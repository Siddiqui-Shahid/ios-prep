import Foundation
import Security

/// Learning-lab: SPKI correctness notes for interviews.
/// Not a drop-in production pin validator — teaches the DER hash rule.

enum SPKIPinningNotes {
    static let definition = """
    SPKI pin = SHA-256(Subject Public Key Info DER bytes from the certificate).
    """

    static let commonMistake = """
    Do NOT treat SecKeyCopyExternalRepresentation raw key bytes as SPKI.
    That export is not the SPKI structure; pins will not match real SPKI tooling.
    """

    static let atsVsPinning = """
    ATS = system HTTPS/TLS baseline.
    Pinning = app-level identity check on top of TLS trust evaluation.
    """

    static let s4VsS4A1 = """
    Verified S4: Ads URLSession + HTTPS + SSL pinning + domain whitelist.
    S4-A1 design: backup pins, ship-before-rotate, monitored break-glass — not claimed as shipped runbook.
    """

    /// Pseudocode steps (interview whiteboard) — implementation omitted on purpose.
    static let challengeSteps: [String] = [
        "Receive URLAuthenticationChallenge (server trust)",
        "Evaluate system trust as required",
        "Extract certificate → SPKI DER",
        "SHA-256(SPKI DER) and compare to embedded pins for allowlisted host",
        "On mismatch for sensitive host: cancel (fail closed)",
    ]
}

/*
 Provenance:
 - Learning-lab · SPKI DER correctness
 - Mirrors Verified · S4 ownership mindset
 - Rotation ops → How I would apply it · S4-A1
 */
