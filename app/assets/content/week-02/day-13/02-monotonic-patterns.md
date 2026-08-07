# Sample 02 — Monotonic patterns & queues (Q&A)

> Guided teaching. Each answer stands alone and ends with **How can I relate to my case** using named work — never S-codes.

---

### Q1. How does valid parentheses work on a stack?

**Answer:**

> Push opening brackets. On a closer, pop and check it matches the expected opener. End with empty stack ⇒ valid. Brute force with counters fails on ordering — `([)]`. Complexity: **O(n) time, O(n) space**. Edges: empty string → true; only closers → false; odd length → false; mixed types `()[]{}`.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Approach script opener? | Clarify bracket pairs → brute ordering failure → stack map → O(n)/O(n) → edges → code. |
| Undo/redo cousin? | Stack of states — same LIFO discipline. |
| Nested CMS JSON? | Different problem — still “matching/nesting” instinct. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q2. What is a monotonic stack?

**Answer:**

> A stack kept strictly increasing or decreasing to answer “next greater/smaller” in **O(n)**. For daily temperatures: maintain a **decreasing stack of indices**. Walk left to right; while current value is greater than `T[stack.top]`, pop and set answer = i − idx. Push i. Leftovers get 0. Each index pushed/popped at most once.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Brute? | O(n²) nested scan — name it then optimize. |
| Store indices vs values? | Indices — needed for distance/day counts. |
| Sliding window max? | Monotonic **deque** — different container, same invariant idea. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q3. How does min stack achieve O(1) getMin?

**Answer:**

> Parallel stack of current minimums, or encode diffs between value and current min. Push/pop/getMin all **O(1)**. Trap: scanning for min each pop → O(n). **Duplicates:** push min again when equal so pop stays correct — otherwise min stack loses track after pop.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Space cost? | O(n) extra for min stack — trade for O(1) query. |
| Interview variant? | Max stack — symmetric. |
| Production use? | Learning-lab — honest about interview focus. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q4. How does the two-stack queue work?

**Answer:**

> **inStack:** enqueue via push. **outStack:** dequeue via pop. When out is empty, **flush** all elements from in → out (reverse order restores FIFO). Each element moves at most twice → **amortized O(1)**. Worst-case single dequeue can be O(n) when flushing — say **amortized**, not strict O(1) always.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Approach script? | Enqueue push in; dequeue pour if out empty then pop out; state amortized story. |
| vs ring buffer? | Ring: fixed capacity O(1); two-stack: dynamic, classic interview. |
| vs Deque? | Deque is production-friendly; two-stack is interview canonical. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q5. When do I use a queue for BFS?

**Answer:**

> Queue holds the frontier. For trees: while queue not empty, drain **level size**, enqueue children. Shortest path in unweighted graphs uses BFS — queue, not stack. Say aloud: “BFS uses a queue; DFS uses a stack or recursion.” Using stack for BFS is a common trap.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Level-order output? | Collect each level during drain loop. |
| Graph cycles? | Track visited — queue alone isn’t enough. |
| Hit counter / recent requests? | Queue of timestamps; drop older than window. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q6. What is a circular queue (ring buffer)?

**Answer:**

> Fixed array with `head`, `tail`, and `count` (or waste one slot). Indices mod capacity. Empty vs full: with a **count** field, both are unambiguous; without count, waste one slot so `head == tail` means empty. O(1) enqueue/dequeue at ends when capacity fixed.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Audio streaming + server-driven splash (Aces) adjacency? | Ring language adjacent to media buffering — **do not** claim you shipped Aces as custom ring engine. |
| vs two-stack? | Ring: bounded capacity; two-stack: dynamic interview FIFO. |
| Full when? | count == capacity — reject or overwrite per spec. |

**How can I relate to my case:**
- **Shipped:** Audio streaming + server-driven splash (Aces)
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q7. What failure modes hit stack/queue problems?

**Answer:**

> Code immediately without agenda. Claim two-stack dequeue is always O(1) — say **amortized**. Use stack for BFS. Use Array removeFirst silently on hot path. Lose `next` while reversing linked list — separate file. Force linked list into UITableView — Array + honesty.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Agenda budget? | 2–3 min: restate, brute, optimize, edges, then code. |
| Concurrency on hit counter? | Actor wrapper — Learning-lab if asked. |
| Next topic? | Linked list algos — [03-linked-list-algos.md](03-linked-list-algos.md). |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

Next: [03-linked-list-algos.md](03-linked-list-algos.md)

---

