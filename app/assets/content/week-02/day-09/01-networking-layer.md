# Sample 01 — Networking layer shape (Q&A)

> Guided teaching. Each answer stands alone and ends with **How can I relate to my case** using named work — never S-codes.

---

### Q1. What is a networking layer, in plain words?

**Answer:**

> It is a small SDK-shaped boundary between feature code and the internet. It knows where to call (path, method, query, body), how to authenticate (headers, tokens), sends bytes with `URLSession`, turns responses into typed Swift models or typed errors, and centralizes cross-cutting work like logging, retries, token refresh, and host validation. ViewModels call `client.request(GetProfile())` — they never scatter raw `URLSession.shared.dataTask` calls that duplicate auth bugs and inconsistent error mapping.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why not Alamofire everywhere? | Fine for fast CRUD; security-sensitive modules often want first-party `URLSession` control (BookMyShow SSL pinning + URLSession migration Ads). |
| Who owns UI state? | ViewModel — the client returns models or errors, not loading spinners. |
| Injectable session? | Yes — `NetworkSession` protocol lets tests inject fakes without subclassing everything. |

**How can I relate to my case:**
- **Shipped:** BookMyShow SSL pinning + URLSession migration
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Claiming pin-rotation / break-glass runbook as a shipped production playbook.

---

### Q2. Walk the pipeline from endpoint to decoded model.

**Answer:**

> ViewModel calls `client.request(SomeEndpoint())`. The builder turns the endpoint into a `URLRequest`, validates the host against a whitelist, interceptors attach Bearer auth and safe logging, `URLSession` executes with TLS (and optional pinning delegate), status codes map to `NetworkError`, and `JSONDecoder` produces `T`. On 401 with auth required, a single-flight refresher runs once, then the original request retries **once** with the new token. Decode failures stay typed — contract breaks shouldn’t look like “no internet.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Interceptor order to remember? | Auth → observe (log/trace) → send → map. |
| 4xx other than 401? | Usually client error — don’t blind-retry. |
| 5xx on GET? | Maybe retry with backoff if idempotent policy allows. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q3. What are interceptors and what must they never become?

**Answer:**

> Interceptors are pipe fittings in the request/response pipeline — auth inject, logging, tracing — not product features. Auth attaches Bearer tokens without blocking the main thread or logging secrets. Logging records path, method, status, latency in debug — never tokens, PII, or full bodies in production. They must not encode billing rules or feature branching; hard failures short-circuit the pipeline.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Retry interceptor trap? | Never install “retry everything” — payment POSTs need idempotency discipline (BookMyShow payment processing-status popup). |
| Firebase Performance hook? | Interceptor can baseline path latency; journey spans often stay at call sites (BookMyShow Firebase Performance traces). |
| Auth at execute time? | Re-apply token after refresh so retry picks up new access token. |

**How can I relate to my case:**
- **Shipped:** BookMyShow Firebase Performance traces; BookMyShow payment processing-status popup
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented checkout drop-off % from the status popup alone.

---

### Q4. What typed error model should you standardize?

**Answer:**

> Map transport failures (`URLError` offline, timeout, cancelled), HTTP status (4xx/5xx split or grouped), `unauthorized` after refresh exhaustion, `decoding(Error)`, optional explicit `cancelled`, `hostNotAllowed` from whitelist, and `pinningFailed` from TLS challenges. UI maps each to retryable, fatal, or silent — cancellation is silent; decode is usually a release bug metric, not a user-facing dump of `DecodingError` keys.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Cancel in UI? | Silent — expected when search query changes (BookMyShow backend-driven header & search). |
| Decoder dump in alert? | Never — typed error + internal logging. |
| Whitelist failure? | Fail before send; log config bug. |

**How can I relate to my case:**
- **Shipped:** BookMyShow backend-driven header & search
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q5. What is an APIEndpoint and why use protocols?

**Answer:**

> An endpoint describes one API call: path, method, headers, query, body, whether auth is required, cache policy, and associated `Response: Decodable` type. Protocol-oriented design keeps call sites readable — `client.request(GetProfile())` — and lets the client enforce whitelist, auth, refresh, and decode in one place. Tests stub `NetworkSession` to return fixture data and fake HTTP responses.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Default cache policy? | `.useProtocolCachePolicy` unless endpoint overrides for force refresh. |
| `requiresAuth` false? | Public CMS GETs may skip Bearer — still validate host. |
| Repository vs client? | Repository owns merge/cache policy; client owns transport + decode seam. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q6. How do Alamofire and URLSession compare for senior interviews?

**Answer:**

> Alamofire speeds CRUD and has async support, but adds dependency surface and indirect pinning hooks. First-party `URLSession` is more boilerplate yet gives direct `URLSessionDelegate` ownership for trust challenges, smaller binary surface, and clearer security reviews. At BMS Ads (BookMyShow SSL pinning + URLSession migration), migration motivation was **ownership** of HTTPS enforcement, SSL pinning, and domain whitelist on a revenue-critical module — not library ideology.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| “Libraries are evil”? | Weak answer — say threat/value justified first-party control on Ads. |
| Parity during migration? | Protocol boundary at call sites + fixture tests for status/decode/errors. |
| Shadow traffic claim? | Not in BookMyShow SSL pinning + URLSession migration — phased rollout is design judgment only. |

**How can I relate to my case:**
- **Shipped:** BookMyShow SSL pinning + URLSession migration
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Claiming pin-rotation / break-glass runbook as a shipped production playbook.

---

### Q7. What is the 60-second networking HLD opener?

**Answer:**

> “I’d build a protocol-oriented client on URLSession: endpoints describe calls, a builder produces URLRequests with host whitelist, interceptors inject auth and safe logging, async URLSession executes, responses map to typed models or typed errors. On 401, an actor runs single-flight refresh; concurrent callers share one refresh and retry once. Cancellation uses Task cancellation with async APIs; callback tasks need explicit cancel and stale guards. Caching splits HTTP cache from app/offline cache.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Tokens stored where? | Keychain in production — learning-lab may use actor `TokenStore`. |
| UI sees raw JSON errors? | No — map to user-facing retry/fatal/silent buckets. |
| Next file in sample? | Refresh, cancel, cache deep dive in `02-refresh-and-cancel.md`. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q8. What is your networking debug workflow?

**Answer:**

> (1) Reproduce with Charles/Proxyman **only on builds that disable pinning** or use a debug trust path — never weaken prod pinning casually. (2) Log safe metadata: path template, status, latency, request id — never tokens or PII. (3) For refresh bugs: count refresh network calls under parallel 401s (must be **one**). (4) For cancel bugs: prove the generation guard with slow stubbed responses. (5) For pin failures: confirm the pin generator hashes **SPKI DER**, not raw key export bytes.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why not Proxyman on prod pins? | Pinning blocks MITM proxies by design — use a debug trust path, don’t ship break-glass open. |
| Refresh under fan-out? | Single-flight: N callers → 1 refresh → retry once each. |
| Cancel proof? | Slow stub + generation/token — stale completion must not update UI. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

Next: [02-refresh-and-cancel.md](02-refresh-and-cancel.md)

---

