# 05 — Exercises: ARC & Instruments (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Simple language. Named work only — never S-codes in speech.

---

### Q1. Exercise A — Predict `deinit` (Learning-lab)? `(45–60s)`
**Answer:**

> “Task: Without running code, for each snippet say whether deinit prints when outer ends.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q2. A1? `(45–60s)`
**Answer:**

> “swift final class A { deinit { print("A") } } do { let a = A _ = a }.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q3. A2? `(45–60s)`
**Answer:**

> “swift final class B { var hold: ( -> Void)? deinit { print("B") } func arm { hold = { print(self) } } } do { let b = B b.arm }.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q4. A3? `(45–60s)`
**Answer:**

> “swift final class C { var hold: ( -> Void)? deinit { print("C") } func arm { hold = { [weak self] in print(self as Any) } } } do { let c = C c.arm }.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q5. Solution A? `(45–60s)`
**Answer:**

> “Interview line: A2 is abandoned memory — Memory Graph would show the cycle; Leaks may not.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q6. Exercise B — Fix the timer (Learning-lab)? `(45–60s)`
**Answer:**

> “Broken: swift final class Pulse { private var timer: Timer? func start { timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(tick), userInfo: nil, repeats: true) } @objc private func tick {} // no deinit }.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q7. Solution B? `(45–60s)`
**Answer:**

> “1. Target-selector timers retain the target until invalidate. Repeating timer ⇒ immortal Pulse while scheduled. 2. Fixed: swift final class PulseFixed { private var timer: Timer?”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q8. Exercise C — NotificationCenter token (Learning-lab)? `(45–60s)`
**Answer:**

> “Broken sketch: swift final class Listener { func start { NotificationCenter.default.addObserver(forName: .init("ping"), object: nil, queue: .main) { _ in self.handle // strong self } } func handle {} }.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q9. Solution C? `(45–60s)`
**Answer:**

> “1. (a) Block strongly captures self. (b) Return token discarded — cannot cleanly remove; observation may keep the block graph alive. 2. Fixed pattern: swift final class ListenerFixed { private var token: NSObjectProtocol?”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q10. Exercise D — Tool selection (interview drill)? `(45–60s)`
**Answer:**

> “For each symptom, pick primary tool: Memory Graph / Allocations / Leaks. One sentence why.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q11. Solution D? `(45–60s)`
**Answer:**

> “---.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q12. Exercise E — Speak for 60s (Verified + Applied labels)? `(45–60s)`
**Answer:**

> “Prompt: “Tell me how you’d hunt a retain cycle in a large consumer app.” Constraints: - Must mention Graph vs Leaks correctly - Must label Verified vs Applied triage - Must not invent “I used Memory Graph at BMS” as fact.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q13. Solution E (model)? `(45–60s)`
**Answer:**

> “Verified: at BookMyShow we operated under a 99.95%+ crash-free bar at 30L+ DAU with Crashlytics workflows and IMOC ownership — memory pressure and lifecycle bugs sit in that reliability culture. Applied: if a screen won’t die, I wouldn’t start with Leaks for a suspected retain cycle. I’d reproduce push/pop, check Memory Graph for leftover instances and retain edges, use Allocations to confirm persistent growth, then fix weak captures, timer invalidation, or NotificationCenter tokens. Leaks is for unreachable memory — cycles stay reachable, so a green Leaks run wouldn’t convince me.” ---.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q14. Exercise F — Code reading (from demo file)? `(45–60s)`
**Answer:**

> “Open code/RetainCycleDemo.swift. 1. Why does BoxBroken.armCycle prevent deinit? 2. Why does TickerBroken mention RunLoop and retain? 3. What two responsibilities does TimeZoneObserver.deinit fulfill? 4. Why is scheduleUnownedCrashRisk dangerous after releasing the last strong ref to Ephemeral?”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q15. Solution F? `(45–60s)`
**Answer:**

> “1. onDone is stored on self and captures self strongly → cycle. 2. Timer is scheduled on a RunLoop (keeps the timer alive) and target-selector retains self until invalidate — double ownership discipline. 3. Remove the NC token and (via stop) clear local state so observation ends; also guarantees teardown if caller forgot stop. 4. After Ephemeral deinits, unowned self dangles; the delayed block crashes when it runs. ---.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q16. Exercise G — Parent/child design choice `(45s speak)`? `(45–60s)`
**Answer:**

> “When would you use weak var parent vs unowned let parent on a child?”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q17. Solution G? `(45–60s)`
**Answer:**

> “- weak: parent might nil out while child briefly remains (or you’re unsure) — safer optional. - unowned: child’s lifetime is strictly nested under parent by API construction; you want non-optional access and accept crash if the invariant breaks. - Interview default under uncertainty: weak. ---.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q18. Exercise H — Mini Memory Graph script (device / simulator)? `(45–60s)`
**Answer:**

> “Provenance: Learning-lab (and How I would apply it if you narrate it for BMS-shaped apps). Do not claim this script as verified BMS production history. 1. Create a blank iOS app; paste LeakyViewController / SafeViewController from the commented section in RetainCycleDemo.swift. 2. Present leaky VC, assign onFinish, dismiss. 3. Open Debug Memory Graph; filter the VC type — confirm instance remains. 4. Repeat with safe VC — confirm absence. 5. Optional: run Allocations with generation marks; optional: run Leaks and note it may stay clean for the leaky cycle.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q19. Exercise I — Write the trap card? `(45–60s)`
**Answer:**

> “Write one flashcard front/back for each: 1. Leaks vs retain cycle 2. Timer target retain 3. NC block token.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q20. Solution I (sample backs)? `(45–60s)`
**Answer:**

> “1. Front: Do retain cycles show in Leaks? Back: No — reachable abandoned memory → Graph/Allocations. Leaks = unreachable. Trap: treating tools as synonyms. Prod: Applied triage under reliability culture. 2. Front: Why won’t my VC die after starting a repeating Timer? Back: scheduledTimer(target:selector:) retains target until invalidate. Invalidate in deinit / disappear. 3. Front: NotificationCenter block API must-dos? Back: Store token; remove on teardown; [weak self] in block. ---.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q21. Done checklist? `(45–60s)`
**Answer:**

> “- [ ] Explained ARC + weak/unowned aloud in &lt;45s - [ ] Corrected someone (or yourself) on Leaks vs cycles - [ ] Fixed a timer + NC example without peeking - [ ] Spoke Exercise E with Verified/Applied labels - [ ] Recorded timed subset from sample/07-revision-qna.md Next: revision twin timed drill — ../../../revision/weeks/week-01/day-03.md.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---
