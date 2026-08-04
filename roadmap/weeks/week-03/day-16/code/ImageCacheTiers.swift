import Foundation

#if canImport(UIKit)
import UIKit
#endif

/// Learning-lab image cache tiers. Downsample is sketched — wire ImageIO in a real app.

struct ImageCacheKey: Hashable, Sendable {
    let url: URL
    let maxPixelSize: Int // targetSize encoded as max pixel dimension
}

actor ImageMemoryCache {
    private let cache = NSCache<NSString, NSData>()
    // NOTE: NSCache is class-bound; wrapping Data for Sendable demo simplicity.

    init(totalCostLimit: Int = 50 * 1024 * 1024) {
        cache.totalCostLimit = totalCostLimit
    }

    func data(for key: ImageCacheKey) -> Data? {
        guard let obj = cache.object(forKey: key.ns) else { return nil }
        return obj as Data
    }

    func set(_ data: Data, for key: ImageCacheKey, cost: Int) {
        cache.setObject(data as NSData, forKey: key.ns, cost: cost)
    }

    func trim() {
        cache.removeAllObjects()
    }
}

extension ImageCacheKey {
    var ns: NSString { "\(url.absoluteString)|\(maxPixelSize)" as NSString }
}

actor ImageLoader {
    private let memory: ImageMemoryCache
    private var inflight: [ImageCacheKey: Task<Data, Error>] = [:]

    init(memory: ImageMemoryCache = ImageMemoryCache()) {
        self.memory = memory
    }

    func load(url: URL, maxPixelSize: Int) async throws -> Data {
        let key = ImageCacheKey(url: url, maxPixelSize: maxPixelSize)
        if let hit = await memory.data(for: key) { return hit }

        if let existing = inflight[key] {
            return try await existing.value
        }

        let task = Task<Data, Error> {
            // L2 disk omitted for brevity — would read Caches then fall through.
            let (bytes, _) = try await URLSession.shared.data(from: url)
            let downsampled = Self.downsample(bytes, maxPixelSize: maxPixelSize)
            let cost = downsampled.count // approx; real cost uses decoded w×h×4
            await memory.set(downsampled, for: key, cost: cost)
            return downsampled
        }
        inflight[key] = task
        defer { inflight[key] = nil }
        return try await task.value
    }

    /// Placeholder — real code uses CGImageSourceCreateThumbnailAtIndex.
    nonisolated static func downsample(_ data: Data, maxPixelSize: Int) -> Data {
        _ = maxPixelSize
        return data
    }

    /// Decoded cost math for interviews.
    static func estimatedDecodedBytes(width: Int, height: Int) -> Int {
        width * height * 4
    }
}

enum ImageCacheDemo {
    static func run() {
        assert(ImageLoader.estimatedDecodedBytes(width: 1000, height: 1000) == 4_000_000)
        print("ImageCacheTiers demo OK — 1000×1000 ≈ 4MB decoded")
    }
}
