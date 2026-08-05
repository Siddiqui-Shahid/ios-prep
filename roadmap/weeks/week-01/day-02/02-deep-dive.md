# 02 — Deep Dive: Associated Types, Dispatch, some/any, Type Erasure

> This file goes deeper. Foundations are assumed. Read slowly. Every section should answer: *what is the problem, why does it happen, what do you do about it?*

---

## 1. Associated types under pressure

### 1.1 Why a “simple protocol variable” suddenly stops working

Start with this protocol:

```swift
protocol AdRenderable {
    associatedtype ContentView: UIView
    associatedtype Model
    func render(_ model: Model) -> ContentView
}
```

In plain words: each ad that adopts this protocol must decide two things for itself —

1. **What model** it renders (`Model`)
2. **What view** it returns (`ContentView`)

Image ads and video ads will often pick *different* answers. That is useful. It is also why these three situations get hard:

**1. Mixed arrays**  
You want `[imageAd, videoAd]` in one list. But each item may have a different `Model` and a different `ContentView`. The language cannot treat them as “the same protocol shape” without help.

**2. Returning the protocol from a function**  
If a function says “I return `AdRenderable`”, the caller still does not know which `Model` or `ContentView` came back. The type system needs a concrete answer, or a strategy that hides those differences.

**3. Storing a property typed only as the protocol**  
Same issue. A property typed as “just the protocol” does not know which associated types sit inside.

Older teaching still helps as a mental model: protocols with associated types were not usable as simple existentials the way a plain protocol like `Error` often was.

Modern Swift (`any`, primary associated types, constraints on existentials) made some cases better. You still need a plan. Here are the four common plans in human words:


| What you do                         | When it fits                                                         |
| ----------------------------------- | -------------------------------------------------------------------- |
| Keep the whole pipeline **generic** | Hot path. You want max safety and the compiler to see the real type. |
| **Type-erase** at the boundary      | You truly need a mixed list, a plugin registry, or a module edge.    |
| Use **constrained** `any P`         | The language lets you do the operations you need after constraining. |
| Use an **enum of known creatives**  | Closed set. New types are rare and you are fine editing the enum.    |


Do not memorize the table as keywords only. Memorize the *decision*: stay generic while you can; erase only when you must mix shapes.

### 1.2 Primary associated types (awareness)

```swift
protocol AdRenderable<Model> {
    associatedtype Model
    associatedtype ContentView: UIView
    func render(_ model: Model) -> ContentView
}

// Newer Swift can make some call sites clearer:
func handle(_ ad: any AdRenderable<HeroModel>) { ... }
```

Interview line in plain English:

> “Primary associated types let you pin down part of the shape — for example, ‘this existential uses HeroModel’. That helps some cases. It does not magically make every protocol with associated types free as an unconstrained `[any P]` for every operation.”



### 1.3 Same idea in Apple’s own libraries

Swift’s standard library uses type erasure (`AnyIterator`, `AnySequence`) because associated types block easy existentials. Combine’s `AnyPublisher` is the same idea for reactive pipelines.

If you can explain *why AnyPublisher exists*, you can explain why an ads type eraser exists.

---



## 2. Generics + associated types together (the ads pipeline shape)



### 2.1 Preferred shape

```swift
protocol Creative {
    associatedtype View: UIView
    func makeView() -> View
}

protocol PlaybackControllable {
    func pause()
    func play()
}

struct HeroPipeline<C: Creative> {
    let creative: C

    func install(into parent: UIView) -> C.View {
        let view = creative.makeView()
        parent.addSubview(view)
        return view
    }
}

// Video-only overlay of capabilities
func bindPlayback<C: Creative & PlaybackControllable>(_ c: C) {
    c.pause()
}
```

What this is doing:

- The outer API is **generic**, so the compiler still sees a concrete `C`.
- Video-only behavior is an **extra capability**. Image creatives are not forced to pretend they play video.
- You avoid `as? VideoCreative` on the revenue path. New types plug in by conforming, not by casting.



### 2.2 `where` clauses for associated types

```swift
func dump<C: Creative>(_ c: C) where C.View: UIImageView {
    // Only creatives whose View is UIImageView
}

extension Array {
    func renderAll<V: UIView>() -> [V] where Element: Creative, Element.View == V {
        map { $0.makeView() }
    }
}
```

`where` lets you say: “only when the associated view is this kind.” You keep specialization. You avoid casting.

### 2.3 Typealiases for readable signatures

```swift
typealias TrackedCreative = AdRenderable & AdTrackable
typealias HeroCapable = TrackedCreative & PlaybackControllable
```

These are just short names for long “and” contracts. Useful on a whiteboard.

---



## 3. Static vs dynamic dispatch (senior must-know)



### 3.1 Three flavors you should be able to name


| Mechanism        | Typical trigger                                            | Plain intuition                     |
| ---------------- | ---------------------------------------------------------- | ----------------------------------- |
| Static (direct)  | Concrete type, `final`, specialized generics               | Compiler knows the exact method     |
| Witness table    | Protocol requirement through an existential / generic path | Dynamic, but scoped to the protocol |
| ObjC / `dynamic` | `@objc` / NSObject message send                            | Runtime messaging                   |


You do not need assembly. You need this sentence:

> “Generics can specialize. Protocol existentials go through witness tables. Extension defaults that are not requirements may bind to the static type — and that can surprise you.”



### 3.2 The extension default trap (classic interview)

```swift
protocol Greeter {
    func greet()
}

extension Greeter {
    func greet() { print("protocol default") }
    func wave() { print("extension-only wave") } // NOT a requirement
}

struct Person: Greeter {
    func greet() { print("person greet") }
    func wave() { print("person wave") }
}

let p: any Greeter = Person()
p.greet()  // "person greet" — requirement, dynamic
p.wave()   // "extension-only wave" — static via Greeter, surprise!
```

What went wrong? You expected `wave` to call `Person.wave` through the protocol-typed variable. It did not, because `wave` was never a protocol requirement.

Fix: if polymorphic behavior matters, declare `wave()` in the protocol body.

### 3.3 Why this matters for ads

Shared `track()` defaults in an extension are fine when every creative should behave the same.  
Custom per-creative tracking that *must* override belongs in the protocol as a requirement — or call it on the concrete / generic type.

---



## 4. `some` vs `any` (deep)



### 4.1 Opaque (`some`)

```swift
func heroWidget() -> some PlaybackControllable {
    VideoHero() // one concrete type forever for this function
}
```

Rules of thumb:

- The caller cannot swap which concrete type comes back.
- Good for hiding implementation (same energy as SwiftUI’s `some View`).
- Still one type → friendly to specialization.



### 4.2 Existential (`any`)

```swift
var tile: any AdTrackable
tile = ImageAd()
tile = VideoAd()  // OK if both adopt and the operations you need are available
```

Costs in plain words:

- Extra box / witness table
- Less specialization
- Operations that need `Self` or associated types may be unavailable



### 4.3 Quick contrast


| Need                          | Prefer                                   |
| ----------------------------- | ---------------------------------------- |
| Hide one concrete return type | `some P`                                 |
| Store different adopters      | `any P` or a type eraser                 |
| Max performance in a hot bind | Generics on the concrete type, or `some` |
| Plugin-style flexibility      | Erasure or a registry of factories       |


---



## 5. Type erasure — full mental model



### 5.1 When you need it

You want one type, say `AnyAd`, so this works:

```swift
let feed: [AnyAd] = [AnyAd(ImageAd()), AnyAd(VideoAd())]
feed.forEach { $0.trackImpression() }
```

But if the original protocol has associated types, you often cannot store the raw protocol values. So you build a box that hides the differences.

### 5.2 Hand-rolled eraser (learning-lab pattern)

```swift
protocol AdTrackable {
    var creativeID: String { get }
    func trackImpression()
}

struct AnyAd: AdTrackable {
    private let _id: String
    private let _track: () -> Void

    var creativeID: String { _id }

    init<A: AdTrackable>(_ base: A) {
        _id = base.creativeID
        _track = { base.trackImpression() }
    }

    func trackImpression() { _track() }
}
```

For richer APIs (render returning different view types), erase to a **common** output (`UIView`) inside the box:

```swift
struct AnyRenderable {
    private let _render: () -> UIView
    init<R: AdRenderable>(_ base: R) {
        _render = { base.makeView() } // views upcast to UIView
    }
    func makeView() -> UIView { _render() }
}
```

You intentionally collapse `ContentView` to `UIView` at the boundary. That is the trade: one usable type, less specific detail.

### 5.3 Costs you must be able to say


| Cost                | Plain detail                                         |
| ------------------- | ---------------------------------------------------- |
| Allocation          | Closures / box classes often land on the heap        |
| Indirection         | Extra call through a stored function                 |
| Lost specialization | Compiler sees `AnyAd`, not `VideoAd`                 |
| Narrower API        | Rich associated types shrink to a common denominator |


**Senior rule:** keep generics **inside** the hot pipeline; erase **at** module boundaries or mixed lists only.

### 5.4 Combine mental transfer

`AnyPublisher<Output, Failure>` exists so you can return or store publishers without leaking nested generic operator types. Same motive as `AnyAd`.

---



## 6. Open vs closed component sets (SDUI bridge)



### 6.1 Closed enum

```swift
enum AdKind {
    case image(ImageModel)
    case video(VideoModel)
}
```

Pros: exhaustive switches, simple.  
Cons: every new creative is an app release plus an enum edit.

### 6.2 Open protocol registry

```swift
protocol AdComponentFactory {
    func supports(_ type: String) -> Bool
    func make(from json: [String: Any]) -> AnyRenderable?
}

final class AdRegistry {
    private var factories: [AdComponentFactory] = []
    func register(_ f: AdComponentFactory) { factories.append(f) }
    func make(type: String, json: [String: Any]) -> AnyRenderable? {
        factories.first { $0.supports(type) }?.make(from: json)
    }
}
```

Pros: CMS / backend can introduce types your factories understand.  
Cons: unknown types need a fallback; versioning matters.

> Soft bridge to BookMyShow backend-driven header (Verified · S3) and Applied · S3-A1 unknown-component fallback — deepen in SDUI weeks. Today only notice: the **shape** matches POP.

---



## 7. Mixing POP with UIKit identity (HeroWidget)

HeroWidget needs three things at once:

1. A real view / view-controller lifecycle (class identity)
2. Pause and play when visibility changes
3. Clean contracts so the ads pipeline does not care about player internals

Sketch:

```swift
protocol PlaybackControllable: AnyObject {
    func play()
    func pause()
}

final class HeroWidget: UIView, PlaybackControllable {
    private let player: AVPlayer

    func play() { player.play() }
    func pause() { player.pause() }

    func didEnterVisibleViewport() { play() }
    func didLeaveVisibleViewport() { pause() }
}
```

Interview line:

> “POP gave us the pipeline. HeroWidget was still a class because lifecycle and player identity are reference concerns — pause and play tied to visibility.”

> **Provenance:** Verified · S1 · HeroWidget pause/play lifecycle

---



## 8. Trade-off tables (memorize the decisions)



### 8.1 Architecture choices


| Choice                  | When                                      | Cost                                         |
| ----------------------- | ----------------------------------------- | -------------------------------------------- |
| POP + generics pipeline | Many variants; test seams; revenue safety | Learning curve; associated-type friction     |
| Inheritance tree        | Rare shared UIKit identity                | Fragile base; hard reuse                     |
| Type erasure            | Mixed arrays / boundaries                 | Allocation, indirection                      |
| `any Protocol`          | Flexibility                               | Existential overhead; associated-type limits |
| Closed enum             | Stable small set                          | App release for every new case               |




### 8.2 YAGNI vs revenue scale


| Situation                                 | Advice                                                 |
| ----------------------------------------- | ------------------------------------------------------ |
| Two similar ad types forever              | Maybe do not abstract yet                              |
| Highest-revenue module, growing creatives | Abstraction pays for itself (S1 justification)         |
| SDK public surface (Stories)              | Protocols at the boundary — Verified · S10 soft bridge |


Trap answer: “Always POP everything.”  
Senior answer: “Introduce POP when variants or test seams demand it. At BookMyShow ads scale, variants justified the pipeline.”

---



## 9. Conditional conformance & protocol inheritance (extra)



### 9.1 Protocol inheritance

```swift
protocol AdRenderable { ... }
protocol VideoAdRenderable: AdRenderable, PlaybackControllable {
    var duration: TimeInterval { get }
}
```

You refine capabilities without inventing a class hierarchy.

### 9.2 Conditional helpers

```swift
extension AdRenderable where Self: PlaybackControllable {
    func renderAndPrime() -> ContentView {
        let v = makeView()
        pause() // safe — Self is playback-capable
        return v
    }
}
```

---



## 10. SDK boundary lessons (S10 soft)

Stories SDK reused across a portfolio → public API should expose **protocols** (and carefully chosen value models), not a forest of concrete types clients must subclass.

Say:

> “Same instinct as ads: contracts at the boundary, concretes inside. On Stories we leaned on reusable SDK surfaces across brands.”

> **Provenance:** Verified · S10 · Stories SDK portfolio reuse  
> Do not invent client counts or latency numbers.

---



## 11. Common interview whiteboard flow (5 min)

Use this for Day 14 architecture dry-run / today’s timed drill:

1. **Agenda:** “Revenue ads path — problems with inheritance → POP contracts → generics pipeline → HeroWidget lifecycle → trade-offs.”
2. **Problem:** New creatives forking render code; video lifecycle bugs.
3. **Design:** `Creative` / `AdTrackable` / `PlaybackControllable`; `Pipeline<C: Creative>`.
4. **Lifecycle:** HeroWidget pause/play on visibility.
5. **Trade-off:** Generics inside; erasure only if a mixed feed requires it.
6. **Honesty:** No invented fill-rate %; maintainable type-safe pipeline is the claim.

---



## 12. Anti-patterns checklist


| Anti-pattern                    | Fix                                           |
| ------------------------------- | --------------------------------------------- |
| `Any` + cast ladder in bind     | Generic constraint or typed factory           |
| Deep `AdView` subclass tree     | Capability protocols                          |
| Erasing every generic           | Erase at the boundary only                    |
| Extension-only overrides        | Promote to requirements                       |
| Claiming `any` is free          | Know existential + associated-type limits     |
| “Structs can’t do POP”          | Structs are first-class adopters              |
| Forgetting UIKit subclass needs | Class for view identity; POP for capabilities |


---



## 13. Code tour (do before questions)

1. Open `[code/AdsPipeline.swift](code/AdsPipeline.swift)` — explain each protocol + generic pipeline aloud.
2. Open `[code/TypeErasureDemo.swift](code/TypeErasureDemo.swift)` — explain why `AnyTrackable` exists.
3. Speak one trap: extension dispatch **or** “why a mixed array of protocols with associated types is hard.”

Then continue to `[03-production-bridge.md](03-production-bridge.md)`.

---



## 14. Deep self-check

- [ ] Can you draw POP vs inheritance for three ad types?
- [ ] Can you explain associated type vs generic parameter in 20s?
- [ ] Can you justify type erasure cost in one breath?
- [ ] Can you demo the extension-default dispatch surprise?
- [ ] Can you deliver the S1 architecture agenda in 15s?

If yes → production bridge. If no → re-read §§3–5 and re-speak.