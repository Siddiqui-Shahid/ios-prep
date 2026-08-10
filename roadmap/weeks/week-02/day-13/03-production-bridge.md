# 03 — Production Bridge: Honest DSA ↔ iOS Hooks (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Simple language. Named work only — never S-codes in speech.

---

### Q1. Provenance map for today? `(45–60s)`
**Answer:**

> “See the notes for this topic and speak the core idea in simple words.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q2. Forbidden overclaims? `(45–60s)`
**Answer:**

> “- “We used linked lists for the feed.” - “I implemented LRU in production at BMS.” (unless you later add real evidence) - “Aces audio = my circular queue.” - Fake complexity wins as production metrics.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q3. Structure → production bridge table? `(45–60s)`
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

### Q4. Soft bridge — refresh waiters (S4 mindset)? `(45–60s)`
**Answer:**

> “On networking, concurrent 401s shouldn’t each refresh. Waiters line up — conceptually a queue — behind one refresh Task, then fan-out. That’s the same FIFO discipline as a BFS queue, applied to auth. The Verified work is the Ads URLSession security ownership; the waiter queue is the concurrency pattern we reason about in that layer.” > Provenance: Learning-lab pattern · soft bridge to Verified · / Day 09 single-flight.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q5. Soft bridge — nav LIFO (S6 / S13)? `(45–60s)`
**Answer:**

> “Product navigation is a stack: push screens, pop on back. On LE Bottom Sheet we reduced full-screen pushes — Verified 30%+ fewer full-screen navigations — which is a product win on top of the same LIFO mental model.” > Provenance: Verified · · LE Bottom Sheet 30%+ · soft stack metaphor.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q6. Honest LL answer? `(45–60s)`
**Answer:**

> “Linked lists rarely appear in my iOS UI code because Array has better locality and ergonomics. I use them in interviews for reverse/cycle/merge and when designing an LRU with a dict plus node list. I won’t pretend BMS Ads was a linked-list codebase.” > Provenance: Learning-lab honesty.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q7. Interview line (≤20s) — day opener? `(45–60s)`
**Answer:**

> “For coding I’ll state structure and complexity first — for example monotonic stack O(n) — then write clean iterative Swift; and I’ll call out Array-as-queue costs when relevant.”.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q8. Tomorrow link — Mock #2? `(45–60s)`
**Answer:**

> “DSA today feeds composure, not the 5-min Ads/SDUI architecture talk. Still: choose Ads or SDUI track tonight so Day 14 isn’t cold.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---
