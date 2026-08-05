# Audio script — Sample 02 — Clarify phase (Q&A)
> Listen-only sample Q&A from `02-clarify-phase.md`. Spoken answers and follow-ups.

## §0 Q1. How do you start any mobile SD interview?

Next. Q1. How do you start any mobile SD interview? Answer. Propose a timed agenda — clarify, high level design, A P I, two deep dives, ops — confirm it matches what they want. Then ask scale, offline, explicit out-of-scope. Drawing silently without a plan is how seniors look junior. Target ≤5 minutes for clarify. Follow-ups. Skip confirm step?: Weak — interviewer may want different dives.. Clarify for 15 min?: Fails structure rubric — timebox ruthlessly.. Solo practice?: Speak agenda aloud; timer 5 min..

## §1 Q2. What scale numbers can you use honestly?

Next. Q2. What scale numbers can you use honestly? Answer. 30+ lakh daily active users when BMS-like consumer context — from resume. 99.95%+ crash free sessions as ops constraint when rollout discussed (S 8). Don’t invent precise QPS. If forced to estimate, label assumptions transparently from daily active users and session length — never fake precision as fact. Follow-ups. “What’s your QPS?” never measured: Offer daily active users; labeled estimate; refocus on client arch — T2 in 04.. Journey metrics?: p50/p90 from S5 — listing, checkout, search instrumented.. Fabricate drop-off %?: Forbidden — resume-only metrics..

## §2 Q3. What do you cut from scope by default?

Next. Q3. What do you cut from scope by default? Answer. Default out of scope unless interviewer pulls you in: web CMS admin, Android parity, ML ranking, pixel-perfect design-tool export, arbitrary script execution on device. Platform: i O S (SwiftUI/UIKit as relevant). State cuts explicitly — scope negotiation is senior signal. Follow-ups. They want Android notes?: 5-min parity bullets — don’t boil both oceans.. Backend service mesh?: Out for networking mock unless asked — client focus.. Admin CMS for S D U I?: Out — you design client engine, not editorial U I..

## §3 Q4. SDUI clarify script — what do you say?

Next. Q4. SDUI clarify script — what do you say? Answer. “I’ll design an i O S server-driven U I engine for CMS-driven home surfaces — header, splash-style screens — not full web admin. Scale: ~30L daily active users context. Assume online-first with last-good cache unless you want offline-first. Deep dives: schema versioning + unknown-component fallback and action routing. Ops with flags and crash-free pause. Does that match?” Follow-ups. Offline-first requested?: Adjust — cache TTL, native scaffold on empty first launch.. Which deep dives swap?: Caching/freshness or image pipeline if media-heavy — timebox judgment.. Provenance in clarify?: Light hooks OK — S3 header/search, S12 splash family..

## §4 Q5. Networking + pinning clarify script?

Next. Q5. Networking + pinning clarify script? Answer. “I’ll design a first-party networking layer with auth and SSL pinning for high-traffic consumer APIs — ads/checkout-adjacent. Scale: 30L+ daily active users. Out of scope: full backend mesh, Android. Deep dives: single-flight token refresh and SPKI pinning with rotation as design. Close on p50/p90 observability. Match?” Follow-ups. Alamofire?: Prefer URLSession when owning trust — S4 Ads migration proof.. Pin all hosts?: No — allowlisted sensitive hosts only.. S4-A1 in clarify?: Mention rotation as design — not shipped runbook..

## §5 Q6. What do you ask about offline during clarify?

Next. Q6. What do you ask about offline during clarify? Answer. Ask in clarify — don’t assume. Default: last-good layout cache with TTL and stale-while-revalidate; native scaffold if cache empty on first launch. Splash can be server-driven for freshness without blocking forever. Networking mock: offline queue + reachability — idempotency on POSTs. Follow-ups. Offline-first product?: Stronger disk cache, sync strategy — still timebox.. White screen on decode fail?: Refuse — partial render + fallback metric.. Charge POST offline?: Queue with idempotency keys — S 7 intent..

## §6 Q7. How is clarify scored?

Next. Q7. How is clarify scored? Answer. Excellent (15 pts): states plan aloud; asks scale/offline/in-out; gets yes before drawing; ≤5 min. Weak: silent boxing or clarifying fifteen minutes. Structure layer — combined with high level design, A P I, dives, ops for ≥70 pass with ops ≥6/10. Follow-ups. Mock partner silent?: Checkpoint — “Does this agenda work?” — T8.. Jump to diagram early?: Ask permission — agenda first.. Next topic?: Cache & scroll — 03-cache-scroll.md.. Next: 03-cache-scroll.md.
