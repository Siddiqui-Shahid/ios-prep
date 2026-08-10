# Audio script — Sample 05 — System-design mock: Realtime Location / Ride Tracking (Q&A)
> Listen-only sample Q&A from `05-system-design-mock.md`. Spoken answers and follow-ups.

## §0 Q1. Interviewer: “Design Realtime Location / Ride Tracking.” How do you open?

Next. Q1. Interviewer: “Design Realtime Location / Ride Tracking.” How do you open? Answer. Agenda (≤20s): “I’ll take ~5 minutes clarifying scope and scale, then a four-layer client high level design with backend touchpoints and load, then A P I/data, two deep dives on CL + battery and Rider interpolation, and close on failure modes, metrics, and kill switches. Does that work?” Then ask the interviewer (speak these): 1. Driver TX + rider map RX? 2. Battery budget? 3. Update interval 2–4s active? 4. WS transport? 5. Out: dispatch matching / payments? Do not draw until they answer or you state labeled assumptions. Keep backend load in mind from the first minute. Follow-ups. Skip agenda?: Weak senior signal — interviewer may want different dives.. Clarify for 15 min?: Hard stop at 5 — park extras as labeled assumptions.. They refuse numbers?: State labeled estimates from daily active users context; continue..

## §1 Q2. After clarify — what does the optimal flow look like?

Next. Q2. After clarify — what does the optimal flow look like? Answer. Scripted outcomes for this mock: CoreLocation filtered batching; WS; rider interpolation; offline queue; out: matching/payments. Good flow: agenda → clarify Qs → confirm → high level design (4 layers + backend + load) → A P I → two crisp dives → ops last 5. Weak flow: silent drawing, happy-path only, no QPS/TTL, invent metrics, skip ops. Follow-ups. They change scope mid-high level design?: Re-confirm in/out in 20s; adjust dives; protect ops.. Backend mesh deep-dive?: Out unless asked — sketch touchpoints, stay client-owned.. Forgot to ask offline?: State online-first + last-good cache as assumption; invite correction..

## §2 Q3. Walk the HLD — client layers, backend, load?

Next. Q3. Walk the HLD — client layers, backend, load? Answer. Driver: CL → filter/Kalman → batch → WS. Rider: WS → interpolate 4s → map polyline delta. Backend: WS; Kafka; ETA; Redis Geo. Load: 2–4s active / 15s BG; batch 3–4 pts/4s; heartbeat 30s. Follow-ups. Why not raw GPS every Hz?: Battery + noise — distanceFilter.. Map 60fps?: Interpolate; don’t redraw every point naively..

## §3 Q4. Data / API — entities, endpoints, scale?

Next. Q4. Data / API — entities, endpoints, scale? Answer. wss://…/trips/{id} location_batch, driver_update, eta_seconds. Follow-ups. Dead zone?: SQLite burst upload later.. Rider WS down?: HTTP poll 5s fallback..

## §4 Q5. Deep dive 1 — CL + battery?

Next. Q5. Deep dive 1 — CL + battery? Answer. accuracy + distanceFilter; Low Power mode coarsens; thermal aware. Follow-ups. Background modes?: Declare honestly; App Review.. Privacy?: Purpose strings; stop when trip ends..

## §5 Q6. Deep dive 2 — Rider interpolation?

Next. Q6. Deep dive 2 — Rider interpolation? Answer. Animate between updates; polyline delta; ETA separate channel. Follow-ups. Teleport snap?: Smooth with max jump threshold.. Heap/hash D S A?: Irrelevant — don’t force..

## §6 Q7. Ops — failures, metrics, rollout, load?

Next. Q7. Ops — failures, metrics, rollout, load? Answer. Fix accuracy, freshness p99, battery SLA. Kill: reduce frequency. Follow-ups. DoorDash sister?: ActivityKit tracker — different prompt.. Invent ETA accuracy?: Forbidden..

## §7 Q8. Flow scorecard — did you hit the optimal spine?

Next. Q8. Flow scorecard — did you hit the optimal spine? Answer. Pass bar: clarify + agenda in ≤5; high level design shows 4 layers + backend + load; A P I has cursors/idempotency as needed; two deep dives; ops with kill switch and concrete metrics. Anti-patterns: offset pagination on dynamic feeds; main-thread SQLite/decode; inventing QPS as fact; never reaching ops; blob “architecture” with no data flow. Spine: 0–5 clarify · 5–15 high level design · 15–25 A P I · 25–40 dives · 40–45 ops. Follow-ups. Ran long on dive 1?: Park dive 2 bullets; protect ops 5 min.. Forgot load?: One sentence: daily active users → labeled QPS, cursor cost, single-flight.. Invented crash-free %?: Forbidden — use resume-backed numbers or label as target..
