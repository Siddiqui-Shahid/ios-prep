# Sample 02 — MVVM, Clean boundaries, and migration (Q&A)

> Guided teaching. Links point at deep dive modules and learning-lab code.

---

### Q1. Why use a state enum instead of boolean flags in a ViewModel?
**Answer:**

> Booleans like `isLoading`, `hasError`, and `isEmpty` can combine into impossible states — loading and error at once. An enum such as `idle`, `loading(query:)`, `results`, `empty`, and `error` makes illegal combinations unrepresentable. The View switches on one source of truth, which simplifies SwiftUI/UIKit binding and unit tests that assert transitions.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Is empty the same as error? | No — empty is a valid success with zero hits; error is transport/decode failure with retry. |
| SwiftUI binding path? | `@Observable` VM (iOS 17+) or `@Published` on `ObservableObject` — hoist async state, keep pure UI local. |
| What about cancelled search? | Cancellation is not an error state — ignore or return to idle; don’t show a red banner. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q2. When should you introduce a UseCase?
**Answer:**

> Introduce a UseCase when at least one is true: rules are non-trivial (eligibility, pricing, idempotency); the same action is shared across screens; you are migrating a fat VC/VM and need a stable seam; or you want cheap unit tests on policy. Skip when the screen is a settings toggle with no domain, or the UseCase would only pass through to one repository method with zero logic — that is ceremony, not architecture.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Free Parking example? | `AdjustFreeParkingBilling` validates request, applies policy, persists via repository — VM maps result to UI only. |
| Anemic UseCase smell? | One-line forward to repo with no policy — maybe you didn’t need the type. |
| Can AI scaffold a UseCase safely? | Only inside a review envelope with boundary checklist and failing tests first. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q3. What are the smells of a fat ViewModel and how do you surgery it?
**Answer:**

> Smells include stringly URLs in the VM, HTTP status switches, billing eligibility checks, direct `navigationController?.push`, and 800-line files that resist unit tests without URLProtocol hacks at the VM layer. Surgery order: freeze contracts; add characterization tests where risk is high; extract UseCase under the VM so behavior stays the same; unit test policy with fakes; extract Repository if DTO/HTTP still leaks; add Router/Coordinator for navigation; delete dead paths. Ship value while migrating — strangler, not big-bang rewrite.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Where do navigation side effects go? | VM emits `NavigationEvent`; Coordinator or thin router observes — UseCase never pushes. |
| Business rules still in VM after extract? | Move to UseCase and add a unit test that fails when policy inverts. |
| District District Free Parking + Clean/MVVM + AI tooling migration style? | New Free Parking on UseCase + thin VM while old screens call new UseCase behind flags. |

**How can I relate to my case:**
- **Shipped:** District Free Parking + Clean/MVVM + AI tooling
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q4. How does a feature assembler fit the DI graph?
**Answer:**

> The assembler is the composition root for one feature: it builds URLSession client → remote data source → repository → view model → view/controller. Production code uses the assembler once at module startup; tests skip it and inject fakes directly into the ViewModel or UseCase. That keeps wiring explicit without a global service locator.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Protocol granularity tip? | `SearchRepository` at the boundary — not `DoesEverythingService`. |
| Circular dependency smell? | UseCase needs Router and Router needs UseCase — split protocols or emit events from VM. |
| DI framework required? | No — manual constructor DI until graph pain is real. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q5. How do you test architecture layers without launching the app?
**Answer:**

> UseCase XCTest units are the cheapest net for policy regressions — fake the repository, assert eligibility and error mapping. ViewModel tests use fake repos to assert state transitions and cancellation. Repository tests use fake network clients or URLProtocol for mapping and cache policy. Reserve XCUITest for critical flows — District used AI-assisted test drafts, but human review was the gate. Prefer fakes over heavy mocks of value types.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| How test navigation without pushing real VCs? | Assert emitted navigation events from the VM. |
| What makes a XCTest “theater”? | It passes when policy is inverted — tests must fail when rules break. |
| UITest timing trap? | AI-generated sleeps for debounce — use deterministic fakes instead. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q6. How does clear architecture relate to crash-free culture at scale?
**Answer:**

> Clear ownership, explicit fail-soft states, and fewer god objects reduce nil races and lifecycle bugs — at 30L+ DAU, force-unwraps in fat view controllers are incident fuel. Architecture shrinks blast radius: search shows `.error` with retry instead of crashing; SDUI skips unknown components (Day 10). It does not replace Crashlytics triage or IMOC — BookMyShow IMOC + crash-free at scale reliability culture still owns production metrics.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Does Clean guarantee crash-free? | No — it makes bugs easier to isolate and test away. |
| Fail-soft search example? | Decode failure → error state + metric, not `fatalError` on bad JSON. |
| Payment states connection? | Explicit enum states (BookMyShow payment processing-status popup) are cousins of MVVM state machines. |

**How can I relate to my case:**
- **Shipped:** BookMyShow payment processing-status popup; BookMyShow IMOC + crash-free at scale
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented checkout drop-off % from the status popup alone.

---

### Q7. What is the decision rule card for picking a pattern?
**Answer:**

> (1) UI mostly render + simple async → MVVM. (2) Non-trivial or shared domain rules → add UseCase. (3) Many async sources fight one state → consider MVI/unidirectional. (4) Dependencies: protocol + constructor; assembler at module edge. (5) Migrate with strangler; AI accelerates inside an envelope you own. Counterexample: a settings toggle stays MVVM — don’t Clean-ceremony everything.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| “Isn’t Clean overengineering?” | Scope it — extract where billing lived at District; MVVM for simple chrome. |
| Big-bang rewrite? | Almost never on live apps — flags and dual paths until strangler wins. |
| Environment-only networking? | Convenient for demos; untestable for SDK hosts — prefer explicit init injection. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q8. Who owns navigation — Coordinator vs Router vs `NavigationPath`?
**Answer:**

> There’s no absolute rule. For a simple push after a row tap, the ViewModel emits a `NavigationEvent` and the view or a thin router performs it. **Cross-feature flows, auth gates, and deeplinks** belong in a **Coordinator / app-edge Router** so VMs stay testable and you avoid dual stacks. In SwiftUI, `NavigationPath` and deeplink handlers live at the **app edge** — Grizzlies taught deliberate ownership (Hybrid UI / deeplinks adjacent). UseCases must never push UIKit controllers. Test ViewModels by asserting events, not by pushing real `UINavigationController`s. Sheet vs push stays a product/presentation choice (LE sheet / BookMyShow LE Bottom Sheet), not a domain decision.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Always VM or always Coordinator? | Trap — split by complexity and testability. |
| UseCase push? | Never — boundary smell. |
| Deep links? | Parse at app boundary → typed intent → single router (Hybrid UI / deeplinks). |
| SwiftUI path ownership? | `NavigationPath` at the edge — not buried in every feature UseCase. |

**How can I relate to my case:**
- **Shipped:** Hybrid UI / deeplinks; BookMyShow LE Bottom Sheet
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

Next: [03-search-cancel-states.md](03-search-cancel-states.md)

---

## Brain puzzles (cover → think → check)

### Puzzle A — When should you introduce a UseCase

**Ask yourself:** When should you introduce a UseCase?

**Answer:** “Introduce a UseCase when at least one is true: rules are non-trivial (eligibility, pricing, idempotency); the same action is shared across screens; you are migrating a fat VC/VM and need a stable seam; or you want cheap unit tests on policy. Skip when the screen is a settings toggle with no domain, or the UseCase would only pass through to one repository method with zero logic — that is ceremony, not architecture.”

### Puzzle B — What are the smells of a fat ViewModel and how do you surgery it

**Ask yourself:** What are the smells of a fat ViewModel and how do you surgery it?

**Answer:** “Smells include stringly URLs in the VM, HTTP status switches, billing eligibility checks, direct `navigationController?.push`, and 800-line files that resist unit tests without URLProtocol hacks at the VM layer. Surgery order: freeze contracts; add characterization tests where risk is high; extract UseCase under the VM so behavior stays the same; unit test policy with fakes; extract Repository if DTO/HTTP still leaks; add Router/Coordinator for navigation; delete dead paths. Ship value while migrating — strangler, not big-bang rewrite.”

### Puzzle C — How does a feature assembler fit the DI graph

**Ask yourself:** How does a feature assembler fit the DI graph?

**Answer:** “The assembler is the composition root for one feature: it builds URLSession client → remote data source → repository → view model → view/controller. Production code uses the assembler once at module startup; tests skip it and inject fakes directly into the ViewModel or UseCase. That keeps wiring explicit without a global service locator.”
