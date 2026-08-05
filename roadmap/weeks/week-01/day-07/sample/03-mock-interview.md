# Sample 03 — Mock interview #1 (Q&A)

> Guided teaching. Each answer stands alone; **Points to** shows where the full module expands the idea.

---

### Q1. What is Mock #1’s agenda and total time?

**Points to:** [Foundations · §3 Mock #1 format](../01-foundations.md#3-mock-1-format-6090-min) · [02-deep-dive · §0 Setup](../02-deep-dive.md#0-setup-2-min)

**Answer:**

> ~60–90 minutes: **defs** (10 min) → **concurrency + memory deep dive** (25 min) → **S2 story** (10 min) → **Social Feed HLD** (20 min) → **retro** (10–15 min). Opener: “Defs → concurrency + memory deep dive → S2 story → feed HLD → retro.” Interviewer may cut at 2× budget — self-correct and continue.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Candidate uses notes? | No — mock is closed-book. |
| Solo mode? | Record voice memo; score against 04-questions full answers. |
| Script source? | Interviewer reads [`02-deep-dive.md`](../02-deep-dive.md). |

---

### Q2. How does the warm-up block work?

**Points to:** [02-deep-dive · §1 Warm-up definitions](../02-deep-dive.md#1-warm-up-definitions-10-min) · [Foundations · §5 Warm-up pool](../01-foundations.md#5-warm-up-pool-ids--full-answers-in-04)

**Answer:**

> Ask **any 5** from warm-up pool — ~45–60s each (~10 min total). Default set A: struct vs class, COW, weak vs unowned, serial vs concurrent, thread-safe dictionary design. Alternate set B: POP, deadlock, actor, Sendable, cancellation. Full spoken answers in [`04-questions.md`](../04-questions.md) — sample gives recall; 04 gives timing-grade detail.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| How to practice? | Speak from **Answer points** in 04; uncover and compare full answer. |
| Overtime? | Agenda first — trim example, keep definition + trade-off. |
| Pass bar warm-up? | Not averaged separately — feeds confidence for deep dive. |

---

### Q3. What is in the deep dive block?

**Points to:** [02-deep-dive · §2 Deep dive](../02-deep-dive.md#2-deep-dive-25-min) · [Foundations · §6 Deep pool](../01-foundations.md#6-deep-pool-ids)

**Answer:**

> **4–5 items**, 90–120s each: actor reentrancy, serial sync re-entry deadlock, Memory Graph vs Leaks, GCD→actor migration, plus one stretch (Sendable ethics, type erasure, async/sync visibility). Follow-ups allowed. Model answers in 04 deep section. Target average **≥3.5** on deep-dive scores.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Actor reentrancy one-liner? | After `await`, another task may mutate actor state before you resume. |
| Graph vs Leaks? | Cycle = reachable abandoned; Leaks = unreachable only. |
| Migration label? | Verified S2 (GCD prod) vs Applied S2-A1 (actor). |

---

### Q4. How does the 1–5 scoring rubric work?

**Points to:** [Foundations · §4 Scoring rubric](../01-foundations.md#4-scoring-rubric-15) · [code/MockScorecard.md](../code/MockScorecard.md)

**Answer:**

> **1** blank/wrong. **2** partial or invented claim. **3** correct core, weak structure or overtime. **4** on time, agenda, trade-off or prod hook. **5** = 4 + crisp provenance + follow-up ready. Fill scorecard after mock; average deep-dive rows; **S2 ≥4** required for pass.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Timing guide? | [`../../../timing/answer-timing-guide.md`](../../../timing/answer-timing-guide.md) |
| 2× budget rule? | Self-correct in one sentence — still scored for recovery. |
| Retro output? | Top 5 weak cards → Week 2 warm-up pin. |

---

### Q5. How do I practice from “Answer points” in 04-questions?

**Points to:** [04-questions · Warm-up pool](../04-questions.md#warm-up-pool) · [05-exercises · Exercise 2](../05-exercises.md#exercise-2--warm-up-speaking-3040-min)

**Answer:**

> **Exercise 2 flow:** Read question only → speak from **Answer points** (bullets, not full prose) → uncover **Full spoken answer** → compare structure, provenance, time. Repeat until points match full answer shape. This is how you avoid skeleton-only prep — points are cues, not substitutes.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Flashcards first? | Morning Exercise 1 — ≥80% pass target on second pass. |
| Miss a card? | Re-speak 20s answer aloud — silent reread does not count. |
| Deep pool? | Same two-layer pattern — points then full answer. |

---

### Q6. What are Mock #1 pass criteria?

**Points to:** [README · Pass criteria](../README.md#pass-criteria-mock-1) · [05-exercises · Exit criteria](../05-exercises.md#exit-criteria)

**Answer:**

> Deep-dive average ≥3.5. S2 score ≥4. No answer >2× budget without self-correction. At least one explicit **trade-off** in concurrency discussion. **Zero** invented fill-rate / crash-% claims. Optional: S1 encore ≤5 min after retro.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Failed one deep question? | OK if average holds — pin weak topic to Week 2. |
| Failed S2? | Re-drill sample 02 + production bridge before Week 2. |
| DSA today? | Light exercise 5 — not part of mock pass formula. |

---

### Q7. What should the retro include?

**Points to:** [02-deep-dive · §5 Retro](../02-deep-dive.md#5-retro-1015-min) · [code/MockScorecard.md](../code/MockScorecard.md)

**Answer:**

> Fill MockScorecard (warm-up, deep, S2, mini SD). Average deep scores. List **top 5 weak cards** for Week 2 warm-ups. One retro one-liner: what improved vs what to drill. Optional S1 encore if energy remains.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Provenance incidents row? | Must be **zero** invented metrics. |
| Social Feed scored? | Clarifying + HLD bullets — see sample 04. |
| Interviewer cut lines? | Deep dive §6 — use when 2× overtime. |

---

Next: [04-warmup-hld.md](04-warmup-hld.md)
