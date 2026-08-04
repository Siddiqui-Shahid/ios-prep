# Day 02 — Protocols, POP, Generics, Associated Types, Type Erasure

> Week 1 · Phase: Swift mastery · Time budget today: ~4–5 hrs

## 1. Outcome

Explain aloud:

- Protocol-oriented design vs inheritance for UI component pipelines
- Generics + associated types + `where` clauses
- When you need type erasure (`AnyPublisher`-style) and the cost
- How BMS Ads **HeroWidget** used POP + Generics for a type-safe renderer

## 2. Concept deep dive

### 2.1 Protocol-Oriented Programming (POP)

Design around capabilities (`Renderable`, `Trackable`, `LifecycleAware`) composed with extensions. Prefer protocol composition over deep class hierarchies for ad units, form fields, SDUI components.

```swift
protocol AdRenderable {
    associatedtype Content
    func render(_ content: Content) -> UIView
}
```

### 2.2 Generics vs protocols with associated types (PATs)

- **Generics:** Caller chooses concrete type; compiler specializes; best for pipelines.
- **PATs:** Cannot use as existential easily (`any AdRenderable` limitations historically); often pair with generics: `func install<R: AdRenderable>(_ r: R)`.
- Swift 5.7+ `any` / `some` improved existentials — still know the trade-offs.

### 2.3 Type erasure

When you must store heterogeneous PAT-conforming values, erase: wrapper class/struct holding `boxes` with a common interface. Cost: allocation, indirection, lost specialization.

### 2.4 Static vs dynamic dispatch

Protocol witness table (dynamic) vs generic specialization (static). `final` classes / generics help performance-sensitive paths (cell configure, ad bind).

### 2.5 Trade-offs

| Choice | When | Cost |
|---|---|---|
| POP + generics pipeline | Many ad/SDUI variants | Learning curve; PAT friction |
| Inheritance hierarchy | Rare shared identity | Fragile base class |
| Type erasure | Heterogeneous arrays | Runtime cost |
| `any Protocol` | Flexibility | Existential overhead |

## 3. Read these

| Priority | Resource | Why |
|---|---|---|
| Must | [Protocols](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/protocols/) | Extensions, composition |
| Must | [Generics](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/generics/) | Constraints, where |
| Deepen | [Swift Generics Manifesto](https://github.com/apple/swift/blob/main/docs/GenericsManifesto.md) (skim) | Mental model |
| Repo | Skim component registry ideas in [sdui-engine.md](../../../ios-system-design/docs/sdui-engine.md) | Same POP shape as SDUI |

## 4. Map to your work

**Company / feature:** BookMyShow — Ads module / HeroWidget  
**What you did:** Refactored highest-revenue module with POP + Generics for type-safe rendering; video pause/play lifecycle on HeroWidget.  
**Interview line (≤20s):** “We made ad rendering a generic protocol pipeline so new creatives plugged in without forking the revenue path.”

→ [S1 Ads](../../stories/story-bank.md#s1--ads-module-refactor--herowidget-bookmyshow) · [S10 Stories SDK](../../stories/story-bank.md#s10--stories-sdk-raw--miami-heat) for reusable protocol APIs

## 5. Normal questions

### Q1. What is POP? `(30–45s)`
**Skeleton:** Design by composing protocols + extensions; prefer over inheritance.  
**Story:** S1 Ads.

### Q2. associatedtype vs generic parameter? `(45–60s)`
**Skeleton:** associatedtype belongs to conforming type; generics chosen by caller.  
**Follow-up:** Can you put PAT in an array?

### Q3. `some` vs `any`? `(45s)`
**Skeleton:** opaque concrete vs existential.  
**Follow-up:** Performance difference.

### Q4. Why generics in an ads pipeline? `(45s)`
**Skeleton:** Compile-time type safety; avoid `Any` casts in revenue code.  
**Story:** S1.

### Q5. Protocol extension default methods — dispatch catch? `(60s)`
**Skeleton:** Defaults are not always dynamically dispatched unless requirement declared.  
**Follow-up:** How to force dynamic dispatch.

### Q6. What is type erasure? `(45s)`
**Skeleton:** Wrap PAT to common type; example AnyPublisher.  
**Follow-up:** Cost?

### Q7. Protocol composition (`A & B`)? `(30s)`
**Skeleton:** Require multiple capabilities.  
**Story:** Renderable & Trackable ads.

### Q8. When is inheritance still OK? `(45s)`
**Skeleton:** UIKit subclasses; shared identity; ObjC.  
**Follow-up:** Mixing POP + UIView subclasses.

### Q9. Conditional conformance? `(45s)`
**Skeleton:** `Array: Equatable where Element: Equatable`.  
**Follow-up:** Use in model layers.

### Q10. Generics for repository interfaces? `(45s)`
**Skeleton:** `Repository` with associated `Model` / generic methods.  
**Story:** District Clean boundaries.

### Q11. Difference between `protocol P: AnyObject` and struct-friendly protocols? `(45s)`
**Skeleton:** Class-bound for weak refs / identity.  

## 6. Tricky questions

### T1. Why can’t you write `var x: [AdRenderable]` easily with associated types? `(120s)`
**Trap:** “Just use the protocol name.”  
**Senior answer:** PAT + Self/associatedtype prevent simple existentials historically; use generics, type erasure, or constrained `any` carefully.

### T2. Default implementation in extension vs requirement — override surprise `(90s)`
**Trap:** Expect polymorphic call to default.  
**Senior answer:** If not a protocol requirement, static dispatch to default via witness of static type.

### T3. Type-erasing a generic renderer — when is it worth it? `(90s)`
**Trap:** Erase everything.  
**Senior answer:** Only at module boundaries / heterogeneous lists; keep generics inside hot pipeline.

### T4. POP for SDUI component registry vs enums `(120s)`
**Trap:** Enum of all components forever.  
**Senior answer:** Enum is closed; protocol registry is open for CMS growth — need versioning + unknown fallback (preview Day 10).

### T5. Generics overkill for two ad types? `(90s)`
**Trap:** Always abstract.  
**Senior answer:** YAGNI — introduce POP when third variant or test seams demand it; at BMS revenue scale, variants justified abstraction.

### T6. `rethrows` + generic higher-order functions `(90s)`
**Trap:** Ignore error propagation.  
**Senior answer:** Propagate only if closure throws; clean API for mappers.

## 7. Flashcards for today

| Front | Back |
|---|---|
| POP | Compose protocols · Trap: deep inheritance · Prod: Ads pipeline |
| associatedtype | Conformer picks type · Trap: use as easy existential · Prod: AdRenderable |
| some vs any | Opaque vs existential · Trap: synonym · Prod: View returns |
| Type erasure | Box PAT · Trap: free · Prod: heterogeneous ads list |
| Protocol extension dispatch | Defaults may be static · Trap: expect override · Prod: shared track() |
| Generics benefit | Specialize + safety · Trap: Any everywhere · Prod: HeroWidget |
| AnyObject protocol | Class-bound · Trap: struct conform · Prod: weak delegate |
| Conditional conformance | where on extension · Trap: always free · Prod: model arrays |
| Composition A & B | Multi-capability · Trap: multiple inheritance myth · Prod: Render+Track |
| Open vs closed SDUI | Registry vs enum · Trap: enum forever · Prod: BMS header |
| Witness table | Dynamic protocol dispatch · Trap: always slow · Prod: cell bind |
| SDK public API | Protocols at boundary · Trap: expose concretes · Prod: Stories SDK |

## 8. Practice

- **Coding:** Build a mini ads pipeline: `protocol Creative`, `struct VideoCreative`, `struct ImageCreative`, `struct Renderer<C: Creative>`. Add pause/play protocol for video only via composition.
- **SD:** Note how SDUI component registry mirrors POP (read 15 min of sdui-engine component registry section).

## 9. Timed drill

1. Record Q1, Q4, Q6, T1, T4.
2. Deliver S1 architecture talk in **≤5 min** using timing guide architecture template (dry run for Day 14).
3. Score; log gotchas.
