# Day 12 — SwiftUI State · Identity · @Observable · Lists

> Week 2 · Revision pass ~45–60 min  
> Full study: [weeks/week-02/day-12/](../../../weeks/week-02/day-12/README.md)  
> Sample Q&A (guided): [weeks/week-02/day-12/sample/](../../../weeks/week-02/day-12/sample/README.md)

## 1. Outcome

Explain aloud, in plain sentences:

- State ownership: `@State`, `@Binding`, `@Observable`, `@Environment` — what lives where
- Identity traps: structural vs explicit; why `.id(UUID())` in body resets everything
- List performance: `List` / `LazyVStack` with stable IDs — not eager `VStack` of thousands
- When to hoist async/domain to VM vs keep ephemeral UI local
- Stories SDK (Raw / Miami Heat) Stories SDK — public API + host isolation

## 2. Concept refresh (simple)

### 2.1 Ownership rules

| Wrapper | Owns | Use for |
|---|---|---|
| `@State` | View-local ephemeral UI | Toggles, field focus, sheet flags |
| `@Binding` | Two-way to parent state | Child controls parent value |
| `@Observable` / `@Bindable` | Shared model (iOS 17+) | Async VM, shared feature state |
| `@Environment` | Injected dependencies | Theme, router — not hidden networking |

Not every toggle belongs in a ViewModel. Hoist when async, shared, or testable.

### 2.2 Identity traps

SwiftUI tracks view **identity** across updates. `@State` lifetime follows identity — changing `.id` destroys and recreates state.

**Trap:** `.id(UUID())` in `body` → text fields clear, representables remake, scroll position lost. Same pain as Day 11 hybrid hosting.

### 2.3 Lists at scale

Large data → `List` or `LazyVStack` with **stable** `Identifiable` IDs. Eager `VStack` of thousands = layout storm. Invalidation storms from unstable IDs look like “SwiftUI is slow.”

### 2.4 Critical truths (pin)

| Claim | Truth |
|---|---|
| `@State` | View-local **ephemeral** UI — not every toggle in VM |
| `@Observable` | iOS **17+** — still explain `ObservableObject` for legacy |
| Identity | `@State` lifetime follows identity — `.id(UUID())` in body resets everything |
| Lists | `List` / `LazyVStack` for large data — not eager `VStack` of thousands |
| Stories SDK (Raw / Miami Heat) | Reusable SDK = **public API + host isolation** — not hardcoded networking |
| Trap | UUID in `.id` → text fields clear, representables remake (Day 11 pain) |

## 3. Read these

| Priority | Resource | Why |
|---|---|---|
| Must | [Sample Q&A](../../../weeks/week-02/day-12/sample/) | Guided cards |
| Must | Full modules [01–03](../../../weeks/week-02/day-12/01-foundations.md) | Gaps |
| Drill | [04-questions](../../../weeks/week-02/day-12/04-questions.md) | Timed answers |

Suggested sample order: `01-state-ownership` → `02-identity-traps` → `03-lists-performance` → `04-production-s10`.

## 4. Map to your work

**Stories SDK (Raw / Miami Heat):** Standalone reusable Stories SDK — clear public API; isolation from app-specific networking via injectable boundaries; adopted across portfolio apps (Raw / Miami Heat).

**Interview line (≤20s):** “I built a reusable Stories SDK — clear public API and host isolation — so multiple NBA/WNBA portfolio apps shared one stories implementation.”

→ [Stories SDK (Raw / Miami Heat) Stories SDK](../../stories/story-bank.md#s10--stories-sdk-raw--miami-heat)

## 5. Flash prompts

1. `@State` vs `@Observable` — what stays view-local?
2. Identity vs structural equality — one concrete trap
3. Why `.id(UUID())` in body destroys text field state
4. List vs eager VStack at 1000+ rows
5. Stable IDs — what makes an ID “unstable”?
6. Stories SDK (Raw / Miami Heat) SDK isolation — injectable loaders, not hardcoded Alamofire
7. `@Observable` vs `ObservableObject` — when legacy matters
8. Stories SDK (Raw / Miami Heat) ≤20s pitch

## 6. Timed drills

| Drill | Budget |
|---|---|
| State ownership map | 60s |
| Identity trap explanation (UUID `.id`) | 60s |
| List performance checklist | 45s |
| Stories SDK (Raw / Miami Heat) ≤20s pitch | 20s |
| Stories SDK (Raw / Miami Heat) full STAR | 2–3 min |

Expand from [sample cards](../../../weeks/week-02/day-12/sample/) and [04-questions](../../../weeks/week-02/day-12/04-questions.md) answer points.
