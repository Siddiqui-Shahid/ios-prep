# Audio script — Sample 01 — HashMap patterns (Q&A)
> Listen-only sample Q&A from `01-hashmap-patterns.md`. Spoken answers and follow-ups.

## §0 Q1. When does a HashMap beat nested loops?

Next. Q1. When does a HashMap beat nested loops? Answer. When you need O(1) expected lookups instead of rescanning: “have I seen X?”, “where was X?”, “how many X?”, “group by signature”, “prefix sum → count”, or sliding-window counts. Brute nested loops is O(n²); one pass with a map is expected O(n) time, O(n) space. Follow-ups. Two Sum why hash?: Need original indices on unsorted input — store value → index, look up complement each step.. When sort + two pointers instead?: Memory tight and indices don’t matter — O(n log n).. Keys must be?: Hashable in Swift — don’t hash mutable identity carelessly..

## §1 Q2. How does Two Sum work as the intern demo?

Next. Q2. How does Two Sum work as the intern demo? Answer. For each nums[i], if target - nums[i] is already in the map, return indices. Else store nums[i] → i. One pass, expected O(n). Say aloud: “Hash when I need indices or unsorted input; sort alternative when memory is tight and indices don’t matter.” Follow-ups. Duplicate values?: Map stores latest index — problem usually guarantees one solution.. No solution?: Return empty or [-1,-1] per prompt — clarify.. Three Sum?: Sort + two pointers with skip logic — different pattern..

## §2 Q3. Subarray sum equals K — why prefix + hash?

Next. Q3. Subarray sum equals K — why prefix + hash? Answer. Maintain running prefix and count how many earlier prefixes equal prefix - K. Map prefix → frequency. Negatives break sliding-window monotonicity — don’t use two pointers here. O(n) time, O(n) space. Follow-ups. Initialize map with {0:1}?: Yes — subarrays starting at index 0 counted correctly.. All negative array?: Prefix+hash still works.. Non-negative only?: Window two-pointer may work — still clarify..

## §3 Q4. How do I group anagrams or isomorphic strings?

Next. Q4. How do I group anagrams or isomorphic strings? Answer. Build a canonical key — sorted string O(k log k) or count tuple O(k) — map key → list of originals. Isomorphic: map char pattern consistently. Expected O(n · k) time, O(n · k) space. Follow-ups. Unicode anagrams?: Count code points or normalize — mention if relevant.. Empty strings?: Single group or skip — confirm.. Group shift?: Fixed alphabet offset — key by normalized form..

## §4 Q5. Sliding window + hash — what hygiene matters?

Next. Q5. Sliding window + hash — what hygiene matters? Answer. Track counts in current window; shrink left when invariant breaks. When a key’s count hits zero, remove it from the map so map.count reflects distinct keys — forgetting this breaks “exactly K distinct” variants. O(n) time, O(Σ) or O(n) space. Follow-ups. Longest without repeat?: Map last-seen index or count; expand/shrink.. Minimum window substring?: Expand until valid, shrink while valid, track best.. Fixed-size window?: Sometimes array of counts — no hash needed..

## §5 Q6. What complexity script do I say for hash problems?

Next. Q6. What complexity script do I say for hash problems? Answer. “Dictionary lookup is expected O(1). Pathological collisions can degrade toward O(n) — theoretical in interviews; I design good keys and state expected O(n) total. Space O(n).” For group anagrams: O(n · k log k) sorted keys or O(n · k) counts. Follow-ups. Worst-case hash table?: O(n) per op — mention if interviewer pushes theory.. Space when only 26 letters?: O(1) alphabet — still say O(1) or O(Σ).. Clone graph with map?: old→new during DFS/BFS — O(n)..

## §6 Q7. What is the hash “say this first” script?

Next. Q7. What is the hash “say this first” script? Answer. “Clarify uniqueness and whether order matters. Brute nested loops O(n²). Optimized: hash complements / frequencies for expected O(n). Edges: empties, duplicates, negatives, unicode keys if strings. Coding now.” Follow-ups. Bucket by frequency?: O(n) when freq ≤ n — alternative to heap for top-K freq.. Time-based key-value?: Binary search on timestamps — different catalog entry.. Swift String gotcha?: Not O(1) index — convert to [Character] when needed..

## §7 Q8. Design O(1) insert, delete, and getRandom?

Next. Q8. Design O(1) insert, delete, and getRandom? Answer. A hash map alone doesn’t give uniform random in O(1), and an array alone makes delete O(n). Keep an array of values plus a dictionary from value → index. Insert: append and record the index. Delete: swap target with the last element, update the map for the swapped value, pop — O(1). getRandom: pick a random index into the array. If duplicates are allowed, store sets of indices per value. Opener: “Array for random, map for index — swap-delete.” Follow-ups. Why not hash alone?: No O(1) uniform pick over keys without extra structure.. Weighted random?: Different structure — alias method / prefix sums — say constraints first.. Thread safety (BookMyShow synchronised dictionaries soft)?: Shared mutable map+array needs serialisation or actor — don’t claim lock-free casually..
