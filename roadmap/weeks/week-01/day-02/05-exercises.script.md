# Audio script — 05 Exercises
> Listen-only audiobook of `05-exercises.md` (Day 02 — Protocols, POP, Generics, Associated Types, Type Erasure). Simple English. Basic explanations. Self-contained speech. Does not assume you are looking at a screen.


## §0 Introduction

Next. Introduction.

Do these after foundations + deep dive + production bridge. Prefer speaking out loud even for coding prompts.

## §1 Exercise 1 — Mini ads pipeline `(25–35 min)`

Next. Exercise 1 — Mini ads pipeline `(25–35 min)`.

Prompt: Using code/AdsPipeline.swift as a base (or rewrite from memory): Define Creative with associated type Body + AdTrackable. Implement ImageCreative (struct) and VideoCreative (class + PlaybackControllable). Implement AdPipeline<C: Creative & AdTrackable> with install() -> C.Body. Add bindPlayback generic constrained to PlaybackControllable. Agenda to say before coding (30s): “Capabilities first. Creative and Trackable. then a generic pipeline, then video-only playback composition.” Done when: You can explain why VideoCreative is a class. while ImageCreative is a struct. Stretch: Add CarouselCreative without touching AdPipeline’s body. only new conformance.

## §2 Exercise 2 — Type eraser `(20–30 min)`

Next. Exercise 2 — Type eraser `(20–30 min)`.

Prompt: Implement AnyTrackable as in code/TypeErasureDemo.swift. Store id + track closure. Build [AnyTrackable] with two concrete types. Speak costs in ≤30s. Speak (≤60s) after coding: When you’d erase vs keep generics on an ads feed. Honesty check: Label as Learning-lab. not shipped BMS source.

## §3 Exercise 3 — Extension dispatch surprise `(15–20 min)`

Next. Exercise 3 — Extension dispatch surprise `(15–20 min)`.

Prompt: Reproduce the greet/wave trap from deep dive §3.2 in a playground or scratch file. Write predicted output before running. Then fix by promoting wave to a protocol requirement. Speak (30s): “Requirements witness-dispatch. extension-only methods may bind statically.”.

## §4 Exercise 4 — HeroWidget lifecycle sketch `(20–25 min)`

Next. Exercise 4 — HeroWidget lifecycle sketch `(20–25 min)`.

Prompt: Here is a simple Swift example, explained in words. final class HeroWidget. // own a VideoCreative or player façade. // didEnterVisibleViewport / didLeaveVisibleViewport. What to remember: focus on the idea, not every symbol. Implement pause/play wiring. Conform to PlaybackControllable. Speak Verified · S1 Action slice in 90s tying widget to pipeline. Honesty check: No fill-rate %. Lifecycle-correct video is the claim.

## §5 Exercise 5 — Open vs closed registry `(20–25 min)`

Next. Exercise 5 — Open vs closed registry `(20–25 min)`.

Prompt: Sketch both: enum AdKind { case image. case video } switch renderer. AdRegistry with AdComponentFactory protocol and unknown fallback returning a placeholder. Speak (90s): Trade-offs. mention S3 soft + S3-A1 as design for unknown fallback.

## §6 Exercise 6 — Timed speaking drill `(30–40 min)`

Next. Exercise 6 — Timed speaking drill `(30–40 min)`.

Record: Q1 P O P Q4 generics in ads Q6 type erasure T1 protocol that has an associated. type array T5 YAGNI vs revenue Optional: 5 min S1 architecture dry-run. Score with../../../timing/answer-timing-guide.md: Check: Pass?. Agenda in first 10s. Trade-off mentioned. Production hook without invented metrics. Finished inside budget. Log misses. gotchas.

## §7 Exercise 7 — Stories SDK boundary `(15 min)`

Next. Exercise 7 — Stories S D K boundary `(15 min)`.

Prompt: Write 5 bullet A P I rules for a reusable Stories S D K surface (protocols vs. concretes, versioning, what not to expose). Speak ≤20s S10 bridge after writing. Provenance: Verified · S10 · portfolio reuse. no invented client counts.

## §8 Solutions pointers

Next. Solutions pointers.

Exercise: 1, 4: code/AdsPipeline.swift. 2: code/TypeErasureDemo.swift. 3: Deep dive §3.2. 5: Deep dive §6. 6: sample/07-revision-qna.md. 7: Production bridge §4.

## §9 Exit criteria

Next. Exit criteria.

You may mark Day 02 complete when you can, without notes: [ ] P O P one-liner +. capability example [ ] associated type vs generic parameter in 20s [ ] Type erasure cost in one. breath [ ] Extension dispatch trap named [ ] ≤20s S1 pitch + ≤5 min architecture talk once. [ ] Honest provenance (no fill-rate invention) Then use the revision twin:../../../revision/weeks/week-01/day-02.md.
