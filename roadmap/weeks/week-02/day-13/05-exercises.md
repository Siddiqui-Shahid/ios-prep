# 05 — Exercises

> Solutions are in-repo under `code/` and inline below. Speak approach **before** peeking.

## A. Conceptual

### A1. Structure picker
For each prompt, name structure + one-line why.

1. Undo typing  
2. Print tree level by level  
3. Next warmer day  
4. Detect loop in singly linked list  
5. Bounded last-100 events  

**Solution:** 1 Stack. 2 Queue. 3 Monotonic stack. 4 Floyd / hash. 5 Queue or deque/ring with eviction.

### A2. Complexity true/false
1. `Array.removeFirst` is O(1).  
2. Two-stack queue dequeue is always O(1) worst-case.  
3. Iterative reverse is O(1) space.  
4. Monotonic stack next-greater is O(n).  

**Solution:** 1 F (O(n)). 2 F (amortized; flush O(n)). 3 T. 4 T.

### A3. Write the universal coding agenda from memory (5 bullets).

**Solution:** Restate/clarify → brute+complexity → optimize+why → edges/API → code now.

---

## B. Coding (worked files)

### B1. Narrate TwoStackQueue
Open [code/TwoStackQueue.swift](code/TwoStackQueue.swift). Speak enqueue/dequeue/flush without looking at comments. Then implement `peek`.

**Solution sketch:** peek flushes if out empty, returns `outStack.last` without popping.

### B2. Reverse + cycle
Open [code/LinkedListAlgos.swift](code/LinkedListAlgos.swift). Trace reverse on `1→2→3`. Trace Floyd on a 4-node cycle at node 2.

### B3. Daily temperatures
Open [code/MonotonicStack.swift](code/MonotonicStack.swift). Hand-simulate `T = [73,74,75,71,69,72,76,73]`.

### B4. MinStack duplicates
Push 3, push 3, pop — getMin must still be 3. Verify against [code/MinStack.swift](code/MinStack.swift).

### B5. Timed pair (record)
1. Easy: valid parentheses — 15–20 min including approach  
2. Medium: reverse list **or** daily temperatures — 25–35 min  

Score approach minutes against the timing guide coding budget.

---

## C. Approach scripts (speak aloud)

Use [code/ApproachScripts.md](code/ApproachScripts.md). Record three:

1. Valid parentheses  
2. Two-stack queue  
3. Reverse linked list  

---

## D. Speaking / catch-up

1. Deliver Q12 (Array vs LL honesty) in ≤45s.  
2. Deliver T8 (pivot to SDUI) in ≤90s.  
3. Pick one weak Week 2 day; re-record 2 answers.  

---

## E. Timed drill checklist

1. [ ] 1 Easy + 1 Medium timed  
2. [ ] Approach spoken before each  
3. [ ] Gotchas logged (`removeFirst`, off-by-ones)  
4. [ ] Ads **or** SDUI track chosen for Day 14  
5. [ ] Revision twin skim  

Next: revision twin — [`../../../revision/weeks/week-02/day-13.md`](../../../revision/weeks/week-02/day-13.md).
