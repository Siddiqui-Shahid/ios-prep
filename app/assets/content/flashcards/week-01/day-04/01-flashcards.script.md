# Audio script — Flashcards — GCD Queues, sync/async, Barriers, Thread-Safe Dictionary
> Listen-only flashcard Q&A from `week-01.md`. Spoken answers.

## §0 Q1. Shared dict without sync

Next. Shared dict without sync? Answer. Data race — undefined behavior.

## §1 Q2. main.sync from main

Next. main.sync from main? Answer. Deadlock — same rule for any serial queue.

## §2 Q3. Async write + sync read

Next. Async write + sync read? Answer. May not see write until write runs — prefer sync set for read-after-write.

## §3 Q4. Hide the queue

Next. Hide the queue? Answer. Expose safe methods only — BookMyShow synchronised dictionaries lesson.

## §4 Q5. Barrier on concurrent queue

Next. Barrier on concurrent queue? Answer. Exclusive writer; plain reads may overlap.

## §5 Q6. · BookMyShow synchronised dictionaries

Next. · BookMyShow synchronised dictionaries? Answer. Path-specific race elimination on synchronised dictionaries.

## §6 Q7. Design: actor SafeDict (not shipped) actor

Next. Design: actor SafeDict (not shipped) actor? Answer. How I would apply it — not a claim you rewrote production.

## §7 Q8. Spell it

Next. Spell it? Answer. final class, never Final class.
