import Foundation

/// Daily Temperatures: for each day, days until a warmer temperature (0 if none).
/// Monotonic decreasing stack of indices — O(n).
enum MonotonicStack {
    static func dailyTemperatures(_ temperatures: [Int]) -> [Int] {
        var answer = Array(repeating: 0, count: temperatures.count)
        var stack: [Int] = [] // indices, temps decreasing

        for (i, temp) in temperatures.enumerated() {
            while let last = stack.last, temperatures[last] < temp {
                let idx = stack.removeLast()
                answer[idx] = i - idx
            }
            stack.append(i)
        }
        return answer
    }
}

enum MonotonicStackDemo {
    static func run() {
        let t = [73, 74, 75, 71, 69, 72, 76, 73]
        let a = MonotonicStack.dailyTemperatures(t)
        assert(a == [1, 1, 4, 2, 1, 1, 0, 0])
        print("MonotonicStack demo OK")
    }
}
