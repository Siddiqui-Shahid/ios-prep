# Sample 04 — Production S1 / S10 (Q&A)

> Guided teaching. Separates **Verified** resume facts from **Learning-lab** demos and soft bridges so you never blur them in an interview.

---

### Q1. What can you claim under Verified · S1?

**Points to:** [Production bridge · §2 Verified · S1](../03-production-bridge.md#2-verified--s1--ads--herowidget-core) · [§1 Story map](../03-production-bridge.md#1-story-map-for-today)

**Answer:**

> The Ads module was highest-revenue and needed a safer, reusable rendering path. You refactored around **protocol** contracts and **generics** so the pipeline stayed **type-safe**. New ad types plugged in without forking the revenue path. You built reusable **HeroWidget** with explicit pause/play tied to visibility / view-controller lifecycle. Stakeholder coordination mattered on a revenue surface. Lesson: for revenue-critical UI, prefer POP + generics over inheritance trees; lifecycle is part of the product contract.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| ≤20s pitch? | “We made ad rendering a generic protocol pipeline so new creatives plugged in without forking the revenue path — and HeroWidget tied video playback to visibility.” |
| Architecture opener (5–10s)? | “I’ll walk through our highest-revenue Ads refactor — protocols, generics, and video lifecycle.” |
| Result (honest)? | Maintainable type-safe pipeline; lifecycle-correct video reduced wasted playback / UI glitches — no invented %. |

---

### Q2. What must you never invent for S1?

**Points to:** [Production bridge · What you must not invent](../03-production-bridge.md#what-you-must-not-invent)

**Answer:**

> Do not invent fill-rate percentages, revenue deltas, CTR, or exact crash rates for ads. Do not claim “we type-erased every renderer” unless personally true — prefer Learning-lab for erasure demos. Do not claim “every creative was a struct.” Do not invent team size, sprint counts, or App Store rankings.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Safe qualitative words? | Revenue-critical, maintainable, type-safe, fewer playback glitches. |
| Trade-off to volunteer? | Generics inside for safety; erase only at mixed list or module boundary — erasure isn’t free. |
| If asked for metrics you don’t have? | Stay qualitative; offer triage or architecture reasoning instead. |

---

### Q3. How do Day 02 concepts map to S1 interview lines?

**Points to:** [Production bridge · §3 Mapping concepts → S1](../03-production-bridge.md#3-mapping-concepts--s1-lines)

**Answer:**

> POP → capability composition + S1 pipeline contracts. Generics → compile-time safety vs `Any` casts. Associated-type pain → keep generic / erase at the edge (lab eraser if asked “how”). Inheritance vs POP → fragile base on ad variants. Video lifecycle → HeroWidget pause/play (class identity + protocol capability). `some`/`any` → prefer generics in hot bind. Extension dispatch → requirement vs default.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Asked “what is POP?” | Capability composition; support with S1 contracts. |
| Asked “why generics?” | Safety vs casts; revenue path correctness. |
| Asked about erasure? | Applied/lab how — don’t invent “we erased everything in production.” |

---

### Q4. What is the Verified · S10 soft bridge?

**Points to:** [Production bridge · §4 Stories SDK](../03-production-bridge.md#4-verified--s10--stories-sdk-soft-bridge) · [Deep dive · §10 SDK boundary](../02-deep-dive.md#10-sdk-boundary-lessons-s10-soft)

**Answer:**

> Stories SDK reused across a portfolio — reusable surfaces mattered. Same instinct: **contracts at the boundary**, concretes inside. Use S10 when asked about reusable module APIs — not as a replacement for S1 on ads-specific questions. Do not invent client counts or latency percentages.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| ≤20s bridge? | “Same POP instinct showed up later in a Stories SDK — reusable protocol-oriented surfaces across brands rather than copy-pasted concretes.” |
| Public API shape? | Protocols + carefully chosen value models — not a forest of concretes clients must subclass. |
| Provenance label? | Verified · S10 · Stories SDK portfolio reuse. |

---

### Q5. How do you talk about Learning-lab code honestly?

**Points to:** [Production bridge · §6 Learning-lab](../03-production-bridge.md#6-learning-lab--what-the-code-files-are) · [AdsPipeline.swift](../code/AdsPipeline.swift)

**Answer:**

> `AdsPipeline.swift` and `TypeErasureDemo.swift` are teaching sketches of the S1 shape and erasure mechanics — **not** shipped BMS source. If asked “Did you write it like this?” say: “This is the teaching shape of the contracts we used — protocol + generic pipeline. I’m not claiming this file is production source.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why keep lab files? | Practice speaking and Memory/type concepts without overclaiming. |
| Erasure in interview? | Prefer lab for “how erasure works”; don’t invent production erasure metrics. |
| Claim level table? | Pipeline = teaching shape of S1; eraser = mechanics demo. |

---

### Q6. Soft S3 / S3-A1 — when do you even mention it?

**Points to:** [Production bridge · §5 Soft S3](../03-production-bridge.md#5-soft--s3--s3-a1--open-registries)

**Answer:**

> Only if the interviewer pivots to SDUI / CMS components. Verified S3: backend-driven header; protocol-driven main screen. Applied S3-A1: unknown component fallback + versioning — say it is design, not a shipped Day 02 core claim. Do not let this hijack Day 02 — keep S1 as the spine.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One liner? | Open registry matches CMS growth better than a forever-closed enum — with explicit unknown fallback. |
| Closed enum when? | Stable small set; rare additions. |
| Link to deep dive? | Open vs closed component sets section. |

---

### Q7. What interview anti-patterns should you avoid?

**Points to:** [Production bridge · §7 Anti-patterns](../03-production-bridge.md#7-anti-patterns-in-interviews)

**Answer:**

> Inventing fill-rate %. Claiming POP means never use classes. Calling type erasure free. Diving into Generics Manifesto trivia. Skipping the agenda on architecture questions. Claiming actors/SwiftUI for S1 when that wasn’t the stack — stick to POP + generics + lifecycle.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Always agenda in 10s? | Yes on architecture questions. |
| HeroWidget contradiction? | Class for lifecycle; protocols for capabilities — not a contradiction. |
| Flash card company/feature? | BookMyShow — Ads module / HeroWidget. |

---

### Q8. Deliver a clean ≈90s Action slice (STAR) with honest labels

**Points to:** [Production bridge · Interview lines](../03-production-bridge.md#interview-lines) · [story-bank S1](../../../../stories/story-bank.md)

**Answer:**

> “The Ads module was highest-revenue and needed a safer reusable rendering path. I refactored rendering around protocol contracts and generics so the pipeline stayed type-safe as creatives grew — new types conformed and plugged in instead of forking bind code. Separately, video inside HeroWidget needed correct pause and play against visibility and view-controller lifecycle, so we made that lifecycle explicit on the widget. Stakeholder coordination mattered because behavior changes on a revenue surface aren’t casual. The result was a maintainable type-safe pipeline and fewer playback glitches on video creatives.”  
> Trade-off if asked: generics inside; erase only at mixed list or boundary.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Timing drills? | 20s pitch · 90s Action · ≤3 min full STAR · ≤5 min whiteboard. |
| S10 in same answer? | Only if asked about reusable SDKs — don’t replace S1. |
| After this sample? | Timed practice in [`../04-questions.md`](../04-questions.md); code walk in [`../code/`](../code/). |

---

## After this sample

1. Walk [`../code/AdsPipeline.swift`](../code/AdsPipeline.swift) and [`../code/TypeErasureDemo.swift`](../code/TypeErasureDemo.swift) aloud.
2. Speak from **Answer points** in [`../04-questions.md`](../04-questions.md).
3. Do drills in [`../05-exercises.md`](../05-exercises.md).
4. Optional: Day 03 sample for ARC / cycles — [`../../day-03/sample/`](../../day-03/sample/README.md).
