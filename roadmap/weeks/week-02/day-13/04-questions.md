# 04 — Questions (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Each question ends with **How can I relate to my case** using named work — never S-codes.
> Normal ≈ 30–60s · Design ≈ 90–120s · Tricky ≈ 90–120s.

---

## Normal questions

### Q1. Stack vs queue in one sentence each. `(30s)`

**Answer:**

> A stack is last-in first-out — push and pop the same end. A queue is first-in first-out — enqueue at the rear, dequeue at the front. A deque allows efficient ops at both ends.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | Undo stacks are LIFO; printer job queues are FIFO — naming the access pattern beats memorizing library types. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q2. Implement stack with Array — complexities? `(30–45s)`

**Answer:**

> I’d wrap an Array: push is append, pop is removeLast, peek is last — all amortized O(1). Random insert or remove in the middle is O(n). Capacity grows geometrically so occasional copies amortize. That’s the default Swift stack.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | Array-backed stack: append/removeLast are amortized O(1); random middle remove is O(n) and not a stack operation. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q3. Why is `Array.removeFirst` bad for queues? `(30–45s)`

**Answer:**

> removeFirst shifts every remaining element, so each dequeue is O(n). That’s fine for tiny or rare queues, but wrong for BFS or hot paths. I’d use a deque, a two-stack queue, a head index with periodic compact, or a ring buffer — and I’d say that cost aloud if I ever use Array naively.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | BFS on a large graph with Array.removeFirst becomes O(n²) from shifting — use a deque or two-stack queue instead. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q4. Valid parentheses approach? `(45–60s)`

**Answer:**

> I’ll use a stack of opening brackets. For each closer, pop and check it matches via a map; if stack is empty or mismatch, invalid. At the end the stack must be empty. That’s O(n) time and O(n) space. Edges: empty string is valid; a single closer is invalid; interleaved types like ([)] fail correctly because order is checked.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | For ([)] the stack sees mismatch on ] because the top is still (, so order checking catches interleaved types. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q5. Monotonic stack — when? `(45–60s)`

**Answer:**

> I reach for a monotonic stack when I need the next greater or next smaller element for every index in linear time. I keep indices in decreasing or increasing order of values; when the invariant breaks, I pop and record answers. Daily temperatures is the classic — O(n) because each index enters and leaves once.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | Daily temperatures: keep decreasing indices; when a warmer day arrives, pop and fill answers — each index pushes/pops once for O(n). |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q6. BFS uses which structure? `(30s)`

**Answer:**

> BFS uses a queue so you expand nodes in the order discovered — level order in trees, shortest path in unweighted graphs. DFS uses a stack or the call stack.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | Tree level-order and unweighted shortest path both enqueue neighbors — DFS would use a stack or recursion instead. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q7. Reverse linked list — iterative steps? `(60s)`

**Answer:**

> Iteratively: prev starts nil, curr at head. While curr is non-nil, save next, point curr.next to prev, then advance prev and curr. Return prev as the new head. That’s O(n) time and O(1) space. Recursive reverse is fine for clarity but uses O(n) stack space — I prefer iterative in interviews unless asked otherwise.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | After reverse, the old head’s next is nil and prev is the new head — draw three nodes once before coding the pointer dance. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q8. Detect cycle — Floyd. `(45–60s)`

**Answer:**

> Floyd: slow moves one step, fast two. If they meet, there’s a cycle. Optionally reset one pointer to head and walk both one step to find the entrance. Time O(n), space O(1). A hash set of visited nodes is simpler but O(n) space.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | If slow and fast meet, a cycle exists; optionally reset one to head and walk together to find the entrance in O(1) space. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q9. Merge two sorted lists. `(45–60s)`

**Answer:**

> I’ll use a dummy head and a tail pointer. While both lists remain, append the smaller node and advance that list. Then attach whichever list remains. Return dummy.next. O(n+m) time, O(1) extra space if we reuse nodes.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | Dummy head avoids special-casing an empty result; attach the remaining non-empty list in one shot after the merge loop. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q10. Middle of linked list. `(30–45s)`

**Answer:**

> Slow and fast from head; fast moves twice as fast. When fast can’t move, slow is the middle. For even length I’ll state whether I want the lower or upper middle — interviewers care that you noticed.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | When fast hits nil on even length, say whether you want the lower or upper middle — interviewers listen for that clarification. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q11. Agenda you say before coding? `(45s)`

**Answer:**

> I budget two to three minutes: restate and clarify, sketch brute force with complexity, present the optimized structure and why, list edge cases and API shape, then say I’m coding the optimized version. Jumping straight into code loses communication points.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | Say complexities and edge cases before coding — jumping straight into syntax loses communication points even if the code is right. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q12. Array vs linked list in Swift production? `(45s)`

**Answer:**

> In Swift production I default to Array for locality and stdlib ergonomics. Linked lists are mainly an interview skill and occasionally appear in specialized designs like an LRU’s node list. I wouldn’t force a linked list into a UITableView data source just to sound clever.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | Prefer Array in production for locality; treat linked lists as interview tools unless you truly need pointer-based structures like LRU nodes. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

## Tricky questions

## Flashcard strip (quick)

