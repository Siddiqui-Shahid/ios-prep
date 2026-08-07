import Foundation

// MARK: - LoadState
// Generic UI/async state machine. Prefer this over boolean flags + optional data/error.

enum LoadState<T> {
    case idle
    case loading
    case loaded(T)
    case failed(Error)

    var isLoading: Bool {
        if case .loading = self { return true }
        return false
    }

    var value: T? {
        if case .loaded(let value) = self { return value }
        return nil
    }
}

extension LoadState {
    /// Map a one-shot network/domain `Result` into UI state.
    /// Note: `Result` has no idle/loading — those are UI concerns.
    static func from(result: Result<T, Error>) -> LoadState<T> {
        switch result {
        case .success(let value):
            return .loaded(value)
        case .failure(let error):
            return .failed(error)
        }
    }

    func map<U>(_ transform: (T) -> U) -> LoadState<U> {
        switch self {
        case .idle:
            return .idle
        case .loading:
            return .loading
        case .loaded(let value):
            return .loaded(transform(value))
        case .failed(let error):
            return .failed(error)
        }
    }
}

// MARK: - Payment popup (Applied · S7-A1)
// Design sketch for interview / practice — not a claim that production used this exact enum.

enum PaymentPopupState: Equatable {
    case hidden
    case processing(message: String)
    case success(bookingID: String)
    case failure(message: String)
    case timedOut(message: String)
}

enum PaymentEvent: Equatable {
    case userStartedCheckout
    case backendSuccess(bookingID: String)
    case backendFailure(message: String)
    case timeout
    case dismiss
}

extension PaymentPopupState {
    /// Pure transition function — easy to unit test and reason about in interviews.
    mutating func apply(_ event: PaymentEvent) {
        switch (self, event) {
        case (.hidden, .userStartedCheckout):
            self = .processing(message: "Confirming payment…")

        case (.processing, .backendSuccess(let id)):
            self = .success(bookingID: id)

        case (.processing, .backendFailure(let message)):
            self = .failure(message: message)

        case (.processing, .timeout):
            self = .timedOut(message: "Still working — check your bookings.")

        case (.success, .dismiss),
             (.failure, .dismiss),
             (.timedOut, .dismiss),
             (.processing, .dismiss):
            self = .hidden

        default:
            // Illegal or no-op transitions: ignore (or assert in DEBUG in real apps).
            break
        }
    }
}

// MARK: - Demo helpers (playground / tests)

enum DemoError: Error {
    case network
}

func demoLoadStateMapping() {
    let ok: Result<String, Error> = .success("Showtime locked")
    let bad: Result<String, Error> = .failure(DemoError.network)

    print(LoadState.from(result: ok))
    print(LoadState.from(result: bad))

    var payment = PaymentPopupState.hidden
    payment.apply(.userStartedCheckout)
    payment.apply(.backendSuccess(bookingID: "BMS-123"))
    print(payment)
}
