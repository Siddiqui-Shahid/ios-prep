# 02 — Deep Dive: Mechanics, Internals, Failure Modes

> Senior depth. Still self-contained — you should not need to leave Cursor to understand these mechanics.

## 1. End-to-end data flow

```text
┌─────────────┐   endpoint    ┌────────────────┐
│  ViewModel  │ ────────────► │ NetworkClient  │
└─────────────┘               └───────┬────────┘
                                      │ build URLRequest
                                      │ validate host whitelist
                                      ▼
                              ┌────────────────┐
                              │ Interceptors   │  auth headers, log, trace
                              └───────┬────────┘
                                      │
                                      ▼
                              ┌────────────────┐
                              │  URLSession    │  TLS (+ optional pinning delegate)
                              └───────┬────────┘
                                      │ Data + HTTPURLResponse
                                      ▼
                              ┌────────────────┐
                              │ Status / Decode│
                              └───────┬────────┘
                         401 │        │ 2xx
                             ▼        ▼
                    ┌──────────────┐  return T
                    │ SingleFlight │
                    │   Refresh    │
                    └──────┬───────┘
                           │ success → retry once
                           │ failure → logout / fail waiters
```

### Responsibilities checklist

| Piece | Owns | Does not own |
|---|---|---|
| `APIEndpoint` | Contract for one call | UI state |
| `RequestBuilder` | URL, method, body, whitelist gate | Token refresh |
| Interceptors | Cross-cutting mutate/observe | Feature branching |
| `URLSession` | Transport, TLS, connection pool | Domain offline DB |
| `TokenRefresher` | Single-flight refresh critical section | Payment idempotency keys |
| Repository | App cache / merge policy | Raw socket config |

## 2. Protocol-oriented client (compilable shape)

```swift
import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

protocol APIEndpoint {
    associatedtype Response: Decodable
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get }
    var queryItems: [URLQueryItem] { get }
    var body: Data? { get }
    var requiresAuth: Bool { get }
    var cachePolicy: URLRequest.CachePolicy { get }
}

extension APIEndpoint {
    var headers: [String: String] { [:] }
    var queryItems: [URLQueryItem] { [] }
    var body: Data? { nil }
    var requiresAuth: Bool { true }
    var cachePolicy: URLRequest.CachePolicy { .useProtocolCachePolicy }
}

protocol NetworkSession: Sendable {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: NetworkSession {}

enum NetworkError: Error {
    case invalidURL
    case hostNotAllowed(String)
    case httpStatus(Int)
    case unauthorized
    case decoding(Error)
    case transport(Error)
}

struct APIConfig: Sendable {
    var baseURL: URL
    var allowedHosts: Set<String>
}

final class NetworkClient: Sendable {
    private let session: any NetworkSession
    private let config: APIConfig
    private let tokens: TokenStore
    private let refresher: SingleFlightRefresh

    init(
        session: any NetworkSession,
        config: APIConfig,
        tokens: TokenStore,
        refresher: SingleFlightRefresh
    ) {
        self.session = session
        self.config = config
        self.tokens = tokens
        self.refresher = refresher
    }

    func request<E: APIEndpoint>(_ endpoint: E) async throws -> E.Response {
        let built = try makeURLRequest(endpoint)
        return try await execute(endpoint, request: built, didRefresh: false)
    }

    private func execute<E: APIEndpoint>(
        _ endpoint: E,
        request: URLRequest,
        didRefresh: Bool
    ) async throws -> E.Response {
        var req = request
        if endpoint.requiresAuth, let token = await tokens.accessToken() {
            req.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        let data: Data
        let response: URLResponse
        do {
            (data, response) = try await session.data(for: req)
        } catch {
            throw mapTransport(error)
        }

        guard let http = response as? HTTPURLResponse else {
            throw NetworkError.transport(URLError(.badServerResponse))
        }

        if http.statusCode == 401, endpoint.requiresAuth, !didRefresh {
            try await refresher.refresh { [tokens] in
                try await tokens.performRefresh()
            }
            return try await execute(endpoint, request: request, didRefresh: true)
        }

        guard (200..<300).contains(http.statusCode) else {
            if http.statusCode == 401 { throw NetworkError.unauthorized }
            throw NetworkError.httpStatus(http.statusCode)
        }

        do {
            return try JSONDecoder().decode(E.Response.self, from: data)
        } catch {
            throw NetworkError.decoding(error)
        }
    }

    private func makeURLRequest<E: APIEndpoint>(_ endpoint: E) throws -> URLRequest {
        guard var components = URLComponents(
            url: config.baseURL.appendingPathComponent(endpoint.path),
            resolvingAgainstBaseURL: false
        ) else { throw NetworkError.invalidURL }

        components.queryItems = endpoint.queryItems.isEmpty ? nil : endpoint.queryItems
        guard let url = components.url else { throw NetworkError.invalidURL }

        guard let host = url.host, config.allowedHosts.contains(host) else {
            throw NetworkError.hostNotAllowed(url.host ?? "<nil>")
        }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.httpBody = endpoint.body
        request.cachePolicy = endpoint.cachePolicy
        endpoint.headers.forEach { request.setValue($1, forHTTPHeaderField: $0) }
        return request
    }

    private func mapTransport(_ error: Error) -> NetworkError {
        if error is CancellationError { return NetworkError.transport(error) }
        return NetworkError.transport(error)
    }
}

/// Minimal token store seam — Keychain in production.
actor TokenStore {
    private var access: String?
    private var refresh: String?

    func accessToken() -> String? { access }

    func install(access: String, refresh: String) {
        self.access = access
        self.refresh = refresh
    }

    func performRefresh() async throws -> String {
        // Learning-lab: pretend network refresh; production hits /oauth/token.
        guard refresh != nil else { throw NetworkError.unauthorized }
        let newAccess = "access-\(UUID().uuidString)"
        access = newAccess
        return newAccess
    }

    func clear() {
        access = nil
        refresh = nil
    }
}
```

**Line-by-line intent:**

- `NetworkSession` lets tests inject fakes without subclassing everything.
- Whitelist runs **before** the session sees the request.
- Auth header is applied at execute time so a post-refresh retry picks up the new token.
- `didRefresh` ensures **one** automatic retry, not an infinite 401 loop.
- Decoding failures stay typed — contract bugs shouldn’t look like “no internet.”

## 3. Interceptor pipeline (explicit)

Some teams keep interceptors as types; others inline auth. Either is fine if you can explain the order.

```swift
protocol RequestInterceptor: Sendable {
    func prepare(_ request: URLRequest) async throws -> URLRequest
}

protocol ResponseInterceptor: Sendable {
    func deliver(data: Data, response: HTTPURLResponse) async throws
}

struct AuthInterceptor: RequestInterceptor {
    let tokens: TokenStore
    let requiresAuth: Bool

    func prepare(_ request: URLRequest) async throws -> URLRequest {
        guard requiresAuth else { return request }
        var copy = request
        if let token = await tokens.accessToken() {
            copy.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        return copy
    }
}

struct LoggingInterceptor: ResponseInterceptor {
    func deliver(data: Data, response: HTTPURLResponse) async throws {
        // Debug only: method/path/status/latency — never tokens or PII bodies in prod logs.
        _ = (data, response)
    }
}
```

**Firebase Performance (preview):** baseline path latency can live in an interceptor; product journeys (listing → checkout) often stay at call sites. Avoid double-counting. (**Verified · S5** for p50/p90 culture; placement is judgment — **S5-A1** if you discuss journey vs interceptor spans.)

## 4. Single-flight token refresh (the concurrency exam)

### 4.1 Failure mode without single-flight

```text
t0  Request A, B, C all in flight with expired access token
t1  All three receive 401
t2  A starts refresh₁, B starts refresh₂, C starts refresh₃
t3  refresh₁ succeeds; server rotates refresh token
t4  refresh₂ / refresh₃ fail → mass logout / thrash
```

### 4.2 Desired sequence

```text
t0  A, B, C get 401
t1  A enters refresher; B and C await the same in-flight work
t2  One refresh network call
t3  Success → update Keychain-backed store → A/B/C retry originals once
t4  Failure → resume all waiters with error → clear tokens → login
```

### 4.3 Actor safety — what went wrong in many samples

Broken pattern (do **not** ship this):

```swift
actor BrokenAuthManager {
    private var accessToken: String?
    private var refreshTask: Task<String, Error>?

    func refreshToken() async throws -> String {
        if let refreshTask { return try await refreshTask.value }

        let task = Task { () -> String in
            let newToken = try await executeRefreshAPI()
            // ❌ Unstructured Task is NOT actor-isolated.
            // Mutating accessToken here races the actor's isolation model.
            self.accessToken = newToken
            return newToken
        }
        refreshTask = task
        defer { refreshTask = nil }
        return try await task.value
    }

    private func executeRefreshAPI() async throws -> String { "x" }
}
```

**Correct rules:**

1. Actor state mutations happen **on the actor** (in actor methods), not inside a detached/unstructured `Task` body that captures `self`.
2. Prefer **continuations** or: run network work in a `Task`, then assign tokens **after** `await task.value` back on the actor.
3. Fan out success/failure to all waiters; clear in-flight state carefully around reentrancy.

See [code/SingleFlightRefresh.swift](code/SingleFlightRefresh.swift) for a continuation-based implementation that follows these rules.

### 4.4 Retry policy after refresh

| Method | Auto-retry after refresh? |
|---|---|
| GET / HEAD (idempotent reads) | Usually yes, once |
| PUT with idempotent semantics | Maybe, if your API contract says so |
| POST create / payment charge | **Only** with server **idempotency key**; otherwise don’t blind-retry |

Networking SDK should let endpoints **opt into** retry. Payments belong with explicit status polling (checkout UX), not a generic “retry all 401s including charge.”

## 5. Cancellation internals

### 5.1 Async API participation

```swift
func loadResults(query: String) async throws -> [Hit] {
    let request = try makeSearchRequest(query)
    // If this function's Task is cancelled, URLSession cancels the underlying work
    // and the await fails with cancellation.
    let (data, response) = try await session.data(for: request)
    _ = response
    return try decoder.decode([Hit].self, from: data)
}

// ViewModel
private var searchTask: Task<Void, Never>?

func onQueryChange(_ q: String) {
    searchTask?.cancel()
    searchTask = Task { [weak self] in
        do {
            let hits = try await self?.loadResults(query: q)
            guard !Task.isCancelled else { return }
            self?.apply(hits ?? [])
        } catch is CancellationError {
            // Silent — expected when typing fast.
        } catch {
            self?.show(error)
        }
    }
}
```

**Ties to search UX (Verified · S3):** debounce in the VM; cancel stale in-flight; never show cancel as a red banner.

### 5.2 Callback dataTask — explicit cancel + stale guards

```swift
final class LegacySearchService {
    private var task: URLSessionDataTask?
    private var generation = 0

    func search(query: String, completion: @escaping (Result<[Hit], Error>) -> Void) {
        task?.cancel()
        generation += 1
        let myGeneration = generation

        let request = makeSearchRequest(query)
        let newTask = session.dataTask(with: request) { data, response, error in
            // Stale guard: a newer search started after we were cancelled/replaced.
            guard myGeneration == self.generation else { return }

            if let error = error as? URLError, error.code == .cancelled {
                return // not a user-facing failure
            }
            // … map data/response …
            _ = (data, response, completion)
        }
        task = newTask
        newTask.resume()
    }

    func cancel() {
        task?.cancel()
        task = nil
        generation += 1
    }
}
```

Without the generation check, a slow response can overwrite newer results (**out-of-order apply**).

### 5.3 Checklist

| API style | Auto with Task.cancel? | You must also |
|---|---|---|
| `session.data(for:)` etc. | Yes — participates | Hold Task handle; ignore `CancellationError` in UI |
| `dataTask` completion | No | `task.cancel()` + stale/generation guard |
| Fire-and-forget `Task { }` | Only if you cancel that Task | Don’t orphan work on disappear |

## 6. Retries and backoff

```swift
struct RetryPolicy: Sendable {
    var maxAttempts: Int = 3
    var baseDelayNanoseconds: UInt64 = 250_000_000 // 0.25s
    var retryableStatusCodes: Set<Int> = [408, 429, 500, 502, 503, 504]
    var retryableMethods: Set<HTTPMethod> = [.get]

    func delay(forAttempt attempt: Int) -> UInt64 {
        let exp = baseDelayNanoseconds << attempt
        let jitter = UInt64.random(in: 0..<(baseDelayNanoseconds / 2))
        return exp + jitter
    }
}
```

Rules to say aloud:

- Retry **transient** failures on **idempotent** methods.
- Honor `Retry-After` on 429 when present.
- Cap attempts; log the final failure with path + status (no secrets).
- Never install “retry everything” as a global interceptor.

## 7. Caching responsibilities

### 7.1 URLSession / URLCache

- Driven by HTTP headers and `URLRequest.cachePolicy`.
- Good default for public content.
- Use `.reloadIgnoringLocalCacheData` for force refresh.
- Authenticated responses: prefer `Cache-Control: private` / no-store from server; client should not invent aggressive caching.

### 7.2 App-level cache

| Store | Use |
|---|---|
| Memory | Hot screens, decoded models |
| Disk | Offline / SDUI fallback (Day 10) |
| None | Payments, highly personalized live data |

**Invalidation levers:** TTL, pull-to-refresh, version keys, logout clears user-keyed entries.

**SDK boundary:** optional transport cache configuration in the client; offline domain cache in repositories — keeps the networking layer focused.

## 8. SSL pinning mechanics (basics)

### 8.1 Where it hooks

Implement `URLSessionDelegate`:

`urlSession(_:didReceive:completionHandler:)` for server trust challenges (`NSURLAuthenticationMethodServerTrust`).

Flow:

1. System presents server trust.
2. You evaluate / inspect certificates in the trust chain (often the leaf).
3. Compute pin(s); compare to allow-list.
4. `completionHandler(.useCredential, credential)` or `.cancelAuthenticationChallenge`.

### 8.2 SPKI correctly

**SPKI** = Subject Public Key Info structure inside the X.509 certificate, encoded as **DER**.

Pin value = `Base64(SHA256(spkiDER))` (common mobile convention; some docs use hex — be consistent with your pin generator).

```text
Certificate (X.509)
 └─ TBSCertificate
     └─ subjectPublicKeyInfo   ← hash THESE DER bytes (SPKI)
         ├─ algorithm
         └─ subjectPublicKey
```

**Not SPKI:** raw output of `SecKeyCopyExternalRepresentation` (key bytes in a format that depends on key type). Hashing that and calling it “SPKI pinning” is a common sample-code defect.

### 8.3 ATS vs pinning (again, with ops)

| | ATS | Pinning |
|---|---|---|
| Layer | System / Info.plist policy | App delegate / trust evaluation |
| Goal | Prefer HTTPS; block cleartext | Extra identity constraint |
| Breaks when | Misconfigured exceptions | Pins outdated after key/cert change |
| Default | On for apps | Off unless you add it |

Apple’s posture: pinning is **optional** and operationally costly. Use when threat model justifies it (high-value traffic, elevated MITM risk). Always design **backup pins** and rotation — as **design** (**S4-A1**), not as a claim you shipped a full ops runbook unless verified.

### 8.4 Domain whitelist

Even with pinning, a CMS typo or malicious config could point the client at unexpected hosts. Central builder validation:

```swift
guard let host = url.host, allowedHosts.contains(host) else {
    throw NetworkError.hostNotAllowed(url.host ?? "")
}
```

Ads modules especially benefit: third-party creative URLs are a separate concern from **API** hosts — don’t conflate “load an image from CDN” with “POST credentials to random host.”

## 9. Alamofire → URLSession migration mechanics

Migration shape (teachable checklist):

1. Introduce `NetworkClient` / `NetworkSession` protocols matching call sites.
2. Implement URLSession backend behind the protocol.
3. Parity tests: status mapping, decode, error cases (fixtures / `URLProtocol`).
4. Enforce **HTTPS**, **SSL pinning**, **domain whitelist** on the Ads path.
5. Design pin rotation / backup / break-glass (**S4-A1**) so pinning isn’t a silent outage generator.
6. Roll out carefully on the Ads module — watch crash + fill / revenue-adjacent metrics you already have access to.

**Do not claim** “we shipped shadow traffic” unless verified. Staged rollout language is fine as **engineering judgment**; shadow traffic is not in the Verified S4 resume bullet.

## 10. Testing without flaky CI

| Technique | Use |
|---|---|
| Protocol-wrap `NetworkSession` | Return fixture `Data` + `HTTPURLResponse` |
| `URLProtocol` subclass | Integration-ish tests through real `URLSession` config |
| Fake `TokenStore` / refresher | Drive 401 → refresh → retry state machine |
| Few smoke hits to staging | Optional; keep secrets out of fixtures |

Assert: single refresh call when N parallel 401s; cancel doesn’t call UI error path; whitelist rejects bad hosts.

## 11. Observability

- Interceptor: method, path template, status, duration.
- Correlate with backend via `X-Request-ID` if available.
- Prefer **p50/p90** over averages (**S5**).
- Client timeouts should be coherent with backend SLOs — a 10s client timeout against a 30s server p99 creates self-inflicted errors.

## 12. Failure modes table

| Failure | Detection | Response |
|---|---|---|
| Offline | `URLError.notConnectedToInternet` | UI offline; don’t spin forever |
| Timeout | `URLError.timedOut` | Retry if idempotent policy allows |
| 401 storm | Many unauthorized | Single-flight refresh |
| Refresh 401/invalid_grant | Refresh endpoint fails | Clear tokens; force login |
| Pin mismatch | Challenge cancelled / custom error | Fail closed; security metric |
| Stale pin after rotate | Mass TLS failures | Backup pin / break-glass **design** |
| Decode break | `DecodingError` | Treat as release bug; don’t infinite retry |
| Cancel | `CancellationError` / `.cancelled` | Silent |
| Host not allowed | Whitelist | Fail before send; log config bug |

## 13. Trade-off matrix

| Choice | When | Cost |
|---|---|---|
| URLSession first-party | Security-sensitive modules (Ads) | More boilerplate |
| Alamofire | Fast CRUD, team fluency | Dependency + less direct control |
| Aggressive HTTP cache | Public content | Stale / wrong-user risk if misused |
| Retry all methods | Never | Duplicate charges / side effects |
| Pinning | High-threat / high-value | Rotation + outage risk if mis-ops |
| Continuations single-flight | Clear actor isolation | Slightly more code than naïve Task |
| Kitchen-sink network SDK | Avoid | Disk cache + image + GraphQL sprawl |

## 14. Debugging workflow

1. Reproduce with Charles/Proxyman **only on builds that disable pinning** or use a debug trust path — never weaken prod pinning casually.
2. Log safe metadata: path, status, latency, request id.
3. For refresh bugs: count refresh network calls under parallel 401s (must be 1).
4. For cancel bugs: prove generation guard with slow stubbed responses.
5. For pin failures: confirm pin generator hashes **SPKI DER**, not raw key export bytes.

## 15. Ready-to-speak 90s networking HLD

> “I’d build a protocol-oriented client on URLSession: endpoints describe calls, a builder produces URLRequests with a host whitelist, interceptors inject auth and safe logging, then we execute with async URLSession APIs. Responses map to typed models or typed errors. On 401, an actor runs single-flight refresh so concurrent callers share one refresh, then we retry once. Cancellation uses Task cancellation with async APIs; callback tasks get explicit cancel and stale guards. Caching splits HTTP cache from app/offline cache. For Ads at BMS we moved off Alamofire to own HTTPS, pinning, and whitelist — and I’d design backup pins and break-glass rather than treating pinning as set-and-forget.”

## 16. Optional citations (not required to study)

- Apple: `URLSession`, `URLSessionDelegate`, App Transport Security
- Swift: structured concurrency cancellation
- OWASP MASVS / MASTG: network security, pinning guidance (threat-model based)

Continue to [03-production-bridge.md](03-production-bridge.md).
