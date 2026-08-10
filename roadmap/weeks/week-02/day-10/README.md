# Day 10 — SDUI / CMS · Schema Versioning · Fallbacks

> Week 2 · Full study (self-contained) · ~4–5 hrs 
> Revision twin: [revision/weeks/week-02/day-10.md](../../../revision/weeks/week-02/day-10.md)

## Outcomes

By end of day, without notes, you can:

- Explain **server-driven UI**: schema → version gate → registry → native render + allowlisted actions — **not** “eval JSON as code”
- Defend **schema versioning**, **unknown-component skip**, and **fallback/cache** as crash-free insurance
- Deliver **S3** BMS backend-driven header honestly; treat **S3-A1** versioning/unknown fallback as **design**
- Deliver **S12** Aces server-driven splash (cold-start flexibility / freshness — no invented ms)
- Contrast SDUI vs **native Ads** media lifecycle (S1) without overclaiming

## How to study (in Cursor only)

1. `01-foundations.md` — mental model + glossary
2. `02-deep-dive.md` — schema, registry, actions, cache, cold start, parity
3. `03-production-bridge.md` — Verified S3 + S12; Applied S3-A1
4. `code/` — `SchemaVersionGate.swift`, `ComponentRegistry.swift`, `FallbackEngine.swift`
5. `sample/07-revision-qna.md` — cover full answers; speak from **Answer points**
6. `05-exercises.md` — drills
7. Revision twin for timed recall

## Module map

| Module | File |
|---|---|
| Foundations | [01-foundations.md](01-foundations.md) |
| Deep dive | [02-deep-dive.md](02-deep-dive.md) |
| Production bridge | [03-production-bridge.md](03-production-bridge.md) |
| Sample Q&A | [sample/README.md](sample/README.md) |
| Questions | [sample/07-revision-qna.md](sample/07-revision-qna.md) |
| Exercises | [05-exercises.md](05-exercises.md) |
| Code | [code/SchemaVersionGate.swift](code/SchemaVersionGate.swift), [code/ComponentRegistry.swift](code/ComponentRegistry.swift), [code/FallbackEngine.swift](code/FallbackEngine.swift) |

## Provenance reminder

| Label | Meaning for today |
|---|---|
| **Verified · S3** | Backend-driven / CMS header; protocol-driven main-screen; API contracts for layout/content without release when possible; search is Day 08’s MVVM beat |
| **How I would apply it · S3-A1** | Schema versioning + unknown-component fallback — **design judgment**, not “I shipped the versioning ops runbook as a named system” |
| **Verified · S12** | Aces server-driven splash (+ audio streaming context); cold-start flexibility/freshness — **no invented latency ms** |
| **Learning-lab** | Gate/registry/fallback snippets in this chapter |

Do **not** claim JS eval SDUI, invented cold-start milliseconds, or that S3-A1 was a shipped named framework.

## Agenda opener

> “I’ll define SDUI as schema plus native registry with version gates and fail-soft unknowns, then map to the BMS header and Aces splash — and call out schema versioning as design I’d insist on.”

## Time budget

| Block | Minutes |
|---|---|
| Foundations | 45–60 |
| Deep dive + code | 90–120 |
| Production bridge + STAR | 30–40 |
| Questions (record 5) | 45–60 |
| Exercises | 30–40 |
| Revision twin skim | 15 |

## Source / version note

SDUI here means **typed JSON → native components**. WebViews may appear as an island, not the architecture. Optional citations only at end of `02-deep-dive.md`.
