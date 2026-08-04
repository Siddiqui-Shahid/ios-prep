# 04 — Questions (two-layer answers)

> Study flow: cover the full spoken answer → speak from **Answer points** only → uncover and compare timing.  
> Totals: **12 normal + 8 tricky = 20**.

---

## Normal questions

### Q1. Stack vs queue in one sentence each. `(30s)`

**Answer points:**
- Stack = LIFO
- Queue = FIFO
- Optional: deque = both ends

**Agenda opener:** “One sentence each…”

**Full spoken answer:**
> “A stack is last-in first-out — push and pop the same end. A queue is first-in first-out — enqueue at the rear, dequeue at the front. A deque allows efficient ops at both ends.”

**Common wrong answer:** Confusing FIFO/LIFO labels.

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | BFS uses which? | Queue. |
| L2 | Undo uses which? | Stack. |
| L3 | Swift default? | Array as stack; careful as queue. |

**Provenance:** Learning-lab

---

### Q2. Implement stack with Array — complexities? `(30–45s)`

**Answer points:**
- append / removeLast amortized O(1)
- peek O(1)
- middle insert O(n)
- geometric capacity growth

**Full spoken answer:**
> “I’d wrap an Array: push is append, pop is removeLast, peek is last — all amortized O(1). Random insert or remove in the middle is O(n). Capacity grows geometrically so occasional copies amortize. That’s the default Swift stack.”

**Common wrong answer:** “Everything on Array is O(1).”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | pop empty? | Return optional / precondition. |
| L2 | Thread safety? | Array isn’t; isolate if shared. |
| L3 | vs ContiguousArray? | Same idea; Array is fine in interviews. |

**Provenance:** Learning-lab · [code/StackAndQueue.swift](code/StackAndQueue.swift)

---

### Q3. Why is `Array.removeFirst` bad for queues? `(30–45s)`

**Answer points:**
- Shifts all elements → O(n)
- Prefer deque / two-stack / head index / ring
- OK only for tiny n

**Full spoken answer:**
> “removeFirst shifts every remaining element, so each dequeue is O(n). That’s fine for tiny or rare queues, but wrong for BFS or hot paths. I’d use a deque, a two-stack queue, a head index with periodic compact, or a ring buffer — and I’d say that cost aloud if I ever use Array naively.”

**Common wrong answer:** Ignoring the shift cost.

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Two-stack complexity? | Amortized O(1). |
| L2 | Production Swift? | Swift Collections Deque if available. |
| L3 | Bridge? | Refresh waiters ≠ Array.removeFirst. |

**Provenance:** Learning-lab

---

### Q4. Valid parentheses approach? `(45–60s)`

**Answer points:**
- Stack of opens
- Map closers → expected openers
- Empty at end
- O(n)/O(n)
- Edges: only closers, odd length

**Full spoken answer:**
> “I’ll use a stack of opening brackets. For each closer, pop and check it matches via a map; if stack is empty or mismatch, invalid. At the end the stack must be empty. That’s O(n) time and O(n) space. Edges: empty string is valid; a single closer is invalid; interleaved types like ([)] fail correctly because order is checked.”

**Common wrong answer:** Counters only (misses ordering).

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Unicode brackets? | Extend the map. |
| L2 | Early exit? | Odd length can early-fail. |
| L3 | Min remove to valid? | Different problem — stack + counts. |

**Provenance:** Learning-lab · approach script in deep dive

---

### Q5. Monotonic stack — when? `(45–60s)`

**Answer points:**
- Next greater/smaller in O(n)
- Maintain mono increasing/decreasing indices
- Each element push/pop ≤ once

**Full spoken answer:**
> “I reach for a monotonic stack when I need the next greater or next smaller element for every index in linear time. I keep indices in decreasing or increasing order of values; when the invariant breaks, I pop and record answers. Daily temperatures is the classic — O(n) because each index enters and leaves once.”

**Common wrong answer:** O(n²) nested loops without naming the pattern.

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Example? | Daily temperatures. |
| L2 | Window max? | Monotonic deque. |
| L3 | Store values or indices? | Indices usually — need positions. |

**Provenance:** Learning-lab · [code/MonotonicStack.swift](code/MonotonicStack.swift)

---

### Q6. BFS uses which structure? `(30s)`

**Answer points:**
- Queue
- Level-order trees
- Shortest path unweighted graphs
- DFS → stack/recursion

**Full spoken answer:**
> “BFS uses a queue so you expand nodes in the order discovered — level order in trees, shortest path in unweighted graphs. DFS uses a stack or the call stack.”

**Common wrong answer:** “BFS uses a stack.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Level-order code shape? | Drain `count` per level. |
| L2 | Weighted shortest? | Dijkstra / heap — not plain BFS. |
| L3 | Bidirectional BFS? | Two queues when useful. |

**Provenance:** Learning-lab

---

### Q7. Reverse linked list — iterative steps? `(60s)`

**Answer points:**
- prev nil, curr head
- save next, rewire, advance
- return prev
- O(n)/O(1)
- recursive = O(n) stack

**Full spoken answer:**
> “Iteratively: prev starts nil, curr at head. While curr is non-nil, save next, point curr.next to prev, then advance prev and curr. Return prev as the new head. That’s O(n) time and O(1) space. Recursive reverse is fine for clarity but uses O(n) stack space — I prefer iterative in interviews unless asked otherwise.”

**Common wrong answer:** Losing `next` and orphaning the rest of the list.

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Empty list? | Return nil. |
| L2 | Reverse m…n? | Find window, reverse segment, reconnect. |
| L3 | k-group? | Count, reverse, reconnect. |

**Provenance:** Learning-lab · [code/LinkedListAlgos.swift](code/LinkedListAlgos.swift)

---

### Q8. Detect cycle — Floyd. `(45–60s)`

**Answer points:**
- Slow +1, fast +2
- Meet ⇒ cycle
- Optional entrance phase
- O(n)/O(1)
- Hash set alternative O(n) space

**Full spoken answer:**
> “Floyd: slow moves one step, fast two. If they meet, there’s a cycle. Optionally reset one pointer to head and walk both one step to find the entrance. Time O(n), space O(1). A hash set of visited nodes is simpler but O(n) space.”

**Common wrong answer:** Only knowing the hash-set approach.

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | No cycle exit? | Fast hits nil. |
| L2 | Why meeting implies cycle? | Fast gains in a loop. |
| L3 | Find entrance proof? | Sketch tortoise-hare math briefly. |

**Provenance:** Learning-lab

---

### Q9. Merge two sorted lists. `(45–60s)`

**Answer points:**
- Dummy head
- Append smaller
- Attach remainder
- O(n+m)/O(1) extra

**Full spoken answer:**
> “I’ll use a dummy head and a tail pointer. While both lists remain, append the smaller node and advance that list. Then attach whichever list remains. Return dummy.next. O(n+m) time, O(1) extra space if we reuse nodes.”

**Common wrong answer:** Forgetting null remainders or mutating without dummy (messy head cases).

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | New nodes vs reuse? | Reuse in-place for O(1) extra. |
| L2 | Merge k? | Heap of heads — Week 4 preview. |
| L3 | Stable merge? | Equal keys — pick policy. |

**Provenance:** Learning-lab

---

### Q10. Middle of linked list. `(30–45s)`

**Answer points:**
- Slow/fast
- Fast ends → slow mid
- State even-length policy

**Full spoken answer:**
> “Slow and fast from head; fast moves twice as fast. When fast can’t move, slow is the middle. For even length I’ll state whether I want the lower or upper middle — interviewers care that you noticed.”

**Common wrong answer:** Counting length in two passes without mentioning two-pointer option.

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Delete middle? | Find mid, relink. |
| L2 | Palindrome list? | Mid + reverse second half. |
| L3 | — | — |

**Provenance:** Learning-lab

---

### Q11. Agenda you say before coding? `(45s)`

**Answer points:**
- Restate → clarify → brute → optimize → complexity → edges → code
- Budget 2–3 min
- Timing guide

**Full spoken answer:**
> “I budget two to three minutes: restate and clarify, sketch brute force with complexity, present the optimized structure and why, list edge cases and API shape, then say I’m coding the optimized version. Jumping straight into code loses communication points.”

**Common wrong answer:** Silent coding from the first second.

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Ran long on approach? | Cut examples; keep structure+complexity. |
| L2 | Stuck mid-code? | Revert to agenda; restate invariant. |
| L3 | Peer mock tip? | Record approach separately. |

**Provenance:** Learning-lab · timing guide coding budget

---

### Q12. Array vs linked list in Swift production? `(45s)`

**Answer points:**
- Array locality + ergonomics
- LL for interview pointers / rare LRU nodes
- Don’t force LL into UI lists

**Full spoken answer:**
> “In Swift production I default to Array for locality and stdlib ergonomics. Linked lists are mainly an interview skill and occasionally appear in specialized designs like an LRU’s node list. I wouldn’t force a linked list into a UITableView data source just to sound clever.”

**Common wrong answer:** “Never learn linked lists” or “always use linked lists for queues.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | LRU shape? | Dict + DLL. |
| L2 | Value vs ref nodes? | class ListNode for mutability. |
| L3 | COW Array queue? | Still O(n) removeFirst. |

**Provenance:** Learning-lab honesty

---

## Tricky questions

### T1. Implement a queue with two stacks. `(90–120s)`

**Trap:** Claiming strict O(1) every dequeue.

**Answer points:**
- in for enqueue, out for dequeue
- flush in→out when out empty
- amortized O(1)
- state worst-case flush

**Full spoken answer:**
> “Enqueue pushes onto an in-stack. Dequeue pops from an out-stack; if out is empty, I pour all of in into out, then pop. Each element moves at most twice, so amortized O(1). A single dequeue can be O(n) during a flush — I say amortized so I’m precise. Empty dequeue should return nil or throw consistently.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | peek? | Same as dequeue without remove; flush if needed. |
| L2 | Thread safety? | Not inherent — wrap if shared. |
| L3 | vs ring? | Ring needs fixed capacity. |

**Provenance:** Learning-lab · [code/TwoStackQueue.swift](code/TwoStackQueue.swift)

---

### T2. Min stack in O(1). `(90–120s)`

**Trap:** Scanning stack each getMin.

**Answer points:**
- Aux min stack (or encode diffs)
- Push/pop/getMin O(1)
- Duplicate mins pushed again

**Full spoken answer:**
> “I’ll keep the value stack plus an auxiliary stack of minima. On push, push onto mins if value ≤ current min. On pop, if popped equals min top, pop mins too. getMin is mins.peek — all O(1). Duplicates matter: when the new value equals min, push it again so one pop doesn’t lose the min.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Space? | O(n) worst case. |
| L2 | Encode diffs? | Possible; more error-prone — mention. |
| L3 | Max stack? | Symmetric. |

**Provenance:** Learning-lab · [code/MinStack.swift](code/MinStack.swift)

---

### T3. Design hit counter / recent requests queue. `(120s)`

**Trap:** Unbounded memory; ignoring concurrency.

**Answer points:**
- Queue of timestamps
- Evict older than window
- count = size
- actor if concurrent

**Full spoken answer:**
> “I’d store timestamps in a queue. On hit, enqueue now; while the front is older than the window, dequeue. The count is the queue’s size — memory stays proportional to hits in the window. If multiple threads call in, I’d isolate behind an actor. In production analytics I’d also budget cardinality and sampling — unbounded raw event queues are dangerous.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Window 5 minutes? | Compare `now - t ≥ window`. |
| L2 | Persist? | Usually in-memory for this problem. |
| L3 | Prod bridge? | Soft — not a Verified BMS metric. |

**Provenance:** Learning-lab

---

### T4. Reverse nodes in k-group. `(120s)`

**Trap:** Off-by-one; reversing leftover < k.

**Answer points:**
- Count k available
- Reverse segment
- Reconnect
- Leave remainder
- O(n)/O(1)

**Full spoken answer:**
> “I’ll walk counting k nodes. If fewer than k remain, leave them. Otherwise reverse that segment, reconnect the previous group’s tail to the new head, and continue. Narrating the pointers matters more than cleverness — leftover nodes stay in original order. O(n) time, O(1) extra space iterative.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | k = 1? | No-op. |
| L2 | k > length? | Leave whole list. |
| L3 | Recursive? | OK if stack discussed. |

**Provenance:** Learning-lab

---

### T5. Why linked lists rarely appear in your iOS code? `(90s)`

**Trap:** Sounding anti-DSA.

**Answer points:**
- Array locality + Swift ergonomics
- LL for interviews + LRU-like designs
- Still practice pointers

**Full spoken answer:**
> “Because Swift Array wins on cache locality and API surface for UI and model lists. Linked lists excel in interview pointer problems and in designs like LRU where you need O(1) move-to-front given a node. I practice them seriously for machine rounds — I just don’t force them into UITableView data sources.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Ever use LL? | LRU design interviews; teaching. |
| L2 | Queue in prod? | Deque / actor mailbox, not ListNode. |
| L3 | — | — |

**Provenance:** Learning-lab honesty

---

### T6. Circular queue with fixed array. `(90–120s)`

**Trap:** Empty/full ambiguity.

**Answer points:**
- head/tail mod capacity
- count field OR waste one slot
- ring buffer language
- S12 adjacency only — don’t overclaim audio

**Full spoken answer:**
> “I’d allocate a fixed buffer with head, tail, and a count — enqueue writes at tail, dequeue reads at head, both indices mod capacity. Count distinguishes empty from full cleanly. Alternatively waste one slot so head==tail means empty. This is the ring-buffer pattern. I’ll use the vocabulary carefully around media — I’m not claiming Aces audio was my custom ring implementation.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Threaded producer/consumer? | Need sync or actor. |
| L2 | Overwrite policy? | Block vs drop oldest — product choice. |
| L3 | — | — |

**Provenance:** Learning-lab · S12 adjacency vocabulary only

---

### T7. Stack for calculator / expression. `(120s)`

**Trap:** Coding without grammar/precedence.

**Answer points:**
- Clarify operators/precedence
- Two stacks or shunting-yard
- State assumptions
- Overflow

**Full spoken answer:**
> “First I’d clarify the grammar — which operators, precedence, associativity, integers only or not. Then either shunting-yard to RPN, or a values stack plus an operators stack. I’ll state assumptions before coding and mention integer overflow. Diving into code without the grammar is how calculator problems implode.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Parentheses? | Ops stack handles with higher precedence rules. |
| L2 | Unary minus? | Call it out as a tokenisation issue. |
| L3 | — | — |

**Provenance:** Learning-lab

---

### T8. Interviewer pivots coding → SDUI mid-way. `(90s)`

**Trap:** Freeze or abandon the code silently.

**Answer points:**
- Park pointer state verbally
- Answer SDUI: versioning + unknown skip
- Offer to resume
- Composure (S8 energy)

**Full spoken answer:**
> “I’d park the code state out loud — for example, I’ve rewired through node three and next is saved — then answer the SDUI question with schema versioning and fail-soft unknown-component skip from our backend-driven header work. Then I’d ask whether to resume the list reverse. That composure matters as much as the algorithm.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | SDUI one-liner? | Fetch → version → registry → fallback. |
| L2 | Story? | S3 header; don’t invent metrics. |
| L3 | Mock #2? | Same composure for 5-min talks. |

**Provenance:** Learning-lab composure · Verified · S3 for SDUI content · S8 energy

---

## Flashcard strip (quick)

| Front | Back |
|---|---|
| removeFirst queue | O(n) shift |
| Two-stack dequeue | Amortized O(1) |
| Monotonic stack | Next greater O(n) |
| Floyd | Slow/fast O(1) space |
| Reverse list | Three pointers |
| Coding agenda | Restate→brute→optimize→edges→code |

Revision twin for skeleton recall: [../../../revision/weeks/week-02/day-13.md](../../../revision/weeks/week-02/day-13.md)
