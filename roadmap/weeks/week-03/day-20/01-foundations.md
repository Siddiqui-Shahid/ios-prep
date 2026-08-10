# 01 — Foundations: Deeplinks, Push, Release Trains (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Simple language. Named work only — never S-codes in speech.

---

### Q1. North star? `(45–60s)`
**Answer:**

> “One router for every entrypoint; queue links until navigation is ready; automate the train; keep a stop button for CFS/perf. ---.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q2. Deep linking pipeline? `(45–60s)`
**Answer:**

> “text https://domain/path?params (Universal Link if AASA ok) OR myapp://… (custom scheme — hijackable) → Scene / onOpenURL → DeepLinkRouter (parse, validate, match) → AppCoordinator (nav ready?) → Target screen OR queue until warm.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q3. Push pipeline? `(45–60s)`
**Answer:**

> “text Permission (contextual) → register for remote notifications → APNs device token → backend / Airship → Campaign / transactional push → Tap → deep link / category action → SAME router as UL.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q4. CI/CD & release trains? `(45–60s)`
**Answer:**

> “text PR → GitHub Actions (lint, build, unit tests) → merge → archive + sign → TestFlight (internal/external) → phased App Store → monitor CFS / perf → PAUSE if needed BMS proof: automated GitHub Actions for build, lint, TestFlight — cut manual release overhead.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q5. Glossary? `(45–60s)`
**Answer:**

> “---.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q6. Teach-back? `(45–60s)`
**Answer:**

> “1. UL vs scheme 2. One router for UL + push 3. Cold-start queue 4. Actions → TestFlight + pause criteria 5. one-liner Next: 02-deep-dive.md.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---
