# Sample 04 — Production bridges & Mock prep (Q&A)

> Guided teaching. Honest bridges from DSA patterns to iOS interview language — without inventing production linked lists.

---

### Q1. What production claims are allowed for Day 13 DSA?

**Points to:** [Production bridge · §1 Provenance map](../03-production-bridge.md#1-provenance-map-for-today) · [§2 Structure → production bridge table](../03-production-bridge.md#2-structure--production-bridge-table)

**Answer:**

> **Learning-lab:** patterns + Swift in `code/` for interviews. **Soft bridges only:** S4 mindset — refresh **waiters** as FIFO queue of continuations (Day 09). S6/S13 — nav back stack as LIFO mental model; Verified **30%+** nav metric for LE sheet. S12 adjacency — ring buffer **vocabulary** for media, not “I built Aces ring engine.” S8 — composure pivot energy, not a DSA incident story.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Forbidden? | “We used linked lists for the feed”; fake LRU in prod at BMS; fake complexity wins as metrics. |
| Verified DSA feature? | None — interview skill chapter. |
| Tomorrow link? | DSA feeds composure for Mock #2 — pick Ads or SDUI track tonight. |

---

### Q2. How do refresh waiters bridge to a queue? (S4 mindset)

**Points to:** [Production bridge · §3 Soft bridge — refresh waiters](../03-production-bridge.md#3-scripts) · [Day 09 single-flight](../../../week-02/day-09/01-foundations.md)

**Answer:**

> Concurrent 401s shouldn’t each refresh independently. **Waiters line up** behind one refresh Task — conceptually a **FIFO queue** of continuations — then fan-out when refresh completes. Same discipline as BFS queue, applied to auth. Verified work is Ads URLSession security ownership (S4); waiter queue is the concurrency **pattern** you reason about in that layer — label Learning-lab / soft bridge.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| ≤20s line? | “Refresh waiters share one in-flight refresh — FIFO mental model like a BFS queue of continuations.” |
| Stampede failure? | N×401 → N refresh calls — single-flight fixes. |
| Mock #2 tricky? | Refresh stampede + pin outage leadership — Day 14. |

---

### Q3. How does navigation bridge to a stack? (S6 / S13)

**Points to:** [Production bridge · §3 Soft bridge — nav LIFO](../03-production-bridge.md#3-scripts)

**Answer:**

> Product navigation is **LIFO**: push screens, pop on back. LE Bottom Sheet reduced **full-screen pushes** — Verified **30%+** fewer full-screen navigations (S6). Hybrid apps still need **one router** — stack discipline matters when deeplinks push (S13). Metaphor supports intuition; don’t claim UIKit literally implements parentheses matching.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Sheet vs push? | Sheet cuts nav fatigue for shallow overview — S6 product win. |
| Dual stacks? | Anti-pattern — one owner (Day 11). |
| Undo stack? | Same LIFO — valid parentheses cousin. |

---

### Q4. What is the honest linked-list interview answer?

**Points to:** [Production bridge · §3 Honest LL answer](../03-production-bridge.md#3-scripts) · [Deep dive · §3.1 Why rare](../02-deep-dive.md#31-why-rare-in-swift-apps)

**Answer:**

> “Linked lists rarely appear in my iOS UI code because Array has better locality and ergonomics. I use them in interviews for reverse/cycle/merge and when designing an LRU with a dict plus node list. I won’t pretend BMS Ads was a linked-list codebase.” Provenance: Learning-lab honesty.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| LRU design interview? | Hash map + doubly linked list — legitimate LL use case. |
| UITableView? | Array-backed — not LL nodes. |
| When Array beats LL? | Random access, cache, Swift algorithms — almost always in UI. |

---

### Q5. What is the Day 13 opener line?

**Points to:** [Production bridge · §4 Interview line](../03-production-bridge.md#4-interview-line-20s--day-opener) · [Foundations · §6 Coding approach](../01-foundations.md#6-coding-approach-budget-23-min--memorize)

**Answer:**

> “For coding I’ll state structure and complexity first — for example monotonic stack O(n) — then write clean iterative Swift; and I’ll call out Array-as-queue costs when relevant.” Pair with universal agenda: restate, brute, optimize, edges, then code.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Array removeFirst? | Call out O(n) or name alternative. |
| Two-stack queue? | Say amortized O(1). |
| Record practice? | 04-questions — speak 6–8 answers. |

---

### Q6. How does DSA composure help in mixed interviews?

**Points to:** [Deep dive · §7 Catch-up ↔ DSA composure](../02-deep-dive.md#7-catch-up--dsa-composure-t8-energy) · [Foundations · §8 Week 2 catch-up](../01-foundations.md#8-week-2-catch-up-dont-skip-mock-2-prep)

**Answer:**

> Interviewer pivots coding → SDUI mid-problem: **park state** (“I have prev/curr wired through node 3…”), answer SDUI with versioning + unknown skip (Day 10 / S3), offer to resume coding. Shows calm ownership (S8 IMOC energy) without inventing a DSA production incident. Also: pick **one** weak Week 2 day for 45–60m catch-up — still finish timed DSA drill.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Weak on hybrid? | Day 11 + S13 opener. |
| Weak on identity? | Day 12 + S10 opener. |
| Mock #2 tonight? | Choose Ads **or** SDUI architecture track. |

---

### Q7. What should I do after Day 13 sample?

**Points to:** [README · Suggested order](README.md#suggested-order) · [Day 14 sample](../../day-14/sample/README.md)

**Answer:**

> Finish timed drills in [`../05-exercises.md`](../05-exercises.md) — one Easy + one Medium. Record 6–8 answers from [`../04-questions.md`](../04-questions.md). Choose **Ads or SDUI** for tomorrow’s Mock #2. Skim [`../../day-14/sample/`](../../day-14/sample/) for mock format and architecture spines.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Skip DSA for mock prep? | No — composure matters; don’t let basics block. |
| Week 2 catch-up? | One weak day only — don’t skip today’s drill. |
| Revision twin? | [revision/weeks/week-02/day-13.md](../../../../revision/weeks/week-02/day-13.md) |

---

Back to: [README.md](README.md)
