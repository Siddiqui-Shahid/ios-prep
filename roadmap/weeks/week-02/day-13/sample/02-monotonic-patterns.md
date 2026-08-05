# Sample 02 — Monotonic patterns & queues (Q&A)

> Guided teaching. Each answer stands alone; **Points to** shows where the full module expands the idea.

---

### Q1. How does valid parentheses work on a stack?

**Points to:** [Deep dive · §1.2 Valid parentheses](../02-deep-dive.md#12-valid-parentheses-pattern) · [Foundations · §4 Pattern map](../01-foundations.md#4-pattern--structure-map)

**Answer:**

> Push opening brackets. On a closer, pop and check it matches the expected opener. End with empty stack ⇒ valid. Brute force with counters fails on ordering — `([)]`. Complexity: **O(n) time, O(n) space**. Edges: empty string → true; only closers → false; odd length → false; mixed types `()[]{}`.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Approach script opener? | Clarify bracket pairs → brute ordering failure → stack map → O(n)/O(n) → edges → code. |
| Undo/redo cousin? | Stack of states — same LIFO discipline. |
| Nested CMS JSON? | Different problem — still “matching/nesting” instinct. |

---

### Q2. What is a monotonic stack?

**Points to:** [Deep dive · §1.3 Monotonic stack](../02-deep-dive.md#13-monotonic-stack--next-greater) · [code/MonotonicStack.swift](../code/MonotonicStack.swift)

**Answer:**

> A stack kept strictly increasing or decreasing to answer “next greater/smaller” in **O(n)**. For daily temperatures: maintain a **decreasing stack of indices**. Walk left to right; while current value is greater than `T[stack.top]`, pop and set answer = i − idx. Push i. Leftovers get 0. Each index pushed/popped at most once.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Brute? | O(n²) nested scan — name it then optimize. |
| Store indices vs values? | Indices — needed for distance/day counts. |
| Sliding window max? | Monotonic **deque** — different container, same invariant idea. |

---

### Q3. How does min stack achieve O(1) getMin?

**Points to:** [Deep dive · §1.4 Min stack](../02-deep-dive.md#14-min-stack-o1) · [code/MinStack.swift](../code/MinStack.swift)

**Answer:**

> Parallel stack of current minimums, or encode diffs between value and current min. Push/pop/getMin all **O(1)**. Trap: scanning for min each pop → O(n). **Duplicates:** push min again when equal so pop stays correct — otherwise min stack loses track after pop.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Space cost? | O(n) extra for min stack — trade for O(1) query. |
| Interview variant? | Max stack — symmetric. |
| Production use? | Learning-lab — honest about interview focus. |

---

### Q4. How does the two-stack queue work?

**Points to:** [Deep dive · §2.2 Two-stack queue](../02-deep-dive.md#22-two-stack-queue) · [code/TwoStackQueue.swift](../code/TwoStackQueue.swift)

**Answer:**

> **inStack:** enqueue via push. **outStack:** dequeue via pop. When out is empty, **flush** all elements from in → out (reverse order restores FIFO). Each element moves at most twice → **amortized O(1)**. Worst-case single dequeue can be O(n) when flushing — say **amortized**, not strict O(1) always.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Approach script? | Enqueue push in; dequeue pour if out empty then pop out; state amortized story. |
| vs ring buffer? | Ring: fixed capacity O(1); two-stack: dynamic, classic interview. |
| vs Deque? | Deque is production-friendly; two-stack is interview canonical. |

---

### Q5. When do I use a queue for BFS?

**Points to:** [Deep dive · §2.3 BFS / level order](../02-deep-dive.md#23-bfs--level-order) · [Foundations · §4 Pattern map](../01-foundations.md#4-pattern--structure-map)

**Answer:**

> Queue holds the frontier. For trees: while queue not empty, drain **level size**, enqueue children. Shortest path in unweighted graphs uses BFS — queue, not stack. Say aloud: “BFS uses a queue; DFS uses a stack or recursion.” Using stack for BFS is a common trap.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Level-order output? | Collect each level during drain loop. |
| Graph cycles? | Track visited — queue alone isn’t enough. |
| Hit counter / recent requests? | Queue of timestamps; drop older than window. |

---

### Q6. What is a circular queue (ring buffer)?

**Points to:** [Deep dive · §2.5 Circular queue](../02-deep-dive.md#25-circular-queue-ring)

**Answer:**

> Fixed array with `head`, `tail`, and `count` (or waste one slot). Indices mod capacity. Empty vs full: with a **count** field, both are unambiguous; without count, waste one slot so `head == tail` means empty. O(1) enqueue/dequeue at ends when capacity fixed.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| S12 adjacency? | Ring language adjacent to media buffering — **do not** claim you shipped Aces as custom ring engine. |
| vs two-stack? | Ring: bounded capacity; two-stack: dynamic interview FIFO. |
| Full when? | count == capacity — reject or overwrite per spec. |

---

### Q7. What failure modes hit stack/queue problems?

**Points to:** [Deep dive · §6 Failure modes / traps](../02-deep-dive.md#6-failure-modes--traps)

**Answer:**

> Code immediately without agenda. Claim two-stack dequeue is always O(1) — say **amortized**. Use stack for BFS. Use Array removeFirst silently on hot path. Lose `next` while reversing linked list — separate file. Force linked list into UITableView — Array + honesty.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Agenda budget? | 2–3 min: restate, brute, optimize, edges, then code. |
| Concurrency on hit counter? | Actor wrapper — Learning-lab if asked. |
| Next topic? | Linked list algos — [03-linked-list-algos.md](03-linked-list-algos.md). |

---

Next: [03-linked-list-algos.md](03-linked-list-algos.md)
