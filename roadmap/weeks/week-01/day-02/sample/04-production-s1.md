# Sample 04 — BookMyShow Ads pipeline + HeroWidget (Q&A)

> Guided teaching. Separates **shipped** named cases from **design-if-asked** and **lab-only**.  
> Say answers out loud. **Brain puzzles** at the bottom keep claims honest.

---

### Q1. What can you claim under BookMyShow Ads pipeline + HeroWidget lifecycle?

**Answer:**

> “The Ads module was highest-revenue and needed a safer, reusable rendering path. I refactored around protocol contracts and generics so the pipeline stayed type-safe. New ad types plugged in without forking the revenue path. I built reusable HeroWidget with explicit pause and play tied to visibility and view-controller lifecycle. Stakeholder coordination mattered on a revenue surface. Lesson: for revenue-critical UI, prefer POP plus generics over inheritance trees; lifecycle is part of the product contract.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| ≤20s pitch? | “We made ad rendering a generic protocol pipeline so new creatives plugged in without forking the revenue path — and HeroWidget tied video playback to visibility.” |
| Architecture opener (5–10s)? | “I’ll walk through our highest-revenue Ads refactor — protocols, generics, and video lifecycle.” |
| Result (honest)? | “Maintainable type-safe pipeline; lifecycle-correct video reduced wasted playback and UI glitches — no invented percent.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

---

### Q2. What must you never invent for Ads + HeroWidget?

**Answer:**

> “Do not invent fill-rate percentages, revenue deltas, CTR, or exact crash rates for ads. Do not claim we type-erased every renderer unless personally true — prefer learning-lab for erasure demos. Do not claim every creative was a struct. Do not invent team size, sprint counts, or App Store rankings.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Safe qualitative words? | “Revenue-critical, maintainable, type-safe, fewer playback glitches.” |
| Trade-off to volunteer? | “Generics inside for safety; erase only at mixed list or module boundary — erasure isn’t free.” |
| If asked for metrics you don’t have? | “Stay qualitative; offer triage or architecture reasoning instead.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

---

### Q3. How do Day 02 concepts map to Ads + HeroWidget interview lines?

**Answer:**

> “POP maps to capability composition and pipeline contracts. Generics map to compile-time safety versus Any casts. Associated-type pain maps to keep generic or erase at the edge — lab eraser if they ask how. Inheritance versus POP maps to fragile base on ad variants. Video lifecycle maps to HeroWidget pause/play — class identity plus protocol capability. some and any map to prefer generics in hot bind. Extension dispatch maps to requirement versus default.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Asked “what is POP?” | “Capability composition; support with Ads pipeline contracts.” |
| Asked “why generics?” | “Safety versus casts; revenue path correctness.” |
| Asked about erasure? | “Lab how — don’t invent we erased everything in production.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

---

### Q4. What is the Stories SDK soft bridge — without stealing Ads credit?

**Answer:**

> “Stories SDK reused across a portfolio — reusable surfaces mattered. Same instinct: contracts at the boundary, concretes inside. Use Stories SDK when asked about reusable module APIs — not as a replacement for Ads plus HeroWidget on ads-specific questions. Do not invent client counts or latency percentages. Soft bridge means I mention it briefly; I don’t steal the Ads spine.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| ≤20s bridge? | “Same POP instinct showed up later in a Stories SDK — reusable protocol-oriented surfaces across brands rather than copy-pasted concretes.” |
| Public API shape? | “Protocols plus carefully chosen value models — not a forest of concretes clients must subclass.” |
| Named-case label? | “Stories SDK — Raw / Miami Heat — portfolio reuse.” |

**How can I relate to my case:**
- **Shipped:** Stories SDK (Raw / Miami Heat); BookMyShow Ads pipeline + HeroWidget lifecycle
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

---

### Q5. How do you talk about learning-lab code honestly?

**Answer:**

> “AdsPipeline.swift and TypeErasureDemo.swift are teaching sketches of the Ads plus HeroWidget shape and erasure mechanics — not shipped BMS source. If asked ‘Did you write it like this?’ I say: this is the teaching shape of the contracts we used — protocol plus generic pipeline. I’m not claiming this file is production source.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why keep lab files? | “Practice speaking without overclaiming.” |
| Erasure in interview? | “Prefer lab for how erasure works; don’t invent production erasure metrics.” |
| Claim level? | “Pipeline equals teaching shape of shipped Ads story; eraser equals mechanics demo.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

---

### Q6. Soft backend-driven header — when do you even mention it?

**Answer:**

> “Only if the interviewer pivots to SDUI or CMS components. BookMyShow backend-driven header and search: protocol-driven main screen. Unknown component fallback and versioning — say it is design when that’s the Applied angle, not a shipped Day 02 core claim. Do not let this hijack Day 02 — keep Ads plus HeroWidget as the spine.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One liner? | “Open registry matches CMS growth better than a forever-closed enum — with explicit unknown fallback.” |
| Closed enum when? | “Stable small set; rare additions.” |
| Link to system design? | “ComponentRegistry deep dive in the SDUI mock.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle; BookMyShow backend-driven header & search
- **Design if asked:** Unknown-component fallback + versioning — label design.
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

---

### Q7. What interview anti-patterns should you avoid?

**Answer:**

> “Inventing fill-rate percent. Claiming POP means never use classes. Calling type erasure free. Diving into Generics Manifesto trivia. Skipping the agenda on architecture questions. Claiming actors or SwiftUI for Ads plus HeroWidget when that wasn’t the stack — stick to POP, generics, and lifecycle.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Always agenda in 10s? | “Yes on architecture questions.” |
| HeroWidget contradiction? | “Class for lifecycle; protocols for capabilities — not a contradiction.” |
| Flash card company/feature? | “BookMyShow — Ads module / HeroWidget.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

---

### Q8. Deliver a clean ≈90s Action slice (STAR) with honest labels

**Answer:**

> “The Ads module was highest-revenue and needed a safer reusable rendering path. I refactored rendering around protocol contracts and generics so the pipeline stayed type-safe as creatives grew — new types conformed and plugged in instead of forking bind code. Separately, video inside HeroWidget needed correct pause and play against visibility and view-controller lifecycle, so we made that lifecycle explicit on the widget. Stakeholder coordination mattered because behavior changes on a revenue surface aren’t casual. The result was a maintainable type-safe pipeline and fewer playback glitches on video creatives. Trade-off if asked: generics inside; erase only at mixed list or boundary.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Timing drills? | “20s pitch · 90s Action · ≤3 min full STAR · ≤5 min whiteboard.” |
| Stories in same answer? | “Only if asked about reusable SDKs — don’t replace Ads.” |
| After this sample? | “Timed practice in 04-questions; code walk in code/.” |

**How can I relate to my case:**
- **Shipped:** Stories SDK (Raw / Miami Heat); BookMyShow Ads pipeline + HeroWidget lifecycle
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

---

### Q9. 5-minute whiteboard spine — speak it once

**Answer:**

> “Agenda in ten seconds: revenue ads — inheritance pain, POP contracts, generics pipeline, HeroWidget lifecycle, trade-offs. Problem: forking render paths and video lifecycle bugs. Design: Creative, AdTrackable, PlaybackControllable, Pipeline of C. Lifecycle: pause/play on visibility. Trade-off: generics inside; erasure only if mixed feed needs it. Close: type-safe maintainable pipeline — no invented fill-rate.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| If they dig erasure? | “Lab mechanics; production claim stays protocol plus generics.” |
| If they dig SDUI? | “Soft pivot — don’t abandon the Ads agenda.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

---

## Brain puzzles (cover → think → check)

### Puzzle A — Inventing fill-rate %

Interviewer: “So POP lifted fill-rate by twelve percent?”

**Good reply:** “I won’t invent fill-rate numbers. Shipped claim is a type-safe protocol-and-generics pipeline plus HeroWidget lifecycle-correct video. Qualitative: fewer playback glitches, maintainable creatives. Metrics fiction is a hard no.”

---

### Puzzle B — Stories SDK soft bridge without stealing Ads credit

Interviewer: “Tell me about POP at BookMyShow.”

**Trap:** Spending the whole answer on Stories SDK.

**Good reply:** Lead with Ads pipeline + HeroWidget. If they ask about reusable SDKs: “Same instinct later on a Stories SDK — contracts at the boundary. That’s a soft bridge, not the Ads story.”

---

### Puzzle C — Lab file as production source

Interviewer points at TypeErasureDemo.swift: “So this is what shipped?”

**Good reply:** “No — learning-lab teaching shape for erasure mechanics. Production language is protocol contracts and a generic pipeline. I’m not claiming this file is BMS source, and I don’t invent that we erased every renderer.”

---

## After this sample

1. Walk [`../code/AdsPipeline.swift`](../code/AdsPipeline.swift) and [`../code/TypeErasureDemo.swift`](../code/TypeErasureDemo.swift) aloud.
2. Continue to [05-system-design-mock.md](05-system-design-mock.md), then [06-module-drills.md](06-module-drills.md).
3. Speak from [`../04-questions.md`](../04-questions.md).
4. Do drills in [`../05-exercises.md`](../05-exercises.md).
