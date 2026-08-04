# 01 — Foundations: ARC mental model

> Intern-first. Read this before the deep dive. No external docs required.

## 1. The one-sentence model

**ARC (Automatic Reference Counting)** is how Swift/ObjC keep track of how many *strong* owners a class instance has. When the strong count hits zero, the object is destroyed and `deinit` runs. There is no garbage-collector pause world like Java/Go — the compiler inserts retain/release calls at compile time.

Structs, enums, and tuples are **value types**. They are not ARC-managed as heap objects in the same way. Nested *classes* inside a struct still use ARC.

## 2. Three kinds of references

| Kind | Optional? | What happens when owner goes away | Use when |
|---|---|---|---|
| **strong** (default) | No | Keeps the object alive | Normal ownership |
| **weak** | Yes (`T?`) | Reference becomes `nil` | Break cycles; owner may outlive you |
| **unowned** | No (`T`) | Becomes a **dangling** pointer — crash if you use it | You are *sure* the other object outlives you |

### Intern picture

Imagine a sticky note on every object: “how many strong owners?”

- Create an object → count = 1 (the variable that owns it).
- Assign to another strong property → count += 1.
- That property is set to `nil` or goes out of scope → count -= 1.
- Count hits 0 → memory freed, `deinit` prints if you log it.

`weak` does **not** bump the sticky-note count. When the object dies, the weak pointer is zeroed to `nil` so you can safely write `guard let self else { return }`.

`unowned` also does **not** bump the count, but it does **not** zero. If you touch it after the object died, you crash. That is why seniors treat `unowned` as a sharp tool, not a default.

## 3. What is a retain cycle?

A **retain cycle** is a loop of strong references:

```
ViewController ──strong──▶ closure
      ▲                        │
      └──────── strong ────────┘
```

Nothing outside the loop needs those objects anymore, but their counts never hit zero — so they never deallocate. They are still **reachable** from each other.

That is **abandoned memory** (still referenced, but unused by the live app graph you care about). It is *not* the same as an Instruments **Leak**, which is memory with **no** live references at all.

### Why this matters in interviews

Interviewers love the trap: “retain cycles show up in the Leaks instrument.”

**Wrong.** Leaks looks for *unreachable* allocations. A cycle is *reachable*. You find cycles with:

1. **Xcode Debug Memory Graph** (visual ownership edges, cycle highlighting)
2. **Allocations** instrument (persistent growth / objects that should have died)

Use **Leaks** for true unreachable leaks (malloc without owners, some C/ObjC edge cases, bugs that drop all pointers).

## 4. Glossary (speak these cleanly)

| Term | Meaning |
|---|---|
| Retain count | Number of strong references to a class instance |
| `deinit` | Method called when count hits zero (last chance to invalidate timers, etc.) |
| Escaping closure | Closure that outlives the function that created it; can capture `self` strongly |
| Capture list | `[weak self]`, `[unowned self]` — how the closure holds outer values |
| Abandoned memory | Still referenced, but no longer useful (classic: retain cycle, forever cache) |
| True leak | Allocated memory with **no** remaining references |
| High watermark | Peak memory during a session; not the same as a leak |
| Jetsam | iOS kills your process under memory pressure |
| Observer token | Object returned by NotificationCenter’s block API; keep it to unregister |

## 5. Cycle hotspots you’ll see every week

| Pattern | Why it cycles | Fix (one line) |
|---|---|---|
| Escaping closure on `self` | Object owns closure; closure captures `self` strong | `[weak self]` + `guard let self` |
| `delegate` stored `strong` | VC ↔ delegate both strong | `weak var delegate` (class-bound) |
| `Timer` target-selector | Timer **retains** its target | `invalidate()` in `deinit`; prefer block timer + weak |
| NotificationCenter **block** observer | Center holds block; block may hold `self` | Store **token**; remove; `[weak self]` in block |
| Parent → child → parent | Two-way strong ownership | One side `weak` / `unowned` |

## 6. weak vs unowned — intern decision tree

```
Does this reference participate in a possible cycle
OR might the other object die first?
        │
        ├─ YES, other might die first ──▶ weak (optional, safe nil)
        │
        └─ Lifetimes are mathematically tied
           (child owned by parent; child never outlives parent)
           ──▶ unowned is *allowed*, still prefer weak if unsure
```

**Default interview stance:** prefer `[weak self]` for escaping async work (network, ads, timers, notifications). Reach for `unowned` only when you can prove lifetime in one sentence.

## 7. What “deinit not called” means

If you expected an object to die and `deinit` never runs, the object still has ≥1 strong owner. Checklist:

1. Escaping closure / Combine / Task still holding `self`
2. Timer not invalidated
3. NotificationCenter observer / token still registered with a strong capture
4. Delegate / parent strong back-reference
5. Still in a navigation stack, presented, or cached by a singleton
6. Instruments: Memory Graph — who points at me?

Do **not** say “ARC is broken.” ARC is doing exactly what the strong graph asks.

## 8. Mini demo mental walkthrough

```swift
final class Box {
    var onDone: (() -> Void)?
    deinit { print("Box deinit") }
}

do {
    let box = Box()
    box.onDone = {
        // strong capture of box → cycle: box → closure → box
        print(box)
    }
}
// Box deinit does NOT print — abandoned, still reachable via the cycle
```

Fix:

```swift
box.onDone = { [weak box] in
    guard let box else { return }
    print(box)
}
```

Full annotated examples: [code/RetainCycleDemo.swift](code/RetainCycleDemo.swift).

## 9. Tools at a glance (foundations)

| Tool | Finds | Does *not* find well |
|---|---|---|
| Memory Graph | Ownership edges, retain cycles, who retains a VC | Historical allocation timeline |
| Allocations | Growth over time, persistent objects, abandoned heaps | Pretty cycle diagrams |
| Leaks | Unreachable malloc/ObjC objects | Retain cycles (they’re reachable!) |

## 10. Bridge to senior thinking

After this file you should be able to say:

> “ARC frees class instances when strong count hits zero. Cycles keep counts above zero even when the UI is gone — that’s abandoned memory, found with Memory Graph or Allocations, not Leaks. I break cycles with weak captures, weak delegates, timer invalidation, and NotificationCenter tokens.”

Next: [02-deep-dive.md](02-deep-dive.md) for mechanisms, edge cases, and trade-off tables.
