# 02 — Deep Dive: Worked Approaches (then code/) (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Simple language. Named work only — never S-codes in speech.

---

### Q1. Two Sum? `(45–60s)`
**Answer:**

> “Prompt: Given nums and target, return indices i, j with nums[i] + nums[j] == target. Say this first (60s): “Constraints? Duplicates? Guaranteed one answer? Brute: try all pairs O(n²). Sorting loses original indices unless I store pairs. I’ll scan once: for each value look up target - value in a dictionary of value→index, else store current. Time O(n), space O(n). Edges: empty, no pair, negatives, duplicates.”.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q2. Best Time to Buy and Sell Stock? `(45–60s)`
**Answer:**

> “Prompt: Max profit from one buy + one later sell; else 0. Say this first: “One transaction. Brute all pairs O(n²). Track minimum price so far and max profit = price - min. O(n)/O(1). Edges: length 1, strictly decreasing → 0.”.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q3. Valid Palindrome? `(45–60s)`
**Answer:**

> “Prompt: Alphanumeric only, case-insensitive palindrome? Say this first: “Two pointers from ends. Skip non-alnum; compare lowercased. O(n)/O(1) extra if we index the string carefully — in Swift I’ll use Array(s) for clarity O(n) space, or walk String.Index. Edges: empty, all punctuation, unicode — I’ll clarify charset; LeetCode is ASCII alnum.”.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q4. Container With Most Water? `(45–60s)`
**Answer:**

> “Prompt: Heights at indices; max min(h[l],h[r]) (r-l). Say this first: “Brute all pairs O(n²). Start at ends — max width. Move the shorter side inward; only a taller short-side can improve. O(n)/O(1). Edges: n=2, all equal.”.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q5. Longest Substring Without Repeating Characters? `(45–60s)`
**Answer:**

> “Prompt: Length of longest substring with all unique chars. Say this first: “Variable window. Expand right; if duplicate, shrink left until unique — typically with last-seen index map. Each index moves at most once → O(n). Space O(min(n, alphabet)). Edges: empty, all unique, all same.”.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q6. Maximum Subarray (Kadane)? `(45–60s)`
**Answer:**

> “Prompt: Contiguous subarray with largest sum. Say this first: “Brute O(n²) sums. Kadane: running sum; if running < 0 reset to 0 before adding next — actually classic: running = max(x, running+x); track global max. All-negative: answer is largest element — the max(x, running+x) form handles it. O(n)/O(1).”.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q7. Product of Array Except Self? `(45–60s)`
**Answer:**

> “Prompt: out[i] = product of all except i; no division; O(n). Say this first: “Left products pass into output; right products multiply on the way back. O(n) time, O(1) extra if output doesn’t count. Edges: zeros (one zero, two zeros), negatives.”.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q8. Move Zeroes? `(45–60s)`
**Answer:**

> “Prompt: Move zeroes to end in place; keep relative order of non-zeroes. Say this first: “Write pointer: write non-zeroes forward, then fill zeroes. O(n)/O(1). Edges: no zeroes, all zeroes, already packed.”.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q9. 3Sum (stretch)? `(45–60s)`
**Answer:**

> “Say this first: “Sort O(n log n). Fix i; two-sum on remainder with left/right; skip duplicates. O(n²). Edges: all zero, <3 elements, many dups.” Code: code/ThreeSum.swift.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q10. Minimum Size Subarray Sum (stretch)? `(45–60s)`
**Answer:**

> “Say this first: “Positive nums assumed for two-pointer window. Expand until sum ≥ target; shrink left; track min length. Impossible → 0. O(n).” Code: code/MinSubArrayLen.swift.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q11. Group Anagrams (bridge)? `(45–60s)`
**Answer:**

> “Say this first: “Key by sorted string or 26-count signature; bucket in dictionary. O(n·k log k) sorted keys or O(n·k) counts.” Code: code/GroupAnagrams.swift.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q12. Pattern ID drills (no code)? `(45–60s)`
**Answer:**

> “---.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q13. When interviewer changes constraints mid-flight? `(45–60s)`
**Answer:**

> “Trap: Silent panic rewrite.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q14. Off-by-one window checklist? `(45–60s)`
**Answer:**

> “Before submitting mentally: 1. Is right inclusive in length right - left + 1? 2. When duplicate at right, is left = last[c] + 1? 3. Did you max(left, …) so left never moves backward? 4. Dry-run "abba" for longest unique substring.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q15. Two Sum — `[2,7,11,15], target 9`? `(45–60s)`
**Answer:**

> “See the notes for this topic and speak the core idea in simple words.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q16. Longest substring — `"abba"`? `(45–60s)`
**Answer:**

> “Answer length 2 ("bb" or "ba" depending on window — length 2).”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q17. Kadane — `[-2,1,-3,4,-1,2,1,-5,4]`? `(45–60s)`
**Answer:**

> “Track running / best through each element; best ends at 6 ([4,-1,2,1]).”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q18. Container water — `[1,8,6,2,5,4,8,3,7]`? `(45–60s)`
**Answer:**

> “Start l=0,r=8 → min(1,7)8=8; move left (shorter). Continue until best 49.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q19. Product except self — `[1,2,3,4]`? `(45–60s)`
**Answer:**

> “Left pass out=[1,1,2,6]; right multiply → [24,12,8,6]. ---.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q20. Brute → optimal comparison table? `(45–60s)`
**Answer:**

> “---.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q21. Edge-case bank (quiz yourself)? `(45–60s)`
**Answer:**

> “---.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q22. Narration anti-patterns? `(45–60s)`
**Answer:**

> “---.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q23. Link to dsa-track (optional)? `(45–60s)`
**Answer:**

> “Canonical list also lives in ../../../coding/dsa-track.md. This chapter embeds Week 1 patterns and solutions — use the track for spaced review across weeks, not as a blocker today. ---.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q24. Next? `(45–60s)`
**Answer:**

> “Implement from memory using code/, then 03-production-bridge.md.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q25. Exit checklist (deep dive)? `(45–60s)`
**Answer:**

> “- [ ] Spoke Two Sum + window + Kadane approaches without peeking - [ ] Dry-ran "abba" and one Kadane array - [ ] Named brute vs optimal for each core problem once - [ ] Opened at least 6 files under code/ and explained them aloud - [ ] Recited say-this-first from memory once more before coding block.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---
