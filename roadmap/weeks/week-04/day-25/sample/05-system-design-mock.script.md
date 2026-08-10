# Audio script — Sample 05 — System-design mock: E-Commerce Catalog & Discovery (Q&A)
> Listen-only sample Q&A from `05-system-design-mock.md`. Spoken answers and follow-ups.

## §0 Q1. Interviewer: “Design E-Commerce Catalog & Discovery.” How do you open?

Next. Q1. Interviewer: “Design E-Commerce Catalog & Discovery.” How do you open? Answer. Agenda (≤20s): “I’ll take ~5 minutes clarifying scope and scale, then a four-layer client high level design with backend touchpoints and load, then A P I/data, two deep dives on Image grid + prefetch and Optimistic cart offline, and close on failure modes, metrics, and kill switches. Does that work?” Then ask the interviewer (speak these): 1. Image grid catalog + search + cart/wishlist? 2. Checkout/payments out? 3. Cursor pagination + 70% prefetch? 4. Offline cart queue? 5. ETag prices? Do not draw until they answer or you state labeled assumptions. Keep backend load in mind from the first minute. Follow-ups. Skip agenda?: Weak senior signal — interviewer may want different dives.. Clarify for 15 min?: Hard stop at 5 — park extras as labeled assumptions.. They refuse numbers?: State labeled estimates from daily active users context; continue..

## §1 Q2. After clarify — what does the optimal flow look like?

Next. Q2. After clarify — what does the optimal flow look like? Answer. Scripted outcomes for this mock: Catalog grid; image pipeline; cursor; search debounce; optimistic cart; out: checkout payments (sister). Good flow: agenda → clarify Qs → confirm → high level design (4 layers + backend + load) → A P I → two crisp dives → ops last 5. Weak flow: silent drawing, happy-path only, no QPS/TTL, invent metrics, skip ops. Follow-ups. They change scope mid-high level design?: Re-confirm in/out in 20s; adjust dives; protect ops.. Backend mesh deep-dive?: Out unless asked — sketch touchpoints, stay client-owned.. Forgot to ask offline?: State online-first + last-good cache as assumption; invite correction..

## §2 Q3. Walk the HLD — client layers, backend, load?

Next. Q3. Walk the HLD — client layers, backend, load? Answer. Catalog U I → VM → CatalogRepo (network+cache) + ImagePipeline + CartQueue. Backend: Catalog A P I + CDN; cart sync; ETag 304. Load: limit 20; debounce 300ms; L1 images ~50MB; thumbs 50–100KB WebP. Follow-ups. Brief B S D U I?: Different machine brief — don’t build both in 3h.. Diffable?: Stable product ids..

## §3 Q4. Data / API — entities, endpoints, scale?

Next. Q4. Data / API — entities, endpoints, scale? Answer. GET /v1/catalog?cursor=&limit=20&category=&sort= ; POST /v1/cart/items ; search with debounce. Follow-ups. Stale price?: ETag/If-None-Match; invalidate on focus.. Page fail?: Inline retry; keep list..

## §4 Q5. Deep dive 1 — Image grid + prefetch?

Next. Q5. Deep dive 1 — Image grid + prefetch? Answer. Downsample; prefetch next page at 70%; cancel reuse — machine-round vertical slice. Follow-ups. Memory?: Cost cache; warning clears L1.. 120Hz?: Prefer frames — avoid main decode..

## §5 Q6. Deep dive 2 — Optimistic cart offline?

Next. Q6. Deep dive 2 — Optimistic cart offline? Answer. Local queue; sync when online; conflict merge; don’t pretend payment. Follow-ups. Payment asked?: Defer to payment-checkout prompt.. Wishlist?: Same offline queue pattern..

## §6 Q7. Ops — failures, metrics, rollout, load?

Next. Q7. Ops — failures, metrics, rollout, load? Answer. scroll_hitch, image_cache_hit, search_latency, cart_add_success. Kill: disable prefetch. Follow-ups. Debrief bridge?: ≤20s S D U I/list UX contracts — Day 25 debrief.. Invent GMV?: Forbidden..

## §7 Q8. Flow scorecard — did you hit the optimal spine?

Next. Q8. Flow scorecard — did you hit the optimal spine? Answer. Pass bar: clarify + agenda in ≤5; high level design shows 4 layers + backend + load; A P I has cursors/idempotency as needed; two deep dives; ops with kill switch and concrete metrics. Anti-patterns: offset pagination on dynamic feeds; main-thread SQLite/decode; inventing QPS as fact; never reaching ops; blob “architecture” with no data flow. Spine: 0–5 clarify · 5–15 high level design · 15–25 A P I · 25–40 dives · 40–45 ops. Follow-ups. Ran long on dive 1?: Park dive 2 bullets; protect ops 5 min.. Forgot load?: One sentence: daily active users → labeled QPS, cursor cost, single-flight.. Invented crash-free %?: Forbidden — use resume-backed numbers or label as target..
