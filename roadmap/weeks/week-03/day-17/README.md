# Day 17 — Performance: Instruments, MetricKit, Startup & Scrolling (p50/p90)

> Week 3 · Full study (self-contained) · ~4–5 hrs 
> Revision twin: [revision/weeks/week-03/day-17.md](../../../revision/weeks/week-03/day-17.md)

## Outcomes

By end of day, without notes, you can:

- Run the senior performance loop: **symptom → hypothesis → lab/field tool → fix → verify p50/p90**
- Separate **lab** (Instruments) from **field** (MetricKit, Firebase Performance) truth
- Explain cold-start phases (pre-main → init → first frame → TTI) and scroll hitch budgets (~16ms @ 60fps)
- Name Instruments with purpose — and correctly say **retain cycles ≠ Leaks** (use **Memory Graph / Allocations**)
- Deliver **Verified · S5**: Firebase Performance journey traces (listing / checkout / search) with **p50/p90** at BMS scale

## How to study (in Cursor only)

1. [`01-foundations.md`](01-foundations.md) — mental model + glossary
2. [`02-deep-dive.md`](02-deep-dive.md) — Instruments matrix, MetricKit, startup, hitches, APM shape
3. [`03-production-bridge.md`](03-production-bridge.md) — Verified S5 + adjacent hooks
4. [`code/`](code/) — journey trace sketch + Instruments tool cheat
5. [`sample/07-revision-qna.md`](sample/07-revision-qna.md) — speak from **Answer points**; compare to **Full spoken**
6. [`05-exercises.md`](05-exercises.md) — drills + timed practice
7. Revision twin for flashcards / day-of recall

## Module map

| Module | File | Role |
|---|---|---|
| Foundations | [01-foundations.md](01-foundations.md) | Perf loop, percentiles, lab vs field |
| Deep dive | [02-deep-dive.md](02-deep-dive.md) | Instruments (correct tools), MetricKit, startup, scroll |
| Production bridge | [03-production-bridge.md](03-production-bridge.md) | S5 STAR + honesty bounds |
| Questions | [sample/07-revision-qna.md](sample/07-revision-qna.md) | Two-layer Q&A (12N + 8T) |
| Exercises | [05-exercises.md](05-exercises.md) | Whiteboard + speaking drills |
| Code | [code/JourneyTrace.swift](code/JourneyTrace.swift), [code/InstrumentsToolMap.swift](code/InstrumentsToolMap.swift) | Teaching sketches |
| Sample Q&A | [sample/README.md](sample/README.md) |

## Critical correctness (memorize)

| Claim | Truth |
|---|---|
| Retain cycle / abandoned VC | Still **reachable** → **Memory Graph** / **Allocations** growth |
| Instruments **Leaks** | Finds **unreachable** memory (no live pointers) |
| Cycles in Leaks? | **No** — common interview trap |
| Why p90 | Tail latency = real pain at scale; averages hide it |
| Verified S5 | Firebase Performance traces; **p50/p90** on listing/checkout/search |

## Provenance reminder

| Label | Use for today |
|---|---|
| **Verified · S5** | Firebase Performance; journey p50/p90 |
| **How I would apply it · S5-A1** | Journey-level traces vs per-request interceptor spans |
| **Verified · S12** | Soft bridge: server-driven splash / cold-start product surface |
| **Verified · S6** | Soft bridge: fewer navigations as UX performance (30%+ flows) |
| **Verified · S3** | Soft bridge: search debounce/cancel when “search feels laggy” |
| **Learning-lab** | Code sketches in this chapter |

Do **not** invent cold-start ms SLAs, fill-rate %, or “Leaks found our retain cycle.”

## Agenda opener (pin this)

> “I’ll separate lab vs field, define journey SLIs with p50/p90, attribute with the right Instruments tool — Graph/Allocations for cycles, not Leaks — then close on BMS Firebase Performance.”

## Time budget

| Block | Minutes |
|---|---|
| Foundations | 45–60 |
| Deep dive + code | 90–120 |
| Production bridge + S5 STAR | 30–40 |
| Questions (record 5+) | 45–60 |
| Exercises + revision twin | 30–45 |
