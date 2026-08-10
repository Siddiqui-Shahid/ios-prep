# Day 03 — ARC, Retain Cycles, weak/unowned, Instruments

> Week 1 · Full study (self-contained) · ~4–5 hrs 
> Revision twin: [revision/weeks/week-01/day-03.md](../../../revision/weeks/week-01/day-03.md)

## Outcomes

By end of day, without notes, you can:

- Explain how ARC inserts retains/releases, when `deinit` runs, and what strong / weak / unowned mean
- Name classic retain-cycle patterns (escaping closures, strong delegates, Timer target-selector, NotificationCenter block observers, parent↔child, Combine store, Task) and the fix for each
- Call out nested-closure re-strong after `guard let self`, singleton forever-cache abandonment, and `unowned` use-after-free
- Distinguish **true leaks** (unreachable — including some CFRelease misses) from **abandoned memory / retain cycles** (reachable but unused) — and which tool finds which
- Walk an interview triage: Memory Graph → Allocations → Leaks, without claiming the wrong instrument; know autoreleasepool ≠ cycle fix
- Tie reliability culture to BookMyShow IMOC + crash-free at scale (Verified) without inventing “I used Memory Graph at BMS” unless labeled Applied; keep ARC as supporting color on STAR

## How to study (in Cursor only)

1. `01-foundations.md` — mental model + glossary (intern-first)
2. `02-deep-dive.md` — full mechanics, tables, failure modes
3. `03-production-bridge.md` — reliability culture + Applied triage playbook
4. `code/RetainCycleDemo.swift` — read the cycle, then the fixes
5. `sample/` — spoken Q&A + brain puzzles (`01`–`06`; `06` folds exercise/flash-recall leftovers)
6. `sample/07-revision-qna.md` — normal Qs + tricky **T1–T10** brain puzzles; timed cites **T1, T5, T8**
7. `05-exercises.md` — drills with in-repo solutions (still do the hands-on work here)
8. Revision twin for timed drill under pressure

## Module map

| Module | File |
|---|---|
| Foundations | [01-foundations.md](01-foundations.md) |
| Deep dive | [02-deep-dive.md](02-deep-dive.md) |
| Production bridge | [03-production-bridge.md](03-production-bridge.md) |
| Questions | [sample/07-revision-qna.md](sample/07-revision-qna.md) |
| Exercises | [05-exercises.md](05-exercises.md) |
| Code | [code/RetainCycleDemo.swift](code/RetainCycleDemo.swift) |
| Sample Q&A (guided) | [sample/](sample/README.md) — includes **06-module-drills** leftovers from these modules |

## Critical correctness (memorize)

| Claim | Truth |
|---|---|
| Retain cycle | Objects keep each other alive → **reachable** abandoned memory |
| Instruments **Leaks** | Finds **unreachable** allocated memory (no live pointers) |
| Cycles in Leaks? | **No** — cycles stay reachable; use **Memory Graph** / **Allocations** |
| Timer `scheduledTimer(timeInterval:target:selector:…)` | Timer **strongly retains** the target until `invalidate` |
| NotificationCenter block API | Returns an **observer token**; store it and remove on teardown |
| Autoreleasepool | Peak/temporary drain — **does not** break retain cycles |

## Provenance reminder

Only use Verified IDs from [`../../../provenance/README.md`](../../../provenance/README.md).

- **Verified · S8** — reliability culture, Crashlytics, IMOC, 99.95%+ CFS at 30L+ DAU
- **How I would apply it** — Memory Graph / Allocations triage playbook at BMS-scale apps (not claimed as shipped personal workflow unless you add real evidence later)
- **Learning-lab** — `RetainCycleDemo.swift` and playground drills

In sample **relate** sections use **named work only** — never S-codes.

## Time budget (suggested)

| Block | Minutes |
|---|---|
| Foundations + deep dive | 90–120 |
| Production bridge + code | 45 |
| Sample `01`–`06` aloud | 60–75 |
| Questions (half bank + T1/T5/T8) | 45–60 |
| Exercises | 45–60 |
| Timed drill (revision twin) | 30 |

## Timed drill (after full study)

1. Speak Q1, Q2, Q5, Q11, **T1, T5, T8** from `sample/07-revision-qna.md` on a timer.
2. 60s: Verified reliability culture + Applied Graph triage (honesty labels).
3. Score against [answer-timing-guide.md](../../../timing/answer-timing-guide.md); log misses.
