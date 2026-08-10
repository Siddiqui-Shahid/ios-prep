# Audio script — Revision guide — MVVM / Clean / MVI · Layering · DI
> Listen-only revision day guide from `day-08.md`.

## §0 1. Outcome

Next. 1. Outcome. Explain aloud, in plain sentences: When to pick M V V M vs Clean vs M V I — and what each layer must never own The layer stack: View → ViewModel → UseCase → Repository → DataSource D I without framework religion: protocol + constructor injection, assembler at module edge.

## §1 2. Concept refresh (simple)

Next. 2. Concept refresh (simple). 2. Concept refresh (simple).

## §2 2.1 Pattern map

Next. 2.1 Pattern map. Default: M V V M for feature U I. Introduce Clean UseCases where rules or migration risk demand it.

## §3 2.2 Layer rules

Next. 2.2 Layer rules. View: layout + forward events — no networking, no business rules ViewModel: U I state, mapping, debounce/cancel — no URLSession UseCase: product policy (“adjust Free Parking billing”) Repository: cache vs remote, DTO mapping — not keystroke timing.

## §4 2.3 Search VM shape

Next. 2.3 Search VM shape. Query → debounce (~300ms) → cancel previous Task → repository → state enum. Debounce is presentation policy in the VM, not the network layer.

## §5 2.4 Critical truths (pin)

Next. 2.4 Critical truths (pin). 2.4 Critical truths (pin).

## §6 3. Read these

Next. 3. Read these. Suggested sample order: 01-layer-stack-di → 02-mvvm-clean-mvi → 03-search-cancel-states → 04-production-s9-s3.

## §7 4. Map to your work

Next. 4. Map to your work. District Free Parking + Clean/M V V M + AI tooling: District Free Parking billing adjustments; M V V M↔Clean migration; Context Engineering; AI-assisted XCTest/XCUITest inside review loop; on-call fixes. BookMyShow backend-driven header & search: Book My Show search debounce, explicit U I states, M V V M binding, cancel stale responses. Interview line (≤20s): “At District I shipped Free Parking while migrating M V V M↔Clean incrementally — AI accelerated scaffolding inside protocols I owned, with tests as the gate.” → District Free Parking + Clean/M V V M + AI tooling Free Parking · BookMyShow backend-driven header & search Search.

## §8 5. Flash prompts

Next. 5. Flash prompts. 1. M V V M vs Clean vs M V I — one-line decision rule each 2. Draw the layer stack; name what each layer must never own 3. Where debounce lives — and why not URLSession 4. Repository vs UseCase with a Free Parking example.

## §9 6. Timed drills

Next. 6. Timed drills. Expand from sample cards and 07-revision-qna answer points.
