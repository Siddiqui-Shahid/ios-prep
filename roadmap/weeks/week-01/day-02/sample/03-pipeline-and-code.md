# Sample 03 — Pipeline shape and code demos (Q&A)

> Guided teaching. Walk the learning-lab files aloud — they are teaching shape, not shipped BMS source.  
> Say answers like a conversation. **Brain puzzles** at the bottom.

---

### Q1. What is the preferred ads pipeline shape?

**Answer:**

> “Keep the outer API generic so the compiler still sees a concrete creative type. Compose video-only behavior as an extra capability — PlaybackControllable — do not force image creatives to pretend they play video. Avoid as? VideoCreative on the revenue path. New types plug in by conforming, not by casting.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Demo type? | “AdPipeline of C where C is Creative and AdTrackable — AdsPipeline.swift.” |
| What does install() do? | “Track impression, then makeBody — type-safe end to end.” |
| Why not Any cast ladder? | “Casts hide bugs until a new creative ships Friday night.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Learning-lab teaching shape; hook BookMyShow Ads only if asked for production proof.

---

### Q2. How do where clauses help with associated types?

**Answer:**

> “where lets you say only when the associated view is this kind — for example where C.View is UIImageView. You keep specialization and avoid casting. Use typealiases for long A & B & C contracts so whiteboard signatures stay readable.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Example typealias? | “TrackedCreative equals AdRenderable and AdTrackable.” |
| Array helper idea? | “renderAll only when every element’s associated View is the same V.” |
| Interview signal? | “You constrain associated types instead of force-casting.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q3. How does HeroWidget mix POP with UIKit identity?

**Answer:**

> “HeroWidget needs three things: a real view lifecycle — class identity — pause and play when visibility changes, and clean contracts so the ads pipeline does not care about player internals. Make it a UIView that adopts PlaybackControllable. POP gave the pipeline; the widget stays a class because lifecycle and player identity are reference concerns. That’s not a contradiction.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Interview line? | “POP for the pipeline; HeroWidget is still a class — pause/play tied to visibility.” |
| Why AnyObject on playback? | “Often weak ownership / class identity for the player surface.” |
| Provenance? | “BookMyShow Ads pipeline + HeroWidget lifecycle.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

---

### Q4. What should you explain when reading AdsPipeline.swift?

**Answer:**

> “Point at each capability protocol — AdTrackable, Creative, PlaybackControllable. Show image versus video conformers. Explain why the pipeline is generic. Note that extension defaults on trackClick are for identical behavior — polymorphic overrides belong in requirements. Say aloud: this is learning-lab teaching shape, not claimed BMS source.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why is VideoCreative a class? | “Playback and identity — also adopts PlaybackControllable.” |
| Why is ImageCreative a struct? | “Value-friendly model with no player identity need.” |
| bindPlayback idea? | “Only types that are Creative and PlaybackControllable get pause/play.” |

**How can I relate to my case:**
- **Lab only:** Learning-lab demos / sketches only — not production source.

---

### Q5. What should you explain when reading TypeErasureDemo.swift?

**Answer:**

> “AnyTrackable is one concrete type that stores an id and a _track closure. Banner and Interstitial both fit in an array of AnyTrackable. The init captures the concrete adopter into the box. Cost is heap/closure indirection and lost specialization. Prefer a generic install inside the pipeline; erase only for mixed lists or boundaries. Same motive as Combine’s AnyPublisher.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why not claim this shipped at BMS? | “Learning-lab — teaching mechanics. Prefer lab for erasure demos unless personally true.” |
| Upcast angle? | “When erasing renderers, views often collapse to UIView as the common surface.” |
| When skip erasure? | “When the hot path can stay generic end-to-end.” |

**How can I relate to my case:**
- **Lab only:** Learning-lab demos / sketches only — not production source.

---

### Q6. What trade-offs should you memorize — including YAGNI vs revenue scale?

**Answer:**

> “POP plus generics: many variants and revenue safety — cost is learning curve and associated-type friction. Inheritance tree: rare shared UIKit identity — cost is fragile base. Type erasure: mixed arrays and boundaries — cost is allocation. any Protocol: flexibility — existential overhead and associated-type limits. Closed enum: stable small set — app release for every new case. Two similar types forever — maybe don’t abstract yet. Highest-revenue growing creatives — abstraction pays. Trap: always POP everything. Senior: introduce POP when variants or test seams demand it.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| BMS ads justification? | “Variants justified the BookMyShow Ads pipeline — still no invented fill-rate %.” |
| Stories SDK angle? | “Protocols at the SDK boundary — soft bridge, don’t steal Ads credit.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

---

### Q7. What is a 5-minute whiteboard architecture spine?

**Answer:**

> “Agenda: revenue ads path — inheritance problems, POP contracts, generics pipeline, HeroWidget lifecycle, trade-offs. Problem: new creatives forking render code; video lifecycle bugs. Design: capability protocols plus Pipeline of C. Lifecycle: pause/play on visibility. Trade-off: generics inside; erasure only if mixed feed requires it. Honesty: no invented fill-rate percent; maintainable type-safe pipeline is the claim. Fifteen-second opener: highest-revenue Ads path — protocols, generics, and video lifecycle.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Anti-pattern to avoid? | “Diving into Generics Manifesto trivia instead of safety → pipeline → lifecycle → trade-off.” |
| Next practice after code tour? | “Production bridge sample, then timed questions.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle (when telling the story)
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

---

### Q8. Name five anti-patterns and their fixes

**Answer:**

> “One: Any plus cast ladder — generic constraint or typed factory. Two: deep AdView tree — capability protocols. Three: erasing every generic — erase at boundary only. Four: extension-only overrides — promote to requirements. Five: structs can’t do POP — structs are first-class adopters. Bonus: forgetting UIKit subclass needs — class for view identity, POP for capabilities.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Claiming any is free? | “Know existential plus associated-type limits.” |
| Claiming every creative was a struct? | “Don’t invent — video/player identity often needs a class.” |
| Done with code sample? | “Move to Ads plus HeroWidget interview language, then Stories soft bridge if asked.” |

**How can I relate to my case:**
- **Shipped:** Stories SDK (Raw / Miami Heat); BookMyShow Ads pipeline + HeroWidget lifecycle
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

---

### Q9. rethrows ergonomics on a pipeline mapper?

**Answer:**

> “A generic mapCreatives that rethrows keeps non-throwing call sites clean — no forced try — while still allowing a throwing transform when decoding or validation can fail. It’s pipeline API manners: don’t make every installer look like it always throws.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Ceremony trap? | “Marking everything rethrows when nothing throws.” |
| Tie to generics? | “Same higher-order style as stdlib map — typed, constrained, honest about errors.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

## Brain puzzles (cover → think → check)

### Puzzle A — HeroWidget class identity + protocol capability

Interviewer: “You said POP — so why is HeroWidget a class?”

**Good reply:** “POP for the pipeline capabilities. HeroWidget is still a class because view lifecycle and player identity are reference concerns — pause and play tied to visibility. Class identity plus protocol capability isn’t a contradiction.”

---

### Puzzle B — Always erase the pipeline?

Someone wraps every creative in AnyCreative before install.

**Ask:** What’s wrong?

**Answer:** You paid erasure cost on the hot path and lost specialization. Prefer `install<C: Creative & AdTrackable>(_:)`. Erase only when the feed truly mixes shapes or you cross a module boundary.

---

### Puzzle C — Inventing fill-rate %

Interviewer: “By what percent did fill-rate improve after POP?”

**Good reply:** “I don’t invent fill-rate numbers. What I claim is a maintainable type-safe pipeline and lifecycle-correct video on HeroWidget — fewer playback glitches qualitatively. If you need metrics, I’d talk measurement design, not fiction.”

---

Next: [04-production-s1.md](04-production-s1.md)
