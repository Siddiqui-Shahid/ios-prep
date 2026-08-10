# Audio script — Sample 02 — Push notifications (Q&A)
> Listen-only sample Q&A from `02-push-notifications.md`. Spoken answers and follow-ups.

## §0 Q1. Walk the push pipeline in order?

Next. Q1. Walk the push pipeline in order? Answer. Permission (contextual, not instant first launch) → register for remote notifications → APNs device token → upload to backend / Airship → campaign or transactional push → user tap → parse payload → same DeepLinkRouter as Universal Links. Foreground delivery uses different handlers but should still unify routing. Follow-ups. Airship vs APNs?: Airship is engagement layer on APNs — segments, journeys; you still know APNs.. Token every launch?: Tokens change; upsert server-side on each register.. Silent push as cron?: Limited wake budget — don’t rely..

## §1 Q2. Why must push and Universal Links share one router?

Next. Q2. Why must push and Universal Links share one router? Answer. Dual routers drift — campaign push opens checkout; https link 404s because tables diverged. Senior design: DeepLinkParser → AppRoute → Coordinator for UL, custom scheme, push tap, Spotlight optional. Hybrid U I / deeplinks lesson: interop costs must be designed; routing is shared discipline. Follow-ups. Payload carries what?: Small route id or URL — not full U I state.. Category actions?: Also map to AppRoute — same table.. Mixpanel in push path?: Analytics on screen event after route — complementary to Airship..

## §2 Q3. When should you ask for notification permission?

Next. Q3. When should you ask for notification permission? Answer. Contextual timing — after user sees value (e.g. “notify me when tickets drop”), not instant first launch. Higher opt-in and better product trust. Pre-permission education screen optional. Never assume permission granted — handle denied gracefully. Follow-ups. Provisional authorization?: Quiet delivery on i O S — know it exists; product decision.. Re-prompt after deny?: Settings deep link — can’t re-show system dialog.. Invent opt-in %?: Forbidden — don’t fabricate Hybrid U I / deeplinks metrics..

## §3 Q4. How do you handle APNs token lifecycle?

Next. Q4. How do you handle APNs token lifecycle? Answer. Register on launch; upload token to provider (Airship/backend). On reinstall/OS update token may change — invalidate old server-side. Handle 410 Unregistered from provider — remove stale token from DB. Defensive: missing token ≠ crash. Follow-ups. Simulator push?: Limited; device testing for real flows.. Multiple devices per user?: Store many tokens per account.. Logout?: Unregister or invalidate token server-side..

## §4 Q5. What goes in the push payload, and how to decode safely?

Next. Q5. What goes in the push payload, and how to decode safely? Answer. Keep payload small — route id, deep link URL, collapse id, category. Defensive decode — malformed JSON must not crash app (protect crash free sessions). On failure: safe home + metric. Rich media via Notification Service Extension — watch memory budgets. Follow-ups. Collapse id?: Replace related notifications — avoid spam stack.. Foreground presentation?: willPresent — decide banner/list/sound.. Full cart in payload?: Bad — route only; fetch server state..

## §5 Q6. Airship vs Mixpanel in the Grizzlies stack?

Next. Q6. Airship vs Mixpanel in the Grizzlies stack? Answer. Airship: push delivery, segments, engagement campaigns — Hybrid U I / deeplinks integration. Mixpanel: product analytics, funnel events — also Hybrid U I / deeplinks. Complementary, not synonyms. Push tap → router → screen → Mixpanel event. Don’t claim you “built Airship.” Follow-ups. Hybrid U I / deeplinks ≤20s line?: “Deeplinks and Airship push atop hybrid SwiftUI/UIKit, Mixpanel for analytics.”. Attribution in Airship?: Engagement; Mixpanel for in-app behavior — both can inform growth.. One vendor for all?: Possible but know layered responsibilities..

## §6 Q7. Push failure modes and senior responses?

Next. Q7. Push failure modes and senior responses? Answer. | Failure | Response | Push JSON crash: Defensive parse → home. Dual routers drifted: Unify routing table. Token stale: 410 handling, re-register. Rich image OOM: Extension memory limits, downsample. Campaign works, UL broken | Same root cause often — router/AASA — fix holistically | Follow-ups. crash free sessions drop after push feature?: Pause rollout — I M O C (BookMyShow I M O C + crash-free at scale). Test push E2E?: Device + sandbox/prod cert match. Next topic?: CI/CD — 03-ci-cd-actions.md.
