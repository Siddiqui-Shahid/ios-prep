# Sample 04 — BookMyShow Ads pipeline + HeroWidget (Q&A)

> Guided teaching. Separates **shipped** named cases from **design-if-asked** and **lab-only** so you never blur them in an interview.

---

### Q1. What can you claim under BookMyShow Ads pipeline + HeroWidget lifecycle?

**Answer:**

> The Ads module was highest-revenue and needed a safer, reusable rendering path. You refactored around **protocol** contracts and **generics** so the pipeline stayed **type-safe**. New ad types plugged in without forking the revenue path. You built reusable **HeroWidget** with explicit pause/play tied to visibility / view-controller lifecycle. Stakeholder coordination mattered on a revenue surface. Lesson: for revenue-critical UI, prefer POP + generics over inheritance trees; lifecycle is part of the product contract.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| ≤20s pitch? | “We made ad rendering a generic protocol pipeline so new creatives plugged in without forking the revenue path — and HeroWidget tied video playback to visibility.” |
| Architecture opener (5–10s)? | “I’ll walk through our highest-revenue Ads refactor — protocols, generics, and video lifecycle.” |
| Result (honest)? | Maintainable type-safe pipeline; lifecycle-correct video reduced wasted playback / UI glitches — no invented %. |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

---

### Q2. What must you never invent for BookMyShow Ads pipeline + HeroWidget lifecycle?

**Answer:**

> Do not invent fill-rate percentages, revenue deltas, CTR, or exact crash rates for ads. Do not claim “we type-erased every renderer” unless personally true — prefer Learning-lab for erasure demos. Do not claim “every creative was a struct.” Do not invent team size, sprint counts, or App Store rankings.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Safe qualitative words? | Revenue-critical, maintainable, type-safe, fewer playback glitches. |
| Trade-off to volunteer? | Generics inside for safety; erase only at mixed list or module boundary — erasure isn’t free. |
| If asked for metrics you don’t have? | Stay qualitative; offer triage or architecture reasoning instead. |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

---

### Q3. How do Day 02 concepts map to BookMyShow Ads pipeline + HeroWidget lifecycle interview lines?

**Answer:**

> POP → capability composition + BookMyShow Ads pipeline + HeroWidget lifecycle pipeline contracts. Generics → compile-time safety vs `Any` casts. Associated-type pain → keep generic / erase at the edge (lab eraser if asked “how”). Inheritance vs POP → fragile base on ad variants. Video lifecycle → HeroWidget pause/play (class identity + protocol capability). `some`/`any` → prefer generics in hot bind. Extension dispatch → requirement vs default.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Asked “what is POP?” | Capability composition; support with BookMyShow Ads pipeline + HeroWidget lifecycle contracts. |
| Asked “why generics?” | Safety vs casts; revenue path correctness. |
| Asked about erasure? | Applied/lab how — don’t invent “we erased everything in production.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

---

### Q4. What is the Stories SDK (Raw / Miami Heat) soft bridge?

**Answer:**

> Stories SDK reused across a portfolio — reusable surfaces mattered. Same instinct: **contracts at the boundary**, concretes inside. Use Stories SDK (Raw / Miami Heat) when asked about reusable module APIs — not as a replacement for BookMyShow Ads pipeline + HeroWidget lifecycle on ads-specific questions. Do not invent client counts or latency percentages.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| ≤20s bridge? | “Same POP instinct showed up later in a Stories SDK — reusable protocol-oriented surfaces across brands rather than copy-pasted concretes.” |
| Public API shape? | Protocols + carefully chosen value models — not a forest of concretes clients must subclass. |
| Named-case label? | Stories SDK (Raw / Miami Heat) · Stories SDK portfolio reuse. |

**How can I relate to my case:**
- **Shipped:** Stories SDK (Raw / Miami Heat); BookMyShow Ads pipeline + HeroWidget lifecycle
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

---

### Q5. How do you talk about Learning-lab code honestly?

**Answer:**

> `AdsPipeline.swift` and `TypeErasureDemo.swift` are teaching sketches of the BookMyShow Ads pipeline + HeroWidget lifecycle shape and erasure mechanics — **not** shipped BMS source. If asked “Did you write it like this?” say: “This is the teaching shape of the contracts we used — protocol + generic pipeline. I’m not claiming this file is production source.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why keep lab files? | Practice speaking and Memory/type concepts without overclaiming. |
| Erasure in interview? | Prefer lab for “how erasure works”; don’t invent production erasure metrics. |
| Claim level table? | Pipeline = teaching shape of BookMyShow Ads pipeline + HeroWidget lifecycle; eraser = mechanics demo. |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

---

### Q6. Soft BookMyShow backend-driven header & search / BookMyShow backend-driven header & search-A1 — when do you even mention it?

**Answer:**

> Only if the interviewer pivots to SDUI / CMS components. BookMyShow backend-driven header & search: backend-driven header; protocol-driven main screen. Applied BookMyShow backend-driven header & search-A1: unknown component fallback + versioning — say it is design, not a shipped Day 02 core claim. Do not let this hijack Day 02 — keep BookMyShow Ads pipeline + HeroWidget lifecycle as the spine.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One liner? | Open registry matches CMS growth better than a forever-closed enum — with explicit unknown fallback. |
| Closed enum when? | Stable small set; rare additions. |
| Link to deep dive? | Open vs closed component sets section. |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle; BookMyShow backend-driven header & search
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

---

### Q7. What interview anti-patterns should you avoid?

**Answer:**

> Inventing fill-rate %. Claiming POP means never use classes. Calling type erasure free. Diving into Generics Manifesto trivia. Skipping the agenda on architecture questions. Claiming actors/SwiftUI for BookMyShow Ads pipeline + HeroWidget lifecycle when that wasn’t the stack — stick to POP + generics + lifecycle.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Always agenda in 10s? | Yes on architecture questions. |
| HeroWidget contradiction? | Class for lifecycle; protocols for capabilities — not a contradiction. |
| Flash card company/feature? | BookMyShow — Ads module / HeroWidget. |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

---

### Q8. Deliver a clean ≈90s Action slice (STAR) with honest labels

**Answer:**

> “The Ads module was highest-revenue and needed a safer reusable rendering path. I refactored rendering around protocol contracts and generics so the pipeline stayed type-safe as creatives grew — new types conformed and plugged in instead of forking bind code. Separately, video inside HeroWidget needed correct pause and play against visibility and view-controller lifecycle, so we made that lifecycle explicit on the widget. Stakeholder coordination mattered because behavior changes on a revenue surface aren’t casual. The result was a maintainable type-safe pipeline and fewer playback glitches on video creatives.”  
> Trade-off if asked: generics inside; erase only at mixed list or boundary.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Timing drills? | 20s pitch · 90s Action · ≤3 min full STAR · ≤5 min whiteboard. |
| Stories SDK (Raw / Miami Heat) in same answer? | Only if asked about reusable SDKs — don’t replace BookMyShow Ads pipeline + HeroWidget lifecycle. |
| After this sample? | Timed practice in [`../04-questions.md`](../04-questions.md); code walk in [`../code/`](../code/). |

**How can I relate to my case:**
- **Shipped:** Stories SDK (Raw / Miami Heat); BookMyShow Ads pipeline + HeroWidget lifecycle
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

## After this sample

1. Walk [`../code/AdsPipeline.swift`](../code/AdsPipeline.swift) and [`../code/TypeErasureDemo.swift`](../code/TypeErasureDemo.swift) aloud.
2. Speak from **Answer points** in [`../04-questions.md`](../04-questions.md).
3. Do drills in [`../05-exercises.md`](../05-exercises.md).
4. Optional: Day 03 sample for ARC / cycles — [`../../day-03/sample/`](../../day-03/sample/README.md).

---

