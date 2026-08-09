# Audio script — Sample 05 — System-design mock: App Modularization & DI (Q&A)
> Listen-only sample Q&A from `05-system-design-mock.md`. Spoken answers and follow-ups.

## §0 Q1. Interviewer: “Design App Modularization & DI.” How do you open?

Next. Q1. Interviewer: “Design App Modularization & DI.” How do you open? Answer. Agenda (≤20s): “I’ll take ~5 minutes clarifying scope and scale, then a four-layer client high level design with backend touchpoints and load, then A P I/data, two deep dives on S D K boundary and Build & launch cost, and close on failure modes, metrics, and kill switches. Does that work?” Then ask the interviewer (speak these): 1. S D K as SPM binary vs source module? 2. Host app DI integration? 3. Binary size / launch budget? 4. Interface for host navigation? 5. Out: full release train EM prompt? Do not draw until they answer or you state labeled assumptions. Keep backend load in mind from the first minute. Follow-ups. Skip agenda?: Weak senior signal — interviewer may want different dives.. Clarify for 15 min?: Hard stop at 5 — park extras as labeled assumptions.. They refuse numbers?: State labeled estimates from daily active users context; continue..

## §1 Q2. After clarify — what does the optimal flow look like?

Next. Q2. After clarify — what does the optimal flow look like? Answer. Scripted outcomes for this mock: Stories-style feature module; Interface/Impl; host composition root; size/launch budgets. Good flow: agenda → clarify Qs → confirm → high level design (4 layers + backend + load) → A P I → two crisp dives → ops last 5. Weak flow: silent drawing, happy-path only, no QPS/TTL, invent metrics, skip ops. Follow-ups. They change scope mid-high level design?: Re-confirm in/out in 20s; adjust dives; protect ops.. Backend mesh deep-dive?: Out unless asked — sketch touchpoints, stay client-owned.. Forgot to ask offline?: State online-first + last-good cache as assumption; invite correction..

## §2 Q3. Walk the HLD — client layers, backend, load.

Next. Q3. Walk the HLD — client layers, backend, load Answer. Same module topology; emphasize S D K boundary: public Interface, private Impl, minimal Host A P I. Metrics: binary_size, dyld, incremental build. Follow-ups. Static vs dynamic for S D K?: Static often simpler; dynamic if replacement needed.. Versioning?: Semver Interface; avoid breaking hosts..

## §3 Q4. Data / API — entities, endpoints, scale.

Next. Q4. Data / API — entities, endpoints, scale Answer. StoriesSDK.start(dependency:) ; host provides analytics/network protocols. Follow-ups. Callback hell?: Async sequences / delegates thin.. Tests?: Host fakes via Interface..

## §4 Q5. Deep dive 1 — SDK boundary?

Next. Q5. Deep dive 1 — SDK boundary? Answer. No leaking UIKit subclasses across boundary unless intentional; dependency inversion for network/analytics. Follow-ups. God S D K?: Split packages — stories core vs U I.. DI in S D K?: Accept deps; don’t create global singletons..

## §5 Q6. Deep dive 2 — Build & launch cost?

Next. Q6. Deep dive 2 — Build & launch cost? Answer. Budget incremental builds; avoid resource duplication; measure pre-main. Follow-ups. Too many modules?: Coalesce leaf packages; keep Interface stable.. CI?: Module-level test targets..

## §6 Q7. Ops — failures, metrics, rollout, load?

Next. Q7. Ops — failures, metrics, rollout, load? Answer. Size/launch gates in CI; flag to disable S D K entry. Follow-ups. Production?: Stories S D K (Raw / Miami Heat) module thinking.. Platform EM?: Day 26/27 can widen to release trains..

## §7 Q8. Flow scorecard — did you hit the optimal spine?

Next. Q8. Flow scorecard — did you hit the optimal spine? Answer. Pass bar: clarify + agenda in ≤5; high level design shows 4 layers + backend + load; A P I has cursors/idempotency as needed; two deep dives; ops with kill switch and concrete metrics. Anti-patterns: offset pagination on dynamic feeds; main-thread SQLite/decode; inventing QPS as fact; never reaching ops; blob “architecture” with no data flow. Spine: 0–5 clarify · 5–15 high level design · 15–25 A P I · 25–40 dives · 40–45 ops. Follow-ups. Ran long on dive 1?: Park dive 2 bullets; protect ops 5 min.. Forgot load?: One sentence: daily active users → labeled QPS, cursor cost, single-flight.. Invented crash-free %?: Forbidden — use resume-backed numbers or label as target..
