// RetainCycleDemo.swift
// Learning-lab examples for Day 03 — ARC / retain cycles.
//
// Provenance: Learning-lab (illustrative). Not production BMS code.
//
// How to use:
// 1. Read each section’s “BROKEN” then “FIXED” notes.
// 2. Optionally paste into an iOS sample / Playground with a RunLoop for Timer demos.
// 3. In an app target: Debug ▸ Memory Graph after exercising BROKEN paths.
//
// Platform notes:
// - Pure Swift class cycles run in SwiftPM / macOS.
// - Timer + NotificationCenter snippets expect Foundation; UIKit types are commented.
//
// CRITICAL REMINDER:
// Retain cycles = reachable abandoned memory → Memory Graph / Allocations.
// Instruments Leaks = unreachable memory. Cycles do NOT “show up in Leaks.”

import Foundation

// MARK: - 1) Escaping closure ↔ owner (classic)

/// BROKEN: `Box` owns `onDone`; `onDone` strongly captures `box` → cycle.
/// `deinit` will NOT run when the local reference drops.
final class BoxBroken {
    var onDone: (() -> Void)?
    let id: String

    init(id: String) {
        self.id = id
        print("BoxBroken \(id) init")
    }

    deinit {
        print("BoxBroken \(id) deinit") // expect: never, while cycle holds
    }

    func armCycle() {
        onDone = {
            // strong capture of self (implicit via using properties / methods)
            print("done for \(self.id)")
        }
    }
}

/// FIXED: capture list breaks closure → self edge.
final class BoxFixed {
    var onDone: (() -> Void)?
    let id: String

    init(id: String) {
        self.id = id
        print("BoxFixed \(id) init")
    }

    deinit {
        print("BoxFixed \(id) deinit") // expect: prints when last external strong ref drops
    }

    func armSafely() {
        onDone = { [weak self] in
            guard let self else { return }
            print("done for \(self.id)")
        }
    }
}

enum ClosureCycleDemo {
    static func runBroken() {
        let box = BoxBroken(id: "A")
        box.armCycle()
        box.onDone?()
        // box falls out of scope — but cycle keeps it alive
    }

    static func runFixed() {
        let box = BoxFixed(id: "B")
        box.armSafely()
        box.onDone?()
        // box falls out of scope — deinit should run
    }
}

// MARK: - 2) Parent ↔ child

final class ParentBroken {
    var child: ChildBroken?
    deinit { print("ParentBroken deinit") }
}

final class ChildBroken {
    var parent: ParentBroken? // strong back-edge → cycle
    deinit { print("ChildBroken deinit") }
}

final class ParentFixed {
    var child: ChildFixed?
    deinit { print("ParentFixed deinit") }
}

final class ChildFixed {
    weak var parent: ParentFixed? // weak back-edge → no cycle
    deinit { print("ChildFixed deinit") }
}

enum ParentChildDemo {
    static func runBroken() {
        let parent = ParentBroken()
        let child = ChildBroken()
        parent.child = child
        child.parent = parent
        // both stay alive after locals drop
    }

    static func runFixed() {
        let parent = ParentFixed()
        let child = ChildFixed()
        parent.child = child
        child.parent = parent
        // child.parent is weak; when locals drop, both can deinit
        // (parent releases child; child’s weak parent zeros)
    }
}

// MARK: - 3) Timer target-selector retains target

/// BROKEN pattern notes:
/// `Timer.scheduledTimer(timeInterval:target:selector:userInfo:repeats:)`
/// **retains** `target` until `invalidate()`.
/// If you never invalidate, `TickerBroken` never deinits.
final class TickerBroken {
    private var timer: Timer?

    func start() {
        timer = Timer.scheduledTimer(
            timeInterval: 1.0,
            target: self,
            selector: #selector(tick),
            userInfo: nil,
            repeats: true
        )
        // Missing invalidate forever → abandoned ticker (+ RunLoop ownership)
    }

    @objc private func tick() {
        print("tick broken")
    }

    deinit {
        print("TickerBroken deinit") // won't run while timer retains self
    }
}

/// FIXED: invalidate in deinit (and ideally when leaving the screen).
/// Block-based timer + weak self also avoids the selector retain semantics,
/// but you MUST still invalidate so the RunLoop releases the timer.
final class TickerFixed {
    private var timer: Timer?

    func start() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.tick()
        }
    }

    private func tick() {
        print("tick fixed")
    }

    func stop() {
        timer?.invalidate()
        timer = nil
    }

    deinit {
        stop()
        print("TickerFixed deinit")
    }
}

// MARK: - 4) NotificationCenter block API — store the token

/// Block API returns an observer token. Store it; remove on teardown.
/// Still use `[weak self]` so the block doesn’t keep `self` forever.
final class TimeZoneObserver {
    private var token: NSObjectProtocol?

    func start() {
        token = NotificationCenter.default.addObserver(
            forName: .NSSystemTimeZoneDidChange,
            object: nil,
            queue: .main
        ) { [weak self] _ in
            self?.handleChange()
        }
    }

    private func handleChange() {
        print("time zone changed")
    }

    func stop() {
        if let token {
            NotificationCenter.default.removeObserver(token)
            self.token = nil
        }
    }

    deinit {
        stop()
        print("TimeZoneObserver deinit")
    }
}

// MARK: - 5) unowned hazard (async outlives owner)

final class Ephemeral {
    let name: String
    init(name: String) { self.name = name }
    deinit { print("Ephemeral \(name) deinit") }

    /// DANGEROUS if work can outlive Ephemeral: unowned crashes after deinit.
    func scheduleUnownedCrashRisk() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [unowned self] in
            print("still here? \(self.name)")
        }
    }

    /// SAFE for uncertain lifetime.
    func scheduleWeak() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            guard let self else {
                print("Ephemeral gone — skipped")
                return
            }
            print("still here \(self.name)")
        }
    }
}

// MARK: - 6) UIKit sketch (commented — for reading / pasting into an app target)

/*
 import UIKit

 final class LeakyViewController: UIViewController {
     var onFinish: (() -> Void)?

     override func viewDidLoad() {
         super.viewDidLoad()
         // BROKEN: VC owns onFinish; onFinish captures self strongly.
         onFinish = {
             self.title = "done"
         }
     }

     deinit {
         print("LeakyViewController deinit") // often missing until fix
     }
 }

 final class SafeViewController: UIViewController {
     var onFinish: (() -> Void)?

     override func viewDidLoad() {
         super.viewDidLoad()
         onFinish = { [weak self] in
             self?.title = "done"
         }
     }

     deinit {
         print("SafeViewController deinit")
     }
 }

 // Memory Graph drill (How I would apply it / Learning-lab — not a BMS claim):
 // 1. Present LeakyViewController, set onFinish, dismiss.
 // 2. Open Memory Graph — instance remains via closure cycle.
 // 3. Switch to SafeViewController — instance should disappear.
 // 4. Allocations: confirm persistent count drops after fix.
 // 5. Leaks instrument: may stay clean even for the BROKEN cycle — that’s expected.
 */

// MARK: - Demo entry (optional)

enum RetainCycleDemoRunner {
    static func printLegend() {
        print("""
        Learning-lab Day 03
        - Cycles are reachable abandoned memory → Memory Graph / Allocations
        - Leaks instrument ≠ retain-cycle detector
        - Timer target-selector retains target until invalidate
        - NotificationCenter block API → store token + remove + weak capture
        """)
    }
}
