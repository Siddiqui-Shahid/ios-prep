# Sample 01 — Machine round operating system (Q&A)

> Guided teaching. Each answer stands alone and ends with **How can I relate to my case** using named work — never S-codes.

---

### Q1. What is the north star for a 3-hour machine round?
**Answer:**

> **Ship a tested happy path with documented cut lines.** A polished unfinished cathedral loses to a demoable core. If you cannot demo in 60 seconds — load, show data, one secondary behavior (next page **or** unknown fallback), mention a test — you do not have a slice yet.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Proctor opener 0:15? | “Clarify briefly, then vertical slice: UI → ViewModel → protocol repository — fake data first. Time for tests and cut lines.” |
| Build both briefs? | Pick A **or** B — outline other in notes only if surplus time. |
| Perfectionism? | Stop styling when pagination/SDUI core broken. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q2. What is the 3-hour clock?
**Answer:**

> **0:00–0:15 Clarify** — restate, API shape, offline?, UIKit/SwiftUI, tests; don’t code yet. **0:15–0:20 Agenda** — layers + milestones aloud. **0:20–0:45 Skeleton** — types, protocols, empty UI, fake repo. **0:45–2:00 Vertical slice** — one happy path E2E. **2:00–2:30 Depth** — cache **or** 2nd component. **2:30–2:50 Tests** — 3–6 meaningful unit tests. **2:50–3:00 Buffer** — trade-offs + known gaps README.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Silent first 10 min? | Fail communication rubric — narrate agenda by 0:20. |
| Pixel-perfect at 1:00? | Wrong priority — happy path first. |
| No tests at 2:40? | Write two immediately — pass bar needs tests ≥3. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q3. What is a vertical slice in practice?
**Answer:**

> End-to-end path a proctor can watch: UI triggers ViewModel → repository returns data → UI updates. Plus **one** depth feature: append page 2 (Brief A) or render unknown component safely (Brief B). Mention at least one test by name in buffer.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Fake repo first? | Yes — stub remote, swap live if time; tests depend on protocol. |
| Real network? | Impressive if stable — flaky Wi‑Fi; prefer stub + one live. |
| README in buffer? | Known gaps, cache policy, cut lines — graders read this. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q4. Anti-perfectionism — what should trigger a stop?
**Answer:**

> Styling fonts while pagination broken → **stop**. Cannot demo in 60s now → **slice**. After 2:30 with zero tests → **write two now**. Haven’t narrated cache/SDUI policy → **say in buffer**. Renaming for beauty → **stop**.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Diffable animations? | Cut line for Brief A unless core done early. |
| Full Clean Architecture? | Rarely fits 3 hrs — pragmatic MVVM + protocols. |
| 100% coverage chase? | Fail — 3–6 meaningful tests win. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q5. Brief A or Brief B — how do I choose?
**Answer:**

> **Choose A** if weaker on networking/state/cache — list UX proof. **Choose B** if weaker on SDUI/decoding/fallbacks — high ROI before Day 27 SDUI system design. Do not build both in 3 hours.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| BookMyShow backend-driven header & search hook? | Both touch list/search and SDUI instincts — honest ≤20s only. |
| UIKit vs SwiftUI? | Clarify at 0:15; state assumption aloud. |
| Surplus time? | Second brief **notes** only — 20 min max. |

**How can I relate to my case:**
- **Shipped:** BookMyShow backend-driven header & search
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q6. What do graders hear at key minutes?
**Answer:**

> **0:10** — restated brief + 2 clarifying Qs. **0:18** — layer plan + cut lines. **1:00** — “happy path compiling.” **2:10** — cache policy or unknown-type policy named. **2:40** — test names aloud while writing. **2:55** — known gaps README.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Trade-offs when? | Buffer + debrief — not only at end if asked. |
| AI scaffolding tests? | District Free Parking + Clean/MVVM + AI tooling — you own architecture and review. |
| Pass bar? | Rubric avg ≥3.5, correctness ≥4, tests ≥3. |

**How can I relate to my case:**
- **Shipped:** District Free Parking + Clean/MVVM + AI tooling
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q7. What should I say at 0:15 (proctor opener)?
**Answer:**

> “I’ll clarify briefly, then build a vertical slice: UI → ViewModel → protocol repository — fake data first. I’ll leave time for tests and document cut lines.” Then pick Brief A or B 90s plan from sample 02 or 03.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Clarifying Q examples? | Pagination cursor vs page? Cache stale-while-revalidate? SDUI unknown behavior? |
| Agenda layers? | ListView/Renderer → ViewModel → Repository protocol → Remote + Cache or Decoder + Factory. |
| Next? | Brief-specific sample 02 or 03. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

Next: [02-brief-a-pagination.md](02-brief-a-pagination.md) · [03-brief-b-sdui.md](03-brief-b-sdui.md)

---

## Brain puzzles (cover → think → check)

### Puzzle A — What is the 3-hour clock

**Ask yourself:** What is the 3-hour clock?

**Answer:** “**0:00–0:15 Clarify** — restate, API shape, offline?, UIKit/SwiftUI, tests; don’t code yet. **0:15–0:20 Agenda** — layers + milestones aloud. **0:20–0:45 Skeleton** — types, protocols, empty UI, fake repo. **0:45–2:00 Vertical slice** — one happy path E2E. **2:00–2:30 Depth** — cache **or** 2nd component. **2:30–2:50 Tests** — 3–6 meaningful unit tests. **2:50–3:00 Buffer** — trade-offs + known gaps README.”

### Puzzle B — What is a vertical slice in practice

**Ask yourself:** What is a vertical slice in practice?

**Answer:** “End-to-end path a proctor can watch: UI triggers ViewModel → repository returns data → UI updates. Plus **one** depth feature: append page 2 (Brief A) or render unknown component safely (Brief B). Mention at least one test by name in buffer.”

### Puzzle C — Anti-perfectionism — what should trigger a stop

**Ask yourself:** Anti-perfectionism — what should trigger a stop?

**Answer:** “Styling fonts while pagination broken → **stop**. Cannot demo in 60s now → **slice**. After 2:30 with zero tests → **write two now**. Haven’t narrated cache/SDUI policy → **say in buffer**. Renaming for beauty → **stop**.”
