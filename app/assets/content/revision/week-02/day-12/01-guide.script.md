# Audio script — Revision guide — SwiftUI State · Identity · @Observable · Lists
> Listen-only revision day guide from `day-12.md`.

## §0 1. Outcome

Next. 1. Outcome. Explain aloud, in plain sentences: State ownership: @State, @Binding, @Observable, @Environment — what lives where Identity traps: structural vs explicit; why .id(UUID()) in body resets everything List performance: List / LazyVStack with stable IDs — not eager VStack of thousands.

## §1 2. Concept refresh (simple)

Next. 2. Concept refresh (simple). 2. Concept refresh (simple).

## §2 2.1 Ownership rules

Next. 2.1 Ownership rules. Not every toggle belongs in a ViewModel. Hoist when async, shared, or testable.

## §3 2.2 Identity traps

Next. 2.2 Identity traps. SwiftUI tracks view identity across updates. @State lifetime follows identity — changing .id destroys and recreates state. Trap: .id(UUID()) in body → text fields clear, representables remake, scroll position lost. Same pain as Day 11 hybrid hosting.

## §4 2.3 Lists at scale

Next. 2.3 Lists at scale. Large data → List or LazyVStack with stable Identifiable IDs. Eager VStack of thousands = layout storm. Invalidation storms from unstable IDs look like “SwiftUI is slow.”.

## §5 2.4 Critical truths (pin)

Next. 2.4 Critical truths (pin). 2.4 Critical truths (pin).

## §6 3. Read these

Next. 3. Read these. Suggested sample order: 01-state-ownership → 02-identity-traps → 03-lists-performance → 04-production-s10.

## §7 4. Map to your work

Next. 4. Map to your work. Stories S D K (Raw / Miami Heat): Standalone reusable Stories S D K — clear public A P I; isolation from app-specific networking via injectable boundaries; adopted across portfolio apps (Raw / Miami Heat). Interview line (≤20s): “I built a reusable Stories S D K — clear public A P I and host isolation — so multiple NBA/WNBA portfolio apps shared one stories implementation.” → Stories S D K (Raw / Miami Heat) Stories S D K.

## §8 5. Flash prompts

Next. 5. Flash prompts. 1. @State vs @Observable — what stays view-local? 2. Identity vs structural equality — one concrete trap 3. Why .id(UUID()) in body destroys text field state 4. List vs eager VStack at 1000+ rows.

## §9 6. Timed drills

Next. 6. Timed drills. Expand from sample cards and 07-revision-qna answer points.
