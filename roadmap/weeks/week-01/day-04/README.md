# Day 04 — GCD Queues, sync/async, Barriers, Thread-Safe Dictionary

> Week 1 · Full study (self-contained) · ~4–5 hrs 
> Revision twin: [revision/weeks/week-01/day-04.md](../../../revision/weeks/week-01/day-04.md)

## Outcomes

By end of day, without notes, you can:

- Contrast serial vs concurrent queues; main vs global QoS
- Explain `sync` vs `async` and why sync-to-current-queue deadlocks (not only main)
- Implement a thread-safe dictionary behind a **private** serial queue API
- Explain reader-writer with barriers on a concurrent queue
- State the **async write / sync read visibility** rule correctly
- Deliver Verified · S2 (synchronised dictionaries) in ≤3 min with an actor-migration coda (S2-A1)
- Use `final class` (correct Swift keyword casing) in code and speech

## How to study (in Cursor only)

1. [`01-foundations.md`](01-foundations.md) — queue mental model (intern → mid)
2. [`02-deep-dive.md`](02-deep-dive.md) — deadlocks, barriers, SafeDict correctness
3. [`03-production-bridge.md`](03-production-bridge.md) — Verified · S2 / S2-A1
4. [`code/SafeDict.swift`](code/SafeDict.swift) — read, predict, then explain aloud
5. [`sample/README.md`](sample/README.md) — spoken Q&A + **brain puzzles** (01–06)
6. [`sample/07-revision-qna.md`](sample/07-revision-qna.md) — speak aloud; include **Tricky T1–T10**
7. [`05-exercises.md`](05-exercises.md) — race demo + speaking drills
8. Revision twin for flashcards / timed drill day-of

## Module map

| Module | File | Role |
|---|---|---|
| Foundations | [01-foundations.md](01-foundations.md) | Queues, sync/async, QoS |
| Deep dive | [02-deep-dive.md](02-deep-dive.md) | Deadlock, RW barriers, visibility |
| Production bridge | [03-production-bridge.md](03-production-bridge.md) | S2 STAR + actor coda |
| Questions | [sample/07-revision-qna.md](sample/07-revision-qna.md) | Normal + **Tricky T1–T10** |
| Exercises | [05-exercises.md](05-exercises.md) | Coding + speaking |
| Code | [code/SafeDict.swift](code/SafeDict.swift), [code/BarrierDict.swift](code/BarrierDict.swift) | Learning-lab |
| Sample Q&A | [sample/README.md](sample/README.md) | Guided teaching + brain puzzles + [06-module-drills](sample/06-module-drills.md) |

## Time budget (suggested)

| Block | Minutes |
|---|---|
| Foundations | 55–70 |
| Deep dive | 75–90 |
| Production bridge + code | 35–45 |
| Questions (speak 7–9 aloud + 2–3 Tricky) | 60–75 |
| Sample 01–06 + brain puzzles (optional pass) | 45–60 |
| Exercises + timed drill | 45–60 |

## Provenance reminder

| Label | Use for today |
|---|---|
| **Verified · S2** | Synchronised dictionaries via GCD serial queues / RW locks; race/crash reduction **on that path** |
| **How I would apply it · S2-A1** | Greenfield shared maps as Swift `actor` |
| **Verified · S8** | Soft: reliability culture / Crashlytics watch (do not claim S2 alone produced 99.95% CFS) |
| **Learning-lab** | `SafeDict` / barrier demos — not shipped BMS source |

Do **not** invent crash counts or claim sole ownership of app-wide crash-free rate.

## Critical correctness notes (pin)

1. **Async write then sync read may not see the write until the write runs.** Prefer **sync write** when the caller needs read-after-write on the same API, or document ordering clearly. 
2. Spell it **`final class`**, never `Final class`. 
3. **Hide the queue** — expose safe methods only (S2 lesson).

## Agenda openers (pin these)

| Topic | 5–10s opener |
|---|---|
| Serial vs concurrent | “One-at-a-time versus overlapping execution.” |
| sync vs async | “Wait for completion versus schedule and return.” |
| Safe dict | “Private serial queue — sync get, careful set.” |
| Barrier | “Exclusive writer on a concurrent queue.” |
| S2 | “Races on shared dictionaries — serial-queue API and trade-offs.” |
