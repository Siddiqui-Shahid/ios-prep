# 02 — Deep Dive: Layering, DI, Migration, MVI, Search

> Senior depth. Assumes [01-foundations.md](01-foundations.md). Still self-contained — no “go read a blog first.” Optional citations at the end.

## 1. Ownership matrix (interview gold)

| Concern | View | ViewModel | UseCase | Repository | DataSource |
|---|---|---|---|---|---|
| Layout / a11y | ✅ | ❌ | ❌ | ❌ | ❌ |
| loading/empty/error UI state | ✅ renders | ✅ owns | ❌ | ❌ | ❌ |
| Debounce keystrokes | ❌ | ✅ (usual) | ✅ if product rule | ❌ | ❌ |
| Cancel in-flight search | maybe onDisappear signal | ✅ | maybe | may cancel tasks | ✅ task cancel |
| Billing eligibility rules | ❌ | ❌ | ✅ | ❌ | ❌ |
| Cache TTL / stale-while-revalidate | ❌ | ❌ | policy hint OK | ✅ | implements |
| JSON decode | ❌ | ❌ | ❌ | maps | often performs |
| `UINavigationController.push` | maybe UIKit | emit event | ❌ | ❌ | ❌ |
| Analytics “search_performed” | ❌ | often | sometimes domain events | ❌ | ❌ |
| URLSession config | ❌ | ❌ | ❌ | ❌ | ✅ |

**Senior one-liner:** Put policy next to the reason it exists. Timing of keystrokes is presentation. Eligibility of Free Parking adjustment is domain. HTTP caching is data.

## 2. MVVM in practice (UIKit + SwiftUI)

### 2.1 State enum beats boolean soup

```swift
enum SearchUIState: Equatable {
    case idle
    case loading(query: String)
    case results([MovieRow])
    case empty(query: String)
    case error(message: String, query: String)
}
```

Booleans (`isLoading`, `hasError`, `isEmpty`) create impossible combinations (`isLoading && hasError`). Enums make illegal states unrepresentable — same lesson as Day 01.

### 2.2 UIKit binding styles

| Style | Shape | Watch-outs |
|---|---|---|
| Closures / callbacks | `vm.onStateChange = { [weak self] in … }` | Retain cycles; clear on deinit |
| Combine | `@Published` / PassthroughSubject | Cancel `AnyCancellable` store |
| Delegation | rare for continuous state | OK for one-shot events |

### 2.3 SwiftUI binding styles

| Style | When |
|---|---|
| `@Observable` VM (iOS 17+) | New feature screens — prefer |
| `@Bindable` | Two-way fields into observable model |
| `ObservableObject` + `@Published` | Legacy / pre-Observation codebases |
| Pure `@State` | View-local chrome only |

**Trap:** Duplicating every toggle into the VM. Hoist async/domain; keep pure UI local (Day 12 expands).

### 2.4 Cancellation is part of MVVM

```text
onQueryChange(q)
  → debounce wait
  → cancel previous Task
  → state = loading
  → await repo
  → if Task.isCancelled: return
  → apply state
```

Without cancel, slow responses overwrite newer queries → “racey search.” BMS search (S3) is the production proof: debounce + explicit states + race-safer UX.

See learning-lab: [code/SearchViewModel.swift](code/SearchViewModel.swift).

## 3. Clean boundaries without folder theater

### 3.1 What “Clean” means here

Not “I have `Domain/Data/Presentation` folders.” It means:

1. **Entities / domain types** don’t import UIKit/SwiftUI.
2. **UseCases** express application actions and can be tested with fakes.
3. **Adapters** (VM, Repository implementations) sit at the edges.
4. Dependencies point **inward**.

### 3.2 When to introduce a UseCase

Introduce when **at least one** is true:

- Rules are non-trivial (eligibility, pricing, multi-step orchestration).
- Same action is shared across screens / entry points.
- You’re migrating and need a stable seam under a fat VC/VM.
- You want the cheapest regression net (unit tests on policy).

Skip when:

- Screen is a settings toggle with no domain.
- UseCase would be a pure pass-through to one repository method with no policy.
- Ceremony would exceed risk.

### 3.3 Free Parking shape (illustrative)

```text
AdjustFreeParkingBilling
  input:  ParkingAdjustmentRequest
  output: ParkingAdjustmentResult
  deps:   BillingRepository, Clock, (optional) IdempotencyStore

Steps:
  1. Validate request (amounts, user eligibility)
  2. Apply domain policy
  3. Persist via repository
  4. Return typed result
```

VM maps `Result` → alert / success / error UI. VM does **not** re-implement eligibility.

See [code/FreeParkingUseCase.swift](code/FreeParkingUseCase.swift).

### 3.4 Repository vs UseCase — the confusion interviewers love

| | UseCase | Repository |
|---|---|---|
| Question it answers | “What should the product do?” | “Where do bytes/models come from/go?” |
| Knows UIKit? | No | No |
| Knows URLSession? | No | Via DataSource / client |
| Contains billing rules? | Yes | No |
| Contains cache TTL? | Rarely (may pass policy) | Yes |
| Orchestrates multiple repos? | Yes | Usually no |

**Wrong:** Put “if free parking promo then waive fee” next to JSON decoding.  
**Wrong:** Put URL building inside the UseCase.

## 4. MVI / unidirectional data flow

### 4.1 Loop

```text
View  --Intent-->  Store/Processor  --State-->  View
                       │
                       └── Effect (network, analytics) ──► Intent (result)
```

### 4.2 When MVI wins

- Multiple async sources mutate one screen (live scoreboard, checkout with polling + user edits).
- You need a replayable log of intents for debugging.
- Team already standardized on unidirectional patterns.

### 4.3 When MVI is overkill

- CRUD forms with one repository call.
- Junior-heavy team with no reducer literacy yet.
- You only needed an enum state machine inside an MVVM VM (often enough — S7 payment states are cousins).

### 4.4 Relation to TCA / Redux-ish frameworks

Same family. Frameworks buy structure and tooling; cost is boilerplate and onboarding. Hand-rolled unidirectional for one complex screen is valid. Don’t claim “we use TCA” unless you do.

**Interview line:** “Unidirectional when async contention is high; MVVM+enum state when it’s not.”

## 5. Dependency injection graphs

### 5.1 Feature assembler

```text
FeatureAssembler
  builds: URLSessionClient → RemoteSearchDataSource → SearchRepository
        → SearchViewModel → SearchView / SearchViewController
```

Production composition root (app or feature module) owns wiring. Tests skip the assembler and inject fakes at the VM/UseCase boundary.

See [code/FeatureAssembler.swift](code/FeatureAssembler.swift).

### 5.2 Protocol granularity

| Good protocol | Bad protocol |
|---|---|
| `SearchRepository` | `DoesEverythingService` |
| `BillingAdjusting` | `IBillingManagerProtocol` for a concrete with one impl forever |
| `AnalyticsClient` | Protocol per single function with no test value |

Prefer protocols at **boundaries** (network, persistence, analytics, clock). Don’t protocol every internal struct.

### 5.3 Circular dependencies

Smell: `UseCase` needs `Router`, `Router` needs `UseCase` to decide destination.

Fixes:

- Emit `NavigationEvent` from VM; Coordinator observes.
- Split protocols (`BillingAdjusting` vs `BillingPresenting`).
- Move shared policy to a third type both depend on.

### 5.4 SwiftUI Environment as DI

| OK in Environment | Risky |
|---|---|
| Theme, locale, layout direction | Sole `NetworkClient` for all features |
| Feature-scoped observable store passed deliberately | Hidden service locator via custom EnvironmentKey soup |

SDKs (Day 12 / S10) prefer **explicit init injection** so hosts see dependencies.

### 5.5 DI frameworks on iOS

Optional. Manual constructor DI + factories until graph pain is real. Frameworks help large graphs; cost is magic and opacity. Protocols first — always.

## 6. Fat ViewModel — smells and surgery

### 6.1 Smells

- Stringly URLs / endpoint paths in the VM
- Switch on HTTP status codes
- Business eligibility checks
- Direct `navigationController?.push`
- 800-line file “just for this screen”
- Hard to unit test without URLProtocol gymnastics at the VM layer

### 6.2 Extraction order (District-style strangler)

1. **Freeze contracts** — API shapes, analytics names, nav entry points.
2. **Characterization tests** — lock current behavior where risk is high.
3. **Extract UseCase** under the VM — VM becomes adapter; behavior unchanged.
4. **Unit test UseCase** with fakes (cheapest confidence).
5. **Extract Repository** if VM still speaks DTO/HTTP.
6. **Router/Coordinator** for cross-feature nav.
7. **Delete dead paths**; keep feature flags for rollback if needed.

**Do not** rewrite the whole module in one PR while shipping Free Parking. Ship value *while* migrating.

## 7. MVVM ↔ Clean migration playbook (S9)

```text
Legacy fat layer
    │
    ├─ new Free Parking flow on UseCase + thin VM   ✅ ship value
    ├─ strangler: old screens call new UseCase
    ├─ AI scaffolds tests/migrations inside envelope
    └─ human review: boundary checklist + on-call ownership
```

### 7.1 Context Engineering envelope (what to feed AI)

- Layering rules doc (“no UIKit in UseCase”, “no URLSession in VM”)
- One exemplar PR of a good extraction
- Acceptance tests / failing tests first when possible
- Naming conventions already in the module

### 7.2 Review checklist (human gate)

| Check | Fail if |
|---|---|
| UseCase imports UIKit/SwiftUI | Boundary violation |
| VM builds `URLRequest` | Wrong layer |
| Missing cancellation on search-like async | Race risk |
| AI-generated empty protocol with one unused type | Ceremony |
| XCTest doesn’t fail when policy inverted | Theater tests |
| Analytics PII logged | Privacy bug |

### 7.3 What AI commonly gets wrong

- Puts debounce in the repository
- Creates UseCase + Interactor + Service that all pass through
- Forgets `Task` cancel on new query
- Writes UITests that sleep for timing
- “Cleans” a screen that should stay MVVM

**Interview readiness:** Have one concrete miss ready (“it placed billing rules in the repository; I moved them to the UseCase and added a unit test”).

## 8. BMS search — full MVVM walkthrough (S3)

### 8.1 Responsibilities

| Piece | Owns |
|---|---|
| Search bar View | Text, forward `onQueryChange`, render state |
| `SearchViewModel` | Debounce, cancel, state enum, map rows |
| `SearchRepository` | Remote/cached results, DTO → `Movie` |
| Ranking | Usually **server**; client filters only if product requires |

### 8.2 Timing policy

- Debounce ~300ms is a **UX/presentation** choice — lives in VM (or UseCase if product-standardized across surfaces).
- Transport may still cancel tasks; it should not know about keystroke cadence.

### 8.3 Out-of-order responses

Without cancel or generation tokens:

```text
Query "a"  → slow response returns later
Query "av" → fast response returns first
UI shows "a" results after user already typed "av"  ← bug
```

Fix: cancel prior work **or** ignore stale generations (monotonic request ID). Prefer cancel + structured concurrency where possible.

### 8.4 Agenda opener for search design

> “I’d put debounce and cancellation in the search ViewModel, keep ranking server-side unless product needs local filter, and model idle/loading/results/empty/error explicitly — that’s how we made BMS search race-safer.”

## 9. Navigation ownership

| Scenario | Owner |
|---|---|
| Simple push after tap | VM emits `NavigationEvent`; thin router or view handles |
| Cross-feature, auth gate, deeplink | Coordinator / app-edge router (S13) |
| Sheet vs push product choice | Product + VM intent; LE sheet (S6) is presentation choice |
| UseCase decides screen stack | ❌ smell |

**Test VMs by asserting events**, not by pushing real `UINavigationController`s.

## 10. Testing pyramid for architecture

| Layer | Test type | Cost | Catch |
|---|---|---|---|
| UseCase | XCTest unit | Low | Policy regressions |
| VM | Unit with fake repo | Low–med | State transitions, cancel |
| Repository | Unit with fake client / URLProtocol | Med | Mapping, cache policy |
| UI | XCUITest / snapshots sparingly | High | Critical flows only |

District (S9): AI-assisted XCTest/XCUITest generation **inside review** — tests are a gate, not a badge.

**Prefer fakes over heavy mocks.** Don’t mock value types needlessly.

## 11. Architecture vs crash-free at scale

Clear ownership + fail-soft states + fewer god objects → fewer nil races and lifecycle bugs. Architecture **reduces blast radius**; it does not replace Crashlytics / IMOC (S8).

Examples of fail-soft:

- Search `.error` with retry instead of crash
- SDUI unknown component skip (Day 10 / S3-A1 design)
- Payment explicit states (S7)

At **30L+ DAU**, silent force-unwraps in fat VCs are incident fuel.

## 12. Trade-off tables (memorize)

### 12.1 Pattern choice

| Choice | When | Cost |
|---|---|---|
| Fat MVVM only | Single team, simple screens | God VMs over time |
| Clean everywhere day 1 | Rarely | Ceremony slows small features |
| MVI for every list | Overkill | Boilerplate; onboarding tax |
| MVVM + selective UseCases | Most production apps | Need discipline on “when” |
| Unidirectional for live/checkout | Multi-source contention | More moving parts |

### 12.2 DI choice

| Choice | When | Cost |
|---|---|---|
| Protocol + constructor | Default | Explicit wiring |
| Feature assembler | Modules / SPM | Ownership of graph |
| DI framework | Large painful graphs | Magic / opacity |
| Service locator | Almost never for domain | Hidden deps |
| Environment-only networking | Convenient demos | Untestable hosts |

### 12.3 Migration choice

| Choice | When | Cost |
|---|---|---|
| Big-bang rewrite | Almost never in live apps | Regression cliffs |
| Strangler + flags | Default | Temporary dual paths |
| New features on new boundaries only | Low-risk start | Legacy rot remains |
| Extract UseCase first | Policy risk high | Needs tests |

## 13. Whiteboard scripts (5 minutes each)

### Script A — Search MVVM

1. Draw View ↔ VM ↔ Repository.
2. Place debounce + cancel on VM.
3. Draw state enum.
4. Mention stale response race.
5. Tie to S3.

### Script B — Free Parking Clean edge

1. Draw VM → UseCase → Repository.
2. Put eligibility in UseCase.
3. Show XCTest on UseCase with fake repo.
4. Tie to S9 migration + AI envelope.

### Script C — “Is Clean overengineering?”

1. Scope: not every screen.
2. Criteria for UseCase.
3. Counterexample: settings toggle stays MVVM.
4. District: extract where billing rules lived.

## 14. Failure modes

| Failure | Cause | Mitigation |
|---|---|---|
| Stale search results | No cancel / generation | Cancel Task; ignore stale IDs |
| Untestable VM | Hidden `URLSession.shared` | Protocol + init injection |
| Ghost navigation | Dual routers | Single nav owner |
| Empty Clean layers | AI/ceremony | Delete pass-through types |
| Billing bug in prod | Rules in UI | UseCase tests + on-call ownership |
| “AI broke prod” narrative | No review gate | Envelope + human review + tests |

## 15. Decision rule card (pin this)

```text
1. Is UI mostly render + simple async? → MVVM
2. Are there non-trivial / shared domain rules? → Add UseCase (Clean edge)
3. Do many async sources fight one state? → Consider MVI / unidirectional
4. Dependencies: protocol + constructor; assembler at module edge
5. Migrate with strangler; AI accelerates inside envelope — you own design
```

## 16. Optional citations (appendix only)

You do **not** need these to study. If interviewers ask sources:

- Clean Architecture (Uncle Bob) — dependency rule concept
- Apple: Testing with XCTest; SwiftUI Data Essentials (state ownership)
- In-repo system design: `ios-system-design/docs/search-autocomplete.md`, `app-modularization.md`

## 17. Bridge to production chapter

Next: [03-production-bridge.md](03-production-bridge.md) — how to speak **S9** and **S3** with honest provenance, including the AI tooling trap.
