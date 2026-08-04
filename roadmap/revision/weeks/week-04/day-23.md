# Day 23 — DSA HashMaps / Heaps + Mixed Unknown-Pattern Simulation

> Week 4 · Phase: DSA polish · Time budget today: ~4–5 hrs

## 1. Outcome

By end of day you can explain aloud (no notes):

- HashMap patterns: **frequency map, index map, prefix/state key, sliding window counts, two-sum family**, and when hashing beats sorting.
- Heap patterns: **Top-K, merge K, running median sketch, “K closest”, schedule/next event** — min-heap vs max-heap intuition in Swift (`Heap` / custom, or sorted array for tiny K with caveat).
- A **mixed unknown-pattern** drill: 60–90s to classify *before* coding, even when the topic isn’t labeled “heap.”
- Complexity scripts: average vs worst hash; heap `O(log k)` ops; space trade-offs.
- Stop pattern-worship: if stuck, fall back to brute → constrain → named structure.

## 2. Concept deep dive

### 2.1 HashMap pattern catalog

| Trigger | Pattern | Complexity script |
|---|---|---|
| “Two sum / complement” | value → index map | O(n) time / O(n) space; sorted two-pointer if mutable sort OK |
| “Group anagrams / isomorphic” | canonical key → list | Key = sorted string O(k log k) or count tuple O(k) |
| “Subarray sum equals K” | prefixSum → frequency | O(n); careful with 0 / negatives |
| “Longest substring without repeat” | window + last-seen index/count | O(n) sliding window |
| “First unique / LRU building block” | ordered dict mental model | Dict + doubly list in design interviews; LC may allow `Dictionary` + heuristics |
| “Clone graph / random pointer” | old → new map | O(n); DFS/BFS + map |
| “Time-based / snapshot” | key → sorted timestamps | Binary search values |

**Say this first (hash):**

> “I’ll clarify uniqueness and whether order matters. Brute is nested loops O(n²). Optimized: hash complements / frequencies for expected O(n). Worst-case hash degradation is theoretical on interviews — I’ll state expected O(n). Edges: empties, duplicates, negatives, unicode keys if strings.”

### 2.2 Heap pattern catalog

| Trigger | Pattern | Notes |
|---|---|---|
| Top K frequent / largest | size-K heap | Freq map then heap; or bucket sort O(n) when constrained |
| Kth largest in stream | min-heap size K | Root = kth |
| Merge K sorted lists | min-heap of heads | O(N log K) |
| K closest points | max-heap size K by distance | Or quickselect |
| Meeting rooms / CPU intervals | sort + min-heap of ends | Classic scheduling |
| Reorganize string / task scheduler | max-heap by freq + cooldown | Greedy with heap |

**Heap complexity script:**

> “Each offer/poll is O(log k). Building from n with heapify is O(n). For top-K I keep heap size K → O(n log k), better than full sort O(n log n) when k ≪ n.”

**Swift interview note:** Prefer clarity — `var heap` with clear comparator comments, or sort when n is small and you say so. Don’t lose the round fighting PriorityQueue boilerplate; narrate operations.

### 2.3 Mixed unknown-pattern simulation (today’s differentiator)

Interviewers often paste an unlabeled Medium. Your job in the first **90 seconds**:

1. **Restate + constraints** (sorted? online? duplicates? memory?).
2. **Brute** one sentence.
3. **Classify:** array scan / two pointer / window / hash / heap / tree / graph / binary search / DP-lite.
4. **Pick one** and justify; mention alternative you rejected.

**Classification cheat sheet (ask yourself):**

| Question | If yes → |
|---|---|
| Need counts / complements / seen set? | Hash |
| Always care about “best K so far”? | Heap |
| Contiguous constraint? | Window / prefix |
| Sorted property exploitable? | Two pointer / binary search |
| Hierarchy / nested? | Tree DFS/BFS (Day 22) |
| Overlapping subproblems stated? | DP (don’t force today) |

**Drill protocol (90 min block):**

- Blindfold topic: pick **6** mixed problems from [dsa-track.md](../../coding/dsa-track.md) Mixed / review set (or random Mediums tagged Array/Hash/Heap/Tree).
- For each: **timer 90s classification only** (no code) → write pattern name on paper → then solve or skip to next if over time budget.
- Goal: **5/6 correct pattern tags** before coding.

### 2.4 Trade-offs

| Choice | When | Cost |
|---|---|---|
| HashMap | Lookups, counts, grouping | O(n) space; worse locality; key design bugs |
| Sort + two pointer | Memory tight, sorted OK | Destroys indices unless index pairs kept; O(n log n) |
| Heap size K | Top-K online or streaming | O(n log k); comparator bugs |
| Full sort | Need full order anyway | Overkill for top-K |
| Bucket / counting sort | Freq in bounded range | Extra O(n) buckets; interview clarity win for “top K frequent” |
| TreeMap / sorted dict | Range queries on keys | Heavier; rarely needed on iOS LC |

### 2.5 Failure modes seniors mention

- Hashing **mutable** objects as keys (don’t).
- Forgetting to **decrement/remove** keys at zero in window maps (memory + correctness).
- Using max-heap when you needed min-heap for “Kth largest stream.”
- Returning heap contents **unsorted** when problem wants sorted top-K — clarify.
- Mixed drill: jumping to DP because the problem “feels hard.”

## 3. Read these

| Priority | Resource | Why |
|---|---|---|
| Must | [coding/dsa-track.md](../../coding/dsa-track.md) — HashMap, Heap, Mixed sections | Problem IDs + logging format |
| Must | [timing/answer-timing-guide.md](../../timing/answer-timing-guide.md) | Coding agenda under pressure |
| Deepen | Day 22 tree flashcards (quick skim) | Mixed set will include 1–2 trees |
| Repo | — | Pure DSA day; AI is Day 24 |

## 4. Map to your work

**Company / feature:** BMS search debounce + request coalescing; synchronised dictionaries; analytics event aggregation; GymFlow cosine top-K neighbors.  
**What you did:** Frequency/coalesce maps for network & state; top similar exercises via embeddings ≈ “K nearest” (heap/select mental model); crash/IMOC triage often starts with **keyed aggregation**.  
**Interview line (≤20s):**  
> “In product code I use maps for coalescing and counts, and top-K style selection for recommenders — same complexity instincts as heap/hash interview problems.”

→ STAR: [story-bank.md](../../stories/story-bank.md)#S2 · #S3 · #S16

## 5. Normal questions

### Q1. Two Sum — hash vs sort? `(30–45s)`
**Skeleton:** Hash complement O(n)/O(n); sort + two pointer O(n log n)/O(1) aux but loses indices unless store pairs. Prefer hash when need original indices.  
**Follow-up:** Multiset duplicates?  
**Story:** —

### Q2. Top K frequent elements approach? `(30–45s)`
**Skeleton:** Count map → min-heap size K **or** bucket by frequency O(n). State O(n log k) vs O(n).  
**Follow-up:** Stream version?  
**Story:** GymFlow “top similar” at tiny K — heap/select OK.

### Q3. What is average vs worst-case for Dictionary? `(30–45s)`
**Skeleton:** Expected O(1) lookup; pathological collisions O(n) (theoretical in interview). Design: good hash + load factor.  
**Follow-up:** Swift `Hashable` pitfalls?  
**Story:** —

### Q4. When is a heap the wrong tool? `(30–45s)`
**Skeleton:** Need full sort; need random access by key; K ≈ n (just sort); need arbitrary delete-by-id without handle.  
**Follow-up:** Indexed priority queue?  
**Story:** —

### Q5. Sliding window + hash — longest substring without repeating? `(45s)`
**Skeleton:** Right expands; while duplicate, advance left using last-seen/count; track max length. O(n).  
**Follow-up:** Exactly K distinct?  
**Story:** —

## 6. Tricky questions

### T1. “Subarray sum equals K with negatives — why can’t I use two pointers?” `(90–120s)`
**Trap:** Sliding window monotonicity assumption.  
**Senior answer:** Negatives break window shrink logic. Use prefix sums + hash of prefix frequencies. O(n)/O(n). Two pointers work for non-negative only.  
**Follow-up:** Count of such subarrays vs boolean.

### T2. “Merge K sorted lists — why not concatenate and sort?” `(90–120s)`
**Trap:** Accepting O(N log N) without discussing K.  
**Senior answer:** Concat+sort works but heap-of-heads is O(N log K); better when K ≪ N. Mention divide-and-conquer merge.  
**Follow-up:** Memory if lists are lazy streams.

### T3. “Design a structure for O(1) insert, delete, getRandom” `(90–120s)`
**Trap:** Only HashMap (no random) or only array (delete O(n)).  
**Senior answer:** Dict value→index + array swap-with-last delete. Classic.  
**Follow-up:** Duplicates allowed? → multiset variant.

### T4. Unknown-pattern meta: “I don’t recognize this — what do you do?” `(90–120s)`
**Trap:** Silence or random DP.  
**Senior answer:** Clarify → brute on example → name constraints (online? contiguous? K?) → pick hash/heap/window/tree → state complexity → code brute if needed then optimize. Seniors communicate uncertainty with a plan.  
**Follow-up:** Tie to machine round Day 25 — same discipline under 3 hrs.

## 7. Flashcards for today

| Front | Back |
|---|---|
| Two Sum default | Hash complement O(n) · Trap: sort loses indices · Prod: id→model maps |
| Top-K heap size | Min-heap size K → O(n log k) · Trap: max-heap confusion for Kth largest stream · Prod: top similar items |
| Prefix sum + hash | Subarray sum K with negatives · Trap: two pointer · Prod: analytics rollups |
| Window + counts | Shrink when invariant breaks · Trap: forget remove at 0 · Prod: debounce coalescing keys |
| Merge K lists | Heap heads O(N log K) · Trap: full sort only · Prod: merge paginated cursors metaphor |
| Hash complexity say | Expected O(1); space O(n) · Trap: claiming worst O(1) always · Prod: synchronised dict access ≠ hash math |
| Unknown pattern 90s | Clarify brute classify pick · Trap: code silently · Prod: senior signal |
| Bucket top-K freq | O(n) when freq ≤ n · Trap: always heap · Prod: — |
| Heap wrong when | Need full order / keyed delete · Trap: heap for everything · Prod: — |
| Clone graph | Hash old→new + DFS/BFS · Trap: no map infinite loop · Prod: object graph copy |

## 8. Practice

- **Coding:** From [dsa-track.md](../../coding/dsa-track.md):
  - **Hash block (4–5):** Two Sum, Group Anagrams, Subarray Sum Equals K, Longest Substring Without Repeating, Top K Frequent (hash+heap bridge).
  - **Heap block (3–4):** Kth Largest Element, Merge K Sorted Lists, K Closest Points, Task Scheduler *(optional)*.
  - **Mixed simulation (6 tags @ 90s each, then solve ≥3):** include at least one tree from Day 22 leftovers and one “feels like DP but is hash/window.”

- **Complexity / agenda to say first:** Every problem: spoken script before code. For mixed set, **pattern tag must be written first** or restart the timer.

- **Anti-perfectionism:** If 25+ min stuck, write brute, state optimize idea, move on — log and revisit after mixed drill.

## 9. Timed drill

1. Pick **3 Normal + 2 Tricky** (§§5–6). Record.
2. Score vs [answer-timing-guide.md](../../timing/answer-timing-guide.md).
3. Extra: **one cold mixed Medium** — only 3-minute approach aloud (no code). Grade: Did you classify correctly?
4. Log gotchas: negatives + window, heap direction, silent coding urge.
