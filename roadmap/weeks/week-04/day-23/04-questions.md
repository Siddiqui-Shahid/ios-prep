# 04 — Questions (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Each question ends with **How can I relate to my case** using named work — never S-codes.
> Normal ≈ 30–60s · Design ≈ 90–120s · Tricky ≈ 90–120s.

---

## Normal questions

### Q1. Two Sum — hash vs sort? `(30–45s)`

**Answer:**

> If I need original indices, I scan once and store each value to index in a dictionary, looking up the complement target minus current. That’s expected O(n) time and O(n) space. Sorting plus two pointers is O(n log n) and better on auxiliary memory, but sorting loses indices unless I store value-index pairs first. I clarify duplicates and whether any pair is enough.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Multiset duplicates? | When looking up the complement, skip the same index — or track counts if equal values can form a valid pair. |
| Three Sum bridge? | Sort, then for each i two-pointer the rest and skip duplicate values for unique triplets — O(n²) after the sort. |
| Streaming one-pass constraint? | A hash map of seen values works in one forward pass; sorting needs the full array, so it fails a true streaming constraint. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q2. Top K frequent elements approach? `(30–45s)`

**Answer:**

> I count frequencies in a hash map, then either keep a min-heap of size K keyed by frequency for O(n log k), or bucket numbers by frequency for O(n) when frequencies are at most n. I clarify whether the output must be sorted. In a recommender, keeping top-K similar items is the same instinct — bound the elite set under a score.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Stream of numbers — Kth largest? | Keep a min-heap of size K over the stream; the root is the Kth largest after each insert. |
| Ties in frequency? | Clarify whether any tied set is fine or a deterministic tie-break (by value or insertion order) is required. |
| GymFlow: heap vs full sort of catalog? | Use a heap/top-K when GymFlow only needs the best K similar exercises; full-sort the catalog only if every rank must be shown. |

**How can I relate to my case:**
- **Shipped:** GymFlow on-device AI
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q3. Average vs worst-case for Dictionary? `(30–45s)`

**Answer:**

> A hash map gives expected O(1) lookup and insert. In the pathological collision case operations can degrade toward O(n), which I mention as theoretical in interviews while stating expected O(n) for a linear pass. Keys need a solid Hashable implementation — mutable or poorly distributed keys cause real pain.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why not hash a class instance identity carelessly? | Identity-based hashing treats equal-by-value objects as different keys, and mutable identity/hash can corrupt the map after insert. |
| BookMyShow synchronised dictionaries — sync access vs hash complexity? | The serial/sync boundary removes races on BookMyShow’s shared maps; it doesn’t change expected O(1) hash lookup cost once you’re inside the queue. |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Exact crash %, “fixed all BMS crashes,” or claiming lab SafeDict.swift was the shipped file.

---

### Q4. When is a heap the wrong tool? `(30–45s)`

**Answer:**

> A heap is wrong when I need the fully sorted order anyway, when I need keyed random access, when K is basically n so O(n log k) ≈ O(n log n), or when I must delete arbitrary elements by id without an index handle. In those cases I sort, use a dictionary, or an indexed priority queue design.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Indexed priority queue sketch? | Pair a heap with a dictionary from id → heap index so decrease-key/delete can sift in O(log n) instead of a linear scan. |
| Quickselect alternative? | Partition like quicksort to find the Kth in expected O(n) — good when you only need the Kth (or unordered top-K), not a maintained heap stream. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q5. Sliding window + hash — longest substring without repeating? `(45s)`

**Answer:**

> I slide a window with a map of characters to last seen index or counts. I expand the right pointer; when I see a duplicate inside the window I advance the left until the invariant holds, and I track the max length. Time O(n). The same map hygiene shows up in ‘exactly K distinct’ problems — I shrink when distinct count exceeds K.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Exactly K distinct characters? | Compute atMost(K) minus atMost(K−1) with a sliding window that tracks distinct character counts. |
| Unicode / String indexing in Swift? | Iterate `Character`s (or follow the problem’s defined unit); `String.Index` isn’t random-access `Int`, so don’t treat Swift strings like C arrays. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q6. Unknown-pattern: first 90 seconds — what do you say? `(45–60s)`

**Answer:**

> I restate the problem and constraints — sorted, online, duplicates, memory. I give a one-line brute force. Then I classify: do I need counts or complements, best K, a contiguous window, a tree shape, or sorted order I can exploit. I pick one structure and briefly reject an alternative, state complexity and edges, and only then code. If I’m wrong, I narrate the pivot instead of silent thrashing.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Demo on an unlabeled Medium aloud. | Pick any Medium and speak the 90-second script before coding — restate, brute force, classify structure, complexity, edges. |
| Tie to machine-round Day 25 discipline. | Same cadence at larger scale: clarify early, ship one happy path, narrate pivots, reserve time for tests — Day 25 just stretches it to hours. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

## Tricky questions

## Suggested record set

