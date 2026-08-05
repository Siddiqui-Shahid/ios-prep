# Sample 03 — Startup and scrolling (Q&A)

> Guided teaching. Each answer stands alone; **Points to** shows where the full module expands the idea.

---

### Q1. What are the cold-start phases you must name?

**Points to:** [Foundations · §6 Startup anatomy](../01-foundations.md#6-startup-anatomy-names-you-must-say) · [Deep dive · §4 Cold start](../02-deep-dive.md#4-cold-start--measurement--optimisation)

**Answer:**

> **Pre-main** (dyld, static init, +load-class work) → **main / App / Scene setup** → **first frame (TTFF)** → **time-to-interactive (TTI)** — data-ready useful UI. Process start ≠ `didFinishLaunching` — pre-main happens earlier. Do **not** invent fake “847ms cold start” — speak categories and measurement method.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| TTFF vs TTI? | First pixel vs user can actually use the app — splash may paint before TTI. |
| APM measurement? | Often `sysctl` process start + first-frame markers + your TTI definition. |
| S12 soft bridge? | Server-driven splash as product surface — TTI mindset, no invented ms. |

---

### Q2. What is the cold-start optimisation playbook?

**Points to:** [Deep dive · §4.2 Optimisation playbook](../02-deep-dive.md#42-optimisation-playbook-say-4-5)

**Answer:**

> (1) Reduce work before first frame — defer non-critical SDKs, avoid sync I/O on main. (2) Watch dynamic framework / dyld cost (Day 15 modularization). (3) Don’t block main on network for splash when cacheable. (4) Parallelize safe init carefully — **crash SDK early**, defer heavy analytics (Day 18). (5) Product: server-driven splash freshness without blocking forever.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Crash SDK vs analytics order? | Crash reporting init early and fast; heavy analytics deferred. |
| Sync Keychain on launch? | Classic App Launch regression in Instruments. |
| Too many dylibs? | Pre-main cost — prefer static internal modules where possible. |

---

### Q3. Hitch vs hang — one sentence each?

**Points to:** [Foundations · §7 Scrolling & hitches](../01-foundations.md#7-scrolling--hitches-first-pass) · [Deep dive · §5 Hitches vs hangs](../02-deep-dive.md#5-hitches-vs-hangs)

**Answer:**

> **Hitch:** missed ~16ms frame budget (8.3ms @ 120Hz) — scroll/animation **jank**. **Hang:** main thread blocked long enough to feel **frozen** (hundreds of ms+; APM often ~250ms class threshold). Lab: Hitches + Time Profiler vs hang detection. Field: MetricKit diagnostics; hangs may not hurt CFS but hurt retention.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Watchdog kill? | OS kills unresponsive app — related but not identical to hang metrics. |
| “FPS average 58”? | Trap — check hitch rate and p90 frame time on older devices. |
| Main-thread decode? | Classic hitch cause — Day 16 downsample off main. |

---

### Q4. What is the scrolling attribution playbook?

**Points to:** [Deep dive · §6 Scrolling attribution](../02-deep-dive.md#6-scrolling-attribution-playbook)

**Answer:**

> Reproduce with **Hitches** instrument → **Time Profiler**: main-thread decode? layout? lock? → Check cell `configure` cost / Auto Layout → Check image pipeline (downsample, off main) → Search path debounce/cancel (S3) if search list → Verify with hitch rate + field device-class segment.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Auto Layout thrash? | Time Profiler + Instruments view hierarchy debugging. |
| Huge cell configure? | Split work — parse off main, diff models, avoid redundant layout. |
| S6 UX perf hook? | LE Bottom Sheet — 30%+ flows fewer full-screen navigations — stack cost, not only CPU. |

---

### Q5. What journeys should Firebase traces cover?

**Points to:** [Deep dive · §7 Journey traces](../02-deep-dive.md#7-journey-traces-firebase-performance-pattern) · [Production bridge · §6 Whiteboard](../03-production-bridge.md#6-whiteboard--where-youd-place-3-traces)

**Answer:**

> **Listing:** appear → first meaningful content bind. **Search:** debounced query fire → results rendered (ignore cancelled). **Checkout:** CTA tap → terminal success/fail — not every polling tick as separate journey. Journey-level for product SLIs; interceptor spans for debug chatter only (S5-A1).

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why not trace every API call as journey? | Cardinality noise — PM cares about end-to-end user outcome. |
| Search cancel handling? | Stop trace or mark abandoned — don’t count stale queries as success. |
| Checkout polling? | One journey to terminal state — not N micro-traces per poll. |

---

### Q6. What anti-patterns must you refuse in perf interviews?

**Points to:** [Production bridge · §7 Anti-patterns](../03-production-bridge.md#7-anti-patterns-to-refuse) · [Deep dive · §9 Trade-offs](../02-deep-dive.md#9-trade-offs-table)

**Answer:**

> “Average improved 12%” without p90/hitch rate. “FPS is fine” without field device class. “Optimize everything in Time Profiler” when wait-bound. “One number performance score” instead of small SLI set: cold start p90, journey p90, hitch, CFS (with hang gap honesty).

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Defer SDK init trade-off? | Launch wins vs late feature readiness — order carefully. |
| Signposts everywhere? | Noise — discipline around hot investigations only. |
| Micro-optimise JSON when? | After profiler proves CPU-bound on critical path only. |

---

### Q7. How do Days 16 and 18 link to today?

**Points to:** [Deep dive · §11 Cross-day links](../02-deep-dive.md#11-cross-day-links-light)

**Answer:**

> **Day 16:** image decode on main as hitch cause — downsample/prefetch fixes. **Day 18:** hang/OOM vs crash; crash SDK init order vs launch budget; CFS may be fine while users freeze. **Day 20:** perf/CFS gates on release trains. Keep links light in speech — one sentence each when asked.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Day 19 bridge? | Security work must not silently add launch/main cost — measure. |
| Instruments map sketch? | [`../code/InstrumentsToolMap.swift`](../code/InstrumentsToolMap.swift) |
| Next sample? | [04-production-s5.md](04-production-s5.md) — Verified Firebase Performance. |

---

Next: [04-production-s5.md](04-production-s5.md)
