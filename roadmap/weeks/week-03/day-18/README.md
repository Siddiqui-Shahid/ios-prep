# Day 18 — Crash Reporting, Observability & Incident Response (IMOC)

> Week 3 · Full study (self-contained) · ~4–5 hrs  
> Revision twin: [revision/weeks/week-03/day-18.md](../../../revision/weeks/week-03/day-18.md)

## Outcomes

By end of day, without notes, you can:

- Explain crash SDK capture → **async-signal-safe** persist → next-launch upload → **dSYM** symbolication
- Distinguish **crash vs OOM vs hang**, and why CFS can look fine while users report freezes
- Deliver **Verified · S8**: **30L+ DAU**, **99.95%+ CFS**, Crashlytics triage, **IMOC** on P0/P1
- Use **Verified · S2** as a **path-scoped** concurrency fix that *contributed* to reliability — **never** “S2 alone caused 99.95% CFS”
- Run an incident script: owner, blast radius, mitigate first, communicate, postmortem

## How to study

1. [`01-foundations.md`](01-foundations.md)
2. [`02-deep-dive.md`](02-deep-dive.md)
3. [`03-production-bridge.md`](03-production-bridge.md) — S8 STAR + S2 honesty bound
4. [`code/`](code/) — breadcrumb ring + signal-safety notes
5. [`04-questions.md`](04-questions.md) — Answer points → Full spoken
6. [`05-exercises.md`](05-exercises.md)
7. Revision twin

## Module map

| Module | File |
|---|---|
| Foundations | [01-foundations.md](01-foundations.md) |
| Deep dive | [02-deep-dive.md](02-deep-dive.md) |
| Production bridge | [03-production-bridge.md](03-production-bridge.md) |
| Questions | [04-questions.md](04-questions.md) |
| Exercises | [05-exercises.md](05-exercises.md) |
| Code | [code/BreadcrumbRing.swift](code/BreadcrumbRing.swift), [code/CrashReportNotes.swift](code/CrashReportNotes.swift) |
| Sample Q&A | [sample/README.md](sample/README.md) |

## Critical correctness

| Claim | Truth |
|---|---|
| **S8** | Sustained **99.95%+ CFS** at **30L+ DAU** via Crashlytics workflows + **IMOC** — multi-factor ops excellence |
| **S2** | Synchronised dictionaries eliminated **path-scoped** race crashes — **contributes**, does **not** solely own CFS |
| Signal handler | **Async-signal-safe** only — no malloc / ObjC / locks |
| Upload timing | Persist on crash; upload **next launch** |
| Hang vs CFS | Freezes / hangs may **not** move crash-free |

## Provenance reminder

| Label | Use |
|---|---|
| **Verified · S8** | 30L+ DAU, 99.95%+ CFS, Crashlytics, IMOC |
| **Verified · S2** | GCD serial-queue / RW sync dictionaries — race crashes on that path |
| **How I would apply it · S2-A1** | Greenfield shared maps as Swift `actor` |
| Learning-lab | Code sketches |

## Agenda opener

> “I’ll cover capture → persist → upload → symbolicate, then OOM/hang gaps, then incident command using our 99.95% CFS / IMOC practice — with concurrency fixes as one contributor, not the whole CFS story.”

## Time budget

| Block | Minutes |
|---|---|
| Foundations + deep dive | 90–120 |
| Production bridge + code | 40–50 |
| Questions | 45–60 |
| Exercises + revision | 30–45 |
