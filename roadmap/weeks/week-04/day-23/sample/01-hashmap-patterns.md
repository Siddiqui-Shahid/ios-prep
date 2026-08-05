# Sample 01 — HashMap patterns (Q&A)

> Guided teaching. Each answer stands alone; **Points to** shows where the full module expands the idea.

---

### Q1. When does a HashMap beat nested loops?

**Points to:** [Foundations · §1 HashMap mental model](../01-foundations.md#1-hashmap-mental-model) · [Deep dive · §1 HashMap pattern catalog](../02-deep-dive.md#1-hashmap-pattern-catalog)

**Answer:**

> When you need **O(1) expected lookups** instead of rescanning: “have I seen X?”, “where was X?”, “how many X?”, “group by signature”, “prefix sum → count”, or sliding-window counts. Brute nested loops is O(n²); one pass with a map is expected O(n) time, O(n) space.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Two Sum why hash? | Need original **indices** on unsorted input — store `value → index`, look up complement each step. |
| When sort + two pointers instead? | Memory tight and indices don’t matter — O(n log n). |
| Keys must be? | `Hashable` in Swift — don’t hash mutable identity carelessly. |

---

### Q2. How does Two Sum work as the intern demo?

**Points to:** [Foundations · §1.2 Intern demo](../01-foundations.md#12-intern-demo--two-sum)

**Answer:**

> For each `nums[i]`, if `target - nums[i]` is already in the map, return indices. Else store `nums[i] → i`. One pass, expected O(n). Say aloud: “Hash when I need indices or unsorted input; sort alternative when memory is tight and indices don’t matter.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Duplicate values? | Map stores latest index — problem usually guarantees one solution. |
| No solution? | Return empty or [-1,-1] per prompt — clarify. |
| Three Sum? | Sort + two pointers with skip logic — different pattern. |

---

### Q3. Subarray sum equals K — why prefix + hash?

**Points to:** [Deep dive · §1 Prefix sum + hash](../02-deep-dive.md#prefix-sum--hash-negatives-break-two-pointers)

**Answer:**

> Maintain running `prefix` and count how many earlier prefixes equal `prefix - K`. Map `prefix → frequency`. **Negatives break** sliding-window monotonicity — don’t use two pointers here. O(n) time, O(n) space.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Initialize map with `{0:1}`? | Yes — subarrays starting at index 0 counted correctly. |
| All negative array? | Prefix+hash still works. |
| Non-negative only? | Window two-pointer may work — still clarify. |

---

### Q4. How do I group anagrams or isomorphic strings?

**Points to:** [Deep dive · §1 HashMap catalog](../02-deep-dive.md#1-hashmap-pattern-catalog)

**Answer:**

> Build a **canonical key** — sorted string O(k log k) or count tuple O(k) — map key → list of originals. Isomorphic: map char pattern consistently. Expected O(n · k) time, O(n · k) space.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Unicode anagrams? | Count code points or normalize — mention if relevant. |
| Empty strings? | Single group or skip — confirm. |
| Group shift? | Fixed alphabet offset — key by normalized form. |

---

### Q5. Sliding window + hash — what hygiene matters?

**Points to:** [Deep dive · §1 Window + counts hygiene](../02-deep-dive.md#window--counts-hygiene)

**Answer:**

> Track counts in current window; shrink left when invariant breaks. When a key’s count hits **zero, remove it** from the map so `map.count` reflects distinct keys — forgetting this breaks “exactly K distinct” variants. O(n) time, O(Σ) or O(n) space.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Longest without repeat? | Map last-seen index or count; expand/shrink. |
| Minimum window substring? | Expand until valid, shrink while valid, track best. |
| Fixed-size window? | Sometimes array of counts — no hash needed. |

---

### Q6. What complexity script do I say for hash problems?

**Points to:** [Foundations · §1.3 Average vs worst](../01-foundations.md#13-average-vs-worst-case-interview-script) · [§4 Complexity cheat card](../01-foundations.md#4-complexity-cheat-card)

**Answer:**

> “Dictionary lookup is **expected O(1)**. Pathological collisions can degrade toward O(n) — theoretical in interviews; I design good keys and state **expected O(n)** total. Space O(n).” For group anagrams: O(n · k log k) sorted keys or O(n · k) counts.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Worst-case hash table? | O(n) per op — mention if interviewer pushes theory. |
| Space when only 26 letters? | O(1) alphabet — still say O(1) or O(Σ). |
| Clone graph with map? | old→new during DFS/BFS — O(n). |

---

### Q7. What is the hash “say this first” script?

**Points to:** [Foundations · §5 First scripts](../01-foundations.md#5-first-scripts-to-memorize)

**Answer:**

> “Clarify uniqueness and whether order matters. Brute nested loops O(n²). Optimized: hash complements / frequencies for expected O(n). Edges: empties, duplicates, negatives, unicode keys if strings. Coding now.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Bucket by frequency? | O(n) when freq ≤ n — alternative to heap for top-K freq. |
| Time-based key-value? | Binary search on timestamps — different catalog entry. |
| Swift String gotcha? | Not O(1) index — convert to `[Character]` when needed. |

---

Next: [02-heap-patterns.md](02-heap-patterns.md)
