# Audio script — Revision guide — Value vs Reference, COW, Enums, Actors Intro
> Listen-only revision day guide from `day-01.md`.

## §0 1. Outcome

Next. 1. Outcome. Explain aloud, in plain sentences: When to pick struct, class, enum, or actor — and what breaks if you choose wrong Copy-on-write: cheap share until write; when a real buffer copy happens Associated-value enums as state machines that eliminate impossible U I states.

## §1 2. Concept refresh (simple)

Next. 2. Concept refresh (simple). 2. Concept refresh (simple).

## §2 2.1 Value vs reference

Next. 2.1 Value vs reference. Structs and enums copy snapshots; classes share identity on the heap. let vs var controls the binding — not the same question as value vs reference.

## §3 2.2 Copy-on-write (COW)

Next. 2.2 Copy-on-write (COW). Array, String, Dictionary, Set share a buffer until a mutation needs a unique copy. Assigning is cheap; mutating may copy if not uniquely referenced.

## §4 2.3 Enums as state machines

Next. 2.3 Enums as state machines. Associated values + exhaustive switch turn “isLoading + optional error + optional data” into one legal state at a time.

## §5 2.4 Actors (intro)

Next. 2.4 Actors (intro). An actor is a reference type with isolated mutable state — callers await to touch it. Not a drop-in replacement for every class; Day 05 deepens.

## §6 2.5 Critical truths (pin)

Next. 2.5 Critical truths (pin). 2.5 Critical truths (pin).

## §7 3. Read these

Next. 3. Read these. 3. Read these.

## §8 4. Map to your work

Next. 4. Map to your work. BookMyShow Ads pipeline + HeroWidget lifecycle: BookMyShow Ads — value-friendly render models in a type-safe pipeline; HeroWidget video pause/play lifecycle. BookMyShow payment processing-status popup: Payment processing popup modeled as explicit states, not boolean flags. Design: payment status pattern (not shipped) / Design: actor SafeDict (not shipped): How you would extend enum-state or actor patterns — not shipped claims. Interview line (≤20s): “I default to structs for ad and listing models so accidental shared mutation can’t corrupt revenue U I; classes and actors only at identity or concurrency boundaries.”.

## §9 5. Flash prompts

Next. 5. Flash prompts. 1. Struct vs class in one sentence + one Book My Show example 2. let vs var vs value vs reference — keep them separate 3. copy on write in one breath: when does a real copy happen? 4. Why enums beat isLoading + optional flags for payment U I.

## §10 6. Timed drills

Next. 6. Timed drills. Expand from sample cards and 04-questions answer points.
