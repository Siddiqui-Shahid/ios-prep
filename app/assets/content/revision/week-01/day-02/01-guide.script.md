# Audio script — Revision guide — Protocols, POP, Generics, Associated Types, Type Erasure
> Listen-only revision day guide from `day-02.md`.

## §0 1. Outcome

Next. 1. Outcome. Explain aloud, in plain sentences: Protocol-oriented design vs inheritance for U I and ad pipelines Generics, associated types, and where clauses — who picks the concrete type When type erasure is worth it and what it costs at runtime.

## §1 2. Concept refresh (simple)

Next. 2. Concept refresh (simple). 2. Concept refresh (simple).

## §2 2.1 Protocol-Oriented Programming (POP)

Next. 2.1 Protocol-Oriented Programming (POP). Compose capabilities (Renderable, Trackable) with extensions. Inheritance models what you are; protocols model what you can do. Prefer P O P over deep class trees for ad units and S D U I variants.

## §3 2.2 Generics vs associated types

Next. 2.2 Generics vs associated types. Generics: the caller chooses T; compiler can specialize — best for pipelines. Associated type: the adopter chooses the concrete type — awkward in mixed arrays without help. Keep APIs generic: func install<R: AdRenderable>(_ r: R). Erase only at boundaries when you must mix shapes. Say “protocol with associated type” — not unexplained PAT letter-soup.

## §4 2.3 Type erasure

Next. 2.3 Type erasure. When you must store mixed adopters with different associated types, box behind one interface. Cost: allocation, indirection, lost specialization.

## §5 2.4 Dispatch trap

Next. 2.4 Dispatch trap. Extension-only methods may not override through an existential — promote to protocol requirements when behavior must vary.

## §6 2.5 Critical truths (pin)

Next. 2.5 Critical truths (pin). 2.5 Critical truths (pin).

## §7 3. Read these

Next. 3. Read these. 3. Read these.

## §8 4. Map to your work

Next. 4. Map to your work. BookMyShow Ads pipeline + HeroWidget lifecycle: BookMyShow Ads / HeroWidget — refactored highest-revenue module with P O P + generics for type-safe rendering; video pause/play lifecycle on HeroWidget. Stories S D K (Raw / Miami Heat): Stories S D K context — same P O P shape, separate story. Interview line (≤20s): “We made ad rendering a generic protocol pipeline so new creatives plugged in without forking the revenue path.” → BookMyShow Ads pipeline + HeroWidget lifecycle Ads · Stories S D K (Raw / Miami Heat) Stories S D K.

## §9 5. Flash prompts

Next. 5. Flash prompts. 1. P O P in one sentence + one capability example 2. Caller picks T vs adopter picks associated type 3. Why a mixed [AdRenderable] is awkward — four escape hatches 4. Extension-default dispatch trap through existential.

## §10 6. Timed drills

Next. 6. Timed drills. Expand from sample cards and 04-questions answer points.
