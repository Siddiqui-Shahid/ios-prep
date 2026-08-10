# 03 — Production Bridge (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Simple language. Named work only — never S-codes in speech.

---

### Q1. Story map? `(45–60s)`
**Answer:**

> “---.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q2. What you can say (safe)? `(45–60s)`
**Answer:**

> “- Shared async state hit from multiple queues → data races / intermittent crashes - Introduced synchronised dictionaries gated by GCD serial queues - Used read-write locks where access was read-heavy - Standardized access API so call sites couldn’t touch raw storage - Validated under concurrency stress and Crashlytics watch - Eliminated concurrent-access crashes in that shared state path - Pattern reused where mutable maps were shared across async work - Lesson: serialize mutation at the boundary; don’t sprinkle locks ad hoc - Today you’d also evaluate a Swift actor for new code.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q3. What you must **not** invent? `(45–60s)`
**Answer:**

> “- Exact crash counts, percentages fixed by this work alone - “I alone brought the app to 99.95% CFS” (CFS is culture metric — don’t steal it for ) - Claiming every dictionary in the app was converted - Claiming production used your Learning-lab file literally.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q4. Interview lines? `(45–60s)`
**Answer:**

> “≤20s: “We gated shared dictionaries behind a serial queue API so call sites couldn’t race the storage — crashes went away on that path.” Timed opener: “We had races on shared dictionaries — I’ll cover the serial-queue design and trade-offs vs actors.”.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q5. How I would apply it · S2-A1? `(45–60s)`
**Answer:**

> “Say explicitly this is design direction, not a claim you rewrote production: > “Production used GCD. How I’d apply it in a new module is an actor SafeDict with get/set/snapshot — callers await, isolation is in the type system, same boundary idea.”.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q6. Mapping concepts → lines? `(45–60s)`
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

### Q7. Anti-patterns? `(45–60s)`
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

### Q8. Flash map card? `(45–60s)`
**Answer:**

> “Company / feature: BookMyShow — synchronised dictionaries What you did: GCD serial queues / RW locks; safe access API; stress + Crashlytics validation.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q9. Timed drills? `(45–60s)`
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

### Q10. Next? `(45–60s)`
**Answer:**

> “sample/07-revision-qna.md — Answer points first, then Full spoken answer.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---
