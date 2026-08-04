# 04 — Questions (two-layer approach scripts)

> Cover **Full spoken answer**. Speak from **Answer points** only. Uncover and compare.  
> Normal ≈ 30–45s · Tricky ≈ 90–120s · Unknown-pattern meta up to 90s classification + answer.

---

## Normal questions

### Q1. Two Sum — hash vs sort? `(30–45s)`

**Answer points:**
- Hash complement O(n)/O(n) keeps indices
- Sort + two pointer O(n log n)/O(1) aux loses indices unless pairs stored
- Prefer hash when indices required
- Clarify duplicates / multiple answers

**Agenda opener:**  
> “Indices decide hash versus sort.”

**Full spoken answer:**  
> “If I need original indices, I scan once and store each value to index in a dictionary, looking up the complement target minus current. That’s expected O(n) time and O(n) space. Sorting plus two pointers is O(n log n) and better on auxiliary memory, but sorting loses indices unless I store value-index pairs first. I clarify duplicates and whether any pair is enough.”

**Common wrong answer:**  
> Always sort first “because two pointers are elegant,” then scramble to recover indices.

**Follow-up ladder:**
- **L1:** Multiset duplicates?
- **L2:** Three Sum bridge?
- **L3:** Streaming one-pass constraint?

**Provenance:** Learning-lab · `code/HashPatterns.swift`

---

### Q2. Top K frequent elements approach? `(30–45s)`

**Answer points:**
- Frequency map first
- Min-heap size K → O(n log k) **or** bucket by frequency O(n)
- Stream version → maintain heap online
- Soft GymFlow top-K analogy

**Agenda opener:**  
> “Count, then size-K heap or buckets.”

**Full spoken answer:**  
> “I count frequencies in a hash map, then either keep a min-heap of size K keyed by frequency for O(n log k), or bucket numbers by frequency for O(n) when frequencies are at most n. I clarify whether the output must be sorted. In a recommender, keeping top-K similar items is the same instinct — bound the elite set under a score.”

**Common wrong answer:**  
> Full sort of all uniques every time without discussing k ≪ n.

**Follow-up ladder:**
- **L1:** Stream of numbers — Kth largest?
- **L2:** Ties in frequency?
- **L3:** GymFlow: heap vs full sort of catalog?

**Provenance:** Learning-lab; soft Verified · S16

---

### Q3. Average vs worst-case for Dictionary? `(30–45s)`

**Answer points:**
- Expected O(1) lookup
- Pathological collisions O(n) theoretical
- Good hash + load factor
- Swift Hashable pitfalls (don’t use unstable keys)

**Agenda opener:**  
> “Expected O(1) — I state expected totals.”

**Full spoken answer:**  
> “A hash map gives expected O(1) lookup and insert. In the pathological collision case operations can degrade toward O(n), which I mention as theoretical in interviews while stating expected O(n) for a linear pass. Keys need a solid Hashable implementation — mutable or poorly distributed keys cause real pain.”

**Common wrong answer:**  
> “Dictionary is always worst-case O(1).”

**Follow-up ladder:**
- **L1:** Why not hash a class instance identity carelessly?
- **L2:** S2 — sync access vs hash complexity?

**Provenance:** Learning-lab; soft Verified · S2

---

### Q4. When is a heap the wrong tool? `(30–45s)`

**Answer points:**
- Need full sort anyway
- Need random access by key
- K ≈ n → just sort
- Arbitrary delete-by-id without handle

**Agenda opener:**  
> “Heap when I only need best K — not always.”

**Full spoken answer:**  
> “A heap is wrong when I need the fully sorted order anyway, when I need keyed random access, when K is basically n so O(n log k) ≈ O(n log n), or when I must delete arbitrary elements by id without an index handle. In those cases I sort, use a dictionary, or an indexed priority queue design.”

**Common wrong answer:**  
> “Always use a heap for anything with K in the name.”

**Follow-up ladder:**
- **L1:** Indexed priority queue sketch?
- **L2:** Quickselect alternative?

**Provenance:** Learning-lab

---

### Q5. Sliding window + hash — longest substring without repeating? `(45s)`

**Answer points:**
- Expand right; shrink left on duplicate
- Last-seen index or counts
- O(n)
- Exactly K distinct is a variant

**Agenda opener:**  
> “Expand, shrink when invariant breaks.”

**Full spoken answer:**  
> “I slide a window with a map of characters to last seen index or counts. I expand the right pointer; when I see a duplicate inside the window I advance the left until the invariant holds, and I track the max length. Time O(n). The same map hygiene shows up in ‘exactly K distinct’ problems — I shrink when distinct count exceeds K.”

**Common wrong answer:**  
> Restart the whole scan on every duplicate (O(n²) disguised).

**Follow-up ladder:**
- **L1:** Exactly K distinct characters?
- **L2:** Unicode / String indexing in Swift?

**Provenance:** Learning-lab · `code/HashPatterns.swift`

---

### Q6. Unknown-pattern: first 90 seconds — what do you say? `(45–60s)`

**Answer points:**
- Restate constraints
- Brute one-liner
- Classify hash/heap/window/tree/…
- Pick + reject alternative
- Complexity + edges

**Agenda opener:**  
> “Classify before I commit.”

**Full spoken answer:**  
> “I restate the problem and constraints — sorted, online, duplicates, memory. I give a one-line brute force. Then I classify: do I need counts or complements, best K, a contiguous window, a tree shape, or sorted order I can exploit. I pick one structure and briefly reject an alternative, state complexity and edges, and only then code. If I’m wrong, I narrate the pivot instead of silent thrashing.”

**Common wrong answer:**  
> Silence, or “this must be DP.”

**Follow-up ladder:**
- **L1:** Demo on an unlabeled Medium aloud.
- **L2:** Tie to machine-round Day 25 discipline.

**Provenance:** Learning-lab

---

## Tricky questions

### T1. “Subarray sum equals K with negatives — why can’t I use two pointers?” `(90–120s)`

**Answer points:**
- Window shrink assumes monotonicity
- Negatives break that
- Prefix sums + hash of prefix frequencies
- O(n)/O(n)
- Count vs boolean variants

**Agenda opener:**  
> “Negatives kill window monotonicity — prefix plus hash.”

**Full spoken answer:**  
> “Two-pointer sliding windows for subarray sums rely on monotonicity — adding elements moves the sum in a predictable direction so shrinking from the left is safe. Negatives break that. Instead I keep a running prefix sum and a hash map from prefix value to how many times I’ve seen it. For each index, prefix minus K tells me how many earlier prefixes form a subarray summing to K. That’s O(n) time and O(n) space. I clarify whether we need the count of subarrays or just existence.”

**Common wrong answer:**  
> Forcing two pointers and hand-waving negatives.

**Follow-up ladder:**
- **L1:** All non-negative — would you switch back to window?
- **L2:** Longest vs count?

**Provenance:** Learning-lab

---

### T2. “Merge K sorted lists — why not concatenate and sort?” `(90–120s)`

**Answer points:**
- Concat+sort works O(N log N)
- Heap-of-heads O(N log K)
- Better when K ≪ N
- Divide-and-conquer merge alternative
- Lazy streams / memory

**Agenda opener:**  
> “Both work — heap wins when K is small.”

**Full spoken answer:**  
> “Concatenating all nodes and sorting is correct in O(N log N). A min-heap of the current head of each list extracts the next global minimum in O(log K) per node, totaling O(N log K), which is better when K is much smaller than N. I’d also mention pairwise divide-and-conquer merging. If lists are lazy streams, the heap approach streams naturally without materializing everything first.”

**Common wrong answer:**  
> Accepting O(N log N) without discussing K.

**Follow-up ladder:**
- **L1:** K = N singleton lists?
- **L2:** Swift heap boilerplate under time pressure?

**Provenance:** Learning-lab · `code/HeapPatterns.swift`

---

### T3. “Design O(1) insert, delete, getRandom” `(90–120s)`

**Answer points:**
- Dict value→index + array
- Delete = swap with last
- Hash alone can’t getRandom uniformly in O(1)
- Array alone delete O(n)
- Duplicates → multiset variant

**Agenda opener:**  
> “Array for random, map for index — swap-delete.”

**Full spoken answer:**  
> “A hash map alone doesn’t give uniform random in O(1), and an array alone makes delete O(n). I keep an array of values plus a dictionary from value to its index. Insert appends and records the index. Delete swaps the target with the last element, updates the map, and pops — O(1). getRandom picks a random index into the array. If duplicates are allowed, I store sets of indices per value.”

**Common wrong answer:**  
> Only HashMap or only array.

**Follow-up ladder:**
- **L1:** Random among weighted items?
- **L2:** Thread safety (S2 soft)?

**Provenance:** Learning-lab

---

### T4. Unknown-pattern meta: “I don’t recognize this — what do you do?” `(90–120s)`

**Answer points:**
- Clarify → brute on example → name constraints
- Pick hash/heap/window/tree
- State complexity
- Code brute if needed then optimize
- Seniors communicate uncertainty with a plan

**Agenda opener:**  
> “Uncertainty with a plan beats silent panic.”

**Full spoken answer:**  
> “I say what I’m unsure about, then work a small example brute force so I see the structure. I ask whether the data is online, contiguous, or needs top-K. That usually collapses to hash, heap, window, or tree. I state the complexity I believe, code the clearest correct approach first if time is tight, and narrate the optimization. The same discipline shows up in a three-hour machine round — classify, vertical slice, don’t freeze.”

**Common wrong answer:**  
> Silence or random DP.

**Follow-up ladder:**
- **L1:** Live classify a problem from the mixed set.
- **L2:** Day 25 / Day 27 transfer.

**Provenance:** Learning-lab

---

### T5. “Top K frequent — heap vs bucket — defend one.” `(90s)`

**Answer points:**
- Heap general when K small
- Bucket O(n) when freq ≤ n
- Clarity under timer
- Output order requirements

**Agenda opener:**  
> “Bucket when frequencies are bounded by n.”

**Full spoken answer:**  
> “After the frequency map, if I only need top K and K is tiny, a size-K heap is simple and O(n log k). If frequencies are integers between 0 and n, I prefer buckets indexed by frequency and walk from high to low for O(n). I pick based on constraints and what I can code correctly in time. I clarify whether ties or sorted output matter.”

**Common wrong answer:**  
> Always heap; never mention bucket.

**Follow-up ladder:**
- **L1:** Follow-up: return any order vs sorted by freq.

**Provenance:** Learning-lab

---

## Suggested record set

Q1, Q2, Q6 + T1, T4.
