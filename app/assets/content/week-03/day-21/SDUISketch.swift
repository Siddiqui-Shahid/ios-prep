import Foundation

/// Learning-lab whiteboard crutches for Prompt A (SDUI).

struct SDUILayout: Decodable, Sendable {
    let id: String
    let version: Int
    let screenId: String
    let components: [SDUIComponent]
}

struct SDUIComponent: Decodable, Sendable {
    let type: String
    let id: String
    let props: [String: String]
    let action: SDUIAction?
}

struct SDUIAction: Decodable, Sendable {
    enum Kind: String, Decodable { case deeplink, apiCall, web }
    let type: Kind
    let payload: String
}

protocol ComponentRendering: Sendable {
    func render(_ component: SDUIComponent) -> String // placeholder for native view
}

struct ComponentRegistry: Sendable {
    private let builders: [String: any ComponentRendering]

    init(builders: [String: any ComponentRendering]) {
        self.builders = builders
    }

    func render(_ component: SDUIComponent) -> String {
        guard let builder = builders[component.type] else {
            // Unknown type → empty + metric (never crash)
            return "EmptyPlaceholder(type: \(component.type))"
        }
        return builder.render(component)
    }
}

enum SDUIActionAllowlist {
    static func handle(_ action: SDUIAction) -> String {
        switch action.type {
        case .deeplink: return "DeepLinkRouter.handle(\(action.payload))"
        case .apiCall: return "APIClient.call(\(action.payload))"
        case .web: return "OpenWeb(\(action.payload))"
        }
    }
}

/*
 Speak: versioned layout, registry fallback, allowlisted actions, same deeplink router.
 Provenance: Learning-lab · S3/S12 family
 */
