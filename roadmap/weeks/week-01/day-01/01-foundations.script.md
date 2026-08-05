# Audio script — 01 Foundations
> Listen-only audiobook of `01-foundations.md` (Day 01 — Value vs Reference, COW, Enums, Actors Intro). Simple English. Basic explanations. Self-contained speech. Does not assume you are looking at a screen.


## §0 Introduction

Next. Introduction.

Read this first. Goal: build a clear mental model an intern can teach back. then layer the senior edges you’ll need in interviews.

## §1 0. One-sentence north star

Next. 0. One-sentence main guiding idea. That means the main guiding idea.

Prefer value types for data. use reference types when you need identity or shared mutable lifetime. use actors when that shared mutability crosses concurrency. Everything below is unpacking that sentence.

## §2 1. Mental model: what “copy” and “share” mean

Next. 1. Mental model: what “copy” and “share” mean.

1.1 Two boxes in your head Imagine every variable is a name taped to either: Box: Meaning. Swift examples. Value box: The name owns a snapshot of the data. Assigning to another name makes another snapshot (conceptually)., struct, enum, tuple, Int, Bool. Reference box: The name holds a pointer to one shared object on the heap. Two names can point at the same object., class, actor, closures (by capture), many U I kit types. Here is a simple code example, explained in words. Value: a [payload A] b [payload B] (independent). Reference: a [same object] b (shared). What to remember: focus on the idea, not every symbol. 1.2 The simple example (remember this example) Here is a simple Swift example, explained in words. struct Point var x: Int var y: Int. var a equals Point(x: 1, y: 2). var b equals a // conceptual copy of the value. b.x equals 99. print(a.x) // 1. a unchanged. print(b.x) // 99. What to remember: focus on the idea, not every symbol. Here is a simple example with a class. A class is a reference type. That means names can share one object. Create object C. Assign D equals C. Change D. C also changes. Why this matters: shared objects can surprise you. What to remember: classes share. Remember: “Structs copy their data on assignment. Classes share identity. mutating through one name is visible through the other.” 1.3 let vs var is not value vs reference. Binding: What it controls. let: The name cannot be reassigned. var: The name can be reassigned. For a struct, let p = Point(...) also means you cannot mutate p’s properties (because mutation would reassign. the whole value under the hood). For a class, let c = Box(1) still allows c.value = 2. the name still points to the same object. the object’s contents change. This common mistakes shows up in interviews constantly. Separate binding mutability from type semantics.

## §3 2. Decision table: struct / class / enum / actor

Next. 2. Decision table: struct / class / enum / actor.

Need: Prefer, Why. Model / data transfer object / U I state snapshot: struct or enum, Independent copies. fewer shared-mutation bugs. Finite set of modes with payloads: enum (associated values), Impossible combinations become compile errors. Identity (“this exact instance”): class, ===, shared lifetime, U I kit objects. Shared mutable state across tasks: actor, Isolation + await. data-race safety in the type system. ObjC / U I kit inheritance: class, Runtime reality of Cocoa. Inheritance tree for behavior: Prefer protocols + structs. class only if required, P O P over deep hierarchies (see S1 ads pipeline). Senior rule of thumb: Start with struct/enum. Justify every class. Justify every actor with a concurrency boundary.

## §4 3. Value types in practice (structs)

Next. 3. Value types in practice (structs).

3.1 Why teams love structs for models Here is a simple Swift example, explained in words. struct AdCreative: Equatable. let id: String. let title: String. let clickURL: U R L. func decorate(_ ad: AdCreative) - AdCreative. What to remember: focus on the idea, not every symbol. If two screens hold an AdCreative, neither accidentally mutates the other’s copy. For revenue-critical listing/ad U I, that independence is a feature. Provenance note: At BookMyShow, ads work emphasized a type-safe pipeline (protocols + generics). Preferring value-friendly models fits that safety story. Verified · S1. You do not need to claim “every model was a struct.” 3.2 Structs can contain classes (shallow copy). Here is a simple Swift example, explained in words. class ImageCache var bytes: Data equals Data(). struct CellModel. var title: String. var cache: ImageCache // reference inside a value. var m1 equals CellModel(title: "A", cache: ImageCache()). What to remember: focus on the idea, not every symbol. Intern takeaway: Copying a struct copies its stored properties. Reference-typed properties stay shared. Senior takeaway: “Value type” ≠ deep immutable graph. Audit nested classes when you reason about isolation.

## §5 4. Reference types in practice (classes)

Next. 4. Reference types in practice (classes).

4.1 When a class is the right tool Use a class when you need identity: The same service. instance shared across the app (APIClient, session managers) U I kit / App kit objects (UIViewController. UIView) “Is this the same object?” checks with === Legacy KVO / ObjC runtime requirements Here is a. simple Swift example, explained in words. final class CheckoutSession. let id equals unique id(). var selectedSeats: [String] equals []. let s1 equals CheckoutSession(). let s2 equals s1. What to remember: focus on the idea, not every symbol. 4.2 == vs === Operator: Meaning, Works on. ==: Equality of value (you define via Equatable), Any Equatable type. ===: Same object identity, Class instances (reference types). Structs do not have ===. Asking “are these the same struct instance?” is a category error. they are values, not identities.

## §6 5. Enums: not just “a list of cases”

Next. 5. Enums: not just “a list of cases”.

5.1 Associated values = data that travels with the mode Here is a simple example with an enum. An enum is a fixed set of modes. Each case is one mode. Some cases can carry extra data. A switch must handle every case. Why this matters: enums make illegal states hard. What to remember: model states with enums. Compare to boolean soup: Here is a simple Swift example, explained in words. // Fragile. illegal combinations are representable. var isLoading equals false. var data: T? equals nil. var error: Error? equals nil. // isLoading && data ! equals nil && error ! equals nil ← all possible. What to remember: focus on the idea, not every symbol. With the enum, loading cannot also hold data. The compiler’s switch exhaustiveness forces you to handle every mode. 5.2 Why this matters for U I Payment / booking flows are state machines in disguise: Here is. a simple example with an enum. An enum is a fixed set of modes. Each case is one mode. Some cases can carry extra data. A switch must handle every case. Why this matters: enums make illegal states hard. What to remember: model states with enums. Each case owns the data the U I needs for that screen. No optional bookingID hanging around during processing. Provenance: The payment processing popup’s intent is Verified · S7 (clear status during delays). Modeling it as this enum is How I would apply it · S7-A1. a design pattern for interviews, not a claim that production shipped Swift enums by name. 5.3 Recursive enums need indirect Enums have a fixed size known at compile time. A case that contains another value of the same enum needs a heap box: Here is a simple. example with an enum. An enum is a fixed set of modes. Each case is one mode. Some cases can carry extra data. A switch must handle every case. Why this matters: enums make illegal states hard. What to remember: model states with enums. indirect tells Swift: store that associated value behind a reference so the layout stays finite.

## §7 6. Copy-on-write (COW) — intern version

Next. 6. Copy-on-write (copy on write) — intern version.

6.1 The problem copy on write solves If Array truly deep-copied every element on every assignment. large lists would be expensive. If it shared buffers like a class without care, mutations would leak across variables (surprising for a “value. type”). copy on write = share storage until someone writes. then copy if needed. 6.2 The three steps Assign: var b = a. both may share one buffer. Cheap (pointer + refcount). Read: either variable can read freely. Still shared. Mutate: before writing, Swift checks “am I the only owner?” Yes. mutate in place No. copy buffer, then mutate the unique copy Here is a simple Swift example, explained in words. var a equals [1, 2, 3]. var b equals a // share. b.append(4) // b unique after copy a still [1,2,3]. print(a) // [1, 2, 3]. print(b) // [1, 2, 3, 4]. What to remember: focus on the idea, not every symbol. Collections with copy on write in the standard library (know these names): Array, Dictionary, Set, String. 6.3 One-sentence junior explanation “Arrays act like values, but under the hood they cheaply share memory until someone. changes something. then they copy.”.

## §8 7. Actors — intro only (Day 05 goes deep)

Next. 7. Actors — intro only (Day 05 goes deep).

7.1 What problem actors solve Reference types + concurrency = data races if two tasks mutate the same. object without synchronization. An actor is a reference type whose mutable state is isolated. You talk to it with await. the runtime serializes access. Here is a simple example with an actor. An actor protects its own data. Other work talks to it with await. Access happens one at a time. Why this matters: fewer data races. What to remember: actors isolate mutable state. 7.2 Soft bridge from production At BookMyShow, shared mutable maps were protected with G C D serial queues. (Verified · S2). Soft interview line: “Where we serialized dictionary access with a serial queue. a Swift actor is the language-native equivalent I’d evaluate for new code.” That extension is How I would. apply it · S2-A1. do not claim you rewrote production dictionaries as actors unless you did. 7.3 What not to say today “Actors replace all classes” “Every ViewModel should be an actor” Deep hop. / reentrancy theory. save for Day 05 Enough for Day 01: isolated reference type. await to touch state. prevents data races.

## §9 8. Glossary (pin)

Next. 8. Glossary (pin).

Term: Meaning. Value semantics: Independent copies. mutation does not surprise other names. Reference semantics: Shared identity. mutation is visible through all references. copy on write: Deferred copy until mutation of a non-unique buffer. Associated value: Payload stored in an enum case. Exhaustiveness: switch must cover all cases (or default). indirect: Heap indirection for recursive enum layout. Isolation: Actor state only accessible in the actor’s executor context. ===: Object identity. @MainActor: Isolation domain for main-thread / U I work (related, not identical to a custom actor).

## §10 9. Teach-back checklist

Next. 9. Teach-back checklist.

Explain each in ≤20s without notes: Struct assignment vs class assignment Why let on a class still allows. property mutation Why enums beat boolean flags for U I state copy on write one-liner Actor one-liner +. serial-queue bridge If any fail, re-read that section, then continue to 02-deep-dive.md.

## §11 10. Mini examples to type once

Next. 10. Mini examples to type once.

Struct vs class mutation Here is a simple Swift example, explained in words. struct Ticket var seat: String. class Hold var seat: String init(_ s: String) seat equals s. var t1 equals Ticket(seat: "A1"). var t2 equals t1. t2.seat equals "B2". // t1.seat equals equals "A1". What to remember: focus on the idea, not every symbol. Enum switch exhaustiveness Here is a simple Swift example, explained in words. func title(for state: LoadState String ) - String. switch state. case.idle: return "Start". case.loading: return "Loading…". case.loaded(let value): return value. case.failed: return "Something went wrong". What to remember: focus on the idea, not every symbol. Adding a new case forces every switch to update. that pressure is the feature.

## §12 Next

Next. Next.

Go to 02-deep-dive.md for copy on write uniqueness checks, large-struct costs. nested reference traps, payment state machines, and actor vs @MainActor boundaries.
