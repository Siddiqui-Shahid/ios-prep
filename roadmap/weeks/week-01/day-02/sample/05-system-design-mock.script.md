# Audio script — Sample 05 — System-design mock: Server-Driven UI Engine (Q&A)
> Listen-only sample Q&A from `05-system-design-mock.md`. Spoken answers and follow-ups.

## §0 Q1. Interviewer: “Design Server-Driven UI Engine.” How do you open?

Next. Q1. Interviewer: “Design Server-Driven UI Engine.” How do you open? Answer. Agenda (≤20s): “I’ll take ~5 minutes clarifying scope and scale, then a four-layer client high level design with backend touchpoints and load, then A P I/data, two deep dives on ComponentRegistry & unknown types and FallbackEngine & schema versioning, and close on failure modes, metrics, and kill switches. Does that work?” Then ask the interviewer (speak these): 1. Which surfaces — home header/splash-style screens, or entire app shell? 2. daily active users / how often layouts refresh from CMS? 3. Online-first with last-good disk cache, or offline-first? 4. i O S-only? 5. Unknown component policy — skip vs hard fail? 6. Schema versioning — major mismatch force update? 7. Out of scope: CMS admin U I and executing JS on device? Do not draw until they answer or you state labeled assumptions. Keep backend load in mind from the first minute. Follow-ups. Skip agenda?: Weak senior signal — interviewer may want different dives.. Clarify for 15 min?: Hard stop at 5 — park extras as labeled assumptions.. They refuse numbers?: State labeled estimates from daily active users context; continue..

## §1 Q2. After clarify — what does the optimal flow look like?

Next. Q2. After clarify — what does the optimal flow look like? Answer. Scripted outcomes for this mock: i O S S D U I for CMS-driven surfaces; online-first + last-good cache; unknown → EmptyView; out: CMS admin, client JS. Good flow: agenda → clarify Qs → confirm → high level design (4 layers + backend + load) → A P I → two crisp dives → ops last 5. Weak flow: silent drawing, happy-path only, no QPS/TTL, invent metrics, skip ops. Follow-ups. They change scope mid-high level design?: Re-confirm in/out in 20s; adjust dives; protect ops.. Backend mesh deep-dive?: Out unless asked — sketch touchpoints, stay client-owned.. Forgot to ask offline?: State online-first + last-good cache as assumption; invite correction..

## §2 Q3. Walk the HLD — client layers, backend, load.

Next. Q3. Walk the HLD — client layers, backend, load Answer. Layers: Screen view controller/SwiftUI → S D U I ViewModel → Parser/Registry/LayoutResolver → Network + FallbackEngine disk. Backend: CMS → Layout A P I → CDN/gateway → client. Payload <50KB gzip target. Load: refresh_ttl e.g. 3600s; stale-while-revalidate; don’t refetch every scroll frame. Parse <16ms to avoid hitch. Follow-ups. Where is type safety?: Registry maps string type → native builder; unknown types no-crash.. Backend CMS?: Out — you own client contract + fallbacks..

## §3 Q4. Data / API — entities, endpoints, scale.

Next. Q4. Data / API — entities, endpoints, scale Answer. GET /v1/screens/{screenId} with Client-Version / schema version headers. Tree of components: type, props, children, actions, analytics payload. Nested fetch_more for lists — don’t invent a full scripting language. Follow-ups. Breaking schema?: Major version bump; unsupported → cache or force-update screen.. Payload too large?: Split screens; field-mask; gzip; CDN..

## §4 Q5. Deep dive 1 — ComponentRegistry & unknown types?

Next. Q5. Deep dive 1 — ComponentRegistry & unknown types? Answer. Dictionary type → AnyView/UIView builder. Missing type → EmptyView + metric unknown_component. Prefer protocol + generics for prop decoding where possible — fail soft per node, not whole tree. Follow-ups. Crash on unknown?: Never — skip node; keep siblings.. P O P link?: Registry as composition of typed factories — Day 02 vocabulary..

## §5 Q6. Deep dive 2 — FallbackEngine & schema versioning?

Next. Q6. Deep dive 2 — FallbackEngine & schema versioning? Answer. On success: write last-good JSON to disk. On network fail: serve disk (<50ms target). Version gate: skip unsupported majors; remote kill switch → native scaffold. Follow-ups. Empty first launch offline?: Native scaffold + retry — don’t crash.. Stale layout forever?: TTL + force-refresh path; show subtle stale if needed..

## §6 Q7. Ops — failures, metrics, rollout, load?

Next. Q7. Ops — failures, metrics, rollout, load? Answer. schema_fetch_latency, cache_hit, unknown_component count, crash-free on S D U I surfaces. Kill switch: remote config disables S D U I → native. Timeout → disk cache. Follow-ups. Force update UX?: Only on unsupported major — don’t brick minors.. Relate production?: BookMyShow backend-driven header & search / Aces splash — design judgment + verified hooks..

## §7 Q8. Flow scorecard — did you hit the optimal spine?

Next. Q8. Flow scorecard — did you hit the optimal spine? Answer. Pass bar: clarify + agenda in ≤5; high level design shows 4 layers + backend + load; A P I has cursors/idempotency as needed; two deep dives; ops with kill switch and concrete metrics. Anti-patterns: offset pagination on dynamic feeds; main-thread SQLite/decode; inventing QPS as fact; never reaching ops; blob “architecture” with no data flow. Spine: 0–5 clarify · 5–15 high level design · 15–25 A P I · 25–40 dives · 40–45 ops. Follow-ups. Ran long on dive 1?: Park dive 2 bullets; protect ops 5 min.. Forgot load?: One sentence: daily active users → labeled QPS, cursor cost, single-flight.. Invented crash-free %?: Forbidden — use resume-backed numbers or label as target..
