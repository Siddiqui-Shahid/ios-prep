# Day 18 — Crash Reporting, Observability & IMOC

> Week 3 · Revision twin · Full study: [weeks/week-03/day-18/](../../../weeks/week-03/day-18/)

## 1. Outcome

- Crash pipeline: handlers → **async-signal-safe** persist → next-launch upload → **dSYM**
- Crash vs OOM vs hang (CFS can look fine while users freeze)
- **Verified · S8:** 30L+ DAU, **99.95%+ CFS**, Crashlytics, **IMOC**
- **HARD:** **Do NOT claim S2 alone caused CFS** — S2 is path-scoped race fix; S8 is the reliability system
- IMOC: owner, blast radius, mitigate first, comms, postmortem

## 2. Concept deep dive (revision)

```text
Init → handlers + breadcrumb ring
Crash → signal-safe mmap write → terminate
Next launch → upload → symbolicate (dSYM UUID)
```

**Forbidden in handler:** malloc, ObjC, locks, OSLog, network.

**Triage:** detect → classify → reproduce → mitigate → fix → blameless write-up.

**S2 OK line:** “Removed race crashes on that shared-state path; contributed to reliability.”  
**S2 forbidden:** “Dictionaries are why we have 99.95% CFS.”

## 3. Map to work

**S8 ≤20s:** “At 30L+ DAU we held 99.95%+ crash-free — Crashlytics triage plus IMOC on P0/P1s, not solo hero debugging.”  
**S2 add-on ≤90s:** path-scoped + explicit non-sole-cause.

## 4. Drill

**N:** Q5 sale CFS drop · Q6 talk 99.95% · Q9 sync dicts (honesty) · Q2 signal-safe  
**T:** T3 CFS fine but freezes · T4 iOS vs backend blame · T1 try/catch myth

## 5. Flashcards

| Front | Back |
|---|---|
| CFS | 99.95%+ · Trap: vanity · Prod: S8 |
| S2 vs CFS | Path contributor · Trap: sole cause · Prod: S2+S8 |
| Signal safety | No alloc/lock · Trap: OSLog in handler · Prod: mmap |
| Hang gap | CFS≠no freezes · Trap: trust CFS only · Prod: MetricKit |
| IMOC | Owner+blast+mitigate · Trap: hero debug · Prod: S8 |

## 6. Timed drill

Q5, Q6, Q9 + T3, T4. Log S2-sole-cause slips.
