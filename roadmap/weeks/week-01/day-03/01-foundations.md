# 01 — Foundations: ARC mental model (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Simple language. Named work only — never S-codes in speech.

---

### Q1. The one-sentence model? `(45–60s)`
**Answer:**

> “ARC (Automatic Reference Counting) is how Swift/ObjC keep track of how many strong owners a class instance has. When the strong count hits zero, the object is destroyed and deinit runs. There is no garbage-collector pause world like Java/Go — the compiler inserts retain/release calls at compile time. Structs, enums, and tuples are value types. They are not ARC-managed as heap objects in the same way. Nested classes inside a struct still use ARC.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q2. Three kinds of references? `(45–60s)`
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

### Q3. Intern picture? `(45–60s)`
**Answer:**

> “Imagine a sticky note on every object: “how many strong owners?” - Create an object → count = 1 (the variable that owns it). - Assign to another strong property → count += 1. - That property is set to nil or goes out of scope → count -= 1. - Count hits 0 → memory freed, deinit prints if you log it.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q4. What is a retain cycle? `(45–60s)`
**Answer:**

> “A retain cycle is a loop of strong references: ViewController ──strong──▶ closure ▲ │ └──────── strong ────────┘.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q5. Why this matters in interviews? `(45–60s)`
**Answer:**

> “Interviewers love the trap: “retain cycles show up in the Leaks instrument.” Wrong. Leaks looks for unreachable allocations. A cycle is reachable. You find cycles with:.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q6. Glossary (speak these cleanly)? `(45–60s)`
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

### Q7. Cycle hotspots you’ll see every week? `(45–60s)`
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

### Q8. weak vs unowned — intern decision tree? `(45–60s)`
**Answer:**

> “Does this reference participate in a possible cycle OR might the other object die first? │ ├─ YES, other might die first ──▶ weak (optional, safe nil) │ └─ Lifetimes are mathematically tied (child owned by parent; child never outlives parent) ──▶ unowned is allowed, still prefer weak if unsure Default interview stance: prefer [weak self] for escaping async work (network, ads, timers, notifications). Reach for unowned only when you can prove lifetime in one sentence.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q9. What “deinit not called” means? `(45–60s)`
**Answer:**

> “If you expected an object to die and deinit never runs, the object still has ≥1 strong owner. Checklist: 1. Escaping closure / Combine / Task still holding self 2. Timer not invalidated 3. NotificationCenter observer / token still registered with a strong capture 4. Delegate / parent strong back-reference 5. Still in a navigation stack, presented, or cached by a singleton 6. Instruments: Memory Graph — who points at me?”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q10. Mini demo mental walkthrough? `(45–60s)`
**Answer:**

> “swift final class Box { var onDone: ( -> Void)? deinit { print("Box deinit") } } do { let box = Box box.onDone = { // strong capture of box → cycle: box → closure → box print(box) } } // Box deinit does NOT print — abandoned, still reachable via the cycle.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q11. Tools at a glance (foundations)? `(45–60s)`
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

### Q12. Bridge to senior thinking? `(45–60s)`
**Answer:**

> “After this file you should be able to say: > “ARC frees class instances when strong count hits zero. Cycles keep counts above zero even when the UI is gone — that’s abandoned memory, found with Memory Graph or Allocations, not Leaks. I break cycles with weak captures, weak delegates, timer invalidation, and NotificationCenter tokens.”.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---
