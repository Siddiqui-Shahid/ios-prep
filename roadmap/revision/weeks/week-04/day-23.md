# Day 23 — DSA HashMap / Heap + Mixed Unknown-Pattern

> Week 4 · Revision pass ~45–60 min  
> Full study: [weeks/week-04/day-23/](../../../weeks/week-04/day-23/README.md)  
> Sample Q&A (guided): [weeks/week-04/day-23/sample/](../../../weeks/week-04/day-23/sample/README.md)

## 1. Outcome

Explain aloud, in plain sentences:

- Deploy **HashMap** patterns: frequency, complement, prefix+K, sliding-window counts — and when hashing beats sorting
- Deploy **Heap** patterns: Top-K, merge K, Kth in stream — min-heap size K for Kth **largest**
- Run the **90s classify-before-code** protocol on unlabeled problems
- Speak **expected vs worst** hash complexity honestly; stop pattern-worship when stuck

## 2. Concept refresh (simple)

### 2.1 HashMap triggers

| Pattern | Key idea |
|---|---|
| Two-sum family | Complement lookup — design a good **key** |
| Frequency / anagram | Count map |
| Subarray sum K | **Prefix sum + hash** — not sliding window |
| Sliding window | Count map with expand/shrink |

Expected **O(1)** lookup; pathological collisions → worst **O(n)**. Say **expected O(n)** for one-pass solutions.

### 2.2 Heap triggers

| Pattern | Heap choice |
|---|---|
| Kth largest / Top-K | **Min-heap size K** — root is answer |
| Kth smallest | Max-heap size K (or min-heap on negated) |
| Merge K sorted | Min-heap of heads — **O(n log k)** |
| K closest | Max-heap size K on distance |

### 2.3 Unknown-pattern protocol

**90s before coding:** restate → brute force → constrain input → name structure → commit. Stuck → brute → constrain → pivot — not DP worship.

### 2.4 Critical truths (pin)

| Claim | Truth |
|---|---|
| Hash | Expected O(1) lookup — design a good **key** |
| Heap Top-K | Min-heap size K for Kth **largest** — root is answer |
| Negatives + subarray sum | **Prefix+hash** — not sliding window |
| Unknown pattern | 90s classify **before** coding |
| Average vs worst hash | Say expected O(n); pathological collisions exist |
| Production | Maps for coalescing — not “search is Two Sum” |

## 3. Read these

| Priority | Resource | Why |
|---|---|---|
| Must | [Sample Q&A](../../../weeks/week-04/day-23/sample/) | Guided cards |
| Must | Full modules [01–03](../../../weeks/week-04/day-23/01-foundations.md) | Catalogs + mixed drill |
| Drill | [07-revision-qna](../../../weeks/week-04/day-23/sample/07-revision-qna.md) | Timed answers |
| Code | [code/](../../../weeks/week-04/day-23/code/) | Two Sum, prefix+K, top-K |

## 4. Map to your work

**BookMyShow synchronised dictionaries:** Synchronised dictionaries — maps as shared mutable state needing a concurrency boundary, not “I optimized Dictionary hash.”  
**BookMyShow backend-driven header & search:** Search debounce — coalesce in-flight keys; cancel stale responses.  
**GymFlow on-device AI:** GymFlow cosine top-K — heap/select mental model for “best K neighbors,” not a claim you shipped `CFBinaryHeap`.

**Interview line (≤20s):** “In product code I treat maps as keyed aggregation with concurrency respect; recommender top-K is the product cousin of heap patterns with a lexical fallback.”

→ [BookMyShow synchronised dictionaries](../../stories/story-bank.md#s2--synchronised-dictionaries--shared-state-bookmyshow) · [BookMyShow backend-driven header & search](../../stories/story-bank.md#s3--backend-driven-header--search-bookmyshow) · [GymFlow on-device AI](../../stories/story-bank.md#s16--gymflow-on-device-ai-recommender)

Do **not** claim “our search is Two Sum” or invent latency % from heap choice.

## 5. Flash prompts

1. Two-sum complement — what is the key?
2. Subarray sum K — prefix+hash, not window
3. Top-K largest — min-heap size K, root is answer
4. Merge K lists — heap of heads, complexity
5. Expected vs worst hash — say both honestly
6. 90s classify protocol — restate, brute, constrain, name, commit
7. Stuck pivot — when to abandon forced DP
8. BookMyShow backend-driven header & search search coalescing ≤20s — keyed state, not LeetCode cosplay

## 6. Timed drills

| Drill | Budget |
|---|---|
| Hash pattern pick (3 prompts) | 90s |
| Heap Top-K setup | 60s |
| Prefix+hash vs window | 60s |
| 90s classify (unlabeled) | 90s |
| Expected vs worst complexity | 45s |
| GymFlow on-device AI top-K mapping ≤20s | 20s |

Expand from [sample cards](../../../weeks/week-04/day-23/sample/) and [07-revision-qna](../../../weeks/week-04/day-23/sample/07-revision-qna.md) answer points.
