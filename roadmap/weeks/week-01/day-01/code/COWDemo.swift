import Foundation

// MARK: - Standard library COW (Array)
// Assignment shares a buffer; mutation copies when the buffer is not uniquely referenced.

enum COWDemo {
    static func arrayShareUntilWrite() {
        var a = [1, 2, 3]
        var b = a          // cheap share
        print("before mutate a=\(a) b=\(b)")

        b.append(4)        // b becomes unique; a unchanged
        print("after  mutate a=\(a) b=\(b)")
        // Expected: a == [1,2,3], b == [1,2,3,4]
    }

    /// Wrapping the array in a class shares *identity* — not the same as Array COW across names.
    static func classBoxBreaksIndependence() {
        final class ArrayBox {
            var values: [Int]
            init(_ values: [Int]) { self.values = values }
        }

        let box1 = ArrayBox([1, 2])
        let box2 = box1
        box2.values.append(3)
        print("box1=\(box1.values) box2=\(box2.values)")
        // Expected: both [1,2,3] — shared class instance
    }
}

// MARK: - Hand-rolled COW value type
// Value façade over a reference-counted buffer. Interviewers love this sketch.

final class IntBuffer {
    var items: [Int]
    init(_ items: [Int]) { self.items = items }
}

struct COWList {
    private var storage: IntBuffer

    init(_ items: [Int] = []) {
        storage = IntBuffer(items)
    }

    var items: [Int] { storage.items }

    private mutating func ensureUniqueStorage() {
        if !isKnownUniquelyReferenced(&storage) {
            storage = IntBuffer(storage.items)
        }
    }

    mutating func append(_ value: Int) {
        ensureUniqueStorage()
        storage.items.append(value)
    }
}

enum HandmadeCOWDemo {
    static func run() {
        var a = COWList([1, 2, 3])
        var b = a
        b.append(4)
        print("handmade a=\(a.items) b=\(b.items)")
        // Expected: a == [1,2,3], b == [1,2,3,4]
    }
}

// Uncomment to run in a playground / command-line context:
// COWDemo.arrayShareUntilWrite()
// COWDemo.classBoxBreaksIndependence()
// HandmadeCOWDemo.run()
