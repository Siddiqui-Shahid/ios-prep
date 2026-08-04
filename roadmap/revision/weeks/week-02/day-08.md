# Day 08 — MVVM / Clean / MVI · Layering · DI

> Week 2 · Phase: Architecture, networking, SDUI, UI · Time budget today: ~4–5 hrs

## 1. Outcome

By end of day you can explain aloud (no notes):

- When to pick **MVVM vs Clean vs MVI**, and what each layer owns vs must never own
- How **dependency injection** (constructor / protocol / factory) makes features testable without a DI “framework religion”
- How you migrated District patterns (**MVVM ↔ Clean**) with Context Engineering without skipping design ownership
- How BMS search sits in MVVM: debounce, cancellation, explicit UI states — and how you’d defend that in interview

## 2. Concept deep dive

### 2.1 Pattern map (say this in 45s)

| Pattern | Core idea | UI binding | Best fit |
|---|---|---|---|
| **MVC** | VC owns too much | Imperative | Tiny screens; legacy UIKit |
| **MVVM** | View observes state; VM holds presentation logic | Bindings / Combine / Observation | Feature screens, search, forms |
| **Clean** | Use cases + entities independent of UI/framework | VM or Presenter at edge | Multi-team modules, migrations, heavy domain |
| **MVI / unidirectional** | Intent → Reducer → State → View | Single state stream | Complex multi-source UI (checkout, live) |

**Interview line:** “I default to MVVM for feature UI. I introduce Clean boundaries when domain rules, reuse, or migration risk demand an explicit UseCase layer. I use unidirectional state when many async sources fight over one screen.”

### 2.2 Layering that interviewers expect

```text
View (SwiftUI / UIKit)
  → ViewModel / Presenter  (UI state, mapping, user intents)
    → UseCase / Interactor (optional; business rules, orchestration)
      → Repository         (cache + remote policy)
        → DataSource       (URLSession, DB, CMS)
```

**Rules of thumb:**

- Views: layout + forward events. No networking. No business rules.
- ViewModels: map domain → display models; hold loading/empty/error; cancel in-flight work on disappear / new query.
- UseCases: “why” of the product (e.g. Free Parking billing adjustment rules) — pure enough to unit test without UI.
- Repositories: decide cache-vs-network; hide DTO decoding; never leak URLSession to VMs.

### 2.3 DI without dogma

| Technique | When | Cost |
|---|---|---|
| Constructor injection of protocols | Default for VMs / UseCases | Slightly more init boilerplate |
| Factory / Assembler per feature | Feature modules, SPM boundaries | Need clear ownership of graph |
| Service locator / shared singleton | Avoid for domain; ok for app-scoped analytics? | Hidden deps, hard tests |
| SwiftUI `.environment` / Observation | UI-tree plumbing | Don’t put networking clients only in Environment without protocols |

**Senior stance:** Protocols at **boundaries** (NetworkClient, SearchRepository, Analytics). Concrete types inside the module. Fake in XCTest. District: AI helped generate tests **after** protocols existed — not instead of them.

### 2.4 MVVM ↔ Clean migration (District playbook)

Incremental migration beats big-bang:

1. Freeze feature contracts (APIs, analytics events, nav).
2. Extract UseCase from fat VM **one flow at a time** (Free Parking billing adjustments).
3. Keep VM as adapter: still owns UI state; now calls UseCase.
4. Add XCTest on UseCase first (cheapest confidence), then VM state tests.
5. Context Engineering: feed Cursor/Claude **boundary docs + existing patterns**, review every diff; you own regressions.

### 2.5 Trade-offs

| Choice | When | Cost |
|---|---|---|
| Fat MVVM only | Single team, simple screens | VMs become god objects |
| Clean everywhere on day 1 | Rarely | Ceremony slows small features |
| MVI for every list | Overkill | Boilerplate; harder junior onboarding |
| Shared AppCoordinator singleton for all DI | Fast start | Untestable coupling at scale |
| Protocol + constructor DI | Default senior choice | Explicit wiring |

## 3. Read these

| Priority | Resource | Why |
|---|---|---|
| Must | Day 08 notes above + [app-modularization.md](../../../ios-system-design/docs/app-modularization.md) (boundaries) | Language for layers in SD / deep-dive |
| Deepen | Apple: [Testing](https://developer.apple.com/documentation/xctest) · WWDC: Data Essentials in SwiftUI (state ownership) | Test + state ownership vocabulary |
| Repo | [search-autocomplete.md](../../../ios-system-design/docs/search-autocomplete.md) | Ties MVVM search to system design |
| Repo | [stories/story-bank.md](../../stories/story-bank.md)#s9--free-parking--cleanmvvm--ai-tooling-district · [S3](../../stories/story-bank.md)#s3--backend-driven-header--search-bookmyshow | Production hooks |

## 4. Map to your work

**Company / feature:** District — Free Parking + Clean/MVVM migration with Context Engineering  
**What you did:** Shipped Free Parking billing adjustments; migrated patterns across MVVM and Clean; used AI inside a strict architectural envelope (reviews + XCTest/XCUITest), owned on-call fixes.  
**Interview line (≤20s):** “At District I shipped Free Parking while migrating MVVM↔Clean incrementally — AI accelerated scaffolding inside protocols I owned, with tests as the gate.”

→ Full STAR: [stories/story-bank.md](../../stories/story-bank.md)#s9--free-parking--cleanmvvm--ai-tooling-district

**Secondary map — BMS search:** Debounced MVVM search with explicit loading/empty/error; race-safer UX on high-traffic surface.  
→ [stories/story-bank.md](../../stories/story-bank.md)#s3--backend-driven-header--search-bookmyshow

## 5. Normal questions

For each: answer out loud within the time. Skeleton only — expand from memory.

### Q1. Explain MVVM vs MVC. `(30–45s)`
**Skeleton:** MVC VCs accumulate networking + state → hard tests. MVVM: View renders state, VM owns presentation + async orchestration, Model/domain separate. UIKit: bindings/closures/Combine; SwiftUI: Observation/`@State`/`@Bindable`.  
**Follow-up:** Where does networking live? → Repository behind protocol, not in View.  
**Story:** S3 search VM; S9 migration away from fat layers.

### Q2. When do you introduce Clean Architecture? `(45–60s)`
**Skeleton:** When domain rules are non-trivial, shared across screens, or you’re migrating safely. Entities + UseCases independent of UIKit/SwiftUI. UI adapters stay thin. Don’t Clean-ify a settings toggle.  
**Follow-up:** How thin is the VM then? → Maps UseCase output → view state; still cancels tasks.  
**Story:** S9 Free Parking + migration.

### Q3. What is MVI / unidirectional data flow? `(45s)`
**Skeleton:** User Intent → reducer/processor → immutable State → View. Side effects explicit. Great when checkout/live scoreboard has many async inputs; heavier than MVVM for CRUD.  
**Follow-up:** Relation to TCA? → Same family; discuss trade-off of framework vs hand-rolled.  
**Story:** Mentally link S7 payment states / S11 live scoreboard as “state machine” cousins.

### Q4. How do you do DI on iOS without a container? `(45–60s)`
**Skeleton:** Protocol boundaries + constructor injection. Feature factory builds graph. Tests inject fakes. Avoid service locators for domain. SwiftUI Environment for UI-scoped deps carefully.  
**Follow-up:** Circular dependencies? → Split protocols; invert ownership toward UseCase.  
**Story:** S9; S10 Stories SDK public API isolation.

### Q5. How would you structure BMS search in MVVM? `(60–90s)`
**Skeleton:** `SearchViewModel`: query subject → debounce (~300ms) → cancel previous `Task` → repository → states: idle/loading/results/empty/error. View binds state only. Ranking stays server-side unless product needs local filter.  
**Follow-up:** Why debounce + cancel? → Avoid out-of-order responses; save battery/network at 30L+ DAU scale.  
**Story:** [S3](../../stories/story-bank.md)#s3--backend-driven-header--search-bookmyshow

### Q6. Fat ViewModel — smells and fix? `(45s)`
**Skeleton:** Smells: networking strings, analytics dumps, routing, business rules all in VM. Fix: extract UseCase + Router/Coordinator + AnalyticsClient protocol.  
**Follow-up:** Migration order? → Extract UseCase under test first.  
**Story:** S9.

### Q7. How do View and ViewModel communicate in UIKit vs SwiftUI? `(45s)`
**Skeleton:** UIKit: closures, Combine `PassthroughSubject`, delegates for one-off. SwiftUI: `@Observable` / `@Bindable`, or published state. Prefer state down, events up.  
**Follow-up:** Retain cycles? → `[weak self]` in UIKit closures; Observation reduces classic Combine cycle footguns but still careful with long-lived tasks.  
**Story:** S13 hybrid if asked UIKit hosting.

### Q8. How did you use AI in the District migration without losing seniority? `(60s)`
**Skeleton:** Context Engineering: feed architecture constraints, existing module patterns, acceptance tests. AI drafts migrations/tests; you review for boundary violations, naming, race conditions. Never “AI wrote the app.”  
**Follow-up:** What did AI get wrong? → Be ready with a concrete miss (wrong layer, missing cancellation, flaky UI test).  
**Story:** S9 — **critical interview story**.

### Q9. Repository vs UseCase — difference? `(30–45s)`
**Skeleton:** UseCase = application policy (“adjust Free Parking billing”). Repository = data policy (cache TTL, remote fetch, mapping DTOs). VM shouldn’t know URLSession; UseCase shouldn’t know UIKit.  
**Follow-up:** Can UseCase call multiple repos? → Yes, orchestration is the point.  
**Story:** S9.

### Q10. How do you keep feature modules testable? `(45–60s)`
**Skeleton:** Protocols at edges, pure UseCases, deterministic fakes, snapshot/UI tests sparingly for critical flows, CI gates. District: XCTest/XCUITest generation inside review loop.  
**Follow-up:** What do you not mock? → Prefer fakes over heavy mocks; don’t mock value types needlessly.  
**Story:** S9; S1 ads protocols for testability.

### Q11. Coordinator vs Router vs NavigationPath? `(45s)`
**Skeleton:** Coordinator/Router owns cross-feature nav side effects so VM stays testable. SwiftUI: `NavigationPath` / deep-link handlers at app edge (Grizzlies). Don’t put `UINavigationController` pushes inside UseCases.  
**Follow-up:** Deep links? → Parse at app boundary → intent → coordinator.  
**Story:** S13.

### Q12. How does architecture relate to crash-free at 30L+ DAU? `(45–60s)`
**Skeleton:** Clear ownership + fail-soft states + fewer god objects → fewer nil races and lifecycle bugs. Architecture doesn’t replace Crashlytics/IMOC — it reduces blast radius.  
**Follow-up:** Example fail-soft? → Search error state; SDUI unknown component skip (preview Day 10).  
**Story:** S8 reliability culture + S3 states.

## 6. Tricky questions

### T1. “Isn’t Clean Architecture overengineering for mobile?” `(90–120s)`
**Trap:** Binary yes/no. Seniors scope it.  
**Senior answer:** Overkill for every screen. Worth it when domain + multi-team + migration risk. At District we extracted UseCases where billing rules lived; left simple UI as MVVM. Measure ceremony vs regression cost.  
**Follow-up:** Show a screen you’d *not* Clean-ify.

### T2. “Where should debounce live — View, VM, or Repository?” `(90s)`
**Trap:** Putting it only in UIControl or only in network layer.  
**Senior answer:** Presentation policy → **VM** (or UseCase if product rule). Repository shouldn’t know keystroke timing. Network layer may still cancel tasks. BMS: debounce in search VM + cancel in-flight.  
**Follow-up:** Different debounce for analytics vs search? → Separate pipelines.

### T3. “MVVM doesn’t work with SwiftUI — discuss.” `(90–120s)`
**Trap:** Claiming SwiftUI kills VM.  
**Senior answer:** SwiftUI wants clear state ownership; VM/`@Observable` models still useful for async, testing, and sharing. Avoid duplicating every `@State` into VM. Prefer view-local state for pure UI; hoist async/domain.  
**Follow-up:** `@Observable` vs `ObservableObject` — Day 12 preview.

### T4. “How do you migrate a live app from MVC to Clean without a rewrite?” `(120s)`
**Trap:** Big-bang rewrite.  
**Senior answer:** Strangler: new features on new boundaries; extract UseCases behind old VC; characterization tests; feature flags; District-style incremental MVVM↔Clean. Ship Free Parking value while migrating.  
**Follow-up:** Rollback plan? → Keep old path behind flag.

### T5. “Dependency injection frameworks on iOS — yes/no?” `(90s)`
**Trap:** Tool advocacy without trade-offs.  
**Senior answer:** Optional. Prefer manual constructor DI + factories until graph pain is real. Frameworks help large graphs; cost is magic and compile/runtime opacity. Protocols first.  
**Follow-up:** How Stories SDK exposes DI to host apps? → Inject networking/analytics via protocols (S10).

### T6. “Who owns navigation — VM or Coordinator?” `(90s)`
**Trap:** Absolute rule.  
**Senior answer:** Simple push: VM can emit `NavigationEvent`. Cross-feature, auth gates, deep links: Coordinator/Router. Test VMs by asserting events, not by pushing VCs.  
**Follow-up:** LE Bottom Sheet — presented UI vs full nav (S6).

### T7. “How do you prevent AI-generated Clean Architecture from becoming nonsense layers?” `(90–120s)`
**Trap:** Either ban AI or praise it blindly.  
**Senior answer:** Envelope: documented layering, example PRs, checklist (no UIKit in UseCase, no URLSession in VM). AI proposes; human reviews boundaries; tests must fail for wrong layer. Context Engineering is the control plane.  
**Follow-up:** Metric of success? → Regression rate + review cycle time, not LOC generated.

## 7. Flashcards for today

| Front | Back |
|---|---|
| MVVM one-liner | View renders state; VM presentation + async; Model domain · Trap: networking in View · Prod: BMS search VM |
| Clean one-liner | UseCases/entities independent of UI · Trap: Clean everywhere · Prod: District Free Parking rules |
| MVI one-liner | Intent → reduce → State → View · Trap: boilerplate for CRUD · Prod: payment/live state cousins |
| Where debounce lives | VM/UseCase presentation policy · Trap: only in URLSession · Prod: BMS search |
| DI default | Protocol + constructor injection · Trap: service locator for domain · Prod: testable VMs |
| Repository duty | Cache/remote + DTO map · Trap: business rules in repo · Prod: search repository |
| Fat VM smell | Networking + routing + rules · Fix: UseCase + Router · Prod: S9 extract |
| AI in migration | Accelerate inside envelope + review · Trap: “AI wrote it” · Prod: S9 Context Engineering |
| Navigation ownership | Events from VM; Coordinator for cross-feature · Trap: UIKit in UseCase · Prod: S13 deeplinks |
| Fail-soft UI states | loading/empty/error/success · Trap: spinner forever · Prod: BMS search |
| When not Clean | Trivial UI, no shared domain · Trap: resume padding · Prod: judgment call |
| Test pyramid tip | UseCase unit tests cheapest · Trap: only UITests · Prod: District XCTest |
| Strangler migration | Incremental extract, flags · Trap: rewrite · Prod: District |
| Protocol boundary | Network/Search/Analytics · Trap: protocol every struct · Prod: S1/S10 |
| Scale link | Clear layers reduce blast radius · Trap: architecture = crash-free alone · Prod: 30L DAU + S8 |

## 8. Practice

- **Coding / SD:** Sketch on paper: `SearchViewModel` API (state enum, `onQueryChange`, cancel). Then outline District Free Parking UseCase inputs/outputs without UIKit.
- **Complexity / agenda to say first:** “I’ll define layers, where debounce/cancel live, then map to BMS search and District migration trade-offs.”
- **Optional:** 15 min read of [search-autocomplete.md](../../../ios-system-design/docs/search-autocomplete.md) HLD — note where VM vs repository sit.

## 9. Timed drill

1. Pick 3 Normal + 2 Tricky (recommended: Q5, Q8, Q2 + T1, T7). Record.
2. Score against [answer-timing-guide.md](../../timing/answer-timing-guide.md).
3. Log misses in gotchas (especially AI-ownership wording and debounce placement).
4. Deliver S9 STAR in **2–3 min** once; opener only in **20s** once.
