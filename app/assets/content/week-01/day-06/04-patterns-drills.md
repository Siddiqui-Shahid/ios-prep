# Sample 04 — Patterns, drills & Week 1 core set (Q&A)

> Guided teaching. Each answer stands alone and ends with **How can I relate to my case** using named work — never S-codes.

---

### Q1. When do I reach for a hash map?
**Answer:**

> When you need **complements**, **counts**, or **last-seen indices** in one pass — and sorting would destroy index information or cost too much. Two Sum, Group Anagrams, window duplicate tracking. Typical: O(n) time, O(n) space. Say what the key and value mean before coding.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Two Sum key? | Value → index seen so far. |
| Group Anagrams key? | Sorted string or char-frequency signature. |
| vs sorting? | Sort is O(n log n); hash is O(n) when order does not matter. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q2. What is the prefix / suffix product pattern?
**Answer:**

> Output[i] = product of all elements except nums[i] without division. Two passes: prefix products left-to-right, suffix right-to-left (or one output array + one scalar). O(n) time, O(1) extra aside from output. Edges: zeros — at most one zero affects non-zero entries.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why no division? | Interviewer constraint; also zero breaks division tricks. |
| One zero in array? | Only that index gets non-zero product; others get 0. |
| Space O(1)? | Output array often excluded from “extra” space — clarify. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q3. What is the Week 1 minimum core set?
**Answer:**

> Eight problems minimum today: Two Sum (hash), Best Time Buy/Sell Stock (running min), Valid Palindrome (two pointers), Container Water (opposite ends), Longest Substring (variable window), Maximum Subarray (Kadane), Product Except Self (prefix/suffix), Move Zeroes (write pointer). Stretch: 3Sum, Min Size Subarray Sum, Group Anagrams.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Solve cold how? | Read approach once → hide → re-speak → implement from [`code/`](../code/). |
| Timed target? | 30–40 min per problem including approach script. |
| Which 3 if short on time? | Two Sum, Longest Substring, Max Subarray — pattern spread. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q4. Say time and space for each core pattern?
**Answer:**

> Hash one-pass: O(n) / O(n). Opposite two pointers (after sort): O(n log n) + O(n) scan, O(1) extra. Variable window: O(n) / O(alphabet). Kadane: O(n) / O(1). Prefix/suffix: O(n) / O(1) extra. Write pointer in-place: O(n) / O(1). Running min (stock): O(n) / O(1).

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| 3Sum overall? | Sort O(n log n) + two-pointer pass O(n²) worst case. |
| Longest substring space? | O(min(n, charset size)). |
| Two Sum brute? | O(n²) time, O(1) space — contrast when optimizing. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q5. Best Time to Buy/Sell Stock — one-pass state?
**Answer:**

> One transaction max. Track minimum price so far and max profit = price - min. O(n)/O(1). Edges: length 1 → 0; strictly decreasing → 0. Trap: sell before buy; update min before computing profit at each step.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Brute? | All buy/sell pairs O(n²). |
| Multiple transactions? | Different problem (greedy) — not Week 1 core. |
| Negative prices? | LeetCode usually non-negative — clarify. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q6. 3Sum — how do hash, sort, and pointers combine?
**Answer:**

> Sort array O(n log n). Fix index i, run opposite pointers on i+1..<n for sum zero. Skip duplicate i and duplicate l/r after hits. O(n²) time typical. Say sort cost up front. Not a hash problem — pointers after sort handle duplicates cleanly.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why not hash for triplets? | Duplicate triplet handling gets messy. |
| All zeros `[0,0,0,0]`? | One triplet `[0,0,0]` after skip logic. |
| No solution? | Return empty array. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q7. How do I drill pattern ID without coding?
**Answer:**

> Read prompt only → say pattern + 60s approach + time/space → no IDE. Use the decision tree: complements → hash; contiguous constraint → window; sorted/ends → pointers; in-place compact → write; max subarray → Kadane; range product → prefix/suffix. 15-minute flash sets in exercises.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Wrong pattern recovery? | Exercise 9 — restart with say-this-first, do not patch bad code. |
| Two patterns fit? | Match output: indices vs length vs count. |
| After drills? | Timed contest simulation in Exercise 4. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q8. How does DSA connect to iOS interview talk (honestly)?
**Answer:**

> DSA in this repo is a **communication skill** — approach narration under uncertainty. Do not claim “I used Kadane in production ads.” Soft honest bridges: cancel in-flight work ≈ debounce (BookMyShow backend-driven header & search); pagination ≈ listing windows later. Grade is process + complexity speech, not resume metric invention.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Pivot to concurrency? | “Same clarity I’d use describing a serial queue API.” |
| Anti-pattern? | Invented BMS DSA war stories. |
| Catch-up rule? | Weak Day 03–05 topic 45–60 min beats a fourth Hard LC. |

**How can I relate to my case:**
- **Shipped:** BookMyShow backend-driven header & search
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

Back to: [README.md](README.md) · Main modules: [07-revision-qna.md](07-revision-qna.md)

---

## Brain puzzles (cover → think → check)

### Puzzle A — What is the prefix / suffix product pattern

**Ask yourself:** What is the prefix / suffix product pattern?

**Answer:** “Output[i] = product of all elements except nums[i] without division. Two passes: prefix products left-to-right, suffix right-to-left (or one output array + one scalar). O(n) time, O(1) extra aside from output. Edges: zeros — at most one zero affects non-zero entries.”

### Puzzle B — What is the Week 1 minimum core set

**Ask yourself:** What is the Week 1 minimum core set?

**Answer:** “Eight problems minimum today: Two Sum (hash), Best Time Buy/Sell Stock (running min), Valid Palindrome (two pointers), Container Water (opposite ends), Longest Substring (variable window), Maximum Subarray (Kadane), Product Except Self (prefix/suffix), Move Zeroes (write pointer). Stretch: 3Sum, Min Size Subarray Sum, Group Anagrams.”

### Puzzle C — Say time and space for each core pattern

**Ask yourself:** Say time and space for each core pattern?

**Answer:** “Hash one-pass: O(n) / O(n). Opposite two pointers (after sort): O(n log n) + O(n) scan, O(1) extra. Variable window: O(n) / O(alphabet). Kadane: O(n) / O(1). Prefix/suffix: O(n) / O(1) extra. Write pointer in-place: O(n) / O(1). Running min (stock): O(n) / O(1).”
