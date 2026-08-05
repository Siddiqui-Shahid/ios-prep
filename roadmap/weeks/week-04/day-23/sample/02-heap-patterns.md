# Sample 02 — Heap patterns (Q&A)

> Guided teaching. Each answer stands alone; **Points to** shows where the full module expands the idea.

---

### Q1. What does a heap buy you in interviews?

**Points to:** [Foundations · §2 Heap mental model](../01-foundations.md#2-heap-mental-model) · [Deep dive · §2 Heap pattern catalog](../02-deep-dive.md#2-heap-pattern-catalog)

**Answer:**

> Heaps turn “keep the **best K** under a score” into **O(n log k)** instead of full sort O(n log n). Triggers: top-K largest/smallest, Kth in stream, merge K sorted lists, K closest points, meeting rooms with end times. Each offer/poll is O(log k).

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| When full sort anyway? | Need entire sorted output or k ≈ n. |
| Heapify build? | O(n) — mention if building from array once. |
| Swift heap API? | Narrate sift operations if boilerplate missing — clarity beats broken code. |

---

### Q2. Min-heap or max-heap for Kth largest?

**Points to:** [Foundations · §2.2 Min vs max](../01-foundations.md#22-min-vs-max--the-interview-trap)

**Answer:**

> **Kth largest** → **min-heap of size K**. The root is the smallest among the K largest seen — that is the Kth largest. Max-heap of all n elements is wasteful O(n log n). This inversion trips many candidates.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Kth smallest? | **Max-heap** size K — root is largest among K smallest. |
| Top K frequent? | Count map → min-heap K by freq **or** bucket O(n). |
| k > n? | Clarify — return all or error. |

---

### Q3. How does merge K sorted lists work?

**Points to:** [Deep dive · §2 Merge K](../02-deep-dive.md#merge-k--why-not-concat--sort)

**Answer:**

> Min-heap of current head from each list. Pop smallest, append to result, push next from that list. O(N log K) where N = total nodes, K = lists. Concat + sort is O(N log N) — heap wins when K ≪ N.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Empty lists? | Skip on init; handle all-empty. |
| Divide-and-conquer merge? | Pairwise merge — also strong; state complexity. |
| Linked list nodes vs arrays? | Same heap-of-heads idea. |

---

### Q4. Top K frequent — heap vs bucket?

**Points to:** [Deep dive · §2 Top K frequent](../02-deep-dive.md#top-k-frequent--bucket-alternative)

**Answer:**

> **Heap:** frequency map → min-heap size K → O(n log k). **Bucket:** array indexed by frequency 0…n, place nums in buckets, walk high to low → **O(n)** when freq ≤ n. Say bucket as optimization when applicable.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Return order? | Clarify sorted vs any order top-K. |
| Ties? | Any K among ties unless problem specifies. |
| Stream variant? | Heap size K — online friendly. |

---

### Q5. What is the heap complexity script?

**Points to:** [Foundations · §2.1 Complexity script](../01-foundations.md#21-what-a-heap-buys-you) · [Deep dive · §7 Worked examples](../02-deep-dive.md#7-worked-complexity-examples)

**Answer:**

> “offer/poll O(log k). Top-K over n elements → **O(n log k)**. Better than full sort O(n log n) when k ≪ n. Space O(k) plus frequency map O(n) if needed.” Merge K: O(N log K). K closest: max-heap size K by distance.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Quickselect alternative? | Average O(n) for Kth — mention if interviewer asks. |
| Reorganize string / task scheduler? | Max-heap by freq + cooldown — greedy. |
| Comparator bugs? | Define min-heap by **negated** max or explicit compare — say aloud. |

---

### Q6. What is the heap “say this first” script?

**Points to:** [Foundations · §5 First scripts](../01-foundations.md#5-first-scripts-to-memorize)

**Answer:**

> “I need the best K under a score. Keep a size-K heap — each insert O(log k), total O(n log k). Clarify sort order of output. Edges: k > n, ties, empty input. Coding now.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Tiny n? | “I’d sort — O(n log n) — acceptable here.” |
| Meeting rooms II? | Sort starts; min-heap of end times for overlap count. |
| Return heap contents unsorted? | Clarify — may need sort before return. |

---

### Q7. Common heap failure modes?

**Points to:** [Deep dive · §5 Failure modes](../02-deep-dive.md#5-failure-modes)

**Answer:**

> Max-heap when min-heap size K needed. Returning heap unsorted when sorted output required. Forgetting tie policy. Building heap of all n when K is small. Broken sift boilerplate under pressure — narrate intent if API missing.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| K closest points? | Max-heap size K by distance — evict farthest among K. |
| Find median stream? | Two heaps — max-low + min-high — design question. |
| iOS 18+ Heap type? | Use if available; else array + sift with explanation. |

---

Next: [03-mixed-unknown-pattern.md](03-mixed-unknown-pattern.md)
