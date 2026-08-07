# Audio script — Flashcards — App Modularization, SPM & DI Graphs
> Listen-only flashcard Q&A from `week-03.md`. Spoken answers.

## §0 Q1. Feature A → Feature B

Next. Feature A → Feature B? Answer. Depend on B’s Interface, never B’s Impl.

## §1 Q2. Composition root

Next. Composition root? Answer. App target wires concrete builders.

## §2 Q3. NetworkManager.shared in features

Next. NetworkManager.shared in features? Answer. Anti-pattern — hides D I graph.

## §3 Q4. Packaging vs architecture

Next. Packaging vs architecture? Answer. Clean boundary can live in CocoaPods or S P M.

## §4 Q5. Service locator

Next. Service locator? Answer. Runtime missing deps — constructor/tree D I is safer.

## §5 Q6. Stories SDK (Raw / Miami Heat)

Next. Stories S D K (Raw / Miami Heat)? Answer. Standalone Stories S D K + portfolio adoption — no invented build-time %.
