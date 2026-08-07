# 04 — Questions (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Each question ends with **How can I relate to my case** using named work — never S-codes.
> Normal ≈ 30–60s · Design ≈ 90–120s · Tricky ≈ 90–120s.

---

## Normal questions

### Q1. Why modularize an iOS app? `(30–45s)`

**Answer:**

> Modularization buys incremental build speed, clearer team ownership, independent tests, and reuse. The key is an enforced import graph — Interface versus Impl — not folders with good intentions. My production proof is the Stories SDK: one module adopted across portfolio apps instead of copy-paste UI.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| First module? | Leaf with clear API — design system, network, or Stories. |
| Story? | Stories SDK (Raw / Miami Heat). |

**How can I relate to my case:**
- **Shipped:** Stories SDK (Raw / Miami Heat)
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q2. CocoaPods vs SPM — how choose? `(30–45s)`

**Answer:**

> For new modules I default to SPM — native Xcode, no Ruby. CocoaPods stays when binary pods or legacy resource bundles dominate. Migration is incremental: leaf packages first. And packaging isn’t architecture — a CocoaPod can still have a clean API boundary.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Resources in SPM? | Process resources carefully per target. |
| Ads context? | BookMyShow Ads URLSession + pinning ownership lived behind a module boundary. |

**How can I relate to my case:**
- **Shipped:** BookMyShow SSL pinning + URLSession migration
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Claiming pin-rotation / break-glass runbook as a shipped production playbook.

---

### Q3. What belongs in a Feature Interface? `(30–45s)`

**Answer:**

> Interfaces hold protocols, lightweight models peers need, and builder/factory types. They should not own heavy UIKit view controllers or concrete networking. Depending on Core abstractions is OK when it stays lean — Interfaces must stay cheap to compile.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| UIKit in Interface? | Smell — prefer opaque factories. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q4. Explain a DI composition root. `(30–45s)`

**Answer:**

> The App target is the composition root: it constructs concrete services and injects them into feature builders. Features depend on protocols, not globals. That compile-time graph beats discovering a missing Swinject registration in production. For Stories, the host injects providers at the root.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Deeplink factories? | Registered at App root. |
| Story? | Stories SDK (Raw / Miami Heat) host injects. |

**How can I relate to my case:**
- **Shipped:** Stories SDK (Raw / Miami Heat)
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q5. Navigate without importing other Impls? `(30–45s)`

**Answer:**

> Feature A imports FeatureB’s Interface and asks DI for a `FeatureBBuildable`. The App registered the concrete builder. That gives compile-time missing-dep failures instead of runtime surprises and prevents Impl↔Impl cycles.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Home routes everywhere? | Home depends on many Interfaces; App wires. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q6. Dynamic vs static — launch impact? `(30–45s)`

**Answer:**

> Lots of dynamic frameworks cost dyld time at launch. I prefer static linking for internal modules and reserve dynamic for true app-and-extension sharing. Modularization shouldn’t mean forty dylibs by accident.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Binary size? | Watch duplicates; CI budgets. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q7. Independently testable modules? `(30–45s)`

**Answer:**

> If dependencies are protocols from Interface packages, unit tests inject fakes and CI can test Checkout without booting the full app. Snapshot tests usually live with Impl UI. That matches the test discipline we used around District architecture work.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Story? | District Free Parking / Clean architecture — soft production hook. |

**How can I relate to my case:**
- **Shipped:** District Free Parking + Clean/MVVM + AI tooling
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q8. Circular dependency — prevent? `(30–45s)`

**Answer:**

> Cycles usually mean two Impls import each other. Break them by depending only on Interfaces and letting App register builders. SPM/Xcode will fail resolution instead of giving you mysterious runtime loops.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Debug SPM? | `swift package` / dependency graph tools. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q9. Extract Stories into an SDK today? `(45–60s)`

**Answer:**

> I’d freeze a public API, inject content, analytics, and image loading, add semantic versioning, prove it in a demo host, then adopt a second production host before wide rollout. Theming stays protocolised so Heat and Aces don’t fork the SDK. That’s the same shape we used for portfolio Stories reuse.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Breaking change? | Major bump + migration notes. |
| Story? | Stories SDK (Raw / Miami Heat). |

**How can I relate to my case:**
- **Shipped:** Stories SDK (Raw / Miami Heat)
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q10. Singletons — ever OK? `(30–45s)`

**Answer:**

> A process-wide analytics sink might be constructed once at App launch, but features should still receive it via injection. Feature-level `NetworkManager.shared` hides the graph and kills testability. Actors change how we isolate state — they don’t excuse hidden globals.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Shared-maps bridge? | Shared maps need explicit isolation APIs. |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Exact crash %, “fixed all BMS crashes,” or claiming lab SafeDict.swift was the shipped file.

---

### Q11. Modularization vs CI? `(30–45s)`

**Answer:**

> Modules let CI build and test only what changed, cache SPM artifacts on runners, and parallelise package builds. That’s a Day 20-shaped conversation — today the point is the graph enables selective work.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| GH Actions? | Preview Day 20. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q12. Binary size risk? `(30–45s)`

**Answer:**

> Modules don’t magically shrink binaries. Dead-code stripping helps, but duplicate symbols and unused dynamic frameworks hurt. I’d put a size budget in CI and watch diffs per release.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Metric? | Compressed download / install size. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

## Tricky questions

