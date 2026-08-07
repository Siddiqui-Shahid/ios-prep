import Foundation

// Learning-lab — Day 11
// Prefetch with concurrency budget + cancel.

actor PrefetchBudget {
    private let limit: Int
    private var inFlight: [IndexPath: Task<Void, Never>] = [:]
    private var running = 0

    init(limit: Int = 4) {
        self.limit = limit
    }

    func prefetch(paths: [IndexPath], work: @escaping @Sendable (IndexPath) async -> Void) {
        for path in paths {
            guard inFlight[path] == nil else { continue }
            let task = Task { [weak self] in
                await self?.withPermit {
                    await work(path)
                }
                await self?.finished(path)
            }
            inFlight[path] = task
        }
    }

    func cancel(paths: [IndexPath]) {
        for path in paths {
            inFlight[path]?.cancel()
            inFlight[path] = nil
        }
    }

    private func withPermit(_ body: @Sendable () async -> Void) async {
        while running >= limit {
            await Task.yield()
            if Task.isCancelled { return }
        }
        running += 1
        defer { running -= 1 }
        await body()
    }

    private func finished(_ path: IndexPath) {
        inFlight[path] = nil
    }
}

struct IndexPath: Hashable, Sendable {
    var item: Int
    var section: Int
}
