# 01 — Foundations: Week 1 Revision Map + Mock Format

> No new topics. Compress Week 1 into speakable atoms, then run Mock #1.

---

## 0. North star

**Prove you can retrieve and trade-off Week 1 under a timer — with resume-honest provenance.**

---

## 1. Revision map (must-nail)

| Topic | Day | Must-nail line |
|---|---|---|
| struct/class/COW/enum | 01 | Value semantics; payment states as enums (S7-A1 design) |
| POP/generics/type erasure | 02 | Ads pipeline rationale (S1); erasure costs |
| ARC/cycles/Instruments | 03 | weak vs unowned; Graph vs Leaks |
| GCD SafeDict | 04 | Serial API; deadlock; async-write visibility; `final class` |
| async/await/actors/Sendable | 05 | Reentrancy; cancel; S2-A1 |
| DSA patterns | 06 | Window + two pointers + say-this-first |

---

## 2. Flashcard strategy (morning)

1. Full Week 1 deck: [`../../../flashcards/week-01.md`](../../../flashcards/week-01.md)  
2. Mark misses.  
3. Re-speak misses as 20s answers (not silent reread).  
4. Target ≥80% correct on second pass.

Meta cards for today:

| Front | Back |
|---|---|
| Mock agenda | Defs → concurrency/memory → S2 → feed HLD → retro |
| S2 time box | ≤3 min STAR |
| Score 5 | On time + trade-off + prod proof + honest provenance |
| Weak topic rule | Re-drill before Week 2 |
| SD clarify first | DAU, offline, pagination, ads mix |
| No new topics | Revision only |

---

## 3. Mock #1 format (60–90 min)

| Block | Time | Content |
|---|---|---|
| Warm-up defs | 10 min | 5× ~45s from warm-up pool |
| Deep dive | 25 min | Concurrency + memory follow-ups |
| Story | 10 min | S2 full STAR + actor migration follow-up |
| Mini SD | 20 min | Social feed: clarify + HLD only |
| Retro | 10–15 min | Score with rubric |

Partner or self: interviewer reads from [`02-deep-dive.md`](02-deep-dive.md). Candidate uses **no notes**.

---

## 4. Scoring rubric (1–5)

| Score | Meaning |
|---|---|
| 1 | Blank / wrong concept |
| 2 | Partial; major hole or invented claim |
| 3 | Correct core; weak structure or overtime |
| 4 | On time; agenda; trade-off or prod hook |
| 5 | 4 + crisp provenance + follow-up ready |

Use [`../../../timing/answer-timing-guide.md`](../../../timing/answer-timing-guide.md) for budgets.

---

## 5. Warm-up pool (IDs — full answers in 04)

1. struct vs class  
2. COW  
3. weak vs unowned  
4. serial vs concurrent  
5. async/await vs GCD  
6. thread-safe dictionary design  
7. actor isolation  
8. Sendable  
9. retain cycle examples  
10. Main-queue deadlock  
11. Task cancellation  
12. POP in ads pipeline  

---

## 6. Deep pool (IDs)

1. Actor reentrancy after await  
2. sync to serial queue re-entry deadlock  
3. Memory Graph cycle vs Leaks  
4. `@unchecked Sendable` ethics  
5. Type erasure cost in renderer  
6. COW uniqueness traps  
7. Mixing GCD sync inside async contexts  
8. Migrating SafeDict GCD → actor without big-bang  

---

## 7. Self-check before mock

- [ ] S2 ≤20s pitch cold  
- [ ] Async write / sync read caveat one sentence  
- [ ] weak vs unowned one sentence  
- [ ] Actor reentrancy one sentence  
- [ ] S1 ≤20s available as optional encore  

→ [`02-deep-dive.md`](02-deep-dive.md) for the live script.
