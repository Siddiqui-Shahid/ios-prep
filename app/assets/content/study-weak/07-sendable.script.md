# Audio script — Drill — Sendable and actors

## §0 Introduction

Drill — Sendable and actors From: 26 Aug. They asked actor vs main actor vs Sendable . You said Sendable “makes the class aggressive” and that the check happens at compile time. Compile-time is the only true part.

## §1 Keywords

- Actor (reference type that serializes its mutable state). - MainActor (UI work: @MainActor view models, UIKit). - Sendable (the value is safe to copy across concurrency domains — usually structs, or classes that are immutable / locked). - Data race (two tasks mutate the same memory without isolation).

## §2 Target answer (45s)

“An actor protects mutable state. UI stays on MainActor. Sendable means this type can cross an actor boundary without a data race — not that the class becomes ‘aggressive.’ I mark a class Sendable only if it is immutable or internally synchronized. If I am unsure, I pass a struct snapshot, not a live class.”
