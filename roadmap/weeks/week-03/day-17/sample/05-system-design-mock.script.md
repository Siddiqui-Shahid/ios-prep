# Audio script — Sample 05 — System-design mock: App Performance Monitoring (Q&A)
> Listen-only sample Q&A from `05-system-design-mock.md`. Spoken answers and follow-ups.

## §0 Q1. Interviewer: “Design App Performance Monitoring.” How do you open?

Next. Q1. Interviewer: “Design App Performance Monitoring.” How do you open? Answer. Agenda (≤20s): “I’ll take ~5 minutes clarifying scope and scale, then a four-layer client high level design with backend touchpoints and load, then A P I/data, two deep dives on Cold start measurement and Hang watchdog, and close on failure modes, metrics, and kill switches. Does that work?” Then ask the interviewer (speak these): 1. Cold start, hang, network, memory in scope? 2. Crash S D K separate? 3. Batch upload budget? 4. MetricKit OK? 5. Overhead SLO <1% CPU? Do not draw until they answer or you state labeled assumptions. Keep backend load in mind from the first minute. Follow-ups. Skip agenda?: Weak senior signal — interviewer may want different dives.. Clarify for 15 min?: Hard stop at 5 — park extras as labeled assumptions.. They refuse numbers?: State labeled estimates from daily active users context; continue..

## §1 Q2. After clarify — what does the optimal flow look like?

Next. Q2. After clarify — what does the optimal flow look like? Answer. Scripted outcomes for this mock: APM client: cold start, hang 250ms, network templates, MetricKit; crash separate; batch gzip upload. Good flow: agenda → clarify Qs → confirm → high level design (4 layers + backend + load) → A P I → two crisp dives → ops last 5. Weak flow: silent drawing, happy-path only, no QPS/TTL, invent metrics, skip ops. Follow-ups. They change scope mid-high level design?: Re-confirm in/out in 20s; adjust dives; protect ops.. Backend mesh deep-dive?: Out unless asked — sketch touchpoints, stay client-owned.. Forgot to ask offline?: State online-first + last-good cache as assumption; invite correction..

## §2 Q3. Walk the HLD — client layers, backend, load.

Next. Q3. Walk the HLD — client layers, backend, load Answer. Instrumentation S D K → ring buffers → batch uploader → ingest/TSDB. Never block main. Load: batch ≤~500KB gzip; background upload; sampling under load. Follow-ups. URL template anti-pattern?: Normalize /users/123 → /users/{id} or cardinality explodes.. Firebase Performance?: BMS traces — listing/checkout/search..

## §3 Q4. Data / API — entities, endpoints, scale.

Next. Q4. Data / API — entities, endpoints, scale Answer. POST /v1/metrics/batch gzip. Local persistence if offline. Follow-ups. PII in spans?: Scrub — no tokens/emails.. Kill switch?: Remote disable S D K if it hangs..

## §4 Q5. Deep dive 1 — Cold start measurement?

Next. Q5. Deep dive 1 — Cold start measurement? Answer. process start/sysctl → first frame; break pre-main vs post-main. Target cold <1.2s class from spec. Follow-ups. Pre-main heavy?: Dyld/frameworks — modularization link.. P90 2s?: P1 alert..

## §5 Q6. Deep dive 2 — Hang watchdog?

Next. Q6. Deep dive 2 — Hang watchdog? Answer. Main-thread ping; 250ms hang candidate; stack capture carefully; don’t deadlock in handler. Follow-ups. False positives?: Debugger attached; breakpoints.. Hitch vs hang?: Hitch frame budget; hang multi-hundred ms..

## §6 Q7. Ops — failures, metrics, rollout, load?

Next. Q7. Ops — failures, metrics, rollout, load? Answer. Upload success; cold p90; hang rate; network p99. Kill APM if self-hurting. Follow-ups. Production?: BookMyShow Firebase Performance traces.. Crash-free?: Pair with crash S D K day — don’t conflate..

## §7 Q8. Flow scorecard — did you hit the optimal spine?

Next. Q8. Flow scorecard — did you hit the optimal spine? Answer. Pass bar: clarify + agenda in ≤5; high level design shows 4 layers + backend + load; A P I has cursors/idempotency as needed; two deep dives; ops with kill switch and concrete metrics. Anti-patterns: offset pagination on dynamic feeds; main-thread SQLite/decode; inventing QPS as fact; never reaching ops; blob “architecture” with no data flow. Spine: 0–5 clarify · 5–15 high level design · 15–25 A P I · 25–40 dives · 40–45 ops. Follow-ups. Ran long on dive 1?: Park dive 2 bullets; protect ops 5 min.. Forgot load?: One sentence: daily active users → labeled QPS, cursor cost, single-flight.. Invented crash-free %?: Forbidden — use resume-backed numbers or label as target..
