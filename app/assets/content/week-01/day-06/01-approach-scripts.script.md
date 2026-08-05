# Audio script — Sample 01 — Approach scripts (Q&A)
> Listen-only sample Q&A from `01-approach-scripts.md`. Spoken answers and follow-ups.

## §0 Q1. What is the 60–90s “say this first” script?

Next. Q1. What is the 60–90s “say this first” script? Answer. Before typing, say: constraints (sorted? duplicates? mutate in place?), brute force and its complexity, the optimized pattern and why it works, time and space, then edge cases (empty, single element, all same). End with “coding the optimized version now.” If you skip this in practice, restart the problem. Follow-ups. Why not jump straight to code?: Interviews grade process under uncertainty. A clear plan buys trust even if you hit a bug.. What if constraints change mid-problem?: Restate the new plan out loud — never silently rewrite for ten minutes.. Minimum time box?: About 60–90 seconds. Longer means you are stalling; shorter means you skipped edges..

## §1 Q2. What should I clarify before choosing a pattern?

Next. Q2. What should I clarify before choosing a pattern? Answer. Ask: input size, sorted or not, duplicates allowed, return indices or values, can I mutate the array, empty input allowed, negative numbers, guaranteed unique answer. These answers pick hash map vs two pointers vs window vs Kadane. Say them out loud so the interviewer can steer you early. Follow-ups. “Can I sort?”: Sorting is O(n log n) — fine if it unlocks two pointers (3Sum), but say the cost.. “Mutate in place?”: Changes whether write-pointer patterns are allowed.. Duplicates matter how?: Two Sum needs distinct indices; 3Sum needs skip logic after sort..

## §2 Q3. How do I present brute force without sounding weak?

Next. Q3. How do I present brute force without sounding weak? Answer. Brute force is not failure — it is the baseline. Say “brute would be … O(?)” to show you understand the search space, then “I can do better because …” and name the pattern. Seniors always anchor optimal against brute so complexity trade-offs are obvious. Follow-ups. Interviewer says “just optimize”?: Give brute in one sentence, then pivot — do not skip entirely.. When is brute the answer?: Tiny n, or when asked to compare approaches before coding.. Example one-liner?: “All pairs is O(n²); one hash pass is O(n) time, O(n) space.”.

## §3 Q4. What edge cases should I mention every time?

Next. Q4. What edge cases should I mention every time? Answer. Empty input, single element, all duplicates, all same value, all negative (Kadane), strictly decreasing (max profit → 0), no valid pair, unicode vs ASCII (strings). You do not need to code every edge — naming them shows you will not ship a fragile solution. Follow-ups. All-negative Kadane?: Largest single element — the max(x, running+x) form handles it.. Empty string palindrome?: Usually true — confirm with interviewer.. Two Sum no solution?: Return empty or [-1,-1] per prompt — clarify..

## §4 Q5. When must I state time and space complexity?

Next. Q5. When must I state time and space complexity? Answer. Right after you name the optimized approach — every time. Pair the pattern with “O(n) time, O(n) space” (or O(1) extra). If output array is excluded from space by convention, say so. Omitting complexity is a common reason strong code still scores low. Follow-ups. O(1) space with output array?: Clarify: O(1) extra aside from required output.. Sort then two pointers?: O(n log n) time from sort + O(n) scan — state both.. Hash map space?: O(n) worst case for stored entries..

## §5 Q6. What senior phrases signal good communication?

Next. Q6. What senior phrases signal good communication? Answer. “I’d clarify whether we can mutate the input.” “Brute is clear; here’s why we can do better.” “I’ll dry-run on this example before coding further.” “If you need O(1) space, we can discuss trade-offs.” These show you think like a teammate, not a silent solver. Follow-ups. Anti-pattern?: Ten minutes of typing with no plan update after a hint.. Dry-run when?: After stating approach, before or during early coding.. Constraint change?: Restate plan — do not pretend the old code still fits..

## §6 Q7. Walk through say-this-first on Two Sum.

Next. Q7. Walk through say-this-first on Two Sum Answer. “Constraints? Duplicates? Guaranteed one answer? Brute: all pairs O(n²). Sorting loses original indices unless I store pairs. I’ll scan once: for each value look up target - value in a dictionary of value→index, else store current. Time O(n), space O(n). Edges: empty, no pair, negatives, duplicates. Coding now.” Follow-ups. Invariant?: Map holds values seen so far with an index.. Trap?: Returning values instead of indices; using same element twice.. Dry-run?: [2,7,11,15], target 9 → at 7 find 2 → [0,1].. Next: 02-two-pointers-window.md.
