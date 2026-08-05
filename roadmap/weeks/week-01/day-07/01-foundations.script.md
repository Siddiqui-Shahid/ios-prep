# Audio script — 01 Foundations
> Listen-only audiobook of `01-foundations.md` (Day 07 — Week 1 Revision + Mock Interview #1). Simple English. Basic explanations. Self-contained speech. Does not assume you are looking at a screen.


## §0 Introduction

Next. Introduction.

No new topics. Compress Week 1 into speakable atoms, then run Mock #1.

## §1 0. North star

Next. 0. main guiding idea. That means the main guiding idea.

Prove you can retrieve and trade-off Week 1 under a timer. with resume-honest provenance.

## §2 1. Revision map (must-nail)

Next. 1. Revision map (must-nail).

Topic: Day, Must-nail line. struct/class/copy on write/enum: 01, Value semantics. payment states as enums (S7-A1 design). P O P/generics/type erasure: 02, Ads pipeline rationale (S1). erasure costs. automatic reference counting/cycles/Instruments: 03, weak vs unowned. Graph vs Leaks. G C D SafeDict: 04, Serial A P I. deadlock. async-write visibility. final class. async/await/actors/Sendable: 05, Reentrancy. cancel. S2-A1. DSA patterns: 06, Window + two pointers + say-this-first.

## §3 2. Flashcard strategy (morning)

Next. 2. Flashcard strategy (morning).

Full Week 1 deck:../../../flashcards/week-01.md Mark misses. Re-speak misses as 20s answers (not silent reread). Target ≥80% correct on second pass. Meta cards for today: Front: Back. Mock agenda: Defs. concurrency/memory. S2. feed HLD. retro. S2 time box: ≤3 min STAR. Score 5: On time + trade-off + prod proof + honest provenance. Weak topic rule: Re-drill before Week 2. SD clarify first: DAU, offline, pagination, ads mix. No new topics: Revision only.

## §4 3. Mock #1 format (60–90 min)

Next. 3. Mock #1 format (60–90 min).

Block: Time, Content. Warm-up defs: 10 min, 5× ~45s from warm-up pool. Deep dive: 25 min, Concurrency + memory follow-ups. Story: 10 min, S2 full STAR + actor migration follow-up. Mini SD: 20 min, Social feed: clarify + HLD only. Retro: 10. 15 min, Score with rubric. Partner or self: interviewer reads from 02-deep-dive.md. Candidate uses no notes.

## §5 4. Scoring rubric (1–5)

Next. 4. Scoring rubric (1–5).

Score: Meaning. 1: Blank / wrong concept. 2: Partial. major hole or invented claim. 3: Correct core. weak structure or overtime. 4: On time. agenda. trade-off or prod hook. 5: 4 + clear provenance + follow-up ready. Use../../../timing/answer-timing-guide.md for budgets.

## §6 5. Warm-up pool (IDs — full answers in 04)

Next. 5. Warm-up pool (IDs — full answers in 04).

struct vs class copy on write weak vs unowned serial vs concurrent async/await vs G C D thread-safe. dictionary design actor isolation Sendable retain cycle examples Main-queue deadlock Task cancellation P O P in ads pipeline.

## §7 6. Deep pool (IDs)

Next. 6. Deep pool (IDs).

Actor reentrancy after await sync to serial queue re-entry deadlock Memory Graph cycle vs Leaks @unchecked Sendable ethics. Type erasure cost in renderer copy on write uniqueness traps Mixing G C D sync inside async contexts. Migrating SafeDict G C D. actor without big-bang.

## §8 7. Self-check before mock

Next. 7. Self-check before mock.

[ ] S2 ≤20s pitch cold [ ] Async write / sync read caveat one sentence [ ]. weak vs unowned one sentence [ ] Actor reentrancy one sentence [ ] S1 ≤20s available as optional. encore. 02-deep-dive.md for the live script.
