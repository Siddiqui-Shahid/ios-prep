# Sample 03 — Mixed unknown-pattern (Q&A)

> Guided teaching. Each answer stands alone; **Points to** shows where the full module expands the idea.

---

### Q1. What is the 90-second unknown-pattern protocol?

**Points to:** [Foundations · §3 Mixed unknown-pattern](../01-foundations.md#3-mixed-unknown-pattern--the-90-second-protocol) · [Deep dive · §3 Mixed simulation](../02-deep-dive.md#3-mixed-unknown-pattern-simulation-todays-differentiator)

**Answer:**

> First 90 seconds on unlabeled Mediums: **(1)** restate + constraints (sorted? online? duplicates? memory?). **(2)** brute one sentence. **(3)** classify: array scan / two pointer / window / hash / heap / tree / graph / binary search / DP-lite. **(4)** pick one and reject one alternative aloud. **Do not code** until step 4 is done.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Goal in drills? | 5/6 correct pattern tags before coding. |
| Timer? | 90s classification only — write pattern name, then solve or skip. |
| Anti-pattern? | Silent coding with no classification. |

---

### Q2. How do I decide hash vs heap vs window?

**Points to:** [Foundations · §3 table](../01-foundations.md#3-mixed-unknown-pattern--the-90-second-protocol)

**Answer:**

> **Hash** if you need counts, complements, seen set, grouping, or prefix state (especially with negatives). **Heap** if you always care about “best K so far” or merge K sorted streams. **Window / prefix** if constraint is contiguous subarray/substring. **Tree** if hierarchy/nested (Day 22). **Two pointer / BS** if sorted property is explicit. **DP** only when overlapping subproblems are stated — don’t force today.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| “Feels hard” → DP? | Anti-pattern — try hash/heap/tree first. |
| Sorted + need indices? | Hash or index map — not blind sort. |
| Online stream? | Heap size K strong signal. |

---

### Q3. How do I recover from a wrong pattern pick?

**Points to:** [Deep dive · §3 Misclassification recovery](../02-deep-dive.md#3-mixed-unknown-pattern-simulation-todays-differentiator)

**Answer:**

> Narrate the pivot aloud: “I started window but negatives break monotonicity — switching to prefix+hash.” Seniors narrate; juniors silently thrash. Restate complexity after pivot. Better a clean pivot at 5 minutes than wrong code for 25.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Interviewer hint? | Incorporate into restated plan — don’t ignore. |
| Two patterns hybrid? | Sometimes hash + heap (top-K freq) — say both. |
| Still stuck at 10 min? | Brute that runs — partial credit beats blank IDE. |

---

### Q4. What is the unknown-pattern spoken script?

**Points to:** [Foundations · §5 Unknown script](../01-foundations.md#5-first-scripts-to-memorize)

**Answer:**

> “I’ll classify in 90 seconds: constraints → brute → hash/heap/window/tree → commit. Clarify uniqueness, order, online vs offline. Then name edges and complexity before coding.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Example pivot line? | “Contiguous sum with negatives — prefix map, not two pointers.” |
| Reject alternative aloud? | “Not DP — no overlapping subproblem stated; hash one-pass fits.” |
| Mixed drill block? | 6 blind problems: 90s tag each, then solve — see exercises. |

---

### Q5. Approach scripts for two-layer Q&A?

**Points to:** [Deep dive · §6 Approach scripts](../02-deep-dive.md#6-approach-scripts-two-layer-ready)

**Answer:**

> Use as **Answer points** spines: **Two Sum** — indices? hash complement; else sort+two pointer. **Anagrams** — sorted or count key. **Subarray sum K** — negatives? prefix+hash. **Top K freq** — count → heap K or bucket. **Merge K** — heap heads O(N log K). **Unknown** — clarify → brute → classify → pick → edges.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Where practiced? | [`../04-questions.md`](../04-questions.md) two-layer format. |
| 60s vs 90s? | Classification 90s; family-specific script ~60s inside. |
| Record yourself? | Suggested record set in questions module. |

---

### Q6. What trade-offs belong in mixed problems?

**Points to:** [Deep dive · §4 Trade-offs](../02-deep-dive.md#4-trade-offs)

**Answer:**

> Hash: O(n) space, key-design bugs. Sort+two pointer: loses indices unless pairs kept. Heap size K: comparator bugs, O(n log k). Full sort: overkill for top-K. Bucket: extra structure, clarity win. TreeMap/sorted dict: rare on iOS LC. Pick one and name cost.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Memory tight? | Sort in-place + two pointer — say O(n log n). |
| Need full order? | Sort beats heap. |
| Freq bounded small? | Counting sort / bucket beats heap. |

---

### Q7. Checklist before leaving Day 23 foundations?

**Points to:** [Foundations · §7 Checklist](../01-foundations.md#7-checklist-before-deep-dive)

**Answer:**

> Two Sum hash script clean. Min-heap size K for Kth largest explained. Negatives → prefix+hash internalized. 90s unknown-pattern protocol rehearsed once. Swift gotchas named if relevant (String index, removeFirst).

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Exit criteria? | See [`../05-exercises.md`](../05-exercises.md) — hash block, heap block, mixed simulation mandatory. |
| Code lab first? | Read `code/HashPatterns.swift` and `HeapPatterns.swift` before inventing. |
| Next sample? | Production hooks — maps and top-K without cosplay. |

---

Next: [04-production-maps-topk.md](04-production-maps-topk.md)
