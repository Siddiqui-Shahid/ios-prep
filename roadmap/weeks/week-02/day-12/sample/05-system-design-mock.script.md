# Audio script — Sample 05 — System-design mock: Short-form Video Feed (Q&A)
> Listen-only sample Q&A from `05-system-design-mock.md`. Spoken answers and follow-ups.

## §0 Q1. Interviewer: “Design Short-form Video Feed.” How do you open?

Next. Q1. Interviewer: “Design Short-form Video Feed.” How do you open? Answer. Agenda (≤20s): “I’ll take ~5 minutes clarifying scope and scale, then a four-layer client high level design with backend touchpoints and load, then A P I/data, two deep dives on AVPlayerPool sliding window and Prefetch + ABR, and close on failure modes, metrics, and kill switches. Does that work?” Then ask the interviewer (speak these): 1. Short-form vertical feed — record/upload out? 2. daily active users and bitrate caps on cellular? 3. AVPlayer pool size (e.g. 3)? 4. Low Power / thermal guards? 5. Cursor pagination OK? Do not draw until they answer or you state labeled assumptions. Keep backend load in mind from the first minute. Follow-ups. Skip agenda?: Weak senior signal — interviewer may want different dives.. Clarify for 15 min?: Hard stop at 5 — park extras as labeled assumptions.. They refuse numbers?: State labeled estimates from daily active users context; continue..

## §1 Q2. After clarify — what does the optimal flow look like?

Next. Q2. After clarify — what does the optimal flow look like? Answer. Scripted outcomes for this mock: 3-player pool; prefetch ~80%; ABR + Low Power; cursor feed; out: upload/transcode. Good flow: agenda → clarify Qs → confirm → high level design (4 layers + backend + load) → A P I → two crisp dives → ops last 5. Weak flow: silent drawing, happy-path only, no QPS/TTL, invent metrics, skip ops. Follow-ups. They change scope mid-high level design?: Re-confirm in/out in 20s; adjust dives; protect ops.. Backend mesh deep-dive?: Out unless asked — sketch touchpoints, stay client-owned.. Forgot to ask offline?: State online-first + last-good cache as assumption; invite correction..

## §2 Q3. Walk the HLD — client layers, backend, load.

Next. Q3. Walk the HLD — client layers, backend, load Answer. Feed VM → page cursor → AVPlayerPool (prev/current/next) → Video CDN. Thumb pipeline separate. Backend: Feed service + Redis; Video CDN. Load: limit 10; JSON <15KB; ~15MB/player; memory <150MB; TTFF <300ms target. Follow-ups. Why pool?: Avoid alloc/teardown hitch each swipe.. SwiftUI identity?: Stable IDs for cells; don’t recreate players on identity churn..

## §3 Q4. Data / API — entities, endpoints, scale.

Next. Q4. Data / API — entities, endpoints, scale Answer. GET /v1/feed?cursor=&limit=10 with stream URLs + thumb. Optional X-Network-Quality. Follow-ups. Tokenized CDN URLs?: Refresh before expiry; don’t log secrets.. Prefetch bytes?: One ahead; not entire catalog..

## §4 Q5. Deep dive 1 — AVPlayerPool sliding window?

Next. Q5. Deep dive 1 — AVPlayerPool sliding window? Answer. Keep prev/current/next; on swipe recycle farthest; pause offscreen. OOM → empty pool. Follow-ups. Cell reuse?: Detach player; clear; generation token.. Background?: Pause all; release some..

## §5 Q6. Deep dive 2 — Prefetch + ABR?

Next. Q6. Deep dive 2 — Prefetch + ABR? Answer. PrefetchEngine at ~80% progress; NWPathMonitor drops to 240p (~200Kbps) on poor path; Low Power disables prefetch. Follow-ups. Stall metric?: <1% views target; drop quality.. Audio session?: Mix/duck policy explicit..

## §6 Q7. Ops — failures, metrics, rollout, load?

Next. Q7. Ops — failures, metrics, rollout, load? Answer. TTFF, stall rate, thumb cache 95%, memory. Kill: force 240p; disable autoplay. Follow-ups. HeroWidget pause?: Same disappear/offscreen pause contract.. Stories S D K?: List identity + media lifecycle..

## §7 Q8. Flow scorecard — did you hit the optimal spine?

Next. Q8. Flow scorecard — did you hit the optimal spine? Answer. Pass bar: clarify + agenda in ≤5; high level design shows 4 layers + backend + load; A P I has cursors/idempotency as needed; two deep dives; ops with kill switch and concrete metrics. Anti-patterns: offset pagination on dynamic feeds; main-thread SQLite/decode; inventing QPS as fact; never reaching ops; blob “architecture” with no data flow. Spine: 0–5 clarify · 5–15 high level design · 15–25 A P I · 25–40 dives · 40–45 ops. Follow-ups. Ran long on dive 1?: Park dive 2 bullets; protect ops 5 min.. Forgot load?: One sentence: daily active users → labeled QPS, cursor cost, single-flight.. Invented crash-free %?: Forbidden — use resume-backed numbers or label as target..
