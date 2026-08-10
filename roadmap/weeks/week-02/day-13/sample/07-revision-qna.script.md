# Audio script — Sample 07 — Revision Q&A (day-13) (Q&A)
> Listen-only sample Q&A from `07-revision-qna.md`. Spoken answers and follow-ups.

## §0 Q1. Stack vs queue in one sentence each? `(30s)`

Next. Q1. Stack vs queue in one sentence each? `(30s)` Answer. A stack is last-in first-out — push and pop the same end. A queue is first-in first-out — enqueue at the rear, dequeue at the front. A deque allows efficient ops at both ends. Follow-ups. Probe deeper?: Undo stacks are LIFO; printer job queues are FIFO — naming the access pattern beats memorizing library types..

## §1 Q2. Implement stack with Array — complexities? `(30–45s)`

Next. Q2. Implement stack with Array — complexities? `(30–45s)` Answer. I’d wrap an Array: push is append, pop is removeLast, peek is last — all amortized O(1). Random insert or remove in the middle is O(n). Capacity grows geometrically so occasional copies amortize. That’s the default Swift stack. Follow-ups. Probe deeper?: Array-backed stack: append/removeLast are amortized O(1); random middle remove is O(n) and not a stack operation..

## §2 Q3. Why is `Array.removeFirst` bad for queues? `(30–45s)`

Next. Q3. Why is `Array.removeFirst` bad for queues? `(30–45s)` Answer. removeFirst shifts every remaining element, so each dequeue is O(n). That’s fine for tiny or rare queues, but wrong for BFS or hot paths. I’d use a deque, a two-stack queue, a head index with periodic compact, or a ring buffer — and I’d say that cost aloud if I ever use Array naively. Follow-ups. Probe deeper?: BFS on a large graph with Array.removeFirst becomes O(n²) from shifting — use a deque or two-stack queue instead..

## §3 Q4. Valid parentheses approach? `(45–60s)`

Next. Q4. Valid parentheses approach? `(45–60s)` Answer. I’ll use a stack of opening brackets. For each closer, pop and check it matches via a map; if stack is empty or mismatch, invalid. At the end the stack must be empty. That’s O(n) time and O(n) space. Edges: empty string is valid; a single closer is invalid; interleaved types like ([)] fail correctly because order is checked. Follow-ups. Probe deeper?: For ([)] the stack sees mismatch on ] because the top is still (, so order checking catches interleaved types..

## §4 Q5. Monotonic stack — when? `(45–60s)`

Next. Q5. Monotonic stack — when? `(45–60s)` Answer. I reach for a monotonic stack when I need the next greater or next smaller element for every index in linear time. I keep indices in decreasing or increasing order of values; when the invariant breaks, I pop and record answers. Daily temperatures is the classic — O(n) because each index enters and leaves once. Follow-ups. Probe deeper?: Daily temperatures: keep decreasing indices; when a warmer day arrives, pop and fill answers — each index pushes/pops once for O(n)..

## §5 Q6. BFS uses which structure? `(30s)`

Next. Q6. BFS uses which structure? `(30s)` Answer. BFS uses a queue so you expand nodes in the order discovered — level order in trees, shortest path in unweighted graphs. DFS uses a stack or the call stack. Follow-ups. Probe deeper?: Tree level-order and unweighted shortest path both enqueue neighbors — DFS would use a stack or recursion instead..

## §6 Q7. Reverse linked list — iterative steps? `(60s)`

Next. Q7. Reverse linked list — iterative steps? `(60s)` Answer. Iteratively: prev starts nil, curr at head. While curr is non-nil, save next, point curr.next to prev, then advance prev and curr. Return prev as the new head. That’s O(n) time and O(1) space. Recursive reverse is fine for clarity but uses O(n) stack space — I prefer iterative in interviews unless asked otherwise. Follow-ups. Probe deeper?: After reverse, the old head’s next is nil and prev is the new head — draw three nodes once before coding the pointer dance..

## §7 Q8. Detect cycle — Floyd? `(45–60s)`

Next. Q8. Detect cycle — Floyd? `(45–60s)` Answer. Floyd: slow moves one step, fast two. If they meet, there’s a cycle. Optionally reset one pointer to head and walk both one step to find the entrance. Time O(n), space O(1). A hash set of visited nodes is simpler but O(n) space. Follow-ups. Probe deeper?: If slow and fast meet, a cycle exists; optionally reset one to head and walk together to find the entrance in O(1) space..

## §8 Q9. Merge two sorted lists? `(45–60s)`

Next. Q9. Merge two sorted lists? `(45–60s)` Answer. I’ll use a dummy head and a tail pointer. While both lists remain, append the smaller node and advance that list. Then attach whichever list remains. Return dummy.next. O(n+m) time, O(1) extra space if we reuse nodes. Follow-ups. Probe deeper?: Dummy head avoids special-casing an empty result; attach the remaining non-empty list in one shot after the merge loop..

## §9 Q10. Middle of linked list? `(30–45s)`

Next. Q10. Middle of linked list? `(30–45s)` Answer. Slow and fast from head; fast moves twice as fast. When fast can’t move, slow is the middle. For even length I’ll state whether I want the lower or upper middle — interviewers care that you noticed. Follow-ups. Probe deeper?: When fast hits nil on even length, say whether you want the lower or upper middle — interviewers listen for that clarification..

## §10 Q11. Agenda you say before coding? `(45s)`

Next. Q11. Agenda you say before coding? `(45s)` Answer. I budget two to three minutes: restate and clarify, sketch brute force with complexity, present the optimized structure and why, list edge cases and A P I shape, then say I’m coding the optimized version. Jumping straight into code loses communication points. Follow-ups. Probe deeper?: Say complexities and edge cases before coding — jumping straight into syntax loses communication points even if the code is right..

## §11 Q12. Array vs linked list in Swift production? `(45s)`

Next. Q12. Array vs linked list in Swift production? `(45s)` Answer. In Swift production I default to Array for locality and stdlib ergonomics. Linked lists are mainly an interview skill and occasionally appear in specialized designs like an LRU’s node list. I wouldn’t force a linked list into a UITableView data source just to sound clever. Follow-ups. Probe deeper?: Prefer Array in production for locality; treat linked lists as interview tools unless you truly need pointer-based structures like LRU nodes.. Indirect questions These do not name the concept first. Speak from the symptom, scenario, or junior question.

## §12 I1. A junior asks you in standup: “Stack vs queue in one sentence each.?” — how do you answer without jargon? `(60–90s)`

Next. I1. A junior asks you in standup: “Stack vs queue in one sentence each.?” — how do you answer without jargon? `(60–90s)` Answer. “A stack is last-in first-out — push and pop the same end. A queue is first-in first-out — enqueue at the rear, dequeue at the front. A deque allows efficient ops at both ends.” Follow-ups. What concept is this really?: Stack vs queue in one sentence each.. How do you prove it?: Give a tiny example or production boundary..

## §13 I2. Production symptom: something related to “Implement stack with Array — complexities” just broke under load. What do you check first? `(60–90s)`

Next. I2. Production symptom: something related to “Implement stack with Array — complexities” just broke under load. What do you check first? `(60–90s)` Answer. “I’d wrap an Array: push is append, pop is removeLast, peek is last — all amortized O(1). Random insert or remove in the middle is O(n). Capacity grows geometrically so occasional copies amortize. That’s the default Swift stack.” Follow-ups. What concept is this really?: Implement stack with Array — complexities. How do you prove it?: Give a tiny example or production boundary..

## §14 I3. Interviewer never names the topic. They describe a mess that maps to “Why is `Array.removeFirst` bad for queues”. How do you diagnose? `(60–90s)`

Next. I3. Interviewer never names the topic. They describe a mess that maps to “Why is `Array.removeFirst` bad for queues”. How do you diagnose? `(60–90s)` Answer. “removeFirst shifts every remaining element, so each dequeue is O(n). That’s fine for tiny or rare queues, but wrong for BFS or hot paths. I’d use a deque, a two-stack queue, a head index with periodic compact, or a ring buffer — and I’d say that cost aloud if I ever use Array naively.” Follow-ups. What concept is this really?: Why is Array.removeFirst bad for queues. How do you prove it?: Give a tiny example or production boundary..

## §15 I4. Code review: you spot a smell around “Valid parentheses approach”. What do you say and what fix do you propose? `(60–90s)`

Next. I4. Code review: you spot a smell around “Valid parentheses approach”. What do you say and what fix do you propose? `(60–90s)` Answer. “I’ll use a stack of opening brackets. For each closer, pop and check it matches via a map; if stack is empty or mismatch, invalid. At the end the stack must be empty. That’s O(n) time and O(n) space. Edges: empty string is valid; a single closer is invalid; interleaved types like ([)] fail correctly because order is checked.” Follow-ups. What concept is this really?: Valid parentheses approach. How do you prove it?: Give a tiny example or production boundary..

## §16 I5. What happens if a teammate ignores the rule behind “Monotonic stack — when”? `(60–90s)`

Next. I5. What happens if a teammate ignores the rule behind “Monotonic stack — when”? `(60–90s)` Answer. “I reach for a monotonic stack when I need the next greater or next smaller element for every index in linear time. I keep indices in decreasing or increasing order of values; when the invariant breaks, I pop and record answers. Daily temperatures is the classic — O(n) because each index enters and leaves once.” Follow-ups. What concept is this really?: Monotonic stack — when. How do you prove it?: Give a tiny example or production boundary..

## §17 I6. Walk me through a failed interview answer on “BFS uses which structure” and how you’d correct it? `(60–90s)`

Next. I6. Walk me through a failed interview answer on “BFS uses which structure” and how you’d correct it? `(60–90s)` Answer. “BFS uses a queue so you expand nodes in the order discovered — level order in trees, shortest path in unweighted graphs. DFS uses a stack or the call stack.” Follow-ups. What concept is this really?: BFS uses which structure. How do you prove it?: Give a tiny example or production boundary..

## §18 I7. A junior asks you in standup: “Reverse linked list — iterative steps?” — how do you answer without jargon? `(60–90s)`

Next. I7. A junior asks you in standup: “Reverse linked list — iterative steps?” — how do you answer without jargon? `(60–90s)` Answer. “Iteratively: prev starts nil, curr at head. While curr is non-nil, save next, point curr.next to prev, then advance prev and curr. Return prev as the new head. That’s O(n) time and O(1) space. Recursive reverse is fine for clarity but uses O(n) stack space — I prefer iterative in interviews unless asked otherwise.” Follow-ups. What concept is this really?: Reverse linked list — iterative steps. How do you prove it?: Give a tiny example or production boundary..

## §19 I8. Production symptom: something related to “Detect cycle — Floyd.” just broke under load. What do you check first? `(60–90s)`

Next. I8. Production symptom: something related to “Detect cycle — Floyd.” just broke under load. What do you check first? `(60–90s)` Answer. “Floyd: slow moves one step, fast two. If they meet, there’s a cycle. Optionally reset one pointer to head and walk both one step to find the entrance. Time O(n), space O(1). A hash set of visited nodes is simpler but O(n) space.” Follow-ups. What concept is this really?: Detect cycle — Floyd.. How do you prove it?: Give a tiny example or production boundary.. Tricky questions / brain puzzles Cover the answer. Speak for ~90–120s. These separate “I read a blog” from “I’ve been burned.”.

## §20 T1. They want a one-tool forever answer? `(90–120s)`

Next. T1. They want a one-tool forever answer? `(90–120s)` Answer. “I pick a default for the constraint, then name the trade-off and when I’d switch. Senior answers are context-bound, not slogan-bound.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §21 T2. Race vs deadlock — they mix the terms? `(90–120s)`

Next. T2. Race vs deadlock — they mix the terms? `(90–120s)` Answer. “Race is unsynchronized shared mutation — corruption and Heisenbugs. Deadlock is waiting forever on an order you can’t break. Fix races with a clear exclusion boundary; fix deadlocks by never syncing onto the queue you’re already on.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §22 T3. Main-thread rule under pressure? `(90–120s)`

Next. T3. Main-thread rule under pressure? `(90–120s)` Answer. “U I work on main. Heavy parse/decode off main. Hop back with async, not sync from main. If the app freezes, I look for sync-to-self or main-queue overload first.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §23 T4. Cancellation honesty? `(90–120s)`

Next. T4. Cancellation honesty? `(90–120s)` Answer. “Cancel in-flight work when the screen goes away. Weak self in completions. Structured tasks cancel children. I don’t claim cancellation if I only nil’d a delegate.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §24 T5. Cache invalidation trap? `(90–120s)`

Next. T5. Cache invalidation trap? `(90–120s)` Answer. “I define TTL, version keys, and a clear bust path. Stale U I with a spinner is often better than corrupt merge. I say what is source of truth.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §25 T6. Security theater vs real pinning? `(90–120s)`

Next. T6. Security theater vs real pinning? `(90–120s)` Answer. “Pinning without rotation and a kill-switch is how you brick clients. I describe SPKI pins, backup pins, and remote config escape hatches.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §26 T7. SDUI unknown component in prod? `(90–120s)`

Next. T7. SDUI unknown component in prod? `(90–120s)` Answer. “Unknown type must degrade — skip, placeholder, or safe fallback — never crash the screen. Schema version and registry discipline matter more than fancy rendering.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §27 T8. DI vs singletons under test? `(90–120s)`

Next. T8. DI vs singletons under test? `(90–120s)` Answer. “I inject boundaries at the feature edge so tests replace networking and clocks. Global singletons make flaky tests and hidden order dependence.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §28 T9. Prefetch that hurts scrolling? `(90–120s)`

Next. T9. Prefetch that hurts scrolling? `(90–120s)` Answer. “Prefetch without budget causes jank and battery drain. I bound concurrency, cancel off-screen work, and measure with Instruments before calling it a win.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §29 T10. Actor reentrancy surprise? `(90–120s)`

Next. T10. Actor reentrancy surprise? `(90–120s)` Answer. “Await inside an actor can interleave other work on that actor. I don’t assume exclusive state across an await without re-checking invariants.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..
