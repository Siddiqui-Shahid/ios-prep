# Audio script — Sample 05 — System-design mock: Server-Driven UI Engine (Q&A)
> Listen-only sample Q&A from `05-system-design-mock.md`. Spoken answers and follow-ups.

## §0 Q1. Interviewer: “Design Server-Driven UI Engine.” How do you open?

Next. Q1. Interviewer: “Design Server-Driven UI Engine.” How do you open? Answer. Agenda (≤20s): “I’ll take ~5 minutes clarifying scope and scale, then a four-layer client high level design with backend touchpoints and load, then A P I/data, two deep dives on Schema versioning + unknown fallback and Action routing, and close on failure modes, metrics, and kill switches. Does that work?” Then ask the interviewer (speak these): 1. Home/header/splash surfaces vs whole app? 2. daily active users and layout refresh cadence? 3. Online-first + last-good cache? 4. Deep dives: schema versioning+fallback and action routing? 5. Out: CMS admin, JS execution? Do not draw until they answer or you state labeled assumptions. Keep backend load in mind from the first minute. Follow-ups. Skip agenda?: Weak senior signal — interviewer may want different dives.. Clarify for 15 min?: Hard stop at 5 — park extras as labeled assumptions.. They refuse numbers?: State labeled estimates from daily active users context; continue..

## §1 Q2. After clarify — what does the optimal flow look like?

Next. Q2. After clarify — what does the optimal flow look like? Answer. Scripted outcomes for this mock: S D U I engine client; schema versioning; FallbackEngine; ActionHandler; out: CMS/JS. Good flow: agenda → clarify Qs → confirm → high level design (4 layers + backend + load) → A P I → two crisp dives → ops last 5. Weak flow: silent drawing, happy-path only, no QPS/TTL, invent metrics, skip ops. Follow-ups. They change scope mid-high level design?: Re-confirm in/out in 20s; adjust dives; protect ops.. Backend mesh deep-dive?: Out unless asked — sketch touchpoints, stay client-owned.. Forgot to ask offline?: State online-first + last-good cache as assumption; invite correction..

## §2 Q3. Walk the HLD — client layers, backend, load?

Next. Q3. Walk the HLD — client layers, backend, load? Answer. CMS → Layout A P I/CDN → Network → Parser → Version check → Registry → LayoutResolver → SwiftUI/UIKit → ActionHandler + analytics. Load: <50KB gzip; parse <16ms; cache <50ms; refresh_ttl; stale-while-revalidate. Follow-ups. Native vs S D U I trade-off?: S D U I for CMS velocity; native for critical path performance.. Ads HeroWidget?: Protocolised native widgets can sit beside S D U I nodes..

## §3 Q4. Data / API — entities, endpoints, scale?

Next. Q4. Data / API — entities, endpoints, scale? Answer. Screen JSON tree; actions: deeplink, A P I, dismiss; analytics envelopes server-defined. Client-Version header; force-refresh query. Follow-ups. A/B layouts?: Server returns experiment component tree; client logs exposure.. Nested lists?: fetch_more contract — don’t boil pagination inside every node..

## §4 Q5. Deep dive 1 — Schema versioning + unknown fallback?

Next. Q5. Deep dive 1 — Schema versioning + unknown fallback? Answer. Major mismatch → force update or last-good. Unknown component → EmptyView + metric. Never crash parse of one bad node. Follow-ups. Partial tree fail?: Drop node; render rest.. Migration?: Additive props first; breaking = major..

## §5 Q6. Deep dive 2 — Action routing?

Next. Q6. Deep dive 2 — Action routing? Answer. ActionHandler routes deeplink/native/web; validates allowlist; fires analytics then navigate. Fail soft on unknown action type. Follow-ups. Open redirect?: Allowlist hosts/schemes.. Offline action?: Queue or disable with U I..

## §6 Q7. Ops — failures, metrics, rollout, load?

Next. Q7. Ops — failures, metrics, rollout, load? Answer. fetch latency, cache hit, unknown_component, crash-free. Kill → native scaffold. Follow-ups. Production?: BMS backend-driven header; Aces splash.. Day 21?: Reuse this spine in Mock #3..

## §7 Q8. Flow scorecard — did you hit the optimal spine?

Next. Q8. Flow scorecard — did you hit the optimal spine? Answer. Pass bar: clarify + agenda in ≤5; high level design shows 4 layers + backend + load; A P I has cursors/idempotency as needed; two deep dives; ops with kill switch and concrete metrics. Anti-patterns: offset pagination on dynamic feeds; main-thread SQLite/decode; inventing QPS as fact; never reaching ops; blob “architecture” with no data flow. Spine: 0–5 clarify · 5–15 high level design · 15–25 A P I · 25–40 dives · 40–45 ops. Follow-ups. Ran long on dive 1?: Park dive 2 bullets; protect ops 5 min.. Forgot load?: One sentence: daily active users → labeled QPS, cursor cost, single-flight.. Invented crash-free %?: Forbidden — use resume-backed numbers or label as target..
