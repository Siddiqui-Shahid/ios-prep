# Sample 01 — Approach scripts (Q&A)

> Guided teaching. Each answer stands alone; **Points to** shows where the full module expands the idea.

---

### Q1. What is the 60–90s “say this first” script?

**Points to:** [Foundations · §1 Master “say this first”](../01-foundations.md#1-master-say-this-first-6090s--memorize) · [Deep dive · §1 Two Sum](../02-deep-dive.md#1-two-sum)

**Answer:**

> Before typing, say: constraints (sorted? duplicates? mutate in place?), brute force and its complexity, the optimized pattern and why it works, time and space, then edge cases (empty, single element, all same). End with “coding the optimized version now.” If you skip this in practice, restart the problem.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why not jump straight to code? | Interviews grade process under uncertainty. A clear plan buys trust even if you hit a bug. |
| What if constraints change mid-problem? | Restate the new plan out loud — never silently rewrite for ten minutes. |
| Minimum time box? | About 60–90 seconds. Longer means you are stalling; shorter means you skipped edges. |

---

### Q2. What should I clarify before choosing a pattern?

**Points to:** [Foundations · §2 Pattern cheatsheet](../01-foundations.md#2-pattern-cheatsheet-embedded--no-external-read-required) · [Deep dive · §13 When interviewer changes constraints](../02-deep-dive.md#13-when-interviewer-changes-constraints-mid-flight)

**Answer:**

> Ask: input size, sorted or not, duplicates allowed, return indices or values, can I mutate the array, empty input allowed, negative numbers, guaranteed unique answer. These answers pick hash map vs two pointers vs window vs Kadane. Say them out loud so the interviewer can steer you early.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| “Can I sort?” | Sorting is O(n log n) — fine if it unlocks two pointers (3Sum), but say the cost. |
| “Mutate in place?” | Changes whether write-pointer patterns are allowed. |
| Duplicates matter how? | Two Sum needs distinct indices; 3Sum needs skip logic after sort. |

---

### Q3. How do I present brute force without sounding weak?

**Points to:** [Foundations · §7 Communication > clever](../01-foundations.md#7-communication--clever) · [Deep dive · §16 Brute → optimal comparison table](../02-deep-dive.md#16-brute--optimal-comparison-table)

**Answer:**

> Brute force is not failure — it is the baseline. Say “brute would be … O(?)” to show you understand the search space, then “I can do better because …” and name the pattern. Seniors always anchor optimal against brute so complexity trade-offs are obvious.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Interviewer says “just optimize”? | Give brute in one sentence, then pivot — do not skip entirely. |
| When is brute the answer? | Tiny n, or when asked to compare approaches before coding. |
| Example one-liner? | “All pairs is O(n²); one hash pass is O(n) time, O(n) space.” |

---

### Q4. What edge cases should I mention every time?

**Points to:** [Deep dive · §17 Edge-case bank](../02-deep-dive.md#17-edge-case-bank-quiz-yourself) · [Foundations · §1 Master “say this first”](../01-foundations.md#1-master-say-this-first-6090s--memorize)

**Answer:**

> Empty input, single element, all duplicates, all same value, all negative (Kadane), strictly decreasing (max profit → 0), no valid pair, unicode vs ASCII (strings). You do not need to code every edge — naming them shows you will not ship a fragile solution.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| All-negative Kadane? | Largest single element — the `max(x, running+x)` form handles it. |
| Empty string palindrome? | Usually true — confirm with interviewer. |
| Two Sum no solution? | Return empty or [-1,-1] per prompt — clarify. |

---

### Q5. When must I state time and space complexity?

**Points to:** [Foundations · §3 Complexity fluency](../01-foundations.md#3-complexity-fluency) · [Foundations · §9 Complexity cheat sheet](../01-foundations.md#9-complexity-cheat-sheet-say-out-loud)

**Answer:**

> Right after you name the optimized approach — every time. Pair the pattern with “O(n) time, O(n) space” (or O(1) extra). If output array is excluded from space by convention, say so. Omitting complexity is a common reason strong code still scores low.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| O(1) space with output array? | Clarify: O(1) *extra* aside from required output. |
| Sort then two pointers? | O(n log n) time from sort + O(n) scan — state both. |
| Hash map space? | O(n) worst case for stored entries. |

---

### Q6. What senior phrases signal good communication?

**Points to:** [Foundations · §7 Communication > clever](../01-foundations.md#7-communication--clever) · [Deep dive · §18 Narration anti-patterns](../02-deep-dive.md#18-narration-anti-patterns)

**Answer:**

> “I’d clarify whether we can mutate the input.” “Brute is clear; here’s why we can do better.” “I’ll dry-run on this example before coding further.” “If you need O(1) space, we can discuss trade-offs.” These show you think like a teammate, not a silent solver.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Anti-pattern? | Ten minutes of typing with no plan update after a hint. |
| Dry-run when? | After stating approach, before or during early coding. |
| Constraint change? | Restate plan — do not pretend the old code still fits. |

---

### Q7. Walk through say-this-first on Two Sum.

**Points to:** [Deep dive · §1 Two Sum](../02-deep-dive.md#1-two-sum) · [code/TwoSum.swift](../code/TwoSum.swift)

**Answer:**

> “Constraints? Duplicates? Guaranteed one answer? Brute: all pairs O(n²). Sorting loses original indices unless I store pairs. I’ll scan once: for each value look up `target - value` in a dictionary of value→index, else store current. Time O(n), space O(n). Edges: empty, no pair, negatives, duplicates. Coding now.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Invariant? | Map holds values seen so far with an index. |
| Trap? | Returning values instead of indices; using same element twice. |
| Dry-run? | `[2,7,11,15], target 9` → at 7 find 2 → `[0,1]`. |

---

Next: [02-two-pointers-window.md](02-two-pointers-window.md)
