import Foundation

// Learning-lab: Array stack + naive queue cost demonstration.
// Not production networking code.

struct Stack<Element> {
    private var storage: [Element] = []

    var isEmpty: Bool { storage.isEmpty }
    var count: Int { storage.count }
    var peek: Element? { storage.last }

    mutating func push(_ value: Element) {
        storage.append(value) // amortized O(1)
    }

    @discardableResult
    mutating func pop() -> Element? {
        storage.popLast() // O(1)
    }
}

/// Demonstrates why Array-as-queue via removeFirst is O(n) per dequeue.
/// Prefer TwoStackQueue, a ring, or Swift Collections Deque in real code.
struct NaiveArrayQueue<Element> {
    private var storage: [Element] = []

    mutating func enqueue(_ value: Element) {
        storage.append(value) // amortized O(1)
    }

    @discardableResult
    mutating func dequeue() -> Element? {
        guard !storage.isEmpty else { return nil }
        return storage.removeFirst() // O(n) — shifts
    }
}

/// Head-index queue: dequeue O(1); compact when head grows large.
struct HeadIndexQueue<Element> {
    private var storage: [Element] = []
    private var head = 0

    var count: Int { storage.count - head }
    var isEmpty: Bool { count == 0 }

    mutating func enqueue(_ value: Element) {
        storage.append(value)
    }

    @discardableResult
    mutating func dequeue() -> Element? {
        guard !isEmpty else { return nil }
        let value = storage[head]
        head += 1
        if head > 50 && head * 2 > storage.count {
            storage.removeFirst(head)
            head = 0
        }
        return value
    }
}

enum StackQueueDemo {
    static func run() {
        var s = Stack<Int>()
        s.push(1); s.push(2)
        assert(s.pop() == 2)

        var naive = NaiveArrayQueue<Int>()
        naive.enqueue(10)
        naive.enqueue(20)
        assert(naive.dequeue() == 10)

        var hq = HeadIndexQueue<String>()
        hq.enqueue("a"); hq.enqueue("b")
        assert(hq.dequeue() == "a")
        print("StackAndQueue demo OK")
    }
}
