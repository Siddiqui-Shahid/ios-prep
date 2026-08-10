# Day 02 — Protocols, POP, Generics, Associated Types, Type Erasure

> Week 1 · Revision pass ~45–60 min  
> Full study: [weeks/week-01/day-02/](../../../weeks/week-01/day-02/README.md)  
> Sample Q&A (guided): [weeks/week-01/day-02/sample/](../../../weeks/week-01/day-02/sample/README.md)

## 1. Outcome

Explain aloud, in plain sentences:

- Protocol-oriented design vs inheritance for UI and ad pipelines
- Generics, associated types, and `where` clauses — who picks the concrete type
- When type erasure is worth it and what it costs at runtime
- How verified BookMyShow Ads pipeline + HeroWidget lifecycle ads work used POP + generics for type-safe rendering

## 2. Concept refresh (simple)

### 2.1 Protocol-Oriented Programming (POP)

Compose **capabilities** (`Renderable`, `Trackable`) with extensions. Inheritance models *what you are*; protocols model *what you can do*. Prefer POP over deep class trees for ad units and SDUI variants.

```swift
protocol AdRenderable {
    associatedtype Content
    func render(_ content: Content) -> UIView
}
```

### 2.2 Generics vs associated types

- **Generics:** the **caller** chooses `T`; compiler can specialize — best for pipelines.
- **Associated type:** the **adopter** chooses the concrete type — awkward in mixed arrays without help.
- Keep APIs generic: `func install<R: AdRenderable>(_ r: R)`. Erase only at boundaries when you must mix shapes.
- Say “protocol with associated type” — not unexplained PAT letter-soup.

### 2.3 Type erasure

When you must store mixed adopters with different associated types, box behind one interface. Cost: allocation, indirection, lost specialization.

### 2.4 Dispatch trap

Extension-only methods may **not** override through an existential — promote to protocol requirements when behavior must vary.

### 2.5 Critical truths (pin)

| Claim | Truth |
|---|---|
| POP | Compose capabilities; inheritance models identity |
| Generics | **Caller** chooses `T` |
| Associated type | **Adopter** chooses the concrete type |
| Mixed `[AdRenderable]` | Awkward — stay generic, erase at boundary, constrained `any`, or closed enum |
| Extension-only method | May not dispatch through existential — promote to requirement |
| Type erasure | Allocation + indirection + lost specialization |
| BookMyShow Ads pipeline + HeroWidget lifecycle | Type-safe ads pipeline + HeroWidget lifecycle — **no** invented fill-rate % |

## 3. Read these

| Priority | Resource | Why |
|---|---|---|
| Must | [Sample Q&A](../../../weeks/week-01/day-02/sample/) | Guided cards |
| Must | Full modules [01–03](../../../weeks/week-01/day-02/01-foundations.md) | Gaps |
| Drill | [07-revision-qna](../../../weeks/week-01/day-02/sample/07-revision-qna.md) | Timed answers |

## 4. Map to your work

**BookMyShow Ads pipeline + HeroWidget lifecycle:** BookMyShow Ads / HeroWidget — refactored highest-revenue module with POP + generics for type-safe rendering; video pause/play lifecycle on HeroWidget.  
**Stories SDK (Raw / Miami Heat):** Stories SDK context — same POP shape, separate story.

**Interview line (≤20s):** “We made ad rendering a generic protocol pipeline so new creatives plugged in without forking the revenue path.”

→ [BookMyShow Ads pipeline + HeroWidget lifecycle Ads](../../stories/story-bank.md#s1--ads-module-refactor--herowidget-bookmyshow) · [Stories SDK (Raw / Miami Heat) Stories SDK](../../stories/story-bank.md#s10--stories-sdk-raw--miami-heat)

## 5. Flash prompts

1. POP in one sentence + one capability example
2. Caller picks `T` vs adopter picks associated type
3. Why a mixed `[AdRenderable]` is awkward — four escape hatches
4. Extension-default dispatch trap through existential
5. Type erasure cost in one breath
6. Static vs dynamic dispatch — when specialization is lost
7. BookMyShow Ads pipeline + HeroWidget lifecycle ≤20s pitch — no invented fill-rate %

## 6. Timed drills

| Drill | Budget |
|---|---|
| BookMyShow Ads pipeline + HeroWidget lifecycle ≤20s pitch | 20s |
| associatedtype vs generic | 45s |
| Four strategies for mixed protocol arrays | 90s |
| Architecture whiteboard (ads pipeline) | 5 min |

Expand from [sample cards](../../../weeks/week-01/day-02/sample/) and [07-revision-qna](../../../weeks/week-01/day-02/sample/07-revision-qna.md) answer points.
