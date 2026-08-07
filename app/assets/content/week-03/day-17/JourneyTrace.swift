import Foundation

/// Learning-lab sketch: journey-level performance spans (S5 / S5-A1 mindset).
/// Not a Firebase SDK wrapper — teaches start/stop discipline + cardinality hygiene.

struct JourneyTrace: Sendable {
    let name: String
    let attributes: [String: String]
    private let startedAt: Date

    private init(name: String, attributes: [String: String], startedAt: Date) {
        self.name = name
        self.attributes = attributes
        self.startedAt = startedAt
    }

    /// Prefer templates over raw URLs — unbounded cardinality + PII risk.
    static func start(
        _ name: String,
        attributes: [String: String] = [:]
    ) -> JourneyTrace {
        // e.g. name: "checkout", attributes: ["network": "wifi"] — not user ids
        JourneyTrace(name: name, attributes: attributes, startedAt: Date())
    }

    func stop(status: Status) -> JourneySample {
        JourneySample(
            name: name,
            attributes: attributes,
            status: status,
            durationMs: Date().timeIntervalSince(startedAt) * 1000
        )
    }

    enum Status: String, Sendable {
        case success
        case failure
        case cancelled
    }
}

struct JourneySample: Sendable {
    let name: String
    let attributes: [String: String]
    let status: JourneyTrace.Status
    let durationMs: Double
}

/// Example placement matching Verified · S5 journeys.
enum BMSJourney {
    static func listingFirstContent() -> JourneyTrace {
        .start("listing_first_content")
    }

    static func searchResults() -> JourneyTrace {
        // Pair with debounce/cancel (S3): cancelled spans should not alarm as failures.
        .start("search_results")
    }

    static func checkoutTerminal() -> JourneyTrace {
        .start("checkout_terminal")
    }
}

/*
 Interview lines this file supports:

 1) "I define clear start/stop events for listing, checkout, and search — then watch p50/p90."
 2) "Journey traces for product SLIs; finer per-request spans only when debugging chatter (S5-A1)."
 3) "Trace names stay low-cardinality; no raw URLs or PII attributes."

 Provenance: Learning-lab · mirrors Verified · S5 culture (not a claim you shipped this exact type).
 */
