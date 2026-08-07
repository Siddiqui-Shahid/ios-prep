# Sample 04 — Ads pipeline, HeroWidget & payment status popup (Q&A)

> Guided teaching. Separates **shipped** named cases from **design-if-asked** and **lab-only** so you never blur them in an interview.

---

### Q1. What can you claim under BookMyShow Ads pipeline + HeroWidget lifecycle?

**Answer:**

> Highest-revenue Ads module work: a **type-safe** pipeline with protocol-oriented contracts and generics so new creatives plug into one rendering path. HeroWidget with explicit pause/play tied to visibility and lifecycle. You may say you **prefer value-friendly models** so accidental shared mutation does not corrupt revenue UI across cells and widgets. You may **not** claim “every ad model was a struct” unless you personally know that.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| ≤20s value-semantics pitch? | “I default to value-friendly DTOs for ad and listing models; classes or actors only at identity or concurrency boundaries.” |
| Where do classes still show up in BookMyShow Ads pipeline + HeroWidget lifecycle? | UIKit surfaces, HeroWidget lifecycle — reference-type identity concerns. |
| Forbidden claim? | Invented fill-rate %, revenue deltas, or crash-rate numbers for ads. |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

---

### Q2. How do you connect BookMyShow Ads pipeline + HeroWidget lifecycle to struct vs class in an interview?

**Answer:**

> Lead with **type safety and composition** (protocols + generics), then extend to model choice: structs and enums for render data keep copies independent; classes stay at UIKit and shared services. Video ads need identity and lifecycle — HeroWidget owning pause/play against visibility is a reference-type story, not an argument against value semantics elsewhere.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Agenda opener? | “Why value semantics matter for revenue UI, then how POP/generics fit the Ads pipeline.” |
| 45s shape? | Claim → POP/generics pipeline → value-friendly DTOs → classes at UIKit boundary. |
| Blur BookMyShow Ads pipeline + HeroWidget lifecycle with memory anecdotes? | Keep architecture (BookMyShow Ads pipeline + HeroWidget lifecycle) separate from invented Memory Graph war stories. |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

---

### Q3. What is BookMyShow payment processing-status popup about?

**Answer:**

> Checkout delays caused drop-off and support load when status was **unclear**. You designed a lightweight popup for **real-time processing status** with distinct processing, success, failure, and timeout messaging, coordinated with backend signals. Intent: reduce ambiguity — silent waiting was the product defect. Do **not** invent measured drop-off %, conversion lift, or support ticket deltas.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| ≤20s line? | “For payment delays we shipped a processing popup with explicit status so users weren’t staring at a silent spinner.” |
| STAR action slice? | Problem = uncertainty during confirmation; action = popup driven by backend status signals; key = treating state communication as part of the feature. |
| Can you say “Swift enum in production”? | Only if personally true — resume level is popup **intent**, not enum implementation name. |

**How can I relate to my case:**
- **Shipped:** BookMyShow payment processing-status popup
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented checkout drop-off % from the status popup alone.

---

### Q4. How do you apply Design: payment status pattern (not shipped) — the enum state machine?

**Answer:**

> Say explicitly: **“How I would apply it.”** Model `hidden`, `processing(message:)`, `success(bookingID:)`, `failure`, `timedOut` as associated-value enum cases so illegal UI combinations cannot exist and `switch`es stay exhaustive. Optional `apply(_ event:)` for transitions. Do **not** say “we shipped it as a Swift enum state machine” unless that is personally true.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why enum here if BookMyShow payment processing-status popup is Verified? | BookMyShow payment processing-status popup = product outcome; Design: payment status pattern (not shipped) = Swift design you recommend when asked *how*. |
| vs boolean flags? | Processing cannot also hold success `bookingID` — impossible states stay unrepresentable. |
| Code sketch location? | `PaymentPopupState` in [`code/LoadState.swift`](../code/LoadState.swift). |

**How can I relate to my case:**
- **Shipped:** BookMyShow payment processing-status popup
- **Design if asked:** Design: payment status pattern (not shipped)
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Invented checkout drop-off % from the status popup alone.

---

### Q5. What is BookMyShow synchronised dictionaries — and how does Day 01 use it?

**Answer:**

> Shared async state hit from multiple queues caused races and intermittent crashes. Fix: **synchronised dictionaries** behind GCD serial queues (RW locks where read-heavy), with a standardized access API so call sites could not touch raw storage. Day 01 uses BookMyShow synchronised dictionaries only as a **soft bridge** to actors — not a full concurrency deep dive (that is Day 05).

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What went wrong before BookMyShow synchronised dictionaries? | Data races on shared maps — intermittent, queue-dependent bugs. |
| Why serial queue? | Serialize mutations — one writer at a time on that storage. |
| Keep BookMyShow synchronised dictionaries short today? | Yes — one bridge sentence; expand concurrency on Day 05. |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Exact crash %, “fixed all BMS crashes,” or claiming lab SafeDict.swift was the shipped file.

---

### Q6. How do you bridge BookMyShow synchronised dictionaries to actors (Design: actor SafeDict (not shipped))?

**Answer:**

> **Verified:** serial queue around shared dictionaries. **Design: actor SafeDict (not shipped):** for greenfield code, expose the same API behind a Swift **`actor`** so isolation is checked by the compiler instead of only by convention. Same boundary idea — different enforcement. Do not claim you rewrote production dictionaries as actors unless you did.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-bridge sentence? | “Where we serialized dictionary access with a serial queue, I’d evaluate an actor for new code.” |
| “We used actors in the ads module”? | **Don’t invent** — Design: actor SafeDict (not shipped) is design-only unless verified. |
| Actor intro 45s? | Race → isolation → serial-queue prior art at BMS. |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries
- **Design if asked:** Design: actor SafeDict (not shipped)
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Exact crash %, “fixed all BMS crashes,” or claiming lab SafeDict.swift was the shipped file.

---

### Q7. How do you combine Day 01 stories without metric inflation?

**Answer:**

> Match question flavor to story: **struct vs class** → BookMyShow Ads pipeline + HeroWidget lifecycle value-friendly models + HeroWidget as identity; **enums vs booleans** → Design: payment status pattern (not shipped) design + BookMyShow payment processing-status popup product intent; **COW / arrays** → listing scale context without fake numbers — “avoid defensive copies; trust COW”; **actors** → Design: actor SafeDict (not shipped) with BookMyShow synchronised dictionaries serial queue as prior art. Scale stats like 30+ lakh DAU belong to BookMyShow IMOC + crash-free at scale reliability culture — use only when the question is about production risk, not as decoration on every answer.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| “Payment enum cut drop-off 40%”? | **Forbidden** — BookMyShow payment processing-status popup intent only, no invented metrics. |
| “Structs are always faster”? | Fix: prefer for semantics; measure large copies. |
| Skipping agenda in answers? | Always: claim → mechanism → trade-off → production hook. |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle; BookMyShow synchronised dictionaries; BookMyShow payment processing-status popup; BookMyShow IMOC + crash-free at scale
- **Design if asked:** Design: actor SafeDict (not shipped); Design: payment status pattern (not shipped)
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Do not steal BookMyShow IMOC / crash-free culture credit for a path-specific dictionary race fix — keep scopes separate.

---

### Q8. What is the flash “map to your work” card for Day 01?

**Answer:**

> **Company / feature:** BookMyShow — Ads / listing models; payment processing popup. **What you did:** Kept render models in a type-safe ads pipeline; modeled processing UI as explicit states rather than silent waiting. **Interview line (≤20s):** “I default to structs for ad and listing models so accidental shared mutation can’t corrupt revenue UI; classes/actors only at identity or concurrency boundaries.” → STAR: BookMyShow Ads pipeline + HeroWidget lifecycle, BookMyShow payment processing-status popup in story bank.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Labels to speak aloud? | **Verified** vs **How I would apply it** — especially Design: payment status pattern (not shipped) and Design: actor SafeDict (not shipped). |
| Provenance source? | [`../../../provenance/README.md`](../../../provenance/README.md) — only Verified IDs from there. |
| After this sample? | Drill timing in [`../04-questions.md`](../04-questions.md). |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle; BookMyShow synchronised dictionaries; BookMyShow payment processing-status popup
- **Design if asked:** Design: actor SafeDict (not shipped); Design: payment status pattern (not shipped)
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Exact crash %, “fixed all BMS crashes,” or claiming lab SafeDict.swift was the shipped file.

Back to: [README.md](README.md)

---

