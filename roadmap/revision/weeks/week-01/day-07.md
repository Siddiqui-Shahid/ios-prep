# Day 07 — Week 1 Revision + Mock Interview #1

> Week 1 · Mock day · Time budget today: ~5–6 hrs

## 1. Outcome

- Active-recall all Week 1 flashcards (≥80% correct)
- Deliver S2 (synchronised dictionaries) in ≤3 min at score ≥4
- Complete Mock #1: concurrency + memory deep dive with timed answers
- Close Social Feed LLD notes (cache + infinite scroll bullets)

## 2. Concept deep dive — revision map

| Topic | Day | Must-nail |
|---|---|---|
| struct/class/COW/enum | 01 | Value semantics + payment states |
| POP/generics/type erasure | 02 | Ads pipeline rationale |
| ARC/cycles/Instruments | 03 | weak vs unowned; Graph vs Leaks |
| GCD sync dict | 04 | Serial API; deadlock |
| async/await/actors/Sendable | 05 | Reentrancy; cancel |
| DSA patterns | 06 | Window + two pointers |

### 2.1 Mock #1 format (60–90 min)

| Block | Time | Content |
|---|---|---|
| Warm-up defs | 10 min | 5× 45s definitions from Weeks 1 |
| Deep dive | 25 min | Concurrency + memory (interviewer-style follow-ups) |
| Story | 10 min | S2 full STAR + “actor migration” follow-up |
| Mini SD | 20 min | Social feed: clarify + HLD only |
| Retro | 10–15 min | Score with timing rubric |

Partner script (or self): ask Normal then Tricky from Days 03–05 without letting notes show.

## 3. Read these

| Priority | Resource | Why |
|---|---|---|
| Must | [flashcards/week-01.md](../../flashcards/week-01.md) | Active recall |
| Must | [timing guide](../../timing/answer-timing-guide.md) | Scoring |
| Must | [S2 story](../../stories/story-bank.md#s2--synchronised-dictionaries-bookmyshow) | Mock centerpiece |
| Repo | [social-feed.md](../../../ios-system-design/docs/social-feed.md) LLD sections | Finish Week 1 SD |

## 4. Map to your work

Today’s narrative spine is **reliability under concurrency at BMS scale** (30L+ DAU, crash-free culture) — S2 + S8 adjacent.

**Interview line:** “Week 1 theme: I don’t just know GCD and actors — I’ve shipped race fixes on a large consumer app and can discuss migration paths.”

## 5. Normal questions (mock warm pool)

Pull live from Days 01–05. Priority set:

1. struct vs class (45s)  
2. COW (45s)  
3. weak vs unowned (45s)  
4. serial vs concurrent (45s)  
5. async/await vs GCD (60s)  
6. thread-safe dictionary design (2 min)  
7. actor isolation (60s)  
8. Sendable (45s)  
9. retain cycle examples (60s)  
10. Main-queue deadlock (45s)  
11. Task cancellation (60s)  
12. POP in ads pipeline (60s)  

## 6. Tricky questions (mock deep pool)

1. Actor reentrancy after await  
2. sync to serial queue re-entry deadlock  
3. Memory Graph cycle vs Leaks tool  
4. `@unchecked Sendable` ethics  
5. Type erasure cost in renderer  
6. COW uniqueness traps  
7. Mixing GCD sync inside async contexts  
8. Migrating SafeDict GCD → actor without big-bang  

## 7. Flashcards for today

Use full Week 1 deck. Quick meta cards:

| Front | Back |
|---|---|
| Mock agenda opener | “Defs → concurrency deep dive → story → feed HLD” |
| S2 time box | ≤3 min STAR |
| Score 5 means | On time + trade-off + prod proof |
| Weak topic rule | Re-drill before Week 2 |
| SD clarify first | DAU, offline, pagination |
| No new topics | Revision only today |

## 8. Practice

- **Morning:** Flashcards full deck + rewrite gotchas cleanly  
- **Mid:** Mock #1 with peer/self recording  
- **Late:** Social feed LLD bullets: cursor pagination, image cache tiers, prefetch cancellation  
- **Coding light:** Re-solve 2 misses from Day 06  

## 9. Timed drill

1. Full Mock #1 with timer visible.  
2. Score every answer 1–5.  
3. List top 5 weak cards → pin to Week 2 daily warm-up.  
4. Deliver S1 Ads POP talk once in 5 min (preview Mock #2) — optional if energy allows.

### Mock #1 pass criteria

- Average ≥3.5 on deep-dive answers  
- S2 ≥4  
- No answer >2× budget without self-correction  
- At least one explicit trade-off in concurrency discussion  
