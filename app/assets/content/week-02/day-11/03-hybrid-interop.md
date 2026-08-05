# Sample 03 — Hybrid UIKit ↔ SwiftUI (Q&A)

> Guided teaching. Each answer stands alone; **Points to** shows where the full module expands the idea.

---

### Q1. How do you embed SwiftUI inside UIKit?

**Points to:** [Foundations · §6 Hybrid](../01-foundations.md#6-hybrid--intern-path) · [Deep dive · §5 SwiftUI in UIKit](../02-deep-dive.md#swiftui-in-uikit-uihostingcontroller) · [code/HybridHostingNotes.swift](../code/HybridHostingNotes.swift)

**Answer:**

> Use `UIHostingController` as a **child view controller**. Correct containment: `addChild(hosting)`, add `hosting.view` with constraints, `hosting.didMove(toParent:)`. On remove: `willMove`, remove view, `removeFromParent`. Pass observable models; do not rebuild the hosting VC on every bind. Parent appear/disappear should inform pause policies for nested players.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Skipping containment breaks what? | Rotation, safe area, appearance forwarding. |
| Sizing fights? | Constraints, intrinsic content, `sizingOptions` awareness — test on notched devices. |
| State churn? | Rebuilding hosting VC every bind → identity and lifecycle bugs. |

---

### Q2. How do you embed UIKit inside SwiftUI?

**Points to:** [Foundations · §6 Hybrid](../01-foundations.md#6-hybrid--intern-path) · [Deep dive · UIKit in SwiftUI](../02-deep-dive.md#uikit-in-swiftui-representable)

**Answer:**

> Use `UIViewControllerRepresentable` or `UIViewRepresentable`. **`make`** creates once; **`update`** pushes new props — do not recreate the UIKit object every SwiftUI pass. Use a **Coordinator** for delegates and target-action. Avoid parent `.id` churn that triggers `make` storms. Do not let a representable silently own a second navigation stack.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| `update` storm symptoms? | Jank, players restart, delegate spam. |
| Fixes? | Reduce observed state, stable identity, Equatable inputs where measured useful (Day 12). |
| Coordinator role? | Glue for UIKit delegates inside SwiftUI lifecycle. |

---

### Q3. Why is dual navigation an anti-pattern?

**Points to:** [Foundations · §6 One navigation owner](../01-foundations.md#6-hybrid--intern-path) · [Deep dive · §5 Dual navigation anti-pattern](../02-deep-dive.md#dual-navigation-anti-pattern)

**Answer:**

> `NavigationPath` and `UINavigationController` both mutating from deeplinks and push taps → double present, lost back stack, analytics double-count. **Pick one root navigation owner**; bridge at edges. Deeplinks, Airship taps, and in-app routing must all write to that single router (S13 lesson).

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| “Dual stacks in sync” as best practice? | **Forbidden** — design one owner, not continuous bidirectional sync. |
| Cold start deeplink? | Queue intent until root ready — avoid race with unfinished launch. |
| Auth gates? | In router, not buried in random VCs. |

---

### Q4. How should deeplinks flow in a hybrid app?

**Points to:** [Deep dive · §6 Deeplinks in hybrid apps](../02-deep-dive.md#6-deeplinks-in-hybrid-apps) · [Production bridge · S13](../03-production-bridge.md#2-s13-star-23-min)

**Answer:**

> URL → parse at app edge → typed Intent → single Router → ensure root ready (queue on cold start) → push/present UIKit host **or** SwiftUI host. Push notification taps use the **same** router as universal links. Mixpanel/Airship must not invent a second navigation path.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Push opened wrong screen? | Single router; same path as deeplinks; queue until ready. |
| Analytics double-count? | One screen owner per visible surface — not UIKit parent and SwiftUI child both firing viewed. |
| S13 provenance? | Verified · Grizzlies hybrid + deeplinks + Mixpanel/Airship. |

---

### Q5. What is the UIHostingController containment checklist?

**Points to:** [Foundations · §13 Hybrid containment checklist](../01-foundations.md#13-hybrid-containment-checklist-uihostingcontroller)

**Answer:**

> 1) `addChild(hosting)` 2) Add `hosting.view` with constraints 3) `hosting.didMove(toParent: self)` 4) Forward appearance if nested players need it 5) On remove: `willMove`, remove view, `removeFromParent`. Skipping steps breaks rotation, safe area, and child lifecycle callbacks.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Nested scroll fights? | Ownership of sizing — intrinsic vs explicit height; avoid nested scroll views fighting. |
| Legacy UIKit host for SwiftUI SDK? | UIHostingController façade is valid (S10 / Day 12). |
| Why not pure SwiftUI everywhere? | Legacy UIKit + ship velocity — hybrid with deliberate ownership (S13). |

---

### Q6. How do representable `update` storms connect to SwiftUI identity?

**Points to:** [Deep dive · §10 Representable update storms](../02-deep-dive.md#10-representable-update-storms) · [Deep dive · §5 Identity stability](../02-deep-dive.md#uikit-in-swiftui-representable)

**Answer:**

> Parent identity churn or non-Equatable inputs cause `updateUIViewController` spam — jank and players restart. Causes: parent state churn, `.id(UUID())` in body, heavy work inside `update`. Fixes: stabilize IDs, reduce observed state, move heavy work out, pass Equatable props where measured (Day 12 deepens).

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Symptom in Stories SDK host? | Page resets mid-swipe — often identity, not “SwiftUI is random.” |
| Intentional `.id` reset? | Logout → `.id(session)` to clear forms — different from accidental UUID churn. |
| Mixpanel discipline? | Representable updates must not re-fire screen_view every body pass. |

---

### Q7. Sheet vs push — when which?

**Points to:** [Foundations · §7 LE Bottom Sheet](../01-foundations.md#7-le-bottom-sheet--product-picture-s6) · [Deep dive · §7 LE Bottom Sheet](../02-deep-dive.md#7-le-bottom-sheet-s6--engineering--product) · [Foundations · §14 Sheet heuristics](../01-foundations.md#14-sheet-product-heuristics)

**Answer:**

> **Sheet:** glanceable overview, keep list context, shallow depth (1–2 actions), high-frequency overview taps — S6 LE Bottom Sheet reduced full-screen navigations for **30%+ of user flows**. **Push:** deep multi-step hierarchy, checkout wizards, tools needing strong back-stack history. Do not use sheet for deep checkout flows.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why not a new tab for LE? | Tabs change information architecture; sheet fixes local friction. |
| Detents? | Medium for overview; large for expanded; grabber + VoiceOver focus matter. |
| Metric you may claim? | Verified S6 · **30%+** fewer full-screen navigations — resume only. |

---

Next: [04-production-s13-s6.md](04-production-s13-s6.md)
