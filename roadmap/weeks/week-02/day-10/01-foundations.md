# 01 — Foundations: What SDUI Actually Is (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Simple language. Named work only — never S-codes in speech.

---

### Q1. Plain-English mental model? `(45–60s)`
**Answer:**

> “Server-driven UI (SDUI) means the backend (or CMS) sends a structured description of what to show — types, props, children, actions — and the app maps those types to native SwiftUI/UIKit components. It is not:.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q2. Glossary? `(45–60s)`
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

> “SDUI answers prove you can: - Ship content velocity without sacrificing crash-free - Design compatibility as a product feature - Secure actions (no arbitrary code) - Reason about cold start and cache freshness - Stay honest about Verified vs Applied ( vs ).”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q4. Wins and costs? `(45–60s)`
**Answer:**

> “Wins: experiment without App Store; personalize surfaces; share contracts across iOS/Android; marketers/CMS iterate layout/content. Costs: schema discipline; capability matrix; QA of combinations; offline/fallback; action security; new component types still need an app release.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q5. Intern path: happy header render? `(45–60s)`
**Answer:**

> “1. App launches; ViewModel asks repository for header payload. 2. Repository returns network JSON or cached last-known-good. 3. Version gate checks schemaVersion against client max-supported. 4. Parser builds a tree of nodes. 5. Registry maps logo, promoBanner, searchEntry → native views. 6. Unknown type: "sparkle_v9" → skip + log; siblings still render. 7. User taps CTA → allowlisted open_deeplink action → router.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q6. Intern path: sad paths you must name? `(45–60s)`
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

### Q7. Schema versioning — 60s picture? `(45–60s)`
**Answer:**

> “Interview line: “Compatibility is a product feature. Unknown nodes fail soft; known nodes validate strictly.”.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q8. Actions & security (intern)? `(45–60s)`
**Answer:**

> “Server may send action: { type, payload }. Client allowlists types. Never execute scripts. Validate URLs against domain policy (Day 09 whitelist mindset). Auth-sensitive actions re-check client-side.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q9. BMS header · S3? `(45–60s)`
**Answer:**

> “Generalised, protocol-driven main header from CMS/backend so many layout/content changes ship without an app release. Paired historically with MVVM search (Day 08).”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q10. Aces splash · S12? `(45–60s)`
**Answer:**

> “Server-driven splash improved cold-start flexibility/freshness alongside audio streaming work. Startup is a product surface — cache + timeout to default; don’t block forever on network. No invented ms on resume.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q11. SDUI vs WebView vs native Ads? `(45–60s)`
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

### Q12. Self-check? `(45–60s)`
**Answer:**

> “Ready for deep dive when you can say: 1. SDUI ≠ JS eval ≠ whole-app WebView 2. Unknown component policy 3. Why empty root needs hard fallback 4. verified vs design 5. Splash: cache + timeout default.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q13. Flash preview? `(45–60s)`
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

### Q14. Additive (safe for old clients)? `(45–60s)`
**Answer:**

> “Old client knows promoBanner. New payload adds optional props.subtitle. Old client ignores unknown field; banner still shows title.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q15. New type (needs app release + fail-soft)? `(45–60s)`
**Answer:**

> “Server sends type: "countdownTimer". Old clients skip + metric. New clients register the type after App Store ships. CMS enables countdown only for builds advertising capability.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q16. Breaking (dual-publish)? `(45–60s)`
**Answer:**

> “children array renamed to nodes without major bump → parsers break. Correct approach: schemaVersion: 4 with dual-publish of v3 and v4 until old clients fall below threshold — or keep additive shape.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q17. Header component inventory (BMS-style thinking)? `(45–60s)`
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

### Q18. Splash inventory (Aces-style thinking)? `(45–60s)`
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

### Q19. Metric dictionary (speak these names)? `(45–60s)`
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

### Q20. 90-second teaching script (record once)? `(45–60s)`
**Answer:**

> “SDUI maps a versioned schema to native components through a registry. Unknown types skip with metrics; incompatible majors fall back. Actions are allowlisted. Cached last-known-good protects offline and bad payloads. On BMS I worked a backend-driven header; on Aces a server-driven splash. Schema versioning and unknown fallbacks I’d insist on as design so CMS velocity doesn’t become crash velocity.”.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---
