# 05 — Exercises: ARC & Instruments

Solutions are in-repo below each exercise. Try first with notes closed.

---

## Exercise A — Predict `deinit` (Learning-lab)

**Task:** Without running code, for each snippet say whether `deinit` prints when `outer` ends.

### A1

```swift
final class A {
    deinit { print("A") }
}
do {
    let a = A()
    _ = a
}
```

### A2

```swift
final class B {
    var hold: (() -> Void)?
    deinit { print("B") }
    func arm() { hold = { print(self) } }
}
do {
    let b = B()
    b.arm()
}
```

### A3

```swift
final class C {
    var hold: (() -> Void)?
    deinit { print("C") }
    func arm() { hold = { [weak self] in print(self as Any) } }
}
do {
    let c = C()
    c.arm()
}
```

### Solution A

| | `deinit` prints? | Why |
|---|---|---|
| A1 | Yes | No extra owners; count → 0 at end of `do`. |
| A2 | No | Cycle: `B` → `hold` → `self`. Abandoned, reachable. |
| A3 | Yes | Weak capture breaks cycle; property may remain but doesn’t keep `C` alive. |

**Interview line:** A2 is abandoned memory — Memory Graph would show the cycle; Leaks may not.

---

## Exercise B — Fix the timer (Learning-lab)

**Broken:**

```swift
final class Pulse {
    private var timer: Timer?
    func start() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,
                                     selector: #selector(tick),
                                     userInfo: nil, repeats: true)
    }
    @objc private func tick() {}
    // no deinit
}
```

**Tasks:**
1. Why can `Pulse` never deallocate after `start()`?
2. Write a fixed version (invalidate + optional block-based form).

### Solution B

1. Target-selector timers **retain the target** until `invalidate()`. Repeating timer ⇒ immortal `Pulse` while scheduled.
2. Fixed:

```swift
final class PulseFixed {
    private var timer: Timer?

    func start() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.tick()
        }
    }

    private func tick() {}

    func stop() {
        timer?.invalidate()
        timer = nil
    }

    deinit { stop() }
}
```

Also call `stop()` from `viewDidDisappear` / flow teardown if the object outlives the need to tick.

See also: [code/RetainCycleDemo.swift](code/RetainCycleDemo.swift) `TickerFixed`.

---

## Exercise C — NotificationCenter token (Learning-lab)

**Broken sketch:**

```swift
final class Listener {
    func start() {
        NotificationCenter.default.addObserver(forName: .init("ping"),
                                               object: nil, queue: .main) { _ in
            self.handle() // strong self
        }
    }
    func handle() {}
}
```

**Tasks:**
1. List two ownership bugs.
2. Rewrite with token storage, removal, and `[weak self]`.

### Solution C

1. (a) Block strongly captures `self`. (b) Return token discarded — cannot cleanly remove; observation may keep the block graph alive.
2. Fixed pattern:

```swift
final class ListenerFixed {
    private var token: NSObjectProtocol?

    func start() {
        token = NotificationCenter.default.addObserver(
            forName: Notification.Name("ping"),
            object: nil,
            queue: .main
        ) { [weak self] _ in
            self?.handle()
        }
    }

    func handle() {}

    func stop() {
        if let token {
            NotificationCenter.default.removeObserver(token)
            self.token = nil
        }
    }

    deinit { stop() }
}
```

---

## Exercise D — Tool selection (interview drill)

For each symptom, pick **primary** tool: Memory Graph / Allocations / Leaks. One sentence why.

| # | Symptom | Your pick |
|---|---|---|
| D1 | Popped VC’s `deinit` never runs; you suspect a closure cycle | |
| D2 | Memory bytes climb every time user opens checkout 20× | |
| D3 | Suspected CFTypeRef / unreachable malloc after a C bridge | |
| D4 | Leaks instrument is clean; interviewer asks if cycles are impossible | |

### Solution D

| # | Primary | Why |
|---|---|---|
| D1 | **Memory Graph** | See who still retains the VC; visualize cycle. |
| D2 | **Allocations** | Prove persistent growth across generations / repeated flow. |
| D3 | **Leaks** | Hunting **unreachable** allocations. |
| D4 | Answer: **No** — cycles are reachable, so clean Leaks proves little about cycles. Use Graph/Allocations. |

---

## Exercise E — Speak for 60s (Verified + Applied labels)

**Prompt:** “Tell me how you’d hunt a retain cycle in a large consumer app.”

**Constraints:**
- Must mention Graph vs Leaks correctly
- Must label Verified S8 vs Applied triage
- Must not invent “I used Memory Graph at BMS” as fact

### Solution E (model)

> “Verified: at BookMyShow we operated under a 99.95%+ crash-free bar at 30L+ DAU with Crashlytics workflows and IMOC ownership — memory pressure and lifecycle bugs sit in that reliability culture. Applied: if a screen won’t die, I wouldn’t start with Leaks for a suspected retain cycle. I’d reproduce push/pop, check Memory Graph for leftover instances and retain edges, use Allocations to confirm persistent growth, then fix weak captures, timer invalidation, or NotificationCenter tokens. Leaks is for unreachable memory — cycles stay reachable, so a green Leaks run wouldn’t convince me.”

---

## Exercise F — Code reading (from demo file)

Open [code/RetainCycleDemo.swift](code/RetainCycleDemo.swift).

1. Why does `BoxBroken.armCycle` prevent `deinit`?
2. Why does `TickerBroken` mention RunLoop *and* retain?
3. What two responsibilities does `TimeZoneObserver.deinit` fulfill?
4. Why is `scheduleUnownedCrashRisk` dangerous after releasing the last strong ref to `Ephemeral`?

### Solution F

1. `onDone` is stored on `self` and captures `self` strongly → cycle.
2. Timer is scheduled on a RunLoop (keeps the timer alive) **and** target-selector retains `self` until invalidate — double ownership discipline.
3. Remove the NC token **and** (via `stop`) clear local state so observation ends; also guarantees teardown if caller forgot `stop()`.
4. After `Ephemeral` deinits, `unowned self` dangles; the delayed block crashes when it runs.

---

## Exercise G — Parent/child design choice `(45s speak)`

When would you use `weak var parent` vs `unowned let parent` on a child?

### Solution G

- **weak:** parent might nil out while child briefly remains (or you’re unsure) — safer optional.
- **unowned:** child’s lifetime is strictly nested under parent by API construction; you want non-optional access and accept crash if the invariant breaks.
- Interview default under uncertainty: **weak**.

---

## Exercise H — Mini Memory Graph script (device / simulator)

> **Provenance:** Learning-lab (and How I would apply it if you narrate it for BMS-shaped apps). Do not claim this script as verified BMS production history.

1. Create a blank iOS app; paste `LeakyViewController` / `SafeViewController` from the commented section in `RetainCycleDemo.swift`.
2. Present leaky VC, assign `onFinish`, dismiss.
3. Open **Debug Memory Graph**; filter the VC type — confirm instance remains.
4. Repeat with safe VC — confirm absence.
5. Optional: run **Allocations** with generation marks; optional: run **Leaks** and note it may stay clean for the leaky cycle.

**Pass criteria:** You can explain *why* Leaks stayed clean while Graph showed the object.

---

## Exercise I — Write the trap card

Write one flashcard front/back for each:

1. Leaks vs retain cycle  
2. Timer target retain  
3. NC block token  

### Solution I (sample backs)

1. **Front:** Do retain cycles show in Leaks? **Back:** No — reachable abandoned memory → Graph/Allocations. Leaks = unreachable. Trap: treating tools as synonyms. Prod: Applied triage under S8 reliability culture.  
2. **Front:** Why won’t my VC die after starting a repeating Timer? **Back:** `scheduledTimer(target:selector:)` retains target until `invalidate`. Invalidate in `deinit` / disappear.  
3. **Front:** NotificationCenter block API must-dos? **Back:** Store token; remove on teardown; `[weak self]` in block.

---

## Done checklist

- [ ] Explained ARC + weak/unowned aloud in &lt;45s  
- [ ] Corrected someone (or yourself) on Leaks vs cycles  
- [ ] Fixed a timer + NC example without peeking  
- [ ] Spoke Exercise E with Verified/Applied labels  
- [ ] Recorded timed subset from `04-questions.md`  

Next: revision twin timed drill — [`../../../revision/weeks/week-01/day-03.md`](../../../revision/weeks/week-01/day-03.md).
