# Audio script — Flashcards — Value vs Reference, COW, Enums, Actors Intro
> Listen-only flashcard Q&A from `week-01.md`. Spoken answers.

## §0 Q1. Value vs reference

Next. Value vs reference? Answer. Structs copy snapshots; classes share identity on the heap.

## §1 Q2. let vs var

Next. let vs var? Answer. Controls binding mutability — not the same as value vs reference.

## §2 Q3. COW

Next. copy on write? Answer. Share buffer until write; then copy if not uniquely referenced.

## §3 Q4. Enum state

Next. Enum state? Answer. Impossible combinations become compile errors, not runtime bugs.

## §4 Q5. Actor intro

Next. Actor intro? Answer. Isolated reference type; await to touch state — not “replace all classes”.

## §5 Q6. BookMyShow Ads pipeline + HeroWidget lifecycle

Next. BookMyShow Ads pipeline + HeroWidget lifecycle? Answer. Type-safe ads pipeline + HeroWidget lifecycle — no invented fill-rate %.

## §6 Q7. BookMyShow payment processing-status popup

Next. BookMyShow payment processing-status popup? Answer. Processing popup with explicit status — no invented drop-off %.

## §7 Q8. Design: payment status pattern (not shipped) / Design: actor SafeDict (not shipped)

Next. Design: payment status pattern (not shipped) / Design: actor SafeDict (not shipped)? Answer. How I would apply it — design patterns, not shipped claims.
