# Sample 03 — Hybrid UIKit ↔ SwiftUI (Q&A)

> Guided teaching. Each answer stands alone and ends with **How can I relate to my case** using named work — never S-codes.

---

### Q1. How do you embed SwiftUI inside UIKit?

**Answer:**

> Use `UIHostingController` as a **child view controller**. Correct containment: `addChild(hosting)`, add `hosting.view` with constraints, `hosting.didMove(toParent:)`. On remove: `willMove`, remove view, `removeFromParent`. Pass observable models; do not rebuild the hosting VC on every bind. Parent appear/disappear should inform pause policies for nested players.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Skipping containment breaks what? | Rotation, safe area, appearance forwarding. |
| Sizing fights? | Constraints, intrinsic content, `sizingOptions` awareness — test on notched devices. |
| State churn? | Rebuilding hosting VC every bind → identity and lifecycle bugs. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q2. How do you embed UIKit inside SwiftUI?

**Answer:**

> Use `UIViewControllerRepresentable` or `UIViewRepresentable`. **`make`** creates once; **`update`** pushes new props — do not recreate the UIKit object every SwiftUI pass. Use a **Coordinator** for delegates and target-action. Avoid parent `.id` churn that triggers `make` storms. Do not let a representable silently own a second navigation stack.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| `update` storm symptoms? | Jank, players restart, delegate spam. |
| Fixes? | Reduce observed state, stable identity, Equatable inputs where measured useful (Day 12). |
| Coordinator role? | Glue for UIKit delegates inside SwiftUI lifecycle. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q3. Why is dual navigation an anti-pattern?

**Answer:**

> `NavigationPath` and `UINavigationController` both mutating from deeplinks and push taps → double present, lost back stack, analytics double-count. **Pick one root navigation owner**; bridge at edges. Deeplinks, Airship taps, and in-app routing must all write to that single router (Hybrid UI / deeplinks lesson).

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| “Dual stacks in sync” as best practice? | **Forbidden** — design one owner, not continuous bidirectional sync. |
| Cold start deeplink? | Queue intent until root ready — avoid race with unfinished launch. |
| Auth gates? | In router, not buried in random VCs. |

**How can I relate to my case:**
- **Shipped:** Hybrid UI / deeplinks
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q4. How should deeplinks flow in a hybrid app?

**Answer:**

> URL → parse at app edge → typed Intent → single Router → ensure root ready (queue on cold start) → push/present UIKit host **or** SwiftUI host. Push notification taps use the **same** router as universal links. Mixpanel/Airship must not invent a second navigation path.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Push opened wrong screen? | Single router; same path as deeplinks; queue until ready. |
| Analytics double-count? | One screen owner per visible surface — not UIKit parent and SwiftUI child both firing viewed. |
| Hybrid UI / deeplinks provenance? | Grizzlies hybrid + deeplinks + Mixpanel/Airship. |

**How can I relate to my case:**
- **Shipped:** Hybrid UI / deeplinks
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q5. What is the UIHostingController containment checklist?

**Answer:**

> 1) `addChild(hosting)` 2) Add `hosting.view` with constraints 3) `hosting.didMove(toParent: self)` 4) Forward appearance if nested players need it 5) On remove: `willMove`, remove view, `removeFromParent`. Skipping steps breaks rotation, safe area, and child lifecycle callbacks.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Nested scroll fights? | Ownership of sizing — intrinsic vs explicit height; avoid nested scroll views fighting. |
| Legacy UIKit host for SwiftUI SDK? | UIHostingController façade is valid (Stories SDK (Raw / Miami Heat) / Day 12). |
| Why not pure SwiftUI everywhere? | Legacy UIKit + ship velocity — hybrid with deliberate ownership (Hybrid UI / deeplinks). |

**How can I relate to my case:**
- **Shipped:** Stories SDK (Raw / Miami Heat); Hybrid UI / deeplinks
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q6. How do representable `update` storms connect to SwiftUI identity?

**Answer:**

> Parent identity churn or non-Equatable inputs cause `updateUIViewController` spam — jank and players restart. Causes: parent state churn, `.id(UUID())` in body, heavy work inside `update`. Fixes: stabilize IDs, reduce observed state, move heavy work out, pass Equatable props where measured (Day 12 deepens).

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Symptom in Stories SDK host? | Page resets mid-swipe — often identity, not “SwiftUI is random.” |
| Intentional `.id` reset? | Logout → `.id(session)` to clear forms — different from accidental UUID churn. |
| Mixpanel discipline? | Representable updates must not re-fire screen_view every body pass. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q7. Sheet vs push — when which?

**Answer:**

> **Sheet:** glanceable overview, keep list context, shallow depth (1–2 actions), high-frequency overview taps — BookMyShow LE Bottom Sheet LE Bottom Sheet reduced full-screen navigations for **30%+ of user flows**. **Push:** deep multi-step hierarchy, checkout wizards, tools needing strong back-stack history. Do not use sheet for deep checkout flows.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why not a new tab for LE? | Tabs change information architecture; sheet fixes local friction. |
| Detents? | Medium for overview; large for expanded; grabber + VoiceOver focus matter. |
| Metric you may claim? | BookMyShow LE Bottom Sheet · **30%+** fewer full-screen navigations — resume only. |

**How can I relate to my case:**
- **Shipped:** BookMyShow LE Bottom Sheet
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

Next: [04-production-s13-s6.md](04-production-s13-s6.md)

---

