# Sample 01 — Value types (Q&A)

> Guided teaching. Say the **Answer** out loud like you’re talking to an interviewer.  
> Each answer ends with **How can I relate to my case** using named work — never S-codes.  
> **Brain puzzles** at the bottom — cover the answer, think, then check.

---

### Q1. What is the north star for choosing types in Swift?

**Answer:**

> “Prefer value types for data. Reach for reference types when you need identity or a shared mutable lifetime. Reach for an actor when that shared mutability crosses concurrency. I start with struct or enum, and I justify every class and every actor with a concrete need — not habit.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Default for a listing row model? | “Struct — independent copies, fewer shared-mutation surprises.” |
| Default for a shared API client? | “Class — one identity the app shares.” |
| When does an enum beat a struct? | “Finite modes with different payloads — loading vs loaded vs failed.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q2. What does “copy” vs “share” mean?

**Answer:**

> “A value box — struct, enum, tuple — owns a snapshot. Assigning to another name makes another snapshot, so mutating one doesn’t change the other. A reference box — class, actor — holds a pointer to one heap object. Two names can point at the same thing, so mutating through one name is visible through the other.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Struct demo in one sentence? | “`b = a` then `b.x = 99` leaves `a.x` unchanged.” |
| Class demo in one sentence? | “`d = c` then `d.value = 99` also changes `c.value`.” |
| Are closures value or reference? | “Closures capture references — especially `self` on classes. That’s a nested-ref trap even if the outer type looks like a value.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q3. Does `let` vs `var` tell you value vs reference?

**Answer:**

> “No — and this trip-up shows up constantly. `let` and `var` control whether the *name* can be reassigned. For a struct, `let` also blocks property mutation, because mutation really replaces the whole value. For a class, `let c = Box(1)` still allows `c.value = 2` — the name still points at the same object; the object’s contents change. `let` is not ‘immutable object’ for reference types.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| `let p = Point(...)` on a struct? | “Cannot mutate `p`’s properties — the whole value is fixed.” |
| `let c = Box(...)` on a class? | “Cannot reassign `c` to another instance, but can mutate properties.” |
| Why does this matter in UI code? | “People assume `let viewModel` means immutable state — often false for classes.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q4. When do you pick struct, class, enum, or actor?

**Answer:**

> “Struct for models, DTOs, and UI state snapshots. Enum for a finite set of modes with associated payloads. Class for identity — triple-equals, UIKit, ObjC — or one shared service instance. Actor for shared mutable state hit from multiple concurrent tasks. ObjC inheritance and UIKit subclassing force class regardless of preference.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Need “is this the exact same instance?” | “Class or actor — triple-equals is identity.” |
| Payment screen with processing / success / failure? | “Enum — each case carries only the data that mode needs.” |
| Shared dictionary mutated from many tasks? | “Actor — or a serial queue in legacy code — not a plain class without sync.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q5. Why do teams prefer structs for ad and listing models?

**Answer:**

> “Structs give value semantics — two screens holding the same model don’t accidentally mutate each other’s copy. For revenue-critical listing and ad UI, that independence is a safety feature. It pairs with a type-safe ads pipeline — protocols plus generics — without claiming every production model was literally a struct.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What if I “decorate” an ad for one cell? | “Return a new value; the caller keeps the old one unless they assign.” |
| Does struct mean “immutable”? | “No — `var` properties on a `var` binding are mutable; copies stay independent.” |
| When is a class still right in ads? | “UIKit views, HeroWidget lifecycle, shared players — identity matters.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

---

### Q6. What happens when a struct contains a class property?

**Answer:**

> “Copying the struct copies its stored properties — but reference-typed properties still share the same heap object. Change `m2.cache` and `m1.cache` sees it too. ‘Value type’ does not mean a deep immutable graph. Audit nested classes when you reason about isolation — and don’t hide shared services inside DTOs.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Symptom in production? | “Two ‘sessions’ polluting one event log or cache.” |
| Fix mindset? | “Make the nested type a value, deep-copy explicitly, or inject services at the boundary.” |
| Can a struct still create a cycle? | “Indirectly — if nested classes or closures form strong loops. The cycle is among class instances.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q7. What is the difference between `==` and `===`?

**Answer:**

> “Double-equals compares values — you implement it via Equatable. Triple-equals compares object identity — same heap instance. Triple-equals only applies to class instances and similar reference types. Asking ‘are these the same struct instance?’ is a category error — structs are values, not identities.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Two CheckoutSession instances, same data? | “Double-equals might be true if you define it; triple-equals is false unless they are the same object.” |
| `let s1 = s2` after creating one session? | “`s1 === s2` is true — both names point at one object.” |
| Structs in a Set? | “Hash and equality on value fields — no triple-equals.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q8. Are structs always cheaper than classes?

**Answer:**

> “No — structs win on semantics and often on small data, not by magic. A large struct with many stored properties pays bitwise copy cost on each assignment or pass-by-value. Stdlib collections dodge that with copy-on-write. Your own fat structs may need COW wrappers, `inout`, or a reference boundary. Measure hot paths; don’t repeat ‘structs are always faster.’”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Interview-safe one-liner? | “I default to structs for semantics; I profile large copies.” |
| When might a class be cheaper? | “One shared mutable cache entry with intentional identity — rare for DTOs.” |
| `inout` parameter? | “Mutates in place — no conceptual return copy. Exclusivity rules apply — overlapping inout access is illegal.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q9. What is the law of exclusivity — and why does `inout` care?

**Answer:**

> “Swift’s exclusivity rules say you can’t have overlapping mutable access to the same value. That’s why `inout` feels strict — while a value is borrowed for mutation, other overlapping reads or writes of that same storage are illegal. It’s part of why value semantics stay predictable. If the compiler complains about overlapping access, don’t fight it with unsafe tricks — restructure so one exclusive write owns the window.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Junior one-liner? | “One exclusive write at a time to a value — overlapping inout is a hard no.” |
| Related to actors? | “Different tool — exclusivity is for values; actors isolate reference mutable state across tasks.” |
| 45s agenda template? | “Claim → exclusivity → `inout` in place → don’t overlap access.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q10. What does a `mutating` method actually do to `self`?

**Answer:**

> “A mutating method is allowed to replace `self`. That’s why it only works on a `var` binding — the call site has to be allowed to write the whole value back. On a `let` binding, `increment()` is a compile error even if the method only bumps one field. Mentally: mutation of a struct is reassignment of the value.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| `private(set)` still mutating? | “Yes — outsiders still need a `var` binding to call mutating methods.” |
| Class analogy? | “Classes don’t need `mutating` — the reference stays; properties change.” |
| Spoken 45s struct agenda? | “Semantics → mutation replaces self → example → production hook.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q11. Give the 45-second spoken agenda for struct vs class

**Answer:**

> “Agenda: semantics → mutation → example. Structs have value semantics — copies are independent. Classes share identity — mutation is visible everywhere. I default to structs for ad and listing models; classes for UIKit and true shared services. On BookMyShow Ads pipeline work, value-friendly render models fit the type-safe pipeline; HeroWidget lifecycle stays a reference-type concern.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Stretch with production? | “Lead with protocols-plus-generics type safety, then model choice — don’t invent fill-rate numbers.” |
| Where next? | [02-cow-enums.md](02-cow-enums.md) |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

---

## Brain puzzles (cover → think → check)

### Puzzle A — Does `let box` make a class immutable?

```swift
final class Box { var value: Int; init(_ v: Int) { value = v } }
let box = Box(1)
box.value = 99
```

**Ask yourself:** Does this compile? Is `box` “immutable”?

**Answer:** It compiles. `let` fixes the *binding* — you can’t do `box = Box(2)`. The object’s properties can still change. Immutability for a class means `let` properties (or read-only surfaces), not `let` on the instance name.

---

### Puzzle B — Struct with nested-class cache pollution

```swift
class ImageCache { var bytes = Data() }
struct CellModel { var title: String; var cache: ImageCache }

var m1 = CellModel(title: "A", cache: ImageCache())
var m2 = m1
m2.title = "B"
m2.cache.bytes = Data([1])
```

**Ask yourself:** What is `m1.title`? What does `m1.cache.bytes` contain?

**Answer:** `m1.title` is still `"A"`. `m1.cache.bytes` is `Data([1])` — the nested class was shared. Value copy is shallow for references.

---

### Puzzle C — Closure capture fakes a value type

```swift
final class Loader {
    var label = "x"
    func makePrinter() -> () -> Void {
        { print(self.label) }
    }
}
let a = Loader()
let printA = a.makePrinter()
a.label = "y"
printA()
```

**Ask yourself:** What prints? Did “returning a function” give you an independent snapshot?

**Answer:** Prints `"y"`. The closure captured `self` by reference. “I returned a value-ish function” does not freeze class state.

---

Next: [02-cow-enums.md](02-cow-enums.md)
