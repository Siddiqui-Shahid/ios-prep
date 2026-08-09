# Audio script — Sample 05 — System-design mock: Deep Linking & Universal Links (Q&A)
> Listen-only sample Q&A from `05-system-design-mock.md`. Spoken answers and follow-ups.

## §0 Q1. Interviewer: “Design Deep Linking & Universal Links.” How do you open?

Next. Q1. Interviewer: “Design Deep Linking & Universal Links.” How do you open? Answer. Agenda (≤20s): “I’ll take ~5 minutes clarifying scope and scale, then a four-layer client high level design with backend touchpoints and load, then A P I/data, two deep dives on Router + Coordinator and Deferred + cold-start queue, and close on failure modes, metrics, and kill switches. Does that work?” Then ask the interviewer (speak these): 1. Universal Links + custom schemes both? 2. Deferred links after install? 3. Cold-start queue required? 4. Auth-gated routes? 5. Out: push payload design, Android App Links? Do not draw until they answer or you state labeled assumptions. Keep backend load in mind from the first minute. Follow-ups. Skip agenda?: Weak senior signal — interviewer may want different dives.. Clarify for 15 min?: Hard stop at 5 — park extras as labeled assumptions.. They refuse numbers?: State labeled estimates from daily active users context; continue..

## §1 Q2. After clarify — what does the optimal flow look like?

Next. Q2. After clarify — what does the optimal flow look like? Answer. Scripted outcomes for this mock: UL + schemes; router+coordinator; cold-start pendingRoute; deferred optional; out: push deep design. Good flow: agenda → clarify Qs → confirm → high level design (4 layers + backend + load) → A P I → two crisp dives → ops last 5. Weak flow: silent drawing, happy-path only, no QPS/TTL, invent metrics, skip ops. Follow-ups. They change scope mid-high level design?: Re-confirm in/out in 20s; adjust dives; protect ops.. Backend mesh deep-dive?: Out unless asked — sketch touchpoints, stay client-owned.. Forgot to ask offline?: State online-first + last-good cache as assumption; invite correction..

## §2 Q3. Walk the HLD — client layers, backend, load.

Next. Q3. Walk the HLD — client layers, backend, load Answer. OS openURL → AppDelegate/Scene → DeepLinkRouter match → Coordinator navigate. If U I not ready (<500ms), queue pendingRoute. Backend: AASA hosted; deferred fingerprint A P I. Load: AASA <128KB; OS caches ~24h; routing <100ms target. Follow-ups. Hybrid UIKit/SwiftUI?: One router owns path — Grizzlies interop lesson.. Push vs deeplink?: Same router — don’t fork navigation..

## §3 Q4. Data / API — entities, endpoints, scale.

Next. Q4. Data / API — entities, endpoints, scale Answer. AASA at /.well-known/apple-app-site-association. GET /v1/deep-link/deferred?fingerprint=. Route table: pattern → builder. Follow-ups. Unsigned links?: Validate path allowlist; strip dangerous query.. AASA fail?: Smart Banner / custom scheme fallback..

## §4 Q5. Deep dive 1 — Router + Coordinator?

Next. Q5. Deep dive 1 — Router + Coordinator? Answer. Parse URL → typed Route → Coordinator presents. Unknown route → metric + home fallback. Follow-ups. Auth wall?: Queue route post-login.. Multiple windows?: Scene-aware routing..

## §5 Q6. Deep dive 2 — Deferred + cold-start queue?

Next. Q6. Deep dive 2 — Deferred + cold-start queue? Answer. Pending route until root ready; deferred match within ~72h; fail → organic open. Follow-ups. Race login?: Hold route until session.. Hijack?: HTTPS UL preferred over custom schemes..

## §6 Q7. Ops — failures, metrics, rollout, load?

Next. Q7. Ops — failures, metrics, rollout, load? Answer. Open rate, unknown route %, routing latency. Kill: disable deferred; UL only. Follow-ups. Production?: Hybrid U I / deeplinks Verified — Grizzlies.. Mixpanel/Airship?: Push taps through same router..

## §7 Q8. Flow scorecard — did you hit the optimal spine?

Next. Q8. Flow scorecard — did you hit the optimal spine? Answer. Pass bar: clarify + agenda in ≤5; high level design shows 4 layers + backend + load; A P I has cursors/idempotency as needed; two deep dives; ops with kill switch and concrete metrics. Anti-patterns: offset pagination on dynamic feeds; main-thread SQLite/decode; inventing QPS as fact; never reaching ops; blob “architecture” with no data flow. Spine: 0–5 clarify · 5–15 high level design · 15–25 A P I · 25–40 dives · 40–45 ops. Follow-ups. Ran long on dive 1?: Park dive 2 bullets; protect ops 5 min.. Forgot load?: One sentence: daily active users → labeled QPS, cursor cost, single-flight.. Invented crash-free %?: Forbidden — use resume-backed numbers or label as target..
