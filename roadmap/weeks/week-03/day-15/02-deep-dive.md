# 02 — Deep Dive: SPM Graphs, DI, Stories SDK

> Self-contained. Optional Apple/Uber reading is enrichment only.

## 1. Layer responsibilities

| Layer | Owns | Must not own |
|---|---|---|
| **App** | Lifecycle, DI root, module registration, deeplink → feature | Feature business rules |
| **Feature Impl** | UI, VM, feature use-cases | Imports of other Feature Impls; `.shared` network |
| **Feature Interface** | Protocols, peer DTOs, `Buildable` factories | Heavy UIKit VCs, URLSession impl |
| **Core** | Network/storage/design/analytics **abstractions** | Feature-specific product rules |

Cross-feature navigation: Feature A depends on `FeatureBBuildable` from B’s Interface; App registered the concrete builder.

## 2. SPM packaging model

```text
Package.swift targets (illustrative):
  CheckoutInterface   // leaf — rare changes, fast
  Checkout            // Impl — depends on CheckoutInterface + CartInterface + CoreNetwork
  CartInterface
  Cart
  Stories             // reusable SDK product
  CoreNetwork / CoreUI / CoreAnalytics
```

**Why Interface/Impl split:**

- Impls compile in parallel when Interfaces are stable  
- Changing Checkout UI doesn’t rebuild Cart  
- Cycles fail at package resolve time  

Worked sketch: [code/Package.swift](code/Package.swift) · [code/StoriesPublicAPI.swift](code/StoriesPublicAPI.swift)

### SPM vs CocoaPods (interview-ready)

| | SPM | CocoaPods |
|---|---|---|
| Default for new | Yes — native Xcode | Legacy gravity |
| Ruby / pods repo | No | Yes |
| Parallelism | Strong | Varies |
| Binary / weird resources | Sometimes awkward | Often already solved in legacy |
| Migration | Leaf packages first | Don’t big-bang |

**Senior line:** Packaging ≠ architecture. You can have a clean CocoaPod module or a messy SPM soup.

## 3. DI without hidden globals

Prefer **constructor injection** or a **typed component tree** over service locators:

```swift
protocol CheckoutDependency {
    var network: NetworkProviding { get }
    var cart: CartProviding { get } // from CartInterface
}

final class CheckoutComponent {
    private let dependency: CheckoutDependency
    init(dependency: CheckoutDependency) { self.dependency = dependency }
    func makeCheckoutVC() -> UIViewController { /* wire VM */ fatalError("sketch") }
}

// App = composition root
final class AppComponent: CheckoutDependency {
    let network: NetworkProviding
    let cart: CartProviding
    // fulfills + registers feature builders
}
```

Worked: [code/CompositionRoot.swift](code/CompositionRoot.swift)

### Anti-patterns

- `NetworkManager.shared` inside feature modules  
- God `AppDelegate` with 40 singletons  
- Interface target secretly importing Impl  
- Locator resolves optional deps — crash in prod on first use  

### Locator pragmatism

Admit legacy Swinject bridges exist; migrate feature-by-feature toward constructor/tree DI. Don’t pretend runtime containers are “more senior.”

## 4. Static vs dynamic linking

| Choice | When | Cost |
|---|---|---|
| Static (default internal) | App modules | Link time; usually better launch than many dylibs |
| Dynamic | App ↔ Extension shared code | dyld overhead; keep count low |
| Too many modules | Ego split | Graph/cache thrash; measure Build Timing Summary |

## 5. Stories SDK as reusable module (deep)

Treat Stories like a **product with a public API**, not a folder copied per NBA/WNBA app:

1. **Standalone package** — host supplies theme, analytics, media loader protocols  
2. **Stable public API** — entry, callbacks, errors; hide internal VCs/SwiftUI  
3. **Host-agnostic content** — inject `StoriesContentProviding`  
4. **Versioning** — additive minor; breaking = major + notes  
5. **Adoption** — one implementation → portfolio parity  

**Extraction sequence (interview):**

```text
Identify public surface → inject host deps → demo app host →
second production host → semantic version → deprecate carefully
```

This is **Verified S10** territory — see [03-production-bridge.md](03-production-bridge.md).

## 6. Shared models without Core junk drawer

| Need | Where |
|---|---|
| True shared entity (User id) | Small `DomainModels` / kernel |
| Checkout-only DTO | Checkout Interface/Impl |
| “Maybe useful someday” | **Not** Core |

## 7. Build times got worse after 80 modules

Causes: chatty Interface changes, over-fine splits, too many dynamic frameworks, poor CI caching.  
Fix: measure Build Timing Summary; merge leaf packages; stabilize Interfaces; prefer static internals.

Tuist/Bazel: mention when monorepo scale demands — not as cargo cult.

## 8. Trade-offs summary

| Choice | When | Cost |
|---|---|---|
| Interface/Impl | Multi-team / large features | More targets |
| Tree/constructor DI | New modules | Boilerplate at App |
| Service locator | Legacy glue | Runtime missing deps |
| SPM | Greenfield / Apple-first | Some vendor binaries awkward |
| Folders only | Tiny spike | No enforcement |
| SDK reuse | Portfolio (S10) | Versioning discipline |

## 9. Failure modes

| Failure | Fix |
|---|---|
| Impl↔Impl import | Depend on Interface; App wires |
| Interface imports UIKit heavily | Keep lean; factory returns opaque VC |
| SDK hardcodes Heat branding | Inject theme |
| SDK owns Kingfisher forever | Inject `ImageLoading` |
| Juniors blocked | Templates + forbidden-import lint + golden path |

## 10. Optional citations

- Apple: Swift packages / modularizing apps  
- Uber Needle conceptual model  
- In-repo: `ios-system-design/docs/app-modularization.md` (optional skim)
