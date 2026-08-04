# 01 — Foundations: Stack, Queue, Linked List

> Read this before the deep dive. Goal: an intern-clear mental model, then senior vocabulary.

## 1. Plain-English mental model

Three ways to arrange work:

| Structure | Rule | Kitchen metaphor |
|---|---|---|
| **Stack** | Last in, first out (LIFO) | Plates — take from the top |
| **Queue** | First in, first out (FIFO) | Ticket line — serve the front |
| **Deque** | Push/pop both ends | Double door — either side |
| **Linked list** | Nodes + pointers | Chain of sticky notes — cheap local splice, slow random access |

**Swift production honesty:** You almost always reach for `Array` (and sometimes Swift Collections `Deque`). Linked lists show up in **interview pointer problems** and specialized designs (LRU node list), not in everyday UIKit lists.

## 2. Glossary (learn these cold)

| Term | Meaning |
|---|---|
| **LIFO** | Last in, first out — stack |
| **FIFO** | First in, first out — queue |
| **push / pop / peek** | Stack insert / remove / look at top |
| **enqueue / dequeue** | Queue insert rear / remove front |
| **Amortized O(1)** | Cheap on average across many ops (e.g. Array growth, two-stack queue) |
| **Monotonic stack** | Stack kept strictly increasing or decreasing to answer “next greater/smaller” in O(n) |
| **BFS** | Breadth-first search — explore level by level using a **queue** |
| **DFS** | Depth-first — stack or recursion |
| **Dummy head** | Sentinel node before the real head to simplify merge/insert edge cases |
| **Floyd cycle** | Slow/fast pointers; meeting ⇒ cycle |
| **ListNode** | Interview class with `val` + `next` (reference semantics) |
| **Ring / circular buffer** | Fixed array with head/tail indices mod capacity |
| **Agenda-first coding** | 2–3 min spoken plan before typing |

## 3. Complexity cheat-sheet (say aloud)

| Structure | Op | Typical |
|---|---|---|
| Array as stack | `append` / `removeLast` | Amortized O(1) |
| Array as queue | `removeFirst` | **O(n)** — shifts |
| Two-stack queue | enqueue / dequeue | **Amortized** O(1) |
| Deque / ring | ends | O(1) |
| Linked list | insert/delete **given node** | O(1) local |
| Linked list | access by index | O(n) |
| Reverse list iterative | — | O(n) time, O(1) space |
| Floyd | — | O(n) time, O(1) space |

## 4. Pattern → structure map

| Pattern | Structure | Canonical problem |
|---|---|---|
| Matching / nesting / undo | Stack | Valid parentheses |
| Next greater / smaller | Monotonic stack | Daily temperatures |
| Level-order / shortest unweighted | Queue | Binary tree level order |
| Sliding window max | Monotonic deque | Max in window |
| Cycle / middle / reverse / merge | Linked list pointers | Floyd, reverse, merge two lists |
| LRU (preview) | Hash + doubly linked list | Cache design |

## 5. Why interviewers care

A senior coding answer proves you can:

- **Name the structure** and **complexity before code**
- Avoid Swift footguns (`removeFirst` as queue)
- Narrate pointer updates without losing `next`
- Distinguish amortized vs worst-case for two-stack queue / Array growth
- Bridge lightly to production (nav stack, refresh waiters) without fake claims

## 6. Coding approach budget (2–3 min) — memorize

Say this every time:

1. **Restate** + 1–2 clarifying questions (constraints, duplicates, empty input)
2. **Brute** + complexity
3. **Optimize** + why this structure
4. **Edges** + API shape (`ListNode?`, mutating vs new list)
5. “I’ll code the optimized version now.”

Full scripts live in [02-deep-dive.md](02-deep-dive.md) § Approach scripts and [code/ApproachScripts.md](code/ApproachScripts.md).

## 7. Swift defaults (interview)

```swift
// Stack — default
var stack: [Int] = []
stack.append(1)        // push
let top = stack.removeLast() // pop

// Queue — do NOT hot-path removeFirst without calling it out
// Prefer two-stack queue, Deque, or head-index ring — see code/

// Linked list — interview node
final class ListNode {
    var val: Int
    var next: ListNode?
    init(_ val: Int, _ next: ListNode? = nil) {
        self.val = val
        self.next = next
    }
}
```

## 8. Week 2 catch-up (don’t skip Mock #2 prep)

| If weak on… | Catch-up (45–60m) |
|---|---|
| MVVM / Clean / DI | Day 08 Qs + S9 opener |
| Networking / refresh / pin | Day 09 T1/T3 + S4 opener |
| SDUI versioning / fallback | Day 10 + S3 opener |
| Hybrid lifecycle | Day 11 + S13 opener |
| SwiftUI identity | Day 12 + S10 opener |

Pick **one** weak day. Still finish today’s timed DSA drill.

## 9. Checkpoint

Before deep dive, say without notes:

1. Stack vs queue in one sentence each  
2. Why `Array.removeFirst` is a bad default queue  
3. The 2–3 min coding agenda sequence  

Then open [02-deep-dive.md](02-deep-dive.md).
