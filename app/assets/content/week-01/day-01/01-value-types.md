# Sample 01 — Value types (Q&A)

> Guided teaching. Each answer stands alone; **Points to** shows where the full module expands the idea.

---

### Q1. What is the north star for choosing types in Swift?

**Points to:** [Foundations · §0 One-sentence north star](../01-foundations.md#0-one-sentence-north-star) · [Deep dive · §10 Diagram: decision flow](../02-deep-dive.md#10-diagram-decision-flow)

**Answer:**

> Prefer value types for data. Use reference types when you need identity or a shared mutable lifetime. Use actors when that shared mutability crosses concurrency boundaries. Start with `struct` or `enum`; justify every `class` and every `actor` with a concrete need.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Default for a listing row model? | **`struct`** — independent copies, fewer shared-mutation surprises. |
| Default for a shared API client? | **`class`** — one identity the app shares. |
| When does an enum beat a struct? | Finite modes with different payloads — loading vs loaded vs failed. |

---

### Q2. What does “copy” vs “share” mean?

**Points to:** [Foundations · §1 Mental model](../01-foundations.md#1-mental-model-what-copy-and-share-mean) · [Foundations · §1.2 The intern demo](../01-foundations.md#12-the-intern-demo-do-this-once-out-loud)

**Answer:**

> A **value box** (struct, enum, tuple) owns a snapshot. Assigning to another name makes another snapshot — mutating one does not change the other. A **reference box** (class, actor) holds a pointer to one heap object. Two names can point at the same object — mutating through one name is visible through the other.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Struct demo in one sentence? | `b = a` then `b.x = 99` leaves `a.x` unchanged. |
| Class demo in one sentence? | `d = c` then `d.value = 99` also changes `c.value`. |
| Are closures value or reference? | Closures **capture** references — especially `self` on classes. |

---

### Q3. Does `let` vs `var` tell you value vs reference?

**Points to:** [Foundations · §1.3 `let` vs `var`](../01-foundations.md#13-let-vs-var-is-not-value-vs-reference)

**Answer:**

> No. `let` and `var` control whether the **name** can be reassigned. For a struct, `let` also blocks property mutation. For a class, `let c = Box(1)` still allows `c.value = 2` — the name still points at the same object; the object’s contents change. This trip-up shows up constantly in interviews.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| `let p = Point(...)` on a struct? | Cannot mutate `p`’s properties — the whole value is fixed. |
| `let c = Box(...)` on a class? | Cannot reassign `c` to another instance, but can mutate properties. |
| Why does this matter in UI code? | People assume `let viewModel` means immutable state — often false for classes. |

---

### Q4. When do you pick struct, class, enum, or actor?

**Points to:** [Foundations · §2 Decision table](../01-foundations.md#2-decision-table-struct--class--enum--actor) · [Deep dive · §7.1 Type choice](../02-deep-dive.md#71-type-choice)

**Answer:**

> **Struct** for models, DTOs, and UI state snapshots. **Enum** for a finite set of modes with associated payloads. **Class** for identity (`===`), UIKit/ObjC, or one shared service instance. **Actor** for shared mutable state hit from multiple concurrent tasks. ObjC inheritance and UIKit subclassing force `class` regardless of preference.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Need “is this the exact same instance?” | **Class** (or actor) — `===` is identity. |
| Payment screen with processing / success / failure? | **Enum** — each case carries only the data that mode needs. |
| Shared dictionary mutated from many tasks? | **Actor** (or serial queue in legacy code) — not a plain class without sync. |

---

### Q5. Why do teams prefer structs for ad and listing models?

**Points to:** [Foundations · §3.1 Why teams love structs](../01-foundations.md#31-why-teams-love-structs-for-models) · [Production bridge · Verified S1](../03-production-bridge.md#2-verified--s1--ads--type-safe-models)

**Answer:**

> Structs give **value semantics** — two screens holding the same model do not accidentally mutate each other’s copy. For revenue-critical listing and ad UI, that independence is a safety feature. It pairs with a type-safe ads pipeline (protocols + generics) without claiming every production model was literally a struct.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What if I “decorate” an ad for one cell? | Return a new value; caller keeps the old one unless they assign. |
| Does struct mean “immutable”? | No — `var` properties on a `var` binding are mutable; copies stay independent. |
| When is a class still right in ads? | UIKit views, HeroWidget lifecycle, shared players — identity matters. |

---

### Q6. What happens when a struct contains a class property?

**Points to:** [Foundations · §3.2 Structs can contain classes](../01-foundations.md#32-structs-can-contain-classes-shallow-copy) · [Deep dive · §3.1 Struct + class property](../02-deep-dive.md#31-struct--class-property)

**Answer:**

> Copying the struct copies its stored properties — but reference-typed properties still **share** the same heap object. Change `m2.cache` and `m1.cache` sees it too. “Value type” does not mean a deep immutable graph. Audit nested classes when you reason about isolation.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Symptom in production? | Two “sessions” polluting one event log or cache. |
| Fix mindset? | Make the nested type a value, deep-copy explicitly, or inject services at the boundary — don’t hide them inside DTOs. |
| Can a struct still “create a cycle”? | Indirectly — if nested classes or closures form strong loops. The cycle is among class instances. |

---

### Q7. What is the difference between `==` and `===`?

**Points to:** [Foundations · §4.2 `==` vs `===`](../01-foundations.md#42--vs-)

**Answer:**

> `==` compares **values** — you implement it via `Equatable`. `===` compares **object identity** — same heap instance. `===` only applies to class instances (and similar reference types). Asking “are these the same struct instance?” is a category error — structs are values, not identities.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Two `CheckoutSession` instances, same data? | `==` might be true if you define it; `===` is false unless they are the same object. |
| `let s1 = s2` after `s1 = CheckoutSession()`? | `s1 === s2` is **true** — both names point at one object. |
| Structs in a `Set`? | Hash/equality on **value** fields — no `===`. |

---

### Q8. Are structs always cheaper than classes?

**Points to:** [Deep dive · §1.1 What the compiler actually does](../02-deep-dive.md#11-what-the-compiler-actually-does) · [Deep dive · §7.1 Type choice](../02-deep-dive.md#71-type-choice)

**Answer:**

> No — structs win on **semantics** and often on small data, not by magic. A large struct with many stored properties pays copy cost on each assignment or pass-by-value. Stdlib collections dodge that with COW; your own fat structs may need COW wrappers, `inout`, or a reference boundary. Measure hot paths; don’t repeat “structs are always faster.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Interview-safe one-liner? | “I default to structs for semantics; I profile large copies.” |
| When might a class be cheaper? | One shared mutable cache entry with intentional identity — rare for DTOs. |
| `inout` parameter? | Mutates in place — no conceptual return copy; exclusivity rules apply. |

---

Next: [02-cow-enums.md](02-cow-enums.md)
