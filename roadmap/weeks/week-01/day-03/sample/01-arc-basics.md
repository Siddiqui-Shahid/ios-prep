# Sample 01 — ARC basics (Q&A)

> Guided teaching. Each answer stands alone; **Points to** shows where the full module expands the idea.

---

### Q1. What is ARC, in plain words?

**Points to:** [Foundations · §1 The one-sentence model](../01-foundations.md#1-the-one-sentence-model) · [Deep dive · §1 What the compiler actually does](../02-deep-dive.md#1-what-the-compiler-actually-does)

**Answer:**

> ARC means Automatic Reference Counting. For class instances, Swift keeps a count of how many **strong** owners exist. When that count hits zero, the object is destroyed and `deinit` runs. The compiler inserts retain and release work for you. It is not a Java-style garbage collector that pauses later to scan the heap. You still must break retain cycles yourself with `weak` or `unowned`.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Do structs use ARC the same way? | Structs, enums, and tuples are value types. They are not refcounted as heap class objects. If a struct *contains* a class, that nested class still uses ARC. |
| When does `deinit` run? | When the last strong reference is released. Relative to that release, timing is predictable — unlike many GC finalizers. |
| Does ARC mean “no memory bugs”? | No. Ownership bugs show up as cycles, early crashes from bad `unowned`, or abandoned caches — not as “forgot to free” in everyday Swift class code. |

---

### Q2. What are strong, weak, and unowned?

**Points to:** [Foundations · §2 Three kinds of references](../01-foundations.md#2-three-kinds-of-references) · [Deep dive · §2 Strong, weak, unowned](../02-deep-dive.md#2-strong-weak-unowned--semantics-table)

**Answer:**

> **Strong** is the default. It keeps the object alive and bumps the retain count.  
> **Weak** does not keep the object alive. It is optional (`T?`). When the object dies, the weak reference becomes `nil`, so you can safely `guard let self`.  
> **Unowned** also does not keep the object alive, but it is not optional and is not zeroed. If you use it after the object died, you crash. Treat `unowned` as a sharp tool, not a default.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why is `weak` optional? | Because it must represent “the object is already gone.” `nil` is that signal. |
| When is `unowned` justified? | When lifetimes are tied by construction — for example a child object that cannot outlive its parent, and you want non-optional access. |
| What about `unowned(unsafe)`? | It skips safety checks. Almost never for casual app code. |

---

### Q3. How do I choose between weak and unowned?

**Points to:** [Foundations · §6 weak vs unowned decision tree](../01-foundations.md#6-weak-vs-unowned--intern-decision-tree) · [Deep dive · When unowned is justified](../02-deep-dive.md#when-unowned-is-justified)

**Answer:**

> Ask: might the other object die first, or might this work outlive the screen? If yes, use **`weak`**.  
> Use **`unowned`** only when you can prove in one sentence that the referenced object outlives this reference (nested ownership).  
> Default interview stance: prefer `[weak self]` for escaping async work — network, ads, timers, notifications. Reach for `unowned` only when the lifetime proof is clear.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Network callback after a VC dismisses — weak or unowned? | **Weak.** The callback can outlive the screen. `unowned` is a crash waiting to happen. |
| Child owned only by parent, never escapes — allowed? | **Unowned** is allowed if that construction is true. Prefer weak if you are unsure. |
| Is unowned “faster so always use it”? | No. Correctness first. Weak’s optional unwrap is cheap compared to a production crash. |

---

### Q4. What does it mean if `deinit` never runs?

**Points to:** [Foundations · §7 What “deinit not called” means](../01-foundations.md#7-what-deinit-not-called-means)

**Answer:**

> It means the object still has at least one strong owner. ARC is not broken — it is doing what the ownership graph asks. Check escaping closures, Combine, or Tasks holding `self`; timers not invalidated; NotificationCenter tokens still registered with a strong capture; strong parent/delegate loops; still on a navigation stack or held in a singleton cache. Then open Memory Graph and ask: who still points at me?

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| First thing to try in a lab? | Temporary `deinit { print(...) }` on the suspect type, then reproduce push/pop. |
| Is “ARC is broken” ever the answer? | Almost never. Fix ownership. |
| Could the object simply still be on screen? | Yes — presented, in a stack, or cached. Not every missing `deinit` is a cycle. |

---

### Q5. How do value types relate to ARC?

**Points to:** [Foundations · §1](../01-foundations.md#1-the-one-sentence-model) · [Deep dive · §10 Value types vs ARC](../02-deep-dive.md#10-value-types-vs-arc-edge)

**Answer:**

> Value types (struct, enum, tuple) copy their data; they are not managed as ARC class instances. Class instances on the heap are. So a struct full of `Int`s does not get a retain count, but a struct that holds a `UIView` or a custom class still participates in ARC for that nested class.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Can a struct create a retain cycle? | Indirectly — if it stores classes that form a strong loop, or if closures capture class owners. The cycle is among class instances. |
| Why prefer structs for models? | Copy semantics and less accidental shared mutation. Classes when you need identity or UIKit subclassing. |
| Does `weak` work on structs? | `weak` / `unowned` apply to class instances (reference types), not to plain value types. |

---

### Q6. What should I be able to say after foundations?

**Points to:** [Foundations · §10 Bridge to senior thinking](../01-foundations.md#10-bridge-to-senior-thinking) · [Foundations · §4 Glossary](../01-foundations.md#4-glossary-speak-these-cleanly)

**Answer:**

> “ARC frees class instances when the strong count hits zero. Cycles keep counts above zero even when the UI is gone — that is abandoned memory, found with Memory Graph or Allocations, not Leaks. I break cycles with weak captures, weak delegates, timer invalidation, and NotificationCenter tokens.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What is a capture list? | `[weak self]` or `[unowned self]` — how a closure holds outer values without (or with less) strong ownership. |
| What is an escaping closure? | A closure that can outlive the function that created it — stored, async, or kept by an API. |
| What is jetsam? | iOS killing your process under memory pressure. Abandoned heaps contribute to that risk at scale. |

---

### Q7. How is ARC different from a tracing garbage collector?

**Points to:** [Deep dive · §1 interview-ready contrast](../02-deep-dive.md#1-what-the-compiler-actually-does)

**Answer:**

> ARC does most work at assign and scope exit — retain and release. A tracing GC scans the heap later (with pause or concurrent mark trade-offs). ARC does not automatically reclaim cyclic garbage; you must break cycles. `deinit` timing is tied to the last strong release, which is more predictable than many finalizers.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Is ARC “manual memory management”? | No — the compiler inserts retains/releases. MRC was the old manual era. Same runtime idea, less human error. |
| Cost model? | Predictable per-operation retain/release, not GC pause semantics. |
| Why do interviews still ask this? | To check you won’t say “Swift has a garbage collector like Java.” |

---

Next: [02-retain-cycles.md](02-retain-cycles.md)
