import Foundation

// Learning-lab — Day 11
// Cell reuse: generation token + cancel to prevent wrong-image assigns.

protocol ImageLoading: Sendable {
    func load(url: URL) async throws -> Data
}

final class PosterCellModel: @unchecked Sendable {
    private var generation = UUID()
    private var task: Task<Void, Never>?
    private(set) var imageData: Data?
    var onChange: ((Data?) -> Void)?

    func bind(url: URL?, loader: ImageLoading) {
        task?.cancel()
        imageData = nil
        onChange?(nil)
        guard let url else { return }

        let token = UUID()
        generation = token
        task = Task { [weak self] in
            do {
                let data = try await loader.load(url: url)
                guard !Task.isCancelled else { return }
                guard let self, self.generation == token else { return }
                self.imageData = data
                self.onChange?(data)
            } catch is CancellationError {
                return
            } catch {
                guard let self, self.generation == token else { return }
                self.imageData = nil
                self.onChange?(nil)
            }
        }
    }

    /// Call from prepareForReuse-equivalent.
    func prepareForReuse() {
        task?.cancel()
        task = nil
        generation = UUID()
        imageData = nil
        onChange = nil
    }
}
