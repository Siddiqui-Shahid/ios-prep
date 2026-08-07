# Audio script — Sample 01 — Performance loop and tools (Q&A)
> Listen-only sample Q&A from `01-perf-loop-tools.md`. Spoken answers and follow-ups.

## §0 Q1. What is the one-sentence north star for performance work?

Next. Q1. What is the one-sentence north star for performance work? Answer. Define a user journey SLI, measure with percentiles in the field, attribute with the right lab tool, fix the smallest high-leverage cause, then re-verify p50/p90. Never optimize from a single desk iPhone anecdote at consumer scale — field distributions lie differently than your device. Follow-ups. What is an SLI?: Service level indicator — measurable user journey signal (checkout success latency, listing time-to-content).. “Smallest high-leverage cause”?: Fix the bottleneck class first — not micro-JSON tweaks when p90 is network wait.. Re-verify how?: Same trace definitions — watch next release for regression (Day 20 gates)..

## §1 Q2. What are the five steps of the performance loop?

Next. Q2. What are the five steps of the performance loop? Answer. (1) Define user journey + SLI. (2) Pull field percentiles OR reproduce in lab. (3) Attribute: CPU / wait / network / layout / decode / lock / memory. (4) Fix smallest high-leverage cause. (5) Re-measure p50/p90 and watch the next release. Say aloud: field percentiles decide priority; lab Instruments attribute. Follow-ups. Skip step 1 symptom?: Optimizing random stacks with no user journey tie-in.. Skip step 5 symptom?: “We shipped the JSON fix” — p90 unchanged.. Staff signal?: Start where the signal lives — field-only bug → field first, then lab..

## §2 Q3. Lab vs field — when do you use which?

Next. Q3. Lab vs field — when do you use which? Answer. Lab (Instruments, local repro): precise attribution, signposts — not representative of all devices/networks. Field (MetricKit, Firebase Performance, hang proxies): fleet truth, percentiles — coarser, delayed, sampled. Rare field-only regressions → field first to locate segment, then lab to attribute root cause. Follow-ups. Desk reproduces, users complain?: Segment field p90 by device class / OS / network — your phone isn’t the fleet.. Lab clean, field p90 bad?: Wait-bound or device-class specific — Network instrument or MetricKit segment.. Both together?: Yes — MetricKit + custom journey traces (BookMyShow Firebase Performance traces)..

## §3 Q4. Why p50 and p90 instead of averages?

Next. Q4. Why p50 and p90 instead of averages? Answer. Average hides tails. p50 is the typical user. p90 is the worst 10% — weak devices, peak traffic, slow networks where pain concentrates. p99 helps extreme Sev paths but is noisy on mobile. Interview trap: shipping because “average FPS improved” — check hitch rate and field percentiles instead. Follow-ups. BookMyShow Firebase Performance traces Verified line?: Firebase Performance on listing/checkout/search with p50/p90 — not averages.. PM conversation shift?: From “feels slow” to “checkout p90 moved.”. When mention p99?: Payment or rare Sev paths — acknowledge noise on mobile..

## §4 Q5. Which Instruments tools for which problems (first pass)?

Next. Q5. Which Instruments tools for which problems (first pass)? Answer. Time Profiler — CPU hot paths. Signposts / Points of Interest — custom journey intervals. Allocations — growth over time, image spikes. Leaks — unreachable memory only. Memory Graph — ownership edges, cycles, abandoned VCs. Hitches — scroll jank. Network — payload/latency. App Launch — pre-main vs post-main. Core Animation — overdraw, offscreen rendering. Follow-ups. Memory climbs on navigate?: Allocations + Memory Graph — not Leaks-first for cycles.. Scroll jank?: Hitches + Time Profiler on main.. Checkout slow, CPU clean?: Network / backend wait — not micro-optimise JSON first..

## §5 Q6. Why don’t retain cycles show in Leaks?

Next. Q6. Why don’t retain cycles show in Leaks? Answer. Retain cycles keep objects reachable — they point at each other — so Leaks often stays clean. Those objects are abandoned (U I gone) but not unreachable. Use Memory Graph for edges and Allocations for persistent growth across navigation generations. Say aloud: “Cycles are Graph and Allocations, not Leaks.” Follow-ups. What Leaks finds?: True leaks — allocated memory with no live references.. Wrong interview answer?: “We opened Leaks and saw the cycle.”. Day 03 link?: A R C deep dive there; today only Instruments correctness trap..

## §6 Q7. What is MetricKit’s role at a high level?

Next. Q7. What is MetricKit’s role at a high level? Answer. Subscribe via MXMetricManager for OS aggregates: hang/hitch diagnostics, CPU/memory histograms, disk write exceptions, exit reasons (pairs with Day 18). Daily-ish cadence — not realtime. Privacy-preserving fleet metrics. Weak alone for product journey SLIs — combine with custom traces (Firebase Performance). Follow-ups. MetricKit vs Firebase?: OS aggregates vs your defined journey spans — use together.. Exit reasons bridge?: OOM/jetsam narratives with Day 18 — not clean client stacks.. Don’t claim as Verified?: MetricKit subscriber code as personal shipped work without evidence..

## §7 Q8. Which tool first — mini decision tree?

Next. Q8. Which tool first — mini decision tree? Answer. “App feels slow” → desk repro? Instruments (Time Profiler / Hitches / Launch). Only some users/devices? Field first (Firebase p90 segment, MetricKit). Memory climbs on navigate? Allocations + Memory Graph. Scroll jank? Hitches on main. Checkout/search latency? Journey traces (BookMyShow Firebase Performance traces) + Network if lab. Follow-ups. Teach-back item 6?: Retain cycles → Graph/Allocations, not Leaks.. Teach-back BookMyShow Firebase Performance traces one-liner?: p50/p90 on listing/checkout/search at BMS.. Next sample?: 02-instruments-metrickit.md — deep attribution..
