# Audio script — Sample 03 — Mixed unknown-pattern (Q&A)
> Listen-only sample Q&A from `03-mixed-unknown-pattern.md`. Spoken answers and follow-ups.

## §0 Q1. What is the 90-second unknown-pattern protocol?

Next. Q1. What is the 90-second unknown-pattern protocol? Answer. First 90 seconds on unlabeled Mediums: (1) restate + constraints (sorted? online? duplicates? memory?). (2) brute one sentence. (3) classify: array scan / two pointer / window / hash / heap / tree / graph / binary search / DP-lite. (4) pick one and reject one alternative aloud. Do not code until step 4 is done. Follow-ups. Goal in drills?: 5/6 correct pattern tags before coding.. Timer?: 90s classification only — write pattern name, then solve or skip.. Anti-pattern?: Silent coding with no classification..

## §1 Q2. How do I decide hash vs heap vs window?

Next. Q2. How do I decide hash vs heap vs window? Answer. Hash if you need counts, complements, seen set, grouping, or prefix state (especially with negatives). Heap if you always care about “best K so far” or merge K sorted streams. Window / prefix if constraint is contiguous subarray/substring. Tree if hierarchy/nested (Day 22). Two pointer / BS if sorted property is explicit. DP only when overlapping subproblems are stated — don’t force today. Follow-ups. “Feels hard” → DP?: Anti-pattern — try hash/heap/tree first.. Sorted + need indices?: Hash or index map — not blind sort.. Online stream?: Heap size K strong signal..

## §2 Q3. How do I recover from a wrong pattern pick?

Next. Q3. How do I recover from a wrong pattern pick? Answer. Narrate the pivot aloud: “I started window but negatives break monotonicity — switching to prefix+hash.” Seniors narrate; juniors silently thrash. Restate complexity after pivot. Better a clean pivot at 5 minutes than wrong code for 25. Follow-ups. Interviewer hint?: Incorporate into restated plan — don’t ignore.. Two patterns hybrid?: Sometimes hash + heap (top-K freq) — say both.. Still stuck at 10 min?: Brute that runs — partial credit beats blank IDE..

## §3 Q4. What is the unknown-pattern spoken script?

Next. Q4. What is the unknown-pattern spoken script? Answer. “I’ll classify in 90 seconds: constraints → brute → hash/heap/window/tree → commit. Clarify uniqueness, order, online vs offline. Then name edges and complexity before coding.” Follow-ups. Example pivot line?: “Contiguous sum with negatives — prefix map, not two pointers.”. Reject alternative aloud?: “Not DP — no overlapping subproblem stated; hash one-pass fits.”. Mixed drill block?: 6 blind problems: 90s tag each, then solve — see exercises..

## §4 Q5. Approach scripts for two-layer Q&A?

Next. Q5. Approach scripts for two-layer Q&A? Answer. Use as Answer points spines: Two Sum — indices? hash complement; else sort+two pointer. Anagrams — sorted or count key. Subarray sum K — negatives? prefix+hash. Top K freq — count → heap K or bucket. Merge K — heap heads O(N log K). Unknown — clarify → brute → classify → pick → edges. Follow-ups. Where practiced?:../04-questions.md two-layer format.. 60s vs 90s?: Classification 90s; family-specific script ~60s inside.. Record yourself?: Suggested record set in questions module..

## §5 Q6. What trade-offs belong in mixed problems?

Next. Q6. What trade-offs belong in mixed problems? Answer. Hash: O(n) space, key-design bugs. Sort+two pointer: loses indices unless pairs kept. Heap size K: comparator bugs, O(n log k). Full sort: overkill for top-K. Bucket: extra structure, clarity win. TreeMap/sorted dict: rare on i O S LC. Pick one and name cost. Follow-ups. Memory tight?: Sort in-place + two pointer — say O(n log n).. Need full order?: Sort beats heap.. Freq bounded small?: Counting sort / bucket beats heap..

## §6 Q7. Checklist before leaving Day 23 foundations?

Next. Q7. Checklist before leaving Day 23 foundations? Answer. Two Sum hash script clean. Min-heap size K for Kth largest explained. Negatives → prefix+hash internalized. 90s unknown-pattern protocol rehearsed once. Swift gotchas named if relevant (String index, removeFirst). Follow-ups. Exit criteria?: See../05-exercises.md — hash block, heap block, mixed simulation mandatory.. Code lab first?: Read code/HashPatterns.swift and HeapPatterns.swift before inventing.. Next sample?: Production hooks — maps and top-K without cosplay.. Next: 04-production-maps-topk.md.
