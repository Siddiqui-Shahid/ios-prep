# Audio script — Sample 03 — Swift strings (Q&A)
> Listen-only sample Q&A from `03-strings-swift.md`. Spoken answers and follow-ups.

## §0 Q1. Why is Swift String not like `[Int]` for indexing?

Next. Q1. Why is Swift String not like `[Int]` for indexing? Answer. Swift String is a collection of Character values with variable UTF-8/UTF-16 encoding. You cannot use s[2] with an Int — subscripting uses String.Index, and advancing an index is not O(1) in the general case. Say this aloud in interviews so you look honest about platform cost. Follow-ups. Can I use Int in a for loop?: Not on String directly — use indices or convert first.. LeetCode Swift?: Same rules — do not assume C-style char arrays.. Why interviewers care?: Shows you know real Swift, not just Python-style pseudocode..

## §1 Q2. When should I convert to `[Character]`?

Next. Q2. When should I convert to `[Character]`? Answer. When you need repeated random access by offset — palindrome two pointers, window on a string, compare s[i] and s[j] many times. let chars = Array(s) costs O(n) time and O(n) space for the copy. State that cost when you choose it; then indexing is O(1) per access. Follow-ups. One forward pass only?: Walking String.Index with formIndex can avoid the copy — more verbose.. Lowercase for compare?: Array(s.lowercased()) — another O(n) pass; say it.. [Character] vs [UInt8]?: Character preserves Unicode scalars; bytes are wrong for general Unicode..

## §2 Q3. What is the interview-safe line about String cost?

Next. Q3. What is the interview-safe line about String cost? Answer. “Swift String is not random-access O(1). I’ll convert to [Character] when I need repeated indexing and say the O(n) copy cost.” That one sentence prevents a follow-up trap and matches the Day 06 agenda opener. Follow-ups. Is O(n) copy always OK?: For interview n up to 10⁵, usually yes — still O(n) overall for one pass.. Alternative?: Two String.Index pointers from start/end — O(1) extra space, trickier code.. Substring?: Slices share storage but still use Index, not Int..

## §3 Q4. Valid Palindrome — how do strings change the approach?

Next. Q4. Valid Palindrome — how do strings change the approach? Answer. Two pointers from both ends on alphanumeric only, case-insensitive. In Swift: Array(s.lowercased()) or walk indices skipping non-alnum. O(n) time; O(n) extra if you copy, O(1) extra if you index carefully. Clarify charset — LeetCode is ASCII alphanumeric. Follow-ups. Skip rule?: Advance left/right while not alphanumeric.. Empty or all punctuation?: True — nothing fails comparison.. Unicode emoji?: Clarify with interviewer; default tests are ASCII..

## §4 Q5. Longest substring — string-specific traps?

Next. Q5. Longest substring — string-specific traps? Answer. Variable window with a last-seen map keyed by Character (or Int if you map char). On duplicate at right, jump left to lastIndex + 1. Use Array(s) if you index by offset. Space O(min(n, alphabet)). Trap: off-by-one on left update; forgetting max with current window length. Follow-ups. left only moves forward?: Yes — each char enters window once → O(n).. Empty string?: Return 0.. All same char "aaaa"?: Answer 1..

## §5 Q6. What Array pitfalls matter on Day 06?

Next. Q6. What Array pitfalls matter on Day 06? Answer. Avoid removeFirst in a loop — O(n) each time. Sorting is O(n log n) — say it when enabling 3Sum two pointers. Integer overflow is rare on LeetCode Swift with Int unless constraints are huge. Prefer for i in 0..<nums.count on arrays, not on strings without conversion. Follow-ups. In-place swap?: Fine on [Int] — two index variables.. nums.sorted() vs sort in place?: sorted() is O(n) extra space; sort() mutates.. Group Anagrams string key?: Sort chars or count frequency — both O(k log k) or O(k) per string..

## §6 Q7. String.Index vs `[Character]` — when to pick which?

Next. Q7. String.Index vs `[Character]` — when to pick which? Answer. [Character]: clearer for two-pointer by offset, multiple random accesses, dry-runs on paper. String.Index: one pass, no copy, production-polished but easy to get wrong under pressure. In timed interviews, many candidates copy once and win on clarity — as long as they state O(n) space. Follow-ups. Production feed parsing?: Often byte buffers or NSString — different day.. Interviewer asks O(1) space?: Offer Index walk; accept more implementation risk.. Test with "A man, a plan, a canal: Panama"?: Yes — classic palindrome dry-run.. Next: 04-patterns-drills.md.
