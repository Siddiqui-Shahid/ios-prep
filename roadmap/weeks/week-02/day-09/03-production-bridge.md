# 03 — Production Bridge: BMS Ads Networking & Honest Provenance (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Simple language. Named work only — never S-codes in speech.

---

### Q1. Provenance map for today? `(45–60s)`
**Answer:**

> “See the notes for this topic and speak the core idea in simple words.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q2. Forbidden overclaims (do not say as fact)? `(45–60s)`
**Answer:**

> “- “I shipped a pin-rotation runbook / break-glass flag to production.” - “We rolled out with shadow traffic.” (not in Verified ) - “Pinning alone caused / fixed app-wide crash-free rate.” - “ATS is our pinning.” - “We hash SecKeyCopyExternalRepresentation as SPKI.”.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q3. Timed opener (~10s)? `(45–60s)`
**Answer:**

> “I’ll walk through migrating BookMyShow Ads networking from Alamofire to URLSession so we owned transport security on a revenue-critical module.”.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q4. Situation / Task (~20s)? `(45–60s)`
**Answer:**

> “Ads networking sat on Alamofire. For a high-traffic, revenue-adjacent module we needed stronger first-party control over transport security and a smaller dependency surface — specifically HTTPS enforcement, SSL pinning, and domain whitelisting.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q5. Action (~90s)? `(45–60s)`
**Answer:**

> “1. Introduced a first-party networking path on URLSession behind clear call-site boundaries so Ads code didn’t care about Alamofire types. 2. Enforced HTTPS for API traffic on that stack. 3. Added SSL pinning via session trust evaluation so unexpected certificates fail closed for pinned hosts. 4. Added a domain whitelist so the client only talks to approved hosts — reducing misconfig / unexpected host risk. 5. Treated pinning as incomplete without an ops mindset: rotation and failure behavior must be designed (see — design, not a claim I shipped the runbook).”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q6. Result (~20–30s)? `(45–60s)`
**Answer:**

> “Reduced MITM exposure on a sensitive high-traffic Ads module and simplified first-party networking ownership. Dependency surface shrank on that pod path.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q7. Lesson (~15–20s)? `(45–60s)`
**Answer:**

> “Pinning without a rotation / backup / break-glass design is how teams create self-inflicted outages when certs or keys change. Security controls need operational paired thinking.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q8. S4-A1 — Pin ops as design (speak carefully)? `(45–60s)`
**Answer:**

> “When interviewers ask “what happens when the cert rotates?”, answer as design judgment:.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q9. Interview line (≤20s)? `(45–60s)`
**Answer:**

> “I moved Ads off Alamofire onto URLSession so we owned HTTPS, SSL pinning, and a domain whitelist on a high-traffic revenue module — and I’d pair pinning with backup pins and a break-glass design so rotation doesn’t brick the app.”.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q10. Search cancel — S3? `(45–60s)`
**Answer:**

> “Use when asked about cancellation UX: debounce + cancel in-flight search; ignore cancellation errors; prevent out-of-order apply. > Provenance: Verified · · search debounce / MVVM state.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q11. Performance — S5? `(45–60s)`
**Answer:**

> “Use when asked how networking relates to latency culture: instrument journeys; optimize with p50/p90, not averages. > Provenance: Verified · · Firebase Performance p50/p90.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q12. Payments — S7? `(45–60s)`
**Answer:**

> “Use when asked about retries: networking SDK must not blindly retry charge POSTs; checkout needs idempotency / status polling discipline. > Provenance: Verified · · payment processing UX intent (no invented drop-off %).”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q13. Mapping chapter topics → what you built vs what you design? `(45–60s)`
**Answer:**

> “See the notes for this topic and speak the core idea in simple words.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q14. Threat model for Ads (short)? `(45–60s)`
**Answer:**

> “Why Ads deserved first-party controls: - High volume / revenue-adjacent traffic. - Attractive target for injection / MITM on hostile networks. - Third-party creative ecosystems increase “unexpected URL” risk — API whitelist is still valuable even if images load from CDNs under separate rules. - Dependency ownership: fewer moving parts when security reviews ask “who controls the session delegate?”.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q15. Migration narrative beats (whiteboard)? `(45–60s)`
**Answer:**

> “text 1. Protocol boundary at call sites 2. URLSession implementation + parity tests 3. HTTPS only 4. Pinning delegate (SPKI hashes) 5. Host whitelist in builder 6. Design: backup pins + rotation + break-glass 7. Observe TLS failures + Ads health metrics Do not invent a sixth verified bullet like “shadow traffic.” If asked how you’d roll out: answer as judgment — phased release, metrics, canary — labeled as design.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q16. Common interviewer pushes & honest replies? `(45–60s)`
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

### Q17. Practice: 60s vs 3 min versions? `(45–60s)`
**Answer:**

> “60s: problem (Alamofire on Ads) → action (URLSession + HTTPS + pin + whitelist) → result (first-party control / MITM ↓) → lesson (design rotation). 3 min: add parity testing, why whitelist, ATS≠pinning, SPKI one-liner, backup/break-glass as design, cancel/refresh only if asked.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q18. Link back to study artifacts? `(45–60s)`
**Answer:**

> “- Code: code/SingleFlightRefresh.swift - Questions: sample/07-revision-qna.md - Revision twin: ../../../revision/weeks/week-02/day-09.md - Story bank: ../../../stories/story-bank.md#s4--ssl-pinning--alamofire--urlsession-bookmyshow.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---
