# Day 06 — DSA: Arrays, Strings, Two Pointers, Sliding Window

> Week 1 · Full study (self-contained) · ~5–6 hrs  
> Revision twin: [revision/weeks/week-01/day-06.md](../../../revision/weeks/week-01/day-06.md)  
> Track index (optional): [`../../../coding/dsa-track.md`](../../../coding/dsa-track.md) — patterns are **embedded below**; you do not need to leave this chapter.

## Outcomes

By end of day, without notes, you can:

- Open every problem with a **60–90s approach script** (clarify → brute → optimize → edges)
- Identify two-pointer vs sliding-window vs prefix/hash patterns from problem signals
- Solve the Week 1 core set in Swift while narrating time/space
- Handle Swift String indexing honestly (`[Character]` when random access needed)
- Catch up one weak Week 1 topic (30–45 min) without opening new rabbit holes

## How to study

1. [`01-foundations.md`](01-foundations.md) — pattern signals + Swift tips + say-this-first  
2. [`02-deep-dive.md`](02-deep-dive.md) — worked approaches for each core problem  
3. [`03-production-bridge.md`](03-production-bridge.md) — how to talk DSA as a senior (BMS hooks light)  
4. [`code/`](code/) — full Swift solutions; cover, re-implement from approach  
5. [`04-questions.md`](04-questions.md) — two-layer pattern Q&A + approach scripts  
6. [`05-exercises.md`](05-exercises.md) — timed solves + catch-up  
7. Revision twin for spaced drills  

## Module map

| Module | File |
|---|---|
| Foundations | [01-foundations.md](01-foundations.md) |
| Deep dive | [02-deep-dive.md](02-deep-dive.md) |
| Production bridge | [03-production-bridge.md](03-production-bridge.md) |
| Questions | [04-questions.md](04-questions.md) |
| Exercises | [05-exercises.md](05-exercises.md) |
| Code | [code/](code/) Solutions.swift + per-problem files |
| Sample Q&A (guided) | [sample/](sample/README.md) — concept teaching; does not replace modules above |

## Time budget

| Block | Minutes |
|---|---|
| Foundations | 45–60 |
| Deep dive (approaches) | 60–75 |
| Code: re-solve 6+ cold | 150–180 |
| Questions / approach scripts | 45–60 |
| Catch-up weak day | 45–60 |

## Provenance

DSA rarely maps 1:1 to resume metrics. Use:

| Label | Use |
|---|---|
| **Learning-lab** | All `code/` solutions |
| **Communication skill** | Approach narration (interview signal) |
| Soft product metaphors | Debounce ≈ cancel in-flight (S3); listing windows ≈ pagination (SD later) — **not** “I used Kadane in production ads” |

## Critical notes (pin)

1. **Patterns are embedded in this chapter** — optional link to dsa-track is for spaced review across weeks only.  
2. Speak **time and space** after every approach.  
3. Swift `String` is not Int-indexed O(1) — convert to `[Character]` when needed and say the cost.  
4. Communication grade > clever silent solve.

## Agenda openers

| Topic | Opener |
|---|---|
| Any LC problem | “Constraints → brute → optimal reason → edges → code.” |
| Two pointers | “Two indices, invariant, move the one that restores it.” |
| Sliding window | “Expand right; shrink left when invariant breaks.” |
| Swift String | “Not O(1) random index — I’ll use [Character] if needed.” |
| Kadane | “Running max of extend vs restart; handle all-negative.” |

## Files in `code/`

| File | Problem |
|---|---|
| `TwoSum.swift` | Two Sum |
| `MaxProfit.swift` | Best Time to Buy/Sell Stock |
| `ValidPalindrome.swift` | Valid Palindrome |
| `ContainerWater.swift` | Container With Most Water |
| `LengthOfLongestSubstring.swift` | Longest Substring Without Repeating |
| `MaxSubArray.swift` | Maximum Subarray (Kadane) |
| `ProductExceptSelf.swift` | Product of Array Except Self |
| `MoveZeroes.swift` | Move Zeroes |
| `ThreeSum.swift` | 3Sum (stretch) |
| `MinSubArrayLen.swift` | Min Size Subarray Sum (stretch) |
| `GroupAnagrams.swift` | Group Anagrams (bridge) |
| `Solutions.swift` | Smoke asserts |
