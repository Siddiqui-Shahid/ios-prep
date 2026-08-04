import Foundation

final class ListNode {
    var val: Int
    var next: ListNode?
    init(_ val: Int, _ next: ListNode? = nil) {
        self.val = val
        self.next = next
    }
}

enum LinkedListAlgos {
    /// Iterative reverse — O(n) time, O(1) space.
    static func reverse(_ head: ListNode?) -> ListNode? {
        var prev: ListNode? = nil
        var curr = head
        while let node = curr {
            let next = node.next
            node.next = prev
            prev = node
            curr = next
        }
        return prev
    }

    /// Floyd cycle detection.
    static func hasCycle(_ head: ListNode?) -> Bool {
        var slow = head
        var fast = head
        while let f = fast?.next {
            slow = slow?.next
            fast = f.next
            if slow === fast { return true }
        }
        return false
    }

    /// Middle node; for even length returns the *upper* middle (2nd of the two).
    static func middle(_ head: ListNode?) -> ListNode? {
        var slow = head
        var fast = head
        while let f = fast, let next = f.next {
            slow = slow?.next
            fast = next.next
        }
        return slow
    }

    /// Merge two sorted lists by reusing nodes.
    static func mergeSorted(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        let dummy = ListNode(0)
        var tail = dummy
        var a = l1
        var b = l2
        while let left = a, let right = b {
            if left.val <= right.val {
                tail.next = left
                a = left.next
            } else {
                tail.next = right
                b = right.next
            }
            tail = tail.next!
        }
        tail.next = a ?? b
        return dummy.next
    }

    // MARK: - Helpers

    static func fromArray(_ values: [Int]) -> ListNode? {
        let dummy = ListNode(0)
        var tail = dummy
        for v in values {
            tail.next = ListNode(v)
            tail = tail.next!
        }
        return dummy.next
    }

    static func toArray(_ head: ListNode?) -> [Int] {
        var result: [Int] = []
        var curr = head
        while let node = curr {
            result.append(node.val)
            curr = node.next
        }
        return result
    }
}

enum LinkedListDemo {
    static func run() {
        let rev = LinkedListAlgos.reverse(LinkedListAlgos.fromArray([1, 2, 3]))
        assert(LinkedListAlgos.toArray(rev) == [3, 2, 1])

        let a = LinkedListAlgos.fromArray([1, 2, 4])
        let b = LinkedListAlgos.fromArray([1, 3, 4])
        assert(LinkedListAlgos.toArray(LinkedListAlgos.mergeSorted(a, b)) == [1, 1, 2, 3, 4, 4])

        // Cycle: 1→2→3→4→2
        let n1 = ListNode(1); let n2 = ListNode(2); let n3 = ListNode(3); let n4 = ListNode(4)
        n1.next = n2; n2.next = n3; n3.next = n4; n4.next = n2
        assert(LinkedListAlgos.hasCycle(n1) == true)
        assert(LinkedListAlgos.hasCycle(LinkedListAlgos.fromArray([1, 2, 3])) == false)

        print("LinkedListAlgos demo OK")
    }
}
