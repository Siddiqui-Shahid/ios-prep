# 01 — Foundations: POP, Generics, Associated Types

> Start here. By the end of this file you should be able to teach the big ideas back in plain English. Keep the code examples — but focus on what each idea *does*.

---

## 0. Main guiding idea

**Build features by combining small capabilities (protocols + generics), not by growing a tall inheritance tree — especially on UI that makes money.**

We will use BookMyShow Ads and HeroWidget as the real-world hook (Verified · S1). You do not need fancy metrics. The claim is: the pipeline stayed type-safe and new ad types could plug in without rewriting the revenue path.

---

## 1. Why POP exists

### 1.1 The inheritance trap

Many UIKit tutorials start with a class tree like this:

```text
UIView
  └── AdView
        ├── ImageAdView
        ├── VideoAdView
        └── CarouselAdView
              └── SponsoredCarouselAdView
```

That looks neat at first. At scale it hurts.

- A shared base class gets fat. Everyone piles “just one more” method into `configure`.
- Everything becomes a class, even when the data itself could be a simple value.
- Tests become painful. You must subclass or mock a deep tree.
- A new creative type means forking the hierarchy or fighting it.
- Swift classes only get one parent. Real ads often need several “I can do X” abilities at once.

Remember this line:

> Inheritance describes *what you are*. Protocols describe *what you can do*.

### 1.2 Think in capabilities

An ad unit is not one giant “ad class”. It is a bag of abilities:

- **Render** into a view → protocol sketch: `AdRenderable` (listing / hero surface cares)
- **Track** impressions and clicks → `AdTrackable` (analytics / revenue cares)
- **Control video** pause and play → `PlaybackControllable` (HeroWidget cares)
- **Prefetch** assets → `Prefetchable` (scroll performance cares)

A video hero ad might need all of: render + track + playback.  
An image tile might only need render + track.

Putting those abilities together is **protocol-oriented programming (POP)**.

### 1.3 Tiny demo

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

What this shows: different types, same ability. No shared base class required.

When a protocol gains an **associated type** (a placeholder type filled in by each adopter), things get harder. That is §4 and the deep dive. Keep this simple demo in your head for the first ten minutes.

---

## 2. Protocols as contracts

### 2.1 Requirements vs extension defaults

```swift
protocol AdTrackable {
    var creativeID: String { get }
    func trackImpression()
    func trackClick()
}

extension AdTrackable {
    // Handy default — but see the dispatch trap in the deep dive
    func trackClick() {
        print("default click \(creativeID)")
    }
}
```

Two pieces, two jobs:

- Methods listed **inside the protocol body** are requirements. They are part of the contract. Call sites usually dispatch them through a witness table (runtime lookup for that protocol).
- Methods added **only in an extension** are convenience. They may *not* override the way you expect when the variable is typed as the protocol.

Simple rule: if a creative must customize a method, put that method in the protocol body as a requirement.  
Senior rule: extension-only defaults can surprise you. The deep dive shows the classic interview trap.

### 2.2 Protocol composition

```swift
typealias HeroAd = AdRenderable & AdTrackable & PlaybackControllable

func installHero<A: HeroAd>(_ ad: A) {
    // Compiler knows A has all three capability sets
}
```

The `&` means “and”. You are saying: this value must satisfy several contracts at once. That is not multiple inheritance. It is multiple capabilities.

### 2.3 Class-bound protocols (`AnyObject`)

```swift
protocol AdDelegate: AnyObject {
    func adDidFail(_ error: Error)
}

final class AdLoader {
    weak var delegate: AdDelegate?
}
```

Use `: AnyObject` when you need a **weak** delegate or class identity.  
Prefer value types (structs) for models when you can.  
UIKit subclasses are fine for views — still put *capabilities* on protocols.

---

## 3. Generics — the caller chooses the type

### 3.1 Mental model

A **generic parameter** is a blank that the **caller** fills in:

```swift
struct Renderer<Creative> {
    let creative: Creative
}

let imageRenderer = Renderer(creative: ImageCreative(title: "Show"))
let videoRenderer = Renderer(creative: VideoCreative(title: "Trailer", duration: 15))
```

Add a constraint when you need to *use* methods on that type:

```swift
struct Renderer<Creative: AdTrackable> {
    let creative: Creative

    func bind() {
        creative.trackImpression()
    }
}
```

### 3.2 Why generics beat `Any` on a revenue path

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

Cast ladders hide bugs until a new creative ships on a Friday night. Generics push mismatches to compile time.

> **Provenance:** Verified · S1 · BookMyShow · POP + Generics for a type-safe ads pipeline.  
> You may say the pipeline was type-safe. You may **not** invent fill-rate percentages.

### 3.3 `where` clauses (first pass)

```swift
func merge<C>(
    _ a: C,
    _ b: C
) -> C where C: AdTrackable & Equatable {
    return a == b ? a : b
}
```

`where` keeps the signature readable when constraints grow. You will use this a lot with associated types in the deep dive.

---

## 4. Associated types — the adopter chooses the type

### 4.1 Mental model

An **associated type** is a blank that the **type adopting the protocol** fills in:

```swift
protocol AdRenderable {
    associatedtype ContentView: UIView
    func makeView() -> ContentView
}

struct ImageAd: AdRenderable {
    // This adopter picks ContentView = UIImageView
    func makeView() -> UIImageView { UIImageView() }
}

struct VideoAd: AdRenderable {
    func makeView() -> UIView { PlayerContainerView() }
}
```

Compare the two blanks:

| Idea | Who fills in the concrete type? |
|---|---|
| `func f<T: P>(_ x: T)` | The **caller** (generic parameter) |
| `associatedtype` inside protocol `P` | The **adopter** |

Remember:

> Generics: I tell the function what `T` is.  
> Associated types: the type that adopts the protocol decides.

### 4.2 Why this feels hard

Once `AdRenderable` has an associated type, this often fails or is heavily limited:

```swift
let ads: [AdRenderable] = ...  // ❌ often illegal / constrained
```

Why? Image ads and video ads may return different view types. The language cannot put “many different shapes” into one simple array without help.

Three strategies you will learn today:

1. Keep the pipeline **generic**: `func install<R: AdRenderable>(_ r: R)`
2. **Type-erase** into one common box when you truly need a mixed list
3. Use constrained `any AdRenderable` only when the language allows the operations you need — and know the limits

(Do not lean on the shortform “PAT” in speech. Say “protocol with associated type”.)

### 4.3 Both ideas together

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

`Pipeline` is generic. The creative itself also has an associated `Body`. That “outer generic + inner associated type” shape is the POP + generics pattern used in component pipelines.

---

## 5. `some` vs `any` (first cut)

| Keyword | Meaning | Plain line |
|---|---|---|
| `some P` | Opaque type — one real concrete type, hidden from the caller | “There is a real type; you just cannot name it.” |
| `any P` | Existential — a box that can hold different adopters (with limits) | “Different types can sit behind this curtain.” |

```swift
func makeBadge() -> some Describable {
    ImageCreative(title: "Badge")  // always ImageCreative
}

func makeItems() -> [any Describable] {
    [ImageCreative(title: "A"), VideoCreative(title: "B", duration: 10)]
}
```

Performance intuition for today:

- Generics and `some` → the compiler can specialize (more static)
- `any` → witness table / existential container (more dynamic)

The deep dive goes further when associated types are involved.

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

Use extensions for shared default behavior, conditional helpers, and thin adopters.  
Do **not** hide methods you need to customize polymorphically inside extensions only. Declare those as requirements.

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

Same idea as `Array: Equatable where Element: Equatable`. Model layers love this: the pair is equatable only when both pieces are.

---

## 8. When inheritance is still OK

POP is a tool, not a religion.

Still subclass when UIKit requires it (`UIView`, `UIViewController`), when you need shared identity / ObjC runtime (delegates, responders), or when the framework owns the base type (`UICollectionViewCell`).

Senior pattern: subclass UIKit for the **view**, put **capabilities** on protocols. HeroWidget can be a real view with lifecycle *and* sit behind a playback protocol.

---

## 9. Glossary (pin)

| Term | One plain sentence |
|---|---|
| POP | Design by composing protocol capabilities and extensions |
| Protocol with associated type | A protocol that names a placeholder type; each adopter fills it in |
| Generic specialization | Compiler builds concrete code for the types you actually use |
| Witness table | Runtime dispatch table for protocol requirements |
| Existential | `any P` — a value that can hold different adopters |
| Opaque type | `some P` — one hidden concrete type |
| Type erasure | A box that turns a hard protocol shape into one usable type |
| Protocol composition | `A & B` — must satisfy both |
| Conditional conformance | A type adopts a protocol only when constraints hold |
| Class-bound | `: AnyObject` — classes only; enables `weak` |

---

## 10. First production bridge (short)

At BookMyShow, the highest-revenue Ads module was refactored around protocol contracts and generics so rendering stayed type-safe as creatives grew. HeroWidget owned video pause/play against visibility and lifecycle — a reference-type concern sitting on top of a POP pipeline.

**≤20s pitch:**

> “We made ad rendering a generic protocol pipeline so new creatives plugged in without forking the revenue path — and HeroWidget tied video playback to visibility.”

> **Provenance:** Verified · S1 · BookMyShow · Ads POP + Generics / HeroWidget

Full STAR and anti-claims: [`03-production-bridge.md`](03-production-bridge.md).

---

## 11. Self-check before deep dive

Without notes, can you:

- [ ] Explain POP in one sentence with a capability example?
- [ ] Contrast “caller picks T” vs “adopter picks associated type”?
- [ ] Say why `[AdRenderable]` is awkward when `AdRenderable` has associated types?
- [ ] Give one reason generics beat `Any` casts in an ads pipeline?
- [ ] Name when you’d still subclass `UIView`?

If yes → [`02-deep-dive.md`](02-deep-dive.md).  
If no → re-speak §§1–4 once out loud.
