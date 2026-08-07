import Foundation

/// Learning-lab whiteboard crutches for Prompt B (networking + pinning).

protocol APIEndpoint {
    associatedtype Response: Decodable
    var path: String { get }
    var method: String { get }
    var requiresAuth: Bool { get }
}

enum NetworkError: Error {
    case transport
    case http(Int)
    case decoding
    case unauthorized
    case pinMismatch
}

protocol NetworkSession: Sendable {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

/// Interview cue list — not a full pin implementation.
enum PinningCues {
    static let spki = "SHA-256(Subject Public Key Info DER) — NOT SecKeyCopyExternalRepresentation bytes"
    static let s4 = "Verified S4: URLSession + HTTPS + pinning + domain whitelist on Ads"
    static let s4a1 = "S4-A1 design: backup pins, ship-before-rotate, monitored break-glass"
    static let refresh = "Actor single-flight refresh; retry once; failure → logout"
    static let tokens = "Keychain only — never UserDefaults"
    static let obs = "Verified S5: journey p50/p90 (listing/checkout/search)"
    static let cfsHonesty = "S2 path races contribute; do NOT claim S2 alone caused 99.95% CFS"
}

actor SingleFlightRefreshCue {
    private var inFlight: Task<String, Error>?

    func tokenAfterRefresh(using work: @Sendable @escaping () async throws -> String) async throws -> String {
        if let inFlight { return try await inFlight.value }
        let task = Task { try await work() }
        inFlight = task
        defer { inFlight = nil }
        return try await task.value
    }
}

/*
 Speak HLD: features → client → interceptors → URLSession+pin → cache/Keychain.
 Provenance: Learning-lab · S4/S5/S4-A1
 */
