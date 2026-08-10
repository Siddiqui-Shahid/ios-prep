# Sample 04 — Ads pipeline, HeroWidget & payment status popup (Q&A)

> Guided teaching. Say the **Answer** out loud like you’re talking to an interviewer. 
> Separates **shipped** named cases from **design-if-asked** and **lab-only** so you never blur them. 
> **Brain puzzles** at the bottom — cover the answer, think, then check.

---

### Q1. What can you claim under BookMyShow Ads pipeline + HeroWidget lifecycle?
**Answer:**

> “Highest-revenue Ads module work: a type-safe pipeline with protocol-oriented contracts and generics so new creatives plug into one rendering path. HeroWidget with explicit pause and play tied to visibility and lifecycle. I may say I prefer value-friendly models so accidental shared mutation does not corrupt revenue UI across cells and widgets. I may not claim every ad model was a struct unless I personally know that — and I never invent fill-rate or revenue percentages.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| ≤20s value-semantics pitch? | “I default to value-friendly DTOs for ad and listing models; classes or actors only at identity or concurrency boundaries.” |
| Where do classes still show up? | “UIKit surfaces, HeroWidget lifecycle — reference-type identity concerns.” |
| Forbidden claim? | “Invented fill-rate %, revenue deltas, or crash-rate numbers for ads.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

---

### Q2. How do you connect Ads pipeline + HeroWidget to struct vs class?
**Answer:**

> “Lead with type safety and composition — protocols plus generics — then extend to model choice: structs and enums for render data keep copies independent; classes stay at UIKit and shared services. Video ads need identity and lifecycle — HeroWidget owning pause and play against visibility is a reference-type story, not an argument against value semantics elsewhere.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Agenda opener? | “Why value semantics matter for revenue UI, then how POP and generics fit the Ads pipeline.” |
| 45s shape? | “Claim → POP/generics pipeline → value-friendly DTOs → classes at UIKit boundary.” |
| Blur with memory anecdotes? | “Keep architecture separate from invented Memory Graph war stories.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

---

### Q3. What is BookMyShow payment processing-status popup about?
**Answer:**

> “Checkout delays caused drop-off and support load when status was unclear. We designed a lightweight popup for real-time processing status with distinct processing, success, failure, and timeout messaging, coordinated with backend signals. Intent: reduce ambiguity — silent waiting was the product defect. I do not invent measured drop-off percent, conversion lift, or support ticket deltas.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| ≤20s line? | “For payment delays we shipped a processing popup with explicit status so users weren’t staring at a silent spinner.” |
| STAR action slice? | “Problem = uncertainty during confirmation; action = popup driven by backend status signals; key = treating state communication as part of the feature.” |
| Can you say “Swift enum in production”? | “Only if personally true — resume level is popup intent, not enum implementation name.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow payment processing-status popup
- **Don’t claim:** Invented checkout drop-off % from the status popup alone.

---

### Q4. How do you apply Design: payment status pattern — the enum state machine?
**Answer:**

> “Say explicitly: how I would apply it. Model hidden, processing(message:), success(bookingID:), failure, timedOut as associated-value enum cases so illegal UI combinations cannot exist and switches stay exhaustive. Optional apply(event) for transitions — full graph in LoadState.swift. Do not say we shipped it as a Swift enum state machine unless that is personally true.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why enum if the popup is Verified? | “Popup = product outcome; payment status pattern = Swift design when asked how.” |
| vs boolean flags? | “Processing cannot also hold success bookingID — impossible states stay unrepresentable.” |
| Code sketch? | “`PaymentPopupState` in [`code/LoadState.swift`](../code/LoadState.swift).” |

**How can I relate to my case:**
- **Shipped:** BookMyShow payment processing-status popup
- **Design if asked:** Design: payment status pattern (not shipped)
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Invented checkout drop-off % from the status popup alone.

---

### Q5. What is BookMyShow synchronised dictionaries — and how does Day 01 use it?
**Answer:**

> “Shared async state hit from multiple queues caused races and intermittent crashes. Fix: synchronised dictionaries behind GCD serial queues — RW locks where read-heavy — with a standardized access API so call sites could not touch raw storage. Day 01 uses this only as a soft bridge to actors — not a full concurrency deep dive. That is Day 05.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What went wrong before? | “Data races on shared maps — intermittent, queue-dependent bugs.” |
| Why serial queue? | “Serialize mutations — one writer at a time on that storage.” |
| Keep it short today? | “Yes — one bridge sentence; expand concurrency on Day 05.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries
- **Don’t claim:** Exact crash %, “fixed all BMS crashes,” or claiming lab SafeDict.swift was the shipped file.

---

### Q6. How do you bridge synchronised dictionaries to actors?
**Answer:**

> “Verified: serial queue around shared dictionaries. Design: actor SafeDict — for greenfield code, expose the same API behind a Swift actor so isolation is checked by the compiler instead of only by convention. Same boundary idea — different enforcement. Do not claim you rewrote production dictionaries as actors unless you did.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-bridge sentence? | “Where we serialized dictionary access with a serial queue, I’d evaluate an actor for new code.” |
| “We used actors in the ads module”? | “Don’t invent — Design: actor SafeDict is design-only unless verified.” |
| Actor intro 45s? | “Race → isolation → serial-queue prior art at BMS.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries
- **Design if asked:** Design: actor SafeDict (not shipped)
- **Don’t claim:** Exact crash %, “fixed all BMS crashes,” or claiming lab SafeDict.swift was the shipped file.

---

### Q7. How do you combine Day 01 stories without metric inflation?
**Answer:**

> “Match question flavor to story. Struct vs class → Ads pipeline value-friendly models plus HeroWidget as identity. Enums vs booleans → payment status pattern design plus payment processing-status popup product intent. COW and arrays → listing scale without fake numbers — avoid defensive copies; trust COW. Actors → SafeDict design with synchronised dictionaries as prior art. Scale stats like thirty-plus lakh DAU belong to IMOC and crash-free-at-scale reliability culture — use only when the question is about production risk, not as decoration on every answer. Never combine stories to invent a bigger metric.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| “Payment enum cut drop-off 40%”? | “Forbidden — popup intent only, no invented metrics.” |
| “Structs are always faster”? | “Prefer for semantics; measure large copies.” |
| Skipping agenda? | “Always: claim → mechanism → trade-off → production hook.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle; BookMyShow synchronised dictionaries; BookMyShow payment processing-status popup; BookMyShow IMOC + crash-free at scale
- **Design if asked:** Design: actor SafeDict (not shipped); Design: payment status pattern (not shipped)
- **Don’t claim:** Do not steal IMOC / crash-free culture credit for a path-specific dictionary race fix — keep scopes separate.

---

### Q8. What is the flash “map to your work” card for Day 01?
**Answer:**

> “Company feature: BookMyShow — Ads and listing models; payment processing popup. What I did: kept render models in a type-safe ads pipeline; modeled processing UI as explicit states rather than silent waiting. Interview line under twenty seconds: I default to structs for ad and listing models so accidental shared mutation can’t corrupt revenue UI; classes and actors only at identity or concurrency boundaries. Then STAR: Ads pipeline plus HeroWidget, payment processing-status popup in the story bank.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Labels to speak aloud? | “Verified versus how I would apply it — especially payment status pattern and actor SafeDict.” |
| Provenance source? | “[`../../../provenance/README.md`](../../../provenance/README.md) — only Verified IDs from there.” |
| After this sample? | “Drill timing in [07-revision-qna.md](07-revision-qna.md).” |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle; BookMyShow synchronised dictionaries; BookMyShow payment processing-status popup
- **Design if asked:** Design: actor SafeDict (not shipped); Design: payment status pattern (not shipped)
- **Don’t claim:** Exact crash %, “fixed all BMS crashes,” or claiming lab SafeDict.swift was the shipped file.

---

## Brain puzzles (cover → think → check)

### Puzzle A — Honest claims vs invented metrics

Interviewer: “By how many percent did the payment popup cut checkout drop-off?”

**Good reply:** “I don’t have a measured percent I’m willing to invent. The product defect was silent waiting; we shipped explicit processing, success, failure, and timeout messaging. Intent was less ambiguity and support friction — I’ll stay qualitative unless I have a real number.”

---

### Puzzle B — Story-combining trap

Someone says: “Our ads structs plus synchronised dictionaries raised crash-free sessions org-wide by X%.”

**Ask yourself:** What’s wrong?

**Answer:** Scope inflation. Ads pipeline is architecture/type-safety; dictionaries are path-scoped race fixes; crash-free culture is a separate reliability story. Don’t glue them into one invented org metric.

---

### Puzzle C — Blurring shipped vs design

“We shipped the payment UI as a Swift enum state machine and rewrote dictionaries to actors.”

**Ask yourself:** Fix the sentence.

**Answer:** Shipped: processing-status popup intent; synchronised dictionaries on GCD. Design-if-asked: enum state machine; actor SafeDict. Label the boundary out loud.

---

Next: [05-system-design-mock.md](05-system-design-mock.md)
