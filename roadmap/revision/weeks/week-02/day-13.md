# Day 13 — DSA: Stack / Queue / Linked List + Catch-up

> **Full chapter:** [`weeks/week-02/day-13/`](../../../weeks/week-02/day-13/) · Revision twin — timed recall only after the full study.

> Week 2 · Phase: Architecture, networking, SDUI, UI · Time budget today: ~5–6 hrs (weekend-style volume)

## 1. Outcome

By end of day you can explain aloud (no notes):

- When to reach for **Stack**, **Queue** / **Deque**, and **Linked List** (and when arrays beat linked lists in Swift)
- Complexities for push/pop/enqueue/dequeue and classic patterns (monotonic stack, BFS queue, fast/slow pointers)
- A crisp **agenda-first** coding approach (2–3 min) before typing Swift
- What Week 2 theory you still owe — and a catch-up plan without dropping Mock #2 prep

**Track index:** [coding/dsa-track.md](../../coding/dsa-track.md)

## 2. Concept deep dive

### 2.1 Structure cheat-sheet

| Structure | Ordered ops | Amortized / typical | Swift go-to |
|---|---|---|---|
| **Stack** LIFO | push/pop/peek | O(1) | `Array` append/removeLast |
| **Queue** FIFO | enqueue/dequeue | O(1) ideal | `Array` dequeue is O(n) — prefer `Deque` / ring / two-stack queue |
| **Deque** | ends both sides | O(1) | Swift Collections `Deque` or manual |
| **Linked list** | insert/delete given node | O(1) local | Rare in Swift interviews vs arrays; know algorithms |

**Interview honesty:** In Swift production, `Array` dominates. Still implement linked-list **algorithms** (reverse, cycle, merge) on `ListNode`.

### 2.2 Pattern → structure

| Pattern | Structure | Examples |
|---|---|---|
| Matching / nesting / undo | Stack | Valid parentheses, calc, decode string |
| Next greater / smaller | Monotonic stack | Daily temperatures, stock span |
| Level-order / BFS | Queue | Binary tree level order (preview Week 4) |
| Sliding window max (deque) | Deque | Max in window |
| Cycle / middle / reverse | Linked list pointers | Floyd, reverse list, merge two lists |
| LRU (preview) | Hash + DLL | Cache design |

### 2.3 Complexity lines to say first

Before coding: “I’ll use a stack for LIFO matching — O(n) time, O(n) space worst case.”  
Or: “Two pointers on linked list — O(n) time, O(1) space.”

### 2.4 Swift pitfalls

- `removeFirst()` on `Array` is **O(n)** — don’t build queues that way in hot paths without noting it.
- Class `ListNode` reference semantics — careful aliasing in reverse.
- Prefer iterative reverse in interviews unless recursion depth discussed.

### 2.5 Catch-up (Week 2)

Use this day to close gaps from Days 08–12:

| If weak on… | Catch-up block (45–60m) |
|---|---|
| MVVM/Clean/DI | Re-drill Day 08 Q5, Q8, T1 + S9 opener |
| Networking/refresh/pinning | Day 09 T1, T3 + skim networking-layer.md sequence |
| SDUI versioning/fallback | Day 10 Q3–Q4 + S3 opener |
| Hybrid lifecycle | Day 11 Q7 + S13 opener |
| SwiftUI identity | Day 12 T1 + S10 opener |

Do **not** skip section 9 timed DSA drill — Mock #4 coding depends on reps.

### 2.6 Trade-offs

| Choice | When | Cost |
|---|---|---|
| Array as stack | Default | Fine |
| Array as queue | Tiny n | O(n) dequeue |
| Two-stack queue | Interview FIFO | Extra code |
| Linked list | Pointer problems | Poor cache locality in real Swift |
| Recursion on list | Elegant reverse | Stack overflow risk on long lists |

## 3. Read these

| Priority | Resource | Why |
|---|---|---|
| Must | [coding/dsa-track.md](../../coding/dsa-track.md) | Master list + machine-round mapping |
| Must | [timing/answer-timing-guide.md](../../timing/answer-timing-guide.md) (coding approach budget) | 2–3 min plan before code |
| Deepen | LeetCode Explore: Stack/Queue · Linked List | Guided reps |
| Repo | Week 2 days 08–12 for catch-up links | Fill theory holes |

## 4. Map to your work

DSA days are mostly pattern training — still **bridge to production** when interviewers ask “have you used this?”

| Structure | Production bridge (honest, metric-safe) |
|---|---|
| Queue | Serialise work / token refresh waiters (Day 09 single-flight queue of waiters) |
| Stack | Nav back stacks; undo; nested CMS layout resolve (parent stack) |
| Linked list mentally | Not common in Swift UI — speak to pointer problems as interview skill; caches/LRU later |

**Story links (light touch today):**  
- Refresh waiters / in-flight management → [S4](../../stories/story-bank.md)#s4--ssl-pinning--alamofire--urlsession-bookmyshow mindset + Day 09  
- Nested UI / nav → [S6](../../stories/story-bank.md)#s6--le-bottom-sheet-bookmyshow · [S13](../../stories/story-bank.md)#s13--swiftuiuikit--deeplinks--analyticspush-raw--memphis-grizzlies  

**Interview line (≤20s):** “For coding I’ll state structure + complexity first — e.g. monotonic stack O(n) — then code clean Swift; I use queues in networking refresh coalescing similarly.”

## 5. Normal questions

For each: answer out loud within the time. Skeleton only — expand from memory.

### Q1. Stack vs queue in one sentence each. `(30s)`
**Skeleton:** Stack LIFO; queue FIFO.  
**Follow-up:** Deque? → Both ends.  
**Story:** —

### Q2. Implement stack with array — ops complexity? `(30–45s)`
**Skeleton:** append/removeLast O(1) amortized; random insert O(n).  
**Follow-up:** Capacity growth? → Geometric resize amortized.  
**Story:** —

### Q3. Why is `Array.removeFirst` bad for queues? `(30–45s)`
**Skeleton:** Shifts all elements O(n). Use deque, linked list, or two-stack, or head index with periodic compact.  
**Follow-up:** When OK? → Tiny n, rare calls.  
**Story:** —

### Q4. Valid parentheses approach? `(45–60s)`
**Skeleton:** Stack of opens; on close check match; empty at end. O(n)/O(n). Edge: odd length, only closers.  
**Follow-up:** Unicode brackets? → Map table.  
**Story:** —

### Q5. Monotonic stack — when? `(45–60s)`
**Skeleton:** Next greater/smaller in O(n). Maintain increasing/decreasing stack of indices.  
**Follow-up:** Example: daily temperatures.  
**Story:** —

### Q6. BFS uses which structure? `(30s)`
**Skeleton:** Queue. Level-order trees; shortest path in unweighted graphs.  
**Follow-up:** DFS? → Stack/recursion.  
**Story:** —

### Q7. Reverse linked list — iterative steps? `(60s)`
**Skeleton:** prev=null, curr=head; while curr: next=curr.next; curr.next=prev; prev=curr; curr=next; return prev. O(n)/O(1).  
**Follow-up:** Recursive? → O(n) stack space.  
**Story:** —

### Q8. Detect cycle — Floyd. `(45–60s)`
**Skeleton:** Slow/fast pointers; meet ⇒ cycle. Optional reset to find entrance. O(n)/O(1).  
**Follow-up:** Hash set alternative? → O(n) space simpler.  
**Story:** —

### Q9. Merge two sorted lists. `(45–60s)`
**Skeleton:** Dummy head; append smaller; attach remainder. O(n+m)/O(1) extra.  
**Follow-up:** Merge k lists? → Heap (Week 4 preview).  
**Story:** —

### Q10. Middle of linked list. `(30–45s)`
**Skeleton:** Slow/fast; fast ends → slow mid. Even-length policy: state which mid.  
**Follow-up:** —  
**Story:** —

### Q11. Agenda you say before coding? `(45s)`
**Skeleton:** Restate · examples · brute · optimize · complexity · edge cases · then code. Budget 2–3 min.  
**Follow-up:** Timing guide.  
**Story:** —

### Q12. Array vs linked list in Swift production? `(45s)`
**Skeleton:** Arrays for cache locality & Swift ergonomics; linked lists mainly for interview pointer skills / rare specialized structures (LRU nodes).  
**Follow-up:** Don’t force LL into iOS UI code.  
**Story:** Honest senior answer.

## 6. Tricky questions

### T1. “Implement a queue with two stacks.” `(90–120s)`
**Trap:** Amortized vs worst-case confusion.  
**Senior answer:** In-stack for enqueue; out-stack for dequeue; flush in→out when out empty. Amortized O(1). State complexities clearly.  
**Follow-up:** Code on whiteboard.

### T2. “Min stack in O(1).” `(90–120s)`
**Trap:** Scanning stack each time.  
**Senior answer:** Aux stack or encode diffs; push/pop/getMin O(1). Discuss space.  
**Follow-up:** Edge: duplicates of min.

### T3. “Design hit counter / recent requests queue.” `(120s)`
**Trap:** Unbounded memory.  
**Senior answer:** Queue of timestamps; pop older than window; count = size. Discuss concurrency if asked (actor).  
**Follow-up:** Production: analytics buffering caution.

### T4. “Reverse nodes in k-group.” `(120s)`
**Trap:** Off-by-one; broken links.  
**Senior answer:** Count k; reverse segment; reconnect; iterate. Narrate pointers. O(n)/O(1).  
**Follow-up:** If leftover < k leave as-is.

### T5. “Why linked lists rarely appear in your iOS code?” `(90s)`
**Trap:** Sound anti-DSA.  
**Senior answer:** Swift Array performance model + value semantics; LL shines in interview algorithms and specialized caches. I still practice pointer problems for interviews.  
**Follow-up:** LRU as exception using DLL + dict.

### T6. “Circular queue with fixed array.” `(90–120s)`
**Trap:** Waste one slot vs count field.  
**Senior answer:** Head/tail mod capacity; distinguish empty/full via count or reserved slot. Useful for ring buffers (audio — S12 adjacency).  
**Follow-up:** Thread safety if producer/consumer.

### T7. “Stack for calculator / expression.” `(120s)`
**Trap:** Dive to code without grammar.  
**Senior answer:** Clarify operators/precedence; shunting-yard or two stacks (vals/ops). State assumptions.  
**Follow-up:** Integer overflow.

### T8. “Catch-up: interviewer pivots from coding to SDUI mid-way.” `(90s)`
**Trap:** Freeze.  
**Senior answer:** Park code state verbally; answer SDUI with versioning/fallback (Day 10); offer to resume coding. Shows composure (S8 IMOC energy).  
**Follow-up:** Mock #2 tomorrow energy.

## 7. Flashcards for today

| Front | Back |
|---|---|
| Stack use | LIFO matching/undo · Trap: use for BFS · Prod: nav nested |
| Queue use | FIFO BFS / waiters · Trap: Array.removeFirst hot · Prod: refresh waiters |
| Monotonic stack | Next greater O(n) · Trap: O(n²) scan · Prod: — |
| Two-stack queue | Amortized O(1) · Trap: claim strict O(1) always · Prod: — |
| Floyd cycle | Slow/fast O(1) space · Trap: only hash set · Prod: — |
| Reverse list | Iterative 3 pointers · Trap: lose next · Prod: — |
| Merge lists | Dummy head · Trap: null edges · Prod: — |
| Array as queue cost | removeFirst O(n) · Trap: ignore · Prod: Swift |
| Coding agenda | Restate→edges→complexity→code · Trap: code immediately · Prod: interviews |
| Deque window max | Maintain mono deque · Trap: heap each slide only · Prod: — |
| Min stack | Aux mins · Trap: O(n) scan · Prod: — |
| LL in Swift apps | Rare vs Array · Trap: force LL UI · Prod: honesty |
| k-group reverse | Count-reverse-reconnect · Trap: leftover mishandle · Prod: — |
| Ring buffer | Head/tail mod · Trap: empty/full ambiguity · Prod: audio-ish |
| Week 2 catch-up | Drill weak day Qs · Trap: only DSA forever · Prod: Mock #2 |

## 8. Practice

- **Coding / SD:** From [dsa-track.md](../../coding/dsa-track.md), complete **at least**:
  - 2 Easy stack/queue
  - 2 Medium stack or monotonic
  - 2 Medium linked list (reverse, cycle, merge, or mid)
  - 1 “tricky” (min stack **or** two-stack queue **or** k-group)
- **Complexity / agenda to say first:** Every problem: structure + time/space **before** code.
- **Catch-up:** Pick **one** weak theory day (08–12); re-record 2 answers.
- **Swift:** Prefer clear `ListNode` class and array stacks; narrate aloud.

## 9. Timed drill

1. Pick 1 Easy + 1 Medium; **timed** (Easy ~15–20m, Medium ~25–35m). Record approach minutes separately.
2. Score approach against [answer-timing-guide.md](../../timing/answer-timing-guide.md) coding budget.
3. Log misses in gotchas (especially Array-as-queue and off-by-ones).
4. Tomorrow prep: skim Day 14 Mock #2 rubric; choose **Ads or SDUI** track tonight (don’t do both cold).
