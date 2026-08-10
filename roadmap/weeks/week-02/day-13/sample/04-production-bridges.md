# Sample 04 — Production story bridges (Q&A)

> Guided teaching. Separates **shipped** named cases from **design-if-asked** and **lab-only** so you never blur them in an interview.

---

### Q1. What production claims are allowed for Day 13 DSA?
**Answer:**

> **Learning-lab:** patterns + Swift in `code/` for interviews. **Soft bridges only:** BookMyShow SSL pinning + URLSession migration mindset — refresh **waiters** as FIFO queue of continuations (Day 09). BookMyShow LE Bottom Sheet/Hybrid UI / deeplinks — nav back stack as LIFO mental model; Verified **30%+** nav metric for LE sheet. Audio streaming + server-driven splash (Aces) adjacency — ring buffer **vocabulary** for media, not “I built Aces ring engine.” BookMyShow IMOC + crash-free at scale — composure pivot energy, not a DSA incident story.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Forbidden? | “We used linked lists for the feed”; fake LRU in prod at BMS; fake complexity wins as metrics. |
| Verified DSA feature? | None — interview skill chapter. |
| Tomorrow link? | DSA feeds composure for Mock #2 — pick Ads or SDUI track tonight. |

**How can I relate to my case:**
- **Shipped:** Audio streaming + server-driven splash (Aces); Hybrid UI / deeplinks; BookMyShow SSL pinning + URLSession migration; BookMyShow LE Bottom Sheet; BookMyShow IMOC + crash-free at scale
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Claiming pin-rotation / break-glass runbook as a shipped production playbook.

---

### Q2. How do refresh waiters bridge to a queue? (BookMyShow SSL pinning + URLSession migration mindset)?
**Answer:**

> Concurrent 401s shouldn’t each refresh independently. **Waiters line up** behind one refresh Task — conceptually a **FIFO queue** of continuations — then fan-out when refresh completes. Same discipline as BFS queue, applied to auth. Verified work is Ads URLSession security ownership (BookMyShow SSL pinning + URLSession migration); waiter queue is the concurrency **pattern** you reason about in that layer — label Learning-lab / soft bridge.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| ≤20s line? | “Refresh waiters share one in-flight refresh — FIFO mental model like a BFS queue of continuations.” |
| Stampede failure? | N×401 → N refresh calls — single-flight fixes. |
| Mock #2 tricky? | Refresh stampede + pin outage leadership — Day 14. |

**How can I relate to my case:**
- **Shipped:** BookMyShow SSL pinning + URLSession migration
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Claiming pin-rotation / break-glass runbook as a shipped production playbook.

---

### Q3. How does navigation bridge to a stack? (BookMyShow LE Bottom Sheet / Hybrid UI / deeplinks)?
**Answer:**

> Product navigation is **LIFO**: push screens, pop on back. LE Bottom Sheet reduced **full-screen pushes** — Verified **30%+** fewer full-screen navigations (BookMyShow LE Bottom Sheet). Hybrid apps still need **one router** — stack discipline matters when deeplinks push (Hybrid UI / deeplinks). Metaphor supports intuition; don’t claim UIKit literally implements parentheses matching.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Sheet vs push? | Sheet cuts nav fatigue for shallow overview — BookMyShow LE Bottom Sheet product win. |
| Dual stacks? | Anti-pattern — one owner (Day 11). |
| Undo stack? | Same LIFO — valid parentheses cousin. |

**How can I relate to my case:**
- **Shipped:** Hybrid UI / deeplinks; BookMyShow LE Bottom Sheet
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q4. What is the honest linked-list interview answer?
**Answer:**

> “Linked lists rarely appear in my iOS UI code because Array has better locality and ergonomics. I use them in interviews for reverse/cycle/merge and when designing an LRU with a dict plus node list. I won’t pretend BMS Ads was a linked-list codebase.” Provenance: Learning-lab honesty.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| LRU design interview? | Hash map + doubly linked list — legitimate LL use case. |
| UITableView? | Array-backed — not LL nodes. |
| When Array beats LL? | Random access, cache, Swift algorithms — almost always in UI. |

**How can I relate to my case:**
- **Shipped:** None for this prompt — keep it conceptual unless they ask for a case.
- **Design if asked:** N/A
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q5. What is the Day 13 opener line?
**Answer:**

> “For coding I’ll state structure and complexity first — for example monotonic stack O(n) — then write clean iterative Swift; and I’ll call out Array-as-queue costs when relevant.” Pair with universal agenda: restate, brute, optimize, edges, then code.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Array removeFirst? | Call out O(n) or name alternative. |
| Two-stack queue? | Say amortized O(1). |
| Record practice? | 07-revision-qna — speak 6–8 answers. |

**How can I relate to my case:**
- **Shipped:** None for this prompt — keep it conceptual unless they ask for a case.
- **Design if asked:** N/A
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q6. How does DSA composure help in mixed interviews?
**Answer:**

> Interviewer pivots coding → SDUI mid-problem: **park state** (“I have prev/curr wired through node 3…”), answer SDUI with versioning + unknown skip (Day 10 / BookMyShow backend-driven header & search), offer to resume coding. Shows calm ownership (BookMyShow IMOC + crash-free at scale IMOC energy) without inventing a DSA production incident. Also: pick **one** weak Week 2 day for 45–60m catch-up — still finish timed DSA drill.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Weak on hybrid? | Day 11 + Hybrid UI / deeplinks opener. |
| Weak on identity? | Day 12 + Stories SDK (Raw / Miami Heat) opener. |
| Mock #2 tonight? | Choose Ads **or** SDUI architecture track. |

**How can I relate to my case:**
- **Shipped:** Stories SDK (Raw / Miami Heat); Hybrid UI / deeplinks; BookMyShow backend-driven header & search; BookMyShow IMOC + crash-free at scale
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Attributing 99.95%+ CFS to a single ticket; inventing DAU figures.

---

### Q7. What should I do after Day 13 sample?
**Answer:**

> Finish timed drills in [`../05-exercises.md`](../05-exercises.md) — one Easy + one Medium. Record 6–8 answers from [07-revision-qna.md](07-revision-qna.md). Choose **Ads or SDUI** for tomorrow’s Mock #2. Skim [`../../day-14/sample/`](../../day-14/sample/) for mock format and architecture spines.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Skip DSA for mock prep? | No — composure matters; don’t let basics block. |
| Week 2 catch-up? | One weak day only — don’t skip today’s drill. |
| Revision twin? | [revision/weeks/week-02/day-13.md](../../../../revision/weeks/week-02/day-13.md) |

**How can I relate to my case:**
- **Shipped:** None for this prompt — keep it conceptual unless they ask for a case.
- **Design if asked:** N/A
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

Back to: [README.md](README.md)

---

## Brain puzzles (cover → think → check)

### Puzzle A — How do refresh waiters bridge to a queue? (BookMyShow SSL pinning + URLSession m

**Ask yourself:** How do refresh waiters bridge to a queue? (BookMyShow SSL pinning + URLSession migration mindset)?

**Answer:** “Concurrent 401s shouldn’t each refresh independently. **Waiters line up** behind one refresh Task — conceptually a **FIFO queue** of continuations — then fan-out when refresh completes. Same discipline as BFS queue, applied to auth. Verified work is Ads URLSession security ownership (BookMyShow SSL pinning + URLSession migration); waiter queue is the concurrency **pattern** you reason about in that layer — label Learning-lab / soft bridge.”

### Puzzle B — How does navigation bridge to a stack? (BookMyShow LE Bottom Sheet / Hybrid UI /

**Ask yourself:** How does navigation bridge to a stack? (BookMyShow LE Bottom Sheet / Hybrid UI / deeplinks)?

**Answer:** “Product navigation is **LIFO**: push screens, pop on back. LE Bottom Sheet reduced **full-screen pushes** — Verified **30%+** fewer full-screen navigations (BookMyShow LE Bottom Sheet). Hybrid apps still need **one router** — stack discipline matters when deeplinks push (Hybrid UI / deeplinks). Metaphor supports intuition; don’t claim UIKit literally implements parentheses matching.”

### Puzzle C — What is the honest linked-list interview answer

**Ask yourself:** What is the honest linked-list interview answer?

**Answer:** “Linked lists rarely appear in my iOS UI code because Array has better locality and ergonomics. I use them in interviews for reverse/cycle/merge and when designing an LRU with a dict plus node list. I won’t pretend BMS Ads was a linked-list codebase.” Provenance: Learning-lab honesty.
