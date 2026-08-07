# Audio script — Sample 02 — Monotonic patterns & queues (Q&A)
> Listen-only sample Q&A from `02-monotonic-patterns.md`. Spoken answers and follow-ups.

## §0 Q1. How does valid parentheses work on a stack?

Next. Q1. How does valid parentheses work on a stack? Answer. Push opening brackets. On a closer, pop and check it matches the expected opener. End with empty stack ⇒ valid. Brute force with counters fails on ordering — ([)]. Complexity: O(n) time, O(n) space. Edges: empty string → true; only closers → false; odd length → false; mixed types ()[]{}. Follow-ups. Approach script opener?: Clarify bracket pairs → brute ordering failure → stack map → O(n)/O(n) → edges → code.. Undo/redo cousin?: Stack of states — same LIFO discipline.. Nested CMS JSON?: Different problem — still “matching/nesting” instinct..

## §1 Q2. What is a monotonic stack?

Next. Q2. What is a monotonic stack? Answer. A stack kept strictly increasing or decreasing to answer “next greater/smaller” in O(n). For daily temperatures: maintain a decreasing stack of indices. Walk left to right; while current value is greater than T[stack.top], pop and set answer = i − idx. Push i. Leftovers get 0. Each index pushed/popped at most once. Follow-ups. Brute?: O(n²) nested scan — name it then optimize.. Store indices vs values?: Indices — needed for distance/day counts.. Sliding window max?: Monotonic deque — different container, same invariant idea..

## §2 Q3. How does min stack achieve O(1) getMin?

Next. Q3. How does min stack achieve O(1) getMin? Answer. Parallel stack of current minimums, or encode diffs between value and current min. Push/pop/getMin all O(1). Trap: scanning for min each pop → O(n). Duplicates: push min again when equal so pop stays correct — otherwise min stack loses track after pop. Follow-ups. Space cost?: O(n) extra for min stack — trade for O(1) query.. Interview variant?: Max stack — symmetric.. Production use?: Learning-lab — honest about interview focus..

## §3 Q4. How does the two-stack queue work?

Next. Q4. How does the two-stack queue work? Answer. inStack: enqueue via push. outStack: dequeue via pop. When out is empty, flush all elements from in → out (reverse order restores FIFO). Each element moves at most twice → amortized O(1). Worst-case single dequeue can be O(n) when flushing — say amortized, not strict O(1) always. Follow-ups. Approach script?: Enqueue push in; dequeue pour if out empty then pop out; state amortized story.. vs ring buffer?: Ring: fixed capacity O(1); two-stack: dynamic, classic interview.. vs Deque?: Deque is production-friendly; two-stack is interview canonical..

## §4 Q5. When do I use a queue for BFS?

Next. Q5. When do I use a queue for BFS? Answer. Queue holds the frontier. For trees: while queue not empty, drain level size, enqueue children. Shortest path in unweighted graphs uses BFS — queue, not stack. Say aloud: “BFS uses a queue; DFS uses a stack or recursion.” Using stack for BFS is a common trap. Follow-ups. Level-order output?: Collect each level during drain loop.. Graph cycles?: Track visited — queue alone isn’t enough.. Hit counter / recent requests?: Queue of timestamps; drop older than window..

## §5 Q6. What is a circular queue (ring buffer)?

Next. Q6. What is a circular queue (ring buffer)? Answer. Fixed array with head, tail, and count (or waste one slot). Indices mod capacity. Empty vs full: with a count field, both are unambiguous; without count, waste one slot so head == tail means empty. O(1) enqueue/dequeue at ends when capacity fixed. Follow-ups. Audio streaming + server-driven splash (Aces) adjacency?: Ring language adjacent to media buffering — do not claim you shipped Aces as custom ring engine.. vs two-stack?: Ring: bounded capacity; two-stack: dynamic interview FIFO.. Full when?: count == capacity — reject or overwrite per spec..

## §6 Q7. What failure modes hit stack/queue problems?

Next. Q7. What failure modes hit stack/queue problems? Answer. Code immediately without agenda. Claim two-stack dequeue is always O(1) — say amortized. Use stack for BFS. Use Array removeFirst silently on hot path. Lose next while reversing linked list — separate file. Force linked list into UITableView — Array + honesty. Follow-ups. Agenda budget?: 2–3 min: restate, brute, optimize, edges, then code.. Concurrency on hit counter?: Actor wrapper — Learning-lab if asked.. Next topic?: Linked list algos — 03-linked-list-algos.md..
