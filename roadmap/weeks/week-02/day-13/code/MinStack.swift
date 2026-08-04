import Foundation

/// O(1) push / pop / top / getMin using an auxiliary min stack.
struct MinStack {
    private var values: [Int] = []
    private var mins: [Int] = []

    mutating func push(_ val: Int) {
        values.append(val)
        if let currentMin = mins.last {
            mins.append(min(currentMin, val))
        } else {
            mins.append(val)
        }
    }

    mutating func pop() {
        guard !values.isEmpty else { return }
        values.removeLast()
        mins.removeLast()
    }

    func top() -> Int {
        values.last! // interview: document precondition non-empty
    }

    func getMin() -> Int {
        mins.last!
    }
}

enum MinStackDemo {
    static func run() {
        var s = MinStack()
        s.push(3); s.push(3); s.push(1); s.push(2)
        assert(s.getMin() == 1)
        s.pop()
        assert(s.getMin() == 1)
        s.pop()
        assert(s.getMin() == 3) // duplicate min preserved
        print("MinStack demo OK")
    }
}
