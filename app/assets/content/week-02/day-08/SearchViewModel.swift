import Foundation

// Learning-lab — Day 08
// Illustrative MVVM search: debounce, cancel, explicit UI states.
// Provenance cousin: Verified · S3 (BMS search debounce / MVVM). Not production BMS source.

enum SearchUIState: Equatable {
    case idle
    case loading(query: String)
    case results([String])
    case empty(query: String)
    case error(message: String, query: String)
}

protocol SearchRepository: Sendable {
    func search(query: String) async throws -> [String]
}

/// Presentation policy lives here: debounce + cancellation + state mapping.
final class SearchViewModel: @unchecked Sendable {
    private let repository: SearchRepository
    private let debounceNanoseconds: UInt64
    private var inFlight: Task<Void, Never>?
    private let lock = NSLock()
    private var _state: SearchUIState = .idle

    var state: SearchUIState {
        lock.lock(); defer { lock.unlock() }
        return _state
    }

    var onStateChange: ((SearchUIState) -> Void)?

    init(repository: SearchRepository, debounceMilliseconds: UInt64 = 300) {
        self.repository = repository
        self.debounceNanoseconds = debounceMilliseconds * 1_000_000
    }

    func onQueryChange(_ raw: String) {
        let query = raw.trimmingCharacters(in: .whitespacesAndNewlines)
        inFlight?.cancel()

        guard !query.isEmpty else {
            publish(.idle)
            return
        }

        inFlight = Task { [weak self] in
            guard let self else { return }
            do {
                try await Task.sleep(nanoseconds: self.debounceNanoseconds)
            } catch {
                return // cancelled during debounce
            }
            guard !Task.isCancelled else { return }

            self.publish(.loading(query: query))
            do {
                let results = try await self.repository.search(query: query)
                guard !Task.isCancelled else { return }
                self.publish(results.isEmpty ? .empty(query: query) : .results(results))
            } catch is CancellationError {
                return
            } catch {
                guard !Task.isCancelled else { return }
                self.publish(.error(message: "Something went wrong", query: query))
            }
        }
    }

    func onDisappear() {
        inFlight?.cancel()
        inFlight = nil
    }

    private func publish(_ newValue: SearchUIState) {
        lock.lock()
        _state = newValue
        lock.unlock()
        onStateChange?(newValue)
    }
}

// MARK: - Fake for XCTest-shaped drills

struct FakeSearchRepository: SearchRepository {
    var result: Result<[String], Error>
    var delayNanoseconds: UInt64 = 0

    func search(query: String) async throws -> [String] {
        if delayNanoseconds > 0 {
            try await Task.sleep(nanoseconds: delayNanoseconds)
        }
        try Task.checkCancellation()
        return try result.get()
    }
}
