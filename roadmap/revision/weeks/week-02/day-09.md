# Day 09 — Networking: URLSession, Interceptors, Token Refresh, Caching, Cancellation

> Week 2 · Phase: Architecture, networking, SDUI, UI · Time budget today: ~4–5 hrs

## 1. Outcome

By end of day you can explain aloud (no notes):

- How to design a **protocol-oriented networking layer** on `URLSession` (endpoints, interceptors, decoding, errors)
- **Token refresh** under concurrency (single-flight refresh, queue/retry, failure fan-out)
- **Cancellation**, retries/backoff, and **caching** responsibilities (HTTP cache vs app cache)
- Why/how you migrated Ads networking **Alamofire → URLSession** with **HTTPS, SSL pinning, domain whitelist** at BMS

## 2. Concept deep dive

### 2.1 Layer shape (interview HLD in 60s)

```text
APIEndpoint (path, method, headers, body, auth requirement)
    → RequestBuilder → URLRequest
        → Interceptors (auth inject, logging, tracing)
            → URLSession data/upload task
                → Response pipeline (status map, decode, domain errors)
                    → TokenRefresher (on 401) → retry once
```

Speak to: generics `request<T: Decodable>(_:) async throws -> T`, mockable `NetworkSession` protocol wrapping `URLSession`, and **no** Alamofire requirement for senior answers — first-party control matters for pinning and Ads.

Primary doc: [networking-layer.md](../../../ios-system-design/docs/networking-layer.md)

### 2.2 Interceptors

| Interceptor | Does | Must not |
|---|---|---|
| Auth | Attach Bearer / custom headers | Block UI thread |
| Logging | Safe metadata (path, status, latency) | Log tokens / PII |
| Tracing | Firebase Performance spans (preview Week 3) | Become business logic |
| Retry | Idempotent GETs with backoff | Blindly retry POSTs (payments!) |

Composition: ordered pipeline; short-circuit on hard failures.

### 2.3 Token refresh (single-flight)

**Problem:** N parallel 401s → N refresh calls → thundering herd / revoked refresh tokens.

**Pattern:**

1. Detect 401 / auth-expired error.
2. First caller starts refresh; others **await the same Task**.
3. On success: update Keychain-backed token store; retry original requests **once**.
4. On failure: fail all waiters; force logout / re-auth path.
5. Actor or serial queue around refresh state.

**Say aloud:** “Refresh is a critical section; retries are bounded; payments use stricter idempotency keys.”

### 2.4 Cancellation & task identity

- Prefer `async` + `Task` cancelled in `onDisappear` / new search query (ties to Day 08).
- `URLSessionTask.cancel()` / structured concurrency cancellation propagation.
- Ignore `CancellationError` in UI (don’t show as hard error).
- Search autocomplete: cancel stale in-flight when query changes.

### 2.5 Caching — split responsibilities

| Layer | Mechanism | Use |
|---|---|---|
| URLCache / HTTP Cache-Control | Transport cache | Static-ish GETs |
| App memory (NSCache) | Hot decoded models | Session UX |
| Disk (files / DB) | Offline / SDUI fallback | Day 10 |
| “No cache” | Auth’d personalized / payments | Correctness |

**Trap:** Caching authenticated personalized responses without keying by user.

### 2.6 Alamofire → URLSession (BMS Ads)

Motivations: dependency surface, first-party pinning hooks, consistent Ads pod networking.

Migration checklist you can recite:

1. Introduce `NetworkClient` protocol matching call sites.
2. Implement URLSession backend; parity tests (status, decode, error mapping).
3. Enforce HTTPS + **SSL pinning** + **domain whitelist**.
4. Document **pin rotation** / break-glass (pinning without ops = outage).
5. Shadow traffic or staged rollout on Ads module; watch Crashlytics + fill metrics.

### 2.7 Trade-offs

| Choice | When | Cost |
|---|---|---|
| URLSession first-party | Security-sensitive modules (Ads) | More boilerplate than Alamofire |
| Alamofire | Rapid CRUD apps, team fluency | Less control; dependency risk |
| Aggressive HTTP cache | Public content | Stale personalized data risk |
| Retry all methods | Never | Duplicate charges / side effects |
| Pinning | High-threat / high-value traffic | Rotation + outage risk if mis-ops |

## 3. Read these

| Priority | Resource | Why |
|---|---|---|
| Must | [URLSession](https://developer.apple.com/documentation/foundation/urlsession) | Baseline API |
| Must | [networking-layer.md](../../../ios-system-design/docs/networking-layer.md) | Full HLD/LLD for interviews |
| Deepen | [mobile-security-privacy-engine.md](../../../ios-system-design/docs/mobile-security-privacy-engine.md) (pinning section) | Pair with S4 |
| Deepen | [authentication-oauth-biometric.md](../../../ios-system-design/docs/authentication-oauth-biometric.md) | Refresh/token storage |
| Repo | [stories/story-bank.md](../../stories/story-bank.md)#s4--ssl-pinning--alamofire--urlsession-bookmyshow | Production hook |

## 4. Map to your work

**Company / feature:** BookMyShow — Ads networking Alamofire → URLSession + SSL pinning + domain whitelist  
**What you did:** Migrated Ads pod networking to URLSession; enforced HTTPS, pinning, whitelist; documented rotation/failure behavior for ops.  
**Interview line (≤20s):** “I moved Ads off Alamofire onto URLSession so we owned pinning and whitelist on a high-traffic revenue module — with an explicit pin-rotation plan.”

→ Full STAR: [stories/story-bank.md](../../stories/story-bank.md)#s4--ssl-pinning--alamofire--urlsession-bookmyshow

**Also link:** Search debounce/cancel (S3); Firebase perf traces on journeys (S5) as observability on the same stack.

## 5. Normal questions

For each: answer out loud within the time. Skeleton only — expand from memory.

### Q1. Why prefer URLSession over Alamofire in a senior design? `(30–45s)`
**Skeleton:** First-party control, fewer deps, direct `URLSessionDelegate` for pinning/challenges, async/await native. Alamofire fine for speed; Ads needed security ownership.  
**Follow-up:** What did you lose? → Convenience adapters; you reimplemented needed pieces.  
**Story:** S4.

### Q2. Sketch a generic request API. `(45–60s)`
**Skeleton:** `protocol APIEndpoint`; `NetworkClient.request<T: Decodable>(_:) async throws -> T`; map HTTP status → domain `NetworkError`; inject session for tests.  
**Follow-up:** Upload/download? → Separate task types; progress callbacks.  
**Story:** Point to networking-layer.md components.

### Q3. How do auth interceptors work? `(45s)`
**Skeleton:** Before send: read token store, attach header. On 401: refresh path. Never log secrets.  
**Follow-up:** Guest vs authed endpoints? → Endpoint flag `requiresAuth`.  
**Story:** S4 stack; general auth design.

### Q4. Explain safe token refresh under concurrency. `(60–90s)`
**Skeleton:** Single-flight Task/actor; waiters share result; retry once; failure → logout all; store tokens in Keychain.  
**Follow-up:** Refresh token reuse detection? → Server revoke → force re-login.  
**Story:** Architecture answer + security discipline from S4.

### Q5. How do you cancel in-flight search requests? `(45s)`
**Skeleton:** New query cancels previous `Task`; treat cancellation as non-error; debounce in VM. Prevents out-of-order apply.  
**Follow-up:** URLSession task vs Task cancellation? → Prefer structured concurrency wrapping session calls.  
**Story:** S3.

### Q6. Retry policy — what do you retry? `(45–60s)`
**Skeleton:** Transient 408/429/5xx on **idempotent** GETs; exponential backoff + jitter; cap attempts. No blind POST retry for payments (use idempotency keys).  
**Follow-up:** 429? → Honor Retry-After when present.  
**Story:** S7 payments caution.

### Q7. HTTP cache vs app cache? `(45s)`
**Skeleton:** URLCache honors headers; app cache for decoded models/offline. Key by user for private data. SDUI layouts often disk+TTL (Day 10).  
**Follow-up:** Cache invalidation? → TTL + pull-to-refresh + version keys.  
**Story:** S3 header CMS freshness.

### Q8. What is SSL pinning and what goes wrong? `(60s)`
**Skeleton:** Pin public key/cert SPKI; reject unexpected server certs → mitigate MITM. Failure mode: expired pin → total outage. Need rotation, backup pins, monitoring.  
**Follow-up:** ATS vs pinning? → ATS baseline; pinning extra.  
**Story:** S4.

### Q9. Domain whitelisting — why? `(30–45s)`
**Skeleton:** Ads/network client only talks to approved hosts; reduces SSRF-ish misconfig and unexpected third-party calls from CMS mistakes.  
**Follow-up:** How enforced? → Central request builder validation before resume.  
**Story:** S4.

### Q10. How do you test networking without flaky CI? `(45–60s)`
**Skeleton:** Protocol-wrap session; return fixture Data; test decode + 401 refresh state machine with fakes; few integration smoke tests.  
**Follow-up:** Recorded traffic? → Optional; keep secrets out of fixtures.  
**Story:** S9 test discipline; S4 migration parity.

### Q11. Error mapping you use in production? `(45s)`
**Skeleton:** Transport (offline/timeout), HTTP (4xx/5xx), decoding, cancelled, auth. UI maps to retryable vs fatal. Don’t show raw JSON errors.  
**Follow-up:** Partial success? → Domain-specific; don’t hide in generic client.  
**Story:** S3 empty/error states.

### Q12. How does networking relate to p50/p90? `(45s)`
**Skeleton:** Trace request spans (Firebase Performance); optimize slow endpoints; client timeouts must align with backend SLOs. Averages lie — watch p90.  
**Follow-up:** Client-only fixes? → Caching, prefetch, cancel waste.  
**Story:** S5.

## 6. Tricky questions

### T1. “N requests get 401 at once — design refresh.” `(120s)`
**Trap:** Refresh per request.  
**Senior answer:** Single-flight refresher; queue/await; one retry; mutex/actor; if refresh 401 → global logout; prevent refresh storm. Draw the sequence.  
**Follow-up:** What if refresh succeeds but original POST isn’t idempotent? → Don’t auto-retry unsafe methods without idempotency key.

### T2. “Should the networking SDK own disk cache?” `(90s)`
**Trap:** Kitchen-sink SDK.  
**Senior answer:** Transport-level cache optional; domain/offline cache usually Repository/SDUI FallbackEngine. Keep SDK focused: build, auth, execute, decode, cancel.  
**Follow-up:** Point to [networking-layer.md](../../../ios-system-design/docs/networking-layer.md) out-of-scope notes.

### T3. “Pinning broke production after cert rotate — your fault?” `(90–120s)`
**Trap:** Blame-only or “pinning bad.”  
**Senior answer:** Pinning without rotation runbook is incomplete design. Backup pins, staged mobile config remote pin set if possible, monitoring of TLS failures, break-glass disable flag carefully scoped. S4 lesson: design ops path.  
**Follow-up:** How detect early? → Canary + TLS failure metrics.

### T4. “Alamofire already supports interceptors — why migrate?” `(90s)`
**Trap:** NIH syndrome.  
**Senior answer:** Ads needed first-party pinning/whitelist control, dependency reduction, consistent pod ownership. Migration cost justified by security + control on revenue module — not ideology.  
**Follow-up:** Would you migrate whole BMS app? → Risk-based; start where threat/value highest.

### T5. “How do you cancel URLSession work with async/await correctly?” `(90s)`
**Trap:** Fire-and-forget Task.  
**Senior answer:** Hold Task handle; cancel on lifecycle; use `withTaskCancellationHandler` / check `Task.isCancelled`; map cancellation to silent UI; ensure session task cancelled too.  
**Follow-up:** Multiple screens sharing one request? → Shared publisher/Task with refcount or repository-level coalescing.

### T6. “Retry + payment checkout.” `(90–120s)`
**Trap:** Generic retry helper on all routes.  
**Senior answer:** Payments: idempotency keys, explicit status polling (S7 popup states), no duplicate charge from client retry. Networking SDK should let endpoints opt into retry policy.  
**Follow-up:** Tie to [payment-checkout.md](../../../ios-system-design/docs/payment-checkout.md) briefly.

### T7. “Man-in-the-middle on public Wi-Fi — what layers help?” `(90s)`
**Trap:** Only “use HTTPS.”  
**Senior answer:** ATS/HTTPS baseline, certificate transparency ecosystem, pinning for high-value, whitelist, no cleartext fallback, careful WebViews. User education ≠ engineering control.  
**Follow-up:** S4 Ads threat model.

### T8. “Where do you put Firebase Performance tracing — interceptor or call site?” `(90s)`
**Trap:** Only one right answer.  
**Senior answer:** Interceptor for baseline latency by path; call sites/journeys for product traces (listing→checkout). Avoid double-counting; PII-safe names.  
**Follow-up:** S5 p50/p90 culture.

## 7. Flashcards for today

| Front | Back |
|---|---|
| Networking SDK core | Endpoint → build → intercept → session → decode · Trap: UI in client · Prod: Ads URLSession |
| Single-flight refresh | One refresh Task; waiters share · Trap: N refreshes · Prod: auth storms |
| Cancel search | Cancel Task on new query · Trap: show cancel as error · Prod: S3 |
| Retry safe? | Idempotent GET + backoff · Trap: POST payments · Prod: S7 |
| URLCache vs app cache | Headers vs domain/offline · Trap: cache private unkeyed · Prod: SDUI Day 10 |
| SSL pinning | SPKI pin; MITM ↓ · Trap: no rotation = outage · Prod: S4 |
| Domain whitelist | Only approved hosts · Trap: CMS open fetch · Prod: S4 |
| Why leave Alamofire | Control + deps + pinning · Trap: hate libraries · Prod: S4 Ads |
| NetworkError kinds | Transport/HTTP/decode/cancel/auth · Trap: raw strings to UI · Prod: S3 states |
| Interceptor order | Auth → log/trace → send · Trap: log tokens · Prod: hygiene |
| Test strategy | Fake session + fixtures · Trap: live network CI · Prod: migration parity |
| Idempotency key | Safe payment retries · Trap: client-only duplicate POST · Prod: checkout |
| p90 networking | Trace spans; optimize tail · Trap: mean latency · Prod: S5 |
| Break-glass pin | Monitored failover plan · Trap: silent disable forever · Prod: S4 lesson |
| Protocol NetworkSession | Inject URLSession mock · Trap: concrete everywhere · Prod: testability |

## 8. Practice

- **Coding / SD:** On a whiteboard, draw token-refresh sequence for 3 parallel 401s. Then list Ads migration steps (protocol → URLSession → pin → whitelist → rotate runbook).
- **Complexity / agenda to say first:** “I’ll scope the client, then auth/refresh, cancellation, cache boundaries, then BMS Alamofire→URLSession + pinning trade-offs.”
- **Deep read:** Skim full [networking-layer.md](../../../ios-system-design/docs/networking-layer.md) HLD + NFRs (30–40 min).

## 9. Timed drill

1. Pick 3 Normal + 2 Tricky (recommended: Q4, Q8, Q5 + T1, T3). Record.
2. Score against [answer-timing-guide.md](../../timing/answer-timing-guide.md).
3. Log misses in gotchas (refresh concurrency + pin rotation).
4. Deliver S4 STAR in **2–3 min**; practice **5 min** networking HLD using the repo doc as checklist (prep for Mock #2 / Mock #3).
