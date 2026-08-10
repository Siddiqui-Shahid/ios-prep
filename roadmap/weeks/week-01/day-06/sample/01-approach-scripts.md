# Sample 01 — Approach scripts (Q&A)

> Guided teaching. Each answer stands alone and ends with **How can I relate to my case** using named work — never S-codes.

---

### Q1. What is the 60–90s “say this first” script?
**Answer:**

> Before typing, say: constraints (sorted? duplicates? mutate in place?), brute force and its complexity, the optimized pattern and why it works, time and space, then edge cases (empty, single element, all same). End with “coding the optimized version now.” If you skip this in practice, restart the problem.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why not jump straight to code? | Interviews grade process under uncertainty. A clear plan buys trust even if you hit a bug. |
| What if constraints change mid-problem? | Restate the new plan out loud — never silently rewrite for ten minutes. |
| Minimum time box? | About 60–90 seconds. Longer means you are stalling; shorter means you skipped edges. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q2. What should I clarify before choosing a pattern?
**Answer:**

> Ask: input size, sorted or not, duplicates allowed, return indices or values, can I mutate the array, empty input allowed, negative numbers, guaranteed unique answer. These answers pick hash map vs two pointers vs window vs Kadane. Say them out loud so the interviewer can steer you early.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| “Can I sort?” | Sorting is O(n log n) — fine if it unlocks two pointers (3Sum), but say the cost. |
| “Mutate in place?” | Changes whether write-pointer patterns are allowed. |
| Duplicates matter how? | Two Sum needs distinct indices; 3Sum needs skip logic after sort. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q3. How do I present brute force without sounding weak?
**Answer:**

> Brute force is not failure — it is the baseline. Say “brute would be … O(?)” to show you understand the search space, then “I can do better because …” and name the pattern. Seniors always anchor optimal against brute so complexity trade-offs are obvious.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Interviewer says “just optimize”? | Give brute in one sentence, then pivot — do not skip entirely. |
| When is brute the answer? | Tiny n, or when asked to compare approaches before coding. |
| Example one-liner? | “All pairs is O(n²); one hash pass is O(n) time, O(n) space.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q4. What edge cases should I mention every time?
**Answer:**

> Empty input, single element, all duplicates, all same value, all negative (Kadane), strictly decreasing (max profit → 0), no valid pair, unicode vs ASCII (strings). You do not need to code every edge — naming them shows you will not ship a fragile solution.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| All-negative Kadane? | Largest single element — the `max(x, running+x)` form handles it. |
| Empty string palindrome? | Usually true — confirm with interviewer. |
| Two Sum no solution? | Return empty or [-1,-1] per prompt — clarify. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q5. When must I state time and space complexity?
**Answer:**

> Right after you name the optimized approach — every time. Pair the pattern with “O(n) time, O(n) space” (or O(1) extra). If output array is excluded from space by convention, say so. Omitting complexity is a common reason strong code still scores low.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| O(1) space with output array? | Clarify: O(1) *extra* aside from required output. |
| Sort then two pointers? | O(n log n) time from sort + O(n) scan — state both. |
| Hash map space? | O(n) worst case for stored entries. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q6. What senior phrases signal good communication?
**Answer:**

> “I’d clarify whether we can mutate the input.” “Brute is clear; here’s why we can do better.” “I’ll dry-run on this example before coding further.” “If you need O(1) space, we can discuss trade-offs.” These show you think like a teammate, not a silent solver.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Anti-pattern? | Ten minutes of typing with no plan update after a hint. |
| Dry-run when? | After stating approach, before or during early coding. |
| Constraint change? | Restate plan — do not pretend the old code still fits. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q7. Walk through say-this-first on Two Sum?
**Answer:**

> “Constraints? Duplicates? Guaranteed one answer? Brute: all pairs O(n²). Sorting loses original indices unless I store pairs. I’ll scan once: for each value look up `target - value` in a dictionary of value→index, else store current. Time O(n), space O(n). Edges: empty, no pair, negatives, duplicates. Coding now.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Invariant? | Map holds values seen so far with an index. |
| Trap? | Returning values instead of indices; using same element twice. |
| Dry-run? | `[2,7,11,15], target 9` → at 7 find 2 → `[0,1]`. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q8. Walk through say-this-first on Container With Most Water?
**Answer:**

> “Area is min of the two heights times the distance between indices. Brute checks all pairs O(n²). I’ll start at both ends for maximum width and move the shorter pointer inward, because width always shrinks and only a taller short side can improve the min height. Time O(n), space O(1). Edges: exactly two lines; all heights equal. Coding that.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why move shorter? | Width shrinks by 1 always; height limited by min. Moving taller can’t increase min; moving shorter might. |
| Trap? | Moving the taller pointer; off-by-one width. |
| Dry-run shape? | `[1,8,6,2,5,4,8,3,7]` — ends inward, track max area. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q9. Walk through say-this-first on Move Zeroes?
**Answer:**

> “I’ll keep a write index. Scan left to right, and whenever I see a non-zero I write it at the write index and advance. Then fill the tail with zeroes. That keeps relative order and uses O(1) extra space. Edges: no zeroes, all zeroes, already compacted.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Trap? | Removing during for-in; careless swap that scrambles relative order. |
| Move zeroes to front? | Same write-pointer idea — write zeros forward or mirror the compact. |
| Why not `removeAll` / `removeFirst` in a loop? | Each remove is O(n) → O(n²) total. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q10. Walk through say-this-first on Min Size Subarray Sum?
**Answer:**

> “Assuming positive numbers, I’ll expand a right pointer adding to a running sum; while the sum is at least target I’ll shrink from the left and track the minimum window length. If I never reach the target, return zero. Each pointer moves at most n times so O(n), space O(1). If negatives were allowed, this shrink logic would break and I’d switch strategies.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Trap? | Using this window with negatives; off-by-one length. |
| Impossible case? | Never hit target → return 0. |
| Pattern name? | Variable sliding window (shortest subarray with constraint). |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q11. Walk through say-this-first on Group Anagrams?
**Answer:**

> “Anagrams share a sorted character key or a 26-length count signature. I’ll map key to a list of strings and return the buckets. Sorted keys are O(n·k log k); count signatures are O(n·k). Edges: empty strings, single characters, already identical inputs.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Key choice? | Sorted string (simple) vs char-frequency signature (faster for long strings). |
| Space? | O(n·k) for storing all strings in buckets. |
| Pattern? | Hash map — group by signature, not two pointers. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

Next: [02-two-pointers-window.md](02-two-pointers-window.md)

---

## Brain puzzles (cover → think → check)

### Puzzle A — What should I clarify before choosing a pattern

**Ask yourself:** What should I clarify before choosing a pattern?

**Answer:** “Ask: input size, sorted or not, duplicates allowed, return indices or values, can I mutate the array, empty input allowed, negative numbers, guaranteed unique answer. These answers pick hash map vs two pointers vs window vs Kadane. Say them out loud so the interviewer can steer you early.”

### Puzzle B — How do I present brute force without sounding weak

**Ask yourself:** How do I present brute force without sounding weak?

**Answer:** “Brute force is not failure — it is the baseline. Say “brute would be … O(?)” to show you understand the search space, then “I can do better because …” and name the pattern. Seniors always anchor optimal against brute so complexity trade-offs are obvious.”

### Puzzle C — What edge cases should I mention every time

**Ask yourself:** What edge cases should I mention every time?

**Answer:** “Empty input, single element, all duplicates, all same value, all negative (Kadane), strictly decreasing (max profit → 0), no valid pair, unicode vs ASCII (strings). You do not need to code every edge — naming them shows you will not ship a fragile solution.”
