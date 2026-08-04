# 03 — Production Bridge: Firebase Performance (S5)

> Convert theory into interview stories without overclaiming.

## 1. Provenance map for today

| ID | Label | Exact claim you may make |
|---|---|---|
| **S5** | Verified | Firebase Performance traces for **listing / checkout / search**; tracked **p50/p90** |
| **S5-A1** | How I would apply it | Journey-level traces vs per-request interceptor spans |
| **S12** | Verified | Server-driven splash / cold-start product surface (no invented ms) |
| **S6** | Verified | LE Bottom Sheet — **30%+** flows fewer full-screen navigations |
| **S3** | Verified | Search debounce / cancel (laggy search checklist) |
| Learning-lab | Illustrative | `JourneyTrace.swift`, Instruments tool map |

### Forbidden overclaims

- Invented cold-start milliseconds or hitch SLA numbers as “what we hit”
- “Leaks instrument showed our retain cycle”
- “I built an in-house APM SDK at BMS” (S5 is Firebase Performance traces)
- Claiming MetricKit subscriber code as shipped personal work without evidence

## 2. Verified S5 — STAR (2–3 min)

### Timed opener (~10s)

> “I’ll walk through building journey-level observability with Firebase Performance at BookMyShow — listing, checkout, and search with p50/p90.”

### Situation / Task (~20s)

We needed data-driven latency visibility across business-critical journeys. Anecdotes from desk devices weren’t enough at consumer scale.

### Action (~90s)

1. Instrumented **Firebase Performance** traces around key journeys: **listing, checkout, search**.
2. Reported **p50 and p90**, not averages — so tails on weak devices and peak traffic stayed visible.
3. Used traces to prioritise optimisation work with PM and backend — conversations shifted from “feels slow” to percentile movement.
4. Treated traces as an **observability layer across releases** — watch regressions, not one-off screenshots.

### Result (~20–30s)

An observability layer for journey latency; release and optimisation discussions grounded in percentiles.

### Lesson (~15–20s)

p90 matters more than average for user-perceived pain under load. Lab Instruments attribute; field percentiles decide priority.

### Provenance tag

> **Provenance:** Verified · S5 · BookMyShow · Firebase Performance p50/p90 on listing/checkout/search

## 3. Interview line (≤20s)

> “I instrumented Firebase Performance traces for listing, checkout, and search — we tracked p50/p90 so release decisions followed real tails, not averages.”

## 4. Adjacent hooks (keep honest)

### Cold start product — S12

> “Splash is a product surface — server-driven content can improve freshness and cold-start experience; I talk TTI mindset, not a fake millisecond trophy.”

> **Provenance:** Verified · S12 · Aces server-driven splash

### UX performance — S6

> “Performance isn’t only CPU — reducing full-screen navigations for 30%+ flows with the LE Bottom Sheet cut stack cost for high-traffic journeys.”

> **Provenance:** Verified · S6 · LE Bottom Sheet 30%+ flows

### Search lag checklist — S3

Debounce, cancel in-flight, don’t apply stale results; pair with search journey traces.

> **Provenance:** Verified · S3 · search debounce/cancel

### Journey vs interceptor — S5-A1

When asked where to put spans:

> “I’d keep product SLIs as journey traces, and use finer interceptor spans for debugging chatter — carefully, with cardinality hygiene.”

> **Provenance:** How I would apply it · S5-A1

## 5. Instruments correctness (say in perf interviews)

If memory comes up during a performance discussion:

> “For abandoned view controllers / retain cycles I use Memory Graph and Allocations. Leaks is for unreachable memory — cycles usually won’t show there.”

Do **not** claim you ran that triage as Verified BMS personal workflow unless you add evidence later — it’s **technical correctness**, labeled Applied/Learning when personal process is implied.

## 6. Whiteboard — where you’d place 3 traces

```text
Listing:  viewDidAppear / onAppear → first content bind
Search:   debounced query fire → results render (ignore cancel)
Checkout: CTA tap → terminal success/fail (not every polling tick as separate journey)
```

## 7. Anti-patterns to refuse

| Temptation | Refuse with |
|---|---|
| “Average improved 12%” | Show p90 / hitch rate |
| “FPS is fine” | Field hitch + device class |
| “Optimize everything in Time Profiler” | Wait-bound ≠ CPU-bound |
| “One number performance score” | Small SLI set: cold start p90, journey p90, hitch, CFS |

## 8. Bridge to Days 18–20

- Day 18: hangs/OOM may not move CFS — don’t trust crash-free alone for “freezes”
- Day 19: security work must not silently add launch/main cost without measurement
- Day 20: release trains pause on perf/CFS gates — S5 culture feeds ops
