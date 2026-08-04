# Day 05 — Questions (two-layer Q&A)

> Study flow: cover **Full spoken answer** → speak from **Answer points** only → uncover and compare timing.  
> Budgets follow [answer-timing-guide.md](../../../timing/answer-timing-guide.md).

**Bank size:** 12 normal + 8 tricky = **20 questions**.

---

## Normal questions

### Q1. async/await vs GCD callbacks? `(45–60s)`

**Answer points (frame first):**
- Both schedule work; async/await is suspension + linear control flow
- Errors via `throws`; cancellation composes with Tasks
- GCD still valid for queues/legacy; not “delete Dispatch”
- One production bridge (mixed codebase / S2 still GCD)

**Agenda opener:** “Both schedule asynchronous work — the difference is composition and suspension versus queue callbacks…”

**Full spoken answer:**
> “GCD gives you queues and explicit scheduling with closures. async/await lets a function suspend at await points so control flow stays linear, errors use throws, and work composes with structured concurrency and Task cancellation. GCD isn’t obsolete — at BookMyShow our synchronised dictionaries were serial-queue based — but for new asynchronous APIs I prefer async/await for readability and cancellation, and I keep GCD where a stable queue boundary already works.”

**Common wrong answer:** “async/await replaces GCD and is always faster.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Does await mean background thread? | No — suspension point; resume depends on isolation/executor |
| L2 | When keep GCD? | Stable serial isolation, ObjC-heavy modules, incremental migration |
| L3 | Mixing risks? | Blocking sync from async code; prefer async façades |

**Provenance:** Verified · S2 (GCD path) · Learning-lab for async rewrite judgment

---

### Q2. What is structured concurrency? `(45–60s)`

**Answer points (frame first):**
- Parent/child task tree; scoped lifetimes
- Cancellation/errors can propagate
- Prefer `async let` / TaskGroup over detached fire-and-forget
- Contrast with unstructured `Task { }`

**Agenda opener:** “Structured concurrency means async work forms a parent-owned tree…”

**Full spoken answer:**
> “Structured concurrency organizes asynchronous work into a parent/child hierarchy. The parent owns child lifetimes, so cancellation and completion compose naturally. APIs like async let and TaskGroup keep fan-out inside a scope. Unstructured Task braces are still needed to bridge from synchronous UI code, but if everything is detached fire-and-forget you lose that ownership story — which shows up as stale search results or work after a screen disappears.”

**Common wrong answer:** “Structured concurrency just means using async/await syntax.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | async let vs TaskGroup? | Fixed vs dynamic child count |
| L2 | What must you manage with Task {}? | Store handle, cancel, error surfacing |
| L3 | Detached default? | No — rare independent lifetime/priority |

**Provenance:** Learning-lab · concepts; product hook via S3 Task ownership

---

### Q3. How does Task cancellation work? `(60s)`

**Answer points (frame first):**
- Cooperative, not kill-thread
- `cancel()` marks cancelled; work checks or hits cancellable await
- `Task.checkCancellation()` / `isCancelled`
- Search debounce needs cancel (S3)

**Agenda opener:** “Cancellation in Swift is cooperative…”

**Full spoken answer:**
> “Calling cancel marks a Task cancelled; it doesn’t forcibly kill a thread. The task stops when it hits a cancellable suspension that throws CancellationError, or when code checks Task.isCancelled or checkCancellation. Tight CPU loops that never check can ignore cancel. In search debounce, I store the Task and cancel the previous one on each keystroke so older in-flight work doesn’t overwrite newer results — that’s the BookMyShow search UX pattern.”

**Common wrong answer:** “Cancel instantly stops all code like killing a thread.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | URLSession async cancel? | Async APIs participate with Task cancel; callback tasks need explicit cancel |
| L2 | Swallow CancellationError? | Usually yes at debounce boundaries; don’t present as app failure |
| L3 | Parent cancel children? | In structured concurrency, cancellation propagates down |

**Provenance:** Verified · S3 · search debounce

---

### Q4. Actor vs class + lock / GCD serial queue? `(60–90s)`

**Answer points (frame first):**
- Actor: compiler-enforced isolation
- GCD serial: proven S2 pattern; manual API discipline
- Locks: small sections; ordering/priority risks
- Migration judgment: S2 verified, S2-A1 applied for greenfield

**Agenda opener:** “All three serialize access — the difference is enforcement and failure modes…”

**Full spoken answer:**
> “A GCD serial queue can protect a dictionary if every access goes through it — that’s what we shipped for synchronised dictionaries at BookMyShow. Locks work for tiny critical sections but are easy to misuse under complexity. An actor gives compiler-checked isolation and an async API from the outside. For greenfield shared maps I’d prefer an actor with the same safe get/set surface; for a stable GCD module I wouldn’t big-bang rewrite. The actor trade-off is reentrancy: after await, state may change, so I re-validate.”

**Common wrong answer:** “Actors are just locks; no new bugs possible.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Why hide storage? | Call sites racing raw dict defeat the wrapper (S2 lesson) |
| L2 | RW locks when? | Read-heavy maps; more complexity than serial |
| L3 | Migrate how? | Strangler: new modules actors, leave stable queues (S2-A1) |

**Provenance:** Verified · S2 · How I would apply it · S2-A1

---

### Q5. What is actor reentrancy? `(60–90s)`

**Answer points (frame first):**
- At `await` inside actor, other calls may run on same actor
- Isolated state may change across await — no data race, possible logic race
- Re-check invariants / use locals / short updates
- One concrete example (balance/refresh or token)

**Agenda opener:** “Actor reentrancy is the rule that suspension points allow other work on the same actor…”

**Full spoken answer:**
> “Actors serialize execution on their isolated state, but they are reentrant at await points. If an actor method awaits, another task may enter the actor before the first resumes, so fields may have changed even though you never had a data race. Seniors don’t assume continuity across await — they snapshot what they need, re-check invariants after resume, and keep mutations short. That’s the main trap when people say actors make concurrency bugs impossible.”

**Common wrong answer:** “Inside an actor method, nothing else can run until the method returns.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Why designed this way? | Avoid deadlocks while actor waits on external work |
| L2 | Fix pattern? | Re-validate after await; version tokens; do I/O off critical assumptions |
| L3 | Diff vs GCD sync queue? | Sync queue won’t interleave that way but can deadlock on sync reentry |

**Provenance:** Learning-lab · core concurrency correctness

---

### Q6. What is `@MainActor` for? `(30–45s)`

**Answer points (frame first):**
- Isolate UI-affined work/state to main
- Hop with await from other contexts
- Don’t put heavy CPU on main
- Contrast with custom actor for non-UI stores

**Agenda opener:** “MainActor is isolation for UI-affined state…”

**Full spoken answer:**
> “@MainActor marks code that must run on the main actor — where UIKit and much of SwiftUI expect updates. ViewModels that own UI state often sit on MainActor so published updates are safe. I still offload heavy decoding or image work elsewhere and await back. A custom actor is better for non-UI shared mutable caches.”

**Common wrong answer:** “Put all app logic on MainActor because it’s safer.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | How hop to main? | await MainActor.run or call @MainActor method |
| L2 | Sync DispatchQueue.main.sync? | Avoid from async — deadlock/blocking risk |
| L3 | Default MainActor isolation? | Settings when enabled — not universal (see Q12/T8) |

**Provenance:** Learning-lab · UI isolation practice

---

### Q7. Sendable in one clear explanation? `(45–60s)`

**Answer points (frame first):**
- Safe to share across concurrency domains
- Value types Sendable **only if** stored props are Sendable
- Classes need care; `@unchecked` is a smell unless proven
- Prefer values across boundaries; isolate mutable refs

**Agenda opener:** “Sendable means a type can cross isolation domains without data races…”

**Full spoken answer:**
> “Sendable is the compiler’s contract that a value can be shared across concurrency domains safely. Structs aren’t magically Sendable — they are when all stored properties are Sendable. A struct holding a mutable class reference can still race. Classes usually need immutability, synchronization, or an actor. @unchecked Sendable opts out of checking; I only use it when I’ve proven the invariant, and for new shared mutability I prefer an actor.”

**Common wrong answer:** “All value types are Sendable; all classes aren’t.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Generic struct? | Sendable when parameters are constrained/proven Sendable |
| L2 | Why Swift 6 cares? | When enabled, crossings become errors under checking |
| L3 | UIKit types? | Often not Sendable — hop to MainActor instead of sending freely |

**Provenance:** Learning-lab · correctness emphasis

---

### Q8. `async let` vs `withTaskGroup`? `(45s)`

**Answer points (frame first):**
- async let: fixed small parallel set
- TaskGroup: dynamic N
- Both structured; cancel with parent
- Bound fan-out when N large

**Agenda opener:** “Both run children concurrently — the difference is fixed versus dynamic fan-out…”

**Full spoken answer:**
> “async let is ideal when I know a small fixed set of parallel children — details, showtimes, offers. TaskGroup is for dynamic N, like prefetching N poster URLs. Both stay structured under the parent. If N can be huge I talk about bounding concurrency so we don’t stampede the network.”

**Common wrong answer:** “Always use TaskGroup; async let is legacy.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Error handling? | Throwing group vs try await each async let |
| L2 | Unordered results? | Iterate group as children complete |
| L3 | vs DispatchGroup? | TaskGroup integrates cancellation/async; GCD group is callback-era |

**Provenance:** Learning-lab

---

### Q9. When is `Task.detached` appropriate? `(45s)`

**Answer points (frame first):**
- Rare
- Independent priority/lifetime; doesn’t inherit actor the same way
- Must pass Sendable state carefully
- Default should be structured or inheriting Task

**Agenda opener:** “Detached tasks are a sharp tool, not a default…”

**Full spoken answer:**
> “I use Task.detached rarely — when work must be independent of the caller’s actor isolation and lifetime, and I’m prepared to pass Sendable inputs explicitly. For UI-driven work I prefer Task that inherits context, with an explicit cancel path. Detached everywhere loses structure and makes MainActor hops easy to get wrong.”

**Common wrong answer:** “Detached is how you always do background work.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Priority? | Can set priority; still don’t starve UI carelessly |
| L2 | Inherit task-locals? | Detached doesn’t inherit the same way — know implications |
| L3 | Alternative? | nonisolated async functions + actor/MainActor hops |

**Provenance:** Learning-lab

---

### Q10. How do you replace callback URLSession with async? `(45–60s)`

**Answer points (frame first):**
- `try await session.data(for:)` / bytes APIs
- throws for failures
- Cancellation via Task with async APIs
- Still validate HTTP status / decode errors

**Agenda opener:** “Modern URLSession exposes async methods that suspend until the transfer finishes…”

**Full spoken answer:**
> “I’d use URLSession’s async data APIs with try await, validate the HTTP response, then decode. Errors surface through throws instead of optional error parameters. If this runs inside a Task, cancelling that Task participates in cancelling the async transfer. I still keep stale-response guards for higher-level flows like search where multiple generations exist.”

**Common wrong answer:** “Async URLSession means I never think about cancellation again.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Callback dataTask still? | Need explicit URLSessionTask.cancel + generation tokens |
| L2 | Progress? | bytes streams / delegates depending on need |
| L3 | Auth challenges? | Separate topic — don’t hand-wave; Week 2 networking day |

**Provenance:** Learning-lab · (S4 is URLSession migration but pinning day owns depth)

---

### Q11. Task priority / QoS — what do you say? `(45s)`

**Answer points (frame first):**
- Tasks have priorities; often inherit from parent
- Don’t run huge low-level work at user-interactive without need
- Avoid starving UI
- Bridge mindset from GCD QoS, not identical API

**Agenda opener:** “Priority influences scheduling — I inherit where possible and avoid elevating bulk work…”

**Full spoken answer:**
> “Tasks carry priority and often inherit from their parent, similar in spirit to caring about GCD QoS. Interactive UI work should stay responsive; bulk prefetch shouldn’t casually run at the highest priority. I set priority deliberately for true background work and avoid assuming the runtime will save me from doing heavy decoding on MainActor.”

**Common wrong answer:** “Priority doesn’t matter in async/await.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Inherit always? | Common case yes; detached/explicit overrides exist |
| L2 | Priority inversion? | Possible with locks/bridges — prefer async isolation |
| L3 | Energy? | Lower priority for deferrable work on mobile |

**Provenance:** Learning-lab

---

### Q12. Swift 6 / Approachable Concurrency / default MainActor — how do you phrase it? `(45–60s)`

**Answer points (frame first):**
- These are **settings / language modes when enabled**
- Not universal behavior of all Swift apps
- Concepts (isolation, Sendable) still matter regardless
- Verify target settings in real projects

**Agenda opener:** “I treat Swift 6 concurrency hardening as settings-dependent…”

**Full spoken answer:**
> “Under Swift 6 language mode and stricter concurrency checking when enabled, isolation and Sendable mistakes become harder to ignore. Approachable Concurrency and default MainActor isolation are also settings that can change defaults for a target — I don’t claim they apply to every codebase worldwide. In interviews I speak in concepts: isolation domains, Sendable, actors, cancellation — and I qualify defaults with ‘when enabled’ after checking build settings.”

**Common wrong answer:** “In Swift 6 everything is MainActor automatically everywhere.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | What still true without those settings? | Reentrancy, cancel, actor isolation concepts |
| L2 | Migration tip? | Turn checking on module-by-module; fix boundaries |
| L3 | UIKit legacy? | Expect annotations/hops; don’t force-fit Sendable |

**Provenance:** Learning-lab · toolchain humility

---

## Tricky questions

### T1. “There’s an await inside my actor method — can I still race?” `(90–120s)`

**Answer points (frame first):**
- No data race on isolated storage from outside concurrently
- Yes logic race: state may change across await (reentrancy)
- Example + mitigation
- Don’t claim actors eliminate all concurrency bugs

**Agenda opener:** “There’s a subtle distinction between data races and logic across suspension…”

**Full spoken answer:**
> “You won’t get a classic data race on the actor’s isolated properties from two tasks mutating them unsynchronized — the actor serializes that. But if your method awaits, another task can run on the actor first, so the assumptions you made before the await can be false afterward. That’s reentrancy. I treat every await inside an actor as a point where I must re-read flags, balances, generations, or whatever invariant I depend on. Actors move bugs from memory corruption toward logical races — still real bugs.”

**Common wrong answer / trap:** “Actor means no races ever inside a method.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Show a fix | Version token; re-check after await; minimize awaited critical sections |
| L2 | Compare GCD sync critical section | Sync section won’t interleave but can deadlock |
| L3 | Single-flight refresh? | Store in-flight Task/continuation on actor; await same flight; careful resume-once |

**Provenance:** Learning-lab · must-nail Day 05

---

### T2. `@unchecked Sendable` on a class with mutable state `(90s)`

**Answer points (frame first):**
- Silences compiler; doesn’t create safety
- Only if manually synchronized and proven
- Prefer actor for new code
- Interview smell if used casually

**Agenda opener:** “Unchecked Sendable is an assertion of safety, not a grant of safety…”

**Full spoken answer:**
> “If I mark a mutable class @unchecked Sendable, I’m telling the compiler not to prove thread safety. That’s only honest if I’ve synchronized every access — for example with an internal lock — and I can explain the invariant. Otherwise I’ve just hidden races. For greenfield shared mutability I’d use an actor instead of teaching the team to sprinkle unchecked. Unchecked belongs in narrow interop/legacy cases with documentation, not as a default escape hatch.”

**Common wrong answer / trap:** “Add @unchecked Sendable to silence Swift 6.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Immutable class? | let Sendable stored props can be Sendable without unchecked |
| L2 | Struct with class prop? | Still not safe — shared reference |
| L3 | Module boundaries? | Public APIs need careful annotation; send DTOs |

**Provenance:** Learning-lab

---

### T3. Task in ViewModel without cancellation (search) `(90–120s)`

**Answer points (frame first):**
- Stale responses / out-of-order UI
- Store Task; cancel on new query / deinit / onDisappear
- Debounce sleep + checkCancellation
- S3 verified hook

**Agenda opener:** “The bug isn’t starting a Task — it’s abandoning ownership…”

**Full spoken answer:**
> “If every keystroke starts a Task and none are cancelled, responses can complete out of order and older results win. In a Search ViewModel I keep a searchTask property, cancel it when the query changes, wait a debounce interval with a cancellable sleep, check cancellation, then fetch and publish on MainActor. CancellationError is expected. That’s aligned with BookMyShow search debounce work — cancellation is part of correct UX, not an optimization.”

**Common wrong answer / trap:** “Fire-and-forget is fine if the network layer is fast.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | weak self? | Avoid retaining cycles; MainActor VM still should cancel |
| L2 | Generation token too? | Yes as belt-and-suspenders with cancel |
| L3 | Structured alternative? | Harder at sync UI boundary; unstructured + cancel is normal |

**Provenance:** Verified · S3

---

### T4. Calling MainActor from an actor — will you deadlock like GCD? `(90s)`

**Answer points (frame first):**
- Different model from queue.sync deadlock
- await MainActor suspends; actor can reenter
- Still avoid sync main bridges / blocking
- Logical wait / priority issues possible

**Agenda opener:** “People map GCD deadlock instincts onto actors incorrectly…”

**Full spoken answer:**
> “With GCD, syncing onto the queue you’re already on deadlocks. Awaiting MainActor from a custom actor doesn’t work like that — your actor method suspends, which allows reentrancy, and MainActor work can proceed. You can still create poor designs: blocking with DispatchQueue.main.sync from thread-pool async code, or long circular waits that hurt responsiveness. I prefer async hops end-to-end and keep actor mutations short after returning from MainActor work.”

**Common wrong answer / trap:** “Never call MainActor from an actor or you’ll deadlock always.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | When hop needed? | Publishing UI state owned on MainActor |
| L2 | Reverse hop? | MainActor awaiting custom actor for cache lookup — fine if not blocking |
| L3 | Reentrancy angle? | While awaiting MainActor, other tasks may enter your actor |

**Provenance:** Learning-lab

---

### T5. GCD `sync` inside async contexts `(90s)`

**Answer points (frame first):**
- Can block cooperative pool threads
- Deadlock risk with main / same serial queue
- Prefer async primitives / continuations
- Mixed codebases need façades

**Agenda opener:** “The danger is blocking a thread the runtime expected to stay cooperative…”

**Full spoken answer:**
> “Swift concurrency multiplexes many tasks onto a thread pool. If async code calls DispatchQueue.sync and blocks, you can starve that pool and create hangs. Sync to main is especially sharp. In mixed codebases I wrap legacy queue APIs with async façades using continuations, resume exactly once, and avoid sync bridges from async paths. At BMS we still have GCD dictionary isolation — the lesson isn’t ‘sync everywhere,’ it’s ‘serialize at the boundary without blocking the world.’”

**Common wrong answer / trap:** “Feel free to mix sync GCD and await freely.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Continuation pitfalls? | Resume twice / never resume — hang or crash |
| L2 | When sync OK? | Tiny known contexts; not as async architecture spine |
| L3 | Actor instead? | Greenfield shared state — S2-A1 |

**Provenance:** Verified · S2 context · Learning-lab mixing guidance

---

### T6. Sendable across modules with public classes `(90–120s)`

**Answer points (frame first):**
- Public classes may not be Sendable
- Don’t force unchecked to push them through
- Send value DTOs; isolate references in actors
- Annotate APIs intentionally under checking when enabled

**Agenda opener:** “Module boundaries make Sendable a design problem, not a checkbox…”

**Full spoken answer:**
> “If a public class from another module isn’t Sendable, I shouldn’t paper over it with unchecked just to call an actor. Prefer converting to Sendable value DTOs at the boundary, or keep the reference inside an isolated domain and only expose async methods that return values. Under Swift 6 checking when enabled, these crossings surface as errors — which is good pressure to design boundaries. UIKit types are a classic example: hop to MainActor rather than pretending UIView is a free Sendable token.”

**Common wrong answer / trap:** “Ignore library types; only my models need Sendable.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Generic APIs? | Constrain to Sendable where crossing tasks |
| L2 | @MainActor class public? | Callers must await; document isolation |
| L3 | Binary frameworks? | May lack annotations — isolate usage |

**Provenance:** Learning-lab

---

### T7. Migrate SafeDict GCD → actor without big-bang `(90–120s)`

**Answer points (frame first):**
- S2 verified current; S2-A1 applied future
- Strangler: new maps on actor; stable leave alone
- Same API philosophy: hide storage, Sendable values
- Teach reentrancy during migration

**Agenda opener:** “I’d migrate by strangling boundaries, not boiling the ocean…”

**Full spoken answer:**
> “Production synchronised dictionaries at BookMyShow used GCD serial queues and a closed API — that fixed races on that path. For greenfield modules I’d introduce an actor SafeDict with get/set/snapshot and Sendable values, matching the safety philosophy. I wouldn’t rewrite every call site in one PR in a large consumer app. Feature teams adopt the actor at new touch points; legacy queues remain until modified. Training matters: engineers must learn that await inside the actor requires re-validation, or we trade data races for logic races.”

**Common wrong answer / trap:** “Actors are better, so rewrite the whole app’s dictionaries next sprint.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | API async impact? | Call sites become async — plan propagation |
| L2 | Testing? | Concurrency tests; stress under parallel tasks |
| L3 | Metrics? | Watch crash signatures for that path — don’t claim CFS ownership |

**Provenance:** Verified · S2 · How I would apply it · S2-A1

---

### T8. “Swift 6.2 Approachable Concurrency means I can stop thinking about MainActor.” `(90s)`

**Answer points (frame first):**
- Reject absolute claim
- Settings when enabled may ease defaults — still understand isolation
- Shared mutable non-UI state still needs actors/Sendable thought
- Humility about toolchain

**Agenda opener:** “Approachable Concurrency doesn’t delete isolation as a concept…”

**Full spoken answer:**
> “I wouldn’t stop thinking about MainActor. Approachable Concurrency and related defaults can change how much boilerplate a target needs when those settings are enabled, but they don’t remove the need to know where UI state lives, where shared mutable caches live, and how Sendable crossings work. I verify the project’s concurrency settings, write isolation explicitly at important boundaries, and still teach reentrancy and cancellation. Tooling can help adoption; it doesn’t replace concurrent design.”

**Common wrong answer / trap:** Treat Approachable Concurrency as universal automatic safety.

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | What do you check in Xcode? | Language mode / concurrency checking / default isolation settings for the target |
| L2 | Cross-module? | Settings may differ; don’t assume |
| L3 | Interview phrasing? | Always say ‘when enabled’ for defaults |

**Provenance:** Learning-lab · settings correctness

---

## Timed set suggestions

| Drill | Questions | Focus |
|---|---|---|
| Core 10 min | Q4, Q5, T1, T3 | Actor + cancel |
| Migration 8 min | Q1, T7, Q12 | S2 → S2-A1 + settings humility |
| Sendable 8 min | Q7, T2, T6 | Exact Sendable rules |
