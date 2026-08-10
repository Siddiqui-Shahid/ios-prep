# Audio script — Sample 05 — System-design mock: Crash Reporting SDK (Q&A)
> Listen-only sample Q&A from `05-system-design-mock.md`. Spoken answers and follow-ups.

## §0 Q1. Interviewer: “Design Crash Reporting SDK.” How do you open?

Next. Q1. Interviewer: “Design Crash Reporting SDK.” How do you open? Answer. Agenda (≤20s): “I’ll take ~5 minutes clarifying scope and scale, then a four-layer client high level design with backend touchpoints and load, then A P I/data, two deep dives on Signal-safe handler and OOM + breadcrumbs, and close on failure modes, metrics, and kill switches. Does that work?” Then ask the interviewer (speak these): 1. Signals + NSException + Swift fatal? 2. OOM heuristics? 3. Breadcrumb budget? 4. Upload next launch? 5. Out: server symbolication internals? Do not draw until they answer or you state labeled assumptions. Keep backend load in mind from the first minute. Follow-ups. Skip agenda?: Weak senior signal — interviewer may want different dives.. Clarify for 15 min?: Hard stop at 5 — park extras as labeled assumptions.. They refuse numbers?: State labeled estimates from daily active users context; continue..

## §1 Q2. After clarify — what does the optimal flow look like?

Next. Q2. After clarify — what does the optimal flow look like? Answer. Scripted outcomes for this mock: Async-signal-safe write; breadcrumbs; OOM next launch; upload; out: backend grouping deep dive. Good flow: agenda → clarify Qs → confirm → high level design (4 layers + backend + load) → A P I → two crisp dives → ops last 5. Weak flow: silent drawing, happy-path only, no QPS/TTL, invent metrics, skip ops. Follow-ups. They change scope mid-high level design?: Re-confirm in/out in 20s; adjust dives; protect ops.. Backend mesh deep-dive?: Out unless asked — sketch touchpoints, stay client-owned.. Forgot to ask offline?: State online-first + last-good cache as assumption; invite correction..

## §2 Q3. Walk the HLD — client layers, backend, load?

Next. Q3. Walk the HLD — client layers, backend, load? Answer. Handlers → mmap crash file → next launch uploader → ingest + dSYM. Constraints: signal handler — no malloc/ObjC. Init <10ms. Follow-ups. Why mmap?: Safe under crash constraints.. 99.95%+ crash free sessions?: Ops culture — BookMyShow I M O C participation — don’t claim sole ownership..

## §3 Q4. Data / API — entities, endpoints, scale?

Next. Q4. Data / API — entities, endpoints, scale? Answer. POST /v1/crashes/report, non-fatal endpoint. Missing dSYM hold ~7d. Follow-ups. Upload fail?: SQLite retry queue.. PII in breadcrumbs?: Redact..

## §4 Q5. Deep dive 1 — Signal-safe handler?

Next. Q5. Deep dive 1 — Signal-safe handler? Answer. POSIX signals write preallocated buffer only; never lock/malloc. Follow-ups. Swift errors?: Fatal vs caught — nonfatal A P I separate.. Hang vs crash?: Watchdog separate path..

## §5 Q6. Deep dive 2 — OOM + breadcrumbs?

Next. Q6. Deep dive 2 — OOM + breadcrumbs? Answer. Next-launch heuristic if jetsam; ring ~100 breadcrumbs <1µs write. Follow-ups. False OOM?: Label heuristic.. dSYM?: Upload in CI; match build UUID..

## §6 Q7. Ops — failures, metrics, rollout, load?

Next. Q7. Ops — failures, metrics, rollout, load? Answer. Crash-free sessions/users, symbolication %, upload success. Kill: disable nonfatal spam. Follow-ups. I M O C?: Incident coordination vocabulary — BookMyShow.. S D K size?: Init budget sacred..

## §7 Q8. Flow scorecard — did you hit the optimal spine?

Next. Q8. Flow scorecard — did you hit the optimal spine? Answer. Pass bar: clarify + agenda in ≤5; high level design shows 4 layers + backend + load; A P I has cursors/idempotency as needed; two deep dives; ops with kill switch and concrete metrics. Anti-patterns: offset pagination on dynamic feeds; main-thread SQLite/decode; inventing QPS as fact; never reaching ops; blob “architecture” with no data flow. Spine: 0–5 clarify · 5–15 high level design · 15–25 A P I · 25–40 dives · 40–45 ops. Follow-ups. Ran long on dive 1?: Park dive 2 bullets; protect ops 5 min.. Forgot load?: One sentence: daily active users → labeled QPS, cursor cost, single-flight.. Invented crash-free %?: Forbidden — use resume-backed numbers or label as target..
