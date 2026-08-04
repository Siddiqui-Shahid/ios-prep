import Foundation

// Learning-lab — Day 12
// Identity traps — conceptual markers you can explain aloud.

enum IdentityTrap: String, CaseIterable, Sendable {
    case uuidInBody
    case indexAsIdOnReorder
    case regeneratingPageIdsOnProgressTick
    case anyViewErasureHidingIdentity
    case intentionalSessionReset
}

struct IdentityLesson: Sendable {
    var trap: IdentityTrap
    var symptom: String
    var fix: String
}

enum IdentityPlaybook {
    static let lessons: [IdentityLesson] = [
        .init(
            trap: .uuidInBody,
            symptom: "@State resets every render; text fields clear; representables remake",
            fix: "Use stable model keys; never UUID() inside body for .id"
        ),
        .init(
            trap: .indexAsIdOnReorder,
            symptom: "Wrong row state after insert/delete/reorder",
            fix: "Identifiable business ids, not indices"
        ),
        .init(
            trap: .regeneratingPageIdsOnProgressTick,
            symptom: "Stories progress bar / page resets mid-swipe",
            fix: "Page id from server/host; progress is state, not identity"
        ),
        .init(
            trap: .anyViewErasureHidingIdentity,
            symptom: "Unexpected rebuilds; harder optimization",
            fix: "Prefer opaque some View; erase rarely"
        ),
        .init(
            trap: .intentionalSessionReset,
            symptom: "None — desired logout wipe",
            fix: ".id(sessionID) on purpose when session changes"
        ),
    ]

    static func explainUUIDTrap() -> String {
        """
        Putting .id(UUID()) inside body creates a new identity every time SwiftUI
        evaluates the view. @State storage is tied to identity, so local state
        resets. Animations restart. UIViewControllerRepresentable is remade.
        IDs must come from stable model keys — the same rule for Stories pages (S10).
        """
    }
}

/// Bad vs good ForEach identity (pseudo-models).
struct Row: Hashable, Sendable {
    var id: String
    var title: String
}

enum ForEachExamples {
    static func badIndices(_ rows: [Row]) -> [Int] {
        // Using indices as IDs breaks across mutations.
        Array(rows.indices)
    }

    static func goodIds(_ rows: [Row]) -> [String] {
        rows.map(\.id)
    }
}
