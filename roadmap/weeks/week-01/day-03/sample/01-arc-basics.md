# Sample 01 — ARC basics (Q&A)

> Guided teaching. Say the **Answer** out loud like you’re talking to an interviewer.  
> Each answer ends with **How can I relate to my case** using named work — never S-codes.  
> **Brain puzzles** at the bottom — cover the answer, think, then check.

---

### Q1. What is ARC, in plain words?

**Answer:**

> “ARC means Automatic Reference Counting. For class instances, Swift keeps a count of how many strong owners exist. When that count hits zero, the object is destroyed and `deinit` runs. The compiler inserts retain and release for you. It’s not a Java-style garbage collector that pauses later to scan the heap. You still must break retain cycles yourself with weak or unowned.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Do structs use ARC the same way? | “Structs, enums, and tuples are value types — not refcounted as heap class objects. If a struct contains a class, that nested class still uses ARC.” |
| When does `deinit` run? | “When the last strong reference is released. Relative to that release, timing is predictable — unlike many GC finalizers.” |
| Does ARC mean no memory bugs? | “No. Ownership bugs show up as cycles, early crashes from bad `unowned`, or abandoned caches — not as ‘forgot to free’ in everyday Swift class code.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q2. What are strong, weak, and unowned?

**Answer:**

> “Strong is the default — it keeps the object alive and bumps the retain count. Weak does not keep the object alive. It’s optional. When the object dies, the weak reference becomes nil, so you can safely guard let self. Unowned also does not keep the object alive, but it is not optional and is not zeroed. If you use it after the object died, you crash. Treat unowned as a sharp tool, not a default.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why is weak optional? | “Because it must represent ‘the object is already gone.’ nil is that signal.” |
| When is unowned justified? | “When lifetimes are tied by construction — a child that cannot outlive its parent, and you want non-optional access.” |
| What about `unowned(unsafe)`? | “It skips safety checks. Almost never for casual app code.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q3. How do I choose between weak and unowned?

**Answer:**

> “Ask: might the other object die first, or might this work outlive the screen? If yes, use weak. Use unowned only when you can prove in one sentence that the referenced object outlives this reference — nested ownership. Default interview stance: prefer weak self for escaping async work — network, ads, timers, notifications. Reach for unowned only when the lifetime proof is clear.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Network callback after a VC dismisses? | “Weak. The callback can outlive the screen. Unowned is a crash waiting to happen.” |
| Child owned only by parent, never escapes? | “Unowned is allowed if that construction is true. Prefer weak if you are unsure.” |
| Is unowned faster so always use it? | “No. Correctness first. Weak’s optional unwrap is cheap compared to a production crash.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q4. Parent ↔ child — weak vs unowned decision?

**Answer:**

> “Parent strongly owns child. Child points back. If both sides are strong, neither dies. Make the back edge weak when the child might briefly outlive the parent or you’re unsure — optional and safe. Use unowned let parent only when the child’s lifetime is strictly nested under the parent by API construction and you want non-optional access — and you accept a crash if that invariant ever breaks. Under uncertainty, interview default is weak.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Which side is usually weak? | “The back-pointer to the owner — child → parent.” |
| Same idea in UIKit? | “Yes — clear one-way ownership; avoid two-way strong.” |
| Demo? | “ParentBroken / ChildBroken vs ParentFixed / ChildFixed in RetainCycleDemo.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q5. What does it mean if `deinit` never runs?

**Answer:**

> “It means the object still has at least one strong owner. ARC is not broken — it’s doing what the ownership graph asks. Check escaping closures, Combine, or Tasks holding self; timers not invalidated; NotificationCenter tokens still registered with a strong capture; strong parent/delegate loops; still on a navigation stack or held in a singleton cache. Then open Memory Graph and ask: who still points at me?”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| First thing to try in a lab? | “Temporary `deinit { print(...) }` on the suspect type, then reproduce push/pop.” |
| Is ‘ARC is broken’ ever the answer? | “Almost never. Fix ownership.” |
| Could the object simply still be on screen? | “Yes — presented, in a stack, or cached. Not every missing deinit is a cycle.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q6. Walk the deinit print lab in one breath

**Answer:**

> “In a learning lab I add `deinit { print(\"Gone: \\(type)\") }` on the VC or controller under test. Push, arm the suspect pattern, pop. If the print never fires, something still owns it. Fix the edge — weak capture, invalidate timer, remove observer — pop again. When the print fires and Memory Graph is clear, I’m done. That’s a five-minute habit, not a production war story.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why print instead of only Graph? | “Fast feedback loop while iterating the fix.” |
| Leave prints in production? | “No — temporary lab signal, then remove.” |

**How can I relate to my case:**
- **Lab only:** Learning-lab demos / sketches only — not production source.

---

### Q7. How do value types relate to ARC?

**Answer:**

> “Value types — struct, enum, tuple — copy their data; they are not managed as ARC class instances. Class instances on the heap are. So a struct full of Ints does not get a retain count, but a struct that holds a UIView or a custom class still participates in ARC for that nested class.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Can a struct create a retain cycle? | “Indirectly — if it stores classes that form a strong loop, or if closures capture class owners. The cycle is among class instances.” |
| Why prefer structs for models? | “Copy semantics and less accidental shared mutation. Classes when you need identity or UIKit subclassing.” |
| Does weak work on structs? | “Weak and unowned apply to class instances — reference types — not to plain value types.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q8. How is ARC different from a tracing garbage collector?

**Answer:**

> “ARC does most work at assign and scope exit — retain and release. A tracing GC scans the heap later, with pause or concurrent mark trade-offs. ARC does not automatically reclaim cyclic garbage; you must break cycles. Deinit timing is tied to the last strong release, which is more predictable than many finalizers.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Is ARC manual memory management? | “No — the compiler inserts retains and releases. MRC was the old manual era.” |
| Why do interviews still ask this? | “To check you won’t say ‘Swift has a garbage collector like Java.’” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q9. What should I be able to say after foundations?

**Answer:**

> “ARC frees class instances when the strong count hits zero. Cycles keep counts above zero even when the UI is gone — that is abandoned memory, found with Memory Graph or Allocations, not Leaks. I break cycles with weak captures, weak delegates, timer invalidation, and NotificationCenter tokens. Unowned after free is a crash, not a silent leak.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What is a capture list? | “Weak self or unowned self — how a closure holds outer values without, or with less, strong ownership.” |
| What is an escaping closure? | “A closure that can outlive the function that created it — stored, async, or kept by an API.” |
| What is jetsam? | “iOS killing your process under memory pressure. Abandoned heaps contribute to that risk at scale.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q10. Give me the 30-second interview definition

**Answer:**

> “ARC reference-counts class instances; deinit runs when the last strong owner is gone. Retain cycles are abandoned but still reachable — Memory Graph and Allocations, not Leaks. Prefer weak for uncertain lifetimes; unowned only with a nested lifetime proof. Timers invalidate; NotificationCenter tokens remove; Tasks cancel.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Stretch with production? | “At BookMyShow we held a 99.95%+ crash-free bar at 30L+ DAU — memory and lifecycle bugs sit in that reliability conversation. For specific Graph triage I’d label Applied, not invent a BMS ticket.” |
| Where’s the full Q bank? | [../04-questions.md](../04-questions.md) |

**How can I relate to my case:**
- **Shipped:** BookMyShow IMOC + crash-free at scale
- **Design if asked:** Applied Memory Graph / Allocations triage — label Applied, not shipped war story.

---

## Brain puzzles (cover → think → check)

### Puzzle A — Weak vs unowned when lifetime uncertain

You write:

```swift
api.load { [unowned self] result in
    self.render(result)
}
```

The user dismisses the screen before the callback. What happens?

**Answer:** When the VC dies, `unowned self` dangles. The late callback **crashes** (use-after-free). Prefer `[weak self]` when the network can outlive the screen.

---

### Puzzle B — deinit print lab

You add `deinit { print("VC gone") }`, push the VC, arm a broken completion that strongly captures `self`, pop. No print.

**Ask yourself:** Is ARC broken?

**Answer:** No. Something still strongly owns the VC — almost always the escaping closure cycle. Open Memory Graph; break the edge; pop again until the print fires.

---

### Puzzle C — Parent ↔ child choice

`Parent` owns `Child` strongly. `Child` needs to call back into `Parent`. Lifetime of `Child` is strictly nested under `Parent` by construction.

**Ask:** weak or unowned back-pointer?

**Answer:** Either can work; **unowned** is allowed when nested lifetime is proven and you want non-optional access. If anything about teardown is fuzzy, **weak**. Interview default under uncertainty: weak.

---

### Puzzle D — “Structs don’t retain”

Someone says: “We only use structs for models, so we can’t have retain cycles.”

**Answer:** False confidence. A struct holding a class still retains that class. Closures are reference types under the hood. Cycles live among **class instances** — structs can participate by storing them.

---

Next: [02-retain-cycles.md](02-retain-cycles.md)
