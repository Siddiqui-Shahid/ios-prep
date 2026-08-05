# Sample 02 — SPM and DI graphs (Q&A)

> Guided teaching. Each answer stands alone; **Points to** shows where the full module expands the idea.

---

### Q1. How does SPM map to Interface / Impl / Core?

**Points to:** [Deep dive · §2 SPM packaging model](../02-deep-dive.md#2-spm-packaging-model)

**Answer:**

> Each feature gets at least two targets: `CheckoutInterface` (leaf — protocols, DTOs, builders) and `Checkout` (Impl — depends on CheckoutInterface + peer Interfaces + CoreNetwork). Core packages hold shared abstractions. Splitting Interface from Impl lets Impls compile in parallel when Interfaces are stable, prevents cycles at package resolve time, and limits rebuild blast radius when UI changes.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why is Interface a “leaf”? | Few dependencies, rare changes — fast to compile and stable for dependents. |
| Changing Checkout UI rebuilds Cart? | Not if Cart only imported CheckoutInterface — Impl changes stay local. |
| Worked sketches? | [`../code/Package.swift`](../code/Package.swift) · [`../code/CompositionRoot.swift`](../code/CompositionRoot.swift) |

---

### Q2. SPM vs CocoaPods — what do you say in an interview?

**Points to:** [Deep dive · SPM vs CocoaPods](../02-deep-dive.md#spm-vs-cocoapods-interview-ready)

**Answer:**

> SPM is the default for greenfield Apple-first work — native Xcode integration, no Ruby pods repo, strong parallelism. CocoaPods still has legacy gravity and sometimes solves binary or resource edge cases SPM struggles with. **Senior line:** packaging ≠ architecture. A clean module boundary can live in either system; a messy SPM soup is still messy.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Migration strategy? | Extract **leaf packages first** — don’t big-bang the whole graph. |
| When mention Tuist/Bazel? | Monorepo scale when Xcode project pain dominates — not cargo cult. |
| S4 soft hook? | Ads networking ownership lived behind a module boundary — packaging era may differ. |

---

### Q3. How do you do DI without hidden globals?

**Points to:** [Deep dive · §3 DI without hidden globals](../02-deep-dive.md#3-di-without-hidden-globals)

**Answer:**

> Prefer **constructor injection** or a **typed component tree** (Needle-style). Each feature defines a dependency protocol (`CheckoutDependency`) with the services it needs. A feature component takes that protocol in `init` and builds VCs/VMs. App’s root component fulfills all dependency protocols and registers builders. No `NetworkManager.shared` inside feature modules.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Service locator downside? | Resolves at runtime — missing dependency crashes on first use in prod, not at compile time. |
| Locator pragmatism? | Legacy Swinject bridges exist — migrate feature-by-feature; don’t pretend locators are “more senior.” |
| Interface secretly importing Impl? | Anti-pattern — breaks the graph and hides cycles. |

---

### Q4. What are the main DI anti-patterns?

**Points to:** [Deep dive · Anti-patterns](../02-deep-dive.md#anti-patterns)

**Answer:**

> `NetworkManager.shared` inside feature modules; a god `AppDelegate` with dozens of singletons; Interface targets that secretly import Impl; service locators that resolve optional dependencies and fail late. Each hides the true dependency graph and makes testing and reuse hard.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why singletons hurt at scale? | Hidden global state — any feature can touch network policy without the graph showing it. |
| Test impact? | Constructor injection lets you pass mocks; singletons force swizzling or env hacks. |
| Junior onboarding fix? | Templates + forbidden-import lint + a documented golden path. |

---

### Q5. Static vs dynamic linking — when which?

**Points to:** [Deep dive · §4 Static vs dynamic linking](../02-deep-dive.md#4-static-vs-dynamic-linking)

**Answer:**

> **Static** (default for internal app modules) links code into the app binary at build time — usually better launch than many dylibs. **Dynamic** frameworks help when App and Extension must share code at runtime — but each dylib adds dyld load cost. Too many tiny modules is ego-splitting: measure Build Timing Summary before celebrating 80 targets.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Launch path concern? | Dynamic frameworks on the critical launch path add pre-main dyld work (Day 17 bridge). |
| Build got worse after modularization? | Chatty Interface changes, over-fine splits, too many dynamic frameworks, poor CI cache. |
| Fix for build regression? | Merge leaf packages; stabilize Interfaces; prefer static internals; measure. |

---

### Q6. What failure modes show up in real modularization?

**Points to:** [Deep dive · §9 Failure modes](../02-deep-dive.md#9-failure-modes)

**Answer:**

> Impl↔Impl imports (fix: depend on Interface; App wires). Interface targets importing UIKit heavily (keep lean; factory returns opaque VC). SDK hardcoding host branding (inject theme). SDK owning Kingfisher forever (inject `ImageLoading` — Day 16 bridge). Juniors blocked without templates and lint.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Circular dependency symptom? | Package resolve fails or teams create “shared utils” hacks. |
| SDK image dependency? | Host injects loader so portfolio shares one cache policy. |
| Theming in reusable SDK? | Protocolised design tokens — not hardcoded Heat colors. |

---

### Q7. How do trade-offs summarize for staff interviews?

**Points to:** [Deep dive · §8 Trade-offs summary](../02-deep-dive.md#8-trade-offs-summary)

**Answer:**

> Interface/Impl split when multi-team or large features — cost is more targets. Constructor/tree DI for new modules — boilerplate at App. Service locator for legacy glue — runtime surprises. SPM for greenfield — some vendor binaries awkward. Folders-only for tiny spikes — no enforcement. SDK reuse (S10) when portfolio parity matters — versioning discipline required.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| When skip Interface split? | Solo spike or truly tiny feature — don’t over-module a screen. |
| Compile-time safety vs locator? | Tree/constructor fails at build; locator fails in prod on first missing dep. |
| Next sample? | [03-stories-sdk.md](03-stories-sdk.md) — extraction and public API. |

---

Next: [03-stories-sdk.md](03-stories-sdk.md)
