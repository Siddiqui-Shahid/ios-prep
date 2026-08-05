# Day 02 — Protocols, POP, Generics, Associated Types, Type Erasure

> Week 1 · Phase: Swift mastery · Time budget today: ~4–5 hrs  
> Full study twin: [weeks/week-01/day-02](../../../weeks/week-01/day-02/README.md)

## 1. Outcome

Explain aloud, in plain sentences:

- Protocol-oriented design vs inheritance for UI / ad pipelines
- Generics + associated types + `where` clauses — who chooses the type
- When you need type erasure and what it costs
- How BookMyShow Ads / HeroWidget used POP + generics for a type-safe renderer

## 2. Concept refresh (simple)

### 2.1 Protocol-Oriented Programming (POP)

Design around capabilities (`Renderable`, `Trackable`, `PlaybackControllable`) composed with extensions. Prefer that over deep class trees for ad units and similar variants.

```swift
protocol AdRenderable {
    associatedtype Content
    func render(_ content: Content) -> UIView
}
```

### 2.2 Generics vs protocols with associated types

- **Generics:** the caller chooses the concrete type; the compiler can specialize; best for pipelines.
- **Associated types:** the adopting type chooses; hard to store as a plain protocol value / mixed array without help.
- Keep APIs generic: `func install<R: AdRenderable>(_ r: R)`. Erase only at boundaries when you must mix shapes.
- Modern Swift (`any` / `some`) improved some cases — still know the trade-offs.

### 2.3 Type erasure

When you must store mixed values that each pick different associated types, build a box with one common interface. Cost: allocation, indirection, lost specialization.

### 2.4 Static vs dynamic dispatch

Protocol witness table (dynamic) vs generic specialization (static). Extension defaults that are not requirements can surprise you when the variable is typed as the protocol.

### 2.5 Trade-offs

| Choice | When | Cost |
|---|---|---|
| POP + generics pipeline | Many ad/SDUI variants | Learning curve; associated-type friction |
| Inheritance hierarchy | Rare shared identity | Fragile base class |
| Type erasure | Mixed arrays / boundaries | Runtime cost |
| `any Protocol` | Flexibility | Existential overhead |

## 3. Read these

| Priority | Resource | Why |
|---|---|---|
| Must | Full Day 02 [`01-foundations`](../../../weeks/week-01/day-02/01-foundations.md) + [`02-deep-dive`](../../../weeks/week-01/day-02/02-deep-dive.md) | Teaching prose + traps |
| Must | [Protocols](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/protocols/) | Extensions, composition |
| Must | [Generics](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/generics/) | Constraints, where |
| Repo | Skim [sdui-engine.md](../../../ios-system-design/docs/sdui-engine.md) | Same POP shape as SDUI |

## 4. Map to your work

**Company / feature:** BookMyShow — Ads module / HeroWidget  
**What you did:** Refactored highest-revenue module with POP + Generics for type-safe rendering; video pause/play lifecycle on HeroWidget.  
**Interview line (≤20s):** “We made ad rendering a generic protocol pipeline so new creatives plugged in without forking the revenue path.”

→ [S1 Ads](../../stories/story-bank.md#s1--ads-module-refactor--herowidget-bookmyshow) · [S10 Stories SDK](../../stories/story-bank.md#s10--stories-sdk-raw--miami-heat)

## 5. Flash prompts

1. POP in one sentence + one capability example
2. Caller picks `T` vs adopter picks associated type
3. Why a mixed `[AdRenderable]` is awkward
4. Four strategies when associated types block existentials
5. Extension-default dispatch trap
6. Type erasure cost in one breath
7. S1 ≤20s pitch (no invented %)

## 6. Timed drills

| Drill | Budget |
|---|---|
| S1 pitch | 20s |
| associatedtype vs generic | 45s |
| Architecture whiteboard | 5 min |

Speak from Day 02 [`04-questions`](../../../weeks/week-01/day-02/04-questions.md) answer points.
