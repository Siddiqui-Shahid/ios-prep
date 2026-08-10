# Audio script — Sample 01 — Stack & queue basics (Q&A)
> Listen-only sample Q&A from `01-stack-queue-basics.md`. Spoken answers and follow-ups.

## §0 Q1. What is a stack vs a queue, in one sentence each?

Next. Q1. What is a stack vs a queue, in one sentence each? Answer. Stack: last in, first out (LIFO) — like a stack of plates; push and pop from the top. Queue: first in, first out (FIFO) — like a ticket line; enqueue at the rear, dequeue from the front. Deque adds push/pop at both ends. Pick the structure that matches the problem’s access pattern before you code. Follow-ups. Kitchen metaphors?: Stack = plates from top; queue = serve front of line.. DFS vs BFS?: DFS uses stack or recursion; BFS uses queue.. Swift default stack?: Array with append / removeLast..

## §1 Q2. Why is `Array.removeFirst` a bad default queue?

Next. Q2. Why is `Array.removeFirst` a bad default queue? Answer. removeFirst shifts every remaining element → O(n) per dequeue. Fine for tiny n or rare calls. Wrong for BFS hot paths and interview silence. Alternatives: two-stack queue (amortized O(1)), head index + compact, ring buffer, or Swift Collections Deque. Follow-ups. When is removeFirst OK?: Small n, prototype, or you explicitly call out O(n).. Production Swift?: Often Deque if dependency OK; two-stack for interviews.. Interviewer trap?: Claiming Array queue is O(1) — wrong..

## §2 Q3. What are the complexity targets to say aloud?

Next. Q3. What are the complexity targets to say aloud? Answer. Array stack push/pop: amortized O(1). Array queue via removeFirst: O(n) dequeue. Two-stack queue: amortized O(1) enqueue/dequeue. Deque/ring ends: O(1). Linked list local insert/delete given node: O(1); access by index: O(n). Reverse list iterative: O(n) time, O(1) space. Follow-ups. Amortized meaning?: Occasional expensive op spread over many cheap ops — Array growth, two-stack flush.. Two-stack worst case?: Dequeue O(n) when pouring in→out — say amortized, not strict O(1) always.. Floyd cycle?: O(n) time, O(1) space with slow/fast pointers..

## §3 Q4. How do I implement a stack in Swift?

Next. Q4. How do I implement a stack in Swift? Answer. Default: var stack: [Int] = []; append to push; removeLast or popLast to pop; last to peek. Say: append/removeLast are amortized O(1) because capacity doubles geometrically — occasional O(n) copy amortized away. A small Stack<Element wrapper is fine in interviews for clarity. Follow-ups. Struct vs class stack?: Struct with mutating methods — value semantics OK for local algorithm.. Thread-safe stack?: Wrap in actor or lock if concurrent — say so if asked.. Min stack?: Separate topic — 02-monotonic-patterns.md..

## §4 Q5. What is the pattern → structure map?

Next. Q5. What is the pattern → structure map? Answer. Matching/nesting/undo → stack (valid parentheses). Next greater/smaller → monotonic stack. Level-order/shortest unweighted → queue (BFS). Sliding window max → monotonic deque. Cycle/middle/reverse/merge → linked list pointers. LRU preview → hash + doubly linked list. Follow-ups. Valid parentheses structure?: Stack of opening chars; map closers.. Daily temperatures?: Monotonic decreasing stack of indices.. Binary tree level order?: Queue drains level by level..

## §5 Q6. Why do interviewers ask stack/queue in iOS rounds?

Next. Q6. Why do interviewers ask stack/queue in iOS rounds? Answer. To see if you name structure and complexity before code, avoid Swift footguns, narrate pointer updates cleanly, and distinguish amortized vs worst-case. Senior line: “I practice these for interviews; in i O S product code I default to Array unless designing something like LRU — I won’t pretend the feed was a linked list.” Follow-ups. Bridge to production?: Nav back stack = LIFO; refresh waiters = FIFO queue (soft BookMyShow SSL pinning + URLSession migration).. Force LL into UITableView?: Wrong — Array + honesty.. Agenda-first?: 2–3 min plan before typing — every time..

## §6 Q7. What is linked list honesty in Swift apps?

Next. Q7. What is linked list honesty in Swift apps? Answer. Arrays win on cache locality, value semantics, and stdlib algorithms. Linked lists shine for interview pointer skill, O(1) splice when you already hold the node, and designs like LRU (dict + node list). Honest senior line: practice LL for interviews; default to Array in product U I unless designing specialized structures. Follow-ups. Interview ListNode?: final class ListNode { var val; var next } — reference semantics.. UITableView cells?: Array-backed diffable — not linked list nodes.. Next topic?: Monotonic patterns — 02-monotonic-patterns.md..

## §7 Q8. How do you design a hit counter / recent-requests queue?

Next. Q8. How do you design a hit counter / recent-requests queue? Answer. Store timestamps in a queue. On hit, enqueue now; while the front is older than the window, dequeue. The count is the queue’s size — memory stays proportional to hits in the window. Unbounded growth is the footgun. If multiple threads call in, isolate behind an actor (Learning-lab design — not a Verified shipped hit counter). Soft prod note: budget cardinality and sampling in real analytics. Follow-ups. Window check?: Compare now - t ≥ window (e.g. 5 minutes).. Persist?: Usually in-memory for this interview problem.. Prod bridge?: Soft — not a Verified BMS metric..

## §8 Q9. How do you approach a calculator / expression stack problem?

Next. Q9. How do you approach a calculator / expression stack problem? Answer. First clarify the grammar — which operators, precedence, associativity, integers only or not. Then either shunting-yard to RPN, or a values stack plus an operators stack. State assumptions before coding and mention integer overflow. Diving into code without the grammar is how calculator problems implode. Follow-ups. Parentheses?: Ops stack handles with higher-precedence / grouping rules.. Unary minus?: Call it out as a tokenisation issue before coding.. Approach opener?: Restate → constraints → brute/optimize → complexity → edges → code..
