# Sample 02 — Two pointers & sliding window (Q&A)

> Guided teaching. Each answer stands alone and ends with **How can I relate to my case** using named work — never S-codes.

---

### Q1. How do I tell two pointers from sliding window?
**Answer:**

> **Two pointers:** two indices move to satisfy a relation — often both ends inward, or fast/slow. **Sliding window:** maintain a contiguous range; expand right to include, shrink left when an invariant breaks. Both use an **invariant** — say that word either way. Window = contiguous + length/subarray constraint; opposite ends = sorted/palindrome/max-area from ends.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Overlap in vocabulary? | Yes — “two pointers” sometimes names window left/right. Focus on the invariant. |
| Contiguous substring signal? | Variable sliding window. |
| Sorted array, pair sum signal? | Opposite pointers (after sort if needed). |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q2. What signals “opposite ends” two pointers?
**Answer:**

> Sorted array pair problems, palindrome check from both ends, max area/volume from left and right indices. Target complexity O(n) after any sort cost. Classic Week 1: Valid Palindrome, Container With Most Water, 3Sum (after sort).

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Container Water move rule? | Move the shorter side — width always shrinks; only a taller short side can help. |
| Unsorted 3Sum? | Sort first O(n log n), then opposite pointers with duplicate skip. |
| Palindrome pointer rule? | Skip non-alphanumeric; compare lowercased chars. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q3. What signals a variable sliding window?
**Answer:**

> “Longest/shortest substring or subarray with a constraint” — no repeats, sum at least K, at most K distinct, etc. Expand `right` to grow; while invariant breaks, shrink `left`. Each index moves at most once → O(n). Track best length or minimum window while shrinking.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Invariant example? | `s[left...right]` has all unique characters. |
| Duplicate char trap? | Move `left` to `lastIndex + 1`, not just `left + 1`. |
| Min Size Subarray Sum? | Shrink while sum ≥ target; track minimum length. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q4. What is a write pointer (in-place two pointers)?
**Answer:**

> One index reads, one writes the next valid position — compact in place without extra array. Move Zeroes, remove duplicates in sorted array. O(n) time, O(1) extra space. Say “write pointer” so the interviewer knows you will not allocate a copy.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| After Move Zeroes? | Zeros are at the end; prefix is non-zero in order. |
| Why not `removeFirst` in a loop? | O(n) per remove → O(n²) total. |
| Mutate allowed? | Confirm — in-place patterns need it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q5. How does Kadane relate to “window” thinking?
**Answer:**

> Kadane is a one-pass running state, not a literal left/right window — but it asks “extend current subarray or restart?” Running max of `max(x, running + x)`; track global max. O(n)/O(1). All-negative: answer is the largest single element.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Brute? | All subarray sums O(n²) or O(n²) with nested loops. |
| Reset trap? | Wrong reset-to-zero logic breaks all-negative arrays. |
| Contiguous required? | Yes — not the same as “pick any subset.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q6. What is the off-by-one checklist for windows?
**Answer:**

> Is the window `[left, right]` inclusive on both ends? When do you update best — on expand or after shrink? Empty window allowed? Initialize `left = 0`, `best = 0` vs `1` correctly. Dry-run a tiny string like `"abc"` and `"aaa"` before coding.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Longest substring empty input? | Length 0. |
| Update max when? | Usually after each valid expand; also check after shrink for min-window problems. |
| Fixed window size k? | Different pattern — slide both ends together when size exceeds k. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q7. Pattern ID: which approach for these prompts?
**Answer:**

> Valid Palindrome → opposite pointers. Container Water → opposite ends, move shorter. Longest Substring Without Repeating → variable window + last-seen map. Move Zeroes → write pointer. Max Subarray → Kadane. If two patterns fit, match the **output** shape (indices vs length vs sum).

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Need complement index? | Hash map, not two pointers on unsorted array. |
| Range product no division? | Prefix/suffix — not window. |
| Many subarray sums? | Prefix + hash (later week). |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

Next: [03-strings-swift.md](03-strings-swift.md)

---

## Brain puzzles (cover → think → check)

### Puzzle A — What signals “opposite ends” two pointers

**Ask yourself:** What signals “opposite ends” two pointers?

**Answer:** “Sorted array pair problems, palindrome check from both ends, max area/volume from left and right indices. Target complexity O(n) after any sort cost. Classic Week 1: Valid Palindrome, Container With Most Water, 3Sum (after sort).”

### Puzzle B — What signals a variable sliding window

**Ask yourself:** What signals a variable sliding window?

**Answer:** “Longest/shortest substring or subarray with a constraint” — no repeats, sum at least K, at most K distinct, etc. Expand `right` to grow; while invariant breaks, shrink `left`. Each index moves at most once → O(n). Track best length or minimum window while shrinking.

### Puzzle C — What is a write pointer (in-place two pointers)

**Ask yourself:** What is a write pointer (in-place two pointers)?

**Answer:** “One index reads, one writes the next valid position — compact in place without extra array. Move Zeroes, remove duplicates in sorted array. O(n) time, O(1) extra space. Say “write pointer” so the interviewer knows you will not allocate a copy.”
