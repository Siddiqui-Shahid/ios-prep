# Audio script — Sample 05 — System-design mock: App Modularization & DI (Q&A)
> Listen-only sample Q&A from `05-system-design-mock.md`. Spoken answers and follow-ups.

## §0 Q1. Interviewer: “Design App Modularization & DI.” How do you open?

Next. Q1. Interviewer: “Design App Modularization & DI.” How do you open? Answer. Agenda (≤20s): “I’ll take ~5 minutes clarifying scope and scale, then a four-layer client high level design with backend touchpoints and load, then A P I/data, two deep dives on Interface / Impl split and Composition-root DI, and close on failure modes, metrics, and kill switches. Does that work?” Then ask the interviewer (speak these): 1. Monorepo feature modules or multi-repo? 2. SPM only, or CocoaPods mix? 3. Build time budget (incremental <30s)? 4. DI style — constructor, Needle, Factory? 5. Dynamic frameworks limit concern? 6. Out: full CI scripts / git branching? Do not draw until they answer or you state labeled assumptions. Keep backend load in mind from the first minute. Follow-ups. Skip agenda?: Weak senior signal — interviewer may want different dives.. Clarify for 15 min?: Hard stop at 5 — park extras as labeled assumptions.. They refuse numbers?: State labeled estimates from daily active users context; continue..

## §1 Q2. After clarify — what does the optimal flow look like?

Next. Q2. After clarify — what does the optimal flow look like? Answer. Scripted outcomes for this mock: App→Feature→Domain→Core; Interface vs Impl; composition-root DI; static preferred; out: CI deep dive. Good flow: agenda → clarify Qs → confirm → high level design (4 layers + backend + load) → A P I → two crisp dives → ops last 5. Weak flow: silent drawing, happy-path only, no QPS/TTL, invent metrics, skip ops. Follow-ups. They change scope mid-high level design?: Re-confirm in/out in 20s; adjust dives; protect ops.. Backend mesh deep-dive?: Out unless asked — sketch touchpoints, stay client-owned.. Forgot to ask offline?: State online-first + last-good cache as assumption; invite correction..

## §2 Q3. Walk the HLD — client layers, backend, load?

Next. Q3. Walk the HLD — client layers, backend, load? Answer. Topology: App composition root wires Feature interfaces; Features depend on Domain protocols; Core = network/storage/design system. No feature→feature Impl deps. Backend N/A beyond shared Network client. Load/build: 100–300 modules possible; incremental <30s target; ≤~6 dynamic historically — prefer static. Follow-ups. Clean vs modules?: Modules are boundaries; Clean/M V V M live inside features.. Circular deps?: Break with Interface modules — compile-time fail is good..

## §3 Q4. Data / API — entities, endpoints, scale?

Next. Q4. Data / API — entities, endpoints, scale? Answer. Protocol contracts: CheckoutBuildable, CheckoutDependency. Factory/Needle components at composition root. Network as APIClientProtocol in Core — features never import URLSession directly if avoidable. Follow-ups. Test seams?: Swap Impl in tests via Interface.. Binary size?: Track mb; avoid duplicate symbols across dynamics..

## §4 Q5. Deep dive 1 — Interface / Impl split?

Next. Q5. Deep dive 1 — Interface / Impl split? Answer. FeatureAInterface exposed to App; FeatureAImpl private. Prevents secretly coupled features and speeds compile. Follow-ups. Who owns navigation?: App coordinator depends on buildable interfaces.. Shared U I kit?: DesignSystem in Core — version carefully..

## §5 Q6. Deep dive 2 — Composition-root DI?

Next. Q6. Deep dive 2 — Composition-root DI? Answer. Construct graph once at launch; pass dependencies down. Avoid service locators in features. Needle/Factory trees mirror module graph. Follow-ups. Runtime optional deps?: Protocols + null objects; still wired at root.. District migration?: Clean/M V V M migration = boundaries + review bar — District Free Parking story..

## §6 Q7. Ops — failures, metrics, rollout, load?

Next. Q7. Ops — failures, metrics, rollout, load? Answer. build_time_seconds, binary_size_mb, dyld_launch_time. Fail CI on new circular deps. Kill: feature flag whole module entry points. Follow-ups. Launch regression?: Fewer dynamics; defer non-critical modules.. Sev-1 bad module?: Flag off surface; hotfix train — platform EM vocabulary..

## §7 Q8. Flow scorecard — did you hit the optimal spine?

Next. Q8. Flow scorecard — did you hit the optimal spine? Answer. Pass bar: clarify + agenda in ≤5; high level design shows 4 layers + backend + load; A P I has cursors/idempotency as needed; two deep dives; ops with kill switch and concrete metrics. Anti-patterns: offset pagination on dynamic feeds; main-thread SQLite/decode; inventing QPS as fact; never reaching ops; blob “architecture” with no data flow. Spine: 0–5 clarify · 5–15 high level design · 15–25 A P I · 25–40 dives · 40–45 ops. Follow-ups. Ran long on dive 1?: Park dive 2 bullets; protect ops 5 min.. Forgot load?: One sentence: daily active users → labeled QPS, cursor cost, single-flight.. Invented crash-free %?: Forbidden — use resume-backed numbers or label as target..
