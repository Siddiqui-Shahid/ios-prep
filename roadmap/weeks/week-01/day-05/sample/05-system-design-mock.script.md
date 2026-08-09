# Audio script — Sample 05 — System-design mock: Infinite Social Feed (Q&A)
> Listen-only sample Q&A from `05-system-design-mock.md`. Spoken answers and follow-ups.

## §0 Q1. Interviewer: “Design Infinite Social Feed.” How do you open?

Next. Q1. Interviewer: “Design Infinite Social Feed.” How do you open? Answer. Agenda (≤20s): “I’ll take ~5 minutes clarifying scope and scale, then a four-layer client high level design with backend touchpoints and load, then A P I/data, two deep dives on Structured concurrency for paging and Optimistic like actor, and close on failure modes, metrics, and kill switches. Does that work?” Then ask the interviewer (speak these): 1. Same feed scope as Day 01 — confirm cursor + offline cache? 2. daily active users / peak? 3. Structured concurrency for page+image tasks OK? 4. Actor for like coordinator? 5. Out: video + ranking? Do not draw until they answer or you state labeled assumptions. Keep backend load in mind from the first minute. Follow-ups. Skip agenda?: Weak senior signal — interviewer may want different dives.. Clarify for 15 min?: Hard stop at 5 — park extras as labeled assumptions.. They refuse numbers?: State labeled estimates from daily active users context; continue..

## §1 Q2. After clarify — what does the optimal flow look like?

Next. Q2. After clarify — what does the optimal flow look like? Answer. Scripted outcomes for this mock: Full client high level design for feed; async page tasks; actor for like single-flight; out: video/ranking. Good flow: agenda → clarify Qs → confirm → high level design (4 layers + backend + load) → A P I → two crisp dives → ops last 5. Weak flow: silent drawing, happy-path only, no QPS/TTL, invent metrics, skip ops. Follow-ups. They change scope mid-high level design?: Re-confirm in/out in 20s; adjust dives; protect ops.. Backend mesh deep-dive?: Out unless asked — sketch touchpoints, stay client-owned.. Forgot to ask offline?: State online-first + last-good cache as assumption; invite correction..

## §2 Q3. Walk the HLD — client layers, backend, load.

Next. Q3. Walk the HLD — client layers, backend, load Answer. Same 4 layers as Day 01, but call out Task trees: parent screen task cancels on disappear; page fetch child; image loads detached with priority. LikeActor serializes per-post mutations. Repository async APIs; MainActor U I. Backend/load: unchanged — cursor pages, CDN images, TTL 5m. Follow-ups. G C D vs async?: Prefer structured concurrency for page lifecycle; G C D OK inside image decode pools.. Sendable feed models?: Value models across actors; no UIKit in domain..

## §3 Q4. Data / API — entities, endpoints, scale.

Next. Q4. Data / API — entities, endpoints, scale Answer. Same GET /v1/feed + POST like. Emphasize cancellation: ignore stale page if newer pull-to-refresh started (generation token). Follow-ups. Race two pages?: Generation token / task cancel — Day 05 race vocabulary.. Actor reentrancy?: Keep like actor work short; hop out for network..

## §4 Q5. Deep dive 1 — Structured concurrency for paging?

Next. Q5. Deep dive 1 — Structured concurrency for paging? Answer. async let / task group for parallel thumb prefetch of a page; cancel on scroll away. Don’t unstructured Task {} without tying to view lifetime. Follow-ups. Priority inversion?: Match QoS; avoid sync waits on main.. Prefetch actor?: Optional ImagePipeline actor — single flight URLs..

## §5 Q6. Deep dive 2 — Optimistic like actor?

Next. Q6. Deep dive 2 — Optimistic like actor? Answer. Actor owns in-flight like set; U I awaits result; rollback on throw. Offline queue as separate durable store — actor coordinates drain. Follow-ups. Many likes spam?: Coalesce toggle; last state wins to server.. MainActor isolation?: U I state on MainActor; network off..

## §6 Q7. Ops — failures, metrics, rollout, load?

Next. Q7. Ops — failures, metrics, rollout, load? Answer. Same feed ops + concurrency metrics: cancelled task rate, like actor wait time. Kill: disable parallel thumb prefetch under thermal. Follow-ups. Hang from await on main?: Never block main with sync network.. Day 21 link?: Same spine — deepen A P I/ops later..

## §7 Q8. Flow scorecard — did you hit the optimal spine?

Next. Q8. Flow scorecard — did you hit the optimal spine? Answer. Pass bar: clarify + agenda in ≤5; high level design shows 4 layers + backend + load; A P I has cursors/idempotency as needed; two deep dives; ops with kill switch and concrete metrics. Anti-patterns: offset pagination on dynamic feeds; main-thread SQLite/decode; inventing QPS as fact; never reaching ops; blob “architecture” with no data flow. Spine: 0–5 clarify · 5–15 high level design · 15–25 A P I · 25–40 dives · 40–45 ops. Follow-ups. Ran long on dive 1?: Park dive 2 bullets; protect ops 5 min.. Forgot load?: One sentence: daily active users → labeled QPS, cursor cost, single-flight.. Invented crash-free %?: Forbidden — use resume-backed numbers or label as target..
