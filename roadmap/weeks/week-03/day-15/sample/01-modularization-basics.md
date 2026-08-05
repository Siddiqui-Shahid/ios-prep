# Sample 01 — Modularization basics (Q&A)

> Guided teaching. Each answer stands alone; **Points to** shows where the full module expands the idea.

---

### Q1. Why do large iOS apps need modules?

**Points to:** [Foundations · §1 Plain-English mental model](../01-foundations.md#1-plain-english-mental-model) · [Foundations · §4 Why interviewers care](../01-foundations.md#4-why-interviewers-care)

**Answer:**

> Without boundaries, everything imports everything. That slows incremental builds, creates merge conflicts in the project file, hides singletons like `NetworkManager.shared`, and makes reuse across apps (copy-paste Stories UI per brand) painful. **Modularization** splits the app into packages or targets with an **allowed import graph**. **DI** means the App target wires implementations into features that only know **protocols**.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Folders vs modules? | Folders are organizational only — Xcode/SPM targets **enforce** what may import what. |
| Kitchen metaphor in one line? | Interface = recipe card; Impl = cook; Core = pantry; App = head chef who assigns cooks. |
| What does “traffic jam” mean here? | Compile-time coupling — one change rebuilds half the app and teams step on each other. |

---

### Q2. What is Feature Interface vs Feature Impl?

**Points to:** [Foundations · §2 Glossary](../01-foundations.md#2-glossary) · [Deep dive · §1 Layer responsibilities](../02-deep-dive.md#1-layer-responsibilities)

**Answer:**

> **Feature Interface** holds protocols, lightweight DTOs, and builder types — no heavy UI or network implementation. **Feature Impl** holds views, view models, and feature use-cases for one feature. Other features may depend on your Interface; they must **not** import your Impl. The App target registers the concrete builder at the composition root.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What must Interface avoid? | Heavy UIKit view controllers, URLSession implementations, `.shared` globals. |
| What does Impl own? | UI, VM, feature-specific use-cases — but not imports of other Feature Impls. |
| Cross-feature navigation pattern? | A depends on `FeatureBBuildable` from B’s Interface; App wires the concrete builder. |

---

### Q3. What is the golden dependency rule?

**Points to:** [Foundations · §3 Golden dependency rule](../01-foundations.md#3-golden-dependency-rule)

**Answer:**

> Feature implementations may depend on **other features’ Interfaces** and on **Core** — never on another feature’s **Impl**. The App target sits at the top and wires concrete builders. **Forbidden:** `FeatureA Impl` imports `FeatureB Impl`. That creates compile-time cycles, hidden coupling, and impossible reuse.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Who breaks Impl↔Impl loops? | The composition root — App registers builders so features talk through Interfaces. |
| Can two Impls both need each other’s UI? | They coordinate through Interface protocols and App-level routing — not direct Impl imports. |
| Why is this interview-critical? | It proves you can scale teams and build times without hand-waving “we use modules.” |

---

### Q4. What is a composition root?

**Points to:** [Foundations · §2 Glossary](../01-foundations.md#2-glossary) · [Deep dive · §3 DI without hidden globals](../02-deep-dive.md#3-di-without-hidden-globals)

**Answer:**

> The **composition root** is the App target that constructs the full DI graph. It creates shared services (network, analytics), fulfills dependency protocols for each feature component, and registers feature builders. Features receive dependencies through **constructor injection** or a typed component tree — they do not reach for global singletons.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Where does DI live? | App target — not scattered inside feature Impls. |
| God `AppDelegate` anti-pattern? | 40 singletons in AppDelegate — features should not discover deps at runtime. |
| Needle-style / tree DI? | Typed dependency protocols per feature + component tree — compile-time wiring. |

---

### Q5. What is Core, and what must it not become?

**Points to:** [Foundations · §2 Glossary](../01-foundations.md#2-glossary) · [Deep dive · §6 Shared models](../02-deep-dive.md#6-shared-models-without-core-junk-drawer)

**Answer:**

> **Core** holds shared infrastructure abstractions: network, storage, design system tokens, analytics interfaces — and **carefully** shared domain models. It must **not** become a junk drawer for “maybe useful someday” DTOs. Checkout-only types belong in Checkout Interface/Impl; true shared entities (User id) may live in a small `DomainModels` kernel.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Feature-specific DTO placement? | That feature’s Interface or Impl — not Core by default. |
| Core owns product rules? | No — feature-specific product rules stay in feature Impls. |
| Why juniors get blocked without Core discipline? | They import Core for convenience and recreate hidden coupling. |

---

### Q6. What should the 60-second HLD show?

**Points to:** [Foundations · §5 60-second HLD](../01-foundations.md#5-60-second-hld-to-draw)

**Answer:**

> Draw App at the top as DI root and deeplink router. Below: feature Impl boxes (Checkout, Search, Stories SDK) each pointing down to their Interface layer. Interfaces converge on CoreNetwork / CoreAnalytics. No Impl-to-Impl arrows. App wires concrete builders at the edges. That diagram shows enforcement, parallelism, and reuse in one picture.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Where do deeplinks land? | App routes to the right feature builder — features expose entry through Interface. |
| Stories as SDK on diagram? | Reusable module with public API — host injects theme, analytics, loaders. |
| One sentence for whiteboard? | “Impls depend on peer Interfaces and Core; App wires concrete types.” |

---

### Q7. What should I say after foundations?

**Points to:** [Foundations · §6 Checkpoint](../01-foundations.md#6-checkpoint)

**Answer:**

> “Interface is the contract other modules may import; Impl is how one feature implements it. DI lives in the App composition root — constructor or tree wiring, not feature-level singletons. Folders don’t enforce anything; SPM/Xcode targets and the import graph do. Features never import peer Impls.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| SPM in one phrase? | Swift Package Manager — native packaging for modules. |
| Static vs dynamic (preview)? | Static links into binary at build time; dynamic loads at runtime (dyld cost). |
| Next sample? | [02-spm-di-graphs.md](02-spm-di-graphs.md) — packaging and DI mechanics. |

---

Next: [02-spm-di-graphs.md](02-spm-di-graphs.md)
