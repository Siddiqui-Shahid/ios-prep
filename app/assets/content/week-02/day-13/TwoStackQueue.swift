import Foundation

/// FIFO queue via two stacks. Dequeue is *amortized* O(1).
struct TwoStackQueue<Element> {
    private var inStack: [Element] = []
    private var outStack: [Element] = []

    var isEmpty: Bool { inStack.isEmpty && outStack.isEmpty }
    var count: Int { inStack.count + outStack.count }

    mutating func enqueue(_ value: Element) {
        inStack.append(value) // O(1) amortized
    }

    @discardableResult
    mutating func dequeue() -> Element? {
        shiftIfNeeded()
        return outStack.popLast()
    }

    func peek() -> Element? {
        // Non-mutating peek requires copy or making shift mutating — interview: mutate then peek.
        // Use mutatingPeek in demos.
        if !outStack.isEmpty { return outStack.last }
        return inStack.first
    }

    mutating func mutatingPeek() -> Element? {
        shiftIfNeeded()
        return outStack.last
    }

    private mutating func shiftIfNeeded() {
        guard outStack.isEmpty else { return }
        while let value = inStack.popLast() {
            outStack.append(value)
        }
    }
}

enum TwoStackQueueDemo {
    static func run() {
        var q = TwoStackQueue<Int>()
        q.enqueue(1); q.enqueue(2); q.enqueue(3)
        assert(q.dequeue() == 1)
        q.enqueue(4)
        assert(q.dequeue() == 2)
        assert(q.mutatingPeek() == 3)
        assert(q.dequeue() == 3)
        assert(q.dequeue() == 4)
        assert(q.dequeue() == nil)
        print("TwoStackQueue demo OK")
    }
}
