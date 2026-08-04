# 02 — Deep Dive: Patterns, Complexities, Approach Scripts

> Senior depth. Self-contained — patterns are taught here; you do not need to leave Cursor to learn them. Optional LeetCode reps are practice, not prerequisites.

## 1. Stack deep dive

### 1.1 Array as stack

```swift
struct Stack<Element> {
    private var storage: [Element] = []
    mutating func push(_ value: Element) { storage.append(value) }
    @discardableResult
    mutating func pop() -> Element? { storage.popLast() }
    var peek: Element? { storage.last }
    var isEmpty: Bool { storage.isEmpty }
}
```

**Say:** `append` / `removeLast` are amortized O(1). Capacity doubles geometrically — occasional O(n) copy amortized away.

### 1.2 Valid parentheses (pattern)

**Idea:** Push opens; on close, pop and match; end empty ⇒ valid.

**Edges:** empty string; only closers; odd length; mixed types `()[]{}`.

**Complexity:** O(n) time, O(n) space.

**Approach script (speak ~90s before code):**

> “I’ll clarify which bracket pairs count. Brute would scan with counters but fails on ordering — `([)]`. Optimized: stack of opening chars; map closers to expected openers. On close, if stack empty or mismatch, false. At end stack must be empty. O(n)/O(n). Edges: empty → true; single closer → false. I’ll code that.”

### 1.3 Monotonic stack — next greater

**Problem shape:** For each index, find next greater element to the right (or days until warmer).

**Idea:** Maintain decreasing stack of **indices**. When current value is greater than stack top’s value, pop and record answer.

**Complexity:** Each index pushed/popped ≤ once → O(n).

**Approach script:**

> “Brute is O(n²) nested scan. I’ll use a monotonic decreasing stack of indices. Walking left to right, while current is greater than `T[stack.top]`, pop and set days = i − idx. Push i. Leftovers get 0. O(n)/O(n).”

Worked Swift: [code/MonotonicStack.swift](code/MonotonicStack.swift).

### 1.4 Min stack O(1)

**Idea:** Parallel stack of current mins (or encode diffs). Push/pop/getMin all O(1).

**Trap:** Scanning for min each time → O(n).

**Duplicates:** Push min again when equal so pop stays correct.

Worked Swift: [code/MinStack.swift](code/MinStack.swift).

---

## 2. Queue deep dive

### 2.1 Why Array.removeFirst is wrong by default

`removeFirst()` shifts every element → **O(n)** per dequeue. Fine for tiny n / rare calls. Wrong for BFS hot paths and interview silence.

**Alternatives:**

| Approach | Dequeue | Notes |
|---|---|---|
| Two-stack queue | Amortized O(1) | Classic interview |
| Head index + Array | Amortized O(1) with compact | Simple |
| Ring buffer | O(1) | Fixed capacity; empty/full via count or waste slot |
| Swift Collections `Deque` | O(1) | Production-friendly if dependency OK |

### 2.2 Two-stack queue

- **inStack:** enqueue via push  
- **outStack:** dequeue via pop  
- When out empty, **flush** all in → out  

Each element moves ≤ twice → amortized O(1). Worst-case dequeue O(n) when flushing — **say amortized**, don’t claim strict O(1) always.

Worked Swift: [code/TwoStackQueue.swift](code/TwoStackQueue.swift).

**Approach script:**

> “I’ll implement FIFO with two stacks. Enqueue pushes to in. Dequeue: if out empty, pour in→out, then pop out. Amortized O(1). I’ll state worst-case flush cost so we’re precise.”

### 2.3 BFS / level order

Queue holds frontier. For trees: while queue not empty, drain level size, push children.

**Say:** “BFS uses a queue; DFS uses a stack or recursion.”

### 2.4 Hit counter / recent requests

Queue of timestamps; while front older than window, dequeue; count = size.

**Concurrency (if asked):** wrap in an `actor` — Learning-lab design, not a Verified shipped hit counter.

### 2.5 Circular queue (ring)

Fixed array; `head`, `tail`, `count` (or waste one slot). Indices mod capacity.

**Empty vs full:** with `count` field, both are unambiguous. Without count, waste one slot so `head == tail` means empty.

**S12 adjacency only:** ring buffers appear in audio/streaming mental models — do **not** claim you shipped Aces as a custom ring-buffer engine.

---

## 3. Linked list deep dive

### 3.1 Why rare in Swift apps

Arrays win on cache locality, value semantics, and stdlib algorithms. LL shines for:

- Interview pointer skill  
- O(1) splice when you **already hold the node**  
- LRU: dict + doubly linked list of nodes  

**Honest senior line:** “I practice LL for interviews; in iOS product code I default to Array unless I’m designing something like an LRU.”

### 3.2 Reverse iterative (must-have)

```text
prev = null, curr = head
while curr:
  next = curr.next
  curr.next = prev
  prev = curr
  curr = next
return prev
```

O(n)/O(1). Recursive reverse is O(n) stack — mention depth risk.

Worked Swift: [code/LinkedListAlgos.swift](code/LinkedListAlgos.swift).

**Approach script:**

> “I’ll reverse iteratively with three pointers so space is O(1). Careful to save `next` before rewiring. Empty and single-node are no-ops. Recursive is elegant but O(n) call stack — I’ll stick to iterative unless you prefer recursion.”

### 3.3 Floyd cycle detection

Slow +1, fast +2. Meet ⇒ cycle. Optional phase 2: reset one pointer to head, both +1 → entrance.

Hash-set alternative: O(n) space, simpler narration.

### 3.4 Middle of list

Same slow/fast; when fast ends, slow is mid. **State even-length policy** (lower vs upper mid).

### 3.5 Merge two sorted lists

Dummy head; append smaller; attach remainder. O(n+m)/O(1) extra.

### 3.6 Reverse k-group (tricky)

1. Count k nodes available  
2. If fewer than k, leave as-is  
3. Reverse segment  
4. Reconnect prev tail → new head; iterate  

Narrate links; off-by-ones kill this problem.

---

## 4. Approach scripts bank (embed — speak these)

### Universal opener (15s)

> “Let me restate, confirm constraints, then I’ll give brute, optimize, complexity, and edges before coding.”

### Stack — calculator / expression (if asked)

> “I’ll clarify operators and precedence. Options: shunting-yard, or two stacks for values and ops. I’ll assume integer ops and left-to-right within same precedence unless you specify. Watch overflow.”

### Queue — design recent counter

> “I’ll keep a queue of event timestamps, drop anything older than the window, and return the queue’s count. Unbounded growth is the footgun — eviction keeps memory to the window. If concurrent, I’d isolate behind an actor.”

### Linked list — merge k (preview)

> “Merge two repeatedly is O(kn). Better: min-heap of heads — O(n log k). That’s a Week 4 heap preview; today I’d mention it as the escalation.”

Full printable versions: [code/ApproachScripts.md](code/ApproachScripts.md).

---

## 5. Trade-offs table

| Choice | When | Cost |
|---|---|---|
| Array stack | Default | Fine |
| Array queue via removeFirst | Tiny n | O(n) dequeue |
| Two-stack queue | Interview FIFO | Extra code; amortized story |
| Ring buffer | Fixed capacity / audio-ish | Empty/full bookkeeping |
| Linked list algos | Interview | Poor locality in real Swift UI |
| Recursive reverse | Short lists / clarity | Stack overflow on long lists |
| Hash cycle detect | Simpler talk | O(n) space |
| Monotonic stack | Next greater family | Must memorize invariant |

---

## 6. Failure modes / traps

| Trap | Fix |
|---|---|
| Code immediately | Agenda 2–3 min first |
| Claim two-stack dequeue always O(1) | Say **amortized** |
| Lose `next` while reversing | Save next before rewrite |
| Even-length mid ambiguity | State policy aloud |
| k-group leftover reversed | Leave remainder intact |
| Use stack for BFS | Queue for BFS |
| Force LL into UITableView | Array + honesty |

---

## 7. Catch-up ↔ DSA composure (T8 energy)

If interviewer pivots coding → SDUI mid-problem:

1. Park state: “I have prev/curr wired through node 3…”  
2. Answer SDUI with versioning + unknown skip (Day 10 / S3)  
3. Offer to resume coding  

Shows composure (S8 IMOC energy without overclaiming).

---

## 8. Optional citations (not required)

- Apple Swift Collections `Deque` docs  
- CLRS stack/queue chapters (concepts only)  
- In-repo: [coding/dsa-track.md](../../../coding/dsa-track.md) for practice volume after this chapter
