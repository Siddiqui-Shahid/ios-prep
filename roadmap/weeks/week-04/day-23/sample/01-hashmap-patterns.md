# Sample 01 — HashMap patterns (Q&A)

> Guided teaching. Each answer stands alone and ends with **How can I relate to my case** using named work — never S-codes.

---

### Q1. When does a HashMap beat nested loops?

**Answer:**

> When you need **O(1) expected lookups** instead of rescanning: “have I seen X?”, “where was X?”, “how many X?”, “group by signature”, “prefix sum → count”, or sliding-window counts. Brute nested loops is O(n²); one pass with a map is expected O(n) time, O(n) space.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Two Sum why hash? | Need original **indices** on unsorted input — store `value → index`, look up complement each step. |
| When sort + two pointers instead? | Memory tight and indices don’t matter — O(n log n). |
| Keys must be? | `Hashable` in Swift — don’t hash mutable identity carelessly. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q2. How does Two Sum work as the intern demo?

**Answer:**

> For each `nums[i]`, if `target - nums[i]` is already in the map, return indices. Else store `nums[i] → i`. One pass, expected O(n). Say aloud: “Hash when I need indices or unsorted input; sort alternative when memory is tight and indices don’t matter.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Duplicate values? | Map stores latest index — problem usually guarantees one solution. |
| No solution? | Return empty or [-1,-1] per prompt — clarify. |
| Three Sum? | Sort + two pointers with skip logic — different pattern. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q3. Subarray sum equals K — why prefix + hash?

**Answer:**

> Maintain running `prefix` and count how many earlier prefixes equal `prefix - K`. Map `prefix → frequency`. **Negatives break** sliding-window monotonicity — don’t use two pointers here. O(n) time, O(n) space.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Initialize map with `{0:1}`? | Yes — subarrays starting at index 0 counted correctly. |
| All negative array? | Prefix+hash still works. |
| Non-negative only? | Window two-pointer may work — still clarify. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q4. How do I group anagrams or isomorphic strings?

**Answer:**

> Build a **canonical key** — sorted string O(k log k) or count tuple O(k) — map key → list of originals. Isomorphic: map char pattern consistently. Expected O(n · k) time, O(n · k) space.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Unicode anagrams? | Count code points or normalize — mention if relevant. |
| Empty strings? | Single group or skip — confirm. |
| Group shift? | Fixed alphabet offset — key by normalized form. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q5. Sliding window + hash — what hygiene matters?

**Answer:**

> Track counts in current window; shrink left when invariant breaks. When a key’s count hits **zero, remove it** from the map so `map.count` reflects distinct keys — forgetting this breaks “exactly K distinct” variants. O(n) time, O(Σ) or O(n) space.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Longest without repeat? | Map last-seen index or count; expand/shrink. |
| Minimum window substring? | Expand until valid, shrink while valid, track best. |
| Fixed-size window? | Sometimes array of counts — no hash needed. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q6. What complexity script do I say for hash problems?

**Answer:**

> “Dictionary lookup is **expected O(1)**. Pathological collisions can degrade toward O(n) — theoretical in interviews; I design good keys and state **expected O(n)** total. Space O(n).” For group anagrams: O(n · k log k) sorted keys or O(n · k) counts.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Worst-case hash table? | O(n) per op — mention if interviewer pushes theory. |
| Space when only 26 letters? | O(1) alphabet — still say O(1) or O(Σ). |
| Clone graph with map? | old→new during DFS/BFS — O(n). |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q7. What is the hash “say this first” script?

**Answer:**

> “Clarify uniqueness and whether order matters. Brute nested loops O(n²). Optimized: hash complements / frequencies for expected O(n). Edges: empties, duplicates, negatives, unicode keys if strings. Coding now.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Bucket by frequency? | O(n) when freq ≤ n — alternative to heap for top-K freq. |
| Time-based key-value? | Binary search on timestamps — different catalog entry. |
| Swift String gotcha? | Not O(1) index — convert to `[Character]` when needed. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q8. Design O(1) insert, delete, and getRandom?

**Answer:**

> A hash map alone doesn’t give **uniform random in O(1)**, and an array alone makes **delete O(n)**. Keep an **array of values** plus a **dictionary from value → index**. **Insert:** append and record the index. **Delete:** swap target with the last element, update the map for the swapped value, pop — O(1). **getRandom:** pick a random index into the array. If **duplicates** are allowed, store **sets of indices** per value. Opener: “Array for random, map for index — swap-delete.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why not hash alone? | No O(1) uniform pick over keys without extra structure. |
| Weighted random? | Different structure — alias method / prefix sums — say constraints first. |
| Thread safety (BookMyShow synchronised dictionaries soft)? | Shared mutable map+array needs serialisation or actor — don’t claim lock-free casually. |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Exact crash %, “fixed all BMS crashes,” or claiming lab SafeDict.swift was the shipped file.

Next: [02-heap-patterns.md](02-heap-patterns.md)

---

