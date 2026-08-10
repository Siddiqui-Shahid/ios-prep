# Sample 07 — Revision Q&A (day-13) (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Each question ends with **How can I relate to my case** using named work — never S-codes.
> Normal ≈ 30–60s · Indirect ≈ 60–90s · Tricky ≈ 90–120s.

---

## Normal questions

### Q1. Stack vs queue in one sentence each? `(30s)`
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

### Q8. Detect cycle — Floyd? `(45–60s)`
**Answer:**

> Floyd: slow moves one step, fast two. If they meet, there’s a cycle. Optionally reset one pointer to head and walk both one step to find the entrance. Time O(n), space O(1). A hash set of visited nodes is simpler but O(n) space.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | If slow and fast meet, a cycle exists; optionally reset one to head and walk together to find the entrance in O(1) space. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q9. Merge two sorted lists? `(45–60s)`
**Answer:**

> I’ll use a dummy head and a tail pointer. While both lists remain, append the smaller node and advance that list. Then attach whichever list remains. Return dummy.next. O(n+m) time, O(1) extra space if we reuse nodes.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | Dummy head avoids special-casing an empty result; attach the remaining non-empty list in one shot after the merge loop. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q10. Middle of linked list? `(30–45s)`
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


## Indirect questions

> These do not name the concept first. Speak from the symptom, scenario, or junior question.

### I1. A junior asks you in standup: “Stack vs queue in one sentence each.?” — how do you answer without jargon? `(60–90s)`
**Answer:**

> “A stack is last-in first-out — push and pop the same end. A queue is first-in first-out — enqueue at the rear, dequeue at the front. A deque allows efficient ops at both ends.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | Stack vs queue in one sentence each. |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### I2. Production symptom: something related to “Implement stack with Array — complexities” just broke under load. What do you check first? `(60–90s)`
**Answer:**

> “I’d wrap an Array: push is append, pop is removeLast, peek is last — all amortized O(1). Random insert or remove in the middle is O(n). Capacity grows geometrically so occasional copies amortize. That’s the default Swift stack.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | Implement stack with Array — complexities |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### I3. Interviewer never names the topic. They describe a mess that maps to “Why is `Array.removeFirst` bad for queues”. How do you diagnose? `(60–90s)`
**Answer:**

> “removeFirst shifts every remaining element, so each dequeue is O(n). That’s fine for tiny or rare queues, but wrong for BFS or hot paths. I’d use a deque, a two-stack queue, a head index with periodic compact, or a ring buffer — and I’d say that cost aloud if I ever use Array naively.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | Why is Array.removeFirst bad for queues |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### I4. Code review: you spot a smell around “Valid parentheses approach”. What do you say and what fix do you propose? `(60–90s)`
**Answer:**

> “I’ll use a stack of opening brackets. For each closer, pop and check it matches via a map; if stack is empty or mismatch, invalid. At the end the stack must be empty. That’s O(n) time and O(n) space. Edges: empty string is valid; a single closer is invalid; interleaved types like ([)] fail correctly because order is checked.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | Valid parentheses approach |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### I5. What happens if a teammate ignores the rule behind “Monotonic stack — when”? `(60–90s)`
**Answer:**

> “I reach for a monotonic stack when I need the next greater or next smaller element for every index in linear time. I keep indices in decreasing or increasing order of values; when the invariant breaks, I pop and record answers. Daily temperatures is the classic — O(n) because each index enters and leaves once.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | Monotonic stack — when |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### I6. Walk me through a failed interview answer on “BFS uses which structure” and how you’d correct it? `(60–90s)`
**Answer:**

> “BFS uses a queue so you expand nodes in the order discovered — level order in trees, shortest path in unweighted graphs. DFS uses a stack or the call stack.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | BFS uses which structure |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### I7. A junior asks you in standup: “Reverse linked list — iterative steps?” — how do you answer without jargon? `(60–90s)`
**Answer:**

> “Iteratively: prev starts nil, curr at head. While curr is non-nil, save next, point curr.next to prev, then advance prev and curr. Return prev as the new head. That’s O(n) time and O(1) space. Recursive reverse is fine for clarity but uses O(n) stack space — I prefer iterative in interviews unless asked otherwise.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | Reverse linked list — iterative steps |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### I8. Production symptom: something related to “Detect cycle — Floyd.” just broke under load. What do you check first? `(60–90s)`
**Answer:**

> “Floyd: slow moves one step, fast two. If they meet, there’s a cycle. Optionally reset one pointer to head and walk both one step to find the entrance. Time O(n), space O(1). A hash set of visited nodes is simpler but O(n) space.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | Detect cycle — Floyd. |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---


## Tricky questions / brain puzzles

> Cover the answer. Speak for ~90–120s. These separate “I read a blog” from “I’ve been burned.”

### T1. They want a one-tool forever answer? `(90–120s)`
**Answer:**

> “I pick a default for the constraint, then name the trade-off and when I’d switch. Senior answers are context-bound, not slogan-bound.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T2. Race vs deadlock — they mix the terms? `(90–120s)`
**Answer:**

> “Race is unsynchronized shared mutation — corruption and Heisenbugs. Deadlock is waiting forever on an order you can’t break. Fix races with a clear exclusion boundary; fix deadlocks by never syncing onto the queue you’re already on.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T3. Main-thread rule under pressure? `(90–120s)`
**Answer:**

> “UI work on main. Heavy parse/decode off main. Hop back with async, not sync from main. If the app freezes, I look for sync-to-self or main-queue overload first.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T4. Cancellation honesty? `(90–120s)`
**Answer:**

> “Cancel in-flight work when the screen goes away. Weak self in completions. Structured tasks cancel children. I don’t claim cancellation if I only nil’d a delegate.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T5. Cache invalidation trap? `(90–120s)`
**Answer:**

> “I define TTL, version keys, and a clear bust path. Stale UI with a spinner is often better than corrupt merge. I say what is source of truth.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T6. Security theater vs real pinning? `(90–120s)`
**Answer:**

> “Pinning without rotation and a kill-switch is how you brick clients. I describe SPKI pins, backup pins, and remote config escape hatches.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T7. SDUI unknown component in prod? `(90–120s)`
**Answer:**

> “Unknown type must degrade — skip, placeholder, or safe fallback — never crash the screen. Schema version and registry discipline matter more than fancy rendering.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T8. DI vs singletons under test? `(90–120s)`
**Answer:**

> “I inject boundaries at the feature edge so tests replace networking and clocks. Global singletons make flaky tests and hidden order dependence.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T9. Prefetch that hurts scrolling? `(90–120s)`
**Answer:**

> “Prefetch without budget causes jank and battery drain. I bound concurrency, cancel off-screen work, and measure with Instruments before calling it a win.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T10. Actor reentrancy surprise? `(90–120s)`
**Answer:**

> “Await inside an actor can interleave other work on that actor. I don’t assume exclusive state across an await without re-checking invariants.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---
