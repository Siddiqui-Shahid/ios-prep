# 04 — Questions (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Each question ends with **How can I relate to my case** using named work — never S-codes.
> Normal ≈ 30–60s · Design ≈ 90–120s · Tricky ≈ 90–120s.

---

## Normal questions

### Q1. Explain MVVM vs MVC. `(30–45s)`

**Answer:**

> In UIKit MVC, view controllers often accumulate networking, state, and layout — Massive View Controller. MVVM keeps the View focused on rendering and forwarding intents, while the ViewModel owns presentation state and screen-level async. The model or domain stays free of UIKit. In UIKit you bind with closures or Combine; in SwiftUI you typically observe an @Observable model. I used that split on BookMyShow search and when thinning layers during District’s migration.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | On BookMyShow search, the ViewModel owns debounce and explicit idle/loading/results/empty/error states so the VC never owns networking. |

**How can I relate to my case:**
- **Shipped:** BookMyShow backend-driven header & search; District Free Parking + Clean/MVVM + AI tooling
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q2. When do you introduce Clean Architecture? `(45–60s)`

**Answer:**

> I introduce Clean boundaries when domain rules are non-trivial, shared across screens, or I’m migrating safely under a fat layer. UseCases and entities stay independent of UIKit and SwiftUI; the ViewModel becomes a thin adapter that maps results to view state and still cancels tasks. I don’t Clean-ify a settings toggle — ceremony has to earn its keep. At District, Free Parking billing rules were a natural UseCase extraction while simpler chrome stayed MVVM.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | At District, Free Parking billing rules became a UseCase while simple chrome stayed thin MVVM — ceremony only where policy lived. |

**How can I relate to my case:**
- **Shipped:** District Free Parking + Clean/MVVM + AI tooling
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q3. What is MVI / unidirectional data flow? `(45s)`

**Answer:**

> MVI or unidirectional flow means the View sends Intents into a processor that produces a new immutable State, and the View renders that state. Side effects like networking are explicit and usually feed results back as Intents. It’s excellent when checkout or a live scoreboard has many async inputs fighting one screen. For simple CRUD, MVVM with an enum state machine is usually enough — I don’t pay reducer boilerplate by default.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | A live in-arena scoreboard with many async inputs is a good unidirectional-flow candidate; simple CRUD stays enum-state MVVM. |

**How can I relate to my case:**
- **Shipped:** Live in-arena scoreboard (Raw); BookMyShow payment processing-status popup
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Invented checkout drop-off % from the status popup alone.

---

### Q4. How do you do DI on iOS without a container? `(45–60s)`

**Answer:**

> My default is protocol boundaries with constructor injection — ViewModels and UseCases receive repositories and clients through init. A feature assembler builds the graph at the module edge. Tests inject fakes. I avoid service locators for domain dependencies. SwiftUI Environment is fine for theme and shallow UI deps, but I don’t hide the NetworkClient only in Environment for an SDK-style feature.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | Stories SDK and Free Parking both take repositories through init so tests inject fakes without a service-locator container. |

**How can I relate to my case:**
- **Shipped:** Stories SDK (Raw / Miami Heat); District Free Parking + Clean/MVVM + AI tooling
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q5. How would you structure BMS search in MVVM? `(60–90s)`

**Answer:**

> I’d give SearchViewModel a query handler that debounces around 300ms, cancels the previous Task, and moves through an explicit state enum — idle, loading, results, empty, error. The View only renders state and forwards text changes. A SearchRepository returns domain models; ranking stays server-side unless product needs local filter. Cancellation must not surface as a scary error. That’s aligned with how we made BookMyShow search race-safer under MVVM.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | Cancel the previous search Task on each new query and treat CancellationError as silent so fast typing never flashes an error banner. |

**How can I relate to my case:**
- **Shipped:** BookMyShow backend-driven header & search
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q6. Fat ViewModel — smells and fix? `(45s)`

**Answer:**

> A fat ViewModel mixes networking strings, routing, analytics, and business rules. The fix is extraction: UseCase for policy, Router/Coordinator for navigation, AnalyticsClient protocol for events. I extract the UseCase under characterization or unit tests first so behavior doesn’t drift — that was the spirit of District’s incremental migration.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | If the ViewModel starts routing and encoding billing policy, extract a UseCase and a Router first under characterization tests. |

**How can I relate to my case:**
- **Shipped:** District Free Parking + Clean/MVVM + AI tooling
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q7. How do View and ViewModel communicate in UIKit vs SwiftUI? `(45s)`

**Answer:**

> In UIKit, ViewModels typically push state through closures, Combine publishers, or occasionally delegates for one-off events — always mind `[weak self]`. In SwiftUI, I prefer an @Observable model with @Bindable for two-way fields. Pattern is state down, events up. Observation reduces some Combine cycle footguns, but long-lived Tasks still need cancellation on disappear.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | In UIKit use closures or Combine with [weak self]; in SwiftUI prefer an @Observable model and cancel long-lived Tasks on disappear. |

**How can I relate to my case:**
- **Shipped:** Hybrid UI / deeplinks
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q8. How did you use AI in the District migration without losing seniority? `(60–90s)`

**Answer:**

> At District I used Context Engineering — feeding architecture constraints, existing module patterns, and acceptance intent into Cursor/Claude/Copilot. AI accelerated scaffolding, review assistance, and XCTest/XCUITest drafts. I reviewed every boundary-sensitive diff for misplaced rules, missing cancellation, and naming. Success wasn’t lines generated; it was shipping Free Parking and migrating patterns without skipping design ownership. I never say AI wrote the app.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | AI drafts scaffolding and XCTest stubs only inside a review envelope — I still own boundary placement, cancellation, and naming. |

**How can I relate to my case:**
- **Shipped:** FinTrack on-device AI; District Free Parking + Clean/MVVM + AI tooling
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q9. Repository vs UseCase — difference? `(30–45s)`

**Answer:**

> A UseCase answers what the product should do — adjust Free Parking billing under eligibility rules. A Repository answers where data comes from and how cache versus remote is applied, including DTO mapping. The ViewModel shouldn’t know URLSession; the UseCase shouldn’t know UIKit. UseCases often orchestrate multiple repositories; repositories usually shouldn’t encode billing policy.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | AdjustFreeParkingBilling encodes eligibility policy; the repository only maps DTOs and chooses cache versus remote. |

**How can I relate to my case:**
- **Shipped:** District Free Parking + Clean/MVVM + AI tooling
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q10. How do you keep feature modules testable? `(45–60s)`

**Answer:**

> Protocols at the edges, pure UseCases, and deterministic fakes give a cheap unit-test core. I add snapshot or UI tests sparingly for critical flows. CI gates matter more than clever mocks. At District, AI-assisted XCTest/XCUITest drafts were useful only inside a review loop — theater tests that never fail when policy flips are worse than no tests.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | A good unit test fails when Free Parking policy inverts; theater tests that always pass are worse than none. |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle; District Free Parking + Clean/MVVM + AI tooling
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

---

### Q11. Coordinator vs Router vs NavigationPath? `(45s)`

**Answer:**

> For simple pushes, the ViewModel can emit a NavigationEvent. Cross-feature flows, auth gates, and deeplinks belong in a Coordinator or Router so VMs stay testable. In SwiftUI, NavigationPath and deeplink handlers live at the app edge — Grizzlies taught deliberate ownership. UseCases must not push UIKit controllers.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | Deeplinks and cross-feature exits belong in one Coordinator/Router; UseCases must never push UIKit controllers. |

**How can I relate to my case:**
- **Shipped:** Hybrid UI / deeplinks; BookMyShow LE Bottom Sheet
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q12. How does architecture relate to crash-free at 30L+ DAU? `(45–60s)`

**Answer:**

> Architecture doesn’t magically create 99.95% crash-free sessions — observability and incident process still matter. What layers buy you is smaller blast radius: fail-soft UI states, fewer god objects, and clearer cancellation so you don’t force-unwrap your way through races. At BookMyShow scale, search error states and disciplined ownership are reliability features.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | Fail-soft search error states and clear ownership shrink blast radius — architecture supports, but does not invent, crash-free bars. |

**How can I relate to my case:**
- **Shipped:** BookMyShow backend-driven header & search; BookMyShow IMOC + crash-free at scale
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Attributing 99.95%+ CFS to a single ticket; inventing DAU figures.

---

## Tricky questions

