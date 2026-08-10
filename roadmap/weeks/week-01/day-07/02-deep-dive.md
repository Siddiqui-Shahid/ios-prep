# 02 — Deep Dive: Full Mock #1 Interviewer Script (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Simple language. Named work only — never S-codes in speech.

---

### Q1. Setup (2 min)? `(45–60s)`
**Answer:**

> “Interviewer says: > “This is Mock #1 — Week 1 concurrency and memory. Agenda: short definitions, a deep dive, your synchronised-dictionaries story, then a social-feed HLD sketch. I’ll cut you off if you’re 2× over time — self-correct and continue. Ready?”.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q2. Warm-up definitions (10 min)? `(45–60s)`
**Answer:**

> “Ask any 5 from the list. Budget ~45–60s each. Full model answers: sample/07-revision-qna.md W1–W12.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q3. Scripted set A (default)? `(45–60s)`
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

### Q4. Alternate set B? `(45–60s)`
**Answer:**

> “POP in ads · Main-queue deadlock · Actor isolation · Sendable · Task cancellation Interviewer notes: Mark agenda? trade-off? provenance honesty?”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q5. Deep dive (25 min)? `(45–60s)`
**Answer:**

> “Ask 4–5 items. Allow follow-ups. Budgets 90–120s unless noted.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q6. D1 — Actor reentrancy `(120s)`? `(45–60s)`
**Answer:**

> “You await inside an actor method. Can another task mutate the actor’s state before you resume? What breaks if you assume continuity?” Follow-ups: - How do you harden load-if-missing? - Contrast with GCD serial queue (no await suspension in the same way).

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q7. D2 — Serial sync re-entry `(90s)`? `(45–60s)`
**Answer:**

> “You’re on a private serial queue and call queue.sync again from nested code. What happens? Is this only a main-queue issue?” Follow-ups: - Unlocked internal pattern? - dispatchPrecondition?

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q8. D3 — Memory Graph vs Leaks `(90s)`? `(45–60s)`
**Answer:**

> “Memory Graph shows a retain cycle but Leaks shows nothing. Why aren’t those tools synonyms?” Follow-ups: - Abandoned memory vs leak? - What do you do next in Xcode?

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q9. D4 — GCD → actor migration `(120s)`? `(45–60s)`
**Answer:**

> “You have a GCD SafeDict in production. How would you migrate a module to an actor without a big-bang rewrite?” Follow-ups: - API surface stay sync somehow? (adapters / async façade) - Label Verified vs Applied .

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q10. D5 — Pick one stretch? `(45–60s)`
**Answer:**

> “Choose based on misses: - @unchecked Sendable ethics (90s) - Type erasure cost in ads renderer (90s) - Async write then sync read visibility (90s) - Mixing queue.sync inside async functions (90s).”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q11. Prompt? `(45–60s)`
**Answer:**

> “Tell me about a concurrency bug you fixed in production. You have three minutes.” Listen for STAR. Score with story rubric:.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q12. Required follow-up `(90s)`? `(45–60s)`
**Answer:**

> “How would you design this today with Swift concurrency?” Expect How I would apply it · — actor, same safe API, await, not “we rewrote everything as actors.”.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q13. Optional follow-up? `(45–60s)`
**Answer:**

> “Why hide the queue instead of letting callers dispatch onto it?” ---.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q14. Prompt? `(45–60s)`
**Answer:**

> “Design the client side of a social/listing feed for a large consumer app — think BookMyShow-scale traffic. Clarify first, then high-level design only. No need for full LLD today.”.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q15. Good clarifying questions (candidate should ask ~4–6)? `(45–60s)`
**Answer:**

> “- Organic vs ads mixing rules? - Pagination model (cursor vs offset)? - Offline / stale content expectations? - Image / video autoplay policy? - Realtime invalidation vs pull-to-refresh? - Approximate DAU / latency targets? (candidate may cite 30L+ DAU as Verified · scale context — not invent new numbers).”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q16. HLD bullets interviewer wants to hear? `(45–60s)`
**Answer:**

> “Interviewer: Cut at 20 min even if incomplete — note what was missing.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q17. Retro `(10–15 min)`? `(45–60s)`
**Answer:**

> “1. Fill code/MockScorecard.md. 2. Average deep-dive scores. 3. List top 5 weak cards → pin to Week 2 warm-ups. 4. Optional encore: Ads POP talk ≤5 min (preview Mock #2). ---.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q18. Interlocutor “cut” lines (use sparingly)? `(45–60s)`
**Answer:**

> “You’re at 2× — give me the trade-off in one sentence.” “Don’t invent a metric — what’s the honest result?” “Agenda first.” “Is that Verified or how you’d apply it?” ---.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q19. Self-mock mode? `(45–60s)`
**Answer:**

> “If solo: record voice memo; play back against 07-revision-qna Full spoken answers; still fill scorecard honestly.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---
