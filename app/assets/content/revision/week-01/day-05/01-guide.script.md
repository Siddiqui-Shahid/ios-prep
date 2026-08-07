# Audio script — Revision guide — async/await, Structured Concurrency, Actors, Sendable
> Listen-only revision day guide from `day-05.md`.

## §0 1. Outcome

Next. 1. Outcome. Explain aloud, in plain sentences: async/await as cooperative suspension — not “always background thread” Structured vs unstructured concurrency and cooperative cancellation Actor isolation, reentrancy at await, and @MainActor.

## §1 2. Concept refresh (simple)

Next. 2. Concept refresh (simple). 2. Concept refresh (simple).

## §2 2.1 async/await

Next. 2.1 async/await. await is a suspension point — the thread is freed cooperatively. Errors surface with throws; no callback pyramid.

## §3 2.2 Structured concurrency

Next. 2.2 Structured concurrency. Parent owns children; cancel and errors propagate. Prefer async let / withTaskGroup over detached fire-and-forget. Cancellation is cooperative — not preemptive thread killing. Check Task.isCancelled / try Task.checkCancellation().

## §4 2.3 Actors

Next. 2.3 Actors. Serialized access to mutable state; external callers await. Reentrancy: after await inside an actor method, other calls may have run — re-validate state, don’t assume continuity. @MainActor isolates U I-affined state to the main actor — not the same as “make every ViewModel an actor.”.

## §5 2.4 Sendable

Next. 2.4 Sendable. Types safe to share across concurrency domains. Value types are Sendable only if all stored properties are Sendable.

## §6 2.5 Critical truths (pin)

Next. 2.5 Critical truths (pin). 2.5 Critical truths (pin).

## §7 3. Read these

Next. 3. Read these. 3. Read these.

## §8 4. Map to your work

Next. 4. Map to your work. BookMyShow synchronised dictionaries: Production fix was G C D synchronised dictionaries — path-specific race elimination, not an org-wide actor rewrite. Design: actor SafeDict (not shipped): Greenfield — expose actor SafeDict with the same hidden-storage A P I. BookMyShow backend-driven header & search hook: Search debounce must cancel in-flight tasks on new keystroke — cooperative cancellation in practice. Interview line (≤20s): “Production fix was a serial-queue dictionary; greenfield I’d expose an actor with the same safe A P I surface.”.

## §9 5. Flash prompts

Next. 5. Flash prompts. 1. await in one sentence — suspension, not background magic 2. Structured vs unstructured Task — who owns cancellation 3. Cooperative cancellation — what it is not 4. Actor reentrancy after await — why re-check state.

## §10 6. Timed drills

Next. 6. Timed drills. Expand from sample cards, SafeDictActor.swift, and 04-questions.
