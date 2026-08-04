# Day 01 — Value vs Reference, COW, Enums, Actors Intro

> Week 1 · Phase: Swift mastery · Time budget today: ~4–5 hrs

## 1. Outcome

By end of day you can explain aloud (no notes):

- When to choose `struct` vs `class` vs `actor` vs `enum`
- What copy-on-write means for Array/String/Dictionary and when a copy actually happens
- How recursive enums and associated values model domain state
- A 30s pitch tying value semantics to the BMS ads / listing models

## 2. Concept deep dive

### 2.1 Value vs reference

| Type | Semantics | Shared mutation? | Typical use |
|---|---|---|---|
| `struct` / `enum` | Value | No (independent copies) | Models, state, DTOs |
| `class` | Reference | Yes | Identity, shared services, UIKit objects |
| `actor` | Reference + isolation | Mutate only inside actor | Shared mutable state across concurrency |

**Senior rule:** Prefer value types for data. Introduce classes when you need identity, inheritance (rare), or Objective-C interop. Introduce actors when you need safe shared mutability across tasks.

### 2.2 Copy-on-write (COW)

Swift’s `Array`, `Dictionary`, `String`, `Set` use COW: assignment is cheap (share buffer); mutation of a uniquely referenced buffer happens in place; if `isKnownUniquelyReferenced` is false, the buffer is copied first.

**Trap:** Holding two variables to the “same” array and mutating one — the other may or may not see changes depending on uniqueness. Don’t rely on reference-like sharing for value collections.

### 2.3 Enums as state machines

Associated-value enums excel for UI/network/payment states:

```swift
enum LoadState<T> {
    case idle
    case loading
    case loaded(T)
    case failed(Error)
}
```

Payment popup at BMS maps cleanly: `processing` / `success` / `failure` / `timeout`.

### 2.4 Actors (intro only — Day 05 deepens)

An `actor` is a reference type that serializes access to its mutable state. Soft pitch today: “Where we used a serial queue around a dictionary at BMS, a Swift `actor` is the modern language-native equivalent for new code.”

### 2.5 Trade-offs

| Choice | When | Cost |
|---|---|---|
| Large struct with many copies | Small models, frequent pass-by-value | Copy cost if not COW / large stored properties |
| Class for everything | UIKit legacy | Shared mutation bugs, retain cycles |
| Actor for UI state | Rarely — prefer `@MainActor` ViewModel | Over-isolation complexity |

## 3. Read these

| Priority | Resource | Why |
|---|---|---|
| Must | [Classes and Structures](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/classesandstructures/) | Canonical value vs reference |
| Must | [Enumerations](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/enumerations/) | Associated values, recursive enums |
| Deepen | [Concurrency — Actors](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/concurrency/) (actors section) | Prep for Day 05 |
| Repo | [social-feed.md](../../../ios-system-design/docs/social-feed.md) — requirements/scope only today | Week 1 SD spine |

## 4. Map to your work

**Company / feature:** BookMyShow — Ads / listing models; Payment processing popup states  
**What you did:** Kept render models as value-friendly DTOs in a type-safe ads pipeline; modeled processing UI as explicit states rather than boolean flags.  
**Interview line (≤20s):** “I default to structs for ad and listing models so accidental shared mutation can’t corrupt revenue UI; classes/actors only at identity or concurrency boundaries.”

→ Full STAR: [story-bank S1](../../stories/story-bank.md#s1--ads-module-refactor--herowidget-bookmyshow), [S7](../../stories/story-bank.md#s7--payment-processing-time-popup-bookmyshow)

## 5. Normal questions

### Q1. Struct vs class? `(30–45s)`
**Skeleton:** Value vs reference → mutation sharing → prefer struct for data, class for identity.  
**Follow-up:** When is a class mandatory?  
**Story:** Ads models / HeroWidget ownership.

### Q2. What is COW? `(30–45s)`
**Skeleton:** Shared buffer until mutation; unique ref → in-place.  
**Follow-up:** Does assigning an array always copy elements?  
**Story:** Large listing arrays — avoid defensive copies in hot paths.

### Q3. Why prefer enums over booleans for UI state? `(30–45s)`
**Skeleton:** Impossible states; associated payloads; switch exhaustiveness.  
**Follow-up:** How do you version new cases for SDUI?  
**Story:** Payment processing popup.

### Q4. What is an actor at a high level? `(30–45s)`
**Skeleton:** Isolated reference type; await hops; prevents data races.  
**Follow-up:** Actor vs serial queue?  
**Story:** Bridge to synchronised dictionaries (S2).

### Q5. Value type containing a class — what happens on copy? `(45s)`
**Skeleton:** Struct copied; nested class reference shared.  
**Follow-up:** How do you deep-copy if needed?  
**Story:** Mixed model graphs in UIKit cells.

### Q6. `===` vs `==`? `(30s)`
**Skeleton:** Identity vs equality; classes; Equatable.  
**Follow-up:** Should view models use identity?  

### Q7. When would you use a class for a model? `(45s)`
**Skeleton:** Shared mutable cache entry with identity; ObjC; KVO legacy.  
**Follow-up:** Could an actor replace it?

### Q8. Recursive enums — why `indirect`? `(45s)`
**Skeleton:** Fixed size layout; indirection for recursive associated values.  
**Follow-up:** Example AST / nested comment thread.

### Q9. Are actors value or reference types? `(30s)`
**Skeleton:** Reference types with isolation.  

### Q10. How do you explain COW in one sentence to a junior? `(30s)`
**Skeleton:** “Cheap share until someone writes.”

## 6. Tricky questions

### T1. You mutate `arrayB` after `let arrayA = arrayB` — does A change? `(90s)`
**Trap:** Assuming always shared or always copied.  
**Senior answer:** Depends on uniqueness at mutation time; COW may copy first. Demonstrate mental model with `isKnownUniquelyReferenced`.  
**Follow-up:** What if both are class-wrapped?

### T2. Large struct passed through many functions — performance? `(90–120s)`
**Trap:** “Structs are always faster.”  
**Senior answer:** Small structs win; large stored properties may copy; use COW wrappers, `inout`, or class/actor at boundary.  
**Follow-up:** How Instruments Allocations would show this.

### T3. Enum with associated `Error` vs generic `Result` for ViewModel state `(90s)`
**Trap:** One true way.  
**Senior answer:** Domain enum communicates UI; `Result` is fine internally; map at boundary. Payment popup example.

### T4. Why not make every ViewModel an actor? `(90s)`
**Trap:** Actors solve all threading.  
**Senior answer:** UI needs `@MainActor`; overusing actors adds hop latency and API friction; isolate the shared mutable store, not every VM.

### T5. Class in a Set — what’s required? `(90s)`
**Trap:** Only Hashable on fields.  
**Senior answer:** `Hashable`/`Equatable` usually by identity (`ObjectIdentifier`) or stable ID; mutating hashed fields while in Set is undefined behavior.

## 7. Flashcards for today

| Front | Back |
|---|---|
| struct vs class | Value vs reference · Trap: class for all models · Prod: BMS ad DTOs as structs |
| COW | Share buffer until write · Trap: assume A sees B’s mutation · Prod: listing arrays |
| actor (1-liner) | Isolated reference type · Trap: use for all UI · Prod: modernize sync dicts |
| enum state machine | Exhaustive states · Trap: boolean flags · Prod: payment popup |
| `===` | Referential identity · Trap: use for structs · Prod: VC identity |
| indirect enum | Heap box for recursion · Trap: forget indirect · Prod: nested domain trees |
| Prefer values when | No identity needed · Trap: premature class · Prod: Clean models |
| Nested class in struct copy | Reference shared · Trap: think deep copy · Prod: mixed graphs |
| `@MainActor` vs actor | UI affinity vs general isolation · Trap: conflate · Prod: VM on main |
| LoadState\<T\> | idle/loading/loaded/failed · Trap: isLoading+optional · Prod: search MVVM |

## 8. Practice

- **Coding:** Implement `LoadState<T>` + map `Result` → `LoadState`. Write a tiny COW demo in a Playground (two array vars, mutate, print).
- **SD slice (20–30 min):** Read Social Feed **requirements/scope** only — write 5 clarifying questions you’d ask for BMS-scale listing (30L+ DAU).
- **Complexity / agenda:** For any “struct vs class” Q, say agenda in 5s: “semantics → mutation → example.”

## 9. Timed drill

1. Record Q1, Q2, Q3, T1, T2.
2. Score with [answer-timing-guide.md](../../timing/answer-timing-guide.md).
3. Practice S7 payment states in ≤90s Action segment.
4. Log gotchas.
