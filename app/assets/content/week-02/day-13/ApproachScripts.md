# Approach scripts (speak 2–3 min before coding)

> Learning-lab. Record these until they are muscle memory.

## Universal (15s)

> “Let me restate, confirm constraints, then brute, optimize, complexity, and edges before I code.”

## Valid parentheses (~90s)

> “I’ll clarify bracket pairs. Counters fail on ordering like `([)]`. I’ll use a stack of opens; on close, pop and match via a map; end must be empty. O(n)/O(n). Edges: empty → true; only closers → false. Coding that now.”

## Monotonic stack / daily temperatures (~90s)

> “Brute is O(n²). I’ll keep a decreasing stack of indices. When today is warmer than the top, pop and set days = i − idx. Push i; leftovers stay 0. O(n)/O(n).”

## Two-stack queue (~90s)

> “Enqueue pushes to in-stack. Dequeue pops from out-stack; if out is empty, pour in→out first. Amortized O(1); a flush can be O(n) once — I’ll say amortized. Empty returns nil.”

## Min stack (~90s)

> “Value stack plus min stack. Push value; push min(value, currentMin). Pop both when popping a min. getMin is peek of mins. Duplicate mins get pushed again. All O(1).”

## Reverse linked list (~90s)

> “Iterative three pointers: prev nil, curr head; save next, rewire, advance. Return prev. O(n)/O(1). Recursive uses O(n) stack — I’ll stay iterative.”

## Floyd cycle (~60–90s)

> “Slow +1, fast +2; meet means cycle. Optional: reset one to head, step together for entrance. O(n)/O(1). Hash set is the O(n)-space alternative.”

## Merge two sorted lists (~60–90s)

> “Dummy head; append smaller; attach remainder. Reuse nodes for O(1) extra space. O(n+m).”

## Hit counter (~90s)

> “Queue of timestamps; drop front if outside window; size is the count. Bound memory to the window. Concurrent callers → actor isolation.”

## Pivot to SDUI mid-coding (T8, ~60–90s)

> “I’ll park state: prev/curr through node N. For SDUI: version gate, registry render, unknown skip with metrics, hard fallback if root empty — same fail-soft mindset as our backend-driven header. Want me to resume the list?”
