# 05 — Exercises

> Do these after foundations + deep dive + production bridge. Speak out loud even for whiteboard prompts.

---

## Exercise 1 — Perf loop teach-back `(10 min)`

**Prompt:** Without notes, recite:

1. Five-step performance loop
2. Lab vs field (one sentence each)
3. Why p90 over average
4. Retain cycles → which Instruments? (explicitly **not** Leaks)

**Done when:** You correct yourself if you say “Leaks for cycles.”

---

## Exercise 2 — Instruments routing `(15 min)`

For each symptom, name the **first** tool and why:

| Symptom | Your tool | Why |
|---|---|---|
| Scroll jank on listing | | |
| Cold start +200ms after SDK | | |
| Memory climbs every push/pop | | |
| Checkout slow; CPU idle | | |
| Only iPhone 11 users complain | | |

**Answers (check after):** Hitches/Time Profiler · App Launch · Allocations+Memory Graph · Network/Firebase journey · Field MetricKit/Firebase first.

---

## Exercise 3 — Place three traces `(15–20 min)`

Using [`code/JourneyTrace.swift`](code/JourneyTrace.swift) as a sketch:

1. Define start/stop events for listing, search, checkout
2. Speak cardinality hygiene (templates, no PII)
3. Mark one span as **S5-A1** journey-level vs a noisy per-request alternative

**Speak (≤90s):** Verified S5 → what you shipped → how you’d place spans.

---

## Exercise 4 — APM whiteboard `(15 min)`

Outline boxes only:

```text
ColdStartTracker | HangDetector | CustomTraces | MetricKitSubscriber | SQLite batch upload
```

Say aloud: overhead budget, batch upload, kill-switch, why not upload in a signal handler (preview Day 18).

---

## Exercise 5 — S5 STAR record `(10–12 min)`

Record the full STAR from [`03-production-bridge.md`](03-production-bridge.md).  
Score: opener / actions with p50/p90 / lesson / no invented metrics.

---

## Exercise 6 — Correct the interviewer `(5 min)`

Interviewer: “If Leaks is clean, you don’t have retain cycles.”

**Your correction (≤45s):** reachable abandoned memory → Graph/Allocations; Leaks = unreachable.

---

## Timed drill

1. Pick 3 Normal + 2 Tricky from `04-questions.md` (recommend Q1, Q2, Q6 + T2, T5).
2. Score against [`answer-timing-guide.md`](../../../timing/answer-timing-guide.md).
3. Log misses: average worship, Instruments-for-network-waits, Leaks-for-cycles.
4. Skim revision twin flashcards.

---

## Flashcards (also on revision twin)

| Front | Back |
|---|---|
| Perf loop | Symptom → attribute → fix → p50/p90 · Trap: vibe opt · Prod: S5 |
| Why p90 | Tail = pain · Trap: averages · Prod: BMS journeys |
| Cycles tool | Graph/Allocations · Trap: Leaks · Prod: correctness |
| MetricKit | OS aggregates · Trap: replaces traces · Prod: fleet |
| Firebase Perf | Custom journeys · Trap: only FPS · Prod: S5 |
| Hitch | Missed frame · Trap: low CPU=smooth · Prod: decode on main |
| Cold start | Pre-main→init→frame→TTI · Trap: only TTFF · Prod: S12 |
| Lab vs field | Instruments vs MetricKit/Firebase · Trap: one device=fleet · Prod: 30L DAU |
