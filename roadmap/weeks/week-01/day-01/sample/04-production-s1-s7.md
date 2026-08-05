# Sample 04 — Production S1, S7, S2 (Q&A)

> Guided teaching. Separates **Verified** resume facts from **How I would apply it** design so you never blur them in an interview.

---

### Q1. What can you claim under Verified · S1?

**Points to:** [Production bridge · §2 Verified · S1](../03-production-bridge.md#2-verified--s1--ads--type-safe-models) · [Foundations · §3.1](../01-foundations.md#31-why-teams-love-structs-for-models)

**Answer:**

> Highest-revenue Ads module work: a **type-safe** pipeline with protocol-oriented contracts and generics so new creatives plug into one rendering path. HeroWidget with explicit pause/play tied to visibility and lifecycle. You may say you **prefer value-friendly models** so accidental shared mutation does not corrupt revenue UI across cells and widgets. You may **not** claim “every ad model was a struct” unless you personally know that.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| ≤20s value-semantics pitch? | “I default to value-friendly DTOs for ad and listing models; classes or actors only at identity or concurrency boundaries.” |
| Where do classes still show up in S1? | UIKit surfaces, HeroWidget lifecycle — reference-type identity concerns. |
| Forbidden claim? | Invented fill-rate %, revenue deltas, or crash-rate numbers for ads. |

---

### Q2. How do you connect S1 to struct vs class in an interview?

**Points to:** [Production bridge · §2 Interview lines](../03-production-bridge.md#2-verified--s1--ads--type-safe-models) · [Deep dive · §9 Struct vs class template](../02-deep-dive.md#struct-vs-class-45s)

**Answer:**

> Lead with **type safety and composition** (protocols + generics), then extend to model choice: structs and enums for render data keep copies independent; classes stay at UIKit and shared services. Video ads need identity and lifecycle — HeroWidget owning pause/play against visibility is a reference-type story, not an argument against value semantics elsewhere.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Agenda opener? | “Why value semantics matter for revenue UI, then how POP/generics fit the Ads pipeline.” |
| 45s shape? | Claim → POP/generics pipeline → value-friendly DTOs → classes at UIKit boundary. |
| Blur S1 with memory anecdotes? | Keep architecture (S1) separate from invented Memory Graph war stories. |

---

### Q3. What is Verified · S7 about?

**Points to:** [Production bridge · §3 Verified · S7](../03-production-bridge.md#3-verified--s7--payment-processing-popup) · [Foundations · §5.2](../01-foundations.md#52-why-this-matters-for-ui)

**Answer:**

> Checkout delays caused drop-off and support load when status was **unclear**. You designed a lightweight popup for **real-time processing status** with distinct processing, success, failure, and timeout messaging, coordinated with backend signals. Intent: reduce ambiguity — silent waiting was the product defect. Do **not** invent measured drop-off %, conversion lift, or support ticket deltas.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| ≤20s line? | “For payment delays we shipped a processing popup with explicit status so users weren’t staring at a silent spinner.” |
| STAR action slice? | Problem = uncertainty during confirmation; action = popup driven by backend status signals; key = treating state communication as part of the feature. |
| Can you say “Swift enum in production”? | Only if personally true — resume level is popup **intent**, not enum implementation name. |

---

### Q4. How do you apply S7-A1 — the enum state machine?

**Points to:** [Production bridge · §4 Applied · S7-A1](../03-production-bridge.md#4-applied--s7-a1--enum-state-machine-design) · [Deep dive · §4.3](../02-deep-dive.md#43-payment-popup-machine-applied--s7-a1) · [code/LoadState.swift](../code/LoadState.swift)

**Answer:**

> Say explicitly: **“How I would apply it.”** Model `hidden`, `processing(message:)`, `success(bookingID:)`, `failure`, `timedOut` as associated-value enum cases so illegal UI combinations cannot exist and `switch`es stay exhaustive. Optional `apply(_ event:)` for transitions. Do **not** say “we shipped it as a Swift enum state machine” unless that is personally true.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why enum here if S7 is Verified? | S7 = product outcome; S7-A1 = Swift design you recommend when asked *how*. |
| vs boolean flags? | Processing cannot also hold success `bookingID` — impossible states stay unrepresentable. |
| Code sketch location? | `PaymentPopupState` in [`code/LoadState.swift`](../code/LoadState.swift). |

---

### Q5. What is Verified · S2 — and how does Day 01 use it?

**Points to:** [Production bridge · §5 Verified · S2](../03-production-bridge.md#5-verified--s2--applied--s2-a1--actors-bridge) · [Foundations · §7.2](../01-foundations.md#72-soft-bridge-from-production)

**Answer:**

> Shared async state hit from multiple queues caused races and intermittent crashes. Fix: **synchronised dictionaries** behind GCD serial queues (RW locks where read-heavy), with a standardized access API so call sites could not touch raw storage. Day 01 uses S2 only as a **soft bridge** to actors — not a full concurrency deep dive (that is Day 05).

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What went wrong before S2? | Data races on shared maps — intermittent, queue-dependent bugs. |
| Why serial queue? | Serialize mutations — one writer at a time on that storage. |
| Keep S2 short today? | Yes — one bridge sentence; expand concurrency on Day 05. |

---

### Q6. How do you bridge S2 to actors (Applied · S2-A1)?

**Points to:** [Production bridge · §5](../03-production-bridge.md#5-verified--s2--applied--s2-a1--actors-bridge) · [Deep dive · §6.2](../02-deep-dive.md#62-actor-vs-serial-queue-s2-bridge)

**Answer:**

> **Verified:** serial queue around shared dictionaries. **Applied · S2-A1:** for greenfield code, expose the same API behind a Swift **`actor`** so isolation is checked by the compiler instead of only by convention. Same boundary idea — different enforcement. Do not claim you rewrote production dictionaries as actors unless you did.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-bridge sentence? | “Where we serialized dictionary access with a serial queue, I’d evaluate an actor for new code.” |
| “We used actors in the ads module”? | **Don’t invent** — S2-A1 is design-only unless verified. |
| Actor intro 45s? | Race → isolation → serial-queue prior art at BMS. |

---

### Q7. How do you combine Day 01 stories without metric inflation?

**Points to:** [Production bridge · §6 Combining stories](../03-production-bridge.md#6-combining-stories-without-metric-inflation) · [Production bridge · §7 Anti-patterns](../03-production-bridge.md#7-anti-patterns-in-interviews)

**Answer:**

> Match question flavor to story: **struct vs class** → S1 value-friendly models + HeroWidget as identity; **enums vs booleans** → S7-A1 design + S7 product intent; **COW / arrays** → listing scale context without fake numbers — “avoid defensive copies; trust COW”; **actors** → S2-A1 with S2 serial queue as prior art. Scale stats like 30+ lakh DAU belong to S8 reliability culture — use only when the question is about production risk, not as decoration on every answer.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| “Payment enum cut drop-off 40%”? | **Forbidden** — S7 intent only, no invented metrics. |
| “Structs are always faster”? | Fix: prefer for semantics; measure large copies. |
| Skipping agenda in answers? | Always: claim → mechanism → trade-off → production hook. |

---

### Q8. What is the flash “map to your work” card for Day 01?

**Points to:** [Production bridge · §8 Flash card](../03-production-bridge.md#8-flash-map-to-your-work-card) · [README · Provenance reminder](../README.md#provenance-reminder)

**Answer:**

> **Company / feature:** BookMyShow — Ads / listing models; payment processing popup. **What you did:** Kept render models in a type-safe ads pipeline; modeled processing UI as explicit states rather than silent waiting. **Interview line (≤20s):** “I default to structs for ad and listing models so accidental shared mutation can’t corrupt revenue UI; classes/actors only at identity or concurrency boundaries.” → STAR: S1, S7 in story bank.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Labels to speak aloud? | **Verified** vs **How I would apply it** — especially S7-A1 and S2-A1. |
| Provenance source? | [`../../../provenance/README.md`](../../../provenance/README.md) — only Verified IDs from there. |
| After this sample? | Drill timing in [`../04-questions.md`](../04-questions.md). |

---

Back to: [README.md](README.md)
