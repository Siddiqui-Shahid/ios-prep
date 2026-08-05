# Sample 04 — Production S9 and S3 (Q&A)

> Guided teaching. Separates **Verified** resume facts from forbidden overclaims.

---

### Q1. What can you claim under Verified · S9?

**Points to:** [Production bridge · §1 Provenance map](../03-production-bridge.md#1-provenance-map-for-today) · [Production bridge · §2 Verified S9](../03-production-bridge.md#2-verified-s9--star-you-can-deliver-23-min)

**Answer:**

> Verified S9 is District **Free Parking** billing adjustments shipped while **migrating MVVM↔Clean incrementally**; **Context Engineering** with Cursor/Claude/Copilot inside boundaries you owned; AI-assisted **reviews and XCTest/XCUITest drafts** with human review; **structured logging** for on-call production fixes. You may **not** say “AI wrote our architecture,” claim the entire District app was Clean-ified, or invent velocity or billing savings percentages.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| 60s S9 version? | Free Parking ship → incremental MVVM/Clean → AI inside envelope + tests → owned regressions. |
| On-call ownership? | Yes — you handled production fixes when issues surfaced; that is part of S9. |
| Forbidden phrase? | “We Clean Architecture’d the entire District app.” |

---

### Q2. How do you speak about AI tooling without sounding like you outsourced design?

**Points to:** [Production bridge · §3 AI tooling](../03-production-bridge.md#3-ai-tooling--speak-carefully-critical) · [Foundations · §9 AI tooling](../01-foundations.md#9-ai-tooling--the-seniority-filter)

**Answer:**

> Say AI was an **accelerator inside a strict architectural envelope**: you fed layering rules, exemplar PRs, and acceptance intent; AI drafted scaffolding and tests; you reviewed for boundary violations, races, and naming. Tests were a gate, not a substitute for judgment. You are author of record — the tool is not. Context Engineering is the control plane, not “the model designed Free Parking.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Safe script fragment? | “AI drafted migrations/tests; I owned boundaries and regressions.” |
| What review checklist catches? | UseCase importing UIKit, VM building URLRequest, missing cancellation, theater tests. |
| Concrete AI miss to mention? | Billing rules placed in repository — moved to UseCase + unit test. |

---

### Q3. What is the S9 STAR story in plain steps?

**Points to:** [Production bridge · §2 Verified S9](../03-production-bridge.md#2-verified-s9--star-you-can-deliver-23-min) · [Deep dive · §7 Migration playbook](../02-deep-dive.md#7-mvvm--clean-migration-playbook-s9)

**Answer:**

> **Situation:** Ship Free Parking billing adjustments while moving patterns across MVVM and Clean without a regression cliff. **Action:** Deliver the feature; extract UseCase boundaries where domain rules lived; leave simple UI as MVVM; use Context Engineering so AI stayed inside protocols; accelerate test drafts with review; use structured logging on-call. **Result:** Feature shipped; migration progressed with velocity and discipline — not “AI shipped it.” **Lesson:** Boundaries first; AI accelerates typing once the envelope is clear.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Strangler vs big-bang? | Strangler — new Free Parking on new boundaries; old screens call new UseCase over time. |
| MVI/TCA at District? | Discuss as pattern judgment only — not a verified adoption claim. |
| Tie search in 3 min S9? | Mention S3 only if asked — keep S9 primary for architecture behavioral questions. |

---

### Q4. What can you claim under Verified · S3 for search?

**Points to:** [Production bridge · §4 Verified S3](../03-production-bridge.md#4-verified-s3--search-mvvm-secondary-star--deep-dive-beat) · [Foundations · §11 BookMyShow search](../01-foundations.md#11-two-production-anchors-preview)

**Answer:**

> Verified S3 for today’s beat: BMS search used **MVVM** with **debounce**, **in-flight cancellation**, and explicit **loading/empty/error** (plus idle/results) states — race-safer UX on a high-traffic surface. Repository hid networking; View bound state only. Backend-driven **header SDUI** is a sibling story on Day 10 — don’t claim deep header mechanics as today’s only proof.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| ≤20s S3 line? | “Debounced search with explicit states and cancellation so stale responses can’t win.” |
| Presentation vs transport? | Debounce in VM; transport cancels tasks but doesn’t own keystroke timing. |
| Learning-lab code? | `SearchViewModel.swift` illustrates shape — exact class names aren’t resume bullets. |

---

### Q5. How do you answer “Isn’t Clean overengineering?”

**Points to:** [Production bridge · §7 Common pushes](../03-production-bridge.md#7-common-interviewer-pushes--honest-replies) · [Deep dive · §3.2 When to introduce a UseCase](../02-deep-dive.md#32-when-to-introduce-a-usecase)

**Answer:**

> Scope it — UseCases where rules and migration risk live; MVVM for simple UI. At District you extracted where **billing rules** hurt, not ceremony on every toggle. Counterexample: a settings switch stays MVVM. Clean here means dependency rule and testable policy, not folder theater or a DI-container religion.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| “Whole app Clean?” | No — strangler with selective UseCases. |
| “Show me DI container.” | Constructor + protocols + feature assembler; container optional until graph pain. |
| “How do you test?” | UseCase unit tests cheapest; VM with fakes; UITests for critical paths only. |

---

### Q6. What must you never blur between S9 and learning-lab code?

**Points to:** [Production bridge · §6 Mapping topics](../03-production-bridge.md#6-mapping-chapter-topics--verified-vs-learning-lab) · [Production bridge · §1 Forbidden overclaims](../03-production-bridge.md#1-provenance-map-for-today)

**Answer:**

> You may say you shipped Free Parking and incremental MVVM/Clean migration (S9). You may **not** present illustrative `AdjustFreeParkingBilling` or `FeatureAssembler` class names as exact production types unless you later verify them. Exact folder layout, invented AI velocity %, and “AI never needed review” are all forbidden. Label learning-lab when walking whiteboard code.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Provenance tag for S9? | Verified · S9 · District · Free Parking; MVVM/Clean migration; Context Engineering. |
| Adjacent S1 hook? | Ads protocols / testable pipelines — separate verified story, don’t invent memory tickets. |
| S10 Stories SDK DI? | Injectable host deps — related DI theme, different product. |

---

### Q7. What should you be able to say after Day 08 sample + modules?

**Points to:** [Foundations · §12 Self-check](../01-foundations.md#12-self-check-before-deep-dive) · [Production bridge · §5 Interview line](../03-production-bridge.md#5-interview-line-20s)

**Answer:**

> “I default to MVVM for feature UI, add UseCases where domain or migration risk demands, and inject dependencies with protocols and constructors. At District I shipped Free Parking while migrating incrementally — AI accelerated inside an envelope I owned. On BMS search, debounce and cancel live in the ViewModel with explicit states so races don’t win.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Decision rule in one breath? | MVVM default → UseCase for rules → MVI if async fights → protocol DI → strangler migration. |
| Where debounce does *not* go? | URLSession / repository transport layer. |
| Next study beat? | Day 09 networking layer; Day 10 SDUI header sibling to S3. |

---

Back to: [README.md](README.md) · Main questions: [../04-questions.md](../04-questions.md)
