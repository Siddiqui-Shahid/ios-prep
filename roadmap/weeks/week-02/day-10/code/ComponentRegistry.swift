import Foundation

// Learning-lab — Day 10
// Component registry with unknown-type skip + metrics hook.

protocol SDUIMetrics: Sendable {
    func unknownComponent(type: String, schemaVersion: Int)
    func unknownAction(type: String)
}

struct ConsoleSDUIMetrics: SDUIMetrics {
    func unknownComponent(type: String, schemaVersion: Int) {
        print("metric unknown_component type=\(type) v=\(schemaVersion)")
    }
    func unknownAction(type: String) {
        print("metric unknown_action type=\(type)")
    }
}

/// Rendered tree node after registry resolution. UI frameworks map this to views.
enum ResolvedNode: Equatable, Sendable {
    case element(type: String, id: String?, props: [String: String], children: [ResolvedNode], action: SDUIAction?)
}

struct ComponentRegistry: Sendable {
    /// Supported server types. In apps this maps to native view factories.
    var supportedTypes: Set<String>
    var metrics: SDUIMetrics
    var schemaVersionForMetrics: Int

    func resolve(_ node: SDUINode) -> ResolvedNode? {
        guard supportedTypes.contains(node.type) else {
            metrics.unknownComponent(type: node.type, schemaVersion: schemaVersionForMetrics)
            return nil
        }
        let kids = (node.children ?? []).compactMap { resolve($0) }
        return .element(
            type: node.type,
            id: node.id,
            props: node.props ?? [:],
            children: kids,
            action: node.action
        )
    }

    func resolveRoot(_ document: SDUIDocument) -> ResolvedNode? {
        var copy = self
        copy.schemaVersionForMetrics = document.schemaVersion
        return copy.resolve(document.root)
    }
}

struct ActionAllowlist: Sendable {
    var allowed: Set<String>
    var metrics: SDUIMetrics

    func accept(_ action: SDUIAction?) -> SDUIAction? {
        guard let action else { return nil }
        guard allowed.contains(action.type) else {
            metrics.unknownAction(type: action.type)
            return nil
        }
        return action
    }
}
