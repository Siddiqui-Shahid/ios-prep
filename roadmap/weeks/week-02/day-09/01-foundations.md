# 01 — Foundations: What a Networking Layer Actually Is

> Read this before the deep dive. Goal: build a mental model an intern can repeat, then raise it to senior vocabulary.

## 1. Plain-English mental model

Your app almost never “talks to the internet” directly from a button handler. It goes through a **networking layer**: a small SDK-shaped boundary that:

1. Knows **where** to call (path, method, query, body).
2. Knows **how** to authenticate (headers, tokens).
3. Sends bytes with **`URLSession`** (Apple’s HTTP stack).
4. Turns the response into **typed Swift models** or a **typed error**.
5. Handles messy cross-cutting concerns: **retries**, **cancellation**, **logging**, **token refresh**.

Think of it as a post office with rules:

| Post-office piece | Networking piece |
|---|---|
| Address + postage form | `APIEndpoint` / request builder |
| Security screening | Auth interceptor, HTTPS, pinning, host whitelist |
| Delivery truck | `URLSession` task |
| Sorting on arrival | Status validation + `JSONDecoder` |
| “Package cancelled” | Task / `URLSessionTask` cancellation |
| “Many packages, one stamp renewal” | Single-flight token refresh |

If you dump raw `URLSession.shared.dataTask` calls into every ViewModel, you get duplicated auth bugs, inconsistent errors, and no single place to pin or whitelist hosts.

## 2. Glossary (learn these cold)

| Term | Meaning |
|---|---|
| **`URLSession`** | Apple’s networking API. Creates tasks (data/upload/download) against a configuration (timeouts, cache, cellular, TLS). |
| **`URLRequest`** | The outbound message: URL, method, headers, body, cache policy. |
| **`URLSessionTask`** | One in-flight unit of work (`dataTask`, `uploadTask`, …). |
| **`APIEndpoint`** | Your app’s description of one API call (path, method, auth need, response type). |
| **Interceptor** | A pipeline step that mutates request/response (auth inject, logging, tracing) without owning business rules. |
| **Bearer token** | Access token usually sent as `Authorization: Bearer <token>`. |
| **401 Unauthorized** | Server rejected credentials (expired/invalid token is the common app case). |
| **Single-flight refresh** | Many concurrent 401s share **one** refresh call; waiters share the result. |
| **Idempotent** | Repeating the request doesn’t create extra side effects (typical GETs; not typical payment POSTs). |
| **Backoff + jitter** | Retry delays grow (1s, 2s, 4s…) with randomness so clients don’t sync-stampede. |
| **`URLCache` / HTTP cache** | Transport-level cache driven by `Cache-Control` / validators. |
| **App cache** | Your memory/disk store of **decoded** models or offline payloads (often a Repository / Day 10 concern). |
| **ATS (App Transport Security)** | System policy preferring secure HTTPS; blocks cleartext by default. **Not** the same as pinning. |
| **TLS** | Encrypts the connection and authenticates the server via certificates in the trust chain. |
| **SSL / cert pinning** | Extra check: server identity must match pins you embedded (or configured). Mitigates some MITM cases TLS alone doesn’t stop (compromised CA / rogue cert on device trust store). |
| **SPKI** | **Subject Public Key Info** — an ASN.1/DER structure describing the public key. Pinning hashes **this DER**, not “whatever bytes `SecKeyCopyExternalRepresentation` returned.” |
| **Domain whitelist** | Client only allows requests to approved hosts. |
| **Cancellation** | Stop work the UI no longer needs; must not surface as a scary user error. |

## 3. Why interviewers care

A senior networking answer proves you can:

- Draw a **clean boundary** (SDK vs feature vs cache vs UI).
- Reason about **concurrency** (401 storms, actor/critical section).
- Respect **security** (HTTPS baseline, pinning threat model, whitelist).
- Avoid **payment disasters** (blind POST retry).
- Cancel without **races** (stale search results applying out of order).

You do **not** need Alamofire to sound senior. First-party `URLSession` control is often the point — especially for pinning hooks and dependency surface on a revenue module.

## 4. Layer shape (60-second HLD)

```text
Feature / ViewModel
        │
        ▼
NetworkClient.request<T: Decodable>(…) async throws → T
        │
        ├─ APIEndpoint (path, method, headers, body, requiresAuth)
        ├─ RequestBuilder → URLRequest (+ host whitelist check)
        ├─ Interceptors (auth inject → logging/tracing)
        ├─ URLSession (data / upload)
        ├─ Status map → NetworkError
        ├─ JSONDecoder → T
        └─ On 401 → TokenRefresher (single-flight) → retry once
```

Speak this aloud once. Then add: “Session is injectable for tests; tokens live in Keychain; UI never sees raw JSON error strings.”

## 5. Intern path: one happy request

1. ViewModel calls `client.request(GetProfile())`.
2. Builder turns endpoint into `URLRequest` for `https://api.example.com/v1/me`.
3. Auth interceptor reads access token from a token store, sets `Authorization`.
4. `try await session.data(for: request)` runs.
5. Status is 200; decode `Profile` with `JSONDecoder`.
6. Return `Profile` to the ViewModel; UI renders.

Failure branches you must name:

| What happened | Typical mapping |
|---|---|
| Offline / DNS / timeout | Transport error → retryable UI |
| 401 | Refresh path (or logout if refresh fails) |
| 4xx (other) | Client error → usually **don’t** blind-retry |
| 5xx | Server error → maybe retry if idempotent |
| Decode fail | Decoding error → treat as bug / contract break |
| Task cancelled | Silent / ignore in UI |

## 6. Interceptors — what they are (and aren’t)

An interceptor is a **pipe fitting**, not a product feature.

| Interceptor | Does | Must not |
|---|---|---|
| Auth | Attach Bearer / device headers | Block the main thread; log secrets |
| Logging | Path, method, status, latency | Log tokens, PII, full bodies in prod |
| Tracing | Start/stop latency spans | Become business logic |
| Retry | Backoff for safe methods | Blindly retry payment POSTs |

**Composition:** ordered pipeline. Hard failures short-circuit. Keep order memorable: **auth → observe (log/trace) → send → map**.

## 7. Token refresh — intern picture

Access tokens expire. Many screens fire requests at once. If each 401 starts its own refresh:

- Auth server gets a **thundering herd**.
- Some OAuth setups **revoke** older refresh grants → cascading logout.
- Retries fight each other.

**Single-flight** means: first waiter starts refresh; others **await the same result**; on success, retry originals **once**; on failure, **fail everyone** and force re-auth.

Say aloud: “Refresh is a critical section; retries are bounded.”

## 8. Cancellation — two APIs, two stories

### 8.1 Async URLSession (`data(for:)`, `bytes(for:)`, …)

These APIs **participate in Swift `Task` cancellation**. If the surrounding `Task` is cancelled (new search query, `onDisappear`), the await throws `CancellationError` (or fails as cancelled). Prefer this style in modern clients.

### 8.2 Callback `dataTask(with:completionHandler:)`

Cancellation is **not** automatic just because a ViewModel went away. You must:

1. Keep the `URLSessionTask` (or wrap it).
2. Call **`task.cancel()`** when the UI no longer wants the result.
3. Use a **generation / request-id stale guard** so a late completion cannot apply outdated data.

**Trap:** “I used async/await so I’m done thinking about cancel” — true for participation, false if you still have callback tasks, Combine wrappers, or fire-and-forget `Task { }` without a handle.

## 9. Caching — split the brain

| Layer | Mechanism | Good for |
|---|---|---|
| HTTP / `URLCache` | `Cache-Control`, ETag, URLSession cache | Public, static-ish GETs |
| App memory (`NSCache`, dictionaries) | Hot decoded models | Session UX snappiness |
| Disk / DB | Files, SQLite, SDUI fallback | Offline / Day 10 |
| No cache | Authed personalized, payments | Correctness |

**Trap:** caching authenticated personalized JSON **without keying by user** → user B sees user A’s data after account switch.

Networking SDK **may** expose cache policy on the request; **domain offline cache** usually belongs in Repository / feature layers — don’t turn the HTTP client into a kitchen-sink disk database.

## 10. Security ladder (do not collapse these)

```text
1. HTTPS only (no cleartext API traffic)
2. ATS baseline (system policy)
3. Correct certificate validation (default trust evaluation)
4. Optional pinning (extra identity check) for high-threat / high-value traffic
5. Domain whitelist (client only calls approved hosts)
```

**ATS ≠ pinning.** ATS pushes you toward TLS and blocks insecure cleartext. Pinning says “even among TLS servers, only **these** public keys / certs are acceptable for our hosts.”

You can have ATS without pinning (common). Pinning without HTTPS is nonsense. Interviewers love catching people who treat the words as synonyms.

## 11. SPKI in one honest paragraph

When people say “public key pinning,” they usually mean **SPKI pinning**:

1. During TLS, you obtain the server certificate.
2. You extract the certificate’s **Subject Public Key Info** as **DER-encoded bytes** (the SPKI structure).
3. You compute **SHA-256** over those DER bytes (often store as Base64).
4. You compare against your embedded pin set (primary + ideally backups).

**Wrong teaching (common bug in sample code):** hash the raw bytes from `SecKeyCopyExternalRepresentation` and call that “SPKI.” That API exports key material in a key-specific format; it is **not** the SPKI DER blob. Mis-labeling it will fail interoperability with standard pin generators (`openssl dgst` over SPKI) and confuse rotation docs.

**Cert pinning vs SPKI/public-key pinning:**

| Style | Pins | Renewal behavior |
|---|---|---|
| Leaf certificate pinning | Exact cert | Breaks when cert is reissued (even with same key) |
| SPKI / public-key pinning | Hash of SPKI | Survives cert reissue **only if the same key pair is reused** |

Pinning always needs an **ops story** (rotation, backups). That ops story for you is **S4-A1 design**, not a verified shipped runbook — see production bridge.

## 12. Alamofire vs URLSession (foundation take)

| | Alamofire | URLSession first-party |
|---|---|---|
| Speed to CRUD | Excellent | More boilerplate |
| Async/await | Supported | Native |
| Pinning / challenges | Possible via session/delegate wiring | Direct `URLSessionDelegate` ownership |
| Dependency / binary surface | Extra | Smaller |
| Interview signal | Fine if you understand underneath | Often preferred for security-sensitive modules |

At BookMyShow Ads (**Verified · S4**), the migration motivation was **ownership**: HTTPS enforcement, SSL pinning, domain whitelist on a high-traffic revenue module — not “libraries are evil.”

## 13. Error model you should standardize

```swift
enum NetworkError: Error {
    case invalidURL
    case transport(URLError)      // offline, timedOut, cancelled, …
    case httpStatus(Int)          // or split 4xx/5xx
    case unauthorized             // 401 after refresh path exhausted / or before
    case decoding(Error)
    case cancelled                // optional explicit case
    case hostNotAllowed           // whitelist
    case pinningFailed            // TLS challenge rejected
}
```

UI maps: **retryable** vs **fatal** vs **silent** (cancel). Never dump decoder dumps into alerts.

## 14. Decision rules (early)

| Situation | Prefer |
|---|---|
| Security-sensitive / pinning / whitelist | First-party `URLSession` client |
| Rapid internal tooling CRUD | Alamofire acceptable if team owns risks |
| Search-as-you-type | Cancel previous Task; ignore cancel errors |
| Payment POST | Idempotency keys; no generic retry helper |
| Public CMS config GET | HTTP cache OK with validators |
| Authed “my tickets” | Cache only if user-keyed; often no URLCache |
| Pin rotation questions | Speak **design** (S4-A1); don’t invent shipped ops |

## 15. Mini self-check

Answer without scrolling up:

1. Name the pipeline from endpoint to decoded model.
2. What goes wrong if every 401 refreshes independently?
3. ATS vs pinning — one sentence each.
4. What is SPKI hashing, and what must you **not** hash?
5. Async `data(for:)` vs callback `dataTask` — cancellation difference?
6. What exactly is Verified in S4 — three controls?

If any answer is fuzzy, re-read that section once, then continue to `02-deep-dive.md`.
