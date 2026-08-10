# 01 — Foundations: POP, Generics, Associated Types (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Simple language. Named work only — never S-codes in speech.

---

### Q1. Main guiding idea? `(45–60s)`
**Answer:**

> “Build features by combining small capabilities (protocols + generics), not by growing a tall inheritance tree — especially on UI that makes money. We will use BookMyShow Ads and HeroWidget as the real-world hook. You do not need fancy metrics. The claim is: the pipeline stayed type-safe and new ad types could plug in without rewriting the revenue path.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q2. The inheritance trap? `(45–60s)`
**Answer:**

> “Many UIKit tutorials start with a class tree like this: text UIView └── AdView ├── ImageAdView ├── VideoAdView └── CarouselAdView └── SponsoredCarouselAdView.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q3. Think in capabilities? `(45–60s)`
**Answer:**

> “An ad unit is not one giant “ad class”. It is a bag of abilities: - Render into a view → protocol sketch: AdRenderable (listing / hero surface cares) - Track impressions and clicks → AdTrackable (analytics / revenue cares) - Control video pause and play → PlaybackControllable (HeroWidget cares) - Prefetch assets → Prefetchable (scroll performance cares).”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q4. Tiny demo? `(45–60s)`
**Answer:**

> “swift protocol Describable { var summary: String { get } } struct ImageCreative: Describable { let title: String var summary: String { "Image: \(title)" } }.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q5. Requirements vs extension defaults? `(45–60s)`
**Answer:**

> “swift protocol AdTrackable { var creativeID: String { get } func trackImpression func trackClick } extension AdTrackable { // Handy default — but see the dispatch trap in the deep dive func trackClick { print("default click \(creativeID)") } }.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q6. Protocol composition? `(45–60s)`
**Answer:**

> “swift typealias HeroAd = AdRenderable & AdTrackable & PlaybackControllable func installHero<A: HeroAd>(_ ad: A) { // Compiler knows A has all three capability sets }.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q7. Class-bound protocols (`AnyObject`)? `(45–60s)`
**Answer:**

> “swift protocol AdDelegate: AnyObject { func adDidFail(_ error: Error) } final class AdLoader { weak var delegate: AdDelegate? }.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q8. Mental model? `(45–60s)`
**Answer:**

> “A generic parameter is a blank that the caller fills in: swift struct Renderer<Creative> { let creative: Creative }.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q9. Why generics beat `Any` on a revenue path? `(45–60s)`
**Answer:**

> “swift // Fragile func render(_ creative: Any) -> UIView { if let image = creative as? ImageCreative { ... } if let video = creative as? VideoCreative { ... } fatalError("unknown") } // Type-safe pipeline func render<C: AdRenderable>(_ creative: C) -> C.ContentView { creative.makeView }.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q10. `where` clauses (first pass)? `(45–60s)`
**Answer:**

> “swift func merge<C>( _ a: C, _ b: C ) -> C where C: AdTrackable & Equatable { return a == b ? a : b } where keeps the signature readable when constraints grow. You will use this a lot with associated types in the deep dive.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q11. Mental model? `(45–60s)`
**Answer:**

> “An associated type is a blank that the type adopting the protocol fills in: swift protocol AdRenderable { associatedtype ContentView: UIView func makeView -> ContentView }.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q12. Why this feels hard? `(45–60s)`
**Answer:**

> “Once AdRenderable has an associated type, this often fails or is heavily limited: swift let ads: [AdRenderable] = ... // ❌ often illegal / constrained.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q13. Both ideas together? `(45–60s)`
**Answer:**

> “swift protocol Creative { associatedtype Body var body: Body { get } } struct Pipeline<C: Creative> { let creative: C func materialize -> C.Body { creative.body } }.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q14. `some` vs `any` (first cut)? `(45–60s)`
**Answer:**

> “swift func makeBadge -> some Describable { ImageCreative(title: "Badge") // always ImageCreative }.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q15. Protocol extensions as shared behavior? `(45–60s)`
**Answer:**

> “swift protocol Prefetchable { var assetURLs: [URL] { get } func prefetch } extension Prefetchable { func prefetch { assetURLs.forEach { URLSession.shared.dataTask(with: $0).resume } } }.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q16. Conditional conformance (first pass)? `(45–60s)`
**Answer:**

> “swift struct Pair<A, B> { var a: A var b: B } extension Pair: Equatable where A: Equatable, B: Equatable { static func == (lhs: Pair<A, B>, rhs: Pair<A, B>) -> Bool { lhs.a == rhs.a && lhs.b == rhs.b } }.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q17. When inheritance is still OK? `(45–60s)`
**Answer:**

> “POP is a tool, not a religion. Still subclass when UIKit requires it (UIView, UIViewController), when you need shared identity / ObjC runtime (delegates, responders), or when the framework owns the base type (UICollectionViewCell).”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q18. Glossary (pin)? `(45–60s)`
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

### Q19. First production bridge (short)? `(45–60s)`
**Answer:**

> “At BookMyShow, the highest-revenue Ads module was refactored around protocol contracts and generics so rendering stayed type-safe as creatives grew. HeroWidget owned video pause/play against visibility and lifecycle — a reference-type concern sitting on top of a POP pipeline. ≤20s pitch:.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q20. Self-check before deep dive? `(45–60s)`
**Answer:**

> “Without notes, can you: - [ ] Explain POP in one sentence with a capability example? - [ ] Contrast “caller picks T” vs “adopter picks associated type”? - [ ] Say why [AdRenderable] is awkward when AdRenderable has associated types? - [ ] Give one reason generics beat Any casts in an ads pipeline? - [ ] Name when you’d still subclass UIView?”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---
