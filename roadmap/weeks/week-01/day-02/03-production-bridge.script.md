# Audio script — 03 Production Bridge
> Listen-only audiobook of `03-production-bridge.md` (Day 02 — Protocols, POP, Generics, Associated Types, Type Erasure). Simple English. Basic explanations. Self-contained speech. Does not assume you are looking at a screen.


## §0 Introduction

Next. Introduction.

Turn Day 02 ideas into honest interview lines. Labels: Verified = resume-backed · How I would apply it = design extension · Learning-lab = demo code.

## §1 1. Story map for today

Next. 1. Story map for today.

Concept: Story, Label. P O P + generics type-safe ads pipeline: Ads module refactor, Verified · S1. Video pause/play tied to visibility: HeroWidget, Verified · S1. Reusable protocol APIs at S D K boundary: Stories S D K, Verified · S10. Protocol-driven header / open components: Backend-driven header, Verified · S3 (soft). Unknown component fallback: S D U I versioning design, How I would apply it · S3-A1 (soft). Mini pipeline / eraser demos: Local snippets, Learning-lab. Full STAR:../../../stories/story-bank.md (S1, S10. S3 optional).

## §2 2. Verified · S1 — Ads / HeroWidget (core)

Next. 2. Verified · S1 — Ads / HeroWidget (core).

What you can say (safe) The Ads module was highest-revenue and needed a safer, reusable rendering path. You refactored around protocol contracts and generics so the pipeline stayed type-safe. New ad types plugged into the pipeline instead of forking the revenue path. You built reusable HeroWidget with explicit pause/play tied to visibility / view-controller lifecycle. Stakeholder coordination mattered because behavior changes on a revenue surface are not casual. Lesson: for revenue-critical U I, prefer P O P + generics over inheritance trees. lifecycle is part of the product contract. What you must not invent Fill-rate percentages, revenue deltas, CTR. exact crash rates for ads “We type-erased every renderer” (unless personally true. prefer Learning-lab for erasure demos) “Every creative was a struct” Fake team size. sprint counts, or App Store rankings Interview lines ≤20s pitch: “We made ad rendering a generic protocol pipeline. so new creatives plugged in without forking the revenue path. and HeroWidget tied video playback to visibility.” Architecture talk opener (5. 10s): “I’ll walk through our highest-revenue Ads refactor. protocols, generics, and video lifecycle.” ≈90s Action slice (STAR): “The Ads module was highest-revenue and. needed a safer reusable rendering path. I refactored rendering around protocol contracts and generics so the pipeline stayed type-safe as creatives grew. new types conformed and plugged in instead of forking bind code. Separately, video inside HeroWidget needed correct pause and play against visibility and. view-controller lifecycle, so we made that lifecycle explicit on the widget. Stakeholder coordination mattered because behavior changes on a revenue surface aren’t casual. The result was a maintainable type-safe pipeline and fewer playback glitches on video creatives.” Result (honest): “Shipped a. maintainable, type-safe ads pipeline. lifecycle-correct video reduced wasted playback and U I glitches on a module that mattered for revenue.” Trade-off to. volunteer: “Generics inside the pipeline for safety and specialization. I’d only type-erase at a mixed list or module boundary. erasure isn’t free.” Provenance: Verified · S1 · BookMyShow · Ads P O P + Generics / HeroWidget.

## §3 3. Mapping concepts → S1 lines

Next. 3. Mapping concepts → S1 lines.

If they ask…: Lead with…, Support with…. What is P O P?: Capability composition, S1 pipeline contracts. Why generics?: Compile-time safety vs Any casts, Revenue path correctness. Associated-type pain: Keep generic / erase at the edge, Learning-lab eraser if asked “how”. Inheritance vs P O P: Fragile base on ad variants, S1 lesson line. Video lifecycle: HeroWidget pause/play, Class identity + protocol capability. some vs any: Opaque vs existential, Prefer generics in hot bind. Extension dispatch: Requirement vs default, Shared track defaults.

## §4 4. Verified · S10 — Stories SDK soft bridge

Next. 4. Verified · S10 — Stories S D K soft bridge.

What you can say (safe) Built a Stories S D K reused across a portfolio of apps Reusable. surfaces / modularity mattered Same instinct: contracts at the boundary. concretes inside What you must not invent Number of client apps as a precise metric unless you know. it Latency / engagement % for stories ≤20s bridge: “Same P O P instinct showed up later in. a Stories S D K. reusable protocol-oriented surfaces across brands rather than copy-pasted concretes.” Provenance: Verified · S10 · Raw / Miami Heat. · Stories S D K portfolio reuse Use S10 when asked “Have you designed reusable module APIs?”. not as a replacement for S1 on ads-specific questions.

## §5 5. Soft · S3 / S3-A1 — open registries

Next. 5. Soft · S3 / S3-A1 — open registries.

Only if the interviewer pivots to S D U I / CMS components: Verified · S3: backend-driven header. generalised protocol-driven main-screen implementation. Applied · S3-A1: how you’d handle unknown component types (fallback + versioning). say it is design, not a shipped claim. One liner: “An open protocol registry matches CMS growth better than a forever-closed enum. with an explicit unknown fallback. That’s the design I’d apply for versioning (S3-A1). the shipped header work was protocol-driven (S3).” Do not let this hijack Day 02. keep S1 as the spine.

## §6 6. Learning-lab — what the code files are

Next. 6. Learning-lab — what the code files are.

File: Claim level. code/AdsPipeline.swift: Teaching sketch of S1 shape. not shipped BMS source. code/TypeErasureDemo.swift: Erasure mechanics demo. If asked “Did you write it like this?”: “This is the teaching shape of the contracts we used. protocol + generic pipeline. I’m not claiming this file is production source.”.

## §7 7. Anti-patterns in interviews

Next. 7. Anti-patterns in interviews.

Anti-pattern: Fix. Inventing fill-rate %: Qualitative: revenue-critical, maintainable, type-safe. “P O P means never use classes”: HeroWidget is a class. capabilities are protocols. “Type erasure is free abstraction”: Name allocation + lost specialization. Diving into Generics Manifesto trivia: Stay: safety. pipeline. lifecycle. trade-off. Skipping agenda on architecture Q: Always agenda in 10s. Claiming actors/Swift U I for S1: Don’t invent stack. stick to P O P + generics + lifecycle.

## §8 8. Flash “map to your work” card

Next. 8. Flash “map to your work” card.

Company / feature: BookMyShow. Ads module / HeroWidget What you did: Refactored highest-revenue module with P O P + Generics for type-safe. rendering. video pause/play lifecycle on HeroWidget. Interview line (≤20s): “We made ad rendering a generic protocol pipeline so. new creatives plugged in without forking the revenue path.”. STAR: S1 · optional S10.

## §9 9. Timed story drills

Next. 9. Timed story drills.

Drill: Budget, Pass bar. S1 ≤20s pitch: 20s, Protocols + generics + HeroWidget. S1 Action only: 90s, No invented metrics. trade-off optional. Full S1 STAR: ≤3 min, Agenda + result + lesson. Architecture dry-run: ≤5 min, Whiteboard flow from deep dive §11. S10 bridge: 20s, Boundary protocols. no fake numbers.

## §10 Next

Next. Next.

Drill spoken answers in 04-questions.md. Speak from Answer points first. then compare to Full spoken answer.
