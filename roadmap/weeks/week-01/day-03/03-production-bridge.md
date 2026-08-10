# 03 — Production bridge: reliability culture vs memory triage (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Simple language. Named work only — never S-codes in speech.

---

### Q1. Provenance map for this chapter? `(45–60s)`
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

### Q2. Forbidden phrasing (unless you later add real evidence)? `(45–60s)`
**Answer:**

> “- “At BMS I opened Memory Graph and found the ad retain cycle.” - “We measured X% memory reduction from fixing cycles.” (not in resume) - “Leaks showed our retain cycles.” (technically false anyway).”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q3. Preferred phrasing? `(45–60s)`
**Answer:**

> “At BMS scale we treated crash-free and incident ownership as first-class — Crashlytics + IMOC under 30L+ DAU and a 99.95%+ CFS bar (Verified ). For memory specifically, my triage approach would be Memory Graph for cycles and Allocations for growth — not Leaks for retain cycles (How I would apply it).”.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q4. Verified · S8 — what reliability culture actually means? `(45–60s)`
**Answer:**

> “Provenance: Verified · · BookMyShow · 30L+ DAU · 99.95%+ CFS · Crashlytics · IMOC Resume-backed facts you can own:.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q5. -second interview line (Verified only)? `(45–60s)`
**Answer:**

> “At BookMyShow we held a 99.95%+ crash-free bar at 30L+ DAU — Crashlytics workflows and IMOC ownership for P0/P1. Memory and lifecycle bugs were reliability issues, not ‘just perf.’”.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q6. -second bridge into ARC (Verified + Applied clearly labeled)? `(45–60s)`
**Answer:**

> “Verified: that reliability culture is . Applied: if we saw climbing memory or VCs that never deinited after navigation, I wouldn’t start in Leaks for a suspected retain cycle — I’d use Memory Graph to see who retains the object and Allocations to confirm persistent growth, then fix weak captures / timer invalidation / observer tokens.”.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q7. How I would apply it — triage playbook at BMS-shaped apps? `(45–60s)`
**Answer:**

> “Provenance: How I would apply it · memory triage for retain cycles / abandoned VCs.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q8. Trigger signals? `(45–60s)`
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

### Q9. Step-by-step (say this in interviews)? `(45–60s)`
**Answer:**

> “1. Reproduce on a debug build with the suspect flow (push/pop N times). 2. Expect death: temporary deinit log on the VC / controller under test (lab). 3. Memory Graph: filter type; inspect unexpected remaining instances; walk retain edges. 4. Classify: cycle / singleton cache / still-on-window — not “ARC bug.” 5. Allocations: mark generations before/after navigation; confirm persistent bytes of that type. 6. Leaks: only if Graph suggests unreachable weirdness or CF/unsafe involvement — do not use Leaks as the cycle detector. 7. Fix: weak capture, weak delegate, timer.invalidate, NC token removal, Task cancel. 8. Verify: deinit runs; Graph clear; Allocations flat across generations. 9. Reliability wrap: if it shipped, watch Crashlytics / memory metrics; communicate blast radius like any P1.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q10. Ads / navigation flavor (Applied, not a fake war story)? `(45–60s)`
**Answer:**

> “Ads and media surfaces are classic cycle magnets: completion handlers, players, timers, notification hooks. At revenue-critical modules (Verified exists for ads architecture — separate story), a senior instinct is: escaping work must not strongly own the screen. You may say:.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q11. District / Raw hooks (light touch)? `(45–60s)`
**Answer:**

> “Keep Day 03 centered on + Applied triage. Don’t force every company into a fake memory anecdote.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q12. Mapping tools to production language? `(45–60s)`
**Answer:**

> “Teach PMs/QA the difference only if useful; teach interviewers by using precise words.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q13. STAR sketch (S8) — keep ARC as supporting color? `(45–60s)`
**Answer:**

> “When the behavioral question is incident ownership, lead with STAR (see story bank). Memory enters as one class of reliability defect, not the hero claim unless the interviewer asks about leaks. Situation/Task: 30L+ DAU, 99.95%+ CFS, fast P0/P1. Action: Crashlytics workflows; IMOC coordination; mitigations and comms. Result: Sustained crash-free; reduced downtime in peaks. If asked about memory: pivot to Applied triage playbook above — labeled honestly.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q14. Checklist before you speak in an interview? `(45–60s)`
**Answer:**

> “- [ ] Did I label Verified vs Applied? - [ ] Did I avoid “cycles show in Leaks”? - [ ] Did I mention Timer retain + invalidate? - [ ] Did I mention NC tokens for the block API? - [ ] Did I invent a BMS Memory Graph war story? → rewrite as Applied Next: code/RetainCycleDemo.swift, then sample/07-revision-qna.md.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---
