# Audio script — Sample 07 — Revision Q&A (day-23) (Q&A)
> Listen-only sample Q&A from `07-revision-qna.md`. Spoken answers and follow-ups.

## §0 Q1. Two Sum — hash vs sort? `(30–45s)`

Next. Q1. Two Sum — hash vs sort? `(30–45s)` Answer. If I need original indices, I scan once and store each value to index in a dictionary, looking up the complement target minus current. That’s expected O(n) time and O(n) space. Sorting plus two pointers is O(n log n) and better on auxiliary memory, but sorting loses indices unless I store value-index pairs first. I clarify duplicates and whether any pair is enough. Follow-ups. Multiset duplicates?: When looking up the complement, skip the same index — or track counts if equal values can form a valid pair.. Three Sum bridge?: Sort, then for each i two-pointer the rest and skip duplicate values for unique triplets — O(n²) after the sort.. Streaming one-pass constraint?: A hash map of seen values works in one forward pass; sorting needs the full array, so it fails a true streaming constraint..

## §1 Q2. Top K frequent elements approach? `(30–45s)`

Next. Q2. Top K frequent elements approach? `(30–45s)` Answer. I count frequencies in a hash map, then either keep a min-heap of size K keyed by frequency for O(n log k), or bucket numbers by frequency for O(n) when frequencies are at most n. I clarify whether the output must be sorted. In a recommender, keeping top-K similar items is the same instinct — bound the elite set under a score. Follow-ups. Stream of numbers — Kth largest?: Keep a min-heap of size K over the stream; the root is the Kth largest after each insert.. Ties in frequency?: Clarify whether any tied set is fine or a deterministic tie-break (by value or insertion order) is required.. GymFlow: heap vs full sort of catalog?: Use a heap/top-K when GymFlow only needs the best K similar exercises; full-sort the catalog only if every rank must be shown..

## §2 Q3. Average vs worst-case for Dictionary? `(30–45s)`

Next. Q3. Average vs worst-case for Dictionary? `(30–45s)` Answer. A hash map gives expected O(1) lookup and insert. In the pathological collision case operations can degrade toward O(n), which I mention as theoretical in interviews while stating expected O(n) for a linear pass. Keys need a solid Hashable implementation — mutable or poorly distributed keys cause real pain. Follow-ups. Why not hash a class instance identity carelessly?: Identity-based hashing treats equal-by-value objects as different keys, and mutable identity/hash can corrupt the map after insert.. BookMyShow synchronised dictionaries — sync access vs hash complexity?: The serial/sync boundary removes races on BookMyShow’s shared maps; it doesn’t change expected O(1) hash lookup cost once you’re inside the queue..

## §3 Q4. When is a heap the wrong tool? `(30–45s)`

Next. Q4. When is a heap the wrong tool? `(30–45s)` Answer. A heap is wrong when I need the fully sorted order anyway, when I need keyed random access, when K is basically n so O(n log k) ≈ O(n log n), or when I must delete arbitrary elements by id without an index handle. In those cases I sort, use a dictionary, or an indexed priority queue design. Follow-ups. Indexed priority queue sketch?: Pair a heap with a dictionary from id → heap index so decrease-key/delete can sift in O(log n) instead of a linear scan.. Quickselect alternative?: Partition like quicksort to find the Kth in expected O(n) — good when you only need the Kth (or unordered top-K), not a maintained heap stream..

## §4 Q5. Sliding window + hash — longest substring without repeating? `(45s)`

Next. Q5. Sliding window + hash — longest substring without repeating? `(45s)` Answer. I slide a window with a map of characters to last seen index or counts. I expand the right pointer; when I see a duplicate inside the window I advance the left until the invariant holds, and I track the max length. Time O(n). The same map hygiene shows up in ‘exactly K distinct’ problems — I shrink when distinct count exceeds K. Follow-ups. Exactly K distinct characters?: Compute atMost(K) minus atMost(K−1) with a sliding window that tracks distinct character counts.. Unicode / String indexing in Swift?: Iterate Characters (or follow the problem’s defined unit); String.Index isn’t random-access Int, so don’t treat Swift strings like C arrays..

## §5 Q6. Unknown-pattern: first 90 seconds — what do you say? `(45–60s)`

Next. Q6. Unknown-pattern: first 90 seconds — what do you say? `(45–60s)` Answer. I restate the problem and constraints — sorted, online, duplicates, memory. I give a one-line brute force. Then I classify: do I need counts or complements, best K, a contiguous window, a tree shape, or sorted order I can exploit. I pick one structure and briefly reject an alternative, state complexity and edges, and only then code. If I’m wrong, I narrate the pivot instead of silent thrashing. Follow-ups. Demo on an unlabeled Medium aloud.: Pick any Medium and speak the 90-second script before coding — restate, brute force, classify structure, complexity, edges.. Tie to machine-round Day 25 discipline.: Same cadence at larger scale: clarify early, ship one happy path, narrate pivots, reserve time for tests — Day 25 just stretches it to hours..

## §6 Q7. What is the one rule to remember for day-23? `(30–45s)`

Next. Q7. What is the one rule to remember for day-23? `(30–45s)` Answer. “Keep a clear boundary, speak simply, and prove with a small example. For day-23, lead with the mental model before APIs.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §7 Q8. What is the one rule to remember for day-23? `(30–45s)`

Next. Q8. What is the one rule to remember for day-23? `(30–45s)` Answer. “Keep a clear boundary, speak simply, and prove with a small example. For day-23, lead with the mental model before APIs.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §8 Q9. What is the one rule to remember for day-23? `(30–45s)`

Next. Q9. What is the one rule to remember for day-23? `(30–45s)` Answer. “Keep a clear boundary, speak simply, and prove with a small example. For day-23, lead with the mental model before APIs.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §9 Q10. What is the one rule to remember for day-23? `(30–45s)`

Next. Q10. What is the one rule to remember for day-23? `(30–45s)` Answer. “Keep a clear boundary, speak simply, and prove with a small example. For day-23, lead with the mental model before APIs.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence.. Indirect questions These do not name the concept first. Speak from the symptom, scenario, or junior question.

## §10 I1. A junior asks you in standup: “Two Sum — hash vs sort?” — how do you answer without jargon? `(60–90s)`

Next. I1. A junior asks you in standup: “Two Sum — hash vs sort?” — how do you answer without jargon? `(60–90s)` Answer. “If I need original indices, I scan once and store each value to index in a dictionary, looking up the complement target minus current. That’s expected O(n) time and O(n) space. Sorting plus two pointers is O(n log n) and better on auxiliary memory, but sorting loses indices unless I store value-index pairs first. I clarify duplicates and whether any pair is enough.” Follow-ups. What concept is this really?: Two Sum — hash vs sort. How do you prove it?: Give a tiny example or production boundary..

## §11 I2. Production symptom: something related to “Top K frequent elements approach” just broke under load. What do you check first? `(60–90s)`

Next. I2. Production symptom: something related to “Top K frequent elements approach” just broke under load. What do you check first? `(60–90s)` Answer. “I count frequencies in a hash map, then either keep a min-heap of size K keyed by frequency for O(n log k), or bucket numbers by frequency for O(n) when frequencies are at most n. I clarify whether the output must be sorted. In a recommender, keeping top-K similar items is the same instinct — bound the elite set under a score.” Follow-ups. What concept is this really?: Top K frequent elements approach. How do you prove it?: Give a tiny example or production boundary..

## §12 I3. Interviewer never names the topic. They describe a mess that maps to “Average vs worst-case for Dictionary”. How do you diagnose? `(60–90s)`

Next. I3. Interviewer never names the topic. They describe a mess that maps to “Average vs worst-case for Dictionary”. How do you diagnose? `(60–90s)` Answer. “A hash map gives expected O(1) lookup and insert. In the pathological collision case operations can degrade toward O(n), which I mention as theoretical in interviews while stating expected O(n) for a linear pass. Keys need a solid Hashable implementation — mutable or poorly distributed keys cause real pain.” Follow-ups. What concept is this really?: Average vs worst-case for Dictionary. How do you prove it?: Give a tiny example or production boundary..

## §13 I4. Code review: you spot a smell around “When is a heap the wrong tool”. What do you say and what fix do you propose? `(60–90s)`

Next. I4. Code review: you spot a smell around “When is a heap the wrong tool”. What do you say and what fix do you propose? `(60–90s)` Answer. “A heap is wrong when I need the fully sorted order anyway, when I need keyed random access, when K is basically n so O(n log k) ≈ O(n log n), or when I must delete arbitrary elements by id without an index handle. In those cases I sort, use a dictionary, or an indexed priority queue design.” Follow-ups. What concept is this really?: When is a heap the wrong tool. How do you prove it?: Give a tiny example or production boundary..

## §14 I5. What happens if a teammate ignores the rule behind “Sliding window + hash — longest substring without repeating”? `(60–90s)`

Next. I5. What happens if a teammate ignores the rule behind “Sliding window + hash — longest substring without repeating”? `(60–90s)` Answer. “I slide a window with a map of characters to last seen index or counts. I expand the right pointer; when I see a duplicate inside the window I advance the left until the invariant holds, and I track the max length. Time O(n). The same map hygiene shows up in ‘exactly K distinct’ problems — I shrink when distinct count exceeds K.” Follow-ups. What concept is this really?: Sliding window + hash — longest substring without repeating. How do you prove it?: Give a tiny example or production boundary..

## §15 I6. Walk me through a failed interview answer on “Unknown-pattern: first 90 seconds — what do you say” and how you’d correct it? `(60–90s)`

Next. I6. Walk me through a failed interview answer on “Unknown-pattern: first 90 seconds — what do you say” and how you’d correct it? `(60–90s)` Answer. “I restate the problem and constraints — sorted, online, duplicates, memory. I give a one-line brute force. Then I classify: do I need counts or complements, best K, a contiguous window, a tree shape, or sorted order I can exploit. I pick one structure and briefly reject an alternative, state complexity and edges, and only then code. If I’m wrong, I narrate the pivot instead of silent thrashing.” Follow-ups. What concept is this really?: Unknown-pattern: first 90 seconds — what do you say. How do you prove it?: Give a tiny example or production boundary.. Tricky questions / brain puzzles Cover the answer. Speak for ~90–120s. These separate “I read a blog” from “I’ve been burned.”.

## §16 T1. They push you to invent a metric you don’t have? `(90–120s)`

Next. T1. They push you to invent a metric you don’t have? `(90–120s)` Answer. “I refuse fake precision. I say what I measured, what I didn’t, and what I’d instrument next. Honesty beats a made-up crash percentage.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §17 T2. They ask if your lab demo was the shipped file? `(90–120s)`

Next. T2. They ask if your lab demo was the shipped file? `(90–120s)` Answer. “I separate Learning-lab sketches from Verified production. Lab code teaches the idea; shipped systems may differ. I never claim the demo file was production.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §18 T3. They want a one-tool forever answer? `(90–120s)`

Next. T3. They want a one-tool forever answer? `(90–120s)` Answer. “I pick a default for the constraint, then name the trade-off and when I’d switch. Senior answers are context-bound, not slogan-bound.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §19 T4. Race vs deadlock — they mix the terms? `(90–120s)`

Next. T4. Race vs deadlock — they mix the terms? `(90–120s)` Answer. “Race is unsynchronized shared mutation — corruption and Heisenbugs. Deadlock is waiting forever on an order you can’t break. Fix races with a clear exclusion boundary; fix deadlocks by never syncing onto the queue you’re already on.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §20 T5. Main-thread rule under pressure? `(90–120s)`

Next. T5. Main-thread rule under pressure? `(90–120s)` Answer. “U I work on main. Heavy parse/decode off main. Hop back with async, not sync from main. If the app freezes, I look for sync-to-self or main-queue overload first.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §21 T6. Cancellation honesty? `(90–120s)`

Next. T6. Cancellation honesty? `(90–120s)` Answer. “Cancel in-flight work when the screen goes away. Weak self in completions. Structured tasks cancel children. I don’t claim cancellation if I only nil’d a delegate.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §22 T7. Cache invalidation trap? `(90–120s)`

Next. T7. Cache invalidation trap? `(90–120s)` Answer. “I define TTL, version keys, and a clear bust path. Stale U I with a spinner is often better than corrupt merge. I say what is source of truth.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §23 T8. Security theater vs real pinning? `(90–120s)`

Next. T8. Security theater vs real pinning? `(90–120s)` Answer. “Pinning without rotation and a kill-switch is how you brick clients. I describe SPKI pins, backup pins, and remote config escape hatches.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §24 T9. SDUI unknown component in prod? `(90–120s)`

Next. T9. SDUI unknown component in prod? `(90–120s)` Answer. “Unknown type must degrade — skip, placeholder, or safe fallback — never crash the screen. Schema version and registry discipline matter more than fancy rendering.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §25 T10. DI vs singletons under test? `(90–120s)`

Next. T10. DI vs singletons under test? `(90–120s)` Answer. “I inject boundaries at the feature edge so tests replace networking and clocks. Global singletons make flaky tests and hidden order dependence.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..
