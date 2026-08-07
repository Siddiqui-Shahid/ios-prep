import Foundation

// Learning-lab — Day 08
// Illustrative Clean edge: Free Parking billing adjustment UseCase.
// Provenance cousin: Verified · S9 (District Free Parking). Not District source.

struct ParkingAdjustmentRequest: Equatable, Sendable {
    var userId: String
    var amountCents: Int
    var reasonCode: String
}

enum ParkingAdjustmentError: Error, Equatable {
    case ineligible
    case invalidAmount
    case persistenceFailed
}

struct ParkingAdjustmentResult: Equatable, Sendable {
    var adjustmentId: String
    var amountCents: Int
}

protocol BillingRepository: Sendable {
    func isEligible(userId: String) async throws -> Bool
    func persistAdjustment(_ request: ParkingAdjustmentRequest) async throws -> String
}

/// Application policy — no UIKit/SwiftUI, no URLSession.
struct AdjustFreeParkingBilling: Sendable {
    var repository: BillingRepository

    func execute(_ request: ParkingAdjustmentRequest) async throws -> ParkingAdjustmentResult {
        guard request.amountCents > 0 else { throw ParkingAdjustmentError.invalidAmount }

        let eligible = try await repository.isEligible(userId: request.userId)
        guard eligible else { throw ParkingAdjustmentError.ineligible }

        // Domain policy illustration: free-parking adjustments capped in UseCase, not UI.
        let capped = ParkingAdjustmentRequest(
            userId: request.userId,
            amountCents: min(request.amountCents, 5_000),
            reasonCode: request.reasonCode
        )

        do {
            let id = try await repository.persistAdjustment(capped)
            return ParkingAdjustmentResult(adjustmentId: id, amountCents: capped.amountCents)
        } catch {
            throw ParkingAdjustmentError.persistenceFailed
        }
    }
}

// Thin VM adapter — owns presentation only.
enum FreeParkingUIState: Equatable {
    case idle
    case submitting
    case success(ParkingAdjustmentResult)
    case failure(String)
}

final class FreeParkingViewModel: @unchecked Sendable {
    private let useCase: AdjustFreeParkingBilling
    private(set) var state: FreeParkingUIState = .idle
    var onStateChange: ((FreeParkingUIState) -> Void)?

    init(useCase: AdjustFreeParkingBilling) {
        self.useCase = useCase
    }

    func submit(_ request: ParkingAdjustmentRequest) {
        state = .submitting
        onStateChange?(state)
        Task {
            do {
                let result = try await useCase.execute(request)
                state = .success(result)
            } catch ParkingAdjustmentError.ineligible {
                state = .failure("Not eligible for Free Parking adjustment")
            } catch ParkingAdjustmentError.invalidAmount {
                state = .failure("Enter a valid amount")
            } catch {
                state = .failure("Couldn’t save adjustment")
            }
            onStateChange?(state)
        }
    }
}
