# 02 — Deep Dive: Hash / Heap Catalogs & Mixed Simulation

---

## 1. HashMap pattern catalog

| Trigger | Pattern | Complexity script |
|---|---|---|
| Two sum / complement | value → index | O(n)/O(n); sort+two-pointer if indices unused |
| Group anagrams / isomorphic | canonical key → list | sorted string O(k log k) or count tuple O(k) |
| Subarray sum equals K | prefixSum → frequency | O(n); careful with 0 / negatives |
| Longest substring without repeat | window + last-seen/count | O(n) |
| First unique / LRU building block | ordered dict mental model | Dict + list in design interviews |
| Clone graph / random pointer | old → new map | O(n); DFS/BFS + map |
| Time-based / snapshot | key → sorted timestamps | Binary search values |

### Prefix sum + hash (negatives break two pointers)

```text
count = 0; map = {0: 1}; prefix = 0
for x in nums:
  prefix += x
  count += map[prefix - K]   # how many earlier prefixes make subarray sum K
  map[prefix] += 1
```

**Trap:** Using sliding window two pointers when negatives exist.

### Window + counts hygiene

When a key’s count hits 0, **remove** it (or treat carefully) so `map.count` reflects distinct keys. Forgetting this breaks “exactly K distinct” variants.

---

## 2. Heap pattern catalog

| Trigger | Pattern | Notes |
|---|---|---|
| Top K frequent / largest | size-K heap **or** bucket by freq | Bucket O(n) when freq ≤ n |
| Kth largest in stream | min-heap size K | Root = kth |
| Merge K sorted lists | min-heap of heads | O(N log K) |
| K closest points | max-heap size K by distance | Or quickselect |
| Meeting rooms / intervals | sort + min-heap of ends | Scheduling |
| Reorganize / task scheduler | max-heap by freq + cooldown | Greedy |

### Merge K — why not concat + sort?

Concat + sort is O(N log N). Heap-of-heads is O(N log K). When K ≪ N, heap wins. Divide-and-conquer pairwise merge is also strong.

### Top K frequent — bucket alternative

After frequency map, place numbers into buckets indexed by frequency `0...n`. Walk buckets from high to low. O(n) time. Say this as the optimization over heap when applicable.

---

## 3. Mixed unknown-pattern simulation (today’s differentiator)

**Drill protocol (90 min block):**

- Blindfold topic: pick **6** mixed problems (Array/Hash/Heap/Tree).
- For each: **timer 90s classification only** (no code) → write pattern name → then solve or skip.
- Goal: **5/6 correct pattern tags** before coding.

**Misclassification recovery:**

> “I started window but negatives break monotonicity — switching to prefix+hash.”

Seniors narrate the pivot; juniors silently thrash.

---

## 4. Trade-offs

| Choice | When | Cost |
|---|---|---|
| HashMap | Lookups, counts, grouping | O(n) space; key-design bugs |
| Sort + two pointer | Memory tight, sorted OK | Loses indices unless pairs kept |
| Heap size K | Top-K online/streaming | O(n log k); comparator bugs |
| Full sort | Need full order anyway | Overkill for top-K |
| Bucket / counting | Freq in bounded range | Extra buckets; clarity win |
| TreeMap / sorted dict | Range queries on keys | Heavier; rare on iOS LC |

---

## 5. Failure modes

- Hashing **mutable** objects as keys.
- Forgetting decrement/remove at zero in window maps.
- Max-heap when you needed min-heap for Kth largest stream.
- Returning heap contents unsorted when problem wants sorted top-K — clarify.
- Mixed drill: jumping to DP because it “feels hard.”
- Silent coding with no classification.

---

## 6. Approach scripts (two-layer ready)

Use these as **Answer points** skeletons in [`04-questions.md`](04-questions.md):

| Family | 60s script spine |
|---|---|
| Two Sum | indices? → hash complement; else sort+two pointer |
| Anagrams | key = sorted or count[26]; bucket lists |
| Subarray sum K | negatives? → prefix+hash; non-neg → window OK |
| Top K freq | count → min-heap K or bucket |
| Merge K | heap heads O(N log K) vs sort N log N |
| Unknown | clarify → brute → classify → pick → edges |

---

## 7. Worked complexity examples

| Problem | Say |
|---|---|
| Group Anagrams | O(n · k log k) sorted keys or O(n · k) counts; space O(n · k) |
| Top K Frequent | O(n log k) heap or O(n) bucket |
| Merge K Lists | O(N log K) |
| Longest substr no repeat | O(n) time, O(min(n, Σ)) space |

→ [`03-production-bridge.md`](03-production-bridge.md) · [`code/`](code/)
