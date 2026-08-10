# Audio script — Sample 05 — System-design mock: Mobile Payment Checkout (Q&A)
> Listen-only sample Q&A from `05-system-design-mock.md`. Spoken answers and follow-ups.

## §0 Q1. Interviewer: “Design Mobile Payment Checkout.” How do you open?

Next. Q1. Interviewer: “Design Mobile Payment Checkout.” How do you open? Answer. Agenda (≤20s): “I’ll take ~5 minutes clarifying scope and scale, then a four-layer client high level design with backend touchpoints and load, then A P I/data, two deep dives on Idempotency exactly-once and Poller + mid-kill recovery, and close on failure modes, metrics, and kill switches. Does that work?” Then ask the interviewer (speak these): 1. Apple Pay / card tokenization — which methods? 2. Idempotency exactly-once required? 3. daily active users and checkout QPS peak? 4. 3DS in scope? 5. Poll vs webhook-driven client? 6. Out: marketplace splits, bank acquiring internals? 7. If time: Search autocomplete sister prompt? Do not draw until they answer or you state labeled assumptions. Keep backend load in mind from the first minute. Follow-ups. Skip agenda?: Weak senior signal — interviewer may want different dives.. Clarify for 15 min?: Hard stop at 5 — park extras as labeled assumptions.. They refuse numbers?: State labeled estimates from daily active users context; continue..

## §1 Q2. After clarify — what does the optimal flow look like?

Next. Q2. After clarify — what does the optimal flow look like? Answer. Scripted outcomes for this mock: Tokenized checkout; Idempotency-Key; payment FSM + SQLite recovery; poll status; 3DS; out: acquiring internals. Search = follow-up only. Good flow: agenda → clarify Qs → confirm → high level design (4 layers + backend + load) → A P I → two crisp dives → ops last 5. Weak flow: silent drawing, happy-path only, no QPS/TTL, invent metrics, skip ops. Follow-ups. They change scope mid-high level design?: Re-confirm in/out in 20s; adjust dives; protect ops.. Backend mesh deep-dive?: Out unless asked — sketch touchpoints, stay client-owned.. Forgot to ask offline?: State online-first + last-good cache as assumption; invite correction..

## §2 Q3. Walk the HLD — client layers, backend, load?

Next. Q3. Walk the HLD — client layers, backend, load? Answer. Checkout U I → Payment VM (FSM) → Repository (SQLite intent) → Merchant A P I → PSP (Stripe/Adyen). Pinning on payment hosts. Load: Idempotency TTL 24h; A P I timeout 30s; poll ≤5m every 5s; never double-charge on retry. Sister: Search debounce/cancel if interviewer switches — don’t mix into payment high level design. Follow-ups. PCI?: No raw PAN on device if tokenized — Apple Pay/PSP fields.. Ads Mock #2?: Architecture talk may be Ads/S D U I — this card is Payment SD spine..

## §3 Q4. Data / API — entities, endpoints, scale?

Next. Q4. Data / API — entities, endpoints, scale? Answer. POST /v1/payments/initiate + Idempotency-Key. GET /v1/payments/{id}/status. 3DS challenge URL handling. Follow-ups. Retry POST?: Same Idempotency-Key — never new key on unknown outcome.. 4xx vs 5xx?: 4xx no retry charge; 5xx → poll status..

## §4 Q5. Deep dive 1 — Idempotency exactly-once?

Next. Q5. Deep dive 1 — Idempotency exactly-once? Answer. Client UUID key persisted before call; retries reuse key; server dedupe 24h. Follow-ups. Lost response?: Poll by payment id — don’t re-initiate new key.. Clock skew?: Server TTL authoritative..

## §5 Q6. Deep dive 2 — Poller + mid-kill recovery?

Next. Q6. Deep dive 2 — Poller + mid-kill recovery? Answer. Persist FSM in SQLite; on launch resume poll until terminal. Timeout → poll not fail toast. Follow-ups. User kills app?: Resume pending payment screen.. Search follow-up?: Debounce 300ms + cancel — search-autocomplete.md..

## §6 Q7. Ops — failures, metrics, rollout, load?

Next. Q7. Ops — failures, metrics, rollout, load? Answer. Success 99.5% target, latency, 3ds rate. Kill: disable method; maintenance banner. Follow-ups. Invent auth rates?: Forbidden.. Pinning?: Payment hosts — networking sister dive..

## §7 Q8. Flow scorecard — did you hit the optimal spine?

Next. Q8. Flow scorecard — did you hit the optimal spine? Answer. Pass bar: clarify + agenda in ≤5; high level design shows 4 layers + backend + load; A P I has cursors/idempotency as needed; two deep dives; ops with kill switch and concrete metrics. Anti-patterns: offset pagination on dynamic feeds; main-thread SQLite/decode; inventing QPS as fact; never reaching ops; blob “architecture” with no data flow. Spine: 0–5 clarify · 5–15 high level design · 15–25 A P I · 25–40 dives · 40–45 ops. Follow-ups. Ran long on dive 1?: Park dive 2 bullets; protect ops 5 min.. Forgot load?: One sentence: daily active users → labeled QPS, cursor cost, single-flight.. Invented crash-free %?: Forbidden — use resume-backed numbers or label as target..
