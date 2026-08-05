# Sample 03 — Linked list algorithms (Q&A)

> Guided teaching. Each answer stands alone; **Points to** shows where the full module expands the idea.

---

### Q1. How do I reverse a linked list iteratively?

**Points to:** [Deep dive · §3.2 Reverse iterative](../02-deep-dive.md#32-reverse-iterative-must-have) · [code/LinkedListAlgos.swift](../code/LinkedListAlgos.swift)

**Answer:**

> Three pointers: `prev = nil`, `curr = head`. While `curr`: save `next = curr.next`, set `curr.next = prev`, advance `prev = curr`, `curr = next`. Return `prev` as new head. **O(n) time, O(1) space.** Save `next` before rewiring — classic bug if you skip. Empty and single-node are no-ops.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Recursive reverse? | O(n) call stack — mention depth risk on long lists; prefer iterative unless asked. |
| Approach script? | Iterative three-pointer O(1) space; save next before rewrite; edges empty/single. |
| Production Swift? | Interview must-have; Arrays dominate product UI. |

---

### Q2. How does Floyd cycle detection work?

**Points to:** [Deep dive · §3.3 Floyd cycle detection](../02-deep-dive.md#33-floyd-cycle-detection) · [Foundations · §2 Glossary](../01-foundations.md#2-glossary-learn-these-cold)

**Answer:**

> **Slow** pointer +1, **fast** +2 per step. If they meet, a cycle exists. Optional phase 2: reset one pointer to head, both advance +1 → cycle entrance. **O(n) time, O(1) space.** Hash-set alternative: O(n) space but simpler to narrate under time pressure.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| No cycle? | Fast reaches nil. |
| Phase 2 when? | When interviewer asks for entrance node, not just boolean. |
| Swift `ListNode`? | `final class` — reference semantics; cycle is possible. |

---

### Q3. How do I find the middle of a linked list?

**Points to:** [Deep dive · §3.4 Middle of list](../02-deep-dive.md#34-middle-of-list)

**Answer:**

> Same slow/fast: when fast reaches end, slow is middle. **State even-length policy aloud** — lower mid vs upper mid (problem dependent). Off-by-one on even lists kills candidates who stay silent.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Fast null check? | While fast and fast.next for middle; cycle variant differs. |
| Delete middle node? | Often copy next value or use dummy head — separate problem. |
| Array middle? | O(1) index — why Arrays win for random access. |

---

### Q4. How do I merge two sorted linked lists?

**Points to:** [Deep dive · §3.5 Merge two sorted lists](../02-deep-dive.md#35-merge-two-sorted-lists)

**Answer:**

> **Dummy head** node simplifies edge cases. Compare heads, append smaller to tail, advance that list. Attach remainder when one list exhausts. **O(n+m) time, O(1) extra** (excluding output links). Narrate pointer updates — off-by-ones are the failure mode.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Dummy head why? | Avoid special-casing empty result head. |
| Recursive merge? | O(n+m) stack — iterative preferred in interviews. |
| Merge k lists preview? | Repeated merge O(kn); min-heap O(n log k) — Week 4 preview. |

---

### Q5. What is reverse k-group and why is it tricky?

**Points to:** [Deep dive · §3.6 Reverse k-group](../02-deep-dive.md#36-reverse-k-group-tricky)

**Answer:**

> Count k nodes available; if fewer than k, leave segment intact. Reverse the k segment. Reconnect previous tail → new head; iterate. Off-by-ones and losing `next` during segment reverse kill this problem — narrate links aloud.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Partial tail? | Leave remainder unreversed — spec dependent. |
| Dummy head again? | Often helps segment bookkeeping. |
| Interview frequency? | Hard — shows pointer mastery. |

---

### Q6. What is the universal coding opener?

**Points to:** [Foundations · §6 Coding approach budget](../01-foundations.md#6-coding-approach-budget-23-min--memorize) · [Deep dive · §4 Approach scripts bank](../02-deep-dive.md#4-approach-scripts-bank-embed--speak-these)

**Answer:**

> “Let me restate, confirm constraints, then I’ll give brute, optimize, complexity, and edges before coding.” Sequence: restate + clarifying questions → brute + complexity → optimized structure + why → edges + API shape → “I’ll code the optimized version now.” ~2–3 minutes. If you skip in practice, restart the problem.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Minimum time box? | ~60–90s for shorter problems; 2–3 min for medium. |
| Mid-problem constraint change? | Restate new plan aloud — don’t silently rewrite. |
| Full scripts? | [code/ApproachScripts.md](../code/ApproachScripts.md) |

---

### Q7. What linked-list traps should I name before coding?

**Points to:** [Deep dive · §6 Failure modes](../02-deep-dive.md#6-failure-modes--traps) · [§7 Catch-up ↔ DSA composure](../02-deep-dive.md#7-catch-up--dsa-composure-t8-energy)

**Answer:**

> Lose `next` while reversing. Even-length mid ambiguity — state policy. k-group leftover reversed incorrectly. Hash cycle vs Floyd — pick one. Claim O(1) Array queue. If interviewer pivots to SDUI mid-problem: park coding state, answer versioning + unknown skip (Day 10), offer to resume — composure beat.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Dummy head when? | Merge, insert, delete — simplifies empty head edges. |
| Class vs struct node? | Interview `ListNode` is class — shared mutable links. |
| Next topic? | Production bridges — [04-production-bridges.md](04-production-bridges.md). |

---

Next: [04-production-bridges.md](04-production-bridges.md)
