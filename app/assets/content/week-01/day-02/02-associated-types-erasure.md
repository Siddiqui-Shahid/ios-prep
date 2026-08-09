# Sample 02 — Associated types, dispatch, type erasure (Q&A)

> Guided teaching. Prefer saying **“protocol with associated type”** in speech — not unexplained PAT letter-soup.  
> Say the **Answer** out loud. **Brain puzzles** at the bottom.

---

### Q1. How is an associated type different from a generic parameter?

**Answer:**

> “A generic parameter is filled in by the caller — Renderer of ImageCreative. An associated type is filled in by the type that adopts the protocol — ImageAd decides what its ContentView is. Generics: I tell the function what T is. Associated types: the adopter decides.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Mini example? | “AdRenderable has associatedtype ContentView; image returns UIImageView, video returns another view type.” |
| Why is that powerful? | “Flexible contracts without a shared base class.” |
| Why does it feel hard? | “Different adopters pick different shapes — hard to put in one plain array.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q2. Why does a “simple protocol variable” stop working with associated types?

**Answer:**

> “Each adopter may pick a different Model and ContentView. Three situations get hard: mixed arrays — image and video in one list; returning the protocol from a function — which associated types came back?; storing a property typed only as the protocol — same unknown shape. The language needs a concrete answer or a strategy that hides the differences. Self and associated types also block unconstrained any for some operations.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Were these always usable as simple existentials? | “Historically no. Modern Swift improved some cases; you still need a plan.” |
| Four strategies? | “Stay generic end-to-end; type-erase at the boundary; constrained any P; closed enum of known creatives.” |
| Decision to memorize? | “Stay generic while you can; erase only when you must mix shapes.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q3. What do primary associated types buy you — and what don’t they?

**Answer:**

> “Primary associated types let you pin down part of the shape — for example any AdRenderable of HeroModel. That helps some call sites. It does not magically make every protocol with associated types free as an unconstrained any-P array for every operation. If ContentView still differs, mixed storage can still hurt.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Interview line? | “They fix part of the type shape — they don’t make every associated-type protocol free as a mixed array.” |
| Still need erasure sometimes? | “Yes — when you need one usable type for heterogeneous storage.” |
| Same idea in Apple’s libs? | “AnyIterator, AnySequence, AnyPublisher exist because associated types block easy existentials.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q4. What is the extension-default dispatch trap — and the static / witness / @objc triad?

**Answer:**

> “Requirements called through an existential go through a witness table — dynamic, protocol-scoped. Extension-only methods may bind to the static type. So let p: any Greeter = Person(); p.wave() can call the extension default, not Person.wave, if wave was never a requirement. Triad: concrete, final, or specialized generics → static dispatch; protocol requirements via existential → witness table; @objc → message send. Fix: declare methods you need to customize as requirements.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One interview sentence? | “Generics can specialize; existentials use witness tables; extension defaults that aren’t requirements may bind statically.” |
| Ads angle? | “Shared identical track() defaults in an extension are fine; custom per-creative overrides must be requirements.” |
| Why mention @objc? | “ObjC message send is a third dispatch story — don’t conflate it with Swift witness tables.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q5. What is type erasure, and when do you need it?

**Answer:**

> “Type erasure builds one concrete box — like AnyAd or AnyTrackable — that can hold different adopters behind a common interface. You need it when you want an array of mixed ads but the original protocol has associated types that block a plain mixed array. Prefer generics inside the hot pipeline; erase at module boundaries or heterogeneous lists only.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| How does a hand-rolled eraser work? | “Store the needed operations as closures — often _track — and upcast views to UIView when you need a common surface.” |
| Same idea as Combine? | “AnyPublisher hides nested generic publisher types — same motive.” |
| Demo file? | “TypeErasureDemo.swift — AnyTrackable wrapping Banner and Interstitial.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q6. What costs of type erasure must you say aloud?

**Answer:**

> “Name four costs: allocation — closures and the box often on the heap; indirection — extra call through a stored function; lost specialization — compiler sees AnyAd, not VideoAd; and a narrower API — rich associated types shrink to a common denominator. Erasure is not free abstraction.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Senior rule? | “Generics inside; erase at the boundary only.” |
| Trap answer? | “‘Type erasure is free.’” |
| When still worth it? | “True mixed feed, plugin registry, or public boundary that must hide nested generics.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q7. Open registry vs closed enum — when each?

**Answer:**

> “A closed enum of known creatives is simple and exhaustive — but every new type is an app release plus an enum edit. An open protocol registry of factories matches CMS growth better — with an explicit unknown fallback and versioning. Soft bridge to backend-driven header and search at BookMyShow; keep Day 02 centered on Ads pipeline plus HeroWidget lifecycle.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Pros of enum? | “Exhaustive switches; simple mental model.” |
| Cons of open registry? | “Unknown types need fallback; versioning matters.” |
| POP connection? | “Factories and capabilities are the same composition instinct.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle; BookMyShow backend-driven header & search
- **Design if asked:** Unknown-component fallback + versioning — label design, not a Day 02 core claim.
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

---

### Q8. How do some and any differ once associated types enter?

**Answer:**

> “Opaque some still means one concrete type — specialization-friendly, but the caller cannot swap types. Existential any may hold different adopters, yet operations involving Self or associated types may be unavailable unless constrained. When associated types block you, reach for generics, erasure, or constrained any — not wishful unconstrained any-P for everything.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Hide one return type? | “Prefer some P.” |
| Store different adopters? | “any P if allowed, else type eraser.” |
| Max performance in hot bind? | “Generics or some on a stable concrete type.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q9. Stay generic vs erase vs closed enum — decision aloud

**Answer:**

> “Hot path with one creative shape at a time — stay generic end-to-end so the compiler sees the real type. True mixed feed or plugin boundary — erase to one concrete box, accepting allocation and lost specialization. Stable small set of creatives — closed enum with exhaustive switches; every new case is a release. Primary associated types help pin Model but don’t replace that decision.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Wrong default? | “Erasing every generic ‘just in case.’” |
| Interview signal? | “You name the trade-off before picking the tool.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

## Brain puzzles (cover → think → check)

### Puzzle A — Why `[AdRenderable]` fails with associated View

```swift
protocol AdRenderable {
    associatedtype ContentView: UIView
    func makeView() -> ContentView
}
// let feed: [AdRenderable] = [ImageAd(), VideoAd()]  // ?
```

**Ask:** Why is this awkward or illegal as a plain mixed array?

**Answer:** Image and video pick different `ContentView` types. The existential doesn’t know a single view shape. Stay generic, erase to a common surface (often UIView), use constrained `any`, or a closed enum.

---

### Puzzle B — Stay generic vs erase vs closed enum

CMS may ship new creative kinds weekly. Product wants one feed list today.

**Ask:** Which strategy, and why?

**Answer:** Open registry / erasure at the list boundary fits CMS growth — with unknown fallback. Hot bind inside each cell can stay generic. Closed enum fights weekly CMS. Don’t erase the entire pipeline.

---

### Puzzle C — Cost of erasure

Interviewer: “We’ll just wrap everything in AnyAd — cheaper than thinking about generics.”

**Good reply:** “You pay allocation, indirection, lost specialization, and a narrower API. I’ll erase at the mixed-list or module edge. Inside the revenue bind path I keep generics so the compiler still sees VideoAd.”

---

Next: [03-pipeline-and-code.md](03-pipeline-and-code.md)
