# Sample 03 — Stories SDK extraction (Q&A)

> Guided teaching. Each answer stands alone; **Points to** shows where the full module expands the idea.

---

### Q1. Why treat Stories as a product SDK, not a copied folder?

**Points to:** [Deep dive · §5 Stories SDK](../02-deep-dive.md#5-stories-sdk-as-reusable-module-deep)

**Answer:**

> Portfolio apps (NBA/WNBA) needed Instagram-style fan Stories without copy-paste UI per brand. A **standalone package** with a **stable public API** lets one implementation serve multiple hosts. Hosts inject theme, analytics, and media loaders. Internals stay hidden; entry points, callbacks, and errors are explicit. Versioning and adoption discipline turn modularization into **product leverage**, not just compile-time tidiness.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What hosts must supply? | Theme tokens, analytics, `StoriesContentProviding`, image loader protocols. |
| What SDK must not own? | Host-specific networking shortcuts, hardcoded branding, permanent third-party loader lock-in. |
| Public API sketch? | [`../code/StoriesPublicAPI.swift`](../code/StoriesPublicAPI.swift) |

---

### Q2. What is the extraction sequence you can whiteboard?

**Points to:** [Deep dive · Extraction sequence](../02-deep-dive.md#5-stories-sdk-as-reusable-module-deep)

**Answer:**

> Identify the public surface → inject host dependencies (theme, analytics, content, loaders) → build a demo app host → prove second production host → semantic version the package → deprecate breaking changes carefully. Each step reduces risk before portfolio-wide adoption.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why demo app host first? | Proves SDK runs without the original app’s hidden shortcuts. |
| Versioning rule of thumb? | Additive minor; breaking = major + release notes. |
| S11 adjacent note? | Live scoreboard is separate Raw ownership — don’t collapse with S10 carelessly. |

---

### Q3. Should the Stories SDK own the image pipeline?

**Points to:** [Deep dive · §9 Failure modes](../02-deep-dive.md#9-failure-modes) · Day 16 bridge in deep dive §5

**Answer:**

> **No** — don’t hardcode Kingfisher (or any loader) inside the SDK forever. Inject `ImageLoading` from the host so every portfolio app shares one cache policy, downsample rules, and memory pressure behavior. The SDK stays reusable; hosts control media infrastructure.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Day 16 connection? | L1/L2/L3 tiers and downsample math live in the host loader. |
| SDK without injection? | Each app forks cache behavior — parity breaks under memory pressure. |
| UIKit host for SwiftUI internals? | UIHostingController façade; deeplink exits via host router (S13 soft). |

---

### Q4. How do you keep Core from becoming a junk drawer?

**Points to:** [Deep dive · §6 Shared models](../02-deep-dive.md#6-shared-models-without-core-junk-drawer)

**Answer:**

> Put true shared entities (User id) in a small kernel. Keep checkout-only DTOs in Checkout Interface/Impl. Reject “maybe useful someday” types in Core — that recreates hidden coupling and slows every dependent module. Shared models need the same discipline as shared UI.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| When is Core justified? | Infrastructure abstractions and genuinely cross-cutting domain ids — not feature UI models. |
| Symptom of junk drawer? | Every feature imports Core and nobody knows who owns a type. |
| Refactor path? | Move misplaced DTOs back to feature Interfaces incrementally. |

---

### Q5. Build times got worse after many modules — why?

**Points to:** [Deep dive · §7 Build times](../02-deep-dive.md#7-build-times-got-worse-after-80-modules)

**Answer:**

> Common causes: Interface targets changing too often (every Impl rebuilds), over-fine package splits, too many dynamic frameworks, poor CI caching. Fix by measuring Build Timing Summary, merging leaf packages, stabilizing Interfaces, and preferring static internal linking. Modularization is a trade-off — measure, don’t assume more targets = faster.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Forbidden interview claim? | “80 modules cut build by X%” without evidence. |
| Chatty Interface symptom? | Small DTO churn in Interface forces wide rebuilds. |
| Ego split? | One screen ≠ one SPM product without team boundary justification. |

---

### Q6. How does modularization connect to testability?

**Points to:** [Production bridge · S9 soft](../03-production-bridge.md#1-provenance-map) · Deep dive · §1 Layer responsibilities

**Answer:**

> Features that depend on protocols can be tested with injected fakes — no live network or singletons. Clean/MVVM inside the module boundary (S9 soft) keeps AI and juniors inside an architecture envelope. Module boundaries are where you enforce “no `.shared` in Impl.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What does Interface enable in tests? | Mock `NetworkProviding`, mock cart, mock builders — constructor injection. |
| S1 soft connection? | Ads as revenue module with POP boundary — modularization of behavior. |
| Without Interface split? | Tests reach for globals or duplicate production wiring hacks. |

---

### Q7. What SDK versioning mistakes hurt portfolio adoption?

**Points to:** [Deep dive · §5 Stories SDK](../02-deep-dive.md#5-stories-sdk-as-reusable-module-deep) · [Deep dive · §9 Failure modes](../02-deep-dive.md#9-failure-modes)

**Answer:**

> Breaking public API without major version bumps; hiding internal VCs that hosts started reaching into; hardcoding host branding; owning third-party dependencies permanently. SDK quality = **API surface + versioning + independence from host shortcuts** — that’s the S10 lesson, not just “we moved files into a package.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Additive change example? | New optional callback on entry builder — minor bump. |
| Breaking change example? | Renaming public entry type — major + migration notes. |
| Next sample? | [04-production-s10.md](04-production-s10.md) — Verified interview language. |

---

Next: [04-production-s10.md](04-production-s10.md)
