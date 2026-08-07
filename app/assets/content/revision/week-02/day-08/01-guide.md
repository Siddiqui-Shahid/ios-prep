# Day 08 — MVVM / Clean / MVI · Layering · DI

> Week 2 · Revision pass ~45–60 min  
> Full study: [weeks/week-02/day-08/](../../../weeks/week-02/day-08/README.md)  
> Sample Q&A (guided): [weeks/week-02/day-08/sample/](../../../weeks/week-02/day-08/sample/README.md)

## 1. Outcome

Explain aloud, in plain sentences:

- When to pick MVVM vs Clean vs MVI — and what each layer must never own
- The layer stack: View → ViewModel → UseCase → Repository → DataSource
- DI without framework religion: protocol + constructor injection, assembler at module edge
- District Free Parking + Clean/MVVM + AI tooling Free Parking migration with AI as accelerator inside your envelope
- BookMyShow backend-driven header & search BMS search: debounce, cancel, explicit idle/loading/results/empty/error

## 2. Concept refresh (simple)

### 2.1 Pattern map

| Pattern | Core idea | Best fit |
|---|---|---|
| **MVVM** | View renders state; VM owns presentation + async | Feature screens, search, forms |
| **Clean** | UseCases + entities independent of UI | Shared domain, migration, heavy rules |
| **MVI** | Intent → reduce → State → View | Many async sources on one screen |

Default: **MVVM for feature UI**. Introduce Clean UseCases where rules or migration risk demand it.

### 2.2 Layer rules

- **View:** layout + forward events — no networking, no business rules
- **ViewModel:** UI state, mapping, debounce/cancel — no URLSession
- **UseCase:** product policy (“adjust Free Parking billing”)
- **Repository:** cache vs remote, DTO mapping — not keystroke timing

### 2.3 Search VM shape

Query → debounce (~300ms) → cancel previous `Task` → repository → state enum. Debounce is **presentation policy** in the VM, not the network layer.

### 2.4 Critical truths (pin)

| Claim | Truth |
|---|---|
| Default pattern | MVVM for feature UI; Clean UseCases where rules/migration demand |
| Debounce | Lives in ViewModel (presentation policy), not URLSession |
| Repository vs UseCase | Repo = where bytes come from; UseCase = what product should do |
| DI default | Protocol + constructor injection; assembler at module edge |
| District Free Parking + Clean/MVVM + AI tooling AI line | Accelerator inside envelope — you own architecture, not the tool |
| BookMyShow backend-driven header & search search | Explicit idle/loading/results/empty/error + cancel stale work |
| Forbidden | “AI wrote our Clean Architecture” or “whole app is Clean” |

## 3. Read these

| Priority | Resource | Why |
|---|---|---|
| Must | [Sample Q&A](../../../weeks/week-02/day-08/sample/) | Guided cards |
| Must | Full modules [01–03](../../../weeks/week-02/day-08/01-foundations.md) | Gaps |
| Drill | [04-questions](../../../weeks/week-02/day-08/04-questions.md) | Timed answers |

Suggested sample order: `01-layer-stack-di` → `02-mvvm-clean-mvi` → `03-search-cancel-states` → `04-production-s9-s3`.

## 4. Map to your work

**District Free Parking + Clean/MVVM + AI tooling:** District Free Parking billing adjustments; MVVM↔Clean migration; Context Engineering; AI-assisted XCTest/XCUITest inside review loop; on-call fixes.  
**BookMyShow backend-driven header & search:** BMS search debounce, explicit UI states, MVVM binding, cancel stale responses.

**Interview line (≤20s):** “At District I shipped Free Parking while migrating MVVM↔Clean incrementally — AI accelerated scaffolding inside protocols I owned, with tests as the gate.”

→ [District Free Parking + Clean/MVVM + AI tooling Free Parking](../../stories/story-bank.md#s9--free-parking--cleanmvvm--ai-tooling-district) · [BookMyShow backend-driven header & search Search](../../stories/story-bank.md#s3--backend-driven-header--search-bookmyshow)

## 5. Flash prompts

1. MVVM vs Clean vs MVI — one-line decision rule each
2. Draw the layer stack; name what each layer must never own
3. Where debounce lives — and why not URLSession
4. Repository vs UseCase with a Free Parking example
5. DI default without a container framework
6. Fat ViewModel smells and the strangler fix
7. District Free Parking + Clean/MVVM + AI tooling AI wording — accelerator, not author of record
8. BookMyShow backend-driven header & search search state enum + cancel stale work

## 6. Timed drills

| Drill | Budget |
|---|---|
| Layer stack whiteboard | 60s |
| MVVM vs Clean decision rule | 45s |
| BookMyShow backend-driven header & search search VM shape (debounce/cancel/states) | 90s |
| District Free Parking + Clean/MVVM + AI tooling ≤20s pitch — AI envelope wording | 20s |
| District Free Parking + Clean/MVVM + AI tooling full STAR | 2–3 min |

Expand from [sample cards](../../../weeks/week-02/day-08/sample/) and [04-questions](../../../weeks/week-02/day-08/04-questions.md) answer points.
