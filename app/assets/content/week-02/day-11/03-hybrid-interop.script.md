# Audio script — Sample 03 — Hybrid UIKit ↔ SwiftUI (Q&A)
> Listen-only sample Q&A from `03-hybrid-interop.md`. Spoken answers and follow-ups.

## §0 Q1. How do you embed SwiftUI inside UIKit?

Next. Q1. How do you embed SwiftUI inside UIKit? Answer. Use UIHostingController as a child view controller. Correct containment: addChild(hosting), add hosting.view with constraints, hosting.didMove(toParent:). On remove: willMove, remove view, removeFromParent. Pass observable models; do not rebuild the hosting view controller on every bind. Parent appear/disappear should inform pause policies for nested players. Follow-ups. Skipping containment breaks what?: Rotation, safe area, appearance forwarding.. Sizing fights?: Constraints, intrinsic content, sizingOptions awareness — test on notched devices.. State churn?: Rebuilding hosting view controller every bind → identity and lifecycle bugs..

## §1 Q2. How do you embed UIKit inside SwiftUI?

Next. Q2. How do you embed UIKit inside SwiftUI? Answer. Use UIViewControllerRepresentable or UIViewRepresentable. make creates once; update pushes new props — do not recreate the UIKit object every SwiftUI pass. Use a Coordinator for delegates and target-action. Avoid parent.id churn that triggers make storms. Do not let a representable silently own a second navigation stack. Follow-ups. update storm symptoms?: Jank, players restart, delegate spam.. Fixes?: Reduce observed state, stable identity, Equatable inputs where measured useful (Day 12).. Coordinator role?: Glue for UIKit delegates inside SwiftUI lifecycle..

## §2 Q3. Why is dual navigation an anti-pattern?

Next. Q3. Why is dual navigation an anti-pattern? Answer. NavigationPath and UINavigationController both mutating from deeplinks and push taps → double present, lost back stack, analytics double-count. Pick one root navigation owner; bridge at edges. Deeplinks, Airship taps, and in-app routing must all write to that single router (Hybrid U I / deeplinks lesson). Follow-ups. “Dual stacks in sync” as best practice?: Forbidden — design one owner, not continuous bidirectional sync.. Cold start deeplink?: Queue intent until root ready — avoid race with unfinished launch.. Auth gates?: In router, not buried in random VCs..

## §3 Q4. How should deeplinks flow in a hybrid app?

Next. Q4. How should deeplinks flow in a hybrid app? Answer. URL → parse at app edge → typed Intent → single Router → ensure root ready (queue on cold start) → push/present UIKit host or SwiftUI host. Push notification taps use the same router as universal links. Mixpanel/Airship must not invent a second navigation path. Follow-ups. Push opened wrong screen?: Single router; same path as deeplinks; queue until ready.. Analytics double-count?: One screen owner per visible surface — not UIKit parent and SwiftUI child both firing viewed.. Hybrid U I / deeplinks provenance?: Grizzlies hybrid + deeplinks + Mixpanel/Airship..

## §4 Q5. What is the UIHostingController containment checklist?

Next. Q5. What is the UIHostingController containment checklist? Answer. 1) addChild(hosting) 2) Add hosting.view with constraints 3) hosting.didMove(toParent: self) 4) Forward appearance if nested players need it 5) On remove: willMove, remove view, removeFromParent. Skipping steps breaks rotation, safe area, and child lifecycle callbacks. Follow-ups. Nested scroll fights?: Ownership of sizing — intrinsic vs explicit height; avoid nested scroll views fighting.. Legacy UIKit host for SwiftUI S D K?: UIHostingController façade is valid (Stories S D K (Raw / Miami Heat) / Day 12).. Why not pure SwiftUI everywhere?: Legacy UIKit + ship velocity — hybrid with deliberate ownership (Hybrid U I / deeplinks)..

## §5 Q6. How do representable `update` storms connect to SwiftUI identity?

Next. Q6. How do representable `update` storms connect to SwiftUI identity? Answer. Parent identity churn or non-Equatable inputs cause updateUIViewController spam — jank and players restart. Causes: parent state churn,.id(UUID) in body, heavy work inside update. Fixes: stabilize IDs, reduce observed state, move heavy work out, pass Equatable props where measured (Day 12 deepens). Follow-ups. Symptom in Stories S D K host?: Page resets mid-swipe — often identity, not “SwiftUI is random.”. Intentional.id reset?: Logout →.id(session) to clear forms — different from accidental UUID churn.. Mixpanel discipline?: Representable updates must not re-fire screen_view every body pass..

## §6 Q7. Sheet vs push — when which?

Next. Q7. Sheet vs push — when which? Answer. Sheet: glanceable overview, keep list context, shallow depth (1–2 actions), high-frequency overview taps — BookMyShow LE Bottom Sheet LE Bottom Sheet reduced full-screen navigations for 30%+ of user flows. Push: deep multi-step hierarchy, checkout wizards, tools needing strong back-stack history. Do not use sheet for deep checkout flows. Follow-ups. Why not a new tab for LE?: Tabs change information architecture; sheet fixes local friction.. Detents?: Medium for overview; large for expanded; grabber + VoiceOver focus matter.. Metric you may claim?: BookMyShow LE Bottom Sheet · 30%+ fewer full-screen navigations — resume only..
