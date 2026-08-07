# Week 1 Flashcards — Swift, Memory, Concurrency, DSA Warm-up

Candidate: **Muhammed Shahid** · BMS / District / Raw  
Resume metrics only: **30L+ DAU**, **99.95%+ CFS**, **30%+ fewer full-screen navs**.

Source: sample critical truths from `week-01` days `day-01`…`day-07`.  
Guided teaching: `../weeks/week-01/day-NN/sample/` · Drill twins: `../revision/weeks/week-01/day-NN.md`.

**≈50 cards** · Tags: `swift` · `memory` · `concurrency` · `dsa` · `mock`

---

## day-01 — Value vs Reference, COW, Enums, Actors Intro

| Front | Back |
|---|---|
| Value vs reference | Structs copy snapshots; classes share identity on the heap |
| `let` vs `var` | Controls binding mutability — not the same as value vs reference |
| COW | Share buffer until write; then copy if not uniquely referenced |
| Enum state | Impossible combinations become compile errors, not runtime bugs |
| Actor intro | Isolated reference type; `await` to touch state — not “replace all classes” |
| BookMyShow Ads pipeline + HeroWidget lifecycle | Type-safe ads pipeline + HeroWidget lifecycle — no invented fill-rate % |
| BookMyShow payment processing-status popup | Processing popup with explicit status — no invented drop-off % |
| Design: payment status pattern (not shipped) / Design: actor SafeDict (not shipped) | How I would apply it — design patterns, not shipped claims |

## day-02 — Protocols, POP, Generics, Associated Types, Type Erasure

| Front | Back |
|---|---|
| POP | Compose capabilities; inheritance models *what you are* |
| Generics | Caller chooses `T` |
| Associated type | Adopter chooses the concrete type |
| Mixed `[AdRenderable]` with associated types | Awkward — stay generic, erase at boundary, constrained `any`, or closed enum |
| Speech | Say “protocol with associated type” — not unexplained PAT letter-soup |
| Extension-only method | May not override through an existential — promote to requirements |
| Type erasure | Allocation + indirection + lost specialization |
| BookMyShow Ads pipeline + HeroWidget lifecycle | Type-safe ads pipeline + HeroWidget lifecycle — no invented fill-rate % |

## day-03 — ARC, Retain Cycles, weak/unowned, Instruments

| Front | Back |
|---|---|
| Retain cycle | Reachable abandoned memory |
| Instruments Leaks | Finds unreachable memory — not cycles |
| Timer `target:selector:` | Timer strongly retains the target until `invalidate` |
| NotificationCenter block API | Store the observer token and remove on teardown |
| Uncertain lifetime (async UI) | Prefer `[weak self]` |
| BookMyShow IMOC + crash-free at scale | Reliability culture — do not invent a BMS Memory Graph war story |

## day-04 — GCD Queues, sync/async, Barriers, Thread-Safe Dictionary

| Front | Back |
|---|---|
| Shared dict without sync | Data race — undefined behavior |
| `main.sync` from main | Deadlock — same rule for any serial queue |
| Async write + sync read | May not see write until write runs — prefer sync set for read-after-write |
| Hide the queue | Expose safe methods only — BookMyShow synchronised dictionaries lesson |
| Barrier on concurrent queue | Exclusive writer; plain reads may overlap |
| · BookMyShow synchronised dictionaries | Path-specific race elimination on synchronised dictionaries |
| Design: actor SafeDict (not shipped) actor | How I would apply it — not a claim you rewrote production |
| Spell it | `final class`, never `Final class` |

## day-05 — async/await, Structured Concurrency, Actors, Sendable

| Front | Back |
|---|---|
| `await` | Suspension point — not “always background thread” |
| Structured concurrency | Parent owns children; cancel and errors can propagate |
| Unstructured `Task` | You own lifetime and cancellation (UI boundaries) |
| Cancellation | Cooperative — not preemptive thread killing |
| Actor | Prevents data races on isolated state — reentrant at `await` |
| Sendable | Value types are Sendable only if stored properties are |
| BookMyShow synchronised dictionaries | GCD synchronised dictionaries at BMS — not org-wide actor rewrite |
| Design: actor SafeDict (not shipped) | Greenfield actor migration — How I would apply it |

## day-06 — DSA: Arrays, Strings, Two Pointers, Sliding Window

| Front | Back |
|---|---|
| Say-this-first | Clarify → brute → optimize → edges — before typing |
| Two pointers | Two indices, invariant, move the side that restores it |
| Sliding window | Expand right; shrink left when invariant breaks |
| Swift String | Not O(1) random index — say the cost if you convert |
| Communication | Process narration beats a silent clever trick |
| Week 1 minimum | 8 core problems in `../01-foundations.md` §5 |

## day-07 — Week 1 Revision + Mock Interview #1

| Front | Back |
|---|---|
| Mock agenda | Defs → concurrency/memory → BookMyShow synchronised dictionaries → feed HLD → retro |
| BookMyShow synchronised dictionaries time box | ≤3 min STAR; ≤20s elevator also |
| Score 5 | On time + trade-off + prod proof + honest provenance |
| Design: actor SafeDict (not shipped) | Actor migration is How I would apply it — not “we rewrote prod” |
| No invention | Zero fake fill-rate / crash-% ownership |
| Full answers | Warm-up/deep Answer points live in `../04-questions.md` |
