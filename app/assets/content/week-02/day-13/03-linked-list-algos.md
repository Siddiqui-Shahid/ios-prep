# Sample 03 — Linked list algorithms (Q&A)

> Guided teaching. Each answer stands alone and ends with **How can I relate to my case** using named work — never S-codes.

---

### Q1. How do I reverse a linked list iteratively?
**Answer:**

> Three pointers: `prev = nil`, `curr = head`. While `curr`: save `next = curr.next`, set `curr.next = prev`, advance `prev = curr`, `curr = next`. Return `prev` as new head. **O(n) time, O(1) space.** Save `next` before rewiring — classic bug if you skip. Empty and single-node are no-ops.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Recursive reverse? | O(n) call stack — mention depth risk on long lists; prefer iterative unless asked. |
| Approach script? | Iterative three-pointer O(1) space; save next before rewrite; edges empty/single. |
| Production Swift? | Interview must-have; Arrays dominate product UI. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q2. How does Floyd cycle detection work?
**Answer:**

> **Slow** pointer +1, **fast** +2 per step. If they meet, a cycle exists. Optional phase 2: reset one pointer to head, both advance +1 → cycle entrance. **O(n) time, O(1) space.** Hash-set alternative: O(n) space but simpler to narrate under time pressure.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| No cycle? | Fast reaches nil. |
| Phase 2 when? | When interviewer asks for entrance node, not just boolean. |
| Swift `ListNode`? | `final class` — reference semantics; cycle is possible. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q3. How do I find the middle of a linked list?
**Answer:**

> Same slow/fast: when fast reaches end, slow is middle. **State even-length policy aloud** — lower mid vs upper mid (problem dependent). Off-by-one on even lists kills candidates who stay silent.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Fast null check? | While fast and fast.next for middle; cycle variant differs. |
| Delete middle node? | Often copy next value or use dummy head — separate problem. |
| Array middle? | O(1) index — why Arrays win for random access. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q4. How do I merge two sorted linked lists?
**Answer:**

> **Dummy head** node simplifies edge cases. Compare heads, append smaller to tail, advance that list. Attach remainder when one list exhausts. **O(n+m) time, O(1) extra** (excluding output links). Narrate pointer updates — off-by-ones are the failure mode.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Dummy head why? | Avoid special-casing empty result head. |
| Recursive merge? | O(n+m) stack — iterative preferred in interviews. |
| Merge k lists preview? | Repeated merge O(kn); min-heap O(n log k) — Week 4 preview. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q5. What is reverse k-group and why is it tricky?
**Answer:**

> Count k nodes available; if fewer than k, leave segment intact. Reverse the k segment. Reconnect previous tail → new head; iterate. Off-by-ones and losing `next` during segment reverse kill this problem — narrate links aloud.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Partial tail? | Leave remainder unreversed — spec dependent. |
| Dummy head again? | Often helps segment bookkeeping. |
| Interview frequency? | Hard — shows pointer mastery. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q6. What is the universal coding opener?
**Answer:**

> “Let me restate, confirm constraints, then I’ll give brute, optimize, complexity, and edges before coding.” Sequence: restate + clarifying questions → brute + complexity → optimized structure + why → edges + API shape → “I’ll code the optimized version now.” ~2–3 minutes. If you skip in practice, restart the problem.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Minimum time box? | ~60–90s for shorter problems; 2–3 min for medium. |
| Mid-problem constraint change? | Restate new plan aloud — don’t silently rewrite. |
| Full scripts? | [code/ApproachScripts.md](../code/ApproachScripts.md) |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q7. What linked-list traps should I name before coding?
**Answer:**

> Lose `next` while reversing. Even-length mid ambiguity — state policy. k-group leftover reversed incorrectly. Hash cycle vs Floyd — pick one. Claim O(1) Array queue. If interviewer pivots to SDUI mid-problem: park coding state, answer versioning + unknown skip (Day 10), offer to resume — composure beat.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Dummy head when? | Merge, insert, delete — simplifies empty head edges. |
| Class vs struct node? | Interview `ListNode` is class — shared mutable links. |
| Next topic? | Production bridges — [04-production-bridges.md](04-production-bridges.md). |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

Next: [04-production-bridges.md](04-production-bridges.md)

---

## Brain puzzles (cover → think → check)

### Puzzle A — How does Floyd cycle detection work

**Ask yourself:** How does Floyd cycle detection work?

**Answer:** “**Slow** pointer +1, **fast** +2 per step. If they meet, a cycle exists. Optional phase 2: reset one pointer to head, both advance +1 → cycle entrance. **O(n) time, O(1) space.** Hash-set alternative: O(n) space but simpler to narrate under time pressure.”

### Puzzle B — How do I find the middle of a linked list

**Ask yourself:** How do I find the middle of a linked list?

**Answer:** “Same slow/fast: when fast reaches end, slow is middle. **State even-length policy aloud** — lower mid vs upper mid (problem dependent). Off-by-one on even lists kills candidates who stay silent.”

### Puzzle C — How do I merge two sorted linked lists

**Ask yourself:** How do I merge two sorted linked lists?

**Answer:** “**Dummy head** node simplifies edge cases. Compare heads, append smaller to tail, advance that list. Attach remainder when one list exhausts. **O(n+m) time, O(1) extra** (excluding output links). Narrate pointer updates — off-by-ones are the failure mode.”
