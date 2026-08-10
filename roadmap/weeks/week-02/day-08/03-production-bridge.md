# 03 — Production Bridge: District Free Parking & BMS Search (Q&A)

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

> “- “AI wrote our architecture / owned the migration.” - “We Clean Architecture’d the entire District app.” - Invented velocity %, regression %, or billing savings %. - “I never needed to review AI output.” - Claiming header SDUI deep mechanics as today’s only story (header is Day 10; search MVVM is today).”

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

> “I’ll walk through shipping Free Parking at District while migrating MVVM and Clean incrementally — with AI as an accelerator inside boundaries I owned.”.

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

> “We needed to ship Free Parking billing adjustments and move patterns across MVVM and Clean without a regression-heavy rewrite. Velocity mattered; so did design ownership.”

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

> “1. Delivered the Free Parking feature for billing adjustments and handled on-call production fixes when issues surfaced. 2. Migrated architecture incrementally — extracted UseCase-style boundaries where domain rules lived; left simpler UI as MVVM rather than ceremony-everywhere. 3. Used Context Engineering with Cursor/Claude/Copilot: fed existing patterns, layering constraints, and acceptance intent so generations stayed inside an envelope. 4. Used AI to accelerate reviews and XCTest/XCUITest drafts; I still reviewed for boundary violations, races, and naming — tests were a gate, not a substitute for judgment. 5. Relied on structured logging to debug production issues quickly during on-call.”

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

> “Feature shipped; migration progressed with velocity and review discipline — not “AI shipped it.”.”

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

> “AI accelerates once boundaries and protocols are clear. You still own architecture, tests, and regressions. Never say “AI wrote the app.”.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q8. AI tooling — speak carefully (critical)? `(45–60s)`
**Answer:**

> “Script fragment:.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q9. Timed opener (~10s)? `(45–60s)`
**Answer:**

> “On BookMyShow search I used MVVM with debounce, cancellation, and explicit UI states so results stayed race-safe on a high-traffic surface.”.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q10. Situation / Task? `(45–60s)`
**Answer:**

> “Search needed modern UX — typing is bursty; naive request-per-keystroke races and wastes network.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q11. Action? `(45–60s)`
**Answer:**

> “1. ViewModel owned debounce and in-flight cancellation. 2. Explicit states: loading / results / empty / error (not boolean soup). 3. Repository hid networking; View bound state only. 4. (Header SDUI was a parallel track — Day 10.).”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q12. Result? `(45–60s)`
**Answer:**

> “Snappier, race-safer search UX; clearer test surface for state transitions.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q13. Lesson? `(45–60s)`
**Answer:**

> “Presentation policy (debounce) lives with presentation; transport cancels but doesn’t know keystroke timing. > Provenance: Verified · · BookMyShow · search debounce / MVVM state.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q14. Interview line (≤20s)? `(45–60s)`
**Answer:**

> “ primary: > “At District I shipped Free Parking while migrating MVVM↔Clean incrementally — AI accelerated scaffolding inside protocols I owned, with tests and review as the gate.”.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q15. Mapping chapter topics → verified vs learning-lab? `(45–60s)`
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

### Q16. Common interviewer pushes & honest replies? `(45–60s)`
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

### Q17. Adjacent hooks (keep them honest)? `(45–60s)`
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

### Q18. Practice: 60s vs 3 min (S9)? `(45–60s)`
**Answer:**

> “60s: Free Parking ship → incremental MVVM/Clean → AI inside envelope + tests → owned regressions. 3 min: Add extraction order, what AI got wrong once, why not Clean-everywhere, on-call logging, tie search only if asked.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q19. Link back to study artifacts? `(45–60s)`
**Answer:**

> “- Code: code/SearchViewModel.swift, code/FreeParkingUseCase.swift, code/FeatureAssembler.swift - Questions: sample/07-revision-qna.md - Revision twin: ../../../revision/weeks/week-02/day-08.md - Story bank: ../../../stories/story-bank.md#s9--free-parking--cleanmvvm--ai-tooling-district · #s3--backend-driven-header--search-bookmyshow.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---
