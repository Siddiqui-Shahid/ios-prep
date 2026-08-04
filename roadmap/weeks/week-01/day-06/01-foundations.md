# 01 — Foundations: Patterns, Swift Tips, Say-This-First

> Intern → competent. By the end you can classify a problem before coding.

---

## 0. North star

**Interviews grade process under uncertainty.** Pattern ID + clear narration beats a silent clever trick.

---

## 1. Master “say this first” (60–90s) — memorize

Use on **every** problem before typing:

> “Constraints? Sorted? Duplicates? Mutate in place?  
> Brute force would be … O(?).  
> I’ll use … because … . Complexity time … space … .  
> Edge cases: empty, single element, all same / all duplicates.  
> Coding the optimized version now.”

Pin it. If you skip it, restart the problem in practice.

---

## 2. Pattern cheatsheet (embedded — no external read required)

| Pattern | Signals in the prompt | Target complexity | Classic problems |
|---|---|---|---|
| Hash map | Need indices / complements / counts | O(n) time / O(n) space | Two Sum, Group Anagrams |
| One-pass running state | Track min/max so far | O(n) / O(1) | Buy/Sell Stock, Kadane |
| Two pointers (opposite) | Sorted array, palindrome, max area from ends | O(n) | Valid Palindrome, Container Water, 3Sum after sort |
| Write pointer | In-place compact / remove | O(n) / O(1) | Move Zeroes, remove dups |
| Sliding window fixed | Exactly k length | O(n) | Fixed max sum of k |
| Sliding window variable | Longest/shortest substring/subarray with constraint | O(n) | Longest Substring Without Repeating, Min Size Subarray Sum |
| Prefix / suffix products | Range aggregates; no division | O(n) | Product Except Self |
| Prefix + hash | Subarray sum counts (esp. with negatives) | O(n) | Subarray Sum Equals K (later) |

### 2.1 Two pointers vs sliding window (intern distinction)

| | Two pointers | Sliding window |
|---|---|---|
| Idea | Indices move to satisfy a relation | Maintain a contiguous range invariant |
| Motion | Often both ends, or fast/slow | Right expands; left shrinks |
| Example | Container With Most Water | Longest substring without repeat |

They overlap in vocabulary — say **invariant** either way.

### 2.2 Fast/slow (awareness)

Cycle detection / middle of list — Week 2. Today: know the name.

---

## 3. Complexity fluency

| Say | Meaning |
|---|---|
| O(n) time | One or few passes |
| O(n²) | Nested loops / each pair |
| O(1) space | Few scalars (output array may be excluded by convention — clarify) |
| O(n) space | Hash map / copy |

**Always state time and space** after the approach.

---

## 4. Swift-specific tips (interview landmines)

### 4.1 String indexing is not array indexing

```swift
let s = "hello"
// s[2] // ❌ not Int subscript
let chars = Array(s)          // O(n) copy; then O(1) index
let arr = Array(s.lowercased())
```

**Say aloud:**  
> “Swift String is not random-access O(1). I’ll convert to `[Character]` when I need repeated indexing.”

### 4.2 Prefer `Array` indices carefully

```swift
for i in 0..<nums.count { }
// Avoid removeFirst in a loop — O(n) each → O(n²)
```

### 4.3 Integer overflow / Int

LeetCode Swift usually uses `Int`. Mention overflow only if constraints suggest it.

### 4.4 Sorting costs

Sorting is O(n log n). If you sort to enable two pointers (3Sum), say that cost up front.

---

## 5. Core problem set (Week 1 Day 06)

Minimum today (solve cold after reading approaches once):

| # | Problem | Pattern | Code file |
|---|---|---|---|
| 1 | Two Sum | Hash map | `TwoSum.swift` |
| 2 | Best Time to Buy/Sell Stock | Running min | `MaxProfit.swift` |
| 3 | Valid Palindrome | Two pointers | `ValidPalindrome.swift` |
| 4 | Container With Most Water | Two pointers ends | `ContainerWater.swift` |
| 5 | Longest Substring Without Repeating | Variable window | `LengthOfLongestSubstring.swift` |
| 6 | Maximum Subarray (Kadane) | Running reset | `MaxSubArray.swift` |
| 7 | Product of Array Except Self | Prefix/suffix | `ProductExceptSelf.swift` |
| 8 | Move Zeroes | Write pointer | `MoveZeroes.swift` |

If time: **3Sum**, **Min Size Subarray Sum**, **Group Anagrams** — see deep dive + `Solutions.swift`.

---

## 6. Approach templates (fill-in)

### 6.1 Hash map

> “I need … so sorting would lose …. I’ll scan once storing … in a dictionary. Brute is …. Edges: ….”

### 6.2 Opposite pointers

> “Sorted/ends problem. Left and right; move the side that … because …. O(n) after any sort cost.”

### 6.3 Variable window

> “Expand right to include. While invariant broken, shrink left. Track best. Each index moves ≤ once → O(n).”

### 6.4 Kadane

> “Running sum; if negative, reset. Track global max. All-negative → largest element.”

---

## 7. Communication > clever

Senior signal phrases:

- “I’d clarify whether we can mutate the input.”  
- “Brute is clear; here’s why we can do better.”  
- “I’ll dry-run on `[…]` before coding further.”  
- “If you need O(1) space, we can discuss trade-offs.”  

Never silently rewrite for 10 minutes after a constraint change — **restate the new plan**.

---

## 8. Catch-up rule (weekend volume)

If Day 03–05 is shaky: **45–60 min on the weakest topic beats a 4th Hard LC**.  
Mark the catch-up topic in exercises; DSA still gets ≥3 timed problems.

---

## 9. Complexity cheat sheet (say out loud)

| Pattern family | Typical time | Typical extra space |
|---|---|---|
| Hash one-pass | O(n) | O(n) |
| Opposite two pointers (unsorted→sort first) | O(n) after O(n log n) | O(1)–O(n) |
| Variable sliding window | O(n) | O(Σ) alphabet map |
| Kadane | O(n) | O(1) |
| Prefix/suffix products | O(n) | O(1) aside from output |
| Write pointer in-place | O(n) | O(1) |

**Interview habit:** After naming the pattern, immediately pair it with time **and** space.

---

## 10. Decision tree (30s ID)

```text
Need indices / complements?     → hash map
Contiguous + constraint?        → sliding window
Sorted / ends / palindrome?     → opposite pointers
In-place compact?               → write pointer
Max subarray sum?               → Kadane
Range product w/o division?     → prefix/suffix
Many range sums / count sums?   → prefix (+ hash if negatives)
```

If two patterns fit, pick the one matching the **output** (indices vs length vs subarray).

---

## 11. Practice cadence today

| Block | Goal |
|---|---|
| First pass | Read approaches; don’t memorize code |
| Second pass | Cover code; re-implement 3 Easy |
| Third pass | Timed Medium window + pointers |
| End | Catch-up weak Week 1 topic |

---

## 12. Self-check

- [ ] Recite say-this-first without looking  
- [ ] Name 4 patterns with one signal each  
- [ ] Explain Swift String indexing cost  
- [ ] Know which 8 problems are “minimum today”  
- [ ] Walk the decision tree on a random prompt  

→ [`02-deep-dive.md`](02-deep-dive.md)
