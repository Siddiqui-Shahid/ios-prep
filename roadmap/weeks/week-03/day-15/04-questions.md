# 04 — Questions (two-layer answers)

> Cover full spoken → speak from **Answer points** → compare.  
> **12 normal + 8 tricky = 20**.

---

## Normal questions

### Q1. Why modularize an iOS app? `(30–45s)`

**Answer points:**
- Build time, ownership, testability, reuse
- Interface/Impl enforcement
- Stories SDK as proof (S10)

**Full spoken answer:**
> “Modularization buys incremental build speed, clearer team ownership, independent tests, and reuse. The key is an enforced import graph — Interface versus Impl — not folders with good intentions. My production proof is the Stories SDK: one module adopted across portfolio apps instead of copy-paste UI.”

**Common wrong answer:** “Modules are just folders.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | First module? | Leaf with clear API — design system, network, or Stories. |
| L2 | Story? | S10. |
| L3 | — | — |

**Provenance:** Verified · S10

---

### Q2. CocoaPods vs SPM — how choose? `(30–45s)`

**Answer points:**
- SPM default for new
- Pods for binary/legacy gravity
- Incremental migration
- Packaging ≠ architecture

**Full spoken answer:**
> “For new modules I default to SPM — native Xcode, no Ruby. CocoaPods stays when binary pods or legacy resource bundles dominate. Migration is incremental: leaf packages first. And packaging isn’t architecture — a CocoaPod can still have a clean API boundary.”

**Common wrong answer:** “Pods are obsolete; always rewrite tomorrow.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Resources in SPM? | Process resources carefully per target. |
| L2 | Ads context? | S4 ownership lived behind a module boundary. |
| L3 | — | — |

**Provenance:** Learning-lab · soft S4

---

### Q3. What belongs in a Feature Interface? `(30–45s)`

**Answer points:**
- Protocols + light DTOs + builders
- No heavy VCs / URLSession impl
- May depend on Core carefully

**Full spoken answer:**
> “Interfaces hold protocols, lightweight models peers need, and builder/factory types. They should not own heavy UIKit view controllers or concrete networking. Depending on Core abstractions is OK when it stays lean — Interfaces must stay cheap to compile.”

**Common wrong answer:** “Put the whole feature in Interface for convenience.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | UIKit in Interface? | Smell — prefer opaque factories. |
| L2 | — | — |
| L3 | — | — |

**Provenance:** Learning-lab

---

### Q4. Explain a DI composition root. `(30–45s)`

**Answer points:**
- App wires graph
- Features receive protocols
- No feature-level `.shared`

**Full spoken answer:**
> “The App target is the composition root: it constructs concrete services and injects them into feature builders. Features depend on protocols, not globals. That compile-time graph beats discovering a missing Swinject registration in production. For Stories, the host injects providers at the root.”

**Common wrong answer:** “Each feature resolves NetworkManager.shared.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Deeplink factories? | Registered at App root. |
| L2 | Story? | S10 host injects. |
| L3 | — | — |

**Provenance:** Verified · S10 · Learning-lab DI

---

### Q5. Navigate without importing other Impls? `(30–45s)`

**Answer points:**
- Depend on `FeatureBBuildable`
- App registers impl
- Coordinator uses protocol

**Full spoken answer:**
> “Feature A imports FeatureB’s Interface and asks DI for a `FeatureBBuildable`. The App registered the concrete builder. That gives compile-time missing-dep failures instead of runtime surprises and prevents Impl↔Impl cycles.”

**Common wrong answer:** “Just import FeatureB — it’s fine once.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Home routes everywhere? | Home depends on many Interfaces; App wires. |
| L2 | — | — |
| L3 | — | — |

**Provenance:** Learning-lab

---

### Q6. Dynamic vs static — launch impact? `(30–45s)`

**Answer points:**
- Many dylibs → dyld cost
- Prefer static internal
- Dynamic for app↔extension share

**Full spoken answer:**
> “Lots of dynamic frameworks cost dyld time at launch. I prefer static linking for internal modules and reserve dynamic for true app-and-extension sharing. Modularization shouldn’t mean forty dylibs by accident.”

**Common wrong answer:** “Dynamic is always cleaner.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Binary size? | Watch duplicates; CI budgets. |
| L2 | — | — |
| L3 | — | — |

**Provenance:** Learning-lab

---

### Q7. Independently testable modules? `(30–45s)`

**Answer points:**
- Inject protocols
- Mock via Interface
- CI test Checkout without full app

**Full spoken answer:**
> “If dependencies are protocols from Interface packages, unit tests inject fakes and CI can test Checkout without booting the full app. Snapshot tests usually live with Impl UI. That matches the test discipline we used around District architecture work.”

**Common wrong answer:** “Only UITests on the monolith.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Story? | S9 soft. |
| L2 | — | — |
| L3 | — | — |

**Provenance:** Verified · S9 soft · Learning-lab

---

### Q8. Circular dependency — prevent? `(30–45s)`

**Answer points:**
- Impl↔Impl is the bug
- Cross-deps only on Interface
- SPM resolve fails early

**Full spoken answer:**
> “Cycles usually mean two Impls import each other. Break them by depending only on Interfaces and letting App register builders. SPM/Xcode will fail resolution instead of giving you mysterious runtime loops.”

**Common wrong answer:** “Import Impl just this once.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Debug SPM? | `swift package` / dependency graph tools. |
| L2 | — | — |
| L3 | — | — |

**Provenance:** Learning-lab

---

### Q9. Extract Stories into an SDK today? `(45–60s)`

**Answer points:**
- Public API → inject content/analytics/loader
- Versioning → demo app → second host
- Theming via protocols

**Full spoken answer:**
> “I’d freeze a public API, inject content, analytics, and image loading, add semantic versioning, prove it in a demo host, then adopt a second production host before wide rollout. Theming stays protocolised so Heat and Aces don’t fork the SDK. That’s the same shape we used for portfolio Stories reuse.”

**Common wrong answer:** “Copy the SwiftUI files into each app.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Breaking change? | Major bump + migration notes. |
| L2 | Story? | S10. |
| L3 | — | — |

**Provenance:** Verified · S10

---

### Q10. Singletons — ever OK? `(30–45s)`

**Answer points:**
- Rare process-wide sinks
- Never hidden in features
- Prefer inject even then

**Full spoken answer:**
> “A process-wide analytics sink might be constructed once at App launch, but features should still receive it via injection. Feature-level `NetworkManager.shared` hides the graph and kills testability. Actors change how we isolate state — they don’t excuse hidden globals.”

**Common wrong answer:** “Singletons are fine everywhere for convenience.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | S2 bridge? | Shared maps need explicit isolation APIs. |
| L2 | — | — |
| L3 | — | — |

**Provenance:** Learning-lab · soft S2

---

### Q11. Modularization vs CI? `(30–45s)`

**Answer points:**
- Parallel package builds
- Selective tests
- Cache SPM artifacts

**Full spoken answer:**
> “Modules let CI build and test only what changed, cache SPM artifacts on runners, and parallelise package builds. That’s a Day 20-shaped conversation — today the point is the graph enables selective work.”

**Common wrong answer:** “CI only cares about the app target.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | GH Actions? | Preview Day 20. |
| L2 | — | — |
| L3 | — | — |

**Provenance:** Learning-lab

---

### Q12. Binary size risk? `(30–45s)`

**Answer points:**
- Dead stripping helps
- Watch duplicate symbols / unused dylibs
- CI budget gates

**Full spoken answer:**
> “Modules don’t magically shrink binaries. Dead-code stripping helps, but duplicate symbols and unused dynamic frameworks hurt. I’d put a size budget in CI and watch diffs per release.”

**Common wrong answer:** “More modules always smaller apps.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Metric? | Compressed download / install size. |
| L2 | — | — |
| L3 | — | — |

**Provenance:** Learning-lab

---

## Tricky questions

### T1. “Folders as modules — why packages?” `(90–120s)`

**Trap:** Equating namespaces with dependency boundaries.

**Answer points:**
- Folders don’t enforce imports
- SPM/Xcode targets do
- Stories reuse needed a real boundary

**Full spoken answer:**
> “Folders are convention; packages and targets are enforcement. At team scale, convention leaks — someone imports the ‘wrong’ folder and the graph collapses. Stories reuse across portfolio apps required a real module boundary and public API, not a folder named Stories. Folders are enough for a spike; they’re not enough for SDK adoption.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Tiny app? | Folders OK until pain. |
| L2 | Story? | S10. |
| L3 | — | — |

**Provenance:** Verified · S10

---

### T2. Service locator vs constructor — pick and defend. `(90–120s)`

**Trap:** “Whatever the team uses.”

**Answer points:**
- Prefer constructor/tree for compile-time completeness
- Locator = runtime missing deps
- Pragmatic legacy bridge + migration

**Full spoken answer:**
> “I prefer constructor or typed tree DI because missing dependencies fail at compile time and the graph is readable at the App root. Service locators push failures to runtime and hide who needs what. I’ll bridge legacy Swinject during migration, but I won’t call the locator more senior — it’s a pragmatism tax.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Migrate singleton feature? | Introduce protocol, inject at edge, delete `.shared`. |
| L2 | — | — |
| L3 | — | — |

**Provenance:** Learning-lab

---

### T3. Interface started importing UIKit — what’s wrong? `(90–120s)`

**Trap:** “UIKit is fine everywhere.”

**Answer points:**
- Interfaces must stay lean
- Non-UI consumers / fast rebuilds
- Opaque builders / keep UI in Impl

**Full spoken answer:**
> “Heavy UIKit in Interface couples every peer to UI and slows rebuilds. Prefer factory protocols that return an opaque `UIViewController` from Impl, or keep UI types out of Interface entirely. SwiftUI `AnyView` as a public SDK API is often a smell — it erases structure and invites host hacks.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Extensions? | Non-UI targets can’t take UIKit Interfaces easily. |
| L2 | — | — |
| L3 | — | — |

**Provenance:** Learning-lab

---

### T4. Two features need same User model — where? `(90–120s)`

**Trap:** Duplicate everything or dump into Core.

**Answer points:**
- Shared kernel for true shared entities
- Feature DTOs stay local
- Avoid Core junk drawer

**Full spoken answer:**
> “If it’s truly shared — stable identity fields — put it in a small domain kernel. Feature-specific DTOs stay in that feature’s Interface/Impl. Core becomes a junk drawer when every ‘maybe shared’ struct lands there, and then nothing rebuilds quickly.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | SDK hosts? | Version shared models carefully across apps. |
| L2 | — | — |
| L3 | — | — |

**Provenance:** Learning-lab

---

### T5. Modularize without slowing juniors? `(90–120s)`

**Trap:** Process theater.

**Answer points:**
- Templates Interface+Impl
- DI registration checklist
- Forbidden-import lint
- Golden path package

**Full spoken answer:**
> “Velocity comes from rails: a template for Interface+Impl, a checklist for App registration, one golden-path package to copy, and lint for forbidden Impl→Impl imports. At District we also kept AI inside architecture envelopes — tools don’t replace clear module boundaries.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | S9? | Context Engineering inside protocols. |
| L2 | — | — |
| L3 | — | — |

**Provenance:** Verified · S9 soft

---

### T6. Ads was a pod — relate to SPM modularization? `(90–120s)`

**Trap:** Mixing package manager with architecture.

**Answer points:**
- Pod vs SPM = packaging
- POP+API = architecture
- S4 ownership inside module boundary

**Full spoken answer:**
> “CocoaPods versus SPM is how you package. Modular architecture is whether Ads exposes a clean API and owns its networking. At BMS, Ads could live as a pod while still having POP contracts and URLSession pinning behind that boundary. You can have clean pods and messy SPM — don’t conflate the tools with the graph.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | S4? | Alamofire → URLSession inside the module. |
| L2 | — | — |
| L3 | — | — |

**Provenance:** Verified · S4 soft · S1 soft

---

### T7. Build times worse after 80 modules — why? `(90–120s)`

**Trap:** “More modules always faster.”

**Answer points:**
- Over-fine splits
- Chatty Interfaces
- Too many dylibs
- Measure; merge; stabilize

**Full spoken answer:**
> “Over-splitting creates chatty Interface changes that rebuild the world, plus dynamic framework overhead and weak caching. I’d measure with Build Timing Summary, merge leaf packages that always change together, stabilize Interface APIs, and prefer static internals. Tuist or Bazel enter the chat at extreme monorepo scale — not as the first move.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | First metric? | Incremental build of a leaf change. |
| L2 | — | — |
| L3 | — | — |

**Provenance:** Learning-lab

---

### T8. SDK versioning across Heat / Aces / Sky? `(90–120s)`

**Trap:** “Always latest everywhere.”

**Answer points:**
- Semver
- Staggered adoption
- Changelog / API diffs
- Host feature flags if needed

**Full spoken answer:**
> “Semantic versioning, staggered host adoption, and honest changelogs. Portfolio reuse only works with release discipline — a breaking Stories callback needs a major bump and migration notes. Hosts can feature-flag temporarily, but the SDK shouldn’t silently fork per brand.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Deprecate callback? | Soft deprecate → remove in next major. |
| L2 | Story? | S10. |
| L3 | — | — |

**Provenance:** Verified · S10

---

Revision twin: [../../../revision/weeks/week-03/day-15.md](../../../revision/weeks/week-03/day-15.md)
