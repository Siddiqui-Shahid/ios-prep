# 05 — Exercises

> Solutions are in-repo. Prefer speaking aloud before peeking at solutions.

## A. Conceptual

### A1. Layer recall
From memory, write what each layer owns in one line: View, VM, UseCase, Repository, DataSource.

**Solution:**
- View: layout + forward intents; no networking/rules.
- VM: UI state, mapping, screen async, cancel.
- UseCase: product/business policy; no UIKit.
- Repository: cache/remote policy + DTO map.
- DataSource: URLSession/DB/CMS bytes.

### A2. Debounce placement (two sentences)
Where does debounce live and why not in URLSession?

**Solution:**  
Debounce is presentation policy about typing cadence, so it lives in the ViewModel (or a shared UseCase policy). URLSession may cancel tasks but must not own keystroke timing.

### A3. True/False — fix the false ones

1. Every screen at District was Clean Architecture.  
2. AI was author of record for Free Parking.  
3. Search empty results should use the error state.  
4. UseCases may orchestrate multiple repositories.  
5. Service locators are the default senior DI choice.

**Solution:**  
1 F — selective UseCases; MVVM remained.  
2 F — accelerator inside envelope; you owned design.  
3 F — empty ≠ error.  
4 T.  
5 F — constructor + protocols default.

### A4. Provenance hygiene
Rewrite:

> “Copilot designed our Clean Architecture and shipped Free Parking with 40% fewer bugs.”

**Solution:**  
“I shipped Free Parking billing adjustments at District while migrating MVVM↔Clean incrementally. I used AI inside a Context Engineering envelope — scaffolding and test drafts I reviewed — and I owned architecture and regressions. I’m not claiming a measured bug-reduction percentage.”

---

## B. Coding

### B1. Read and critique
Open [code/SearchViewModel.swift](code/SearchViewModel.swift).

1. What happens if you omit `inFlight?.cancel()` on new queries?  
2. Why ignore `CancellationError` in the UI state mapping?  
3. Optional: write an XCTest-shaped async test that fires `onQueryChange("a")` then quickly `onQueryChange("avengers")` against a slow fake and asserts final state is for `"avengers"`.

**Solution sketch:**

1. Stale responses can overwrite newer queries.  
2. Cancellation is expected control flow — not a user-facing failure.  
3. Fake with delay; assert `.results` or `.empty` tied to final query; ensure no `.loading("a")` terminal.

### B2. Free Parking policy
Open [code/FreeParkingUseCase.swift](code/FreeParkingUseCase.swift).

1. Why is the amount cap in the UseCase, not the ViewModel?  
2. Add a failing unit-test idea: eligible user + amount 0 → `invalidAmount`.  
3. What would make this UseCase “anemic” / deletable?

**Solution:**

1. Cap is domain policy — must hold for any UI entry point.  
2. `execute` throws before repository persistence.  
3. If it only forwarded to `persistAdjustment` with no validation/policy.

### B3. Assembler
Using [code/FeatureAssembler.swift](code/FeatureAssembler.swift), sketch how a test skips the assembler.

**Solution:**  
`SearchViewModel(repository: FakeSearchRepository(...))` — no `NetworkClient` required.

---

## C. Speaking drills

### C1. S9 opener (20s)
Record once. Must include: Free Parking, MVVM↔Clean, AI accelerator (not author).

### C2. S3 search (60–90s)
Debounce + cancel + state enum. No SDUI deep dive unless asked.

### C3. T1 Clean overengineering (90–120s)
Binary refused; District scope; counterexample screen.

### C4. Agenda opener for architecture HLD
Deliver the README agenda opener from memory.

---

## D. Whiteboard (5 min)

Draw either:

**D1.** Search MVVM sequence with race annotation, or  
**D2.** Free Parking VM → UseCase → Repository with test seam marked.

Agenda first:

> “I’ll define layers, where debounce/cancel live, then map to BMS search and District migration trade-offs.”

---

## E. Timed drill

1. Pick 3 Normal + 2 Tricky (recommended: Q5, Q8, Q2 + T1, T7). Record.  
2. Score against [answer-timing-guide.md](../../../timing/answer-timing-guide.md).  
3. Log misses in gotchas (AI ownership wording + debounce placement).  
4. Deliver S9 STAR in **2–3 min** once; opener only in **20s** once.

## F. Flashcard self-check

| Front | Back |
|---|---|
| MVVM one-liner | View renders; VM presentation + async · Trap: net in View · Prod: S3 |
| Clean one-liner | UseCases/entities independent of UI · Trap: everywhere · Prod: S9 |
| MVI one-liner | Intent → State → View · Trap: CRUD boilerplate · Prod: judgment |
| Debounce home | VM/UseCase · Trap: URLSession · Prod: S3 |
| DI default | Protocol + constructor · Trap: locator · Prod: tests |
| AI line | Accelerator + review · Trap: “AI wrote it” · Prod: S9 |
| Fat VM fix | UseCase + Router · Trap: extensions only · Prod: S9 |
| Repo vs UseCase | Data vs product policy · Trap: same layer · Prod: S9 |
