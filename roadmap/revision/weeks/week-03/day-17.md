# Day 17 — Performance: Instruments, MetricKit, Startup & Scrolling (p50/p90)

> Week 3 · Revision twin · Full study: [weeks/week-03/day-17/](../../../weeks/week-03/day-17/)  
> Time budget today: ~4–5 hrs (full) · revision pass ~45–60 min

## 1. Outcome

Explain aloud (no notes):

- Perf loop: symptom → hypothesis → lab/field tool → fix → **p50/p90**
- Lab (Instruments) vs field (MetricKit, Firebase Performance)
- Cold start: pre-main → init → first frame → TTI
- Scroll hitch ~16ms @ 60fps
- **CORRECT:** retain cycles ≠ **Leaks** → use **Memory Graph / Allocations**
- **Verified · S5:** Firebase Performance listing/checkout/search p50/p90

## 2. Concept deep dive (revision)

### Perf loop
Define SLI → field or lab → attribute → smallest fix → re-verify percentiles.

### Instruments (purpose)
Time Profiler · Signposts · **Allocations** · **Leaks (unreachable only)** · **Memory Graph (cycles)** · Hitches · Network · App Launch · Core Animation

### MetricKit
Daily-ish OS aggregates: hangs/hitches, CPU/memory, exit reasons. Pair with custom journey traces.

### Startup / scroll
Pre-main cost, defer SDKs, hitch ≠ hang.

### S5
Journey traces; p50/p90; no invented ms SLAs.

### Trade-offs
| Choice | When | Cost |
|---|---|---|
| Instruments | Repro lab | Not fleet-representative |
| MetricKit/Firebase | Field | Delayed / sampled |
| Optimize average | Never for UX SLOs | Hides p90 |

## 3. Map to work

**S5 ≤20s:** “I instrumented Firebase Performance for listing, checkout, and search — p50/p90 so decisions followed tails, not averages.”  
Soft: S12 splash · S6 30%+ flows · S3 search lag checklist.

## 4. Drill questions (skeleton only)

**N:** Q1 slow-app loop · Q2 why p90 · Q6 cold-start phases · Q5 MetricKit vs Firebase  
**T:** T2 network p90 + clean profiler · T5 p50↑ p90↓ after cache · T1 average FPS ship?

**Must-correct line:** “Cycles → Graph/Allocations, not Leaks.”

## 5. Flashcards

| Front | Back |
|---|---|
| Perf loop | Symptom→fix→p50/p90 · Trap: vibe · Prod: S5 |
| Cycles tool | Graph/Allocations · Trap: Leaks · Prod: correctness |
| Why p90 | Tail pain · Trap: averages · Prod: BMS journeys |
| Hitch | Missed frame · Trap: low CPU=smooth · Prod: decode on main |
| Lab vs field | Instruments vs MetricKit/Firebase · Trap: one device · Prod: 30L DAU |

## 6. Timed drill

Record Q1, Q2, Q6 + T2, T5. S5 STAR ≤3 min. Score timing guide. Log: averages, Leaks-for-cycles, profiler-for-waits.
