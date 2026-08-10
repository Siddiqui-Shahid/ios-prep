# Day 01 — Value vs Reference, COW, Enums, Actors Intro

> Week 1 · Revision pass ~45–60 min  
> Full study: [weeks/week-01/day-01/](../../../weeks/week-01/day-01/README.md)  
> Sample Q&A (guided): [weeks/week-01/day-01/sample/](../../../weeks/week-01/day-01/sample/README.md)

## 1. Outcome

Explain aloud, in plain sentences:

- When to pick `struct`, `class`, `enum`, or `actor` — and what breaks if you choose wrong
- Copy-on-write: cheap share until write; when a real buffer copy happens
- Associated-value enums as state machines that eliminate impossible UI states
- How value semantics show up in verified ads/payment work — and how actors bridge to Day 05

## 2. Concept refresh (simple)

### 2.1 Value vs reference

Structs and enums copy **snapshots**; classes share **identity** on the heap. `let` vs `var` controls the **binding** — not the same question as value vs reference.

| Type | Semantics | Typical use |
|---|---|---|
| `struct` / `enum` | Independent copies | Models, DTOs, state |
| `class` | Shared identity | UIKit objects, shared services |
| `actor` | Isolated reference type | Safe shared mutability across tasks |

### 2.2 Copy-on-write (COW)

Array, String, Dictionary, Set share a buffer until a mutation needs a unique copy. Assigning is cheap; mutating may copy if not uniquely referenced.

### 2.3 Enums as state machines

Associated values + exhaustive `switch` turn “isLoading + optional error + optional data” into one legal state at a time.

```swift
enum LoadState<T> {
    case idle, loading, loaded(T), failed(Error)
}
```

### 2.4 Actors (intro)

An actor is a reference type with **isolated** mutable state — callers `await` to touch it. Not a drop-in replacement for every class; Day 05 deepens.

### 2.5 Critical truths (pin)

| Claim | Truth |
|---|---|
| Value vs reference | Structs copy; classes share heap identity |
| `let` vs `var` | Binding mutability — separate from value vs reference |
| COW | Share buffer until write; copy if not uniquely referenced |
| Enum state | Impossible combinations → compile errors, not runtime bugs |
| Actor intro | Isolated ref type; `await` to touch state — not “replace all classes” |
| BookMyShow Ads pipeline + HeroWidget lifecycle | Type-safe ads pipeline + HeroWidget lifecycle — **no** invented fill-rate % |
| BookMyShow payment processing-status popup | Processing popup with explicit status — **no** invented drop-off % |
| Design: payment status pattern (not shipped) / Design: actor SafeDict (not shipped) | **How I would apply it** — design patterns, not shipped claims |

## 3. Read these

| Priority | Resource | Why |
|---|---|---|
| Must | [Sample Q&A](../../../weeks/week-01/day-01/sample/) | Guided cards |
| Must | Full modules [01–03](../../../weeks/week-01/day-01/01-foundations.md) | Gaps |
| Drill | [07-revision-qna](../../../weeks/week-01/day-01/sample/07-revision-qna.md) | Timed answers |

## 4. Map to your work

**BookMyShow Ads pipeline + HeroWidget lifecycle:** BookMyShow Ads — value-friendly render models in a type-safe pipeline; HeroWidget video pause/play lifecycle.  
**BookMyShow payment processing-status popup:** Payment processing popup modeled as explicit states, not boolean flags.  
**Design: payment status pattern (not shipped) / Design: actor SafeDict (not shipped):** How you would extend enum-state or actor patterns — not shipped claims.

**Interview line (≤20s):** “I default to structs for ad and listing models so accidental shared mutation can’t corrupt revenue UI; classes and actors only at identity or concurrency boundaries.”

→ [BookMyShow Ads pipeline + HeroWidget lifecycle Ads](../../stories/story-bank.md#s1--ads-module-refactor--herowidget-bookmyshow) · [BookMyShow payment processing-status popup Payment](../../stories/story-bank.md#s7--payment-processing-time-popup-bookmyshow)

## 5. Flash prompts

1. Struct vs class in one sentence + one BMS example
2. `let` vs `var` vs value vs reference — keep them separate
3. COW in one breath: when does a real copy happen?
4. Why enums beat `isLoading` + optional flags for payment UI
5. Value type containing a class — what copies, what shares?
6. Actor intro: isolated reference type, not “replace all classes”
7. BookMyShow Ads pipeline + HeroWidget lifecycle ≤20s — no invented metrics
8. BookMyShow payment processing-status popup state-machine pitch — no invented drop-off %

## 6. Timed drills

| Drill | Budget |
|---|---|
| struct vs class | 45s |
| COW mental model | 45s |
| enum state machine (BookMyShow payment processing-status popup) | 60s |
| actor intro + GCD bridge | 45s |
| BookMyShow Ads pipeline + HeroWidget lifecycle ≤20s pitch | 20s |

Expand from [sample cards](../../../weeks/week-01/day-01/sample/) and [07-revision-qna](../../../weeks/week-01/day-01/sample/07-revision-qna.md) answer points.
