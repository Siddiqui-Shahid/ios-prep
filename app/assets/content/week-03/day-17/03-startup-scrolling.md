# Sample 03 — Startup and scrolling (Q&A)

> Guided teaching. Each answer stands alone and ends with **How can I relate to my case** using named work — never S-codes.

---

### Q1. What are the cold-start phases you must name?
**Answer:**

> **Pre-main** (dyld, static init, +load-class work) → **main / App / Scene setup** → **first frame (TTFF)** → **time-to-interactive (TTI)** — data-ready useful UI. Process start ≠ `didFinishLaunching` — pre-main happens earlier. Do **not** invent fake “847ms cold start” — speak categories and measurement method.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| TTFF vs TTI? | First pixel vs user can actually use the app — splash may paint before TTI. |
| APM measurement? | Often `sysctl` process start + first-frame markers + your TTI definition. |
| Audio streaming + server-driven splash (Aces) soft bridge? | Server-driven splash as product surface — TTI mindset, no invented ms. |

**How can I relate to my case:**
- **Shipped:** Audio streaming + server-driven splash (Aces)
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q2. What is the cold-start optimisation playbook?
**Answer:**

> (1) Reduce work before first frame — defer non-critical SDKs, avoid sync I/O on main. (2) Watch dynamic framework / dyld cost (Day 15 modularization). (3) Don’t block main on network for splash when cacheable. (4) Parallelize safe init carefully — **crash SDK early**, defer heavy analytics (Day 18). (5) Product: server-driven splash freshness without blocking forever.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Crash SDK vs analytics order? | Crash reporting init early and fast; heavy analytics deferred. |
| Sync Keychain on launch? | Classic App Launch regression in Instruments. |
| Too many dylibs? | Pre-main cost — prefer static internal modules where possible. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q3. Hitch vs hang — one sentence each?
**Answer:**

> **Hitch:** missed ~16ms frame budget (8.3ms @ 120Hz) — scroll/animation **jank**. **Hang:** main thread blocked long enough to feel **frozen** (hundreds of ms+; APM often ~250ms class threshold). Lab: Hitches + Time Profiler vs hang detection. Field: MetricKit diagnostics; hangs may not hurt CFS but hurt retention.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Watchdog kill? | OS kills unresponsive app — related but not identical to hang metrics. |
| “FPS average 58”? | Trap — check hitch rate and p90 frame time on older devices. |
| Main-thread decode? | Classic hitch cause — Day 16 downsample off main. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q4. What is the scrolling attribution playbook?
**Answer:**

> Reproduce with **Hitches** instrument → **Time Profiler**: main-thread decode? layout? lock? → Check cell `configure` cost / Auto Layout → Check image pipeline (downsample, off main) → Search path debounce/cancel (BookMyShow backend-driven header & search) if search list → Verify with hitch rate + field device-class segment.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Auto Layout thrash? | Time Profiler + Instruments view hierarchy debugging. |
| Huge cell configure? | Split work — parse off main, diff models, avoid redundant layout. |
| BookMyShow LE Bottom Sheet UX perf hook? | LE Bottom Sheet — 30%+ flows fewer full-screen navigations — stack cost, not only CPU. |

**How can I relate to my case:**
- **Shipped:** BookMyShow backend-driven header & search; BookMyShow LE Bottom Sheet
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q5. What journeys should Firebase traces cover?
**Answer:**

> **Listing:** appear → first meaningful content bind. **Search:** debounced query fire → results rendered (ignore cancelled). **Checkout:** CTA tap → terminal success/fail — not every polling tick as separate journey. Journey-level for product SLIs; interceptor spans for debug chatter only (BookMyShow Firebase Performance traces-A1).

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why not trace every API call as journey? | Cardinality noise — PM cares about end-to-end user outcome. |
| Search cancel handling? | Stop trace or mark abandoned — don’t count stale queries as success. |
| Checkout polling? | One journey to terminal state — not N micro-traces per poll. |

**How can I relate to my case:**
- **Shipped:** BookMyShow Firebase Performance traces
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q6. What anti-patterns must you refuse in perf interviews?
**Answer:**

> “Average improved 12%” without p90/hitch rate. “FPS is fine” without field device class. “Optimize everything in Time Profiler” when wait-bound. “One number performance score” instead of small SLI set: cold start p90, journey p90, hitch, CFS (with hang gap honesty).

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Defer SDK init trade-off? | Launch wins vs late feature readiness — order carefully. |
| Signposts everywhere? | Noise — discipline around hot investigations only. |
| Micro-optimise JSON when? | After profiler proves CPU-bound on critical path only. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q7. How do Days 16 and 18 link to today?
**Answer:**

> **Day 16:** image decode on main as hitch cause — downsample/prefetch fixes. **Day 18:** hang/OOM vs crash; crash SDK init order vs launch budget; CFS may be fine while users freeze. **Day 20:** perf/CFS gates on release trains. Keep links light in speech — one sentence each when asked.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Day 19 bridge? | Security work must not silently add launch/main cost — measure. |
| Instruments map sketch? | [`../code/InstrumentsToolMap.swift`](../code/InstrumentsToolMap.swift) |
| Next sample? | [04-production-s5.md](04-production-s5.md) — Verified Firebase Performance. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q8. How does binary size relate to performance?
**Answer:**

> Binary size isn’t a store-listing vanity metric — it hits **download time**, **dyld** work, and **page-ins** that show up in launch and memory behaviour. Put a **size budget in CI**, respect app thinning realities, and keep modularization from dragging unnecessary code onto the launch path (Day 15 dynamic frameworks). Treat size as a **performance input**, not a separate vanity number.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Day 15 link? | Dynamic frameworks / modular boundaries raise pre-main cost. |
| Asset catalogs? | On-demand resources / thinning strategies reduce resident weight. |
| Gate in CI? | Fail the PR when the binary exceeds budget. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

Next: [04-production-s5.md](04-production-s5.md)

---

## Brain puzzles (cover → think → check)

### Puzzle A — What is the cold-start optimisation playbook

**Ask yourself:** What is the cold-start optimisation playbook?

**Answer:** “(1) Reduce work before first frame — defer non-critical SDKs, avoid sync I/O on main. (2) Watch dynamic framework / dyld cost (Day 15 modularization). (3) Don’t block main on network for splash when cacheable. (4) Parallelize safe init carefully — **crash SDK early**, defer heavy analytics (Day 18). (5) Product: server-driven splash freshness without blocking forever.”

### Puzzle B — Hitch vs hang — one sentence each

**Ask yourself:** Hitch vs hang — one sentence each?

**Answer:** “**Hitch:** missed ~16ms frame budget (8.3ms @ 120Hz) — scroll/animation **jank**. **Hang:** main thread blocked long enough to feel **frozen** (hundreds of ms+; APM often ~250ms class threshold). Lab: Hitches + Time Profiler vs hang detection. Field: MetricKit diagnostics; hangs may not hurt CFS but hurt retention.”

### Puzzle C — What is the scrolling attribution playbook

**Ask yourself:** What is the scrolling attribution playbook?

**Answer:** “Reproduce with **Hitches** instrument → **Time Profiler**: main-thread decode? layout? lock? → Check cell `configure` cost / Auto Layout → Check image pipeline (downsample, off main) → Search path debounce/cancel (BookMyShow backend-driven header & search) if search list → Verify with hitch rate + field device-class segment.”
