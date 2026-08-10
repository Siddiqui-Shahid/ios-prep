# Day 07 — Week 1 Revision + Mock Interview #1

> Week 1 · Revision pass ~45–60 min (mock block: ~60–90 min)  
> Full study: [weeks/week-01/day-07/](../../../weeks/week-01/day-07/README.md)  
> Sample Q&A (guided): [weeks/week-01/day-07/sample/](../../../weeks/week-01/day-07/sample/README.md)

## 1. Outcome

Explain aloud, in plain sentences:

- Active-recall Week 1 core — value types, POP, ARC, GCD, async — without notes
- Deliver verified BookMyShow synchronised dictionaries synchronised dictionaries in ≤3 min at score ≥4
- Run Mock #1: defs → concurrency/memory deep dive → story → feed HLD → retro
- Score honestly: on time, trade-off named, prod proof with correct provenance

## 2. Concept refresh (simple)

### 2.1 Week 1 revision map

| Topic | Day | Must-nail |
|---|---|---|
| struct/class/COW/enum | 01 | Value semantics + payment states |
| POP/generics/type erasure | 02 | Ads pipeline rationale |
| ARC/cycles/Instruments | 03 | weak vs unowned; Graph vs Leaks |
| GCD sync dict | 04 | Serial API; deadlock |
| async/await/actors/Sendable | 05 | Reentrancy; cooperative cancel |
| DSA patterns | 06 | Window + two pointers |

### 2.2 Mock #1 agenda

Defs (10 min) → concurrency + memory deep dive (25 min) → **BookMyShow synchronised dictionaries story** (10 min) → Social Feed HLD warm-up (20 min) → retro (10–15 min).

Score 5 = on time + trade-off + prod proof + **honest provenance** (Verified vs Applied). Zero fake fill-rate or crash-% ownership.

### 2.3 Critical truths (pin)

| Claim | Truth |
|---|---|
| Mock agenda | Defs → concurrency/memory → BookMyShow synchronised dictionaries → feed HLD → retro |
| BookMyShow synchronised dictionaries time box | ≤3 min STAR; ≤20s elevator also |
| Score 5 | On time + trade-off + prod proof + honest provenance |
| Design: actor SafeDict (not shipped) | Actor migration is **How I would apply it** — not “we rewrote prod” |
| No invention | Zero fake fill-rate / crash-% ownership |
| Full answers | Warm-up/deep answer points live in 07-revision-qna |

## 3. Read these

| Priority | Resource | Why |
|---|---|---|
| Must | [Sample Q&A](../../../weeks/week-01/day-07/sample/) | Guided cards |
| Must | Full modules [01–03](../../../weeks/week-01/day-07/01-foundations.md) | Gaps |
| Drill | [07-revision-qna](../../../weeks/week-01/day-07/sample/07-revision-qna.md) | Timed answers |

## 4. Map to your work

Today’s narrative spine: **reliability under concurrency at BMS scale** — verified BookMyShow synchronised dictionaries (synchronised dictionaries) plus BookMyShow IMOC + crash-free at scale-adjacent reliability culture (30L+ DAU, 99.95%+ CFS).

**BookMyShow synchronised dictionaries:** GCD serial-queue dictionaries eliminated path-specific race crashes.  
**Design: actor SafeDict (not shipped):** Actor migration coda — greenfield design, not production rewrite.  
**BookMyShow Ads pipeline + HeroWidget lifecycle (optional preview):** POP ads pipeline if energy allows — no invented metrics.

**Interview line (≤20s):** “Week 1 theme: I’ve shipped race fixes on a large consumer app and can discuss both the GCD fix and a modern actor migration path.”

→ [BookMyShow synchronised dictionaries](../../stories/story-bank.md#s2--synchronised-dictionaries-bookmyshow) · [BookMyShow IMOC + crash-free at scale IMOC](../../stories/story-bank.md#s8--imoc--crash-free-at-scale-bookmyshow)

## 5. Flash prompts

1. Mock agenda in order — one breath
2. struct vs class (Day 01 warm-up)
3. POP + associated type trap (Day 02)
4. Leaks vs Memory Graph (Day 03)
5. main.sync deadlock — generalize (Day 04)
6. Actor reentrancy after await (Day 05)
7. Two pointers vs sliding window (Day 06)
8. BookMyShow synchronised dictionaries ≤3 min STAR — trade-off + Design: actor SafeDict (not shipped) coda
9. Social Feed HLD — clarify DAU, offline, pagination first
10. Score yourself: provenance honest?

## 6. Timed drills

| Drill | Budget |
|---|---|
| Warm-up defs (5×) | 10 min |
| Concurrency + memory deep pool | 25 min |
| BookMyShow synchronised dictionaries full STAR | 3 min |
| BookMyShow synchronised dictionaries ≤20s elevator | 20s |
| Social Feed HLD clarify + bullets | 20 min |
| Mock retro + weak-card list | 15 min |

Run full Mock #1 from [02-deep-dive](../../../weeks/week-01/day-07/02-deep-dive.md) and score with [MockScorecard.md](../../../weeks/week-01/day-07/code/MockScorecard.md). Expand warm-up/deep pools from [07-revision-qna](../../../weeks/week-01/day-07/sample/07-revision-qna.md).

**Pass criteria:** deep-dive average ≥3.5 · BookMyShow synchronised dictionaries ≥4 · no answer >2× budget without self-correction · at least one explicit concurrency trade-off.
