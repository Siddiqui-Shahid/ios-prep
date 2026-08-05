# Day 03 — ARC, Retain Cycles, weak/unowned, Instruments

> Week 1 · Full study (self-contained) · ~4–5 hrs  
> Revision twin: [revision/weeks/week-01/day-03.md](../../../revision/weeks/week-01/day-03.md)

## Outcomes

By end of day, without notes, you can:

- Explain how ARC inserts retains/releases, when `deinit` runs, and what strong / weak / unowned mean
- Name classic retain-cycle patterns (escaping closures, strong delegates, Timer target-selector, NotificationCenter block observers, parent↔child) and the fix for each
- Distinguish **true leaks** (unreachable) from **abandoned memory / retain cycles** (reachable but unused) — and which tool finds which
- Walk an interview triage: Memory Graph → Allocations → Leaks, without claiming the wrong instrument
- Tie reliability culture to Verified **S8** (30L+ DAU, 99.95%+ CFS, Crashlytics, IMOC) without inventing “I used Memory Graph at BMS” unless labeled Applied

## How to study (in Cursor only)

1. `01-foundations.md` — mental model + glossary (intern-first)
2. `02-deep-dive.md` — full mechanics, tables, failure modes
3. `03-production-bridge.md` — S8 reliability culture + Applied triage playbook
4. `code/RetainCycleDemo.swift` — read the cycle, then the fixes
5. `04-questions.md` — cover full answers; speak from **Answer points**; compare
6. `05-exercises.md` — drills with in-repo solutions
7. Revision twin for timed drill under pressure

## Module map

| Module | File |
|---|---|
| Foundations | [01-foundations.md](01-foundations.md) |
| Deep dive | [02-deep-dive.md](02-deep-dive.md) |
| Production bridge | [03-production-bridge.md](03-production-bridge.md) |
| Questions | [04-questions.md](04-questions.md) |
| Exercises | [05-exercises.md](05-exercises.md) |
| Code | [code/RetainCycleDemo.swift](code/RetainCycleDemo.swift) |
| Sample Q&A (guided) | [sample/](sample/README.md) — concept teaching; does not replace modules above |

## Critical correctness (memorize)

| Claim | Truth |
|---|---|
| Retain cycle | Objects keep each other alive → **reachable** abandoned memory |
| Instruments **Leaks** | Finds **unreachable** allocated memory (no live pointers) |
| Cycles in Leaks? | **No** — cycles stay reachable; use **Memory Graph** / **Allocations** |
| Timer `scheduledTimer(timeInterval:target:selector:…)` | Timer **strongly retains** the target until `invalidate` |
| NotificationCenter block API | Returns an **observer token**; store it and remove on teardown |

## Provenance reminder

Only use Verified IDs from [`../../../provenance/README.md`](../../../provenance/README.md).

- **Verified · S8** — reliability culture, Crashlytics, IMOC, 99.95%+ CFS at 30L+ DAU
- **How I would apply it** — Memory Graph / Allocations triage playbook at BMS-scale apps (not claimed as shipped personal workflow unless you add real evidence later)
- **Learning-lab** — `RetainCycleDemo.swift` and playground drills

## Time budget (suggested)

| Block | Minutes |
|---|---|
| Foundations + deep dive | 90–120 |
| Production bridge + code | 45 |
| Questions (half bank aloud) | 60–75 |
| Exercises | 45–60 |
| Timed drill (revision twin) | 30 |
