# 02 — Deep Dive: Patterns, Complexities, Approach Scripts (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Simple language. Named work only — never S-codes in speech.

---

### Q1. Array as stack? `(45–60s)`
**Answer:**

> “swift struct Stack<Element> { private var storage: [Element] = [] mutating func push(_ value: Element) { storage.append(value) } @discardableResult mutating func pop -> Element? { storage.popLast } var peek: Element? { storage.last } var isEmpty: Bool { storage.isEmpty } } Say: append / removeLast are amortized O(1). Capacity doubles geometrically — occasional O(n) copy amortized away.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q2. Valid parentheses (pattern)? `(45–60s)`
**Answer:**

> “Idea: Push opens; on close, pop and match; end empty ⇒ valid. Edges: empty string; only closers; odd length; mixed types[]{}.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q3. Monotonic stack — next greater? `(45–60s)`
**Answer:**

> “Problem shape: For each index, find next greater element to the right (or days until warmer). Idea: Maintain decreasing stack of indices. When current value is greater than stack top’s value, pop and record answer.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q4. Min stack O(1)? `(45–60s)`
**Answer:**

> “Idea: Parallel stack of current mins (or encode diffs). Push/pop/getMin all O(1). Trap: Scanning for min each time → O(n).”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q5. Why Array.removeFirst is wrong by default? `(45–60s)`
**Answer:**

> “removeFirst shifts every element → O(n) per dequeue. Fine for tiny n / rare calls. Wrong for BFS hot paths and interview silence. Alternatives:.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q6. Two-stack queue? `(45–60s)`
**Answer:**

> “- inStack: enqueue via push - outStack: dequeue via pop - When out empty, flush all in → out Each element moves ≤ twice → amortized O(1). Worst-case dequeue O(n) when flushing — say amortized, don’t claim strict O(1) always.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q7. BFS / level order? `(45–60s)`
**Answer:**

> “Queue holds frontier. For trees: while queue not empty, drain level size, push children. Say: “BFS uses a queue; DFS uses a stack or recursion.”.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q8. Hit counter / recent requests? `(45–60s)`
**Answer:**

> “Queue of timestamps; while front older than window, dequeue; count = size. Concurrency (if asked): wrap in an actor — Learning-lab design, not a Verified shipped hit counter.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q9. Circular queue (ring)? `(45–60s)`
**Answer:**

> “Fixed array; head, tail, count (or waste one slot). Indices mod capacity. Empty vs full: with count field, both are unambiguous. Without count, waste one slot so head == tail means empty.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q10. Why rare in Swift apps? `(45–60s)`
**Answer:**

> “Arrays win on cache locality, value semantics, and stdlib algorithms. LL shines for: - Interview pointer skill - O(1) splice when you already hold the node - LRU: dict + doubly linked list of nodes.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q11. Reverse iterative (must-have)? `(45–60s)`
**Answer:**

> “text prev = null, curr = head while curr: next = curr.next curr.next = prev prev = curr curr = next return prev O(n)/O(1). Recursive reverse is O(n) stack — mention depth risk.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q12. Floyd cycle detection? `(45–60s)`
**Answer:**

> “Slow +1, fast +2. Meet ⇒ cycle. Optional phase 2: reset one pointer to head, both +1 → entrance. Hash-set alternative: O(n) space, simpler narration.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q13. Middle of list? `(45–60s)`
**Answer:**

> “Same slow/fast; when fast ends, slow is mid. State even-length policy (lower vs upper mid).”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q14. Merge two sorted lists? `(45–60s)`
**Answer:**

> “Dummy head; append smaller; attach remainder. O(n+m)/O(1) extra.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q15. Reverse k-group (tricky)? `(45–60s)`
**Answer:**

> “1. Count k nodes available 2. If fewer than k, leave as-is 3. Reverse segment 4. Reconnect prev tail → new head; iterate Narrate links; off-by-ones kill this problem.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q16. Universal opener (15s)? `(45–60s)`
**Answer:**

> “Let me restate, confirm constraints, then I’ll give brute, optimize, complexity, and edges before coding.”.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q17. Stack — calculator / expression (if asked)? `(45–60s)`
**Answer:**

> “I’ll clarify operators and precedence. Options: shunting-yard, or two stacks for values and ops. I’ll assume integer ops and left-to-right within same precedence unless you specify. Watch overflow.”.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q18. Queue — design recent counter? `(45–60s)`
**Answer:**

> “I’ll keep a queue of event timestamps, drop anything older than the window, and return the queue’s count. Unbounded growth is the footgun — eviction keeps memory to the window. If concurrent, I’d isolate behind an actor.”.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q19. Linked list — merge k (preview)? `(45–60s)`
**Answer:**

> “Merge two repeatedly is O(kn). Better: min-heap of heads — O(n log k). That’s a Week 4 heap preview; today I’d mention it as the escalation.” Full printable versions: code/ApproachScripts.md.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q20. Trade-offs table? `(45–60s)`
**Answer:**

> “---.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q21. Failure modes / traps? `(45–60s)`
**Answer:**

> “---.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q22. Catch-up ↔ DSA composure (T8 energy)? `(45–60s)`
**Answer:**

> “If interviewer pivots coding → SDUI mid-problem: 1. Park state: “I have prev/curr wired through node 3…” 2. Answer SDUI with versioning + unknown skip (Day 10 / ) 3. Offer to resume coding.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q23. Optional citations (not required)? `(45–60s)`
**Answer:**

> “- Apple Swift Collections Deque docs - CLRS stack/queue chapters (concepts only) - In-repo: coding/dsa-track.md for practice volume after this chapter.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---
