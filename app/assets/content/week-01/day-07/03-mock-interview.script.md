# Audio script — Sample 03 — Mock interview #1 (Q&A)
> Listen-only sample Q&A from `03-mock-interview.md`. Spoken answers and follow-ups.

## §0 Q1. What is Mock #1’s agenda and total time?

Next. Q1. What is Mock #1’s agenda and total time? Answer. ~60–90 minutes: defs (10 min) → concurrency + memory deep dive (25 min) → S 2 story (10 min) → Social Feed high level design (20 min) → retro (10–15 min). Opener: “Defs → concurrency + memory deep dive → S 2 story → feed high level design → retro.” Interviewer may cut at 2× budget — self-correct and continue. Follow-ups. Candidate uses notes?: No — mock is closed-book.. Solo mode?: Record voice memo; score against 04-questions full answers.. Script source?: Interviewer reads 02-deep-dive.md..

## §1 Q2. How does the warm-up block work?

Next. Q2. How does the warm-up block work? Answer. Ask any 5 from warm-up pool — ~45–60s each (~10 min total). Default set A: struct vs class, copy on write, weak vs unowned, serial vs concurrent, thread-safe dictionary design. Alternate set B: P O P, deadlock, actor, Sendable, cancellation. Full spoken answers in 04-questions.md — sample gives recall; 04 gives timing-grade detail. Follow-ups. How to practice?: Speak from Answer points in 04; uncover and compare full answer.. Overtime?: Agenda first — trim example, keep definition + trade-off.. Pass bar warm-up?: Not averaged separately — feeds confidence for deep dive..

## §2 Q3. What is in the deep dive block?

Next. Q3. What is in the deep dive block? Answer. 4–5 items, 90–120s each: actor reentrancy, serial sync re-entry deadlock, Memory Graph vs Leaks, G C D→actor migration, plus one stretch (Sendable ethics, type erasure, async/sync visibility). Follow-ups allowed. Model answers in 04 deep section. Target average ≥3.5 on deep-dive scores. Follow-ups. Actor reentrancy one-liner?: After await, another task may mutate actor state before you resume.. Graph vs Leaks?: Cycle = reachable abandoned; Leaks = unreachable only.. Migration label?: Verified S 2 (G C D prod) vs Applied S 2-A1 (actor)..

## §3 Q4. How does the 1–5 scoring rubric work?

Next. Q4. How does the 1–5 scoring rubric work? Answer. 1 blank/wrong. 2 partial or invented claim. 3 correct core, weak structure or overtime. 4 on time, agenda, trade-off or prod hook. 5 = 4 + crisp provenance + follow-up ready. Fill scorecard after mock; average deep-dive rows; S 2 ≥4 required for pass. Follow-ups. Timing guide?:../../../timing/answer-timing-guide.md. 2× budget rule?: Self-correct in one sentence — still scored for recovery.. Retro output?: Top 5 weak cards → Week 2 warm-up pin..

## §4 Q5. How do I practice from “Answer points” in 04-questions?

Next. Q5. How do I practice from “Answer points” in 04-questions? Answer. Exercise 2 flow: Read question only → speak from Answer points (bullets, not full prose) → uncover Full spoken answer → compare structure, provenance, time. Repeat until points match full answer shape. This is how you avoid skeleton-only prep — points are cues, not substitutes. Follow-ups. Flashcards first?: Morning Exercise 1 — ≥80% pass target on second pass.. Miss a card?: Re-speak 20s answer aloud — silent reread does not count.. Deep pool?: Same two-layer pattern — points then full answer..

## §5 Q6. What are Mock #1 pass criteria?

Next. Q6. What are Mock #1 pass criteria? Answer. Deep-dive average ≥3.5. S 2 score ≥4. No answer 2× budget without self-correction. At least one explicit trade-off in concurrency discussion. Zero invented fill-rate / crash-% claims. Optional: S 1 encore ≤5 min after retro. Follow-ups. Failed one deep question?: OK if average holds — pin weak topic to Week 2.. Failed S 2?: Re-drill sample 02 + production bridge before Week 2.. D S A today?: Light exercise 5 — not part of mock pass formula..

## §6 Q7. What should the retro include?

Next. Q7. What should the retro include? Answer. Fill MockScorecard (warm-up, deep, S 2, mini SD). Average deep scores. List top 5 weak cards for Week 2 warm-ups. One retro one-liner: what improved vs what to drill. Optional S 1 encore if energy remains. Follow-ups. Provenance incidents row?: Must be zero invented metrics.. Social Feed scored?: Clarifying + high level design bullets — see sample 04.. Interviewer cut lines?: Deep dive §6 — use when 2× overtime.. Next: 04-warmup-hld.md.
