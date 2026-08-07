# Audio script — Sample 03 — Startup and scrolling (Q&A)
> Listen-only sample Q&A from `03-startup-scrolling.md`. Spoken answers and follow-ups.

## §0 Q1. What are the cold-start phases you must name?

Next. Q1. What are the cold-start phases you must name? Answer. Pre-main (dyld, static init, +load-class work) → main / App / Scene setup → first frame (TTFF) → time-to-interactive (TTI) — data-ready useful U I. Process start ≠ didFinishLaunching — pre-main happens earlier. Do not invent fake “847ms cold start” — speak categories and measurement method. Follow-ups. TTFF vs TTI?: First pixel vs user can actually use the app — splash may paint before TTI.. APM measurement?: Often sysctl process start + first-frame markers + your TTI definition.. Audio streaming + server-driven splash (Aces) soft bridge?: Server-driven splash as product surface — TTI mindset, no invented ms..

## §1 Q2. What is the cold-start optimisation playbook?

Next. Q2. What is the cold-start optimisation playbook? Answer. (1) Reduce work before first frame — defer non-critical SDKs, avoid sync I/O on main. (2) Watch dynamic framework / dyld cost (Day 15 modularization). (3) Don’t block main on network for splash when cacheable. (4) Parallelize safe init carefully — crash S D K early, defer heavy analytics (Day 18). (5) Product: server-driven splash freshness without blocking forever. Follow-ups. Crash S D K vs analytics order?: Crash reporting init early and fast; heavy analytics deferred.. Sync Keychain on launch?: Classic App Launch regression in Instruments.. Too many dylibs?: Pre-main cost — prefer static internal modules where possible..

## §2 Q3. Hitch vs hang — one sentence each?

Next. Q3. Hitch vs hang — one sentence each? Answer. Hitch: missed ~16ms frame budget (8.3ms @ 120Hz) — scroll/animation jank. Hang: main thread blocked long enough to feel frozen (hundreds of ms+; APM often ~250ms class threshold). Lab: Hitches + Time Profiler vs hang detection. Field: MetricKit diagnostics; hangs may not hurt crash free sessions but hurt retention. Follow-ups. Watchdog kill?: OS kills unresponsive app — related but not identical to hang metrics.. “FPS average 58”?: Trap — check hitch rate and p90 frame time on older devices.. Main-thread decode?: Classic hitch cause — Day 16 downsample off main..

## §3 Q4. What is the scrolling attribution playbook?

Next. Q4. What is the scrolling attribution playbook? Answer. Reproduce with Hitches instrument → Time Profiler: main-thread decode? layout? lock? → Check cell configure cost / Auto Layout → Check image pipeline (downsample, off main) → Search path debounce/cancel (BookMyShow backend-driven header & search) if search list → Verify with hitch rate + field device-class segment. Follow-ups. Auto Layout thrash?: Time Profiler + Instruments view hierarchy debugging.. Huge cell configure?: Split work — parse off main, diff models, avoid redundant layout.. BookMyShow LE Bottom Sheet UX perf hook?: LE Bottom Sheet — 30%+ flows fewer full-screen navigations — stack cost, not only CPU..

## §4 Q5. What journeys should Firebase traces cover?

Next. Q5. What journeys should Firebase traces cover? Answer. Listing: appear → first meaningful content bind. Search: debounced query fire → results rendered (ignore cancelled). Checkout: CTA tap → terminal success/fail — not every polling tick as separate journey. Journey-level for product SLIs; interceptor spans for debug chatter only (BookMyShow Firebase Performance traces-A1). Follow-ups. Why not trace every A P I call as journey?: Cardinality noise — PM cares about end-to-end user outcome.. Search cancel handling?: Stop trace or mark abandoned — don’t count stale queries as success.. Checkout polling?: One journey to terminal state — not N micro-traces per poll..

## §5 Q6. What anti-patterns must you refuse in perf interviews?

Next. Q6. What anti-patterns must you refuse in perf interviews? Answer. “Average improved 12%” without p90/hitch rate. “FPS is fine” without field device class. “Optimize everything in Time Profiler” when wait-bound. “One number performance score” instead of small SLI set: cold start p90, journey p90, hitch, crash free sessions (with hang gap honesty). Follow-ups. Defer S D K init trade-off?: Launch wins vs late feature readiness — order carefully.. Signposts everywhere?: Noise — discipline around hot investigations only.. Micro-optimise JSON when?: After profiler proves CPU-bound on critical path only..

## §6 Q7. How do Days 16 and 18 link to today?

Next. Q7. How do Days 16 and 18 link to today? Answer. Day 16: image decode on main as hitch cause — downsample/prefetch fixes. Day 18: hang/OOM vs crash; crash S D K init order vs launch budget; crash free sessions may be fine while users freeze. Day 20: perf/crash free sessions gates on release trains. Keep links light in speech — one sentence each when asked. Follow-ups. Day 19 bridge?: Security work must not silently add launch/main cost — measure.. Instruments map sketch?:../code/InstrumentsToolMap.swift. Next sample?: 04-production-s5.md — Verified Firebase Performance..

## §7 Q8. How does binary size relate to performance?

Next. Q8. How does binary size relate to performance? Answer. Binary size isn’t a store-listing vanity metric — it hits download time, dyld work, and page-ins that show up in launch and memory behaviour. Put a size budget in CI, respect app thinning realities, and keep modularization from dragging unnecessary code onto the launch path (Day 15 dynamic frameworks). Treat size as a performance input, not a separate vanity number. Follow-ups. Day 15 link?: Dynamic frameworks / modular boundaries raise pre-main cost.. Asset catalogs?: On-demand resources / thinning strategies reduce resident weight.. Gate in CI?: Fail the PR when the binary exceeds budget..
