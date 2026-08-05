# Sample 04 — Patterns, drills & Week 1 core set (Q&A)

> Guided teaching. Each answer stands alone; **Points to** shows where the full module expands the idea.

---

### Q1. When do I reach for a hash map?

**Points to:** [Foundations · §2 Pattern cheatsheet](../01-foundations.md#2-pattern-cheatsheet-embedded--no-external-read-required) · [Deep dive · §1 Two Sum](../02-deep-dive.md#1-two-sum) · [Deep dive · §11 Group Anagrams](../02-deep-dive.md#11-group-anagrams-bridge)

**Answer:**

> When you need **complements**, **counts**, or **last-seen indices** in one pass — and sorting would destroy index information or cost too much. Two Sum, Group Anagrams, window duplicate tracking. Typical: O(n) time, O(n) space. Say what the key and value mean before coding.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Two Sum key? | Value → index seen so far. |
| Group Anagrams key? | Sorted string or char-frequency signature. |
| vs sorting? | Sort is O(n log n); hash is O(n) when order does not matter. |

---

### Q2. What is the prefix / suffix product pattern?

**Points to:** [Foundations · §2 Pattern cheatsheet](../01-foundations.md#2-pattern-cheatsheet-embedded--no-external-read-required) · [Deep dive · §7 Product Except Self](../02-deep-dive.md#7-product-of-array-except-self)

**Answer:**

> Output[i] = product of all elements except nums[i] without division. Two passes: prefix products left-to-right, suffix right-to-left (or one output array + one scalar). O(n) time, O(1) extra aside from output. Edges: zeros — at most one zero affects non-zero entries.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why no division? | Interviewer constraint; also zero breaks division tricks. |
| One zero in array? | Only that index gets non-zero product; others get 0. |
| Space O(1)? | Output array often excluded from “extra” space — clarify. |

---

### Q3. What is the Week 1 minimum core set?

**Points to:** [Foundations · §5 Core problem set](../01-foundations.md#5-core-problem-set-week-1-day-06) · [README · Files in code](../README.md#files-in-code)

**Answer:**

> Eight problems minimum today: Two Sum (hash), Best Time Buy/Sell Stock (running min), Valid Palindrome (two pointers), Container Water (opposite ends), Longest Substring (variable window), Maximum Subarray (Kadane), Product Except Self (prefix/suffix), Move Zeroes (write pointer). Stretch: 3Sum, Min Size Subarray Sum, Group Anagrams.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Solve cold how? | Read approach once → hide → re-speak → implement from [`code/`](../code/). |
| Timed target? | 30–40 min per problem including approach script. |
| Which 3 if short on time? | Two Sum, Longest Substring, Max Subarray — pattern spread. |

---

### Q4. Say time and space for each core pattern.

**Points to:** [Foundations · §9 Complexity cheat sheet](../01-foundations.md#9-complexity-cheat-sheet-say-out-loud) · [Deep dive · §16 Brute → optimal comparison table](../02-deep-dive.md#16-brute--optimal-comparison-table)

**Answer:**

> Hash one-pass: O(n) / O(n). Opposite two pointers (after sort): O(n log n) + O(n) scan, O(1) extra. Variable window: O(n) / O(alphabet). Kadane: O(n) / O(1). Prefix/suffix: O(n) / O(1) extra. Write pointer in-place: O(n) / O(1). Running min (stock): O(n) / O(1).

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| 3Sum overall? | Sort O(n log n) + two-pointer pass O(n²) worst case. |
| Longest substring space? | O(min(n, charset size)). |
| Two Sum brute? | O(n²) time, O(1) space — contrast when optimizing. |

---

### Q5. Best Time to Buy/Sell Stock — one-pass state?

**Points to:** [Deep dive · §2 Best Time to Buy and Sell Stock](../02-deep-dive.md#2-best-time-to-buy-and-sell-stock) · [code/MaxProfit.swift](../code/MaxProfit.swift)

**Answer:**

> One transaction max. Track minimum price so far and max profit = price - min. O(n)/O(1). Edges: length 1 → 0; strictly decreasing → 0. Trap: sell before buy; update min before computing profit at each step.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Brute? | All buy/sell pairs O(n²). |
| Multiple transactions? | Different problem (greedy) — not Week 1 core. |
| Negative prices? | LeetCode usually non-negative — clarify. |

---

### Q6. 3Sum — how do hash, sort, and pointers combine?

**Points to:** [Deep dive · §9 3Sum (stretch)](../02-deep-dive.md#9-3sum-stretch) · [code/ThreeSum.swift](../code/ThreeSum.swift)

**Answer:**

> Sort array O(n log n). Fix index i, run opposite pointers on i+1..<n for sum zero. Skip duplicate i and duplicate l/r after hits. O(n²) time typical. Say sort cost up front. Not a hash problem — pointers after sort handle duplicates cleanly.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why not hash for triplets? | Duplicate triplet handling gets messy. |
| All zeros `[0,0,0,0]`? | One triplet `[0,0,0]` after skip logic. |
| No solution? | Return empty array. |

---

### Q7. How do I drill pattern ID without coding?

**Points to:** [Deep dive · §12 Pattern ID drills](../02-deep-dive.md#12-pattern-id-drills-no-code) · [05-exercises · Exercise 3](../05-exercises.md#exercise-3--pattern-id-flash-15-min)

**Answer:**

> Read prompt only → say pattern + 60s approach + time/space → no IDE. Use the decision tree: complements → hash; contiguous constraint → window; sorted/ends → pointers; in-place compact → write; max subarray → Kadane; range product → prefix/suffix. 15-minute flash sets in exercises.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Wrong pattern recovery? | Exercise 9 — restart with say-this-first, do not patch bad code. |
| Two patterns fit? | Match output: indices vs length vs count. |
| After drills? | Timed contest simulation in Exercise 4. |

---

### Q8. How does DSA connect to iOS interview talk (honestly)?

**Points to:** [Production bridge · §1 How seniors talk about DSA](../03-production-bridge.md#1-how-seniors-talk-about-dsa) · [Production bridge · §3 When DSA pivots to iOS](../03-production-bridge.md#3-when-dsa-interviews-pivot-to-ios)

**Answer:**

> DSA in this repo is a **communication skill** — approach narration under uncertainty. Do not claim “I used Kadane in production ads.” Soft honest bridges: cancel in-flight work ≈ debounce (S3); pagination ≈ listing windows later. Grade is process + complexity speech, not resume metric invention.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Pivot to concurrency? | “Same clarity I’d use describing a serial queue API.” |
| Anti-pattern? | Invented BMS DSA war stories. |
| Catch-up rule? | Weak Day 03–05 topic 45–60 min beats a fourth Hard LC. |

---

Back to: [README.md](README.md) · Main modules: [`../04-questions.md`](../04-questions.md)
