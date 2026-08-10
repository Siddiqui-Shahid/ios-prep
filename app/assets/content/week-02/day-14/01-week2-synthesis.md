# Sample 01 — Week 2 synthesis (Q&A)

> Guided teaching. Each answer stands alone and ends with **How can I relate to my case** using named work — never S-codes.

---

### Q1. What is the Week 2 narrative in one flow?
**Answer:**

> Day 08: layers / DI / search VM → Day 09: URLSession / refresh / pin / cancel → Day 10: SDUI schema / registry / fallback → Day 11: lifecycle / cells / hybrid / bottom sheet → Day 12: SwiftUI state / identity / Stories SDK → Day 13: stack · queue · LL composure. One senior sentence: clear layers and DI, own networking with cancellation and security, SDUI where content velocity matters with fail-soft schema, UIKit/SwiftUI lifecycle and identity as production contracts.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| BMS / District / Raw? | Tie honestly — Verified stories per day, no merged fake project. |
| Week 1 still relevant? | POP, ARC, async — Mock #2 assumes Week 1+2 together. |
| Revision twin? | [revision/weeks/week-02/day-14.md](../../../../revision/weeks/week-02/day-14.md) |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q2. What is the Week 2 one-liner to memorize?
**Answer:**

> “I structure features with clear layers and DI, own networking with cancellation and security, use SDUI where content velocity matters with fail-soft schema, and treat UIKit/SwiftUI lifecycle and identity as production contracts — proven on BMS, District, and Raw apps.” Adjust provenance per story — don’t claim every bullet on every employer.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Overclaim risk? | One-liner is synthesis — STAR still per Verified ID. |
| District piece? | District Free Parking + Clean/MVVM + AI tooling Clean/MVVM + AI judgment — supporting spice. |
| Raw piece? | Stories SDK (Raw / Miami Heat) Stories, Hybrid UI / deeplinks Grizzlies hybrid. |

**How can I relate to my case:**
- **Shipped:** Stories SDK (Raw / Miami Heat); Hybrid UI / deeplinks; District Free Parking + Clean/MVVM + AI tooling
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q3. What is single-flight refresh in 30 seconds?
**Answer:**

> N concurrent 401s shouldn’t each start refresh. **One refresh Task**; other callers become **waiters** that await the same result. Retry once on success path; on failure → logout fan-out. FIFO queue of continuations mental model (Day 13 soft bridge). Verified: BookMyShow SSL pinning + URLSession migration URLSession ownership on Ads — not invented stampede metrics.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| vs debounce? | Debounce delays intent; single-flight dedupes concurrent same work. |
| Pin outage same week? | IMOC leadership + backup pins design (Design: pin rotation / break-glass (not shipped runbook) Applied). |
| Mock tricky pool? | Refresh stampede + pin outage — Block 2. |

**How can I relate to my case:**
- **Shipped:** BookMyShow SSL pinning + URLSession migration
- **Design if asked:** Design: pin rotation / break-glass (not shipped runbook)
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Claiming pin-rotation / break-glass runbook as a shipped production playbook.

---

### Q4. What is unknown SDUI handling in 20 seconds?
**Answer:**

> Unknown component type → **skip + metric**; never crash the shell. Schema version gate on fetch. Empty root after parse → **hard fallback** header/splash. Last-known-good cache when network fails. Allowlisted actions only — no arbitrary URL schemes from CMS. BookMyShow backend-driven header & search-A1 emphasizes versioning + fallback as design emphasis.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Skip vs throw? | Skip — fail-soft product contract. |
| Stable node ids? | ForEach identity — Day 12 crossover. |
| Native Ads player SDUI? | Weak — keep renderer native (BookMyShow Ads pipeline + HeroWidget lifecycle). |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle; BookMyShow backend-driven header & search
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

---

### Q5. What is search cancel discipline in 20 seconds?
**Answer:**

> Debounce in view model. Cancel in-flight `Task` on new query. **Cancellation ≠ user-facing error** — ignore stale results. MVVM binding for loading/empty/error. BookMyShow backend-driven header & search: backend-driven header + search debounce/state/MVVM.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Debounce VM vs repository? | Mock tricky — pick a side with trade-off. |
| Race on slow network? | Generation token or task id — apply latest only. |
| SDUI search field? | Same cancel discipline in observable model. |

**How can I relate to my case:**
- **Shipped:** BookMyShow backend-driven header & search
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q6. What is SwiftUI identity in 20 seconds for mock warm-ups?
**Answer:**

> Stable IDs preserve `@State` and representables. **Never `.id(UUID)` in body** — text clears, players restart. Stories pages need stable identity across progress ticks (Stories SDK (Raw / Miami Heat)). SDUI leaves use server node ids, not array indices.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Intentional reset? | Logout `.id(session)` — deliberate. |
| Hybrid link? | Representable remake — Day 11. |
| List jump? | Unstable ForEach ids. |

**How can I relate to my case:**
- **Shipped:** Stories SDK (Raw / Miami Heat)
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q7. What is Array-as-queue in 15 seconds?
**Answer:**

> `Array.removeFirst` is **O(n)** per dequeue — shifts all elements. Name it or use **Deque**, two-stack queue, or ring buffer. BFS hot paths need honest queue cost. DSA composure: don’t let basics block architecture talk.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Two-stack? | Amortized O(1) — say amortized. |
| Mock warm-up? | One DSA composure question in Block 1. |
| Next topic? | Mock format — [02-mock-format.md](02-mock-format.md). |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

Next: [02-mock-format.md](02-mock-format.md)

---

## Brain puzzles (cover → think → check)

### Puzzle A — What is the Week 2 one-liner to memorize

**Ask yourself:** What is the Week 2 one-liner to memorize?

**Answer:** “I structure features with clear layers and DI, own networking with cancellation and security, use SDUI where content velocity matters with fail-soft schema, and treat UIKit/SwiftUI lifecycle and identity as production contracts — proven on BMS, District, and Raw apps.” Adjust provenance per story — don’t claim every bullet on every employer.

### Puzzle B — What is single-flight refresh in 30 seconds

**Ask yourself:** What is single-flight refresh in 30 seconds?

**Answer:** “N concurrent 401s shouldn’t each start refresh. **One refresh Task**; other callers become **waiters** that await the same result. Retry once on success path; on failure → logout fan-out. FIFO queue of continuations mental model (Day 13 soft bridge). Verified: BookMyShow SSL pinning + URLSession migration URLSession ownership on Ads — not invented stampede metrics.”

### Puzzle C — What is unknown SDUI handling in 20 seconds

**Ask yourself:** What is unknown SDUI handling in 20 seconds?

**Answer:** “Unknown component type → **skip + metric**; never crash the shell. Schema version gate on fetch. Empty root after parse → **hard fallback** header/splash. Last-known-good cache when network fails. Allowlisted actions only — no arbitrary URL schemes from CMS. BookMyShow backend-driven header & search-A1 emphasizes versioning + fallback as design emphasis.”
