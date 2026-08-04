# 02 — Deep Dive: Instruments, MetricKit, Startup, Scrolling

> Mechanics, traps, trade-offs. Self-contained — you do not need the APM doc open, but it mirrors that design vocabulary.

---

## 1. Attribution before optimisation

Senior failure mode: micro-optimising JSON encoders when p90 is **network wait**.

| Symptom class | Often looks like | First attribution |
|---|---|---|
| High CPU on main | Scroll jank, launch stutter | Time Profiler |
| Waiting / idle CPU | “Slow” but clean profiler | Network / backend / lock wait |
| Memory climb across pushes | Eventually jetsam | Allocations + Memory Graph |
| Field-only p90 spike | Desk is fine | Firebase / MetricKit segment |
| Launch regression | New SDK | App Launch template (pre vs post main) |

**Rule:** Name the **bottleneck class** before proposing a fix.

---

## 2. Instruments matrix (interview-ready)

### 2.1 Time Profiler

- Sampling profiler — heavy **self-time** and **heaviest stacks**
- Look for unexpected main-thread work: JSON decode, regex, image work, sorting
- After fix: confirm the stack shrinks (don’t trust vibes)

**Trap:** Using Time Profiler to “find” network latency. Waiting ≠ computing.

### 2.2 Points of Interest / `os_signpost`

- Custom intervals around journeys you care about
- Bridge lab to product language (“checkout_tap → confirmation”)
- Discipline: too many signposts = noise

### 2.3 Animations / Hitches

- Hitch = frame late vs display link
- Correlate hitch regions with Time Profiler samples on main
- 120Hz devices tighten the budget — same bugs, less margin

### 2.4 App Launch

- Separates **pre-main** (dyld, static) from **post-main**
- Classic regressions: dynamic framework load, sync Keychain, eager analytics SDKs
- Pair with “defer non-critical init” plans (keep crash SDK early — Day 18)

### 2.5 Network instrument

- Payload sizes, chatter, DNS, TLS, request fan-out
- When Firebase network/journey p90 is high and CPU is clean → stay here / backend

### 2.6 Core Animation

- Offscreen rendering, blending, masks, shadows
- Useful when GPU/commit cost dominates — less common than main-thread decode

### 2.7 Memory tools — **correctness section**

| Tool | Finds | Does **not** find well |
|---|---|---|
| **Leaks** | Unreachable allocations | Retain cycles (still reachable) |
| **Allocations** | Persistent growth, spikes | Ownership *why* without Graph |
| **Memory Graph** | Retain edges, cycles, abandoned VCs | Every historical transient |

**Interview script (memorize):**

> “A retain cycle keeps objects alive through mutual strong references — they’re abandoned but still reachable, so the Leaks instrument often stays clean. I use Memory Graph to see the ownership edges and Allocations to confirm those objects persist across navigation generations.”

**Wrong answer:** “We opened Leaks and saw the cycle.”

---

## 3. MetricKit deep dive

### 3.1 What you get

- Aggregated CPU, memory, hang/hitch-related diagnostics
- Exit / diagnostic payloads useful with crash narratives
- Delivered on a **delay** (think ~24h class aggregates) — not a live pager by itself

### 3.2 How you use it in speech

1. Fleet-level OS truth across device classes
2. Segment older devices when scroll jank is class-specific
3. Combine with custom journey traces for product SLIs
4. Privacy: OS aggregation — still scrub anything you add in custom layers

### 3.3 MetricKit vs Firebase Performance

| | MetricKit | Firebase Performance (S5) |
|---|---|---|
| Owner | Apple OS aggregates | Your custom traces / network |
| Journey SLIs | Weak alone | Strong (you define spans) |
| Latency of signal | Daily-ish | Nearer to release monitoring |
| Use together? | Yes | Yes |

---

## 4. Cold start — measurement & optimisation

### 4.1 Measure correctly

- Process start ≠ `didFinishLaunching` — pre-main happens earlier
- APM designs often use `sysctl` / process start + first-frame markers
- Break into: **preMain + appInit + firstFrame** (+ TTI if you define data-ready)

### 4.2 Optimisation playbook (say 4–5)

1. Reduce work before first frame (defer SDKs, avoid sync I/O)
2. Watch dynamic framework / dyld cost
3. Don’t block main on network for splash content when cacheable
4. Parallelize safe init carefully (ordering: crash SDK early)
5. Product: server-driven splash freshness without blocking forever (S12 soft bridge)

### 4.3 Soft production bridges

- **S12:** server-driven splash as cold-start *product* surface — measure TTI mindset, don’t invent ms.
- **S6:** LE Bottom Sheet cut full-screen navigations for **30%+** flows — UX performance, not only CPU.

---

## 5. Hitches vs hangs

| | Hitch | Hang |
|---|---|---|
| User feel | Scroll / animation jank | App “frozen” |
| Typical bar | Missed ~16ms frame | Main blocked hundreds of ms+ |
| Lab tools | Hitches, Time Profiler | Hang detection, Time Profiler |
| Field | MetricKit hitch/hang diagnostics | Hang rate, watchdog adjacency |

### 5.1 Hang detector concept (APM vocabulary)

```text
Background ping thread → signal main → wait with timeout (~250ms class)
  → if main doesn’t respond, capture stacks (carefully)
  → persist / upload later (not heavy work on critical path)
```

**NFR mindset:** Overhead must be budgeted; remote kill-switch for APM features; batch uploads; never sync network on the happy path.

**Difference vs watchdog kill:** Your detector observes; the OS may still kill if unresponsive long enough.

---

## 6. Scrolling attribution playbook

```text
Scroll jank reported
  → Reproduce with Hitches instrument
  → Time Profiler: main-thread decode? layout? lock?
  → Check cell configure cost / Auto Layout
  → Check image pipeline (downsample, decode off main — Day 16)
  → Check search path debounce/cancel (S3) if search list
  → Verify with hitch rate + field device-class segment
```

**Trap:** “FPS average is 58 — ship it.” Check hitch rate / p90 frame time / older devices.

---

## 7. Journey traces (Firebase Performance pattern)

### 7.1 What to trace

| Journey | Example span |
|---|---|
| Listing | Appear → first meaningful content |
| Search | Query committed → results rendered |
| Checkout | Tap pay → success/fail terminal state |

### 7.2 Placement judgment (S5-A1)

| Placement | When | Cost |
|---|---|---|
| Journey-level traces | Product SLIs, PM conversations | Need clear start/stop events |
| Per-request interceptor spans | Debugging API chatter | Cardinality / noise if unbounded |

> **Provenance:** How I would apply it · S5-A1 · journey traces vs interceptor spans

### 7.3 Cardinality hygiene

- Prefer URL **templates** (`/user/:id`) over raw URLs in metrics
- Avoid PII in trace names/attributes
- Sample if needed; watch SDK overhead

---

## 8. APM SDK shape (whiteboard in 10 minutes)

Useful when interview pivots to “design an APM”:

```text
App
  ├─ ColdStartTracker (process start → first frame)
  ├─ HangDetector (main ping)
  ├─ CustomTraces (journey API)
  ├─ MetricKitSubscriber
  └─ LocalStore (SQLite WAL) → batch GZIP upload (bg / threshold)
```

**Ops:** retry/backoff, kill-switch, alert on cold-start p90 / hang rate — cite categories, don’t invent BMS-internal alert thresholds as “Verified.”

---

## 9. Trade-offs table

| Choice | When | Cost |
|---|---|---|
| Instruments deep dive | Reproducible lab issue | Not fleet-representative alone |
| MetricKit first | Field-only / device-class | Delayed, coarse |
| Firebase Performance | Product journey SLIs | Vendor overhead; sampling |
| Signposts everywhere | Hot investigation | Noise if undisciplined |
| Optimize average | Never for UX SLOs | Hides p90 fires |
| Defer SDK init | Launch budget | Late feature readiness — order carefully |
| Micro-optimise JSON | After profiler proof | Premature otherwise |
| Leaks-only memory pass | Never for cycle hunts | False confidence |

---

## 10. Failure modes & gotchas

| Gotcha | Fix in speech |
|---|---|
| Average worship | Demand p90 / hitch rate |
| Profiler on wait-bound issue | Switch to network/backend |
| Leaks clean ⇒ no cycles | Graph + Allocations |
| Launch blame on UI only | Check pre-main / dyld |
| One device “proof” | Segment field data |
| Trace every URL raw | Templates + scrub |
| Ignore older devices | MetricKit / device-class p90 |

---

## 11. Cross-day links (light)

- Day 16 — image decode on main as hitch cause
- Day 18 — hang/OOM vs crash; crash SDK init order vs launch budget
- Day 20 — perf/CFS gates on release trains
- Day 03 — ARC/cycles deep; today only Instruments correctness

---

## 12. Optional citations (end only)

- Apple MetricKit / Understanding hitches / App launch documentation
- Repo mirror: `ios-system-design/docs/app-performance-monitoring.md`
- Story: [`story-bank.md`](../../../stories/story-bank.md) S5, S12, S6, S3

This chapter remains self-contained without those opens.
