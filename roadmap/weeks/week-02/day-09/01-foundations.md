# 01 — Foundations: What a Networking Layer Actually Is (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Simple language. Named work only — never S-codes in speech.

---

### Q1. Plain-English mental model? `(45–60s)`
**Answer:**

> “Your app almost never “talks to the internet” directly from a button handler. It goes through a networking layer: a small SDK-shaped boundary that: 1. Knows where to call (path, method, query, body). 2. Knows how to authenticate (headers, tokens). 3. Sends bytes with URLSession (Apple’s HTTP stack). 4. Turns the response into typed Swift models or a typed error. 5. Handles messy cross-cutting concerns: retries, cancellation, logging, token refresh.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q2. Glossary (learn these cold)? `(45–60s)`
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

### Q3. Why interviewers care? `(45–60s)`
**Answer:**

> “A senior networking answer proves you can: - Draw a clean boundary (SDK vs feature vs cache vs UI). - Reason about concurrency (401 storms, actor/critical section). - Respect security (HTTPS baseline, pinning threat model, whitelist). - Avoid payment disasters (blind POST retry). - Cancel without races (stale search results applying out of order).”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q4. Layer shape (60-second HLD)? `(45–60s)`
**Answer:**

> “text Feature / ViewModel │ ▼ NetworkClient.request<T: Decodable>(…) async throws → T │ ├─ APIEndpoint (path, method, headers, body, requiresAuth) ├─ RequestBuilder → URLRequest (+ host whitelist check) ├─ Interceptors (auth inject → logging/tracing) ├─ URLSession (data / upload) ├─ Status map → NetworkError ├─ JSONDecoder → T └─ On 401 → TokenRefresher (single-flight) → retry once Speak this aloud once. Then add: “Session is injectable for tests; tokens live in Keychain; UI never sees raw JSON error strings.”.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q5. Intern path: one happy request? `(45–60s)`
**Answer:**

> “1. ViewModel calls client.request(GetProfile). 2. Builder turns endpoint into URLRequest for https://api.example.com/v1/me. 3. Auth interceptor reads access token from a token store, sets Authorization. 4. try await session.data(for: request) runs. 5. Status is 200; decode Profile with JSONDecoder. 6. Return Profile to the ViewModel; UI renders. Failure branches you must name:.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q6. Interceptors — what they are (and aren’t)? `(45–60s)`
**Answer:**

> “An interceptor is a pipe fitting, not a product feature.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q7. Token refresh — intern picture? `(45–60s)`
**Answer:**

> “Access tokens expire. Many screens fire requests at once. If each 401 starts its own refresh: - Auth server gets a thundering herd. - Some OAuth setups revoke older refresh grants → cascading logout. - Retries fight each other.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q8. Async URLSession (`data(for:)`, `bytes(for:)`, …)? `(45–60s)`
**Answer:**

> “These APIs participate in Swift Task cancellation. If the surrounding Task is cancelled (new search query, onDisappear), the await throws CancellationError (or fails as cancelled). Prefer this style in modern clients.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q9. Callback `dataTask(with:completionHandler:)`? `(45–60s)`
**Answer:**

> “Cancellation is not automatic just because a ViewModel went away. You must: 1. Keep the URLSessionTask (or wrap it). 2. Call task.cancel when the UI no longer wants the result. 3. Use a generation / request-id stale guard so a late completion cannot apply outdated data.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q10. Caching — split the brain? `(45–60s)`
**Answer:**

> “Trap: caching authenticated personalized JSON without keying by user → user B sees user A’s data after account switch.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q11. Security ladder (do not collapse these)? `(45–60s)`
**Answer:**

> “text 1. HTTPS only (no cleartext API traffic) 2. ATS baseline (system policy) 3. Correct certificate validation (default trust evaluation) 4. Optional pinning (extra identity check) for high-threat / high-value traffic 5. Domain whitelist (client only calls approved hosts) ATS ≠ pinning. ATS pushes you toward TLS and blocks insecure cleartext. Pinning says “even among TLS servers, only these public keys / certs are acceptable for our hosts.”.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q12. SPKI in one honest paragraph? `(45–60s)`
**Answer:**

> “When people say “public key pinning,” they usually mean SPKI pinning: 1. During TLS, you obtain the server certificate. 2. You extract the certificate’s Subject Public Key Info as DER-encoded bytes (the SPKI structure). 3. You compute SHA-256 over those DER bytes (often store as Base64). 4. You compare against your embedded pin set (primary + ideally backups).”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q13. Alamofire vs URLSession (foundation take)? `(45–60s)`
**Answer:**

> “At BookMyShow Ads, the migration motivation was ownership: HTTPS enforcement, SSL pinning, domain whitelist on a high-traffic revenue module — not “libraries are evil.”.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q14. Error model you should standardize? `(45–60s)`
**Answer:**

> “swift enum NetworkError: Error { case invalidURL case transport(URLError) // offline, timedOut, cancelled, … case httpStatus(Int) // or split 4xx/5xx case unauthorized // 401 after refresh path exhausted / or before case decoding(Error) case cancelled // optional explicit case case hostNotAllowed // whitelist case pinningFailed // TLS challenge rejected } UI maps: retryable vs fatal vs silent (cancel). Never dump decoder dumps into alerts.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q15. Decision rules (early)? `(45–60s)`
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

### Q16. Mini self-check? `(45–60s)`
**Answer:**

> “Answer without scrolling up: 1. Name the pipeline from endpoint to decoded model. 2. What goes wrong if every 401 refreshes independently? 3. ATS vs pinning — one sentence each. 4. What is SPKI hashing, and what must you not hash? 5. Async data(for:) vs callback dataTask — cancellation difference? 6. What exactly is Verified in — three controls?”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---
