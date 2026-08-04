# 05 — Exercises

> Solutions in-repo. Speak before peeking.

## A. Conceptual

### A1. Draw the graph
Ticketing app: App, Checkout, Search, Ads, MediaStories, CoreNetwork. Mark Interface vs Impl and one protocol-only nav arrow.

**Solution:** Impls hang under App; cross arrows only to `*Interface`; App wires builders. MediaStories/Stories is a reusable product module (S10 shape).

### A2. Forbidden import?
`CheckoutImpl` imports `CartImpl` to push a VC. Fix?

**Solution:** Depend on `CartBuildable` in CartInterface; App provides CartImpl builder.

### A3. Interface smell
`CheckoutInterface` imports UIKit and exposes `CheckoutViewController` subclass. What’s wrong + fix?

**Solution:** Interfaces should stay lean. Prefer `CheckoutBuildable` returning opaque `UIViewController` from Impl, or keep UI types in Impl only.

### A4. Provenance rewrite
Bad: “I built Needle at Raw and cut build times 70% with 80 SPM modules.”  

**Solution:** “I designed a standalone Stories SDK with a public API and host-injected deps, adopted across portfolio apps (S10). I don’t have a verified 70% build-time metric to quote.”

### A5. Packaging vs architecture
One sentence each: CocoaPods vs SPM; modular architecture.

**Solution:** Packaging = how you distribute targets. Architecture = Interface/Impl graph + DI + public API. Clean pods and messy SPM both exist.

---

## B. Coding

1. Read [code/Package.swift](code/Package.swift) — explain target deps aloud; name the forbidden edge.  
2. Read [code/StoriesPublicAPI.swift](code/StoriesPublicAPI.swift) — list public protocols hosts must supply.  
3. Read [code/CompositionRoot.swift](code/CompositionRoot.swift) — where is the composition root? Why isn’t network a feature singleton?  
4. Optional: add `CartBuildable` protocol + register a fake in `AppComponent`.  
5. Optional: sketch how `StoriesConfiguration` would be built inside `AppComponent` for Heat vs Aces themes.

---

## C. Speaking drills

1. S10 STAR ≤ 3 min (record).  
2. Q4 composition root ≤ 45s.  
3. Q9 extract Stories ≤ 60s.  
4. T1 folders vs packages ≤ 120s.  
5. T2 locator vs constructor ≤ 120s.  
6. T6 pod vs architecture ≤ 120s.  
7. T8 portfolio versioning ≤ 120s.

---

## D. Whiteboard (10–12 min)

Agenda first, then draw:

1. App composition root  
2. Two features with Interface-only cross nav  
3. Stories SDK box with injected `ImageLoading` / analytics  
4. Static vs dynamic callout in one sentence  

---

## E. Timed drill

Record **Q4, Q9, Q6** + **T1, T6**. Score via timing guide.

Revision twin: [`../../../revision/weeks/week-03/day-15.md`](../../../revision/weeks/week-03/day-15.md)
