# 01 — Foundations: Why Modules Exist

> Intern-clear model first; senior vocabulary second.

## 1. Plain-English mental model

A growing iOS app becomes a traffic jam if everything imports everything:

- Slow **incremental builds**  
- Merge conflicts in the project file  
- Hidden **singletons** (`NetworkManager.shared`)  
- Impossible **reuse** across apps (copy-paste Stories UI per brand)

**Modularization** = split into packages/targets with an **allowed import graph**.  
**DI** = the App target **wires** implementations into features that only know **protocols**.

Kitchen metaphor:

| Kitchen role | Module role |
|---|---|
| Recipe card (interface) | Feature Interface — what you can order |
| Cook (implementation) | Feature Impl — how it’s cooked |
| Pantry (core) | Network, analytics, design system abstractions |
| Head chef (app) | Composition root — assigns who cooks what |

## 2. Glossary

| Term | Meaning |
|---|---|
| **Feature Interface** | Protocols, lightweight DTOs, builder types — no heavy UI/network impl |
| **Feature Impl** | Views, VMs, use-cases for one feature |
| **Core** | Shared infrastructure abstractions (and carefully shared models) |
| **Composition root** | App target that constructs the DI graph |
| **SPM** | Swift Package Manager — native packaging |
| **Static linking** | Code linked into the app binary at build time |
| **Dynamic framework** | Loaded at runtime (dyld cost; useful for app↔extension share) |
| **Constructor injection** | Dependencies passed into `init` |
| **Service locator** | Runtime “ask the container” (Swinject-style) — failures late |
| **Needle-style / tree DI** | Typed dependency protocols + component tree |
| **Circular dependency** | A Impl ↔ B Impl import loop |
| **SDK public API** | Stable entry points; hide internals |

## 3. Golden dependency rule

```text
App
 ├─ FeatureA Impl ──► FeatureB Interface ──► Core
 ├─ FeatureB Impl ──► FeatureA Interface ──► Core
 └─ wires concrete builders at composition root
```

**Forbidden:** `FeatureA Impl` imports `FeatureB Impl`.

## 4. Why interviewers care

- Scale (teams, build time) without hand-waving  
- Compile-time safety vs runtime locator surprises  
- SDK reuse proof (**S10 Stories**)  
- Linking/launch trade-offs  

## 5. 60-second HLD to draw

```text
+------------ App (DI root, deeplink routing) -------------+
|  CheckoutImpl     SearchImpl      Stories (SDK)          |
|       |               |                |                 |
|  CheckoutIface   SearchIface     Stories public API      |
|       \               |               /                  |
|                CoreNetwork / CoreAnalytics               |
+----------------------------------------------------------+
```

## 6. Checkpoint

1. Interface vs Impl in one sentence each  
2. Where does DI live?  
3. Why folders ≠ modules?  

→ [02-deep-dive.md](02-deep-dive.md)
