# Day 06 — DSA: Arrays, Strings, Two Pointers, Sliding Window

> Week 1 · Revision pass ~45–60 min  
> Full study: [weeks/week-01/day-06/](../../../weeks/week-01/day-06/README.md)  
> Sample Q&A (guided): [weeks/week-01/day-06/sample/](../../../weeks/week-01/day-06/sample/README.md)

## 1. Outcome

Explain aloud, in plain sentences:

- Open every problem with clarify → brute → optimize → edges before typing
- Spot two-pointer vs sliding-window vs prefix/hash signals quickly
- Solve Week 1 core array/string problems in Swift while narrating time/space
- Handle Swift String indexing honestly — and catch up one weak Week 1 topic if needed

## 2. Concept refresh (simple)

### 2.1 Say-this-first script (60–90s)

Clarify constraints → state brute force and complexity → name the pattern and why → list edge cases → code.

### 2.2 Pattern signals

| Pattern | Signals | Target |
|---|---|---|
| Two pointers (opposite) | Sorted pair sum, palindrome | O(n) |
| Sliding window fixed | Exact length k | O(n) |
| Sliding window variable | Longest/shortest with constraint | O(n) — expand right, shrink left when invariant breaks |
| Prefix sums / hash map | Range sums, anagrams, Two Sum | O(n) prep |

**Two pointers:** two indices, maintain an invariant, move the side that restores it.  
**Sliding window:** expand right; shrink left when the invariant breaks.

### 2.3 Swift String

String is **not** O(1) random access by integer index. Say the cost if you convert to `[Character]` or walk `String.Index`.

### 2.4 Week 1 core set (minimum 8)

Two Sum · Best Time to Buy/Sell Stock · Valid Palindrome · Container With Most Water · Longest Substring Without Repeating Characters · Maximum Subarray · Product of Array Except Self · 3Sum (if time). Full list in [01-foundations §5](../../../weeks/week-01/day-06/01-foundations.md).

### 2.5 Critical truths (pin)

| Claim | Truth |
|---|---|
| Say-this-first | Clarify → brute → optimize → edges — **before** typing |
| Two pointers | Two indices, invariant, move the side that restores it |
| Sliding window | Expand right; shrink left when invariant breaks |
| Swift String | Not O(1) random index — say the cost if you convert |
| Communication | Process narration beats a silent clever trick |
| Week 1 minimum | 8 core problems in 01-foundations §5 |

## 3. Read these

| Priority | Resource | Why |
|---|---|---|
| Must | [Sample Q&A](../../../weeks/week-01/day-06/sample/) | Guided cards |
| Must | Full modules [01–03](../../../weeks/week-01/day-06/01-foundations.md) | Gaps |
| Drill | [04-questions](../../../weeks/week-01/day-06/04-questions.md) | Timed answers |

## 4. Map to your work

DSA rarely maps 1:1 to BMS — use product intuition lightly:

- Debounced search ≈ cancel in-flight work (concurrency story from BookMyShow backend-driven header & search, not an algorithm claim)
- Listing windows ≈ pagination cursors (system design Week 2+)

**Interview line (≤20s):** “I treat DSA as structured communication under uncertainty — clarify, brute, optimize, then code.”

No invented metrics. Catch-up rule: one weak Week 1 topic (Days 01–05) beats grinding new hard problems.

## 5. Flash prompts

1. 60s approach script — say it without looking
2. Two pointers vs sliding window — how do you decide?
3. Container With Most Water — why move the shorter side?
4. Longest substring without repeats — expand/shrink invariant
5. Swift String indexing cost — when `[Character]`?
6. Two Sum — map vs sort — state trade-off aloud
7. Off-by-one window trap — how do you dry-run?
8. Week 1 catch-up — which day card failed last?

## 6. Timed drills

| Drill | Budget |
|---|---|
| Approach script (any problem) | 90s |
| Two pointers pattern | 45s |
| Sliding window pattern | 45s |
| Timed solve (pick 1 core problem) | 25 min |
| Week 1 catch-up flashcards | 15 min |

Expand from [sample cards](../../../weeks/week-01/day-06/sample/), [code/](../../../weeks/week-01/day-06/code/), and [05-exercises](../../../weeks/week-01/day-06/05-exercises.md).
