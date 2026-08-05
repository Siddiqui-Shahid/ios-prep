# Sample 01 — Stack & queue basics (Q&A)

> Guided teaching. Each answer stands alone; **Points to** shows where the full module expands the idea.

---

### Q1. What is a stack vs a queue, in one sentence each?

**Points to:** [Foundations · §1 Plain-English mental model](../01-foundations.md#1-plain-english-mental-model) · [§3 Complexity cheat-sheet](../01-foundations.md#3-complexity-cheat-sheet-say-aloud)

**Answer:**

> **Stack:** last in, first out (LIFO) — like a stack of plates; push and pop from the top. **Queue:** first in, first out (FIFO) — like a ticket line; enqueue at the rear, dequeue from the front. **Deque** adds push/pop at both ends. Pick the structure that matches the problem’s access pattern before you code.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Kitchen metaphors? | Stack = plates from top; queue = serve front of line. |
| DFS vs BFS? | DFS uses stack or recursion; BFS uses **queue**. |
| Swift default stack? | `Array` with `append` / `removeLast`. |

---

### Q2. Why is `Array.removeFirst()` a bad default queue?

**Points to:** [Foundations · §3 Complexity cheat-sheet](../01-foundations.md#3-complexity-cheat-sheet-say-aloud) · [Deep dive · §2.1 Why Array.removeFirst is wrong](../02-deep-dive.md#21-why-arrayremovefirst-is-wrong-by-default)

**Answer:**

> `removeFirst()` shifts every remaining element → **O(n)** per dequeue. Fine for tiny n or rare calls. Wrong for BFS hot paths and interview silence. Alternatives: **two-stack queue** (amortized O(1)), head index + compact, **ring buffer**, or Swift Collections **`Deque`**.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| When is removeFirst OK? | Small n, prototype, or you explicitly call out O(n). |
| Production Swift? | Often `Deque` if dependency OK; two-stack for interviews. |
| Interviewer trap? | Claiming Array queue is O(1) — wrong. |

---

### Q3. What are the complexity targets to say aloud?

**Points to:** [Foundations · §3 Complexity cheat-sheet](../01-foundations.md#3-complexity-cheat-sheet-say-aloud) · [Deep dive · §5 Trade-offs table](../02-deep-dive.md#5-trade-offs-table)

**Answer:**

> Array stack push/pop: **amortized O(1)**. Array queue via removeFirst: **O(n)** dequeue. Two-stack queue: **amortized O(1)** enqueue/dequeue. Deque/ring ends: **O(1)**. Linked list local insert/delete given node: **O(1)**; access by index: **O(n)**. Reverse list iterative: O(n) time, O(1) space.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Amortized meaning? | Occasional expensive op spread over many cheap ops — Array growth, two-stack flush. |
| Two-stack worst case? | Dequeue O(n) when pouring in→out — say **amortized**, not strict O(1) always. |
| Floyd cycle? | O(n) time, O(1) space with slow/fast pointers. |

---

### Q4. How do I implement a stack in Swift?

**Points to:** [Foundations · §7 Swift defaults](../01-foundations.md#7-swift-defaults-interview) · [Deep dive · §1.1 Array as stack](../02-deep-dive.md#11-array-as-stack)

**Answer:**

> Default: `var stack: [Int] = []`; `append` to push; `removeLast` or `popLast` to pop; `last` to peek. Say: append/removeLast are amortized O(1) because capacity doubles geometrically — occasional O(n) copy amortized away. A small `Stack<Element>` wrapper is fine in interviews for clarity.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Struct vs class stack? | Struct with mutating methods — value semantics OK for local algorithm. |
| Thread-safe stack? | Wrap in actor or lock if concurrent — say so if asked. |
| Min stack? | Separate topic — [02-monotonic-patterns.md](02-monotonic-patterns.md). |

---

### Q5. What is the pattern → structure map?

**Points to:** [Foundations · §4 Pattern → structure map](../01-foundations.md#4-pattern--structure-map) · [Deep dive · §1–2 patterns](../02-deep-dive.md#1-stack-deep-dive)

**Answer:**

> Matching/nesting/undo → **stack** (valid parentheses). Next greater/smaller → **monotonic stack**. Level-order/shortest unweighted → **queue** (BFS). Sliding window max → **monotonic deque**. Cycle/middle/reverse/merge → **linked list pointers**. LRU preview → hash + doubly linked list.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Valid parentheses structure? | Stack of opening chars; map closers. |
| Daily temperatures? | Monotonic decreasing stack of indices. |
| Binary tree level order? | Queue drains level by level. |

---

### Q6. Why do interviewers ask stack/queue in iOS rounds?

**Points to:** [Foundations · §5 Why interviewers care](../01-foundations.md#5-why-interviewers-care) · [Production bridge · Honest LL answer](../03-production-bridge.md#3-scripts)

**Answer:**

> To see if you **name structure and complexity before code**, avoid Swift footguns, narrate pointer updates cleanly, and distinguish amortized vs worst-case. Senior line: “I practice these for interviews; in iOS product code I default to Array unless designing something like LRU — I won’t pretend the feed was a linked list.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Bridge to production? | Nav back stack = LIFO; refresh waiters = FIFO queue (soft S4). |
| Force LL into UITableView? | Wrong — Array + honesty. |
| Agenda-first? | 2–3 min plan before typing — every time. |

---

### Q7. What is linked list honesty in Swift apps?

**Points to:** [Foundations · §1 Linked list row](../01-foundations.md#1-plain-english-mental-model) · [Deep dive · §3.1 Why rare in Swift apps](../02-deep-dive.md#31-why-rare-in-swift-apps)

**Answer:**

> Arrays win on cache locality, value semantics, and stdlib algorithms. Linked lists shine for **interview pointer skill**, O(1) splice when you already hold the node, and designs like LRU (dict + node list). Honest senior line: practice LL for interviews; default to Array in product UI unless designing specialized structures.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Interview ListNode? | `final class ListNode { var val; var next }` — reference semantics. |
| UITableView cells? | Array-backed diffable — not linked list nodes. |
| Next topic? | Monotonic patterns — [02-monotonic-patterns.md](02-monotonic-patterns.md). |

---

Next: [02-monotonic-patterns.md](02-monotonic-patterns.md)
