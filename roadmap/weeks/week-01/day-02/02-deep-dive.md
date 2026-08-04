# 02 — Deep Dive: PATs, Dispatch, some/any, Type Erasure

> Mechanics and traps. Intern foundations assumed. This is the interview depth layer.

---

## 1. Associated types under pressure

### 1.1 Self and associated types constrain existentials

```swift
protocol AdRenderable {
    associatedtype ContentView: UIView
    associatedtype Model
    func render(_ model: Model) -> ContentView
}
```

Problems you must be able to explain:

1. **Heterogeneous collections** — different `Model` / `ContentView` per conformer.
2. **Returning `AdRenderable` from a function** — which associated types?
3. **Storing as a property** typed only as the protocol — same issue.

Historical teaching (still valid as *mental model*): PATs were not usable as simple existentials the way `Error` or `Equatable`-free protocols were.

Modern Swift (`any`, primary associated types, constraints on existentials) improved some cases — you still need a strategy:

| Strategy | When |
|---|---|
| Stay generic end-to-end | Hot pipeline, max safety + specialization |
| Type erase at the boundary | Heterogeneous list / plugin registry |
| Constrained `any P` | Language allows the operations you need |
| Enum of known creatives | Closed set, rare additions |

### 1.2 Primary associated types (awareness)

```swift
protocol AdRenderable<Model> {
    associatedtype Model
    associatedtype ContentView: UIView
    func render(_ model: Model) -> ContentView
}

// Call sites can constrain the existential more usefully in newer Swift:
func handle(_ ad: any AdRenderable<HeroModel>) { ... }
```

**Interview line:** “Primary associated types make some existentials usable by fixing part of the type shape — they don’t make every PAT free as `[any P]` for arbitrary operations.”

### 1.3 Same idea with `IteratorProtocol` / `Sequence`

Swift’s own standard library uses type erasure (`AnyIterator`, `AnySequence`) precisely because associated types block easy existentials. `AnyPublisher` in Combine is the same idea for reactive pipelines.

If you can explain *why AnyPublisher exists*, you can explain ads type erasure.

---

## 2. Generics + PATs together (the ads pipeline shape)

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

**Teaching points:**

- Outer API is generic → compiler sees concrete `C`.
- Video-only behavior is composed, not forced onto image creatives.
- No `as? VideoCreative` in the revenue path.

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

This is how you keep specialization without casting.

### 2.3 Generic typealiases for readability

```swift
typealias TrackedCreative = AdRenderable & AdTrackable
typealias HeroCapable = TrackedCreative & PlaybackControllable
```

Use in signatures so interview whiteboards stay readable.

---

## 3. Static vs dynamic dispatch (senior must-know)

### 3.1 Three dispatch flavors you’ll mention

| Mechanism | Typical trigger | Intuition |
|---|---|---|
| Static (direct) | Concrete type, `final`, generics specialized | Compiler knows exact method |
| Witness table | Protocol requirement called via existential / generic unconstrained path | Dynamic but protocol-scoped |
| ObjC / `dynamic` | `@objc` / NSObject message send | Runtime messaging |

You do **not** need assembly. You need this sentence:

> “Generics can specialize; protocol existentials go through witness tables; extension defaults that aren’t requirements may bind to the static type.”

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

**Trap:** Expecting `wave` to call `Person.wave` through the existential.  
**Fix:** Declare `wave()` as a protocol requirement if polymorphic behavior matters.

### 3.3 Why this matters for ads

Shared `track()` defaults in an extension are fine for identical behavior. Custom per-creative tracking that must override must be a **requirement** (or a generic call on the concrete type).

---

## 4. `some` vs `any` (deep)

### 4.1 Opaque (`some`)

```swift
func heroWidget() -> some PlaybackControllable {
    VideoHero() // one concrete type forever for this function
}
```

Rules of thumb:

- Caller cannot change which concrete type is returned.
- Good for hiding implementation (SwiftUI `some View` energy).
- Still one type → specialization-friendly.

### 4.2 Existential (`any`)

```swift
var tile: any AdTrackable
tile = ImageAd()
tile = VideoAd()  // OK if both conform and associated types don’t block the operations you use
```

Costs:

- Existential container / witness table
- Less specialization
- Operations involving `Self` or associated types may be unavailable

### 4.3 Interview contrast table

| Need | Prefer |
|---|---|
| Hide one concrete return type | `some P` |
| Heterogeneous stored values | `any P` or type eraser |
| Max performance in hot bind | Generics on concrete / `some` |
| API flexibility for plugins | Erasure or registry of factories |

---

## 5. Type erasure — full mental model

### 5.1 When you need it

You need a single type `AnyAd` such that:

```swift
let feed: [AnyAd] = [AnyAd(ImageAd()), AnyAd(VideoAd())]
feed.forEach { $0.trackImpression() }
```

But `AdRenderable` has associated types, so you cannot store raw PATs.

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

You intentionally collapse `ContentView` to `UIView` at the boundary.

### 5.3 Costs you must say aloud

| Cost | Detail |
|---|---|
| Allocation | Closures / box class often heap-allocate |
| Indirection | Extra call through stored function |
| Lost specialization | Compiler sees `AnyAd`, not `VideoAd` |
| API narrowing | Associated richness reduced to common denominator |

**Senior rule:** Keep generics **inside** the hot pipeline; erase **at** module boundaries or heterogeneous lists only.

### 5.4 Combine mental transfer

`AnyPublisher<Output, Failure>` exists so you can return/store publishers without leaking nested generic operator types. Same motive as `AnyAd`.

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
Cons: every new creative is an app release + enum edit.

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
Cons: unknown types need fallback; versioning matters.

> Soft bridge to BookMyShow backend-driven header (Verified · S3) and Applied · S3-A1 unknown-component fallback — deepen in SDUI weeks. Today only note the **shape** matches POP.

---

## 7. Mixing POP with UIKit identity (HeroWidget)

HeroWidget needs:

1. A real view / VC lifecycle (class identity)
2. Pause/play when visibility changes
3. Clean contracts so the ads pipeline doesn’t care about player internals

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

**Interview line:**  
> “POP gave us the pipeline; HeroWidget was still a class because lifecycle and player identity are reference concerns — pause/play tied to visibility.”

> **Provenance:** Verified · S1 · HeroWidget pause/play lifecycle

---

## 8. Trade-off tables (memorize)

### 8.1 Architecture choices

| Choice | When | Cost |
|---|---|---|
| POP + generics pipeline | Many variants; test seams; revenue safety | Learning curve; PAT friction |
| Inheritance tree | Rare shared UIKit identity | Fragile base; hard reuse |
| Type erasure | Heterogeneous arrays / boundaries | Allocation, indirection |
| `any Protocol` | Flexibility | Existential overhead; PAT limits |
| Closed enum | Stable small set | App release for every new case |

### 8.2 YAGNI vs revenue scale

| Situation | Advice |
|---|---|
| Two similar ad types forever | Maybe don’t abstract yet |
| Highest-revenue module, growing creatives | Abstraction pays for itself (S1 justification) |
| SDK public surface (Stories) | Protocols at boundary — Verified · S10 soft bridge |

**Trap answer:** “Always POP everything.”  
**Senior answer:** “Introduce POP when variants or test seams demand it; at BMS ads scale, variants justified the pipeline.”

---

## 9. Conditional conformance & protocol inheritance (extra)

### 9.1 Protocol inheritance

```swift
protocol AdRenderable { ... }
protocol VideoAdRenderable: AdRenderable, PlaybackControllable {
    var duration: TimeInterval { get }
}
```

Refine capabilities without inventing a class hierarchy.

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

**Say:**  
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
5. **Trade-off:** Generics inside; erasure only if heterogeneous feed requires it.
6. **Honesty:** No invented fill-rate %; maintainable type-safe pipeline is the claim.

---

## 12. Anti-patterns checklist

| Anti-pattern | Fix |
|---|---|
| `Any` + cast ladder in bind | Generic constraint or typed factory |
| Deep `AdView` subclass tree | Capability protocols |
| Erasing every generic | Erase at boundary only |
| Extension-only overrides | Promote to requirements |
| Claiming `any` == free | Know existential + PAT limits |
| “Structs can’t do POP” | Structs are first-class conformers |
| Forgetting UIKit subclass needs | Class for view identity; POP for capabilities |

---

## 13. Code tour (do before questions)

1. Open [`code/AdsPipeline.swift`](code/AdsPipeline.swift) — explain each protocol + generic pipeline aloud.
2. Open [`code/TypeErasureDemo.swift`](code/TypeErasureDemo.swift) — explain why `AnyTrackable` exists.
3. Speak one trap: extension dispatch **or** PAT-in-array.

Then continue to [`03-production-bridge.md`](03-production-bridge.md).

---

## 14. Deep self-check

- [ ] Can you draw POP vs inheritance for three ad types?
- [ ] Can you explain associatedtype vs generic parameter in 20s?
- [ ] Can you justify type erasure cost in one breath?
- [ ] Can you demo the extension-default dispatch surprise?
- [ ] Can you deliver S1 architecture agenda in 15s?

If yes → production bridge. If no → re-read §§3–5 and re-speak.
