# Sample 01 — Week 2 synthesis (Q&A)

> Guided teaching. Each answer stands alone; **Points to** shows where the full module expands the idea.

---

### Q1. What is the Week 2 narrative in one flow?

**Points to:** [Foundations · §1 Week 2 map](../01-foundations.md#1-week-2-map-say-as-one-narrative)

**Answer:**

> Day 08: layers / DI / search VM → Day 09: URLSession / refresh / pin / cancel → Day 10: SDUI schema / registry / fallback → Day 11: lifecycle / cells / hybrid / bottom sheet → Day 12: SwiftUI state / identity / Stories SDK → Day 13: stack · queue · LL composure. One senior sentence: clear layers and DI, own networking with cancellation and security, SDUI where content velocity matters with fail-soft schema, UIKit/SwiftUI lifecycle and identity as production contracts.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| BMS / District / Raw? | Tie honestly — Verified stories per day, no merged fake project. |
| Week 1 still relevant? | POP, ARC, async — Mock #2 assumes Week 1+2 together. |
| Revision twin? | [revision/weeks/week-02/day-14.md](../../../../revision/weeks/week-02/day-14.md) |

---

### Q2. What is the Week 2 one-liner to memorize?

**Points to:** [Foundations · §1 One-sentence senior narrative](../01-foundations.md#1-week-2-map-say-as-one-narrative)

**Answer:**

> “I structure features with clear layers and DI, own networking with cancellation and security, use SDUI where content velocity matters with fail-soft schema, and treat UIKit/SwiftUI lifecycle and identity as production contracts — proven on BMS, District, and Raw apps.” Adjust provenance per story — don’t claim every bullet on every employer.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Overclaim risk? | One-liner is synthesis — STAR still per Verified ID. |
| District piece? | S9 Clean/MVVM + AI judgment — supporting spice. |
| Raw piece? | S10 Stories, S13 Grizzlies hybrid. |

---

### Q3. What is single-flight refresh in 30 seconds?

**Points to:** [Deep dive · §5 Single-flight refresh](../02-deep-dive.md#5-week-2-connective-micro-answers-embedded) · [Day 09 foundations](../../day-09/01-foundations.md)

**Answer:**

> N concurrent 401s shouldn’t each start refresh. **One refresh Task**; other callers become **waiters** that await the same result. Retry once on success path; on failure → logout fan-out. FIFO queue of continuations mental model (Day 13 soft bridge). Verified: S4 URLSession ownership on Ads — not invented stampede metrics.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| vs debounce? | Debounce delays intent; single-flight dedupes concurrent same work. |
| Pin outage same week? | IMOC leadership + backup pins design (S4-A1 Applied). |
| Mock tricky pool? | Refresh stampede + pin outage — Block 2. |

---

### Q4. What is unknown SDUI handling in 20 seconds?

**Points to:** [Deep dive · §5 Unknown SDUI](../02-deep-dive.md#5-week-2-connective-micro-answers-embedded) · [Day 10 foundations](../../day-10/01-foundations.md)

**Answer:**

> Unknown component type → **skip + metric**; never crash the shell. Schema version gate on fetch. Empty root after parse → **hard fallback** header/splash. Last-known-good cache when network fails. Allowlisted actions only — no arbitrary URL schemes from CMS. S3-A1 emphasizes versioning + fallback as design emphasis.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Skip vs throw? | Skip — fail-soft product contract. |
| Stable node ids? | ForEach identity — Day 12 crossover. |
| Native Ads player SDUI? | Weak — keep renderer native (S1). |

---

### Q5. What is search cancel discipline in 20 seconds?

**Points to:** [Deep dive · §5 Search cancel](../02-deep-dive.md#5-week-2-connective-micro-answers-embedded) · [Day 08 SearchViewModel](../../day-08/code/SearchViewModel.swift)

**Answer:**

> Debounce in view model. Cancel in-flight `Task` on new query. **Cancellation ≠ user-facing error** — ignore stale results. MVVM binding for loading/empty/error. Verified S3: backend-driven header + search debounce/state/MVVM.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Debounce VM vs repository? | Mock tricky — pick a side with trade-off. |
| Race on slow network? | Generation token or task id — apply latest only. |
| SDUI search field? | Same cancel discipline in observable model. |

---

### Q6. What is SwiftUI identity in 20 seconds for mock warm-ups?

**Points to:** [Deep dive · §5 SwiftUI identity](../02-deep-dive.md#5-week-2-connective-micro-answers-embedded) · [Day 12 sample](../../day-12/sample/02-identity-traps.md)

**Answer:**

> Stable IDs preserve `@State` and representables. **Never `.id(UUID())` in body** — text clears, players restart. Stories pages need stable identity across progress ticks (S10). SDUI leaves use server node ids, not array indices.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Intentional reset? | Logout `.id(session)` — deliberate. |
| Hybrid link? | Representable remake — Day 11. |
| List jump? | Unstable ForEach ids. |

---

### Q7. What is Array-as-queue in 15 seconds?

**Points to:** [Deep dive · §5 Array as queue](../02-deep-dive.md#5-week-2-connective-micro-answers-embedded) · [Day 13 sample](../../day-13/sample/01-stack-queue-basics.md)

**Answer:**

> `Array.removeFirst()` is **O(n)** per dequeue — shifts all elements. Name it or use **Deque**, two-stack queue, or ring buffer. BFS hot paths need honest queue cost. DSA composure: don’t let basics block architecture talk.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Two-stack? | Amortized O(1) — say amortized. |
| Mock warm-up? | One DSA composure question in Block 1. |
| Next topic? | Mock format — [02-mock-format.md](02-mock-format.md). |

---

Next: [02-mock-format.md](02-mock-format.md)
