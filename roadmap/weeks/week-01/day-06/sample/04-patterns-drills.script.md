# Audio script — Sample 04 — Patterns, drills & Week 1 core set (Q&A)
> Listen-only sample Q&A from `04-patterns-drills.md`. Spoken answers and follow-ups.

## §0 Q1. When do I reach for a hash map?

Next. Q1. When do I reach for a hash map? Answer. When you need complements, counts, or last-seen indices in one pass — and sorting would destroy index information or cost too much. Two Sum, Group Anagrams, window duplicate tracking. Typical: O(n) time, O(n) space. Say what the key and value mean before coding. Follow-ups. Two Sum key?: Value → index seen so far.. Group Anagrams key?: Sorted string or char-frequency signature.. vs sorting?: Sort is O(n log n); hash is O(n) when order does not matter..

## §1 Q2. What is the prefix / suffix product pattern?

Next. Q2. What is the prefix / suffix product pattern? Answer. Output[i] = product of all elements except nums[i] without division. Two passes: prefix products left-to-right, suffix right-to-left (or one output array + one scalar). O(n) time, O(1) extra aside from output. Edges: zeros — at most one zero affects non-zero entries. Follow-ups. Why no division?: Interviewer constraint; also zero breaks division tricks.. One zero in array?: Only that index gets non-zero product; others get 0.. Space O(1)?: Output array often excluded from “extra” space — clarify..

## §2 Q3. What is the Week 1 minimum core set?

Next. Q3. What is the Week 1 minimum core set? Answer. Eight problems minimum today: Two Sum (hash), Best Time Buy/Sell Stock (running min), Valid Palindrome (two pointers), Container Water (opposite ends), Longest Substring (variable window), Maximum Subarray (Kadane), Product Except Self (prefix/suffix), Move Zeroes (write pointer). Stretch: 3Sum, Min Size Subarray Sum, Group Anagrams. Follow-ups. Solve cold how?: Read approach once → hide → re-speak → implement from code/.. Timed target?: 30–40 min per problem including approach script.. Which 3 if short on time?: Two Sum, Longest Substring, Max Subarray — pattern spread..

## §3 Q4. Say time and space for each core pattern?

Next. Q4. Say time and space for each core pattern? Answer. Hash one-pass: O(n) / O(n). Opposite two pointers (after sort): O(n log n) + O(n) scan, O(1) extra. Variable window: O(n) / O(alphabet). Kadane: O(n) / O(1). Prefix/suffix: O(n) / O(1) extra. Write pointer in-place: O(n) / O(1). Running min (stock): O(n) / O(1). Follow-ups. 3Sum overall?: Sort O(n log n) + two-pointer pass O(n²) worst case.. Longest substring space?: O(min(n, charset size)).. Two Sum brute?: O(n²) time, O(1) space — contrast when optimizing..

## §4 Q5. Best Time to Buy/Sell Stock — one-pass state?

Next. Q5. Best Time to Buy/Sell Stock — one-pass state? Answer. One transaction max. Track minimum price so far and max profit = price - min. O(n)/O(1). Edges: length 1 → 0; strictly decreasing → 0. Trap: sell before buy; update min before computing profit at each step. Follow-ups. Brute?: All buy/sell pairs O(n²).. Multiple transactions?: Different problem (greedy) — not Week 1 core.. Negative prices?: LeetCode usually non-negative — clarify..

## §5 Q6. 3Sum — how do hash, sort, and pointers combine?

Next. Q6. 3Sum — how do hash, sort, and pointers combine? Answer. Sort array O(n log n). Fix index i, run opposite pointers on i+1..<n for sum zero. Skip duplicate i and duplicate l/r after hits. O(n²) time typical. Say sort cost up front. Not a hash problem — pointers after sort handle duplicates cleanly. Follow-ups. Why not hash for triplets?: Duplicate triplet handling gets messy.. All zeros [0,0,0,0]?: One triplet [0,0,0] after skip logic.. No solution?: Return empty array..

## §6 Q7. How do I drill pattern ID without coding?

Next. Q7. How do I drill pattern ID without coding? Answer. Read prompt only → say pattern + 60s approach + time/space → no IDE. Use the decision tree: complements → hash; contiguous constraint → window; sorted/ends → pointers; in-place compact → write; max subarray → Kadane; range product → prefix/suffix. 15-minute flash sets in exercises. Follow-ups. Wrong pattern recovery?: Exercise 9 — restart with say-this-first, do not patch bad code.. Two patterns fit?: Match output: indices vs length vs count.. After drills?: Timed contest simulation in Exercise 4..

## §7 Q8. How does DSA connect to iOS interview talk (honestly)?

Next. Q8. How does DSA connect to iOS interview talk (honestly)? Answer. D S A in this repo is a communication skill — approach narration under uncertainty. Do not claim “I used Kadane in production ads.” Soft honest bridges: cancel in-flight work ≈ debounce (BookMyShow backend-driven header & search); pagination ≈ listing windows later. Grade is process + complexity speech, not resume metric invention. Follow-ups. Pivot to concurrency?: “Same clarity I’d use describing a serial queue A P I.”. Anti-pattern?: Invented BMS D S A war stories.. Catch-up rule?: Weak Day 03–05 topic 45–60 min beats a fourth Hard LC..
