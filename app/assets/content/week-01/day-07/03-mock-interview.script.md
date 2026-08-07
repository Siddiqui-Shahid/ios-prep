# Audio script — Sample 03 — Mock interview #1 (Q&A)
> Listen-only sample Q&A from `03-mock-interview.md`. Spoken answers and follow-ups.

## §0 Q1. What is Mock #1’s agenda and total time?

Next. Q1. What is Mock #1’s agenda and total time? Answer. ~60–90 minutes: defs (10 min) → concurrency + memory deep dive (25 min) → BookMyShow synchronised dictionaries story (10 min) → Social Feed high level design (20 min) → retro (10–15 min). Opener: “Defs → concurrency + memory deep dive → BookMyShow synchronised dictionaries story → feed high level design → retro.” Interviewer may cut at 2× budget — self-correct and continue. Follow-ups. Candidate uses notes?: No — mock is closed-book.. Solo mode?: Record voice memo; score against 04-questions full answers.. Script source?: Interviewer reads 02-deep-dive.md..

## §1 Q2. How does the warm-up block work?

Next. Q2. How does the warm-up block work? Answer. Ask any 5 from warm-up pool — ~45–60s each (~10 min total). Default set A: struct vs class, copy on write, weak vs unowned, serial vs concurrent, thread-safe dictionary design. Alternate set B: P O P, deadlock, actor, Sendable, cancellation. Full spoken answers in 04-questions.md — sample gives recall; 04 gives timing-grade detail. Follow-ups. How to practice?: Speak from Answer points in 04; uncover and compare full answer.. Overtime?: Agenda first — trim example, keep definition + trade-off.. Pass bar warm-up?: Not averaged separately — feeds confidence for deep dive..

## §2 Q3. What is in the deep dive block?

Next. Q3. What is in the deep dive block? Answer. 4–5 items, 90–120s each: actor reentrancy, serial sync re-entry deadlock, Memory Graph vs Leaks, G C D→actor migration, plus one stretch (Sendable ethics, type erasure, async/sync visibility). Follow-ups allowed. Model answers in 04 deep section. Target average ≥3.5 on deep-dive scores. Follow-ups. Actor reentrancy one-liner?: After await, another task may mutate actor state before you resume.. Graph vs Leaks?: Cycle = reachable abandoned; Leaks = unreachable only.. Migration label?: BookMyShow synchronised dictionaries (G C D prod) vs Design: actor SafeDict (not shipped) (actor)..

## §3 Q4. How does the 1–5 scoring rubric work?

Next. Q4. How does the 1–5 scoring rubric work? Answer. 1 blank/wrong. 2 partial or invented claim. 3 correct core, weak structure or overtime. 4 on time, agenda, trade-off or prod hook. 5 = 4 + crisp provenance + follow-up ready. Fill scorecard after mock; average deep-dive rows; BookMyShow synchronised dictionaries ≥4 required for pass. Follow-ups. Timing guide?:../../../timing/answer-timing-guide.md. 2× budget rule?: Self-correct in one sentence — still scored for recovery.. Retro output?: Top 5 weak cards → Week 2 warm-up pin..

## §4 Q5. How do I practice from “Answer points” in 04-questions?

Next. Q5. How do I practice from “Answer points” in 04-questions? Answer. Exercise 2 flow: Read question only → speak from Answer points (bullets, not full prose) → uncover Full spoken answer → compare structure, provenance, time. Repeat until points match full answer shape. This is how you avoid skeleton-only prep — points are cues, not substitutes. Follow-ups. Flashcards first?: Morning Exercise 1 — ≥80% pass target on second pass.. Miss a card?: Re-speak 20s answer aloud — silent reread does not count.. Deep pool?: Same two-layer pattern — points then full answer..

## §5 Q6. What are Mock #1 pass criteria?

Next. Q6. What are Mock #1 pass criteria? Answer. Deep-dive average ≥3.5. BookMyShow synchronised dictionaries score ≥4. No answer 2× budget without self-correction. At least one explicit trade-off in concurrency discussion. Zero invented fill-rate / crash-% claims. Optional: BookMyShow Ads pipeline + HeroWidget lifecycle encore ≤5 min after retro. Follow-ups. Failed one deep question?: OK if average holds — pin weak topic to Week 2.. Failed BookMyShow synchronised dictionaries?: Re-drill sample 02 + production bridge before Week 2.. D S A today?: Light exercise 5 — not part of mock pass formula..

## §6 Q7. What should the retro include?

Next. Q7. What should the retro include? Answer. Fill MockScorecard (warm-up, deep, BookMyShow synchronised dictionaries, mini SD). Average deep scores. List top 5 weak cards for Week 2 warm-ups. One retro one-liner: what improved vs what to drill. Optional BookMyShow Ads pipeline + HeroWidget lifecycle encore if energy remains. Follow-ups. Provenance incidents row?: Must be zero invented metrics.. Social Feed scored?: Clarifying + high level design bullets — see sample 04.. Interviewer cut lines?: Deep dive §6 — use when 2× overtime..

## §7 Q8. D1 — Actor reentrancy after await?

Next. Q8. D1 — Actor reentrancy after await? Answer. Actors prevent data races on isolated state, but they are reentrant across await. If I read a key, await a loader, then write, another task may have entered and changed that key meanwhile. Re-validate after await — check again, use a generation token, or load outside and apply a short synchronous set. Race-freedom ≠ logic-correctness. Follow-ups. Trap?: “Actors prevent all concurrency bugs.”. G C D serial without await?: Serial queue runs one block at a time without suspension mid-block — different reentrancy story.. Single-flight?: One in-flight load; waiters share the result — pairs with re-check after await..

## §8 Q9. D2 — sync serial re-entry deadlock?

Next. Q9. D2 — sync serial re-entry deadlock? Answer. Any serial queue can deadlock if you’re already executing on it and call sync again — you’re waiting for yourself. Main is the famous case, but private queues fail the same way when APIs nest. Split public sync wrappers from unlocked internals, or schedule nested work async. dispatchPrecondition helps catch mistakes. Follow-ups. Trap?: “Only main.sync deadlocks.”. Delegate while holding queue?: Callback can re-enter — unlock or async before calling out.. Actor contrast?: Actor uses await suspension, not nested sync on the same queue..

## §9 Q10. D3 — Memory Graph cycle vs Leaks?

Next. Q10. D3 — Memory Graph cycle vs Leaks? Answer. Leaks finds objects with no pointers — true leaks. A retain cycle keeps objects reachable from each other, so they may never appear as classic leaks even though they won’t deallocate. Memory Graph shows those cycles visually; Allocations helps with abandoned growth. Treat as reliability work — without inventing a memory-only metric. Follow-ups. Abandoned vs leaked?: Abandoned = still referenced/unused; leaked = unreachable.. deinit not called?: Graph for owners; weak/invalidate/cancel checklist.. Autorelease pools?: Peak temporaries — not a cycle fix..

## §10 Q11. D4 — `@unchecked Sendable` ethics?

Next. Q11. D4 — `@unchecked Sendable` ethics? Answer. @unchecked Sendable tells the compiler to trust you without verifying. Sometimes needed at legacy boundaries, but it’s an ethics and review issue — document the invariant that makes crossing threads safe, or you reintroduce races under a green build. Prefer wrapping mutable legacy state in an actor or exposing immutable snapshots. Follow-ups. Trap?: Sprinkle unchecked to silence errors.. Justified case?: Legacy class you cannot change, with a documented thread-safe invariant.. Prefer redesign?: Actor, immutable snapshot, or value types first..

## §11 Q12. D5 — Type erasure cost in a renderer?

Next. Q12. D5 — Type erasure cost in a renderer? Answer. Type erasure boxes disparate conformers into one type — useful for heterogeneous ad lists — but you pay allocation, indirection, and lost generic specialization, and you often collapse associated types to a common denominator. Keep generics inside the hot pipeline; erase only at the boundary that needs heterogeneity. P O P + generics first — don’t claim every renderer was erased. Follow-ups. Trap?: Erase everything for cleaner types.. any vs hand eraser?: any Protocol is language erasure; hand-rolled box is the older pattern.. Measure?: Instruments — allocation / time on the render path..

## §12 Q13. D6 — COW uniqueness traps?

Next. Q13. D6 — COW uniqueness traps? Answer. After var b = a on an Array, they may share a buffer. Mutating b copies if the buffer isn’t unique — a stays old. If something else holds a reference that breaks uniqueness, you pay a copy. A struct containing a class still shares that class on “copy.” copy on write = cheap share until write; uniqueness decides. Follow-ups. Trap?: Always shared or always copied.. Nested class?: Value shell copies; class reference still shared.. Defensive copy anti-pattern?: Blind Array(other) when copy on write already shares cheaply..

## §13 Q14. D7 — GCD sync inside async contexts?

Next. Q14. D7 — GCD sync inside async contexts? Answer. Calling queue.sync from an async function blocks a thread until the queue runs the block. In the cooperative concurrency model that can starve other work. Prefer awaiting an actor or continuation-based async wrappers that schedule with async, not sync. Correctness without blocking the async world is the goal. Follow-ups. Trap?: “sync is fine everywhere for correctness.”. When is sync still OK?: Known non-async threads / tiny critical sections you can justify.. Bridge?: withCheckedContinuation / actor APIs instead of sync..

## §14 Q15. D8 — Migrating SafeDict GCD → actor?

Next. Q15. D8 — Migrating SafeDict GCD → actor? Answer. Production synchronised dictionaries used G C D — that’s Verified. Migration without big-bang: introduce an actor with the same get/set/snapshot semantics behind a protocol, move one module at a time, and let call sites await. Optional temporary G C D façade bridging to the actor. Validate under concurrency stress. Label Design: actor SafeDict (not shipped) — don’t claim the migration already shipped. Follow-ups. Trap?: Big-bang rewrite next sprint, or claiming already done.. Sync A P I over actor?: Generally avoid — fights the await model.. Reentrancy?: Load-if-missing still needs post-await re-check (D1)..
