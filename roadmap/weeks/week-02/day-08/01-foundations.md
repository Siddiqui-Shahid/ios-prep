# 01 — Foundations: What Architecture Layers Actually Are (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Simple language. Named work only — never S-codes in speech.

---

### Q1. Plain-English mental model? `(45–60s)`
**Answer:**

> “UI frameworks render pixels. Architecture decides where truth lives and who is allowed to change it. Without layers:.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q2. Glossary (learn these cold)? `(45–60s)`
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

### Q3. Why interviewers care? `(45–60s)`
**Answer:**

> “A senior architecture answer proves you can: - Scope ceremony — not Clean-everywhere, not MVC-forever. - Draw ownership (who cancels Tasks? who owns billing rules?). - Make features testable without launching the app. - Migrate live apps without hero rewrites. - Talk about AI tooling without sounding like you outsourced judgment.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q4. Pattern map (45-second HLD)? `(45–60s)`
**Answer:**

> “Interview line (memorize):.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q5. Layer shape (60-second HLD)? `(45–60s)`
**Answer:**

> “text View (SwiftUI / UIKit) → ViewModel / Presenter (UI state, mapping, user intents, cancel Tasks) → UseCase / Interactor (optional; business rules, orchestration) → Repository (cache + remote policy, DTO ↔ domain) → DataSource (URLSession, DB, CMS) Dependency rule: arrows point inward toward policies you want stable. UI frameworks sit at the outside. Domain must not import UIKit/SwiftUI.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q6. Intern path: one happy search? `(45–60s)`
**Answer:**

> “1. User types in SearchView. 2. View calls viewModel.onQueryChange("aveng"). 3. ViewModel debounces ~300ms, cancels the previous Task, sets state to .loading. 4. ViewModel asks SearchRepository.search(query:). 5. Repository hits remote (and maybe cache), returns domain Movie models. 6. ViewModel maps to .results([...]) or .empty. 7. View renders. Failure branches you must name:.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q7. Intern path: Free Parking with a UseCase? `(45–60s)`
**Answer:**

> “1. User confirms a billing adjustment on a Free Parking screen. 2. ViewModel forwards a typed input (ParkingAdjustmentRequest) — not raw form strings forever. 3. AdjustFreeParkingBilling UseCase validates policy (eligibility, amounts, idempotency key if needed). 4. UseCase calls BillingRepository to persist / sync. 5. ViewModel maps success/failure → presentation state. 6. Analytics / navigation happen via injected clients or emitted events — not buried inside the UseCase as UIKit pushes. Why extract the UseCase? Billing rules are product truth. They should be unit-tested without spinning UI. At District, Free Parking lived next to an MVVM↔Clean migration — extract where rules hurt, leave simple chrome as MVVM.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q8. DI without dogma (intern picture)? `(45–60s)`
**Answer:**

> “Bad: swift final class SearchViewModel { func search { URLSession.shared.dataTask(...) // hidden dependency } }.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q9. AI tooling — the seniority filter? `(45–60s)`
**Answer:**

> “Wrong interview framing: “Cursor wrote our Clean Architecture.” Right framing:.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q10. Where things go wrong (preview of deep dive)? `(45–60s)`
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

### Q11. District · S9 — Free Parking + migration? `(45–60s)`
**Answer:**

> “Shipped Free Parking billing adjustments while migrating patterns across MVVM and Clean. Used AI inside a strict envelope (reviews + XCTest/XCUITest). You own architecture.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q12. BookMyShow · S3 — Search MVVM? `(45–60s)`
**Answer:**

> “Debounced search with explicit states and cancellation — race-safer UX on a high-traffic surface. Header SDUI is Day 10; today’s beat is the search VM shape.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q13. Self-check before deep dive? `(45–60s)`
**Answer:**

> “You are ready for 02-deep-dive.md when you can say aloud: 1. MVVM vs Clean in one sentence each. 2. What a Repository owns vs a UseCase. 3. Why debounce lives in the VM (or UseCase), not the transport layer. 4. Why “AI wrote it” is the wrong line. 5. The five presentation states for search.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q14. Flash preview (foundations only)? `(45–60s)`
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
