# Sample 04 — Free Parking architecture & backend-driven search (Q&A)

> Guided teaching. Separates **shipped** named cases from **design-if-asked** and **lab-only** so you never blur them in an interview.

---

### Q1. What can you claim under District Free Parking + Clean/MVVM + AI tooling?
**Answer:**

> District Free Parking + Clean/MVVM + AI tooling is District **Free Parking** billing adjustments shipped while **migrating MVVM↔Clean incrementally**; **Context Engineering** with Cursor/Claude/Copilot inside boundaries you owned; AI-assisted **reviews and XCTest/XCUITest drafts** with human review; **structured logging** for on-call production fixes. You may **not** say “AI wrote our architecture,” claim the entire District app was Clean-ified, or invent velocity or billing savings percentages.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| 60s District Free Parking + Clean/MVVM + AI tooling version? | Free Parking ship → incremental MVVM/Clean → AI inside envelope + tests → owned regressions. |
| On-call ownership? | Yes — you handled production fixes when issues surfaced; that is part of District Free Parking + Clean/MVVM + AI tooling. |
| Forbidden phrase? | “We Clean Architecture’d the entire District app.” |

**How can I relate to my case:**
- **Shipped:** District Free Parking + Clean/MVVM + AI tooling
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q2. How do you speak about AI tooling without sounding like you outsourced design?
**Answer:**

> Say AI was an **accelerator inside a strict architectural envelope**: you fed layering rules, exemplar PRs, and acceptance intent; AI drafted scaffolding and tests; you reviewed for boundary violations, races, and naming. Tests were a gate, not a substitute for judgment. You are author of record — the tool is not. Context Engineering is the control plane, not “the model designed Free Parking.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Safe script fragment? | “AI drafted migrations/tests; I owned boundaries and regressions.” |
| What review checklist catches? | UseCase importing UIKit, VM building URLRequest, missing cancellation, theater tests. |
| Concrete AI miss to mention? | Billing rules placed in repository — moved to UseCase + unit test. |

**How can I relate to my case:**
- **Shipped:** None for this prompt — keep it conceptual unless they ask for a case.
- **Design if asked:** N/A
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q3. What is the District Free Parking + Clean/MVVM + AI tooling STAR story in plain steps?
**Answer:**

> **Situation:** Ship Free Parking billing adjustments while moving patterns across MVVM and Clean without a regression cliff. **Action:** Deliver the feature; extract UseCase boundaries where domain rules lived; leave simple UI as MVVM; use Context Engineering so AI stayed inside protocols; accelerate test drafts with review; use structured logging on-call. **Result:** Feature shipped; migration progressed with velocity and discipline — not “AI shipped it.” **Lesson:** Boundaries first; AI accelerates typing once the envelope is clear.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Strangler vs big-bang? | Strangler — new Free Parking on new boundaries; old screens call new UseCase over time. |
| MVI/TCA at District? | Discuss as pattern judgment only — not a verified adoption claim. |
| Tie search in 3 min District Free Parking + Clean/MVVM + AI tooling? | Mention BookMyShow backend-driven header & search only if asked — keep District Free Parking + Clean/MVVM + AI tooling primary for architecture behavioral questions. |

**How can I relate to my case:**
- **Shipped:** BookMyShow backend-driven header & search; District Free Parking + Clean/MVVM + AI tooling
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q4. What can you claim under BookMyShow backend-driven header & search for search?
**Answer:**

> BookMyShow backend-driven header & search for today’s beat: BMS search used **MVVM** with **debounce**, **in-flight cancellation**, and explicit **loading/empty/error** (plus idle/results) states — race-safer UX on a high-traffic surface. Repository hid networking; View bound state only. Backend-driven **header SDUI** is a sibling story on Day 10 — don’t claim deep header mechanics as today’s only proof.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| ≤20s BookMyShow backend-driven header & search line? | “Debounced search with explicit states and cancellation so stale responses can’t win.” |
| Presentation vs transport? | Debounce in VM; transport cancels tasks but doesn’t own keystroke timing. |
| Learning-lab code? | `SearchViewModel.swift` illustrates shape — exact class names aren’t resume bullets. |

**How can I relate to my case:**
- **Shipped:** BookMyShow backend-driven header & search
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q5. How do you answer “Isn’t Clean overengineering?”?
**Answer:**

> Scope it — UseCases where rules and migration risk live; MVVM for simple UI. At District you extracted where **billing rules** hurt, not ceremony on every toggle. Counterexample: a settings switch stays MVVM. Clean here means dependency rule and testable policy, not folder theater or a DI-container religion.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| “Whole app Clean?” | No — strangler with selective UseCases. |
| “Show me DI container.” | Constructor + protocols + feature assembler; container optional until graph pain. |
| “How do you test?” | UseCase unit tests cheapest; VM with fakes; UITests for critical paths only. |

**How can I relate to my case:**
- **Shipped:** None for this prompt — keep it conceptual unless they ask for a case.
- **Design if asked:** N/A
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q6. What must you never blur between District Free Parking + Clean/MVVM + AI tooling and learning-lab code?
**Answer:**

> You may say you shipped Free Parking and incremental MVVM/Clean migration (District Free Parking + Clean/MVVM + AI tooling). You may **not** present illustrative `AdjustFreeParkingBilling` or `FeatureAssembler` class names as exact production types unless you later verify them. Exact folder layout, invented AI velocity %, and “AI never needed review” are all forbidden. Label learning-lab when walking whiteboard code.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Provenance tag for District Free Parking + Clean/MVVM + AI tooling? | District Free Parking + Clean/MVVM + AI tooling · District · Free Parking; MVVM/Clean migration; Context Engineering. |
| Adjacent BookMyShow Ads pipeline + HeroWidget lifecycle hook? | Ads protocols / testable pipelines — separate verified story, don’t invent memory tickets. |
| Stories SDK (Raw / Miami Heat) Stories SDK DI? | Injectable host deps — related DI theme, different product. |

**How can I relate to my case:**
- **Shipped:** Stories SDK (Raw / Miami Heat); BookMyShow Ads pipeline + HeroWidget lifecycle; District Free Parking + Clean/MVVM + AI tooling
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

---

### Q7. What should you be able to say after Day 08 sample + modules?
**Answer:**

> “I default to MVVM for feature UI, add UseCases where domain or migration risk demands, and inject dependencies with protocols and constructors. At District I shipped Free Parking while migrating incrementally — AI accelerated inside an envelope I owned. On BMS search, debounce and cancel live in the ViewModel with explicit states so races don’t win.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Decision rule in one breath? | MVVM default → UseCase for rules → MVI if async fights → protocol DI → strangler migration. |
| Where debounce does *not* go? | URLSession / repository transport layer. |
| Next study beat? | Day 09 networking layer; Day 10 SDUI header sibling to BookMyShow backend-driven header & search. |

**How can I relate to my case:**
- **Shipped:** BookMyShow backend-driven header & search
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

Back to: [README.md](README.md) · Main questions: [07-revision-qna.md](07-revision-qna.md)

---

## Brain puzzles (cover → think → check)

### Puzzle A — How do you speak about AI tooling without sounding like you outsourced design

**Ask yourself:** How do you speak about AI tooling without sounding like you outsourced design?

**Answer:** “Say AI was an **accelerator inside a strict architectural envelope**: you fed layering rules, exemplar PRs, and acceptance intent; AI drafted scaffolding and tests; you reviewed for boundary violations, races, and naming. Tests were a gate, not a substitute for judgment. You are author of record — the tool is not. Context Engineering is the control plane, not “the model designed Free Parking.”

### Puzzle B — What is the District Free Parking + Clean/MVVM + AI tooling STAR story in plain 

**Ask yourself:** What is the District Free Parking + Clean/MVVM + AI tooling STAR story in plain steps?

**Answer:** “**Situation:** Ship Free Parking billing adjustments while moving patterns across MVVM and Clean without a regression cliff. **Action:** Deliver the feature; extract UseCase boundaries where domain rules lived; leave simple UI as MVVM; use Context Engineering so AI stayed inside protocols; accelerate test drafts with review; use structured logging on-call. **Result:** Feature shipped; migration progressed with velocity and discipline — not “AI shipped it.” **Lesson:** Boundaries first; AI accelerates typing once the envelope is clear.”

### Puzzle C — What can you claim under BookMyShow backend-driven header & search for search

**Ask yourself:** What can you claim under BookMyShow backend-driven header & search for search?

**Answer:** “BookMyShow backend-driven header & search for today’s beat: BMS search used **MVVM** with **debounce**, **in-flight cancellation**, and explicit **loading/empty/error** (plus idle/results) states — race-safer UX on a high-traffic surface. Repository hid networking; View bound state only. Backend-driven **header SDUI** is a sibling story on Day 10 — don’t claim deep header mechanics as today’s only proof.”
