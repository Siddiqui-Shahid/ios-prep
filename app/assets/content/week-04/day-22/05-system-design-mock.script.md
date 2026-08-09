# Audio script — Sample 05 — System-design mock: Collaborative Document Editor (Q&A)
> Listen-only sample Q&A from `05-system-design-mock.md`. Spoken answers and follow-ups.

## §0 Q1. Interviewer: “Design Collaborative Document Editor.” How do you open?

Next. Q1. Interviewer: “Design Collaborative Document Editor.” How do you open? Answer. Agenda (≤20s): “I’ll take ~5 minutes clarifying scope and scale, then a four-layer client high level design with backend touchpoints and load, then A P I/data, two deep dives on OT transform engine and Pending queue + desync, and close on failure modes, metrics, and kill switches. Does that work?” Then ask the interviewer (speak these): 1. Multi-user realtime text — rich formatting out? 2. OT vs CRDT preference? 3. Max concurrent editors (~100)? 4. Offline op log? 5. Presence/cursors? Do not draw until they answer or you state labeled assumptions. Keep backend load in mind from the first minute. Follow-ups. Skip agenda?: Weak senior signal — interviewer may want different dives.. Clarify for 15 min?: Hard stop at 5 — park extras as labeled assumptions.. They refuse numbers?: State labeled estimates from daily active users context; continue..

## §1 Q2. After clarify — what does the optimal flow look like?

Next. Q2. After clarify — what does the optimal flow look like? Answer. Scripted outcomes for this mock: OT transforms; WS sequencer; offline op queue; presence; out: rich ACLs/folders. Good flow: agenda → clarify Qs → confirm → high level design (4 layers + backend + load) → A P I → two crisp dives → ops last 5. Weak flow: silent drawing, happy-path only, no QPS/TTL, invent metrics, skip ops. Follow-ups. They change scope mid-high level design?: Re-confirm in/out in 20s; adjust dives; protect ops.. Backend mesh deep-dive?: Out unless asked — sketch touchpoints, stay client-owned.. Forgot to ask offline?: State online-first + last-good cache as assumption; invite correction..

## §2 Q3. Walk the HLD — client layers, backend, load.

Next. Q3. Walk the HLD — client layers, backend, load Answer. Editor U I → OT engine → pending op queue → WS → server sequencer. Snapshot store periodically. Load: presence ~500ms; batch ops ~500ms; snapshot ~100 ops; sync <100ms target. Follow-ups. CRDT instead?: Valid — state trade-off; pick one and go deep.. Tree D S A link?: Op transform ≠ tree problem — don’t force..

## §3 Q4. Data / API — entities, endpoints, scale.

Next. Q4. Data / API — entities, endpoints, scale Answer. GET /docs/{id}/snapshot; WS submit_ops / apply_ops / presence. Follow-ups. Desync?: Hash mismatch → full snapshot reload.. ACL?: Out unless asked..

## §4 Q5. Deep dive 1 — OT transform engine?

Next. Q5. Deep dive 1 — OT transform engine? Answer. Transform local vs remote ops against revision; apply optimistically; ACK revisions. Follow-ups. Cursor presence?: Separate channel; ephemeral.. CPU?: Metric OT time; compact history..

## §5 Q6. Deep dive 2 — Pending queue + desync?

Next. Q6. Deep dive 2 — Pending queue + desync? Answer. Queue offline; replay on reconnect; if 1000 ops warn/compact; desync → snapshot. Follow-ups. Partial apply?: Atomic per revision batch.. Conflict UX?: Rare with OT — still handle snapshot..

## §6 Q7. Ops — failures, metrics, rollout, load?

Next. Q7. Ops — failures, metrics, rollout, load? Answer. Sync latency, desync rate, OT CPU. Kill: read-only mode. Follow-ups. Redis presence?: Backend sketch only.. Invent editors count?: Use labeled ≤100 from spec..

## §7 Q8. Flow scorecard — did you hit the optimal spine?

Next. Q8. Flow scorecard — did you hit the optimal spine? Answer. Pass bar: clarify + agenda in ≤5; high level design shows 4 layers + backend + load; A P I has cursors/idempotency as needed; two deep dives; ops with kill switch and concrete metrics. Anti-patterns: offset pagination on dynamic feeds; main-thread SQLite/decode; inventing QPS as fact; never reaching ops; blob “architecture” with no data flow. Spine: 0–5 clarify · 5–15 high level design · 15–25 A P I · 25–40 dives · 40–45 ops. Follow-ups. Ran long on dive 1?: Park dive 2 bullets; protect ops 5 min.. Forgot load?: One sentence: daily active users → labeled QPS, cursor cost, single-flight.. Invented crash-free %?: Forbidden — use resume-backed numbers or label as target..
