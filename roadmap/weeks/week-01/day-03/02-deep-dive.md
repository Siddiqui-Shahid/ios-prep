# 02 — Deep dive: ARC mechanics, cycles, Instruments (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Simple language. Named work only — never S-codes in speech.

---

### Q1. What the compiler actually does? `(45–60s)`
**Answer:**

> “For class instances, the Swift/ObjC runtime maintains a retain count (plus side tables for weak references). The compiler emits: - retain / release (or equivalent ARC runtime calls) at ownership transfer points - deinit invocation when the last strong reference is released - Zeroing weak bookkeeping so weak becomes nil after destroy.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q2. Strong, weak, unowned — semantics table? `(45–60s)`
**Answer:**

> “See the notes for this topic and speak the core idea in simple words.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q3. When `unowned` is justified? `(45–60s)`
**Answer:**

> “Example: a Person strongly owns a CreditCard, and the card’s owner must always exist for the card’s entire life: swift final class Person { var card: CreditCard! init { card = CreditCard(owner: self) } }.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q4. Escaping vs non-escaping? `(45–60s)`
**Answer:**

> “- Non-escaping closures (default for function parameters that don’t escape) usually cannot outlive self, so a strong capture of self often cannot form a long-lived cycle. - Escaping closures stored in properties, dispatched async, or passed to APIs that keep them → can outlive the call site → cycle risk if they capture self and self owns them.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q5. Capture lists? `(45–60s)`
**Answer:**

> “swift // Cycle: self → onComplete → self onComplete = { self.refresh } // Breaks the cycle edge from closure → self onComplete = { [weak self] in guard let self else { return } self.refresh }.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q6. `lazy var` closures? `(45–60s)`
**Answer:**

> “swift lazy var formatter: DateFormatter = { // This closure runs later and can capture self strongly while // self is initializing / retaining the lazy property. let f = DateFormatter f.timeZone = self.timeZone // careful: strong self capture return f } Safer patterns: don’t touch self inside lazy init if avoidable; or compute without storing a self-capturing escaping closure; or use explicit weak if the design truly needs self.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q7. Delegates? `(45–60s)`
**Answer:**

> “swift protocol FeedDelegate: AnyObject { func feedDidRefresh } final class FeedController { weak var delegate: FeedDelegate? }.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q8. Timer — target-selector retains the target? `(45–60s)`
**Answer:**

> “swift final class Ticker { private var timer: Timer? func start { // IMPORTANT: scheduledTimer(target:selector:) RETAINS target (self) timer = Timer.scheduledTimer( timeInterval: 1, target: self, selector: #selector(tick), userInfo: nil, repeats: true ) }.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q9. NotificationCenter — block API uses tokens? `(45–60s)`
**Answer:**

> “Modern block-based API: swift private var token: NSObjectProtocol?”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q10. Parent ↔ child? `(45–60s)`
**Answer:**

> “swift final class Parent { var child: Child? } final class Child { weak var parent: Parent? // break the cycle } Use unowned only if the child is guaranteed never to outlive the parent and you want non-optional access.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q11. `Task` / unstructured concurrency? `(45–60s)`
**Answer:**

> “swift final class SearchVC { private var searchTask: Task<Void, Never>? func query(_ text: String) { searchTask?.cancel searchTask = Task { [weak self] in guard let self else { return } // … await network … await self.apply(results) } }.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q12. Leak vs abandoned vs high watermark? `(45–60s)`
**Answer:**

> “See the notes for this topic and speak the core idea in simple words.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q13. The sentence that wins interviews? `(45–60s)`
**Answer:**

> “Retain cycles are abandoned but still reachable, so they don’t show as Leaks. I use Memory Graph to see the cycle and Allocations to see persistent growth. Leaks is for unreachable memory.” Never say: “I found the retain cycle in the Leaks instrument.”.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q14. Debug Memory Graph (Xcode debugger)? `(45–60s)`
**Answer:**

> “1. Reproduce the bug (push VC, play ad, start timer, pop VC). 2. Debug → Memory Graph (or the gauge button). 3. Filter by your class name / module. 4. Inspect instances that should be gone. 5. Walk incoming references until you see the cycle (closure ↔ object, timer → target, etc.). Strength: visual “who retains me?” Weakness: snapshot in time; less about historical growth curves.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q15. Allocations? `(45–60s)`
**Answer:**

> “1. Record while navigating hot paths (feed, checkout, ads). 2. Look for persistent growth of your types across generations / marks. 3. Use generation analysis / “persistent” bytes after you expect teardown. 4. Compare before/after a fix. Strength: proves growth and abandoned heaps over time. Weakness: doesn’t draw the cycle as clearly as Memory Graph.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q16. Leaks? `(45–60s)`
**Answer:**

> “1. Record the same session. 2. Investigate true leaks (unreachable). 3. Do not conclude “no cycles” just because Leaks is clean. Strength: unreachable memory. Weakness: silent on retain cycles.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q17. Suggested order when a VC “won’t die”? `(45–60s)`
**Answer:**

> “1. Add a temporary deinit { print("…") } (learning lab) or breakpoint. 2. Memory Graph — find unexpected owners. 3. Allocations — confirm the type persists across navigation generations. 4. Leaks — only if you suspect unsafe / CF / true unreachable issues. 5. Fix ownership; re-verify deinit + Graph.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q18. Trade-off table? `(45–60s)`
**Answer:**

> “See the notes for this topic and speak the core idea in simple words.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q19. Failure modes (production-shaped)? `(45–60s)`
**Answer:**

> “See the notes for this topic and speak the core idea in simple words.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q20. Autorelease pools (short, accurate)? `(45–60s)`
**Answer:**

> “In tight loops that create many temporary ObjC objects (bridging, image processing helpers), drain with: swift for item in hugeList { autoreleasepool { // temporaries released each iteration process(item) } }.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q21. Value types vs ARC (edge)? `(45–60s)`
**Answer:**

> “- Structs themselves are not reference-counted. - A struct storing a class instance shares that reference; mutating the struct may copy the struct shell but still share/retain the class unless you implement COW yourself. - Closures are reference types under the hood — capturing large value trees can still keep class graphs alive.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q22. Interview answer skeleton (90s deep dive)? `(45–60s)`
**Answer:**

> “1. Claim: ARC frees at retain count zero; cycles prevent that. 2. Mechanism: strong vs weak/unowned; escaping closures; timer retain; NC tokens. 3. Tools: Graph/Allocations for abandoned; Leaks for unreachable — don’t confuse them. 4. Production: reliability culture at scale (Verified metrics); triage playbook as Applied judgment.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q23. Optional citations (appendix only)? `(45–60s)`
**Answer:**

> “- Swift Language Guide — Automatic Reference Counting - Xcode Help — Debug memory graph / Instruments Allocations & Leaks Studying this chapter alone is sufficient; links are optional deepeners.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---
