# Day 15 — App Modularization, SPM & DI Graphs

> Week 3 · Revision pass ~45–60 min  
> Full study: [weeks/week-03/day-15/](../../../weeks/week-03/day-15/README.md)  
> Sample Q&A (guided): [weeks/week-03/day-15/sample/](../../../weeks/week-03/day-15/sample/README.md)

## 1. Outcome

Explain aloud, in plain sentences:

- Why features depend on **interfaces**, never other feature **implementations**
- How **SPM** targets map to Interface / Impl / Core and what that buys for build parallelism
- How the **composition root** (App target) wires a DI graph without feature-level singletons
- How you designed the **Stories SDK** as a reusable module adopted across the portfolio
- Trade-offs: CocoaPods vs SPM, static vs dynamic linking, constructor/tree DI vs service locator

## 2. Concept refresh (simple)

### 2.1 Module hierarchy

```text
App (composition root)
  → Feature Impl (UI + logic)
    → Feature Interface (protocols, DTOs, builders)
      → Core (network, storage, design system)
```

Cross-feature navigation: Feature A imports `FeatureBInterface`, asks DI for `FeatureBBuildable`; App registered the real builder.

### 2.2 SPM packaging

Interface targets build fast and change rarely; Impl targets compile in parallel. Circular deps fail at resolve time — not as mysterious runtime loops.

### 2.3 DI without hidden globals

Prefer **constructor injection** or a **tree of components** over service locators. The App target fulfills dependency protocols; features receive protocols, not `.shared` singletons.

### 2.4 Critical truths (pin)

| Claim | Truth |
|---|---|
| Feature A → Feature B | Depend on **B’s Interface**, never B’s Impl |
| Composition root | **App target** wires concrete builders |
| `NetworkManager.shared` in features | Anti-pattern — hides DI graph |
| Packaging vs architecture | Clean boundary can live in CocoaPods **or** SPM |
| Service locator | Runtime missing deps — constructor/tree DI is safer |
| Stories SDK (Raw / Miami Heat) | Standalone Stories SDK + portfolio adoption — **no** invented build-time % |

## 3. Read these

| Priority | Resource | Why |
|---|---|---|
| Must | [Sample Q&A](../../../weeks/week-03/day-15/sample/) | Guided cards |
| Must | Full modules [01–03](../../../weeks/week-03/day-15/01-foundations.md) | Gaps |
| Deepen | [app-modularization.md](../../../ios-system-design/docs/app-modularization.md) | HLD vocabulary |
| Drill | [04-questions](../../../weeks/week-03/day-15/04-questions.md) | Timed answers |

## 4. Map to your work

**Stories SDK (Raw / Miami Heat):** Raw Engineering — standalone reusable Stories SDK with public API and injected host dependencies; adopted across NBA/WNBA portfolio apps.

**Soft hooks:** BookMyShow Ads pipeline + HeroWidget lifecycle Ads as a module boundary (POP + Generics); District Free Parking + Clean/MVVM + AI tooling Clean/MVVM test discipline; BookMyShow SSL pinning + URLSession migration packaging ≠ architecture (Ads pod path).

**Interview line (≤20s):** “I shipped Stories as a standalone SDK with a clear public API and injected host dependencies — one module, multiple apps, no copy-paste forks.”

→ [Stories SDK (Raw / Miami Heat) Stories SDK](../../stories/story-bank.md#s10--stories-sdk-raw--miami-heat)

## 5. Flash prompts

1. Why modularize — three reasons in one breath
2. Interface vs Impl — what lives where?
3. Composition root — who wires what?
4. Feature A navigates to Feature B without importing B’s Impl
5. CocoaPods vs SPM — packaging choice, not architecture quality
6. Service locator vs constructor injection — pick and defend
7. Static vs dynamic frameworks — launch impact
8. Stories SDK extraction — public API, host injects providers
9. Stories SDK (Raw / Miami Heat) ≤20s — no invented build-time %
10. “Folders as modules” — why that fails at scale

## 6. Timed drills

| Drill | Budget |
|---|---|
| Module hierarchy diagram | 60s |
| DI composition root | 45s |
| Cross-feature navigation via Interface | 45s |
| Stories SDK extraction pitch | 60s |
| Service locator vs constructor | 90s |
| Stories SDK (Raw / Miami Heat) ≤20s pitch | 20s |

Expand from [sample cards](../../../weeks/week-03/day-15/sample/) and [04-questions](../../../weeks/week-03/day-15/04-questions.md) answer points.
