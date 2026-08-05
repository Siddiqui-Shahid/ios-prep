# Sample 03 — Swift strings (Q&A)

> Guided teaching. Each answer stands alone; **Points to** shows where the full module expands the idea.

---

### Q1. Why is Swift String not like `[Int]` for indexing?

**Points to:** [Foundations · §4.1 String indexing](../01-foundations.md#41-string-indexing-is-not-array-indexing) · [Deep dive · §3 Valid Palindrome](../02-deep-dive.md#3-valid-palindrome)

**Answer:**

> Swift `String` is a collection of **Character** values with variable UTF-8/UTF-16 encoding. You cannot use `s[2]` with an Int — subscripting uses `String.Index`, and advancing an index is not O(1) in the general case. Say this aloud in interviews so you look honest about platform cost.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Can I use Int in a for loop? | Not on String directly — use indices or convert first. |
| LeetCode Swift? | Same rules — do not assume C-style char arrays. |
| Why interviewers care? | Shows you know real Swift, not just Python-style pseudocode. |

---

### Q2. When should I convert to `[Character]`?

**Points to:** [Foundations · §4.1 String indexing](../01-foundations.md#41-string-indexing-is-not-array-indexing) · [Deep dive · §5 Longest Substring](../02-deep-dive.md#5-longest-substring-without-repeating-characters)

**Answer:**

> When you need **repeated random access** by offset — palindrome two pointers, window on a string, compare `s[i]` and `s[j]` many times. `let chars = Array(s)` costs O(n) time and O(n) space for the copy. State that cost when you choose it; then indexing is O(1) per access.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One forward pass only? | Walking `String.Index` with `formIndex` can avoid the copy — more verbose. |
| Lowercase for compare? | `Array(s.lowercased())` — another O(n) pass; say it. |
| `[Character]` vs `[UInt8]`? | Character preserves Unicode scalars; bytes are wrong for general Unicode. |

---

### Q3. What is the interview-safe line about String cost?

**Points to:** [Foundations · §4 Swift-specific tips](../01-foundations.md#4-swift-specific-tips-interview-landmines) · [README · Agenda openers](../README.md#agenda-openers)

**Answer:**

> “Swift String is not random-access O(1). I’ll convert to `[Character]` when I need repeated indexing and say the O(n) copy cost.” That one sentence prevents a follow-up trap and matches the Day 06 agenda opener.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Is O(n) copy always OK? | For interview n up to 10⁵, usually yes — still O(n) overall for one pass. |
| Alternative? | Two `String.Index` pointers from start/end — O(1) extra space, trickier code. |
| `Substring`? | Slices share storage but still use Index, not Int. |

---

### Q4. Valid Palindrome — how do strings change the approach?

**Points to:** [Deep dive · §3 Valid Palindrome](../02-deep-dive.md#3-valid-palindrome) · [code/ValidPalindrome.swift](../code/ValidPalindrome.swift)

**Answer:**

> Two pointers from both ends on alphanumeric only, case-insensitive. In Swift: `Array(s.lowercased())` or walk indices skipping non-alnum. O(n) time; O(n) extra if you copy, O(1) extra if you index carefully. Clarify charset — LeetCode is ASCII alphanumeric.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Skip rule? | Advance left/right while not alphanumeric. |
| Empty or all punctuation? | True — nothing fails comparison. |
| Unicode emoji? | Clarify with interviewer; default tests are ASCII. |

---

### Q5. Longest substring — string-specific traps?

**Points to:** [Deep dive · §5 Longest Substring](../02-deep-dive.md#5-longest-substring-without-repeating-characters) · [code/LengthOfLongestSubstring.swift](../code/LengthOfLongestSubstring.swift)

**Answer:**

> Variable window with a last-seen map keyed by Character (or Int if you map char). On duplicate at `right`, jump `left` to `lastIndex + 1`. Use `Array(s)` if you index by offset. Space O(min(n, alphabet)). Trap: off-by-one on left update; forgetting `max` with current window length.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| `left` only moves forward? | Yes — each char enters window once → O(n). |
| Empty string? | Return 0. |
| All same char `"aaaa"`? | Answer 1. |

---

### Q6. What Array pitfalls matter on Day 06?

**Points to:** [Foundations · §4.2 Prefer Array indices](../01-foundations.md#42-prefer-array-indices-carefully) · [Foundations · §4.4 Sorting costs](../01-foundations.md#44-sorting-costs)

**Answer:**

> Avoid `removeFirst` in a loop — O(n) each time. Sorting is O(n log n) — say it when enabling 3Sum two pointers. Integer overflow is rare on LeetCode Swift with `Int` unless constraints are huge. Prefer `for i in 0..<nums.count` on arrays, not on strings without conversion.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| In-place swap? | Fine on `[Int]` — two index variables. |
| `nums.sorted()` vs sort in place? | `sorted()` is O(n) extra space; `sort()` mutates. |
| Group Anagrams string key? | Sort chars or count frequency — both O(k log k) or O(k) per string. |

---

### Q7. String.Index vs `[Character]` — when to pick which?

**Points to:** [Foundations · §4.1 String indexing](../01-foundations.md#41-string-indexing-is-not-array-indexing) · [Deep dive · §3 Valid Palindrome](../02-deep-dive.md#3-valid-palindrome)

**Answer:**

> **`[Character]`:** clearer for two-pointer by offset, multiple random accesses, dry-runs on paper. **`String.Index`:** one pass, no copy, production-polished but easy to get wrong under pressure. In timed interviews, many candidates copy once and win on clarity — as long as they state O(n) space.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Production feed parsing? | Often byte buffers or NSString — different day. |
| Interviewer asks O(1) space? | Offer Index walk; accept more implementation risk. |
| Test with `"A man, a plan, a canal: Panama"`? | Yes — classic palindrome dry-run. |

---

Next: [04-patterns-drills.md](04-patterns-drills.md)
