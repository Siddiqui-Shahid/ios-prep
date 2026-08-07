# Audio script — Revision guide — DSA: Arrays, Strings, Two Pointers, Sliding Window
> Listen-only revision day guide from `day-06.md`.

## §0 1. Outcome

Next. 1. Outcome. Explain aloud, in plain sentences: Open every problem with clarify → brute → optimize → edges before typing Spot two-pointer vs sliding-window vs prefix/hash signals quickly Solve Week 1 core array/string problems in Swift while narrating time/space.

## §1 2. Concept refresh (simple)

Next. 2. Concept refresh (simple). 2. Concept refresh (simple).

## §2 2.1 Say-this-first script (60–90s)

Next. 2.1 Say-this-first script (60–90s). Clarify constraints → state brute force and complexity → name the pattern and why → list edge cases → code.

## §3 2.2 Pattern signals

Next. 2.2 Pattern signals. Two pointers: two indices, maintain an invariant, move the side that restores it. Sliding window: expand right; shrink left when the invariant breaks.

## §4 2.3 Swift String

Next. 2.3 Swift String. String is not O(1) random access by integer index. Say the cost if you convert to [Character] or walk String.Index.

## §5 2.4 Week 1 core set (minimum 8)

Next. 2.4 Week 1 core set (minimum 8). Two Sum · Best Time to Buy/Sell Stock · Valid Palindrome · Container With Most Water · Longest Substring Without Repeating Characters · Maximum Subarray · Product of Array Except Self · 3Sum (if time). Full list in 01-foundations §5.

## §6 2.5 Critical truths (pin)

Next. 2.5 Critical truths (pin). 2.5 Critical truths (pin).

## §7 3. Read these

Next. 3. Read these. 3. Read these.

## §8 4. Map to your work

Next. 4. Map to your work. D S A rarely maps 1:1 to Book My Show — use product intuition lightly: Debounced search ≈ cancel in-flight work (concurrency story from BookMyShow backend-driven header & search, not an algorithm claim) Listing windows ≈ pagination cursors (system design Week 2+) Interview line (≤20s): “I treat D S A as structured communication under uncertainty — clarify, brute, optimize, then code.”.

## §9 5. Flash prompts

Next. 5. Flash prompts. 1. 60s approach script — say it without looking 2. Two pointers vs sliding window — how do you decide? 3. Container With Most Water — why move the shorter side? 4. Longest substring without repeats — expand/shrink invariant.

## §10 6. Timed drills

Next. 6. Timed drills. Expand from sample cards, code/, and 05-exercises.
