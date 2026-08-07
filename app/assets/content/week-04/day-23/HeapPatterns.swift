import Foundation

/// Minimal binary heap for interview clarity (min-heap by default).
struct InterviewHeap<Element> {
    private var storage: [Element] = []
    private let areSorted: (Element, Element) -> Bool // true if first should be above second (parent better)

    init(areSorted: @escaping (Element, Element) -> Bool) {
        self.areSorted = areSorted
    }

    var count: Int { storage.count }
    var peek: Element? { storage.first }

    mutating func offer(_ value: Element) {
        storage.append(value)
        siftUp(storage.count - 1)
    }

    @discardableResult
    mutating func poll() -> Element? {
        guard let first = storage.first else { return nil }
        if storage.count == 1 {
            storage.removeLast()
            return first
        }
        storage[0] = storage.removeLast()
        siftDown(0)
        return first
    }

    private mutating func siftUp(_ index: Int) {
        var child = index
        while child > 0 {
            let parent = (child - 1) / 2
            if areSorted(storage[child], storage[parent]) {
                storage.swapAt(child, parent)
                child = parent
            } else { break }
        }
    }

    private mutating func siftDown(_ index: Int) {
        var parent = index
        while true {
            let left = parent * 2 + 1
            let right = left + 1
            var candidate = parent
            if left < storage.count && areSorted(storage[left], storage[candidate]) {
                candidate = left
            }
            if right < storage.count && areSorted(storage[right], storage[candidate]) {
                candidate = right
            }
            if candidate == parent { break }
            storage.swapAt(parent, candidate)
            parent = candidate
        }
    }
}

enum HeapPatterns {
    /// Top K frequent — min-heap of size k by frequency.
    static func topKFrequent(_ nums: [Int], _ k: Int) -> [Int] {
        var freq: [Int: Int] = [:]
        for n in nums { freq[n, default: 0] += 1 }
        var heap = InterviewHeap<(Int, Int)> { a, b in a.1 < b.1 } // min by freq
        for (value, count) in freq {
            heap.offer((value, count))
            if heap.count > k { _ = heap.poll() }
        }
        var result: [Int] = []
        while let (value, _) = heap.poll() { result.append(value) }
        return result
    }

    /// Kth largest in array via min-heap size k.
    static func findKthLargest(_ nums: [Int], _ k: Int) -> Int {
        var heap = InterviewHeap<Int> { $0 < $1 }
        for n in nums {
            heap.offer(n)
            if heap.count > k { _ = heap.poll() }
        }
        return heap.peek!
    }

    final class ListNode {
        var val: Int
        var next: ListNode?
        init(_ val: Int, _ next: ListNode? = nil) { self.val = val; self.next = next }
    }

    /// Merge K sorted lists — heap of heads. O(N log K).
    static func mergeKLists(_ lists: [ListNode?]) -> ListNode? {
        var heap = InterviewHeap<ListNode> { $0.val < $1.val }
        for node in lists {
            if let node { heap.offer(node) }
        }
        let dummy = ListNode(0)
        var tail = dummy
        while let node = heap.poll() {
            tail.next = node
            tail = node
            if let next = node.next { heap.offer(next) }
        }
        return dummy.next
    }
}

/*
 Say this first — Top K Frequent:
 “Frequency map, then min-heap size K — O(n log k). Bucket O(n) alternative when freq ≤ n.”
 */
