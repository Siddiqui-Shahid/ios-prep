# Audio script — Flashcards — async/await, Structured Concurrency, Actors, Sendable
> Listen-only flashcard Q&A from `week-01.md`. Spoken answers.

## §0 Q1. await

Next. await? Answer. Suspension point — not “always background thread”.

## §1 Q2. Structured concurrency

Next. Structured concurrency? Answer. Parent owns children; cancel and errors can propagate.

## §2 Q3. Unstructured Task

Next. Unstructured Task? Answer. You own lifetime and cancellation (U I boundaries).

## §3 Q4. Cancellation

Next. Cancellation? Answer. Cooperative — not preemptive thread killing.

## §4 Q5. Actor

Next. Actor? Answer. Prevents data races on isolated state — reentrant at await.

## §5 Q6. Sendable

Next. Sendable? Answer. Value types are Sendable only if stored properties are.

## §6 Q7. BookMyShow synchronised dictionaries

Next. BookMyShow synchronised dictionaries? Answer. G C D synchronised dictionaries at Book My Show — not org-wide actor rewrite.

## §7 Q8. Design: actor SafeDict (not shipped)

Next. Design: actor SafeDict (not shipped)? Answer. Greenfield actor migration — How I would apply it.
