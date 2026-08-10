# 05 — Exercises (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Simple language. Named work only — never S-codes in speech.

---

### Q1. A1. Pipeline recall? `(45–60s)`
**Answer:**

> “Draw from memory: endpoint → … → decoded model, including the 401 branch. Solution: text APIEndpoint → RequestBuilder (+ whitelist) → Interceptors (auth/log) → URLSession → status/decode → on 401: SingleFlightRefresh → retry once → decode → on refresh fail: fail waiters → logout.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q2. A2. ATS vs pinning (two sentences)? `(45–60s)`
**Answer:**

> “Write two sentences that an intern couldn’t confuse. Solution: ATS is system policy that prefers HTTPS and blocks cleartext by default. Pinning is an additional app-level check that the server’s identity matches embedded pins (typically SPKI hashes) during trust evaluation.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q3. A3. SPKI true/false? `(45–60s)`
**Answer:**

> “Mark each statement T/F and fix the false ones. 1. SPKI pinning hashes the Subject Public Key Info DER. 2. SecKeyCopyExternalRepresentation bytes are the same as SPKI DER. 3. SPKI pins always survive certificate renewal. 4. Domain whitelist replaces the need for HTTPS.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q4. A4. Provenance hygiene? `(45–60s)`
**Answer:**

> “Rewrite this bad interview sentence so it’s honest: > “I shipped Alamofire to URLSession with pinning, whitelist, shadow traffic, and a production break-glass runbook.”.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q5. B1. Read and critique? `(45–60s)`
**Answer:**

> “Open code/SingleFlightRefresh.swift. 1. Explain why the continuation design avoids the racy Task { self.token = … } bug. 2. What goes wrong if you set isRefreshing = false after resuming waiters? 3. Optional: implement a unit-test-shaped async function that starts three concurrent refresh calls and asserts a single leader execution using an OSAllocatedUnfairLock/actor counter inside performRefresh.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q6. B2. Broken refresh — fix it? `(45–60s)`
**Answer:**

> “Fix this (conceptually or in a playground): swift actor Broken { var token: String? var task: Task<String, Error>? func refresh async throws -> String { if let task { return try await task.value } let task = Task { let t = try await network self.token = t // bug return t } self.task = task defer { self.task = nil } return try await task.value } func network async throws -> String { "ok" } }.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q7. B3. Callback cancel + stale guard? `(45–60s)`
**Answer:**

> “Write a minimal class that: - Starts a URLSessionDataTask for search - Cancels previous task on new query - Ignores late completions via a generation Int.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q8. B4. Whitelist gate? `(45–60s)`
**Answer:**

> “Given allowedHosts = ["api.bms.example"], show the guard that throws before session.data. Solution: swift guard let host = url.host, allowedHosts.contains(host) else { throw NetworkError.hostNotAllowed(url.host ?? "") }.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q9. C1. Users see old search results after typing fast? `(45–60s)`
**Answer:**

> “Likely causes: no cancel; callback task without stale guard; applying results without Task.isCancelled check. Fix: cancel previous Task / dataTask; generation guard; ignore cancel errors.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q10. C2. Mass logout at 8am traffic peak? `(45–60s)`
**Answer:**

> “Likely causes: refresh storm on expired access tokens; refresh token rotation invalidating siblings. Fix: single-flight refresh; one retry; verify only one refresh call under load tests.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q11. C3. “Pinning mismatch” after routine cert renew? `(45–60s)`
**Answer:**

> “Likely causes: leaf pin instead of SPKI; SPKI pin but new key; pins generated from wrong bytes (SecKeyCopyExternalRepresentation). Fix: confirm pin pipeline hashes SPKI DER; use backup pins; design rotation.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q12. C4. CI networking tests flake? `(45–60s)`
**Answer:**

> “Likely causes: live network; shared mutable URLProtocol state across parallel tests. Fix: inject NetworkSession fakes; isolate protocol mocks per test. ---.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q13. D1. 60s Ads migration? `(45–60s)`
**Answer:**

> “Record once. Must include: Alamofire → URLSession, HTTPS, pinning, whitelist. Must not invent shadow traffic or shipped runbook.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q14. D2. 90s refresh design? `(45–60s)`
**Answer:**

> “Whiteboard three parallel 401s; say “critical section” and “retry once.”.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q15. D3. 45s cancellation distinction? `(45–60s)`
**Answer:**

> “One breath on async participation vs callback explicit cancel + stale guards.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q16. D4. Full agenda opener? `(45–60s)`
**Answer:**

> “Deliver the README networking HLD opener cold, then expand 3 minutes covering refresh, cache split, , . Opener: “I’ll scope a first-party URLSession client — endpoints, interceptors, decode/errors — then single-flight refresh, cancellation, cache boundaries, and the Ads security controls: HTTPS, pinning, and host whitelist.”.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q17. E. Whiteboard prompts? `(45–60s)`
**Answer:**

> “1. Sequence diagram: three 401s → one refresh → three retries → one failure path to logout. 2. Table: ATS Whitelist — layer and failure mode each. 3. List Ads migration steps (protocol → URLSession → HTTPS → pin → whitelist → design rotation). 4. Mark each step Verified vs . ---.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q18. F. Self-score rubric? `(45–60s)`
**Answer:**

> “Target: ≥ 8/10 before marking Day 09 complete.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q19. G. After exercises? `(45–60s)`
**Answer:**

> “1. Skim revision twin: ../../../revision/weeks/week-02/day-09.md 2. Log gotchas: refresh concurrency, SPKI vs raw key bytes, ATS ≠ pinning, no shadow-traffic claim. 3. Next day builds on persistence / offline — keep cache boundary language ready for Day 10.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---
