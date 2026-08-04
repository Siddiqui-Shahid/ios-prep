# 02 — Deep Dive: Mechanics, Traps, Trade-offs

> Senior depth. Assumes [`01-foundations.md`](01-foundations.md). Still self-contained — no external reading required.

---

## 1. Value semantics under pressure

### 1.1 What the compiler actually does (mental model)

For small structs stored in registers / stack, assignment often *is* a bitwise copy of stored properties. For larger values, Swift may still copy stored properties eagerly — **unless** the type implements COW internally (std collections do).

Your own `struct Huge` with ten large non-COW properties pays copy cost on each assignment / pass-by-value.

```swift
struct ListingRow {
    var id: String
    var title: String
    var subtitle: String
    var imageURL: URL?
    var badge: String?
    // …many fields
}

func decorate(_ row: ListingRow) -> ListingRow {
    var copy = row   // copies stored properties
    copy.badge = "Ad"
    return copy
}
```

**Interview nuance:** “Structs are always cheaper than classes” is false. Structs win on *semantics* and often on small data; large graphs may want COW wrappers, `inout`, or a reference boundary.

### 1.2 `inout` and exclusivity

```swift
func bumpX(_ p: inout Point) {
    p.x += 1
}

var point = Point(x: 0, y: 0)
bumpX(&point)   // mutate in place — no conceptual “return a copy”
```

Swift’s exclusivity rules prevent overlapping access to the same value. That’s part of why value semantics stay predictable.

### 1.3 Mutation through `mutating` methods

```swift
struct Counter {
    private(set) var value = 0
    mutating func increment() { value += 1 }
}

var c = Counter()
c.increment()

let frozen = Counter()
// frozen.increment()  // compile error — mutating on let binding
```

A `mutating` method is allowed to replace `self`. That only works on `var` bindings.

---

## 2. Copy-on-write — senior mechanics

### 2.1 Uniqueness

Stdlib collections store a reference to a buffer object. Before mutating, they ask roughly: “is this buffer uniquely referenced?”

Swift exposes a related primitive for **your** COW types:

```swift
final class Storage {
    var items: [Int]
    init(_ items: [Int]) { self.items = items }
}

struct COWList {
    private var storage: Storage

    init(_ items: [Int]) {
        storage = Storage(items)
    }

    private mutating func ensureUnique() {
        if !isKnownUniquelyReferenced(&storage) {
            storage = Storage(storage.items) // copy buffer
        }
    }

    mutating func append(_ value: Int) {
        ensureUnique()
        storage.items.append(value)
    }

    var items: [Int] { storage.items }
}
```

**Teaching point:** `isKnownUniquelyReferenced` only works with **class** instances. COW is “value type façade over a reference-counted buffer.”

### 2.2 When does A change after mutating B?

```swift
var a = [1, 2, 3]
var b = a
b.append(4)
// a is still [1,2,3] — COW copied for b
```

Trap answer: “Always shared” or “Always copied on assign.”  
Correct: **shared until a write forces uniqueness.**

Edge case people forget:

```swift
var a = [1, 2, 3]
var b = a
a.append(4)   // a may copy; b keeps old buffer
```

Same rule — whoever mutates while sharing pays for the copy (if not unique).

### 2.3 Wrapping arrays in a class kills COW *across* that wrapper

```swift
final class ArrayBox {
    var values: [Int]
    init(_ values: [Int]) { self.values = values }
}

let box1 = ArrayBox([1, 2])
let box2 = box1
box2.values.append(3)
// box1.values also [1,2,3] — the *box* is shared
```

The inner `Array` still has COW *relative to other Array values*, but two names pointing at one `ArrayBox` share the same array *property storage path*. Interviewers use this to test whether you confuse collection COW with object identity.

### 2.4 Performance interview answer (90s shape)

1. **Claim:** COW makes value-typed collections cheap to pass until mutation.  
2. **Mechanism:** shared buffer + uniqueness check on write.  
3. **Trade-off:** unexpected copies if you mutate while aliases exist; profiling matters for huge buffers.  
4. **Prod:** listing/search arrays — avoid defensive deep copies in hot paths; let COW work; don’t wrap in classes “for safety” without thinking.

---

## 3. Nested references and “fake” value types

### 3.1 Struct + class property

Already covered in foundations — deepen the failure mode:

```swift
struct UserSession {
    var token: String
    var profiler: Profiler   // class
}

final class Profiler {
    var events: [String] = []
    func log(_ e: String) { events.append(e) }
}
```

Copying `UserSession` duplicates `token` but shares `profiler`. Two “sessions” pollute one event log. Fixes:

- Make `Profiler` a struct with COW / value semantics  
- Deep-copy explicitly when needed  
- Don’t put shared services inside DTOs — inject them at the boundary

### 3.2 Closures capture references

```swift
final class Loader {
    var label = "x"
    func makePrinter() -> () -> Void {
        { print(self.label) }  // captures self strongly by default
    }
}
```

Closures are reference-ish for captures. Pair with ARC / retain-cycle day — but for *this* day, know that “I used a struct” does not eliminate shared mutable state if you capture classes.

---

## 4. Enums as state machines (production-grade)

### 4.1 Impossible states are bugs you don’t ship

Boolean flags explode combinatorially:

| isLoading | hasData | hasError | Meaning? |
|---|---|---|---|
| T | F | F | loading |
| F | T | F | success |
| F | F | T | failure |
| T | T | T | ??? |

An enum with four cases encodes only the legal rows.

### 4.2 Mapping network `Result` → UI state

Keep `Result` at the networking edge; map to a UI-facing enum:

```swift
enum LoadState<T> {
    case idle
    case loading
    case loaded(T)
    case failed(Error)
}

extension LoadState {
    static func from(_ result: Result<T, Error>) -> LoadState {
        switch result {
        case .success(let value): return .loaded(value)
        case .failure(let error): return .failed(error)
        }
    }
}
```

**Why not use `Result` alone in the ViewModel?**  
`Result` has no `idle` / `loading`. UI needs those modes. Domain enums communicate screen semantics; `Result` communicates one-shot outcomes.

### 4.3 Payment popup machine (Applied · S7-A1)

```swift
enum PaymentPopupState: Equatable {
    case hidden
    case processing(message: String)
    case success(bookingID: String)
    case failure(code: String, message: String)
    case timedOut(message: String)

    mutating func apply(_ event: PaymentEvent) {
        switch (self, event) {
        case (.hidden, .userStartedCheckout):
            self = .processing(message: "Confirming payment…")
        case (.processing, .backendSuccess(let id)):
            self = .success(bookingID: id)
        case (.processing, .backendFailure(let code, let message)):
            self = .failure(code: code, message: message)
        case (.processing, .timeout):
            self = .timedOut(message: "Still working — check your bookings.")
        case (.success, .dismiss), (.failure, .dismiss), (.timedOut, .dismiss):
            self = .hidden
        default:
            break // ignore illegal transitions; or assert in DEBUG
        }
    }
}

enum PaymentEvent {
    case userStartedCheckout
    case backendSuccess(bookingID: String)
    case backendFailure(code: String, message: String)
    case timeout
    case dismiss
}
```

**Interview framing:**

- Verified · **S7**: designed a processing-time popup so delays weren’t silent (intent: less drop-off / support friction — **no invented %**).  
- Applied · **S7-A1**: I’d model transitions as an enum state machine so illegal UI modes can’t exist.

### 4.4 Versioning new cases (SDUI / backend-driven adjacent)

When backend can add modes:

```swift
enum HeaderComponent {
    case banner(BannerPayload)
    case spacer(height: CGFloat)
    case unknown(type: String, raw: [String: String])
}
```

Unknown cases keep the app resilient. Tie to S3 search/header themes later; today just know: **enums + fallback beats crashing on new raw values**.

### 4.5 Recursive / nested domain trees

```swift
indirect enum FeedNode {
    case ad(AdCreative)
    case event(EventSummary)
    case section(title: String, children: [FeedNode])
}
```

Useful for nested listings / comment threads. Mention `indirect` when asked about recursive enums.

---

## 5. Classes: identity, sets, and mutation hazards

### 5.1 Hashing classes

If you put class instances in a `Set` / `Dictionary` key:

- Prefer stable ID-based `Hashable` **or** identity via `ObjectIdentifier`
- **Never** mutate fields that participate in `hash(into:)` while the object is in the collection — undefined behavior / lost entries

```swift
final class Seat: Hashable {
    let id: String
    var isSelected: Bool
    static func == (l: Seat, r: Seat) -> Bool { l.id == r.id }
    func hash(into hasher: inout Hasher) { hasher.combine(id) }
    init(id: String) { self.id = id; isSelected = false }
}
```

### 5.2 When a model *should* be a class

Rare but real:

- Shared mutable cache entry with intentional identity  
- ObjC interop / UIKit subclass  
- “One session object” everyone must see updates on  

Otherwise prefer values + a single owner (ViewModel / store).

---

## 6. Actors intro — boundaries you’ll be asked about

### 6.1 Actor vs class

| | Class | Actor |
|---|---|---|
| Semantics | Reference | Reference + isolation |
| Cross-task mutation | You synchronize | Compiler / runtime enforce |
| Call site | Direct | Often `await` |
| Inheritance | Possible | Limited (actors don’t freely inherit like classes) |

### 6.2 Actor vs serial queue (S2 bridge)

| Approach | Pros | Cons |
|---|---|---|
| GCD serial queue around a dictionary | Works on older OS; familiar | Easy to misuse `sync` (deadlock); no compile-time isolation |
| Swift `actor` | Type-system isolation; clearer API | Requires concurrency adoption; hop latency; learning curve |

Soft pitch (Verified · S2 + Applied · S2-A1):

> “We fixed races by serializing access with a GCD queue. For greenfield code I’d expose the same API behind an `actor` so isolation is checked by the compiler.”

### 6.3 Why not every ViewModel is an actor

UI must update on the main actor. Common pattern:

```swift
@MainActor
final class SearchViewModel: ObservableObject {
    @Published private(set) var state: LoadState<[String]> = .idle
}
```

`@MainActor` is an isolation *domain* for UI affinity. A custom `actor` for every VM adds await noise at every bind site. Isolate the **shared mutable store** (caches, in-flight maps), keep UI models on `@MainActor`.

### 6.4 Actor reentrancy (awareness only)

While an actor `await`s, other work may run on that actor before your method continues. Don’t assume “I set flag X, awaited, flag X still means what I think” without care. Deep dive = Day 05.

---

## 7. Trade-off tables (memorize shape)

### 7.1 Type choice

| Choice | When | Cost |
|---|---|---|
| Small struct / enum | Models, state, DTOs | Negligible copy |
| Large struct, many copies | Hot paths with fat values | Copy churn — measure; consider COW / `inout` / reference boundary |
| Class for models | True shared identity | Shared mutation bugs, retain cycles |
| Actor for shared maps | Concurrent mutation | Await hops; API friction |
| `@MainActor` VM | UI state | Don’t block main with heavy work |

### 7.2 State modeling

| Choice | When | Cost |
|---|---|---|
| Boolean flags | Prototypes only | Impossible states |
| `Result` only | One-shot async outcome | No idle/loading |
| Domain `LoadState` | Screens | Slightly more mapping code |
| Event + enum reduce | Complex flows (payments) | Need discipline on transitions |

---

## 8. Failure modes checklist

| Failure | Symptom | Fix mindset |
|---|---|---|
| Class used for DTO | Flaky UI after “copy” | Prefer struct |
| Nested class in struct | Surprising shared side effects | Audit graph |
| Assume array assign deep-copies | Unexpected perf *or* wrong sharing mental model | Teach COW |
| Boolean UI state | Impossible screens / crashy force unwraps | Enum machine |
| Actor on every type | Contorted call sites | Isolate the real shared mutable core |
| Mutating hashed fields in Set | Lost objects / weird lookups | Hash stable identity only |

---

## 9. Spoken “agenda → answer” templates

### Struct vs class (45s)

> Agenda: semantics → mutation → example.  
> Structs have value semantics — copies are independent. Classes share identity — mutation is visible everywhere. I default to structs for ad/listing models; classes for UIKit and true shared services.

### COW (45s)

> Agenda: share → uniqueness → mutate.  
> Assignment of Array is cheap because buffers are shared. On mutation, if the buffer isn’t uniquely referenced, Swift copies first. So value semantics stay intact without paying full copy on every assign.

### Enum state (45s)

> Agenda: impossible states → exhaustiveness → payload.  
> Booleans allow illegal combinations. An associated-value enum makes each mode carry only the data it needs, and switches stay exhaustive. That’s how I’d model payment processing UI.

### Actor intro (45s)

> Agenda: race → isolation → bridge.  
> An actor is a reference type that serializes access to its state. Call sites await. It’s the modern equivalent of the serial-queue boundary we used around shared dictionaries.

---

## 10. Diagram: decision flow

```text
Do you need identity or ObjC/UIKit inheritance?
  │
  ├─ yes → class (or @MainActor class for UI)
  │         │
  │         └─ shared mutable across tasks?
  │               ├─ yes → actor (or isolate behind actor)
  │               └─ no  → plain class / main-actor type
  │
  └─ no → is it a finite mode + payload?
            ├─ yes → enum
            └─ no  → struct
                      │
                      └─ large / shared buffer needs?
                            └─ rely on std COW or implement COW
```

---

## 11. Connect to code in this chapter

| File | What to notice |
|---|---|
| [`code/LoadState.swift`](code/LoadState.swift) | Generic UI state + `Result` mapping + payment enum sketch |
| [`code/COWDemo.swift`](code/COWDemo.swift) | Array sharing vs mutation; handmade COW list |

Read both before questions.

---

## Next

[`03-production-bridge.md`](03-production-bridge.md) — turn S1 / S7 / S2 into tight interview lines without inventing metrics.
