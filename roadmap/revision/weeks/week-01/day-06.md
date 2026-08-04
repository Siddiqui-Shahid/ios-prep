# Day 06 — DSA: Arrays, Strings, Two Pointers, Sliding Window + Catch-up

> Week 1 · Weekend-style volume day · Time budget today: ~5–6 hrs

## 1. Outcome

- Solve Easy/Medium array-string problems in Swift while narrating
- Open every problem with a **2–3 min approach** (timing guide)
- Identify two-pointer vs sliding-window vs prefix patterns quickly
- Catch up any shaky Week 1 topic (actors / ARC / POP)

## 2. Concept deep dive

### 2.1 Pattern cheatsheet

| Pattern | Signals | Complexity target |
|---|---|---|
| Two pointers (opposite) | Sorted pair sum, palindrome | O(n) |
| Fast/slow | Cycle, middle | O(n) |
| Sliding window fixed | Exact k length | O(n) |
| Sliding window variable | Longest/shortest with constraint | O(n) |
| Prefix sums | Range sums, subarray sum | O(n) prep |
| Frequency map | Anagrams, counts | O(n) |

### 2.2 “Say this first” script (60–90s)

> “Constraints? Sorted? Duplicates? Mutate in place?  
> Brute force would be … O(?).  
> I’ll use … because … .  
> Edge cases: empty, single element, all same.  
> Coding now.”

### 2.3 Swift-specific tips

- Prefer `Array` indices carefully (`startIndex`)
- `Character` vs `String` indexing costs — convert to `Array` of `Character` when random access needed
- Speak complexity for time **and** space

## 3. Read these

| Priority | Resource | Why |
|---|---|---|
| Must | [coding/dsa-track.md](../../coding/dsa-track.md) Week 1 list | Canonical problem set |
| Must | Timing guide § Coding approach | Communication grade |
| Deepen | Catch-up: Day 03 or 05 notes you marked weak | Retention |

## 4. Map to your work

DSA rarely maps 1:1 to BMS — still use product intuition for examples:
- Debounced search ≈ cancel in-flight work (concurrency story, not algorithm)
- Listing windows ≈ pagination cursors (system design Week 2+)

**Interview line:** “I treat DSA as structured communication under uncertainty — clarify, brute, optimize, then code.”

## 5. Normal questions (meta + warmups)

### Q1. Explain two pointers `(30–45s)`
**Skeleton:** Two indices moving; sorted/palindrome use cases.

### Q2. Sliding window vs two pointers? `(45s)`
**Skeleton:** Window maintains a range invariant; pointers may be broader.

### Q3. When prefix sums? `(30s)`
**Skeleton:** Many range sum queries.

### Q4. Why narrate before coding? `(30s)`
**Skeleton:** Interviewer grades process; catch wrong approach early.

### Q5–Q12. Problem set (solve; each gets approach script)

Use full list in dsa-track; minimum today:

1. Two Sum (map)  
2. Best Time to Buy/Sell Stock  
3. Valid Palindrome  
4. Container With Most Water  
5. Longest Substring Without Repeating Characters  
6. Maximum Subarray (Kadane)  
7. Product of Array Except Self  
8. 3Sum (if time)  

For each: 2–3 min approach → code → test edges → complexity out loud.

## 6. Tricky questions

### T1. Interviewer asks for O(1) space after you used a map `(90s)`
**Trap:** Panic rewrite silently.  
**Senior answer:** State trade-off; ask if input can be sorted/mutated; propose alternative.

### T2. String indexing in Swift feels O(n) — what do you do? `(90s)`
**Trap:** Pretend String is random-access.  
**Senior answer:** Convert to `[Character]` or use indices carefully; mention cost.

### T3. Off-by-one in window `(90s)`
**Trap:** Expand/shrink wrong.  
**Senior answer:** Invariant comment; examples dry-run.

### T4. Mutating array while iterating `(90s)`
**Trap:** Remove during for-in.  
**Senior answer:** Two-pointer write index pattern.

### T5. They want both brute and optimal coded `(120s)`
**Trap:** Only optimal.  
**Senior answer:** Sketch brute verbally; code optimal; mention when brute OK for n≤20.

## 7. Flashcards for today

| Front | Back |
|---|---|
| Two pointers opposite | Sorted pair / palindrome · O(n) |
| Sliding window variable | Longest with constraint · expand/shrink |
| Kadane | Max subarray · running reset |
| Prefix sum | Range sum O(1) after O(n) |
| Frequency map | Anagram / counts |
| Say first | Clarify→brute→opt→edges |
| Swift String index | Not random O(1) · use Array |
| Write pointer | In-place filter/dedup |
| Two Sum map | value→index · O(n) |
| Container water | Ends inward · O(n) |
| Catch-up rule | Weak topic > new LC hard |
| Communication > clever | Senior signal |

## 8. Practice

- **Coding:** Complete minimum 6 problems from list in Swift.
- **Catch-up (60–90 min):** Re-read weakest of Days 01–05; redo 5 flashcards from that day.
- **SD light:** Write Social Feed API: cursor pagination request/response JSON sketch (15 min).

## 9. Timed drill

1. Pick 2 problems: full timed — 3 min approach + 25 min code each.
2. One conceptual from Day 05 (actor reentrancy) at 2 min.
3. Gotchas log: any pattern mis-ID.
