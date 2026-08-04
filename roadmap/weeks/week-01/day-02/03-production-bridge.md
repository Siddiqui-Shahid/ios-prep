# 03 — Production Bridge

> Turn Day 02 concepts into resume-honest interview lines.  
> Labels: **Verified** = resume-backed · **How I would apply it** = design extension · **Learning-lab** = demo code.

---

## 1. Story map for today

| Concept | Story | Label |
|---|---|---|
| POP + generics type-safe ads pipeline | Ads module refactor | **Verified · S1** |
| Video pause/play tied to visibility | HeroWidget | **Verified · S1** |
| Reusable protocol APIs at SDK boundary | Stories SDK | **Verified · S10** |
| Protocol-driven header / open components | Backend-driven header | **Verified · S3** (soft) |
| Unknown component fallback | SDUI versioning design | **How I would apply it · S3-A1** (soft) |
| Mini pipeline / eraser demos | Local snippets | **Learning-lab** |

Full STAR: [`../../../stories/story-bank.md`](../../../stories/story-bank.md) (S1, S10; S3 optional).

---

## 2. Verified · S1 — Ads / HeroWidget (core)

### What you can say (safe)

- Highest-revenue Ads module needed a safer, reusable rendering path  
- Refactored around **protocol-oriented** ad component contracts + **generics** for a **type-safe** pipeline  
- New ad types plug into the pipeline without forking the revenue path  
- Built reusable **HeroWidget** with explicit pause/play tied to visibility / VC lifecycle  
- Coordinated behavior with stakeholders without breaking fill behavior (qualitative — no invented %)  
- Lesson: for revenue-critical UI, prefer POP + generics over inheritance trees; lifecycle is part of the product contract  

### What you must **not** invent

- Fill-rate percentages, revenue deltas, CTR, exact crash rates for ads  
- “We type-erased every renderer” (unless personally true — prefer Learning-lab for erasure demos)  
- “Every creative was a struct”  
- Fake team size, sprint counts, or App Store rankings  

### Interview lines

**≤20s pitch:**  
> “We made ad rendering a generic protocol pipeline so new creatives plugged in without forking the revenue path — and HeroWidget tied video playback to visibility.”

**Architecture talk opener (5–10s):**  
> “I’ll walk through our highest-revenue Ads refactor — protocols, generics, and video lifecycle.”

**≈90s Action slice (STAR):**  
> “The Ads module was highest-revenue and needed a safer reusable rendering path. I refactored rendering around protocol-oriented contracts and generics so the pipeline stayed type-safe as creatives grew — new types conformed and plugged in instead of forking bind code. Separately, video inside HeroWidget needed correct pause and play against visibility and view-controller lifecycle, so we made that lifecycle explicit on the widget. Stakeholder coordination mattered because behavior changes on a revenue surface aren’t casual. The result was a maintainable type-safe pipeline and fewer playback glitches on video creatives.”

**Result (honest):**  
> “Shipped a maintainable, type-safe ads pipeline; lifecycle-correct video reduced wasted playback and UI glitches on a module that mattered for revenue.”

**Trade-off to volunteer:**  
> “Generics inside the pipeline for safety and specialization; I’d only type-erase at a heterogeneous list or module boundary — erasure isn’t free.”

> **Provenance:** Verified · S1 · BookMyShow · Ads POP + Generics / HeroWidget

---

## 3. Mapping concepts → S1 lines

| Question flavor | Lead with | Support with |
|---|---|---|
| What is POP? | Capability composition | S1 pipeline contracts |
| Why generics? | Compile-time safety vs `Any` casts | Revenue path correctness |
| associatedtype pain | Keep generic / erase at edge | Learning-lab eraser if asked “how” |
| Inheritance vs POP | Fragile base on ad variants | S1 lesson line |
| Video lifecycle | HeroWidget pause/play | Class identity + protocol capability |
| `some` vs `any` | Opaque vs existential | Prefer generics in hot bind |
| Extension dispatch | Requirement vs default | Shared `track` defaults |

---

## 4. Verified · S10 — Stories SDK soft bridge

### What you can say (safe)

- Built a Stories SDK reused across a portfolio of apps  
- Reusable surfaces / modularity mattered  
- Same instinct: **contracts at the boundary**, concretes inside  

### What you must **not** invent

- Number of client apps as a precise metric unless you know it  
- Latency / engagement % for stories  

**≤20s bridge:**  
> “Same POP instinct showed up later in a Stories SDK — reusable protocol-oriented surfaces across brands rather than copy-pasted concretes.”

> **Provenance:** Verified · S10 · Raw / Miami Heat · Stories SDK portfolio reuse

Use S10 when asked “Have you designed reusable module APIs?” — not as a replacement for S1 on ads-specific questions.

---

## 5. Soft · S3 / S3-A1 — open registries

Only if interviewer pivots to SDUI / CMS components:

**Verified · S3:** backend-driven header; generalised protocol-driven main-screen implementation.  

**Applied · S3-A1:** how you’d handle unknown component types (fallback + versioning) — say it is design, not a shipped claim.

**One liner:**  
> “An open protocol registry matches CMS growth better than an forever-closed enum — with an explicit unknown fallback. That’s the design I’d apply for versioning (S3-A1); the shipped header work was protocol-driven (S3).”

Do not let this hijack Day 02 — keep S1 as the spine.

---

## 6. Learning-lab — what the code files are

| File | Claim level |
|---|---|
| [`code/AdsPipeline.swift`](code/AdsPipeline.swift) | Teaching sketch of S1 shape — **not** shipped BMS source |
| [`code/TypeErasureDemo.swift`](code/TypeErasureDemo.swift) | Erasure mechanics demo |

If asked “Did you write it like this?”:  
> “This is the teaching shape of the contracts we used — protocol + generic pipeline. I’m not claiming this file is production source.”

---

## 7. Anti-patterns in interviews

| Anti-pattern | Fix |
|---|---|
| Inventing fill-rate % | Qualitative: revenue-critical, maintainable, type-safe |
| “POP means never use classes” | HeroWidget is a class; capabilities are protocols |
| “Type erasure is free abstraction” | Name allocation + lost specialization |
| Diving into Generics Manifesto trivia | Stay: safety → pipeline → lifecycle → trade-off |
| Skipping agenda on architecture Q | Always agenda in 10s |
| Claiming actors/SwiftUI for S1 | Don’t invent stack; stick to POP + generics + lifecycle |

---

## 8. Flash “map to your work” card

**Company / feature:** BookMyShow — Ads module / HeroWidget  

**What you did:** Refactored highest-revenue module with POP + Generics for type-safe rendering; video pause/play lifecycle on HeroWidget.  

**Interview line (≤20s):**  
> “We made ad rendering a generic protocol pipeline so new creatives plugged in without forking the revenue path.”

→ STAR: [S1](../../../stories/story-bank.md#s1--ads-module-refactor--herowidget-bookmyshow) · optional [S10](../../../stories/story-bank.md#s10--stories-sdk-raw--miami-heat)

---

## 9. Timed story drills

| Drill | Budget | Pass bar |
|---|---|---|
| S1 ≤20s pitch | 20s | Protocols + generics + HeroWidget |
| S1 Action only | 90s | No invented metrics; trade-off optional |
| Full S1 STAR | ≤3 min | Agenda + result + lesson |
| Architecture dry-run | ≤5 min | Whiteboard flow from deep dive §11 |
| S10 bridge | 20s | Boundary protocols; no fake numbers |

---

## Next

Drill spoken answers in [`04-questions.md`](04-questions.md). Speak from **Answer points** first; then compare to **Full spoken answer**.
