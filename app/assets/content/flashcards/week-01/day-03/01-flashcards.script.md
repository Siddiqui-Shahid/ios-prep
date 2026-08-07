# Audio script — Flashcards — ARC, Retain Cycles, weak/unowned, Instruments
> Listen-only flashcard Q&A from `week-01.md`. Spoken answers.

## §0 Q1. Retain cycle

Next. Retain cycle? Answer. Reachable abandoned memory.

## §1 Q2. Instruments Leaks

Next. Instruments Leaks? Answer. Finds unreachable memory — not cycles.

## §2 Q3. Timer target:selector:

Next. Timer target:selector:? Answer. Timer strongly retains the target until invalidate.

## §3 Q4. NotificationCenter block API

Next. NotificationCenter block A P I? Answer. Store the observer token and remove on teardown.

## §4 Q5. Uncertain lifetime (async UI)

Next. Uncertain lifetime (async U I)? Answer. Prefer [weak self].

## §5 Q6. BookMyShow IMOC + crash-free at scale

Next. BookMyShow I M O C + crash-free at scale? Answer. Reliability culture — do not invent a Book My Show Memory Graph war story.
