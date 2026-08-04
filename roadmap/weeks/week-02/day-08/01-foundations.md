# 01 — Foundations: What Architecture Layers Actually Are

> Read this before the deep dive. Goal: build a mental model an intern can repeat, then raise it to senior vocabulary.

## 1. Plain-English mental model

UI frameworks render pixels. **Architecture** decides *where truth lives* and *who is allowed to change it*.

Without layers:

- A button handler talks to the network, parses JSON, applies billing rules, pushes a screen, and fires analytics.
- Tests require the whole app.
- Migrations become archaeology.

With layers, each piece has **one job**:

| Piece | Job in one sentence |
|---|---|
| **View** | Draw state; forward user intents. |
| **ViewModel / Presenter** | Hold UI state; map domain → display; orchestrate async for *this screen*. |
| **UseCase / Interactor** | Enforce product/business rules independent of UIKit/SwiftUI. |
| **Repository** | Decide cache vs network; hide DTOs. |
| **DataSource** | Talk to URLSession, DB, CMS, Keychain. |

Think of a restaurant:

| Kitchen metaphor | Architecture piece |
|---|---|
| Dining room | View |
| Waiter taking orders + describing dishes | ViewModel |
| Chef following recipes | UseCase |
| Pantry + supplier contracts | Repository |
| Delivery truck / fridge sensors | DataSource |

If the waiter starts cooking *and* rewriting supplier contracts, service collapses under load — the mobile equivalent of a fat ViewController / fat ViewModel.

## 2. Glossary (learn these cold)

| Term | Meaning |
|---|---|
| **MVC** | Model–View–Controller. In UIKit practice, Controllers often absorb networking + state → “Massive View Controller.” |
| **MVVM** | Model–View–ViewModel. View observes state; VM owns presentation logic and screen async. |
| **Clean Architecture** | Concentric dependency rule: inner domain doesn’t import UI/frameworks. UseCases + Entities at the center. |
| **Entity** | Core domain type (e.g. `ParkingAdjustment`) with rules that aren’t UI strings. |
| **UseCase / Interactor** | One application action: inputs → policy → outputs. Unit-testable without views. |
| **Repository** | Abstraction over data sources; owns merge/cache policy, not product billing rules. |
| **DTO** | Data Transfer Object — wire/decode shape. Map to domain before UseCase/VM if shapes diverge. |
| **MVI / Unidirectional** | Intent → reduce/process → immutable State → View. Side effects explicit. |
| **Intent** | User or system event (“queryChanged”, “retryTapped”). |
| **Reducer / Processor** | Pure(ish) function: `(State, Intent) → State` (+ effects). |
| **DI (Dependency Injection)** | Pass collaborators in (usually constructors) instead of constructing hidden globals. |
| **Protocol boundary** | Abstract dependency at a seam (`SearchRepository`, `BillingAdjusting`). |
| **Constructor injection** | `init(repo: SearchRepository)` — default senior choice. |
| **Factory / Assembler** | Builds the object graph for a feature/module. |
| **Service locator** | Global “give me X” registry — convenient, hides deps, hard tests. Avoid for domain. |
| **Strangler migration** | Incrementally replace old paths behind stable contracts instead of big-bang rewrite. |
| **Context Engineering** | Feeding AI tools boundaries, examples, acceptance criteria so output stays inside your architecture. |
| **Fat ViewModel** | VM that owns networking strings, routing, analytics dumps, *and* business rules. |
| **Presentation state** | What the screen shows: idle / loading / content / empty / error (often an enum). |
| **Coordinator / Router** | Owns navigation side effects so VMs stay testable. |

## 3. Why interviewers care

A senior architecture answer proves you can:

- **Scope ceremony** — not Clean-everywhere, not MVC-forever.
- Draw **ownership** (who cancels Tasks? who owns billing rules?).
- Make features **testable** without launching the app.
- Migrate **live apps** without hero rewrites.
- Talk about **AI tooling** without sounding like you outsourced judgment.

You do **not** need TCA, RIBs, or a DI container to sound senior. Clear boundaries + honest trade-offs beat framework name-dropping.

## 4. Pattern map (45-second HLD)

| Pattern | Core idea | UI binding | Best fit |
|---|---|---|---|
| **MVC** | VC mediates Model ↔ View | Imperative outlets | Tiny screens; legacy UIKit islands |
| **MVVM** | View observes VM state; VM holds presentation + screen async | Closures / Combine / Observation | Feature screens, search, forms |
| **Clean** | UseCases + entities independent of UI | VM/Presenter as adapter at the edge | Multi-team modules, migrations, heavy domain |
| **MVI / unidirectional** | Intent → State → View; effects explicit | Single state stream | Checkout, live scoreboard, multi-source fights |

**Interview line (memorize):**

> “I default to MVVM for feature UI. I introduce Clean boundaries when domain rules, reuse, or migration risk demand an explicit UseCase layer. I use unidirectional state when many async sources fight over one screen.”

## 5. Layer shape (60-second HLD)

```text
View (SwiftUI / UIKit)
  → ViewModel / Presenter   (UI state, mapping, user intents, cancel Tasks)
    → UseCase / Interactor  (optional; business rules, orchestration)
      → Repository          (cache + remote policy, DTO ↔ domain)
        → DataSource        (URLSession, DB, CMS)
```

**Dependency rule:** arrows point **inward** toward policies you want stable. UI frameworks sit at the outside. Domain must not import UIKit/SwiftUI.

Speak this aloud once. Then add: “Views never see URLSession. UseCases never push view controllers. Repositories don’t encode Free Parking billing policy.”

## 6. Intern path: one happy search

1. User types in `SearchView`.
2. View calls `viewModel.onQueryChange("aveng")`.
3. ViewModel debounces ~300ms, cancels the previous `Task`, sets state to `.loading`.
4. ViewModel asks `SearchRepository.search(query:)`.
5. Repository hits remote (and maybe cache), returns domain `Movie` models.
6. ViewModel maps to `.results([...])` or `.empty`.
7. View renders.

Failure branches you must name:

| What happened | Typical mapping |
|---|---|
| User keeps typing | Cancel prior Task; don’t apply stale results |
| Offline / timeout | `.error` with retry intent |
| Empty hit list | `.empty` (not an error) |
| Task cancelled | Ignore — not a user-facing error |
| Decode / contract break | Error + metric; don’t crash |

## 7. Intern path: Free Parking with a UseCase

1. User confirms a billing adjustment on a Free Parking screen.
2. ViewModel forwards a typed input (`ParkingAdjustmentRequest`) — not raw form strings forever.
3. `AdjustFreeParkingBilling` UseCase validates policy (eligibility, amounts, idempotency key if needed).
4. UseCase calls `BillingRepository` to persist / sync.
5. ViewModel maps success/failure → presentation state.
6. Analytics / navigation happen via injected clients or emitted events — not buried inside the UseCase as UIKit pushes.

**Why extract the UseCase?** Billing rules are product truth. They should be unit-tested without spinning UI. At District, Free Parking lived next to an MVVM↔Clean migration — extract where rules hurt, leave simple chrome as MVVM.

## 8. DI without dogma (intern picture)

Bad:

```swift
final class SearchViewModel {
    func search() {
        URLSession.shared.dataTask(...) // hidden dependency
    }
}
```

Better:

```swift
protocol SearchRepository: Sendable {
    func search(query: String) async throws -> [Movie]
}

final class SearchViewModel {
    private let repository: SearchRepository
    init(repository: SearchRepository) { self.repository = repository }
}
```

Tests inject a fake. Production assembler wires the real repository. That is DI — no container required.

| Technique | When | Cost |
|---|---|---|
| Constructor injection of protocols | Default for VMs / UseCases | Init boilerplate |
| Feature factory / assembler | Module boundaries, SPM | Need clear graph ownership |
| SwiftUI `.environment` | UI-tree plumbing (theme, shallow deps) | Easy to hide networking |
| Service locator / app singleton | Avoid for domain | Untestable coupling |

## 9. AI tooling — the seniority filter

**Wrong interview framing:** “Cursor wrote our Clean Architecture.”

**Right framing (S9):**

> “I used Context Engineering — boundaries, existing patterns, acceptance tests — so AI accelerated scaffolding and test drafts inside protocols I owned. Review and regressions stayed human.”

AI is a **force multiplier for typing**, not a substitute for:

- Choosing MVVM vs Clean for a screen
- Placing debounce/cancel
- Deciding what is a UseCase vs Repository
- Owning on-call fixes when billing breaks

## 10. Where things go wrong (preview of deep dive)

| Smell | Symptom | Fix direction |
|---|---|---|
| Fat VM | Networking URLs + routing + rules | Extract UseCase + Router |
| Anemic UseCase | Pass-through to repo with no policy | Maybe you didn’t need it |
| Business rules in Repository | “If promo then half price” next to JSON decode | Move to UseCase |
| Navigation in UseCase | `nav.push(...)` | Emit event / Coordinator |
| Debounce in URLSession | Timing policy leak | Debounce in VM/UseCase |
| AI-generated empty layers | Folders without ownership | Delete ceremony; keep seams that tests need |

## 11. Two production anchors (preview)

### District · S9 — Free Parking + migration

Shipped Free Parking billing adjustments while migrating patterns across MVVM and Clean. Used AI inside a strict envelope (reviews + XCTest/XCUITest). You own architecture.

### BookMyShow · S3 — Search MVVM

Debounced search with explicit states and cancellation — race-safer UX on a high-traffic surface. Header SDUI is Day 10; today’s beat is the **search VM shape**.

## 12. Self-check before deep dive

You are ready for `02-deep-dive.md` when you can say aloud:

1. MVVM vs Clean in one sentence each.
2. What a Repository owns vs a UseCase.
3. Why debounce lives in the VM (or UseCase), not the transport layer.
4. Why “AI wrote it” is the wrong S9 line.
5. The five presentation states for search.

## 13. Flash preview (foundations only)

| Front | Back |
|---|---|
| View duty | Render + forward intents |
| VM duty | UI state + screen async + mapping |
| UseCase duty | Product/business policy |
| Repository duty | Cache/remote + DTO map |
| DI default | Protocol + constructor |
| S9 AI line | Accelerator inside envelope |
| S3 search keys | Debounce + cancel + states |
