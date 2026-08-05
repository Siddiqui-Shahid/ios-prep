# Audio script — 02 Deep Dive
> Listen-only audiobook of `02-deep-dive.md` (Day 06 — DSA: Arrays, Strings, Two Pointers, Sliding Window). Simple English. Basic explanations. Self-contained speech. Does not assume you are looking at a screen.


## §0 Introduction

Next. Introduction.

Read the approach script. hide it. re-speak. implement from code/. Full solutions live in code. this file is the thinking layer.

## §1 1. Two Sum

Next. 1. Two Sum.

Prompt: Given nums and target, return indices i, j with nums[i] + nums[j] == target. Say this first (60s): “Constraints? Duplicates? Guaranteed one answer? Brute: try all pairs O(n²). Sorting loses original indices unless I store pairs. I’ll scan once: for each value look up target - value in a dictionary of value. index, else store current. Time O(n), space O(n). Edges: empty, no pair, negatives, duplicates.” Invariant: Map holds values seen so far with an index. Dry-run: nums = [2,7,11,15], target = 9. at 7 find 2. [0,1]. Trap: Returning values instead of indices. using the same element twice. Code: code/TwoSum.swift.

## §2 2. Best Time to Buy and Sell Stock

Next. 2. Best Time to Buy and Sell Stock.

Prompt: Max profit from one buy + one later sell. else 0. Say this first: “One transaction. Brute all pairs O(n²). Track minimum price so far and max profit = price - min. O(n)/O(1). Edges: length 1, strictly decreasing. 0.” Trap: Selling before buying. resetting min after computing profit wrong order. Code: code/MaxProfit.swift.

## §3 3. Valid Palindrome

Next. 3. Valid Palindrome.

Prompt: Alphanumeric only, case-insensitive palindrome? Say this first: “Two pointers from ends. Skip non-alnum. compare lowercased. O(n)/O(1) extra if we index the string carefully. in Swift I’ll use Array(s) for clarity O(n) space, or walk String.Index. Edges: empty, all punctuation, unicode. I’ll clarify charset. LeetCode is ASCII alnum.” Trap: Forgetting to skip. comparing uppercase vs lower. Code: code/ValidPalindrome.swift.

## §4 4. Container With Most Water

Next. 4. Container With Most Water.

Prompt: Heights at indices. max min(h[l],h[r]) (r-l). Say this first: “Brute all pairs O(n²). Start at ends. max width. Move the shorter side inward. only a taller short-side can improve. O(n)/O(1). Edges: n=2, all equal.” Why move shorter: Width shrinks by 1 always. height limited by min. Moving taller can’t increase min. moving shorter might. Code: code/ContainerWater.swift.

## §5 5. Longest Substring Without Repeating Characters

Next. 5. Longest Substring Without Repeating Characters.

Prompt: Length of longest substring with all unique chars. Say this first: “Variable window. Expand right. if duplicate, shrink left until unique. typically with last-seen index map. Each index moves at most once. O(n). Space O(min(n, alphabet)). Edges: empty, all unique, all same.” Invariant: s[left...right] has unique characters. Trap: Off-by-one when updating left to lastIndex + 1. not taking max with current left. Code: code/LengthOfLongestSubstring.swift.

## §6 6. Maximum Subarray (Kadane)

Next. 6. Maximum Subarray (Kadane).

Prompt: Contiguous subarray with largest sum. Say this first: “Brute O(n²) sums. Kadane: running sum. if running < 0 reset to 0 before adding next. actually classic: running = max(x, running+x). track global max. All-negative: answer is largest element. the max(x, running+x) form handles it. O(n)/O(1).” Trap: Resetting to 0 when all negative (wrong if you force non-empty and reset poorly). Code: code/MaxSubArray.swift.

## §7 7. Product of Array Except Self

Next. 7. Product of Array Except Self.

Prompt: out[i] = product of all except i. no division. O(n). Say this first: “Left products pass into output. right products multiply on the way back. O(n) time, O(1) extra if output doesn’t count. Edges: zeros (one zero, two zeros), negatives.” Trap: Using division. O(n) extra left/right arrays without mentioning you can optimize. Code: code/ProductExceptSelf.swift.

## §8 8. Move Zeroes

Next. 8. Move Zeroes.

Prompt: Move zeroes to end in place. keep relative order of non-zeroes. Say this first: “Write pointer: write non-zeroes forward, then fill zeroes. O(n)/O(1). Edges: no zeroes, all zeroes, already packed.” Code: code/MoveZeroes.swift.

## §9 9. 3Sum (stretch)

Next. 9. 3Sum (stretch).

Say this first: “Sort O(n log n). Fix i. two-sum on remainder with left/right. skip duplicates. O(n²). Edges: all zero, <3 elements, many dups.” Code: code/ThreeSum.swift.

## §10 10. Minimum Size Subarray Sum (stretch)

Next. 10. Minimum Size Subarray Sum (stretch).

Say this first: “Positive nums assumed for two-pointer window. Expand until sum ≥ target. shrink left. track min length. Impossible. 0. O(n).” Code: code/MinSubArrayLen.swift.

## §11 11. Group Anagrams (bridge)

Next. 11. Group Anagrams (bridge).

Say this first: “Key by sorted string or 26-count signature. bucket in dictionary. O(n·k log k) sorted keys or O(n·k) counts.” Code: code/GroupAnagrams.swift.

## §12 12. Pattern ID drills (no code)

Next. 12. Pattern I D drills (no code).

Prompt fragment: Reach for. “indices of two numbers”: Hash map. “longest substring with at most K”: Variable window. “sorted array, pairs”: Opposite pointers. “maximum subarray sum”: Kadane. “in-place remove / compact”: Write pointer. “product except self / no division”: Prefix-suffix. “anagrams”: Frequency signature.

## §13 13. When interviewer changes constraints mid-flight

Next. 13. When interviewer changes constraints mid-flight.

Change: Response. Need O(1) space after map solution: Restate trade-off. ask if sort/mutate propose alt. Want brute coded too: Sketch brute verbally. code optimal. note n≤20 brute Streaming input: Discuss what breaks (need full array?). Trap: Silent panic rewrite.

## §14 14. Off-by-one window checklist

Next. 14. Off-by-one window checklist.

Before submitting mentally: Is right inclusive in length right - left + 1? When duplicate at right, is left = last[c] + 1? Did you max(left, …) so left never moves backward? Dry-run "abba" for longest unique substring.

## §15 15. Full dry-runs (speak these once)

Next. 15. Full dry-runs (speak these once).

15.1 Two Sum. [2,7,11,15], target 9 i: value, need, seen before step, action. 0: 2, 7, {}, store 2. 0. 1: 7, 2, {2:0}, found. [0,1]. 15.2 Longest substring. "abba" right: ch, last, left before, left after, best. 0: a,. , 0, 0, 1. 1: b,. , 0, 0, 2. 2: b, 1, 0, max(0,2)=2, 2. 3: a, 0, 2, max(2,1)=2, 2. Answer length 2 ("bb" or "ba" depending on window. length 2). 15.3 Kadane. [-2,1,-3,4,-1,2,1,-5,4] Track running / best through each element. best ends at 6 ([4,-1,2,1]). 15.4 Container water. [1,8,6,2,5,4,8,3,7] Start l=0,r=8. min(1,7)8=8. move left (shorter). Continue until best 49. 15.5 Product except self. [1,2,3,4] Left pass out=[1,1,2,6]. right multiply. [24,12,8,6].

## §16 16. Brute → optimal comparison table

Next. 16. Brute → optimal comparison table.

Problem: Brute, Optimal, What you say. Two Sum: O(n²) pairs, O(n) map, “Indices. map beats sort+scan unless O(1) space forced”. Stock: O(n²) pairs, O(n) min, “Running min is enough for one transaction”. Palindrome: Build cleaned string + reverse, Two pointers, “Same O(n). pointers save an allocation”. Water: O(n²), O(n) ends, “Move shorter. width shrinks anyway”. Unique substring: O(n²) check sets, O(n) window, “Each index moves ≤ once”. Max subarray: O(n²)/O(n³), O(n) Kadane, “Reset when extending loses”. Product: Divide by nums[i], Prefix/suffix, “Division fails on zeros. prompt forbids it”. Move zeroes: Extra array, Write pointer, “Stable compact in place”. 3Sum: O(n³), Sort + O(n²), “Pay n log n to enable two-sum”. Min subarray: O(n²), O(n) window, “Positives. shrink safely”.

## §17 17. Edge-case bank (quiz yourself)

Next. 17. Edge-case bank (quiz yourself).

Problem: Edge, Expected intuition. Two Sum: Duplicate values, distinct indices, Map stores latest or first. be consistent with “one answer”. Stock: Strictly decreasing, Profit 0. Palindrome: ",.", true. Water: n=2, Only one container. Unique substring: "" / " ", 0 / 1. Kadane: All negative, Largest (least negative) element. Product: [0,0,1], Careful zeros. Move zeroes: [0,0,0], Still all zeroes. 3Sum: [-1,-1,2], One triplet. skip dups. Min window sum: Target larger than total, 0.

## §18 18. Narration anti-patterns

Next. 18. Narration anti-patterns.

Anti-pattern: Fix. Coding while silent: Forced 60s plan. “I’ve seen this” then blank: Still state pattern + invariant. Ignoring interviewer hints: Rephrase hint into plan change. Optimizing microconstants: Big-O + clarity first. Swift s[i] with Int: [Character] honesty.

## §19 19. Link to dsa-track (optional)

Next. 19. Link to dsa-track (optional).

Canonical list also lives in../../../coding/dsa-track.md. This chapter embeds Week 1 patterns and solutions. use the track for spaced review across weeks, not as a blocker today.

## §20 Next

Next. Next.

Implement from memory using code/, then 03-production-bridge.md. Exit checklist (deep dive) [ ] Spoke Two Sum + window + Kadane approaches without peeking [ ]. Dry-ran "abba" and one Kadane array [ ] Named brute vs optimal for each core problem once [. ] Opened at least 6 files under code/ and explained them aloud [ ] Recited say-this-first from memory. once more before coding block.
