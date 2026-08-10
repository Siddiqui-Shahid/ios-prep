# 02 — Deep Dive: Layering, DI, Migration, MVI, Search (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Simple language. Named work only — never S-codes in speech.

---

### Q1. Ownership matrix (interview gold)? `(45–60s)`
**Answer:**

> “Senior one-liner: Put policy next to the reason it exists. Timing of keystrokes is presentation. Eligibility of Free Parking adjustment is domain. HTTP caching is data.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q2. State enum beats boolean soup? `(45–60s)`
**Answer:**

> “swift enum SearchUIState: Equatable { case idle case loading(query: String) case results([MovieRow]) case empty(query: String) case error(message: String, query: String) } Booleans (isLoading, hasError, isEmpty) create impossible combinations (isLoading && hasError). Enums make illegal states unrepresentable — same lesson as Day 01.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q3. UIKit binding styles? `(45–60s)`
**Answer:**

> “See the notes for this topic and speak the core idea in simple words.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q4. SwiftUI binding styles? `(45–60s)`
**Answer:**

> “Trap: Duplicating every toggle into the VM. Hoist async/domain; keep pure UI local (Day 12 expands).”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q5. Cancellation is part of MVVM? `(45–60s)`
**Answer:**

> “text onQueryChange(q) → debounce wait → cancel previous Task → state = loading → await repo → if Task.isCancelled: return → apply state Without cancel, slow responses overwrite newer queries → “racey search.” BMS search is the production proof: debounce + explicit states + race-safer UX.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q6. What “Clean” means here? `(45–60s)`
**Answer:**

> “Not “I have Domain/Data/Presentation folders.” It means: 1. Entities / domain types don’t import UIKit/SwiftUI. 2. UseCases express application actions and can be tested with fakes. 3. Adapters (VM, Repository implementations) sit at the edges. 4. Dependencies point inward.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q7. When to introduce a UseCase? `(45–60s)`
**Answer:**

> “Introduce when at least one is true: - Rules are non-trivial (eligibility, pricing, multi-step orchestration). - Same action is shared across screens / entry points. - You’re migrating and need a stable seam under a fat VC/VM. - You want the cheapest regression net (unit tests on policy).”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q8. Free Parking shape (illustrative)? `(45–60s)`
**Answer:**

> “text AdjustFreeParkingBilling input: ParkingAdjustmentRequest output: ParkingAdjustmentResult deps: BillingRepository, Clock, (optional) IdempotencyStore Steps: 1. Validate request (amounts, user eligibility) 2. Apply domain policy 3. Persist via repository 4. Return typed result.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q9. Repository vs UseCase — the confusion interviewers love? `(45–60s)`
**Answer:**

> “Wrong: Put “if free parking promo then waive fee” next to JSON decoding. Wrong: Put URL building inside the UseCase.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q10. Loop? `(45–60s)`
**Answer:**

> “text View --Intent--> Store/Processor --State--> View │ └── Effect (network, analytics) ──► Intent (result).”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q11. When MVI wins? `(45–60s)`
**Answer:**

> “- Multiple async sources mutate one screen (live scoreboard, checkout with polling + user edits). - You need a replayable log of intents for debugging. - Team already standardized on unidirectional patterns.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q12. When MVI is overkill? `(45–60s)`
**Answer:**

> “- CRUD forms with one repository call. - Junior-heavy team with no reducer literacy yet. - You only needed an enum state machine inside an MVVM VM (often enough — payment states are cousins).”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q13. Relation to TCA / Redux-ish frameworks? `(45–60s)`
**Answer:**

> “Same family. Frameworks buy structure and tooling; cost is boilerplate and onboarding. Hand-rolled unidirectional for one complex screen is valid. Don’t claim “we use TCA” unless you do. Interview line: “Unidirectional when async contention is high; MVVM+enum state when it’s not.”.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q14. Feature assembler? `(45–60s)`
**Answer:**

> “text FeatureAssembler builds: URLSessionClient → RemoteSearchDataSource → SearchRepository → SearchViewModel → SearchView / SearchViewController Production composition root (app or feature module) owns wiring. Tests skip the assembler and inject fakes at the VM/UseCase boundary.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q15. Protocol granularity? `(45–60s)`
**Answer:**

> “Prefer protocols at boundaries (network, persistence, analytics, clock). Don’t protocol every internal struct.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q16. Circular dependencies? `(45–60s)`
**Answer:**

> “Smell: UseCase needs Router, Router needs UseCase to decide destination. Fixes:.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q17. SwiftUI Environment as DI? `(45–60s)`
**Answer:**

> “SDKs (Day 12 / ) prefer explicit init injection so hosts see dependencies.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q18. DI frameworks on iOS? `(45–60s)`
**Answer:**

> “Optional. Manual constructor DI + factories until graph pain is real. Frameworks help large graphs; cost is magic and opacity. Protocols first — always.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q19. Smells? `(45–60s)`
**Answer:**

> “- Stringly URLs / endpoint paths in the VM - Switch on HTTP status codes - Business eligibility checks - Direct navigationController?.push - 800-line file “just for this screen” - Hard to unit test without URLProtocol gymnastics at the VM layer.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q20. Extraction order (District-style strangler)? `(45–60s)`
**Answer:**

> “1. Freeze contracts — API shapes, analytics names, nav entry points. 2. Characterization tests — lock current behavior where risk is high. 3. Extract UseCase under the VM — VM becomes adapter; behavior unchanged. 4. Unit test UseCase with fakes (cheapest confidence). 5. Extract Repository if VM still speaks DTO/HTTP. 6. Router/Coordinator for cross-feature nav. 7. Delete dead paths; keep feature flags for rollback if needed. Do not rewrite the whole module in one PR while shipping Free Parking. Ship value while migrating.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q21. MVVM ↔ Clean migration playbook (S9)? `(45–60s)`
**Answer:**

> “text Legacy fat layer │ ├─ new Free Parking flow on UseCase + thin VM ✅ ship value ├─ strangler: old screens call new UseCase ├─ AI scaffolds tests/migrations inside envelope └─ human review: boundary checklist + on-call ownership.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q22. Context Engineering envelope (what to feed AI)? `(45–60s)`
**Answer:**

> “- Layering rules doc (“no UIKit in UseCase”, “no URLSession in VM”) - One exemplar PR of a good extraction - Acceptance tests / failing tests first when possible - Naming conventions already in the module.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q23. Review checklist (human gate)? `(45–60s)`
**Answer:**

> “See the notes for this topic and speak the core idea in simple words.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q24. What AI commonly gets wrong? `(45–60s)`
**Answer:**

> “- Puts debounce in the repository - Creates UseCase + Interactor + Service that all pass through - Forgets Task cancel on new query - Writes UITests that sleep for timing - “Cleans” a screen that should stay MVVM Interview readiness: Have one concrete miss ready (“it placed billing rules in the repository; I moved them to the UseCase and added a unit test”).”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q25. Responsibilities? `(45–60s)`
**Answer:**

> “See the notes for this topic and speak the core idea in simple words.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q26. Timing policy? `(45–60s)`
**Answer:**

> “- Debounce ~300ms is a UX/presentation choice — lives in VM (or UseCase if product-standardized across surfaces). - Transport may still cancel tasks; it should not know about keystroke cadence.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q27. Out-of-order responses? `(45–60s)`
**Answer:**

> “Without cancel or generation tokens: text Query "a" → slow response returns later Query "av" → fast response returns first UI shows "a" results after user already typed "av" ← bug.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q28. Agenda opener for search design? `(45–60s)`
**Answer:**

> “I’d put debounce and cancellation in the search ViewModel, keep ranking server-side unless product needs local filter, and model idle/loading/results/empty/error explicitly — that’s how we made BMS search race-safer.”.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q29. Navigation ownership? `(45–60s)`
**Answer:**

> “Test VMs by asserting events, not by pushing real UINavigationControllers.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q30. Testing pyramid for architecture? `(45–60s)`
**Answer:**

> “District: AI-assisted XCTest/XCUITest generation inside review — tests are a gate, not a badge.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q31. Architecture vs crash-free at scale? `(45–60s)`
**Answer:**

> “Clear ownership + fail-soft states + fewer god objects → fewer nil races and lifecycle bugs. Architecture reduces blast radius; it does not replace Crashlytics / IMOC. Examples of fail-soft:.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q32. Pattern choice? `(45–60s)`
**Answer:**

> “See the notes for this topic and speak the core idea in simple words.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q33. DI choice? `(45–60s)`
**Answer:**

> “See the notes for this topic and speak the core idea in simple words.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q34. Migration choice? `(45–60s)`
**Answer:**

> “See the notes for this topic and speak the core idea in simple words.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q35. Script A — Search MVVM? `(45–60s)`
**Answer:**

> “1. Draw View ↔ VM ↔ Repository. 2. Place debounce + cancel on VM. 3. Draw state enum. 4. Mention stale response race. 5. Tie to .”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q36. Script B — Free Parking Clean edge? `(45–60s)`
**Answer:**

> “1. Draw VM → UseCase → Repository. 2. Put eligibility in UseCase. 3. Show XCTest on UseCase with fake repo. 4. Tie to migration + AI envelope.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q37. Script C — “Is Clean overengineering?”? `(45–60s)`
**Answer:**

> “1. Scope: not every screen. 2. Criteria for UseCase. 3. Counterexample: settings toggle stays MVVM. 4. District: extract where billing rules lived.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q38. Failure modes? `(45–60s)`
**Answer:**

> “See the notes for this topic and speak the core idea in simple words.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q39. Decision rule card (pin this)? `(45–60s)`
**Answer:**

> “text 1. Is UI mostly render + simple async? → MVVM 2. Are there non-trivial / shared domain rules? → Add UseCase (Clean edge) 3. Do many async sources fight one state? → Consider MVI / unidirectional 4. Dependencies: protocol + constructor; assembler at module edge 5. Migrate with strangler; AI accelerates inside envelope — you own design.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q40. Optional citations (appendix only)? `(45–60s)`
**Answer:**

> “You do not need these to study. If interviewers ask sources: - Clean Architecture (Uncle Bob) — dependency rule concept - Apple: Testing with XCTest; SwiftUI Data Essentials (state ownership) - In-repo system design: ios-system-design/docs/search-autocomplete.md, app-modularization.md.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q41. Bridge to production chapter? `(45–60s)`
**Answer:**

> “Next: 03-production-bridge.md — how to speak and with honest provenance, including the AI tooling trap.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---
