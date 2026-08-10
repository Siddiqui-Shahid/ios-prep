# Audio script — Sample 01 — Deep links & Universal Links (Q&A)
> Listen-only sample Q&A from `01-deep-links.md`. Spoken answers and follow-ups.

## §0 Q1. Universal Links vs custom URL scheme — when which?

Next. Q1. Universal Links vs custom URL scheme — when which? Answer. Universal Links (https://): domain association via AASA — opens app when installed, falls back to web in Safari; more secure than schemes. Custom scheme (myapp://): easier setup but hijackable by other apps; fine for legacy/internal. Production consumer apps: prefer Universal Links for marketing and email links. Follow-ups. Why hijackable?: i O S doesn’t uniquely bind custom schemes to one app.. https in Notes app?: Universal Link if AASA valid; else Safari.. Both in one app?: Yes — route both through one router..

## §1 Q2. What is AASA, and what can go wrong?

Next. Q2. What is AASA, and what can go wrong? Answer. apple-app-site-association JSON at https://domain/.well-known/apple-app-site-association — lists appIDs (TEAMID.bundle) and paths. Must be HTTPS with correct content-type. CDN/OS caching can delay fixes after you deploy AASA changes. Size limits apply — keep file lean. Follow-ups. Link opens Safari not app?: Checklist: AASA reachable, appID, paths, entitlements, cache delay, user preference.. “i O S bug” first answer?: Trap — verify AASA and entitlements first.. Path excluded?: Link won’t open app even if domain matches..

## §2 Q3. Describe the deep link pipeline end-to-end?

Next. Q3. Describe the deep link pipeline end-to-end? Answer. https:// or myapp:// → Scene / onOpenURL → DeepLinkParser (validate, match) → typed AppRoute → AuthGate if needed → AppCoordinator.navigate OR PendingDeepLinkStore.enqueue if nav not ready. One table for every entrypoint. Follow-ups. Why typed enum route?: Parser produces AppRoute; coordinator doesn’t parse strings ad hoc.. Invalid link?: Safe home + metric — don’t crash on bad params.. Dual routers problem?: Push vs UL drift — checkout works from one, 404s from other..

## §3 Q4. What is the cold-start race, and how do you fix it?

Next. Q4. What is the cold-start race, and how do you fix it? Answer. Link arrives before DI, auth, or navigation stack is ready → don’t navigate into nil coordinator. Queue the parsed intent in PendingDeepLinkStore; flush when root U I and coordinator are warm. Invalid routes → home + log. Same pattern for deferred first-launch attribution. Follow-ups. Flush trigger?: Root view controller ready, session restored, coordinator injected.. Multiple queued links?: Policy: latest wins, or FIFO — state explicitly.. Push tap same queue?: Yes — same router mindset..

## §4 Q5. What security rules apply to URL parameters?

Next. Q5. What security rules apply to URL parameters? Answer. Validate params; auth-gate checkout and account routes; never trust URL for price or user authority — server is authoritative for cart/price. Ignore spoofed query prices. Confirm destructive actions. Deep links are intent, not proof of entitlement. Follow-ups. ?price=0.01 in link?: Display nothing until server confirms.. Logged-out checkout link?: Auth gate → login → resume queued route.. Open redirect in web fallback?: Sanitize web paths in AASA..

## §5 Q6. Hybrid SwiftUI/UIKit — what does routing need?

Next. Q6. Hybrid SwiftUI/UIKit — what does routing need? Answer. Coordinator owns stack identity — don’t bolt UIHostingController without lifecycle plan. Hybrid U I / deeplinks Grizzlies: SwiftUI surfaces hosted in UIKit (or reverse) with designed interop. Router targets coordinator APIs, not raw view controller class names scattered in features. Follow-ups. SwiftUI NavigationStack vs UIKit?: Pick ownership model; router stays above both.. State restoration?: Coordinator + route enum aids restore.. Hybrid U I / deeplinks one-liner?: “Deeplinks and Airship atop hybrid SwiftUI/UIKit navigation.”.

## §6 Q7. Deferred deep links — what to claim honestly?

Next. Q7. Deferred deep links — what to claim honestly? Answer. Post-install attribution: first launch fetches pending route with expiry (industry often ~days, not forever). Privacy and probabilistic matching limits — don’t overclaim certainty. Prefer first-party login then route when identity matters. Same router flushes when ready. Follow-ups. Forever pending route?: Bad — expire and fall back to home.. Branch/Adjust internals?: Know concept; don’t invent CTR %.. Organic install?: No deferred route — native onboarding..

## §7 Q8. “Two routers drifted” — tell it as a first-class failure story?

Next. Q8. “Two routers drifted” — tell it as a first-class failure story? Answer. Push and Universal Links are entrypoints only. One DeepLinkRouter and one AppRoute table own behavior. Duplication is how checkout works from a campaign banner and 404s from an https campaign — tables drifted. Symptom: marketing says “push works, links broken” (or the reverse). Fix: unify the routing table; modules register routes through interfaces (Day 15 modular thinking). Hybrid U I / deeplinks lesson: interop costs must be designed; routing is shared discipline. Follow-ups. Who owns the table?: App coordinator / routing module — not each feature switch.. Push payload?: Small route id or URL → same parser.. Test for drift?: Contract tests: same AppRoute from UL fixture and push fixture..

## §8 Q9. Marketing wants `myapp://` everywhere — how do you push back?

Next. Q9. Marketing wants `myapp://` everywhere — how do you push back? Answer. Prefer Universal Links for public campaigns and explain scheme hijack risk — i O S doesn’t uniquely bind custom schemes to one app. Offer schemes as a transitional legacy fallback and migrate campaigns gradually. On Grizzlies we lived in a practical mix while designing routing so either entrypoint still hit one table. Don’t refuse without options, and don’t accept hijack risk silently. Follow-ups. Internal deep links?: Schemes can be fine short-term if not public.. Email/SMS campaigns?: Prefer https UL for consumer trust + web fallback.. Same router either way?: Yes — scheme vs UL is entrypoint only (Hybrid U I / deeplinks)..
