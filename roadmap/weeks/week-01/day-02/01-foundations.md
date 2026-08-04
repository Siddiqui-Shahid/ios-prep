# 01 — Foundations: POP, Generics, Associated Types

> Read this first. Goal: build a crisp mental model an intern can teach back, then layer the senior edges you’ll need in interviews.

---

## 0. One-sentence north star

**Design by composing capabilities (protocols + generics), not by growing inheritance trees — especially on revenue-critical UI pipelines.**

Everything below unpacks that sentence with Ads / HeroWidget as the production hook (Verified · S1).

---

## 1. Why POP exists (intern story)

### 1.1 The inheritance trap

Classic UIKit tutorials teach:

```text
UIView
  └── AdView
        ├── ImageAdView
        ├── VideoAdView
        └── CarouselAdView
              └── SponsoredCarouselAdView
```

Problems at scale:

| Pain | Why it hurts |
|---|---|
| Fragile base class | Shared `configure` grows god-methods |
| Forced shared identity | Everything is a class even when data isn’t |
| Hard to test | Must subclass or mock deep trees |
| New creative type | Fork or fight the hierarchy |
| Multiple “is-a” needs | Swift has single inheritance for classes |

**Say aloud:** “Inheritance models *what you are*. Protocols model *what you can do*.”

### 1.2 Capability thinking

An ad unit might need several **capabilities**:

| Capability | Protocol sketch | Who cares |
|---|---|---|
| Render into a view | `AdRenderable` | Listing / hero surface |
| Impression / click tracking | `AdTrackable` | Analytics / revenue |
| Video lifecycle | `PlaybackControllable` | HeroWidget pause/play |
| Prefetch assets | `Prefetchable` | Scroll performance |

A video hero ad composes `AdRenderable & AdTrackable & PlaybackControllable`.  
An image tile might only need `AdRenderable & AdTrackable`.

That composition is **protocol-oriented programming (POP)**.

### 1.3 The intern demo (do this once out loud)

```swift
protocol Describable {
    var summary: String { get }
}

struct ImageCreative: Describable {
    let title: String
    var summary: String { "Image: \(title)" }
}

struct VideoCreative: Describable {
    let title: String
    let duration: TimeInterval
    var summary: String { "Video: \(title) (\(Int(duration))s)" }
}

func logAll(_ items: [any Describable]) {
    items.forEach { print($0.summary) }
}
```

**Say aloud:** “Different types, same capability. No shared base class required.”

When `Describable` gains an `associatedtype`, the story changes — see §4 and deep dive. Keep this simple demo for the first 10 minutes.

---

## 2. Protocols as contracts

### 2.1 Requirements vs extensions

```swift
protocol AdTrackable {
    var creativeID: String { get }
    func trackImpression()
    func trackClick()
}

extension AdTrackable {
    // Default — convenient, but see dispatch traps in deep dive
    func trackClick() {
        print("default click \(creativeID)")
    }
}
```

| Piece | Role |
|---|---|
| Protocol body | **Requirements** — part of the contract; usually dynamic dispatch via witness table |
| Extension defaults | Convenience; may **not** override polymorphically if not declared as requirements |

**Intern takeaway:** Put methods you need to override/customize in the protocol requirement list.  
**Senior takeaway:** Extension-only defaults can surprise you at call sites typed as the protocol — Day 02 deep dive covers this trap in full.

### 2.2 Protocol composition

```swift
typealias HeroAd = AdRenderable & AdTrackable & PlaybackControllable

func installHero<A: HeroAd>(_ ad: A) {
    // Compiler knows A has all three capability sets
}
```

Composition is **and**, not multiple inheritance myths. You’re requiring a type that satisfies multiple contracts.

### 2.3 Class-bound protocols (`AnyObject`)

```swift
protocol AdDelegate: AnyObject {
    func adDidFail(_ error: Error)
}

final class AdLoader {
    weak var delegate: AdDelegate?
}
```

| Need | Protocol style |
|---|---|
| `weak` delegate / identity | `: AnyObject` (class-bound) |
| Struct-friendly models | Avoid `AnyObject`; prefer value conformers |
| UIKit subclassing | Class conformers are fine; still prefer protocols for *capabilities* |

---

## 3. Generics — caller chooses the type

### 3.1 Mental model

A **generic parameter** is a blank the **caller** fills in:

```swift
struct Renderer<Creative> {
    let creative: Creative
}

let imageRenderer = Renderer(creative: ImageCreative(title: "Show"))
let videoRenderer = Renderer(creative: VideoCreative(title: "Trailer", duration: 15))
```

Add constraints so you can *use* the type:

```swift
struct Renderer<Creative: AdTrackable> {
    let creative: Creative

    func bind() {
        creative.trackImpression()
    }
}
```

### 3.2 Why generics beat `Any` in revenue paths

```swift
// Fragile
func render(_ creative: Any) -> UIView {
    if let image = creative as? ImageCreative { ... }
    if let video = creative as? VideoCreative { ... }
    fatalError("unknown")
}

// Type-safe pipeline
func render<C: AdRenderable>(_ creative: C) -> C.ContentView {
    creative.makeView()
}
```

Casts hide bugs until a new creative ships on Friday night. Generics push mismatches to compile time.

> **Provenance:** Verified · S1 · BookMyShow · POP + Generics for a type-safe ads pipeline.  
> You may say the pipeline was type-safe. You may **not** invent fill-rate percentages.

### 3.3 `where` clauses (first pass)

```swift
func merge<C>(
    _ a: C,
    _ b: C
) -> C where C: AdTrackable & Equatable {
    // Only types that are trackable AND equatable
    return a == b ? a : b
}
```

`where` keeps the generic signature readable when constraints grow (especially with associated types — deep dive).

---

## 4. Associated types — conformer chooses the type

### 4.1 Mental model

An **associated type** is a blank the **conforming type** fills in:

```swift
protocol AdRenderable {
    associatedtype ContentView: UIView
    func makeView() -> ContentView
}

struct ImageAd: AdRenderable {
    // Conformer picks ContentView
    func makeView() -> UIImageView { UIImageView() }
}

struct VideoAd: AdRenderable {
    func makeView() -> UIView { PlayerContainerView() }
}
```

| Concept | Who chooses the concrete type? |
|---|---|
| `func f<T: P>(_ x: T)` | **Caller** (generic parameter) |
| `associatedtype` inside `P` | **Conformer** |

**Say aloud:** “Generics: I tell the function what T is. Associated types: the type that adopts the protocol decides.”

### 4.2 Why PATs feel “hard”

`AdRenderable` has an associated type → historically you could not freely write:

```swift
let ads: [AdRenderable] = ...  // ❌ often illegal / constrained
```

Because each conformer may have a *different* `ContentView`, so the existential can’t present one uniform shape without erasure or newer constrained `any` features.

Workarounds you’ll learn today:

1. Keep the pipeline **generic**: `func install<R: AdRenderable>(_ r: R)`
2. **Type-erase** to a common box when you truly need heterogeneous arrays
3. Use carefully constrained `any AdRenderable` where the language allows (know the limits)

### 4.3 Mini example tying both together

```swift
protocol Creative {
    associatedtype Body
    var body: Body { get }
}

struct Pipeline<C: Creative> {
    let creative: C
    func materialize() -> C.Body { creative.body }
}
```

Generic `Pipeline` is parameterized by a Creative that itself has an associated `Body`. This is the “POP + generics” shape used in component pipelines.

---

## 5. `some` vs `any` (foundations cut)

| Keyword | Meaning | Intern line |
|---|---|---|
| `some P` | Opaque type — *one* concrete type, hidden from the caller | “There’s a real type; you just can’t name it.” |
| `any P` | Existential — box that can hold different conformers (with limits) | “Could be different types behind the curtain.” |

```swift
func makeBadge() -> some Describable {
    ImageCreative(title: "Badge")  // always ImageCreative
}

func makeItems() -> [any Describable] {
    [ImageCreative(title: "A"), VideoCreative(title: "B", duration: 10)]
}
```

Performance intuition (enough for today):

- Generics / `some` → compiler can specialize (static-ish)
- `any` → witness table / existential container (dynamic)

Deep dive expands PAT + existential interactions.

---

## 6. Protocol extensions as shared behavior

```swift
protocol Prefetchable {
    var assetURLs: [URL] { get }
    func prefetch()
}

extension Prefetchable {
    func prefetch() {
        assetURLs.forEach { URLSession.shared.dataTask(with: $0).resume() }
    }
}
```

Use extensions for:

- Shared default behavior across many conformers
- Conditional helpers (`where` on extension)
- Keeping conformers thin

Do **not** use extensions as a place to hide requirements you actually need to customize polymorphically — declare those as requirements.

---

## 7. Conditional conformance (first pass)

```swift
struct Pair<A, B> {
    var a: A
    var b: B
}

extension Pair: Equatable where A: Equatable, B: Equatable {
    static func == (lhs: Pair<A, B>, rhs: Pair<A, B>) -> Bool {
        lhs.a == rhs.a && lhs.b == rhs.b
    }
}
```

Same idea as `Array: Equatable where Element: Equatable`. Model layers love this.

---

## 8. When inheritance is still OK

POP is not a religion.

| Still use class inheritance when | Example |
|---|---|
| UIKit requires a subclass | `UIView`, `UIViewController` |
| Shared identity + ObjC runtime | Delegates, responders |
| Framework base types you don’t control | `UICollectionViewCell` |

**Senior pattern:** Subclass UIKit for the *view*, put *capabilities* on protocols the cell/view model conforms to. HeroWidget can be a real view object with lifecycle *and* sit behind playback protocols.

---

## 9. Glossary (pin)

| Term | One-liner |
|---|---|
| POP | Design by composing protocol capabilities + extensions |
| PAT | Protocol with associated type(s) |
| Generic specialization | Compiler generates concrete code for used types |
| Witness table | Runtime dispatch table for protocol requirements |
| Existential | `any P` — value that can hold different conformers |
| Opaque type | `some P` — one hidden concrete type |
| Type erasure | Manual/API box turning PAT into a single usable type |
| Protocol composition | `A & B` — must satisfy both |
| Conditional conformance | Type conforms only when constraints hold |
| Class-bound | `AnyObject` — only classes; enables `weak` |

---

## 10. First production bridge (keep short)

At BookMyShow, the highest-revenue **Ads** module was refactored around **protocol-oriented** contracts and **generics** so rendering stayed type-safe as creatives grew. **HeroWidget** owned video pause/play against visibility / lifecycle — a reference-type lifecycle concern sitting on top of a POP pipeline.

**≤20s pitch:**  
> “We made ad rendering a generic protocol pipeline so new creatives plugged in without forking the revenue path — and HeroWidget tied video playback to visibility.”

> **Provenance:** Verified · S1 · BookMyShow · Ads POP + Generics / HeroWidget

Full STAR and anti-claims live in [`03-production-bridge.md`](03-production-bridge.md).

---

## 11. Self-check before deep dive

Without notes, can you:

- [ ] Explain POP in one sentence with a capability example?
- [ ] Contrast “caller picks T” vs “conformer picks associatedtype”?
- [ ] Say why `[AdRenderable]` is awkward when `AdRenderable` has associated types?
- [ ] Give one reason generics beat `Any` casts in an ads pipeline?
- [ ] Name when you’d still subclass `UIView`?

If yes → [`02-deep-dive.md`](02-deep-dive.md).  
If no → re-speak §§1–4 aloud once.
