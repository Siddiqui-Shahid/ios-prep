# Sample 01 — Layer stack, patterns, and DI (Q&A)

> Guided teaching. Each answer stands alone and ends with **How can I relate to my case** using named work — never S-codes.

---

### Q1. What problem do architecture layers actually solve?

**Answer:**

> Without layers, a button handler talks to the network, parses JSON, applies billing rules, pushes a screen, and fires analytics — all in one place. Tests need the whole app and migrations become archaeology. Layers give each piece one job: the View draws and forwards intents; the ViewModel holds UI state and screen-level async; the UseCase enforces product rules; the Repository decides cache vs remote; the DataSource talks to URLSession or the database. Dependencies point inward toward stable policy, not outward toward UIKit.

**Follow-ups:**


| Follow-up                             | Answer                                                                                     |
| ------------------------------------- | ------------------------------------------------------------------------------------------ |
| Who must never see URLSession?        | The View and usually the ViewModel — transport belongs at the Repository/DataSource edge.  |
| Can a UseCase push a view controller? | No — that is a boundary smell. Emit navigation events or let a Coordinator handle routing. |
| Is this only about folder names?      | No — it is about ownership and test seams, not whether you have a folder called `Domain`.  |


**How can I relate to my case:**

- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---



### Q2. How do MVVM, Clean, and MVI differ in one breath each?

**Answer:**

> **MVVM:** the View observes ViewModel state; the VM owns presentation logic and async for *this screen*. **Clean (as used here):** UseCases and entities sit at the center without importing UIKit; VMs and repositories are adapters at the edge. **MVI / unidirectional:** user Intents flow into a processor, which emits immutable State back to the View, with side effects explicit. Default to MVVM for feature UI; add UseCases where domain rules or migration risk demand it; reach for unidirectional state when many async sources fight over one screen.

**Follow-ups:**


| Follow-up                        | Answer                                                                                                                              |
| -------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------- |
| Interview one-liner to memorize? | “MVVM for feature UI; Clean boundaries when rules or migration risk demand UseCases; unidirectional when async contention is high.” |
| Is Clean “UseCase everywhere”?   | No — ceremony on a settings toggle is waste. Scope UseCases to real policy.                                                         |
| Do you need TCA to sound senior? | No — hand-rolled enum state inside MVVM is often enough; don’t claim frameworks you didn’t ship.                                    |


**How can I relate to my case:**

- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---



### Q3. Draw the layer stack and say what each layer must never own?

**Answer:**

> View → ViewModel → UseCase (optional) → Repository → DataSource. The View renders and forwards taps; it does not decode JSON. The ViewModel owns loading/empty/error presentation state and debounce/cancel for the screen; it does not encode Free Parking billing policy. The UseCase validates eligibility and orchestrates product actions; it does not import SwiftUI. The Repository merges cache and remote and maps DTOs to domain types; it does not decide “if promo then half price.” The DataSource owns URLSession config and raw I/O.

**Follow-ups:**


| Follow-up                                | Answer                                                                                            |
| ---------------------------------------- | ------------------------------------------------------------------------------------------------- |
| Where does debounce live?                | ViewModel (or UseCase if standardized across surfaces) — keystroke timing is presentation policy. |
| Where do billing eligibility rules live? | UseCase — product truth, unit-testable without UI.                                                |
| Where does JSON decode usually happen?   | Repository or DataSource mapping layer — not in the View.                                         |


**How can I relate to my case:**

- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---



### Q4. What is dependency injection without framework religion?

**Answer:**

> DI means passing collaborators in — usually via constructor — instead of reaching for hidden globals like `URLSession.shared` inside a ViewModel. The senior default is protocol boundaries plus `init(repository: SearchRepository)`. Tests inject fakes at the VM or UseCase seam. A feature assembler wires the real graph in production. You do not need Swinject to sound credible; you need visible dependencies and testable seams.

**Follow-ups:**


| Follow-up                                              | Answer                                                                                           |
| ------------------------------------------------------ | ------------------------------------------------------------------------------------------------ |
| What is a service locator and why avoid it for domain? | A global “give me X” registry — convenient but hides deps and makes unit tests painful.          |
| When is SwiftUI `.environment` OK?                     | Theme, locale, shallow UI plumbing — risky as the sole path for networking clients.              |
| What does FeatureAssembler do?                         | Builds URLSession → DataSource → Repository → ViewModel for one feature at the composition root. |


**How can I relate to my case:**

- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---



### Q5. Repository vs UseCase — what question does each answer?

**Answer:**

> A **UseCase** answers “what should the product do?” — eligibility, pricing, multi-step orchestration — without knowing UIKit or URLSession. A **Repository** answers “where do bytes/models come from and go?” — cache TTL, remote fetch, DTO → domain mapping. Billing rules in the Repository next to JSON decode is a smell. URL building inside the UseCase is also wrong. Put policy next to the reason it exists.

**Follow-ups:**


| Follow-up                                   | Answer                                                                       |
| ------------------------------------------- | ---------------------------------------------------------------------------- |
| When is a UseCase overkill?                 | Pure pass-through to one repo method with zero policy — delete the ceremony. |
| Can a UseCase orchestrate two repositories? | Yes — that is a legitimate application action.                               |
| Who owns cache TTL?                         | Repository — with optional policy hints from domain, not billing rules.      |


**How can I relate to my case:**

- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---



### Q6. What is MVI and when is it overkill?

**Answer:**

> MVI loops Intent → Processor/Reducer → immutable State → View, with side effects explicit and often funneled back as result Intents. It wins when checkout, live scoreboards, or payment flows have many async sources mutating one screen and you want replayable intent logs. It is overkill for a CRUD form with one repository call — an enum state machine inside MVVM is often enough (payment states on Day 07 are cousins).

**Follow-ups:**


| Follow-up                           | Answer                                                                                  |
| ----------------------------------- | --------------------------------------------------------------------------------------- |
| MVVM with a state enum vs full MVI? | Same family — choose based on team literacy and async contention, not buzzwords.        |
| Does MVI replace Coordinators?      | No — navigation side effects still belong outside UseCases.                             |
| Hand-rolled vs TCA?                 | Hand-rolled for one complex screen is valid; frameworks buy tooling at onboarding cost. |


**How can I relate to my case:**

- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---



### Q7. What should I say about AI tooling in architecture interviews?

**Answer:**

> Never say “AI wrote our Clean Architecture.” The senior line is **Context Engineering**: you fed boundaries, exemplar PRs, and acceptance tests so AI accelerated scaffolding and test drafts *inside* protocols you owned. Human review caught misplaced rules, missing Task cancellation, and boundary violations. You remain author of record for design, regressions, and on-call fixes — the tool is a typing accelerator, not a substitute for judgment.

**Follow-ups:**


| Follow-up                        | Answer                                                                                  |
| -------------------------------- | --------------------------------------------------------------------------------------- |
| Forbidden phrase?                | “Cursor wrote the migration.”                                                           |
| Safe phrase?                     | “AI drafted migrations inside an envelope I defined; review and XCTest were the gate.”  |
| What does AI commonly get wrong? | Debounce in the repository, empty UseCase layers, missing cancel on new search queries. |


**How can I relate to my case:**

- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

Next: [02-mvvm-clean-mvi.md](02-mvvm-clean-mvi.md)

---



## Brain puzzles (cover → think → check)



### Puzzle A — How do MVVM, Clean, and MVI differ in one breath each

**Ask yourself:** How do MVVM, Clean, and MVI differ in one breath each?

**Answer:** “**MVVM:** the View observes ViewModel state; the VM owns presentation logic and async for *this screen*. **Clean (as used here):** UseCases and entities sit at the center without importing UIKit; VMs and repositories are adapters at the edge. **MVI / unidirectional:** user Intents flow into a processor, which emits immutable State back to the View, with side effects explicit. Default to MVVM for feature UI; add UseCases where domain rules or migration risk demand it; reach for unidirectional state when many async sources fight over one screen.”

### Puzzle B — Draw the layer stack and say what each layer must never own

**Ask yourself:** Draw the layer stack and say what each layer must never own?

**Answer:** “View → ViewModel → UseCase (optional) → Repository → DataSource. The View renders and forwards taps; it does not decode JSON. The ViewModel owns loading/empty/error presentation state and debounce/cancel for the screen; it does not encode Free Parking billing policy. The UseCase validates eligibility and orchestrates product actions; it does not import SwiftUI. The Repository merges cache and remote and maps DTOs to domain types; it does not decide “if promo then half price.” The DataSource owns URLSession config and raw I/O.”

### Puzzle C — What is dependency injection without framework religion

**Ask yourself:** What is dependency injection without framework religion?

**Answer:** “DI means passing collaborators in — usually via constructor — instead of reaching for hidden globals like `URLSession.shared` inside a ViewModel. The senior default is protocol boundaries plus `init(repository: SearchRepository)`. Tests inject fakes at the VM or UseCase seam. A feature assembler wires the real graph in production. You do not need Swinject to sound credible; you need visible dependencies and testable seams.”