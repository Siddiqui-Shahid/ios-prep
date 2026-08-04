# Day 15 — App Modularization, SPM & DI Graphs

> **Full chapter:** [`weeks/week-03/day-15/`](../../../weeks/week-03/day-15/) · Revision twin — timed recall only after the full study.

> Week 3 · Phase: Full architecture, performance, security, platform · Time budget today: ~4–5 hrs

## 1. Outcome

By end of day you can explain aloud (no notes):

- Why feature modules must depend on **interfaces**, never other feature **implementations**
- How **SPM** targets map to Interface / Impl / Core layers and what that buys for build parallelism
- How a **composition root** (App target) wires a DI graph without feature-level singletons
- How you designed the **Stories SDK** as a reusable module adopted across NBA/WNBA apps
- Trade-offs: CocoaPods vs SPM, dynamic vs static linking, service locator vs constructor/tree DI

## 2. Concept deep dive

### 2.1 Module hierarchy that scales

Senior answer structure: **App → Feature Impl → Feature Interface → Core**.

| Layer | Owns | Must not own |
|---|---|---|
| **App target** | Lifecycle, DI root, module registration, deep-link → feature routing | Business logic of features |
| **Feature Impl** | Views, ViewModels, feature use-cases | Direct imports of other Feature Impls |
| **Feature Interface** | Public protocols, DTOs needed by peers | Heavy UI / networking impl |
| **Core** | Network, storage, design system, analytics abstractions | Feature-specific rules |

Cross-feature navigation: Feature A imports `FeatureBInterface`, asks DI for `FeatureBBuildable`, App registered the real builder. **Compile-time** missing deps beat runtime Swinject surprises.

### 2.2 SPM as the packaging model

```text
Package.swift
  CheckoutInterface  (leaf — builds fast, rarely changes)
  Checkout           (depends on CheckoutInterface + CartInterface + CoreNetwork)
  CartInterface
  Cart
  CoreNetwork / CoreUI / CoreAnalytics
```

**Why Interface/Impl split:** Impls can compile in parallel; changing Checkout UI doesn’t rebuild Cart. Circular deps fail at resolve time instead of mysterious runtime loops.

**SPM vs CocoaPods (interview-ready):**
- SPM: native Xcode, no Ruby, better parallel resolution, first-party Apple path
- Pods: still common in legacy monorepos; binary pods / complex resource bundles; migration cost is real — don’t pretend otherwise

### 2.3 DI graphs without hidden globals

Prefer **constructor injection** or a **tree of components** (Needle-style) over service locators:

```swift
protocol CheckoutDependency: Dependency {
    var network: NetworkProviding { get }
    var cart: CartProviding { get }  // protocol from CartInterface
}

final class CheckoutComponent {
    let dependency: CheckoutDependency
    func makeCheckoutVC() -> UIViewController { /* wire VM */ }
}

// App = composition root
final class AppComponent: CheckoutDependency { /* fulfill + register */ }
```

**Anti-patterns to call out:**
- Feature modules calling `NetworkManager.shared`
- “God” AppDelegate holding 40 singletons
- Interface modules that secretly import Impl (defeats the graph)

### 2.4 Stories SDK as a reusable module (your production proof)

Treat the Stories SDK like a **product surface with a public API**, not a folder of views copied per app:

1. **Standalone package / framework** — host app supplies config (theme, analytics, media loader protocols)
2. **Stable public API** — entry points, callbacks, error types; hide internal VCs/SwiftUI
3. **Host-agnostic networking** — inject `StoriesContentProviding` so Miami Heat and portfolio apps don’t fork fetch code inside the SDK
4. **Versioning mindset** — additive API changes; breaking changes = major bump + migration notes
5. **Adoption** — one implementation leveraged across the client portfolio → faster feature parity

### 2.5 Trade-offs

| Choice | When | Cost |
|---|---|---|
| Interface/Impl split | Multi-team / large features | More targets, more Package.swift discipline |
| Static linking | Default for app modules | Larger link step; prefer over many dynamic frameworks at launch |
| Dynamic frameworks | App + Extension shared code | dyld overhead; Apple guidance ~keep dynamic count low |
| Tree DI / constructor | New modules, compile-time safety | More boilerplate at App root |
| Service locator (Swinject) | Legacy glue | Runtime missing-deps; harder to reason |
| SPM | Greenfield / Apple-first | Some binary/vendor pods still awkward |
| Monolith “just folders” | Tiny app / spike | Build time + merge conflict pain at scale |

## 3. Read these

| Priority | Resource | Why |
|---|---|---|
| Must | [app-modularization.md](../../../ios-system-design/docs/app-modularization.md) | HLD, Interface/Impl, Needle-style DI, linking trade-offs |
| Deepen | WWDC: Modularizing your app / Swift packages in depth | Official SPM + module boundary language |
| Deepen | Uber Needle / Airbnb modularization posts (skim) | Industry vocabulary interviewers recognize |
| Repo | [cheatsheet.md](../../../ios-system-design/docs/cheatsheet.md) — concurrency/DI snippets | Tie modules to injectable actors/services |
| Story | [story-bank.md](../../stories/story-bank.md)#S10 | Stories SDK STAR |

## 4. Map to your work

**Company / feature:** Raw Engineering — Miami Heat; **standalone reusable Stories SDK** adopted across portfolio.  
**What you did:** Designed SDK boundaries (public API, isolation from host shortcuts), shipped Instagram-style fan Stories once, reused across NBA/WNBA apps.  
**Interview line (≤20s):**  
> “I shipped Stories as a standalone SDK with a clear public API and injected host dependencies — one module, multiple apps, no copy-paste forks.”

→ Full STAR: [story-bank.md](../../stories/story-bank.md)#S10

**Secondary hooks:** BookMyShow Ads as a **pod/module** with POP+Generics pipeline ([S1](../../stories/story-bank.md)#S1); District Clean/MVVM boundaries ([S9](../../stories/story-bank.md)#S9).

## 5. Normal questions

For each: answer out loud within the time. Skeleton only — expand from memory.

### Q1. Why modularize an iOS app? `(30–45s)`
**Skeleton:** Build time + team ownership + testability + binary/feature isolation → Interface/Impl → Stories SDK reuse as proof.  
**Follow-up:** What’s the smallest useful first module?  
**Story:** S10

### Q2. CocoaPods vs SPM — how do you choose? `(30–45s)`
**Skeleton:** SPM default for new; Pods if binary/legacy; migration is incremental (leaf packages first).  
**Follow-up:** How do you share resources (assets) across SPM targets?  
**Story:** Ads pod migration context (S4) if asked about existing pods

### Q3. What belongs in a Feature Interface module? `(30–45s)`
**Skeleton:** Protocols + lightweight models + builder/factory types — no UIKit heavy VCs, no URLSession impl.  
**Follow-up:** Can Interface depend on Core? When is that OK?  
**Story:** —

### Q4. Explain a DI composition root. `(30–45s)`
**Skeleton:** App target wires graph; features receive protocols; no feature-level `.shared`.  
**Follow-up:** Where do you put deep-link → feature factories?  
**Story:** S10 (host injects providers)

### Q5. How do features navigate without importing each other? `(30–45s)`
**Skeleton:** Depend on `FeatureBBuildable` protocol; App registers impl; coordinator uses protocol.  
**Follow-up:** What about shared “Home” that routes to everything?  
**Story:** —

### Q6. Dynamic vs static frameworks — launch impact? `(30–45s)`
**Skeleton:** Many dynamic frameworks → dyld cost; prefer static for internal modules; dynamic when sharing with extensions.  
**Follow-up:** How does this interact with app thinning / binary size?  
**Story:** —

### Q7. How do you keep modules independently testable? `(30–45s)`
**Skeleton:** Inject protocols; Interface packages enable mock doubles; CI can test Checkout without full app.  
**Follow-up:** Snapshot tests — which layer owns them?  
**Story:** S9 (tests + architecture envelope)

### Q8. What is a circular dependency and how do you prevent it? `(30–45s)`
**Skeleton:** A Impl ↔ B Impl; prevent via Interface-only cross deps; CI/graph lint if needed.  
**Follow-up:** Ever had SPM resolve fail — how did you debug?  
**Story:** —

### Q9. How would you extract Stories into an SDK today? `(45–60s)`
**Skeleton:** Public API surface → inject content + analytics + image loader → versioning → demo app → adopt in second host.  
**Follow-up:** How do you handle theming across brands?  
**Story:** S10

### Q10. Singletons — ever OK? `(30–45s)`
**Skeleton:** Rare, at App/Core boundary if truly process-wide (e.g. analytics sink); never inside feature modules as hidden deps.  
**Follow-up:** How do actors change the singleton debate?  
**Story:** S2 (shared state patterns)

### Q11. How does modularization help CI? `(30–45s)`
**Skeleton:** Parallel package builds; selective test of changed modules; cache SPM artifacts on runners.  
**Follow-up:** Tie to GitHub Actions (preview Day 20).  
**Story:** BMS CI (resume) — high level only

### Q12. Binary size — modularization risk? `(30–45s)`
**Skeleton:** Dead code stripping helps; watch duplicate symbols / unused dynamic frameworks; budget gates in CI.  
**Follow-up:** What metric do you track per release?  
**Story:** —

## 6. Tricky questions

### T1. “Just use folders as modules — why packages?” `(90–120s)`
**Trap:** Equating namespace folders with dependency boundaries.  
**Senior answer:** Folders don’t enforce import graphs; SPM/Xcode targets do. Enforcement > convention at 30L+ DAU team scale. Stories reuse required a real boundary, not a folder name.  
**Follow-up:** When are folders enough? (tiny app / spike)

### T2. Service locator vs constructor injection — pick one and defend. `(90–120s)`
**Trap:** “Whatever the team uses.”  
**Senior answer:** Prefer constructor/tree DI for compile-time completeness; locator pushes failures to runtime and hides the graph. Admit pragmatism for legacy bridges with a migration path.  
**Follow-up:** How do you migrate a singleton-heavy feature?

### T3. Your Feature Interface started importing UIKit — what’s wrong? `(90–120s)`
**Trap:** “UIKit is fine everywhere.”  
**Senior answer:** Interfaces should stay lean for fast rebuilds and non-UI consumers (extensions, tests). Prefer opaque builders returning `UIViewController` via type erasure / factory protocols defined carefully — or keep UI types in Impl.  
**Follow-up:** SwiftUI `AnyView` as API — when is that a smell?

### T4. Two features need the same User model — where does it live? `(90–120s)`
**Trap:** Duplicate models or dump everything in Core.  
**Senior answer:** Shared kernel / `DomainModels` for true shared entities; feature-specific DTOs stay local; avoid Core becoming a junk drawer.  
**Follow-up:** Versioning shared models across SDK hosts

### T5. How do you modularize without slowing juniors down? `(90–120s)`
**Trap:** Process theater.  
**Senior answer:** Templates for new Feature Interface+Impl, documented DI registration checklist, one “golden path” package, lint for forbidden imports. Velocity comes from clear rails.  
**Follow-up:** How AI tooling fits (Context Engineering inside module boundaries — S9)

### T6. Ads was a pod — how does that relate to SPM modularization? `(90–120s)`
**Trap:** Mixing package manager with architecture.  
**Senior answer:** Pod vs SPM is packaging; POP+Generics + clear module API is architecture. You can have a well-modularized CocoaPod or a messy SPM. At BMS, Ads ownership + URLSession/pinning lived behind a module boundary.  
**Follow-up:** Migration Alamofire → URLSession inside the module (S4)

### T7. Build times got worse after splitting 80 modules — why? `(90–120s)`
**Trap:** “More modules always faster.”  
**Senior answer:** Too-fine splits, chatty Interface changes, excessive dynamic frameworks, poor caching. Use Build Timing Summary; merge leaf packages; stabilize Interface APIs.  
**Follow-up:** Tuist/Bazel — when do you mention them?

### T8. SDK versioning across Heat / Aces / Sky — strategy? `(90–120s)`
**Trap:** “Always latest everywhere.”  
**Senior answer:** Semantic versioning, staggered adoption, feature flags in host if needed, changelog + API diffs. Portfolio reuse only works with release discipline.  
**Follow-up:** How do you deprecate a Stories callback?

## 7. Flashcards for today

| Front | Back |
|---|---|
| Interface vs Impl module | Interface = protocols/DTOs; Impl = UI+logic. Cross-feature deps only on Interface · Trap: Impl→Impl · Prod: Stories public API |
| Composition root | App wires DI; features don’t resolve globals · Trap: Swinject everywhere · Prod: host injects Stories providers |
| Why SPM | Native, parallel, no Ruby · Trap: ignore legacy Pod constraints · Prod: new modules SPM-first |
| Circular dependency fix | Depend on Interface; App registers builders · Trap: import Impl “just once” · Prod: portfolio SDK boundary |
| Static vs dynamic | Prefer static internal; dynamic for app↔extension share · Trap: 40 dynamic frameworks · Prod: launch dyld cost |
| Needle-style DI | Typed dependency protocols + component tree · Trap: runtime locator · Prod: CheckoutDependency pattern |
| Stories SDK lesson | Reuse = API + isolation + versioning · Trap: copy views per app · Prod: S10 portfolio adoption |
| Core junk drawer | Shared kernel only for true shared types · Trap: everything in Core · Prod: feature DTOs stay local |
| Forbidden import | FeatureAImpl must not import FeatureBImpl · Trap: convenience import · Prod: graph as architecture |
| Module testability | Mock Interface protocols in unit tests · Trap: only UITests on full app · Prod: S9 test discipline |
| Binary size gate | CI budget + thinning · Trap: modules magically shrink binary · Prod: watch duplicates |
| Singleton rule | OK rarely at process boundary; never hidden in features · Trap: NetworkManager.shared in VM · Prod: S2 shared-state API |
| First module to extract | Leaf with clear API (design system / networking / Stories) · Trap: split biggest mess first · Prod: S10 |
| Build Timing Summary | Measure before/after splits · Trap: split blindly · Prod: xcodebuild flag |
| SDK host config | Theme, analytics, loader via protocols · Trap: hardcode Heat branding · Prod: multi-app Stories |

## 8. Practice

- **Coding / SD:** Sketch (paper/whiteboard) a 4-layer module graph for a ticketing app: `App`, `Checkout`, `Search`, `Ads`, `Stories`-like `MediaStories`, `CoreNetwork`. Mark Interface vs Impl boxes and one cross-feature navigation arrow that uses a protocol only.
- **Complexity / agenda to say first:**  
  > “I’ll clarify module boundaries, show Interface/Impl + DI composition root, then deep-dive Stories-as-SDK and build/link trade-offs.”
- **Optional code:** Write a tiny `Package.swift` with `StoriesInterface` + `Stories` + app-side `StoriesDependency` stub (no need to compile in CI — interview fluency).

## 9. Timed drill

1. Pick 3 Normal + 2 Tricky (recommend **Q4, Q9, Q6** + **T1, T6**). Record.
2. Score against [answer-timing-guide.md](../../timing/answer-timing-guide.md).
3. Deliver **S10** in ≤3 min once.
4. Log misses in gotchas (especially “folders = modules” and locator vs constructor).
