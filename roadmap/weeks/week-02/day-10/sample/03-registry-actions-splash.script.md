# Audio script — Sample 03 — Registry, actions, and cold start (Q&A)
> Listen-only sample Q&A from `03-registry-actions-splash.md`. Spoken answers and follow-ups.

## §0 Q1. What are the design rules for a ComponentRegistry?

Next. Q1. What are the design rules for a ComponentRegistry? Answer. (1) Fail soft on unknown — never crash on CMS type strings. (2) Validate known props strictly — bad props on a known type: skip node or safe defaults — pick one policy and stay consistent. (3) Stable identity — server id on nodes for SwiftUI identity and analytics. (4) Keep leaves dumb — registry returns views; ViewModel owns payload lifecycle. (5) Ownership — app-specific header components in app module; shared primitives in U I kit with clear public A P I (S 10 S D K lesson). Follow-ups. Example skip in tree?: sparkle_v9 skipped; logo + promoBanner still render.. fatalError in factory?: Forbidden — skip + metric instead.. See code?: ComponentRegistry.swift learning-lab..

## §1 Q2. How do allowlisted actions work?

Next. Q2. How do allowlisted actions work? Answer. Server sends action: { type, payload }. ActionHandler checks type against allowlist — unknown types: metric + no-op, no crash. Known types validate payload: deeplink schemes for open_deeplink, HTTPS + domain policy for open_url, refresh triggers re-fetch. Never execute custom_js or arbitrary scripts. Auth-sensitive actions re-check client-side. Tie to Day 09 whitelist mindset for URLs that leave the app. Follow-ups. Metric for bad action?: sdui_unknown_action.. open_deeplink?: App schemes only; router owns nav (S13).. Analytics in CMS payload?: Validate event names; refuse unchecked PII from CMS..

## §2 Q3. What is BMS-style header component inventory thinking?

Next. Q3. What is BMS-style header component inventory thinking? Answer. Types like logo, citySelector, promoBanner, searchEntry, navIcons map to native responsibilities. Skip impact varies: missing logo at root is high — may trigger hard fallback; promoBanner skip is low. searchEntry skip medium — provide native default search affordance. Verified S3: protocol-driven generalised main-screen header from backend/CMS so many layout/content changes skip App Store — registry + fail-soft is how that stays crash-safe. Follow-ups. Search M V V M sibling?: Day 08 — debounce/cancel on search surface; header is S D U I beat.. New component type?: App release to register — CMS can’t invent native types without client.. Limits of S D U I?: Not infinite flexibility — types need client support..

## §3 Q4. What is the Aces splash cold-start checklist?

Next. Q4. What is the Aces splash cold-start checklist? Answer. Verified S12: server-driven splash for cold-start flexibility/freshness alongside audio streaming — no invented milliseconds. Design checklist: prewarm/read disk cache on launch; network fetch with short timeout → default if slow; minimum viable tree (logo/brand) if partial skip; don’t serialize audio init and splash network on one blocking main-thread chain; measure time-to-interactive, not only first frame. Startup is a product surface — cached splash with timeout-to-default beats blocking on perfection. Follow-ups. Metric sdui_splash_source?: cache \. Seasonal art unknown type?: Skip skippable art; keep brand minimum.. Legal/age gate?: Prefer native if product-required..

## §4 Q5. How do analytics work safely in SDUI payloads?

Next. Q5. How do analytics work safely in SDUI payloads? Answer. Server may attach analytics: { event, params }. Client validates event names against allowlist or prefix rules, injects common context (screen, app version, bucket), and refuses unchecked PII from CMS. Don’t treat CMS as a raw logging pipe — same discipline as network logging (no secrets/PII dumps). Unknown analytics keys should fail safe, not crash. Follow-ups. Trust CMS for event names?: No — allowlist or prefix validation.. Skip metrics vs analytics?: sdui_unknown_component is ops signal; product analytics still gated.. Double logging?: Inject context once — avoid duplicate fire on re-render..

## §5 Q6. How does SDUI relate to feature flags and A/B?

Next. Q6. How does SDUI relate to feature flags and A/B? Answer. Feature flag: toggles code path on/off. A/B: assigns variant bucket. S D U I: layout/content via payload. Often combined: flag enables S D U I surface; CMS/A/B supplies variant layout. Parity across i O S/Android needs shared schema spec, capability negotiation, contract tests per registry, and server targeting — don’t send i O S-only types to old Android builds blindly. Follow-ups. Kill switch?: Feature flag back to native default — part of S3-A1 design.. Canary payload?: % expose new schema before full rollout.. Contract tests in CI?: Catch platform drift early..

## §6 Q7. What performance notes matter for SDUI on iOS?

Next. Q7. What performance notes matter for SDUI on iOS? Answer. Parse off main when payloads grow. Budget interaction frames; prewarm splash cache on launch path. Incremental render if tree is large. Image props still use bounded image pipeline — S D U I doesn’t bypass Week 3 perf rules. Parser-on-main dropping frames is an NFR bug, not “JSON’s fault.” Splash prioritizes fast safe paint over perfect freshness when network is slow. Follow-ups. Empty splash after slow network?: Timeout → baked default — never infinite spinner on launch.. Large header tree?: Incremental render or flatten where product allows.. Whiteboard script?: Schema → gate → registry → actions → fallback; map BMS + Aces.. Next: 04-production-s3-s12.md.
