# 05 — Exercises (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Simple language. Named work only — never S-codes in speech.

---

### Q1. A1. Layer recall? `(45–60s)`
**Answer:**

> “From memory, write what each layer owns in one line: View, VM, UseCase, Repository, DataSource. Solution: - View: layout + forward intents; no networking/rules. - VM: UI state, mapping, screen async, cancel. - UseCase: product/business policy; no UIKit. - Repository: cache/remote policy + DTO map. - DataSource: URLSession/DB/CMS bytes.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q2. A2. Debounce placement (two sentences)? `(45–60s)`
**Answer:**

> “Where does debounce live and why not in URLSession? Solution: Debounce is presentation policy about typing cadence, so it lives in the ViewModel (or a shared UseCase policy). URLSession may cancel tasks but must not own keystroke timing.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q3. A3. True/False — fix the false ones? `(45–60s)`
**Answer:**

> “1. Every screen at District was Clean Architecture. 2. AI was author of record for Free Parking. 3. Search empty results should use the error state. 4. UseCases may orchestrate multiple repositories. 5. Service locators are the default senior DI choice. Solution: 1 F — selective UseCases; MVVM remained. 2 F — accelerator inside envelope; you owned design. 3 F — empty ≠ error. 4 T. 5 F — constructor + protocols default.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q4. A4. Provenance hygiene? `(45–60s)`
**Answer:**

> “Rewrite: > “Copilot designed our Clean Architecture and shipped Free Parking with 40% fewer bugs.”.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q5. B1. Read and critique? `(45–60s)`
**Answer:**

> “Open code/SearchViewModel.swift. 1. What happens if you omit inFlight?.cancel on new queries? 2. Why ignore CancellationError in the UI state mapping? 3. Optional: write an XCTest-shaped async test that fires onQueryChange("a") then quickly onQueryChange("avengers") against a slow fake and asserts final state is for "avengers".”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q6. B2. Free Parking policy? `(45–60s)`
**Answer:**

> “Open code/FreeParkingUseCase.swift. 1. Why is the amount cap in the UseCase, not the ViewModel? 2. Add a failing unit-test idea: eligible user + amount 0 → invalidAmount. 3. What would make this UseCase “anemic” / deletable?”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q7. B3. Assembler? `(45–60s)`
**Answer:**

> “Using code/FeatureAssembler.swift, sketch how a test skips the assembler. Solution: SearchViewModel(repository: FakeSearchRepository(...)) — no NetworkClient required.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q8. C1. S9 opener (20s)? `(45–60s)`
**Answer:**

> “Record once. Must include: Free Parking, MVVM↔Clean, AI accelerator (not author).”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q9. C2. S3 search (60–90s)? `(45–60s)`
**Answer:**

> “Debounce + cancel + state enum. No SDUI deep dive unless asked.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q10. C3. T1 Clean overengineering (90–120s)? `(45–60s)`
**Answer:**

> “Binary refused; District scope; counterexample screen.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q11. C4. Agenda opener for architecture HLD? `(45–60s)`
**Answer:**

> “Deliver the README agenda opener from memory. ---.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q12. D. Whiteboard (5 min)? `(45–60s)`
**Answer:**

> “Draw either: D1. Search MVVM sequence with race annotation, or D2. Free Parking VM → UseCase → Repository with test seam marked.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q13. E. Timed drill? `(45–60s)`
**Answer:**

> “1. Pick 3 Normal + 2 Tricky (recommended: Q5, Q8, Q2 + T1, T7). Record. 2. Score against answer-timing-guide.md. 3. Log misses in gotchas (AI ownership wording + debounce placement). 4. Deliver STAR in 2–3 min once; opener only in 20s once.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q14. F. Flashcard self-check? `(45–60s)`
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
