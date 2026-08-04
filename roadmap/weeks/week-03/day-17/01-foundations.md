# 01 — Foundations: Performance Investigation

> Read this first. Goal: a crisp mental model you can teach an intern, then the senior edges for interviews.

---

## 0. One-sentence north star

**Define a user journey SLI, measure with percentiles in the field, attribute with the right lab tool, fix the smallest high-leverage cause, then re-verify p50/p90.**

Everything below unpacks that sentence.

---

## 1. The performance loop (senior habit)

```text
1. Define user journey + SLI   (e.g. checkout success latency)
2. Pull field percentiles OR reproduce in lab
3. Attribute: CPU / wait / network / layout / decode / lock / memory
4. Fix smallest high-leverage cause
5. Re-measure p50/p90 + watch next release for regression
```

**Say aloud:** “I never optimize from a single desk iPhone anecdote at 30L+ DAU scale — field distributions lie differently than my device.”

### 1.1 Lab vs field

| Mode | Tools | Strength | Weakness |
|---|---|---|---|
| **Lab** | Instruments, local repro | Precise attribution, signposts | Not representative of all devices/networks |
| **Field** | MetricKit, Firebase Performance, Crashlytics hang proxies | Fleet truth, percentiles | Coarser / delayed / sampled |

**Staff signal:** Start where the signal lives. Rare field-only regressions → field first to locate the segment, then lab to attribute.

---

## 2. Why p50 / p90 (not averages)

| Metric | What it answers |
|---|---|
| **Average** | Central tendency — hides tails |
| **p50** | “Typical” user |
| **p90** | Worst 10% — weak devices, peak traffic, slow networks |
| **p99** | Extreme tail — useful for rare Sev paths; noisy on mobile |

**Interview line:**  
> “At BookMyShow we instrumented Firebase Performance for listing, checkout, and search and tracked **p50/p90** so prioritisation followed real tails, not averages.”

> **Provenance:** Verified · S5 · BookMyShow · Firebase Performance p50/p90

**Trap:** Shipping because “average FPS improved.” Average vanity; check hitch rate and field percentiles.

---

## 3. Glossary (intern → mid)

| Term | Meaning |
|---|---|
| **SLI** | Service level indicator — measurable user journey signal |
| **Cold start** | Process not in memory; includes dyld / pre-main |
| **Warm start** | Process alive; UI may still rebuild |
| **TTFF** | Time to first frame |
| **TTI** | Time to interactive (data-ready useful UI) |
| **Hitch** | Frame missed vsync / display deadline |
| **Hang** | Main thread blocked long enough to feel frozen (tool-defined threshold, often ~250ms+ in APM designs) |
| **Watchdog kill** | OS kills unresponsive app — related but not identical to hang metrics |
| **Signpost** | Custom interval marker (`os_signpost`) for Points of Interest |
| **Journey trace** | Product span (screen appear → success) you define in APM |
| **Abandoned memory** | Still referenced but unused (retain cycles) |
| **True leak** | Allocated with **no** live references |

---

## 4. Instruments — name with purpose (first pass)

| Tool | Use when | You’ll find |
|---|---|---|
| **Time Profiler** | CPU hot paths | Heavy JSON, regex, main-thread work |
| **os_signpost / Points of Interest** | Custom intervals | Journey spans you define |
| **Allocations** | Growth over time | Persistent objects, image spikes |
| **Leaks** | Unreachable allocations | True leaks (no pointers) |
| **Memory Graph** | Ownership edges | Retain cycles, abandoned VCs |
| **Animations / Hitches** | Scroll jank | Main-thread >~16ms frames |
| **Network** | Payload / latency | Chatty APIs, large JSON |
| **App Launch** | Cold start | Pre-main vs post-main cost |
| **Core Animation** | Overdraw / blending | Offscreen rendering, shadows |

### Critical correctness — retain cycles vs Leaks

```text
Retain cycle / abandoned VC
  → objects still REACHABLE (they point at each other)
  → Leaks instrument usually CLEAN
  → Use Memory Graph (edges) + Allocations (persistent growth)
```

| Claim | Truth |
|---|---|
| “Leaks finds retain cycles” | **False** |
| Correct tools for cycles | **Memory Graph**, **Allocations** |
| What Leaks finds | Unreachable allocated memory |

**Say aloud once:** “Retain cycles are abandoned but reachable — that’s Graph and Allocations, not Leaks.”

(Day 03 deepens ARC; today you only need the Instruments correctness trap when discussing performance tooling.)

---

## 5. MetricKit (field OS aggregates)

Subscribe via `MXMetricManager` / `MXMetricManagerSubscriber`:

- Hang diagnostics / hitch metrics
- CPU / memory histograms
- Disk write exceptions
- Exit reasons (pairs with Day 18 crash/OOM narratives)

**Cadence:** Aggregated payloads — think **daily**, not realtime dashboards. Privacy-preserving OS metrics.

**Staff signal:** MetricKit ≠ product journey SLIs. Combine with **custom traces** (Firebase Performance) for listing/checkout/search.

---

## 6. Startup anatomy (names you must say)

```text
Pre-main (dyld, static init, +load-class work)
  → main / App / Scene setup
  → First frame (TTFF)
  → Time-to-interactive (data-ready UI)
```

Optimizations interviewers expect:

- Fewer dynamic frameworks on launch path (modularization — Week 3 Day 15)
- Defer non-critical SDK init
- Avoid sync disk/network on main during launch
- Cache splash/config when product allows (Aces server-driven splash — S12 soft bridge)

**Do not invent** a fake “we hit 847ms cold start” number. Speak categories and measurement method.

---

## 7. Scrolling & hitches (first pass)

- **Budget:** ~16.7ms per frame @ 60Hz; ~8.3ms @ 120Hz
- **Hitch:** work missed the deadline → jank
- Common causes: main-thread image decode, Auto Layout thrash, sync file I/O, lock contention, huge cell `configure`
- Fixes preview: downsample/prefetch (Day 16), reuse hygiene, flatten hierarchies, parse off main, debounce search (S3)

---

## 8. Firebase Performance at BMS (production proof — preview)

Instrumented **p50/p90** traces across **listing, checkout, search** — an observability layer for data-driven optimisation.

Interview structure:

1. Why percentiles (tail = pain)
2. Which journeys (business-critical)
3. How traces informed PM/backend prioritisation
4. Link to release regression watch (Day 20 CI gates)

Full STAR in [`03-production-bridge.md`](03-production-bridge.md).

---

## 9. Mini decision tree — which tool first?

```text
“App feels slow”
  ├─ Can you reproduce on desk? → Instruments (Time Profiler / Hitches / Launch)
  ├─ Only some users / devices? → Field first (Firebase p90 segment, MetricKit)
  ├─ Memory climbs on navigate? → Allocations + Memory Graph (not Leaks-first for cycles)
  ├─ Scroll jank? → Hitches / Time Profiler on main
  └─ Checkout/search latency? → Journey traces (S5) + Network instrument if lab
```

---

## 10. Teach-back checklist

Before deep dive, say without notes:

1. Perf loop in five steps
2. Why p90 over average
3. Lab vs field
4. Cold-start four phases
5. Hitch vs hang (one sentence each)
6. **Retain cycles → Graph/Allocations, not Leaks**
7. S5 one-liner with p50/p90

---

## 11. What’s next

[`02-deep-dive.md`](02-deep-dive.md) expands Instruments failure modes, MetricKit subscriber shape, hang detector concept, APM upload NFRs, and scroll attribution playbooks.
