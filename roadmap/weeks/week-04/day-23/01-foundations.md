# 01 — Foundations: HashMaps & Heaps

> Intern → mid mental model. Mixed unknown-pattern discipline starts here.

---

## 0. North star

**HashMaps turn repeated scans into expected O(1) lookups when you can design a key. Heaps turn “keep the best K” into O(n log k) instead of full sorts. When the problem is unlabeled, spend 90 seconds classifying before you romanticize either.**

---

## 1. HashMap mental model

### 1.1 What a Dictionary buys you

| Need | Pattern |
|---|---|
| “Have I seen X?” | Set / map presence |
| “Where was X?” | value → index |
| “How many X?” | frequency map |
| “Group by signature” | canonical key → list |
| “Subarray math with negatives” | prefixSum → frequency |
| “Window invariant” | counts in current window; shrink when broken |

```text
Brute: for i, for j > i …          → O(n²)
Hash:  one pass, look up complement → expected O(n), space O(n)
```

### 1.2 Intern demo — Two Sum

> Need indices of two numbers that add to target.

- Sort + two pointers loses original indices unless you store pairs.
- Hash: for each `nums[i]`, if `target - nums[i]` in map → answer; else store `nums[i] → i`.

**Say aloud:** “I pick hash when I need indices or unsorted input; I mention sort alternative when memory is tight and indices don’t matter.”

### 1.3 Average vs worst case (interview script)

> “Dictionary lookup is **expected O(1)**. Pathological collisions can degrade toward O(n) — theoretical in interviews; I design good keys and state expected O(n) total. Space O(n).”

Swift note: keys must be `Hashable`. Don’t hash mutable identity carelessly.

---

## 2. Heap mental model

### 2.1 What a heap buys you

| Need | Structure |
|---|---|
| Top K largest | Min-heap size K (root = smallest of the elite) |
| Top K smallest | Max-heap size K |
| Kth largest in stream | Min-heap size K; root is answer |
| Merge K sorted lists | Min-heap of current heads |
| K closest points | Max-heap size K by distance (or min of n) |

**Complexity script:**

> “offer/poll O(log k). Top-K over n elements → O(n log k). Better than full sort O(n log n) when k ≪ n. Heapify build is O(n).”

### 2.2 Min vs max — the interview trap

For **Kth largest**, a **min-heap of size K** stores the K largest seen; the root is the smallest among them = Kth largest. Using a max-heap of all n is wasteful.

### 2.3 Swift interview pragmatism

- iOS 18+ / packages may expose `Heap`; in interviews, a clear array + sift or “I’ll use a binary heap API” narration beats broken boilerplate.
- If n is tiny, say “I’d sort — O(n log n) — acceptable here” and move on.

---

## 3. Mixed unknown-pattern — the 90-second protocol

Interviewers paste unlabeled Mediums. First 90 seconds:

1. **Restate + constraints** (sorted? online? duplicates? memory?).
2. **Brute** one sentence.
3. **Classify:** array scan / two pointer / window / hash / heap / tree / graph / binary search / DP-lite.
4. **Pick one** + reject one alternative aloud.

| Ask yourself | If yes → |
|---|---|
| Need counts / complements / seen set? | Hash |
| Always care about “best K so far”? | Heap |
| Contiguous constraint? | Window / prefix |
| Sorted property exploitable? | Two pointer / binary search |
| Hierarchy / nested? | Tree DFS/BFS (Day 22) |
| Overlapping subproblems stated? | DP (don’t force today) |

**Anti-pattern:** Jumping to DP because it “feels hard.”

---

## 4. Complexity cheat card

| Structure | Time (typical) | Space |
|---|---|---|
| Hash one-pass | Expected O(n) | O(n) |
| Sort + two pointer | O(n log n) | O(1) aux (ignore sort storage debate) |
| Heap top-K | O(n log k) | O(k) (+ freq map O(n)) |
| Bucket by freq | O(n) when freq ≤ n | O(n) |
| Sliding window + map | O(n) | O(Σ) alphabet or O(n) |

---

## 5. First scripts to memorize

**Hash:**

> “Clarify uniqueness and whether order matters. Brute nested loops O(n²). Optimized: hash complements / frequencies for expected O(n). Edges: empties, duplicates, negatives, unicode keys if strings.”

**Heap:**

> “I need the best K under a score. Keep a size-K heap — each insert O(log k), total O(n log k). Clarify sort order of the output. Edges: k > n, ties, empty.”

**Unknown:**

> “I’ll classify in 90 seconds: constraints → brute → hash/heap/window/tree → commit.”

→ [`02-deep-dive.md`](02-deep-dive.md)


---

## 6. Swift-specific gotchas (say if relevant)

| Topic | Interview line |
|---|---|
| `String` indexing | Not O(1) random access — convert to `[Character]` when needed |
| `Array.removeFirst` | O(n) — fine to acknowledge in BFS/queue talk |
| `Dictionary` keys | Must be `Hashable`; unstable hashes → pain |
| Heap boilerplate | Narrate operations if API missing; clarity > clever sift bugs |

---

## 7. Checklist before Deep Dive

- [ ] Two Sum hash script clean
- [ ] Min-heap size K for Kth largest explained
- [ ] Negatives → prefix+hash (not window) internalized
- [ ] 90s unknown-pattern protocol rehearsed once
