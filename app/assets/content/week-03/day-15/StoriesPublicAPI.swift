import Foundation

// Learning-lab public API sketch for a Stories SDK (S10-shaped).
// Hide internal SwiftUI/UIKit types from hosts.

/// Host-facing configuration. Theme/analytics/loaders stay injectable.
public struct StoriesConfiguration: Sendable {
    public var theme: StoriesTheming
    public var analytics: StoriesAnalytics
    public var content: StoriesContentProviding
    public var imageLoader: StoriesImageLoading

    public init(
        theme: StoriesTheming,
        analytics: StoriesAnalytics,
        content: StoriesContentProviding,
        imageLoader: StoriesImageLoading
    ) {
        self.theme = theme
        self.analytics = analytics
        self.content = content
        self.imageLoader = imageLoader
    }
}

public protocol StoriesTheming: Sendable {
    var primaryAccentHex: String { get }
}

public protocol StoriesAnalytics: Sendable {
    func track(event: String, props: [String: String])
}

public protocol StoriesContentProviding: Sendable {
    func fetchTray() async throws -> [StoriesTrayItem]
}

public protocol StoriesImageLoading: Sendable {
    func imageData(for url: URL) async throws -> Data
}

public struct StoriesTrayItem: Identifiable, Sendable, Codable {
    public let id: String
    public let title: String
    public let coverURL: URL
}

public enum StoriesError: Error, Sendable {
    case unavailable
    case cancelled
}

/// Stable entry — hosts should not import StoriesInternals.
public enum StoriesSDK {
    @MainActor
    public static func makeTrayController(config: StoriesConfiguration) -> StoriesTrayControlling {
        StoriesTrayController(config: config)
    }
}

@MainActor
public protocol StoriesTrayControlling: AnyObject {
    func reload()
}

// MARK: - Internal (would be non-public / other module in a real SDK)

@MainActor
final class StoriesTrayController: StoriesTrayControlling {
    private let config: StoriesConfiguration
    init(config: StoriesConfiguration) { self.config = config }
    func reload() {
        config.analytics.track(event: "stories_reload", props: [:])
    }
}
