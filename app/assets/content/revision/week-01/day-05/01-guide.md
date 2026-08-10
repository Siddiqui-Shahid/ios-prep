# Day 05 — async/await, Structured Concurrency, Actors, Sendable

> Week 1 · Revision pass ~45–60 min  
> Full study: [weeks/week-01/day-05/](../../../weeks/week-01/day-05/README.md)  
> Sample Q&A (guided): [weeks/week-01/day-05/sample/](../../../weeks/week-01/day-05/sample/README.md)

## 1. Outcome

Explain aloud, in plain sentences:

- `async`/`await` as cooperative suspension — not “always background thread”
- Structured vs unstructured concurrency and cooperative cancellation
- Actor isolation, reentrancy at `await`, and `@MainActor`
- Sendable rules and the verified BookMyShow synchronised dictionaries vs applied Design: actor SafeDict (not shipped) migration pitch

## 2. Concept refresh (simple)

### 2.1 async/await

`await` is a **suspension point** — the thread is freed cooperatively. Errors surface with `throws`; no callback pyramid.

### 2.2 Structured concurrency

Parent owns children; cancel and errors propagate. Prefer `async let` / `withTaskGroup` over detached fire-and-forget.

| API | Use |
|---|---|
| `Task { }` | Bridge from sync UI boundary — you own lifetime |
| `async let` | Fixed parallel children |
| `withTaskGroup` | Dynamic fan-out |
| `Task.detached` | Rare — independent priority/lifetime |

**Cancellation is cooperative** — not preemptive thread killing. Check `Task.isCancelled` / `try Task.checkCancellation()`.

### 2.3 Actors

Serialized access to mutable state; external callers `await`. **Reentrancy:** after `await` inside an actor method, other calls may have run — re-validate state, don’t assume continuity.

`@MainActor` isolates UI-affined state to the main actor — not the same as “make every ViewModel an actor.”

### 2.4 Sendable

Types safe to share across concurrency domains. Value types are Sendable **only if** all stored properties are Sendable.

### 2.5 Critical truths (pin)

| Claim | Truth |
|---|---|
| `await` | Suspension point — **not** “always background thread” |
| Structured concurrency | Parent owns children; cancel and errors propagate |
| Unstructured `Task` | You own lifetime and cancellation (UI boundaries) |
| Cancellation | **Cooperative** — not preemptive |
| Actor | Prevents data races on isolated state — **reentrant at `await`** |
| Sendable | Value types Sendable **only if** stored properties are |
| BookMyShow synchronised dictionaries | GCD synchronised dictionaries at BMS — not org-wide actor rewrite |
| Design: actor SafeDict (not shipped) | Greenfield actor migration — **How I would apply it** |

## 3. Read these

| Priority | Resource | Why |
|---|---|---|
| Must | [Sample Q&A](../../../weeks/week-01/day-05/sample/) | Guided cards |
| Must | Full modules [01–03](../../../weeks/week-01/day-05/01-foundations.md) | Gaps |
| Drill | [07-revision-qna](../../../weeks/week-01/day-05/sample/07-revision-qna.md) | Timed answers |

## 4. Map to your work

**BookMyShow synchronised dictionaries:** Production fix was GCD synchronised dictionaries — path-specific race elimination, not an org-wide actor rewrite.  
**Design: actor SafeDict (not shipped):** Greenfield — expose `actor SafeDict` with the same hidden-storage API.  
**BookMyShow backend-driven header & search hook:** Search debounce must cancel in-flight tasks on new keystroke — cooperative cancellation in practice.

**Interview line (≤20s):** “Production fix was a serial-queue dictionary; greenfield I’d expose an actor with the same safe API surface.”

→ [BookMyShow synchronised dictionaries](../../stories/story-bank.md#s2--synchronised-dictionaries-bookmyshow) · [BookMyShow backend-driven header & search Search](../../stories/story-bank.md#s3--backend-driven-header--search-bookmyshow)

## 5. Flash prompts

1. `await` in one sentence — suspension, not background magic
2. Structured vs unstructured Task — who owns cancellation
3. Cooperative cancellation — what it is not
4. Actor reentrancy after `await` — why re-check state
5. `@MainActor` vs general actor — UI affinity
6. Sendable rule for structs with stored properties
7. BookMyShow synchronised dictionaries vs Design: actor SafeDict (not shipped) — production GCD vs applied actor pitch
8. BookMyShow backend-driven header & search debounce — cancel in-flight work on new input

## 6. Timed drills

| Drill | Budget |
|---|---|
| async/await vs GCD | 60s |
| actor reentrancy scenario | 90s |
| Task cancellation (BookMyShow backend-driven header & search debounce) | 60s |
| BookMyShow synchronised dictionaries → actor migration pitch | 90s |

Expand from [sample cards](../../../weeks/week-01/day-05/sample/), [SafeDictActor.swift](../../../weeks/week-01/day-05/code/SafeDictActor.swift), and [07-revision-qna](../../../weeks/week-01/day-05/sample/07-revision-qna.md).
