# Audio script — Revision guide — ARC, Retain Cycles, weak/unowned, Instruments
> Listen-only revision day guide from `day-03.md`.

## §0 1. Outcome

Next. 1. Outcome. Explain aloud, in plain sentences: How A R C works — strong, weak, unowned — and when deinit runs Classic retain-cycle patterns and the fix for each Leak vs abandoned memory vs high watermark — and which tool finds which.

## §1 2. Concept refresh (simple)

Next. 2. Concept refresh (simple). 2. Concept refresh (simple).

## §2 2.1 ARC basics

Next. 2.1 ARC basics. Strong refs increment retain count; at zero, deinit runs. weak is optional and zeroing; unowned is non-optional and non-zeroing — crash if dangling. Value types aren’t A R C’d; nested classes inside them are.

## §3 2.2 Cycle hotspots

Next. 2.2 Cycle hotspots. 2.2 Cycle hotspots.

## §4 2.3 Tools — don’t conflate them

Next. 2.3 Tools — don’t conflate them. At 30L+ daily active users, small leaks in navigation or ad paths become memory pressure and jetsam. 99.95%+ crash-free is the verified reliability bar (BookMyShow I M O C + crash-free at scale).

## §5 2.4 Critical truths (pin)

Next. 2.4 Critical truths (pin). 2.4 Critical truths (pin).

## §6 3. Read these

Next. 3. Read these. 3. Read these.

## §7 4. Map to your work

Next. 4. Map to your work. BookMyShow I M O C + crash-free at scale: BookMyShow I M O C / crash-free at scale — 30L+ daily active users, 99.95%+ crash-free via structured Crashlytics workflows; memory and race issues were part of reliability culture. Design if asked: Triage playbook (Memory Graph → Allocations → Leaks) — how you would investigate, not a claim you ran Memory Graph on every Book My Show leak. Interview line (≤20s): “At 30L+ daily active users we treated retain cycles and abandoned view controllers as reliability bugs — structured triage and Crashlytics, not guesswork.” → BookMyShow I M O C + crash-free at scale I M O C.

## §8 5. Flash prompts

Next. 5. Flash prompts. 1. A R C in 30s — retain count, deinit, not GC 2. weak vs unowned — when each, and the crash risk 3. Classic closure cycle — draw the strong edges 4. Timer target-selector retain rule.

## §9 6. Timed drills

Next. 6. Timed drills. Expand from sample cards and 04-questions answer points.
