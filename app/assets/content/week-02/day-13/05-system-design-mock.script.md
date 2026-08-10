# Audio script — Sample 05 — System-design mock: Instant Messaging & Chat (Q&A)
> Listen-only sample Q&A from `05-system-design-mock.md`. Spoken answers and follow-ups.

## §0 Q1. Interviewer: “Design Instant Messaging & Chat.” How do you open?

Next. Q1. Interviewer: “Design Instant Messaging & Chat.” How do you open? Answer. Agenda (≤20s): “I’ll take ~5 minutes clarifying scope and scale, then a four-layer client high level design with backend touchpoints and load, then A P I/data, two deep dives on WS reconnect + heartbeat and Message state machine, and close on failure modes, metrics, and kill switches. Does that work?” Then ask the interviewer (speak these): 1. 1:1 + group text? Media? 2. E2EE in scope or conceptual only? 3. daily active users and message QPS? 4. Offline queue required? 5. WebSocket + REST history? 6. Out: WebRTC calls? Do not draw until they answer or you state labeled assumptions. Keep backend load in mind from the first minute. Follow-ups. Skip agenda?: Weak senior signal — interviewer may want different dives.. Clarify for 15 min?: Hard stop at 5 — park extras as labeled assumptions.. They refuse numbers?: State labeled estimates from daily active users context; continue..

## §1 Q2. After clarify — what does the optimal flow look like?

Next. Q2. After clarify — what does the optimal flow look like? Answer. Scripted outcomes for this mock: WS realtime + REST history; SQLite; UUID idempotency; media presign; E2EE concepts only unless asked; out: calls. Good flow: agenda → clarify Qs → confirm → high level design (4 layers + backend + load) → A P I → two crisp dives → ops last 5. Weak flow: silent drawing, happy-path only, no QPS/TTL, invent metrics, skip ops. Follow-ups. They change scope mid-high level design?: Re-confirm in/out in 20s; adjust dives; protect ops.. Backend mesh deep-dive?: Out unless asked — sketch touchpoints, stay client-owned.. Forgot to ask offline?: State online-first + last-good cache as assumption; invite correction..

## §2 Q3. Walk the HLD — client layers, backend, load?

Next. Q3. Walk the HLD — client layers, backend, load? Answer. Chat U I → VM → MessageRepository (SQLite) → WSClient + REST. Presence optional. Backend: WS gateway; history service; presign; pubsub. Load: history cursor 50; heartbeat 30s; reconnect ≤60s jitter; store <500MB. Follow-ups. Why WS?: Bidirectional low latency — cheatsheet transport table.. APNs?: Wake when backgrounded — push system sister prompt..

## §3 Q4. Data / API — entities, endpoints, scale?

Next. Q4. Data / API — entities, endpoints, scale? Answer. wss://…/v1/chat events: send/ack/incoming. GET /threads, GET /threads/{id}/messages?cursor=. Client message UUID for idempotency. Follow-ups. Exactly-once?: At-least-once + idempotent UUID.. Ordering?: Server seq per thread; local pending bubble..

## §4 Q5. Deep dive 1 — WS reconnect + heartbeat?

Next. Q5. Deep dive 1 — WS reconnect + heartbeat? Answer. 30s ping; detect zombie; exponential backoff + jitter; resume with last_ack seq. Follow-ups. App killed?: Pending queue drain on launch.. Stampede?: Jitter reconnect..

## §5 Q6. Deep dive 2 — Message state machine?

Next. Q6. Deep dive 2 — Message state machine? Answer. local→sending→sent→delivered→read; fail→failed+retry. Offline enqueue. Media: upload presign then send message referencing URL. Follow-ups. Partial group ack?: Per-recipient receipts if product needs.. E2EE?: Keys high-level only unless pulled deep..

## §6 Q7. Ops — failures, metrics, rollout, load?

Next. Q7. Ops — failures, metrics, rollout, load? Answer. Delivery p99, queue depth, WS drop rate. Kill: force polling mode. Follow-ups. Battery?: <2%/hr active chat target — batch presence.. Security?: TLS; token auth on WS..

## §7 Q8. Flow scorecard — did you hit the optimal spine?

Next. Q8. Flow scorecard — did you hit the optimal spine? Answer. Pass bar: clarify + agenda in ≤5; high level design shows 4 layers + backend + load; A P I has cursors/idempotency as needed; two deep dives; ops with kill switch and concrete metrics. Anti-patterns: offset pagination on dynamic feeds; main-thread SQLite/decode; inventing QPS as fact; never reaching ops; blob “architecture” with no data flow. Spine: 0–5 clarify · 5–15 high level design · 15–25 A P I · 25–40 dives · 40–45 ops. Follow-ups. Ran long on dive 1?: Park dive 2 bullets; protect ops 5 min.. Forgot load?: One sentence: daily active users → labeled QPS, cursor cost, single-flight.. Invented crash-free %?: Forbidden — use resume-backed numbers or label as target..
