# Audio script — Sample 05 — System-design mock: Server-Driven UI Engine (Q&A)
> Listen-only sample Q&A from `05-system-design-mock.md`. Spoken answers and follow-ups.

## §0 Q1. Interviewer: “Design Server-Driven UI Engine.” How do you open?

Next. Q1. Interviewer: “Design Server-Driven UI Engine.” How do you open? Answer. “I’ll take about five minutes clarifying scope and scale, then a four-layer client high level design with backend touchpoints and load, then A P I and data, two deep dives on ComponentRegistry and unknown types, and FallbackEngine and schema versioning, and close on failure modes, metrics, and kill switches. Does that work? Then I ask: which surfaces — home header style or entire app shell? daily active users and how often layouts refresh? Online-first with last-good disk cache, or offline-first? i O S-only? Unknown component policy — skip versus hard fail? Schema versioning — major mismatch force update? Out of scope: CMS admin U I and executing JS on device? I do not draw until they answer or I state labeled assumptions.” Follow-ups. Skip agenda?: “Weak senior signal — interviewer may want different dives.”. Clarify for 15 min?: “Hard stop at five — park extras as labeled assumptions.”. They refuse numbers?: “State labeled estimates from daily active users context; continue.”.

## §1 Q2. After clarify — what does the optimal flow look like?

Next. Q2. After clarify — what does the optimal flow look like? Answer. “Scripted outcomes for this mock: i O S S D U I for CMS-driven surfaces; online-first plus last-good cache; unknown goes to EmptyView; out of scope: CMS admin and client JS. Good flow: agenda, clarify questions, confirm, high level design with four layers plus backend plus load, A P I, two crisp dives, ops last five. Weak flow: silent drawing, happy-path only, no QPS or TTL, invent metrics, skip ops.” Follow-ups. They change scope mid-high level design?: “Re-confirm in/out in twenty seconds; adjust dives; protect ops.”. Backend mesh deep-dive?: “Out unless asked — sketch touchpoints, stay client-owned.”. Forgot to ask offline?: “State online-first plus last-good cache as assumption; invite correction.”.

## §2 Q3. Walk the HLD — client layers, backend, load.

Next. Q3. Walk the HLD — client layers, backend, load Answer. “Layers: Screen view controller or SwiftUI, S D U I ViewModel, Parser Registry LayoutResolver, Network plus FallbackEngine on disk. Backend: CMS to Layout A P I to CDN or gateway to client. Payload under about fifty KB gzip as a target. Load: refresh TTL for example thirty-six hundred seconds; stale-while-revalidate; don’t refetch every scroll frame. Parse under sixteen milliseconds to avoid hitch.” Follow-ups. Where is type safety?: “Registry maps string type to native builder; unknown types no-crash.”. Backend CMS?: “Out — you own client contract plus fallbacks.”.

## §3 Q4. Data / API — entities, endpoints, scale.

Next. Q4. Data / API — entities, endpoints, scale Answer. “GET /v1/screens/{screenId} with Client-Version and schema version headers. Tree of components: type, props, children, actions, analytics payload. Nested fetch_more for lists — don’t invent a full scripting language on device.” Follow-ups. Breaking schema?: “Major version bump; unsupported goes to cache or force-update screen.”. Payload too large?: “Split screens; field-mask; gzip; CDN.”.

## §4 Q5. Deep dive 1 — open ComponentRegistry & unknown-type fallback?

Next. Q5. Deep dive 1 — open ComponentRegistry & unknown-type fallback? Answer. “Dictionary from type string to AnyView or UIView builder. Missing type returns EmptyView and bumps metric unknown_component. Prefer protocol plus generics for prop decoding where possible — fail soft per node, not the whole tree. That’s the Day 02 parallel: open registry of typed factories, not a forever-closed enum that needs an app release for every CMS experiment. Never crash on unknown — skip the node, keep siblings.” Follow-ups. Crash on unknown?: “Never — skip node; keep siblings.”. P O P link?: “Registry as composition of typed factories — Day 02 vocabulary.”. Closed enum when?: “Stable tiny set; rare additions — not weekly CMS creatives.”.

## §5 Q6. Deep dive 2 — FallbackEngine & schema versioning?

Next. Q6. Deep dive 2 — FallbackEngine & schema versioning? Answer. “On success: write last-good JSON to disk. On network fail: serve disk — under fifty milliseconds as a target. Version gate: skip unsupported majors; remote kill switch returns native scaffold.” Follow-ups. Empty first launch offline?: “Native scaffold plus retry — don’t crash.”. Stale layout forever?: “TTL plus force-refresh path; show subtle stale if needed.”.

## §6 Q7. Ops — failures, metrics, rollout, load?

Next. Q7. Ops — failures, metrics, rollout, load? Answer. “Track schema_fetch_latency, cache_hit, unknown_component count, crash-free on S D U I surfaces — as targets or resume-backed numbers, not invented facts. Kill switch: remote config disables S D U I to native. Timeout goes to disk cache.” Follow-ups. Force update UX?: “Only on unsupported major — don’t brick minors.”. Relate production?: “Backend-driven header and Aces splash — design judgment plus verified hooks.”.

## §7 Q8. Flow scorecard — did you hit the optimal spine?

Next. Q8. Flow scorecard — did you hit the optimal spine? Answer. “Pass bar: clarify plus agenda in five minutes or less; high level design shows four layers plus backend plus load; A P I has cursors or idempotency as needed; two deep dives; ops with kill switch and concrete metrics. Anti-patterns: offset pagination on dynamic feeds; main-thread SQLite or decode; inventing QPS as fact; never reaching ops; blob architecture with no data flow. Spine: zero to five clarify, five to fifteen high level design, fifteen to twenty-five A P I, twenty-five to forty dives, forty to forty-five ops.” Follow-ups. Ran long on dive 1?: “Park dive 2 bullets; protect ops five minutes.”. Forgot load?: “One sentence: daily active users to labeled QPS, cursor cost, single-flight.”. Invented crash-free %?: “Forbidden — use resume-backed numbers or label as target.”.

## §8 Q9. Tie SDUI back to Day 02 Ads vocabulary in 20s

Next. Q9. Tie SDUI back to Day 02 Ads vocabulary in 20s Answer. “Ads day taught capability protocols and generics for a typed pipeline. S D U I’s ComponentRegistry is the same instinct at CMS scale — typed factories, open registration, unknown fallback instead of a fragile closed enum. I still keep Ads plus HeroWidget as the Day 02 production spine unless they asked for S D U I.” Follow-ups. Steal Ads credit?: “No — S D U I is the mock; Ads is the verified revenue story.”.
