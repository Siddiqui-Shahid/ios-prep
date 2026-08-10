# Audio script — Sample 05 — System-design mock: Push Notification System (Q&A)
> Listen-only sample Q&A from `05-system-design-mock.md`. Spoken answers and follow-ups.

## §0 Q1. Interviewer: “Design Push Notification System.” How do you open?

Next. Q1. Interviewer: “Design Push Notification System.” How do you open? Answer. Agenda (≤20s): “I’ll take ~5 minutes clarifying scope and scale, then a four-layer client high level design with backend touchpoints and load, then A P I/data, two deep dives on Token lifecycle and Silent push + deferred, and close on failure modes, metrics, and kill switches. Does that work?” Then ask the interviewer (speak these): 1. Display + silent + BG processing? 2. Token register every launch? 3. Deep link on open? 4. Payload ≤4KB OK? 5. Out: rich NSE deep dive, chat WS? Do not draw until they answer or you state labeled assumptions. Keep backend load in mind from the first minute. Follow-ups. Skip agenda?: Weak senior signal — interviewer may want different dives.. Clarify for 15 min?: Hard stop at 5 — park extras as labeled assumptions.. They refuse numbers?: State labeled estimates from daily active users context; continue..

## §1 Q2. After clarify — what does the optimal flow look like?

Next. Q2. After clarify — what does the optimal flow look like? Answer. Scripted outcomes for this mock: Token lifecycle; display/silent; router on tap; APNs fanout backend sketch; out: NSE deep, WS chat. Good flow: agenda → clarify Qs → confirm → high level design (4 layers + backend + load) → A P I → two crisp dives → ops last 5. Weak flow: silent drawing, happy-path only, no QPS/TTL, invent metrics, skip ops. Follow-ups. They change scope mid-high level design?: Re-confirm in/out in 20s; adjust dives; protect ops.. Backend mesh deep-dive?: Out unless asked — sketch touchpoints, stay client-owned.. Forgot to ask offline?: State online-first + last-good cache as assumption; invite correction..

## §2 Q3. Walk the HLD — client layers, backend, load?

Next. Q3. Walk the HLD — client layers, backend, load? Answer. App ↔ Device token A P I ↔ Push Service ↔ APNs HTTP/2. Client: register, display, silent ≤30s, route. Load: payload ≤4KB; silent ~3/hr; priority 10 vs 5; collapse-id. Follow-ups. Same as deeplink?: Tap → same DeepLinkRouter.. CI/CD?: Mention phased release — don’t boil CI unless asked..

## §3 Q4. Data / API — entities, endpoints, scale?

Next. Q4. Data / API — entities, endpoints, scale? Answer. PUT /v1/devices/{userId}/push-token, DELETE invalidate. Server→APNs. Client handles UNNotification. Follow-ups. 410 Unregistered?: Invalidate token server-side.. Denied permission?: Settings CTA — don’t spam..

## §4 Q5. Deep dive 1 — Token lifecycle?

Next. Q5. Deep dive 1 — Token lifecycle? Answer. Register every launch; rotate on change; dedupe server-side; multi-device. Follow-ups. Logout?: DELETE token binding.. Sandbox vs prod?: Correct APNs env — classic footgun..

## §5 Q6. Deep dive 2 — Silent push + deferred?

Next. Q6. Deep dive 2 — Silent push + deferred? Answer. Silent ≤30s work; throttle; fallback BGAppRefresh. Deferred install links sister to deeplink doc. Follow-ups. i O S throttling?: Expect coalescing — design resilient sync.. Security?: Don’t put secrets in payload..

## §6 Q7. Ops — failures, metrics, rollout, load?

Next. Q7. Ops — failures, metrics, rollout, load? Answer. Delivery, CTR (labeled ranges only), invalidate on 410. Kill: stop campaign; collapse-id. Follow-ups. Production?: Grizzlies push via Airship/Mixpanel routing discipline.. Invent open rates?: Forbidden as personal fact..

## §7 Q8. Flow scorecard — did you hit the optimal spine?

Next. Q8. Flow scorecard — did you hit the optimal spine? Answer. Pass bar: clarify + agenda in ≤5; high level design shows 4 layers + backend + load; A P I has cursors/idempotency as needed; two deep dives; ops with kill switch and concrete metrics. Anti-patterns: offset pagination on dynamic feeds; main-thread SQLite/decode; inventing QPS as fact; never reaching ops; blob “architecture” with no data flow. Spine: 0–5 clarify · 5–15 high level design · 15–25 A P I · 25–40 dives · 40–45 ops. Follow-ups. Ran long on dive 1?: Park dive 2 bullets; protect ops 5 min.. Forgot load?: One sentence: daily active users → labeled QPS, cursor cost, single-flight.. Invented crash-free %?: Forbidden — use resume-backed numbers or label as target..
