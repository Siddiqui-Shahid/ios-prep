# Day 05 — async/await, Structured Concurrency, Tasks, Actors, Sendable

> Week 1 · Phase: Modern concurrency · Time budget today: ~4–5 hrs

## 1. Outcome

Explain aloud:

- async/await vs GCD callbacks; structured concurrency benefits
- Task, TaskGroup, cancellation propagation
- Actor isolation, reentrancy, `@MainActor`
- Sendable and why Swift 6 cares
- How you’d migrate BMS synchronised dictionaries toward an actor

## 2. Concept deep dive

### 2.1 async/await

Suspends without blocking a thread (cooperatively). Replace callback pyramids; surface errors with `throws`.

### 2.2 Structured concurrency

Parent task owns children; cancellation and errors propagate. Prefer `async let` / `withTaskGroup` over detached fire-and-forget.

| API | Use |
|---|---|
| `Task { }` | Unstructured bridge from sync |
| `Task.detached` | Rare — independent priority/lifetime |
| `async let` | Fixed parallel children |
| `withTaskGroup` | Dynamic fan-out |

### 2.3 Actors

Serialized access to mutable state. Methods are `async` from outside. **Reentrancy:** after `await` inside actor, state may change — don’t assume continuity across awaits.

### 2.4 Sendable

Types safe to share across concurrency domains. Value types usually Sendable; classes need care (`@unchecked Sendable` is a smell unless proven).

### 2.5 Trade-offs

| Choice | When | Cost |
|---|---|---|
| Actor for shared dict | New shared mutable state | Migration; API async |
| Keep GCD serial | Legacy stable module | Dual models in app |
| `@MainActor` VM | UI state | Don’t do heavy work on main |
| Detached tasks | Truly independent | Lose structure |

## 3. Read these

| Priority | Resource | Why |
|---|---|---|
| Must | [Concurrency](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/concurrency/) | Full mental model |
| Must | WWDC: Meet async/await in Swift; Protect mutable state with Swift actors | Visual intuition |
| Deepen | [Sendable](https://developer.apple.com/documentation/swift/sendable) | Swift 6 readiness |
| Repo | Social feed HLD section — note async image/pipeline | [social-feed.md](../../../ios-system-design/docs/social-feed.md) |

## 4. Map to your work

**Company / feature:** BookMyShow — shared async state / sync dictionaries  
**What you did:** Fixed races with GCD; interview narrative includes modern equivalent.  
**Interview line (≤20s):** “Production fix was a serial-queue dictionary; greenfield I’d expose an actor with the same safe API surface.”

→ [S2](../../stories/story-bank.md#s2--synchronised-dictionaries-bookmyshow) · search debounce tasks [S3](../../stories/story-bank.md#s3--backend-driven-header--search-bookmyshow)

## 5. Normal questions

### Q1. async/await vs GCD? `(45–60s)`
**Skeleton:** Syntax + structured cancel/errors vs queues; both schedule work.  

### Q2. What is structured concurrency? `(45s)`
**Skeleton:** Hierarchy of tasks; cancel propagates.  

### Q3. How does Task cancellation work? `(60s)`
**Skeleton:** Cooperative — check `Task.isCancelled` / `try Task.checkCancellation()`.  

### Q4. Actor vs class + lock? `(60s)`
**Skeleton:** Compiler-enforced isolation vs manual.  
**Story:** S2 migration pitch.

### Q5. What is actor reentrancy? `(60–90s)`
**Skeleton:** Await suspends; other calls may run; re-validate state.  

### Q6. `@MainActor` purpose? `(30–45s)`
**Skeleton:** Isolate UI-affined state to main.  

### Q7. Sendable in one sentence? `(30s)`
**Skeleton:** Safe to share across concurrency domains.  

### Q8. `async let` vs TaskGroup? `(45s)`
**Skeleton:** Fixed vs dynamic number of children.  

### Q9. When Task.detached? `(45s)`
**Skeleton:** Rare independent work; usually avoid.  

### Q10. Replace callback URLSession with async? `(45s)`
**Skeleton:** `await session.data(for:)`; cancel via Task.  

### Q11. Priority / QoS with Tasks? `(45s)`
**Skeleton:** Task priority; inherit from parent; avoid starving UI.  

## 6. Tricky questions

### T1. Race across await inside actor method `(120s)`
**Trap:** “Actor means no races ever inside method.”  
**Senior answer:** Reentrancy — after await, fields may have changed; use local lets / re-check invariants.

### T2. `@unchecked Sendable` on a class with mutable state `(90s)`
**Trap:** Silence the compiler.  
**Senior answer:** Only if you manually synchronize; prefer actor.

### T3. Starting Task in ViewModel without cancellation `(90s)`
**Trap:** Fire-and-forget search.  
**Senior answer:** Store task; cancel on new keystroke / deinit — BMS search debounce.

### T4. Calling MainActor from actor — deadlock myths `(90s)`
**Trap:** Actors deadlock like queues.  
**Senior answer:** Different model; can still create logical waits; avoid sync bridges.

### T5. GCD sync inside async context `(90s)`
**Trap:** Mix freely.  
**Senior answer:** Can block thread pools; prefer async primitives end-to-end.

### T6. Sendable across module boundaries with public classes `(120s)`
**Trap:** Ignore library types.  
**Senior answer:** Annotate carefully; send values across; isolate references inside actors.

## 7. Flashcards for today

| Front | Back |
|---|---|
| Structured concurrency | Parent owns children · Trap: detached everywhere · Prod: search tasks |
| Actor | Isolated mutable state · Trap: no reentrancy · Prod: S2 future |
| Reentrancy | State may change after await · Trap: assume continuity · Prod: token refresh |
| Sendable | Cross-domain safe · Trap: @unchecked casually · Prod: Swift 6 |
| @MainActor | UI isolation · Trap: heavy work on main · Prod: VM |
| Task cancel | Cooperative · Trap: kill thread · Prod: debounce |
| async let | Fixed parallel · Trap: unbounded fanout · Prod: dual fetch |
| TaskGroup | Dynamic parallel · Trap: forget await all · Prod: prefetch |
| async vs GCD | Await + structure · Trap: throw GCD away blindly · Prod: mixed codebase |
| Detached | Independent lifetime · Trap: default choice · Prod: rare |
| Hop to main | await MainActor · Trap: sync main · Prod: bind UI |
| Migration pitch | Queue dict → actor · Trap: big-bang rewrite · Prod: S2 |

## 8. Practice

- **Coding:** Implement `actor SafeDict<Key: Hashable, Value: Sendable>` with get/set. Compare API to Day 04 GCD version.
- **SD:** Social feed HLD — list 4 client layers + where TaskGroup prefetch fits.

## 9. Timed drill

1. Q4, Q5, T1, T3 — record.
2. 90s answer: “How would you migrate synchronised dictionaries to actors?”
3. Score; gotchas.
