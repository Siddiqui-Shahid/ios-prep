# 02 — Deep Dive: Associated Types, Dispatch, some/any, Type Erasure (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Simple language. Named work only — never S-codes in speech.

---

### Q1. Why a “simple protocol variable” suddenly stops working? `(45–60s)`
**Answer:**

> “Start with this protocol: swift protocol AdRenderable { associatedtype ContentView: UIView associatedtype Model func render(_ model: Model) -> ContentView }.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q2. Primary associated types (awareness)? `(45–60s)`
**Answer:**

> “swift protocol AdRenderable<Model> { associatedtype Model associatedtype ContentView: UIView func render(_ model: Model) -> ContentView } // Newer Swift can make some call sites clearer: func handle(_ ad: any AdRenderable<HeroModel>) { ... }.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q3. Same idea in Apple’s own libraries? `(45–60s)`
**Answer:**

> “Swift’s standard library uses type erasure (AnyIterator, AnySequence) because associated types block easy existentials. Combine’s AnyPublisher is the same idea for reactive pipelines. If you can explain why AnyPublisher exists, you can explain why an ads type eraser exists.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q4. Preferred shape? `(45–60s)`
**Answer:**

> “swift protocol Creative { associatedtype View: UIView func makeView -> View } protocol PlaybackControllable { func pause func play }.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q5. `where` clauses for associated types? `(45–60s)`
**Answer:**

> “swift func dump<C: Creative>(_ c: C) where C.View: UIImageView { // Only creatives whose View is UIImageView } extension Array { func renderAll<V: UIView> -> [V] where Element: Creative, Element.View == V { map { $0.makeView } } }.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q6. Typealiases for readable signatures? `(45–60s)`
**Answer:**

> “swift typealias TrackedCreative = AdRenderable & AdTrackable typealias HeroCapable = TrackedCreative & PlaybackControllable These are just short names for long “and” contracts. Useful on a whiteboard.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q7. Three flavors you should be able to name? `(45–60s)`
**Answer:**

> “You do not need assembly. You need this sentence:.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q8. The extension default trap (classic interview)? `(45–60s)`
**Answer:**

> “swift protocol Greeter { func greet } extension Greeter { func greet { print("protocol default") } func wave { print("extension-only wave") } // NOT a requirement }.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q9. Why this matters for ads? `(45–60s)`
**Answer:**

> “Shared track defaults in an extension are fine when every creative should behave the same. Custom per-creative tracking that must override belongs in the protocol as a requirement — or call it on the concrete / generic type. ---.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q10. Opaque (`some`)? `(45–60s)`
**Answer:**

> “swift func heroWidget -> some PlaybackControllable { VideoHero // one concrete type forever for this function } Rules of thumb:.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q11. Existential (`any`)? `(45–60s)`
**Answer:**

> “swift var tile: any AdTrackable tile = ImageAd tile = VideoAd // OK if both adopt and the operations you need are available Costs in plain words:.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q12. Quick contrast? `(45–60s)`
**Answer:**

> “---.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q13. When you need it? `(45–60s)`
**Answer:**

> “You want one type, say AnyAd, so this works: swift let feed: [AnyAd] = [AnyAd(ImageAd), AnyAd(VideoAd)] feed.forEach { $0.trackImpression }.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q14. Hand-rolled eraser (learning-lab pattern)? `(45–60s)`
**Answer:**

> “swift protocol AdTrackable { var creativeID: String { get } func trackImpression } struct AnyAd: AdTrackable { private let _id: String private let _track: -> Void.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q15. Costs you must be able to say? `(45–60s)`
**Answer:**

> “Senior rule: keep generics inside the hot pipeline; erase at module boundaries or mixed lists only.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q16. Combine mental transfer? `(45–60s)`
**Answer:**

> “AnyPublisher<Output, Failure> exists so you can return or store publishers without leaking nested generic operator types. Same motive as AnyAd. ---.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q17. Closed enum? `(45–60s)`
**Answer:**

> “swift enum AdKind { case image(ImageModel) case video(VideoModel) } Pros: exhaustive switches, simple. Cons: every new creative is an app release plus an enum edit.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q18. Open protocol registry? `(45–60s)`
**Answer:**

> “swift protocol AdComponentFactory { func supports(_ type: String) -> Bool func make(from json: [String: Any]) -> AnyRenderable? } final class AdRegistry { private var factories: [AdComponentFactory] = [] func register(_ f: AdComponentFactory) { factories.append(f) } func make(type: String, json: [String: Any]) -> AnyRenderable? { factories.first { $0.supports(type) }?.make(from: json) } }.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q19. Mixing POP with UIKit identity (HeroWidget)? `(45–60s)`
**Answer:**

> “HeroWidget needs three things at once: 1. A real view / view-controller lifecycle (class identity) 2. Pause and play when visibility changes 3. Clean contracts so the ads pipeline does not care about player internals.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q20. Architecture choices? `(45–60s)`
**Answer:**

> “See the notes for this topic and speak the core idea in simple words.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q21. YAGNI vs revenue scale? `(45–60s)`
**Answer:**

> “Trap answer: “Always POP everything.” Senior answer: “Introduce POP when variants or test seams demand it. At BookMyShow ads scale, variants justified the pipeline.”.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q22. Protocol inheritance? `(45–60s)`
**Answer:**

> “swift protocol AdRenderable { ... } protocol VideoAdRenderable: AdRenderable, PlaybackControllable { var duration: TimeInterval { get } } You refine capabilities without inventing a class hierarchy.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q23. Conditional helpers? `(45–60s)`
**Answer:**

> “swift extension AdRenderable where Self: PlaybackControllable { func renderAndPrime -> ContentView { let v = makeView pause // safe — Self is playback-capable return v } } ---.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q24. SDK boundary lessons (S10 soft)? `(45–60s)`
**Answer:**

> “Stories SDK reused across a portfolio → public API should expose protocols (and carefully chosen value models), not a forest of concrete types clients must subclass. Say:.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q25. Common interview whiteboard flow (5 min)? `(45–60s)`
**Answer:**

> “Use this for Day 14 architecture dry-run / today’s timed drill: 1. Agenda: “Revenue ads path — problems with inheritance → POP contracts → generics pipeline → HeroWidget lifecycle → trade-offs.” 2. Problem: New creatives forking render code; video lifecycle bugs. 3. Design: Creative / AdTrackable / PlaybackControllable; Pipeline<C: Creative>. 4. Lifecycle: HeroWidget pause/play on visibility. 5. Trade-off: Generics inside; erasure only if a mixed feed requires it. 6. Honesty: No invented fill-rate %; maintainable type-safe pipeline is the claim.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q26. Anti-patterns checklist? `(45–60s)`
**Answer:**

> “---.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q27. Code tour (do before questions)? `(45–60s)`
**Answer:**

> “1. Open code/AdsPipeline.swift — explain each protocol + generic pipeline aloud. 2. Open code/TypeErasureDemo.swift — explain why AnyTrackable exists. 3. Speak one trap: extension dispatch or “why a mixed array of protocols with associated types is hard.” Then continue to 03-production-bridge.md.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q28. Deep self-check? `(45–60s)`
**Answer:**

> “- [ ] Can you draw POP vs inheritance for three ad types? - [ ] Can you explain associated type vs generic parameter in 20s? - [ ] Can you justify type erasure cost in one breath? - [ ] Can you demo the extension-default dispatch surprise? - [ ] Can you deliver the architecture agenda in 15s? If yes → production bridge. If no → re-read §§3–5 and re-speak.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---
