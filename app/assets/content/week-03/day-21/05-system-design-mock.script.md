# Audio script — Sample 05 — System-design mock: Networking Layer + SSL Pinning (Q&A)
> Listen-only sample Q&A from `05-system-design-mock.md`. Spoken answers and follow-ups.

## §0 Q1. Interviewer: “Design Networking Layer + SSL Pinning.” How do you open?

Next. Q1. Interviewer: “Design Networking Layer + SSL Pinning.” How do you open? Answer. Agenda (≤20s): “I’ll take ~5 minutes clarifying scope and scale, then a four-layer client high level design with backend touchpoints and load, then A P I/data, two deep dives on Single-flight refresh and SPKI pin rotation, and close on failure modes, metrics, and kill switches. Does that work?” Then ask the interviewer (speak these): 1. First-party networking + auth + SPKI pinning? 2. 30L+ daily active users context OK? 3. Out: backend mesh / Android? 4. Dives: single-flight refresh + SPKI rotation? 5. Ops with p50/p90? Do not draw until they answer or you state labeled assumptions. Keep backend load in mind from the first minute. Follow-ups. Skip agenda?: Weak senior signal — interviewer may want different dives.. Clarify for 15 min?: Hard stop at 5 — park extras as labeled assumptions.. They refuse numbers?: State labeled estimates from daily active users context; continue..

## §1 Q2. After clarify — what does the optimal flow look like?

Next. Q2. After clarify — what does the optimal flow look like? Answer. Scripted outcomes for this mock: Networking+pinning 45‑min mock; refresh actor; pin rotation design; S D U I is the other prompt — pick one live. Good flow: agenda → clarify Qs → confirm → high level design (4 layers + backend + load) → A P I → two crisp dives → ops last 5. Weak flow: silent drawing, happy-path only, no QPS/TTL, invent metrics, skip ops. Follow-ups. They change scope mid-high level design?: Re-confirm in/out in 20s; adjust dives; protect ops.. Backend mesh deep-dive?: Out unless asked — sketch touchpoints, stay client-owned.. Forgot to ask offline?: State online-first + last-good cache as assumption; invite correction..

## §2 Q3. Walk the HLD — client layers, backend, load.

Next. Q3. Walk the HLD — client layers, backend, load Answer. Features → protocols → APIClient → interceptors → URLSession + SPKI + allowlist → URLCache/Keychain/reachability. Prefer URLSession when owning trust. Load: HTTP/2, gzip, timeout 30s, pin rotate ≤90d. Follow-ups. S D U I instead?: If Prompt A chosen, switch cards — don’t mix mid-draw.. Four layers?: Yes + data flow arrows..

## §3 Q4. Data / API — entities, endpoints, scale.

Next. Q4. Data / API — entities, endpoints, scale Answer. APIEndpoint async throws; 401 refresh coordinator; retry only transient on idempotent GET; pin challenge. Follow-ups. Charge POST retry?: Never blind — idempotency or poll.. Backup pins?: Ship before rotate; break-glass design labeled..

## §4 Q5. Deep dive 1 — Single-flight refresh?

Next. Q5. Deep dive 1 — Single-flight refresh? Answer. Actor-owned refresh; waiters; success retry once; failure logout. Follow-ups. N parallel 401?: One refresh.. Refresh endpoint pin?: Same trust policy..

## §5 Q6. Deep dive 2 — SPKI pin rotation?

Next. Q6. Deep dive 2 — SPKI pin rotation? Answer. Pin SHA-256 of SPKI DER; backup pins; client before server rotate; mismatch terminate + metric. Follow-ups. Outage from bad pin?: Backup + staged rollout.. Whitelist?: Domain allowlist beside pin..

## §6 Q7. Ops — failures, metrics, rollout, load?

Next. Q7. Ops — failures, metrics, rollout, load? Answer. p50/p90/p99, 5xx, refresh fail, pin fail. Kill retries; break-glass design. Score with Day 21 rubric. Follow-ups. Production?: BMS pinning + URLSession migration.. Cheatsheet?: ios-system-design/docs/cheatsheet.md spine..

## §7 Q8. Flow scorecard — did you hit the optimal spine?

Next. Q8. Flow scorecard — did you hit the optimal spine? Answer. Pass bar: clarify + agenda in ≤5; high level design shows 4 layers + backend + load; A P I has cursors/idempotency as needed; two deep dives; ops with kill switch and concrete metrics. Anti-patterns: offset pagination on dynamic feeds; main-thread SQLite/decode; inventing QPS as fact; never reaching ops; blob “architecture” with no data flow. Spine: 0–5 clarify · 5–15 high level design · 15–25 A P I · 25–40 dives · 40–45 ops. Follow-ups. Ran long on dive 1?: Park dive 2 bullets; protect ops 5 min.. Forgot load?: One sentence: daily active users → labeled QPS, cursor cost, single-flight.. Invented crash-free %?: Forbidden — use resume-backed numbers or label as target..
