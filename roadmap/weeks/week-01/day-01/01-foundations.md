# 01 — Foundations: Value vs Reference, COW, Enums, Actors

> Read this first. Goal: build a crisp mental model an intern can teach back, then layer the senior edges you’ll need in interviews.

---

## 0. One-sentence north star

**Prefer value types for data; use reference types when you need identity or shared mutable lifetime; use actors when that shared mutability crosses concurrency.**

Everything below is unpacking that sentence.

---

## 1. Mental model: what “copy” and “share” mean

### 1.1 Two boxes in your head

Imagine every variable is a **name** taped to either:

| Box | Meaning | Swift examples |
|---|---|---|
| **Value box** | The name owns a *snapshot* of the data. Assigning to another name makes another snapshot (conceptually). | `struct`, `enum`, `tuple`, `Int`, `Bool` |
| **Reference box** | The name holds a *pointer* to one shared object on the heap. Two names can point at the same object. | `class`, `actor`, closures (by capture), many UIKit types |

```text
Value:     a ──► [payload A]     b ──► [payload B]   (independent)
Reference: a ──► [same object] ◄── b                 (shared)
```

### 1.2 The intern demo (do this once out loud)

```swift
struct Point { var x: Int; var y: Int }

var a = Point(x: 1, y: 2)
var b = a          // conceptual copy of the value
b.x = 99
print(a.x)         // 1 — a unchanged
print(b.x)         // 99
```

```swift
class Box { var value: Int; init(_ v: Int) { value = v } }

var c = Box(1)
var d = c          // both point to the same Box
d.value = 99
print(c.value)     // 99 — shared mutation
```

**Say aloud:** “Structs copy their data on assignment. Classes share identity; mutating through one name is visible through the other.”

### 1.3 `let` vs `var` is not value vs reference

| Binding | What it controls |
|---|---|
| `let` | The *name* cannot be reassigned |
| `var` | The *name* can be reassigned |

For a **struct**, `let p = Point(...)` also means you cannot mutate `p`’s properties (because mutation would reassign the whole value under the hood).

For a **class**, `let c = Box(1)` still allows `c.value = 2` — the name still points to the same object; the object’s contents change.

This trip-up shows up in interviews constantly. Separate **binding mutability** from **type semantics**.

---

## 2. Decision table: struct / class / enum / actor

| Need | Prefer | Why |
|---|---|---|
| Model / DTO / UI state snapshot | `struct` or `enum` | Independent copies; fewer shared-mutation bugs |
| Finite set of modes with payloads | `enum` (associated values) | Impossible combinations become compile errors |
| Identity (“this exact instance”) | `class` | `===`, shared lifetime, UIKit objects |
| Shared mutable state across tasks | `actor` | Isolation + await; data-race safety in the type system |
| ObjC / UIKit inheritance | `class` | Runtime reality of Cocoa |
| Inheritance tree for behavior | Prefer protocols + structs; `class` only if required | POP over deep hierarchies (see S1 ads pipeline) |

**Senior rule of thumb:** Start with `struct`/`enum`. Justify every `class`. Justify every `actor` with a concurrency boundary.

---

## 3. Value types in practice (structs)

### 3.1 Why teams love structs for models

```swift
struct AdCreative: Equatable {
    let id: String
    let title: String
    let clickURL: URL
}

func decorate(_ ad: AdCreative) -> AdCreative {
    // Returning a new value — caller keeps the old one unless they assign
    var copy = ad
    // mutate copy fields if they were `var`…
    return copy
}
```

If two screens hold an `AdCreative`, neither accidentally mutates the other’s copy. For revenue-critical listing/ad UI, that independence is a feature.

> **Provenance note:** At BookMyShow, ads work emphasized a **type-safe** pipeline (protocols + generics). Preferring value-friendly models fits that safety story — **Verified · S1**. You do **not** need to claim “every model was a struct.”

### 3.2 Structs can contain classes (shallow copy)

```swift
class ImageCache { var bytes: Data = Data() }

struct CellModel {
    var title: String
    var cache: ImageCache   // reference inside a value
}

var m1 = CellModel(title: "A", cache: ImageCache())
var m2 = m1
m2.title = "B"           // only m2’s title changes
m2.cache.bytes = Data([1]) // m1.cache sees it too — shared reference
```

**Intern takeaway:** Copying a struct copies its *stored properties*. Reference-typed properties stay shared.

**Senior takeaway:** “Value type” ≠ deep immutable graph. Audit nested classes when you reason about isolation.

---

## 4. Reference types in practice (classes)

### 4.1 When a class is the right tool

Use a class when you need **identity**:

- The same service instance shared across the app (`APIClient`, session managers)
- UIKit / AppKit objects (`UIViewController`, `UIView`)
- “Is this the same object?” checks with `===`
- Legacy KVO / ObjC runtime requirements

```swift
final class CheckoutSession {
    let id = UUID()
    var selectedSeats: [String] = []
}

let s1 = CheckoutSession()
let s2 = s1
print(s1 === s2)   // true — same identity
```

### 4.2 `==` vs `===`

| Operator | Meaning | Works on |
|---|---|---|
| `==` | Equality of *value* (you define via `Equatable`) | Any `Equatable` type |
| `===` | Same *object identity* | Class instances (reference types) |

Structs do not have `===`. Asking “are these the same struct instance?” is a category error — they are values, not identities.

---

## 5. Enums: not just “a list of cases”

### 5.1 Associated values = data that travels with the mode

```swift
enum LoadState<T> {
    case idle
    case loading
    case loaded(T)
    case failed(Error)
}
```

Compare to boolean soup:

```swift
// Fragile — illegal combinations are representable
var isLoading = false
var data: T? = nil
var error: Error? = nil
// isLoading && data != nil && error != nil  ← all possible
```

With the enum, `loading` cannot also hold `data`. The compiler’s `switch` exhaustiveness forces you to handle every mode.

### 5.2 Why this matters for UI

Payment / booking flows are state machines in disguise:

```swift
enum PaymentPopupState {
    case hidden
    case processing(message: String)
    case success(bookingID: String)
    case failure(message: String)
    case timedOut(message: String)
}
```

Each case owns the data the UI needs for that screen. No optional `bookingID` hanging around during `processing`.

> **Provenance:** The payment processing popup’s *intent* is Verified · **S7** (clear status during delays). Modeling it as this enum is **How I would apply it · S7-A1** — a design pattern for interviews, not a claim that production shipped Swift enums by name.

### 5.3 Recursive enums need `indirect`

Enums have a fixed size known at compile time. A case that contains *another value of the same enum* needs a heap box:

```swift
indirect enum CommentThread {
    case leaf(String)
    case node(String, replies: [CommentThread])
}
```

`indirect` tells Swift: store that associated value behind a reference so the layout stays finite.

---

## 6. Copy-on-write (COW) — intern version

### 6.1 The problem COW solves

If `Array` truly deep-copied every element on every assignment, large lists would be expensive. If it shared buffers like a class *without* care, mutations would leak across variables (surprising for a “value type”).

**COW = share storage until someone writes; then copy if needed.**

### 6.2 The three steps

1. **Assign:** `var b = a` — both may share one buffer. Cheap (pointer + refcount).
2. **Read:** either variable can read freely. Still shared.
3. **Mutate:** before writing, Swift checks “am I the only owner?”
   - Yes → mutate in place
   - No → copy buffer, then mutate the unique copy

```swift
var a = [1, 2, 3]
var b = a          // share
b.append(4)        // b unique after copy; a still [1,2,3]
print(a)           // [1, 2, 3]
print(b)           // [1, 2, 3, 4]
```

Collections with COW in the standard library (know these names): **`Array`**, **`Dictionary`**, **`Set`**, **`String`**.

### 6.3 One-sentence junior explanation

> “Arrays act like values, but under the hood they cheaply share memory until someone changes something — then they copy.”

---

## 7. Actors — intro only (Day 05 goes deep)

### 7.1 What problem actors solve

Reference types + concurrency = data races if two tasks mutate the same object without synchronization.

An **`actor`** is a reference type whose mutable state is **isolated**. You talk to it with `await`; the runtime serializes access.

```swift
actor Counter {
    private var value = 0
    func increment() { value += 1 }
    func get() -> Int { value }
}

let counter = Counter()
await counter.increment()
print(await counter.get())
```

### 7.2 Soft bridge from production

At BookMyShow, shared mutable maps were protected with **GCD serial queues** (Verified · **S2**). Soft interview line:

> “Where we serialized dictionary access with a serial queue, a Swift `actor` is the language-native equivalent I’d evaluate for new code.”

That extension is **How I would apply it · S2-A1** — do not claim you rewrote production dictionaries as actors unless you did.

### 7.3 What *not* to say today

- “Actors replace all classes”
- “Every ViewModel should be an actor”
- Deep hop / reentrancy theory — save for Day 05

Enough for Day 01: **isolated reference type; await to touch state; prevents data races.**

---

## 8. Glossary (pin)

| Term | Meaning |
|---|---|
| Value semantics | Independent copies; mutation does not surprise other names |
| Reference semantics | Shared identity; mutation is visible through all references |
| COW | Deferred copy until mutation of a non-unique buffer |
| Associated value | Payload stored in an enum case |
| Exhaustiveness | `switch` must cover all cases (or `default`) |
| `indirect` | Heap indirection for recursive enum layout |
| Isolation | Actor state only accessible in the actor’s executor context |
| `===` | Object identity |
| `@MainActor` | Isolation domain for main-thread / UI work (related, not identical to a custom actor) |

---

## 9. Teach-back checklist

Explain each in ≤20s without notes:

1. Struct assignment vs class assignment  
2. Why `let` on a class still allows property mutation  
3. Why enums beat boolean flags for UI state  
4. COW one-liner  
5. Actor one-liner + serial-queue bridge  

If any fail, re-read that section, then continue to [`02-deep-dive.md`](02-deep-dive.md).

---

## 10. Mini examples to type once

### Struct vs class mutation

```swift
struct Ticket { var seat: String }
class Hold { var seat: String; init(_ s: String) { seat = s } }

var t1 = Ticket(seat: "A1")
var t2 = t1
t2.seat = "B2"
// t1.seat == "A1"

let h1 = Hold("A1")
let h2 = h1
h2.seat = "B2"
// h1.seat == "B2"
```

### Enum switch exhaustiveness

```swift
func title(for state: LoadState<String>) -> String {
    switch state {
    case .idle: return "Start"
    case .loading: return "Loading…"
    case .loaded(let value): return value
    case .failed: return "Something went wrong"
    }
}
```

Adding a new case forces every switch to update — that pressure is the feature.

---

## Next

Go to [`02-deep-dive.md`](02-deep-dive.md) for COW uniqueness checks, large-struct costs, nested reference traps, payment state machines, and actor vs `@MainActor` boundaries.
