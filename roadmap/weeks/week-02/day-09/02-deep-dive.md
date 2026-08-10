# 02 — Deep Dive: Mechanics, Internals, Failure Modes (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Simple language. Named work only — never S-codes in speech.

---

### Q1. End-to-end data flow? `(45–60s)`
**Answer:**

> “text ┌─────────────┐ endpoint ┌────────────────┐ │ ViewModel │ ────────────► │ NetworkClient │ └─────────────┘ └───────┬────────┘ │ build URLRequest │ validate host whitelist ▼ ┌────────────────┐ │ Interceptors │ auth headers, log, trace └───────┬────────┘ │ ▼ ┌────────────────┐ │ URLSession │ TLS (+ optional pinning delegate) └───────┬────────┘ │ Data + HTTPURLResponse ▼ ┌────────────────┐ │ Status / Decode│ └───────┬────────┘ 401 │ │ 2xx ▼ ▼ ┌──────────────┐ return T │ SingleFlight │ │ Refresh │ └──────┬───────┘ │ success → retry once │ failure → logout / fail waiters.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q2. Responsibilities checklist? `(45–60s)`
**Answer:**

> “See the notes for this topic and speak the core idea in simple words.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q3. Protocol-oriented client (compilable shape)? `(45–60s)`
**Answer:**

> “swift import Foundation enum HTTPMethod: String { case get = "GET" case post = "POST" case put = "PUT" case delete = "DELETE" }.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q4. Interceptor pipeline (explicit)? `(45–60s)`
**Answer:**

> “Some teams keep interceptors as types; others inline auth. Either is fine if you can explain the order. swift protocol RequestInterceptor: Sendable { func prepare(_ request: URLRequest) async throws -> URLRequest }.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q5. Failure mode without single-flight? `(45–60s)`
**Answer:**

> “text t0 Request A, B, C all in flight with expired access token t1 All three receive 401 t2 A starts refresh₁, B starts refresh₂, C starts refresh₃ t3 refresh₁ succeeds; server rotates refresh token t4 refresh₂ / refresh₃ fail → mass logout / thrash.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q6. Desired sequence? `(45–60s)`
**Answer:**

> “text t0 A, B, C get 401 t1 A enters refresher; B and C await the same in-flight work t2 One refresh network call t3 Success → update Keychain-backed store → A/B/C retry originals once t4 Failure → resume all waiters with error → clear tokens → login.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q7. Actor safety — what went wrong in many samples? `(45–60s)`
**Answer:**

> “Broken pattern (do not ship this): swift actor BrokenAuthManager { private var accessToken: String? private var refreshTask: Task<String, Error>?”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q8. Retry policy after refresh? `(45–60s)`
**Answer:**

> “Networking SDK should let endpoints opt into retry. Payments belong with explicit status polling (checkout UX), not a generic “retry all 401s including charge.”.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q9. Async API participation? `(45–60s)`
**Answer:**

> “swift func loadResults(query: String) async throws -> [Hit] { let request = try makeSearchRequest(query) // If this function's Task is cancelled, URLSession cancels the underlying work // and the await fails with cancellation. let (data, response) = try await session.data(for: request) _ = response return try decoder.decode([Hit].self, from: data) } // ViewModel private var searchTask: Task<Void, Never>?”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q10. Callback dataTask — explicit cancel + stale guards? `(45–60s)`
**Answer:**

> “swift final class LegacySearchService { private var task: URLSessionDataTask? private var generation = 0 func search(query: String, completion: @escaping (Result<[Hit], Error>) -> Void) { task?.cancel generation += 1 let myGeneration = generation.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q11. Checklist? `(45–60s)`
**Answer:**

> “See the notes for this topic and speak the core idea in simple words.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q12. Retries and backoff? `(45–60s)`
**Answer:**

> “swift struct RetryPolicy: Sendable { var maxAttempts: Int = 3 var baseDelayNanoseconds: UInt64 = 250_000_000 // 0.25s var retryableStatusCodes: Set<Int> = [408, 429, 500, 502, 503, 504] var retryableMethods: Set<HTTPMethod> = [.get] func delay(forAttempt attempt: Int) -> UInt64 { let exp = baseDelayNanoseconds << attempt let jitter = UInt64.random(in: 0..<(baseDelayNanoseconds / 2)) return exp + jitter } }.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q13. URLSession / URLCache? `(45–60s)`
**Answer:**

> “- Driven by HTTP headers and URLRequest.cachePolicy. - Good default for public content. - Use .reloadIgnoringLocalCacheData for force refresh. - Authenticated responses: prefer Cache-Control: private / no-store from server; client should not invent aggressive caching.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q14. App-level cache? `(45–60s)`
**Answer:**

> “Invalidation levers: TTL, pull-to-refresh, version keys, logout clears user-keyed entries.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q15. Where it hooks? `(45–60s)`
**Answer:**

> “Implement URLSessionDelegate: urlSession(_:didReceive:completionHandler:) for server trust challenges (NSURLAuthenticationMethodServerTrust).”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q16. SPKI correctly? `(45–60s)`
**Answer:**

> “SPKI = Subject Public Key Info structure inside the X.509 certificate, encoded as DER. Pin value = Base64(SHA256(spkiDER)) (common mobile convention; some docs use hex — be consistent with your pin generator).”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q17. ATS vs pinning (again, with ops)? `(45–60s)`
**Answer:**

> “Apple’s posture: pinning is optional and operationally costly. Use when threat model justifies it (high-value traffic, elevated MITM risk). Always design backup pins and rotation — as design, not as a claim you shipped a full ops runbook unless verified.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q18. Domain whitelist? `(45–60s)`
**Answer:**

> “Even with pinning, a CMS typo or malicious config could point the client at unexpected hosts. Central builder validation: swift guard let host = url.host, allowedHosts.contains(host) else { throw NetworkError.hostNotAllowed(url.host ?? "") }.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q19. Alamofire → URLSession migration mechanics? `(45–60s)`
**Answer:**

> “Migration shape (teachable checklist): 1. Introduce NetworkClient / NetworkSession protocols matching call sites. 2. Implement URLSession backend behind the protocol. 3. Parity tests: status mapping, decode, error cases (fixtures / URLProtocol). 4. Enforce HTTPS, SSL pinning, domain whitelist on the Ads path. 5. Design pin rotation / backup / break-glass so pinning isn’t a silent outage generator. 6. Roll out carefully on the Ads module — watch crash + fill / revenue-adjacent metrics you already have access to.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q20. Testing without flaky CI? `(45–60s)`
**Answer:**

> “Assert: single refresh call when N parallel 401s; cancel doesn’t call UI error path; whitelist rejects bad hosts.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q21. Observability? `(45–60s)`
**Answer:**

> “- Interceptor: method, path template, status, duration. - Correlate with backend via X-Request-ID if available. - Prefer p50/p90 over averages. - Client timeouts should be coherent with backend SLOs — a 10s client timeout against a 30s server p99 creates self-inflicted errors.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q22. Failure modes table? `(45–60s)`
**Answer:**

> “See the notes for this topic and speak the core idea in simple words.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q23. Trade-off matrix? `(45–60s)`
**Answer:**

> “See the notes for this topic and speak the core idea in simple words.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q24. Debugging workflow? `(45–60s)`
**Answer:**

> “1. Reproduce with Charles/Proxyman only on builds that disable pinning or use a debug trust path — never weaken prod pinning casually. 2. Log safe metadata: path, status, latency, request id. 3. For refresh bugs: count refresh network calls under parallel 401s (must be 1). 4. For cancel bugs: prove generation guard with slow stubbed responses. 5. For pin failures: confirm pin generator hashes SPKI DER, not raw key export bytes.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q25. Ready-to-speak 90s networking HLD? `(45–60s)`
**Answer:**

> “I’d build a protocol-oriented client on URLSession: endpoints describe calls, a builder produces URLRequests with a host whitelist, interceptors inject auth and safe logging, then we execute with async URLSession APIs. Responses map to typed models or typed errors. On 401, an actor runs single-flight refresh so concurrent callers share one refresh, then we retry once. Cancellation uses Task cancellation with async APIs; callback tasks get explicit cancel and stale guards. Caching splits HTTP cache from app/offline cache. For Ads at BMS we moved off Alamofire to own HTTPS, pinning, and whitelist — and I’d design backup pins and break-glass rather than treating pinning as set-and-forget.”.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q26. Optional citations (not required to study)? `(45–60s)`
**Answer:**

> “- Apple: URLSession, URLSessionDelegate, App Transport Security - Swift: structured concurrency cancellation - OWASP MASVS / MASTG: network security, pinning guidance (threat-model based) Continue to 03-production-bridge.md.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---
