# 03 — Production Bridge: S8 IMOC/CFS + S2 Honesty (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Simple language. Named work only — never S-codes in speech.

---

### Q1. Provenance map? `(45–60s)`
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

> “- “ alone caused / delivered 99.95% CFS” - “I wrote our in-house signal handler crash SDK” (unless you add evidence — default is Crashlytics workflows) - Invented downtime minutes or crash counts - “CFS proves no hangs”.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q3. Opener (~10s)? `(45–60s)`
**Answer:**

> “I’ll cover sustaining 99.95%+ crash-free sessions at 30L+ DAU — Crashlytics triage plus IMOC coordination on P0/P1s.”.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q4. Situation / Task (~20s)? `(45–60s)`
**Answer:**

> “Consumer ticketing app at very large DAU. Reliability is a product feature during peak traffic. Need structured crash response and multi-team incident command.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q5. Action (~90s)? `(45–60s)`
**Answer:**

> “1. Crashlytics triage with structured workflows — detect, classify, reproduce, mitigate, fix, write-up. 2. As IMOC, coordinated iOS, backend, and QA on P0/P1 during high-traffic events. 3. Drove mitigations first: feature guards, rollout pause, hotfix path, cadenced comms. 4. Treated CFS as a sustained operational bar, not a slide metric.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q6. Result (~20–30s)? `(45–60s)`
**Answer:**

> “Sustained high crash-free sessions; reduced downtime impact in peak events through clear ownership and blast-radius thinking.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q7. Lesson (~15–20s)? `(45–60s)`
**Answer:**

> “Incident leadership is owner + blast radius + rollback — not lone-hero stack debugging. > Provenance: Verified · · BookMyShow · 30L+ DAU · 99.95%+ CFS · IMOC.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q8. Interview line (≤20s)? `(45–60s)`
**Answer:**

> “At 30L+ DAU we held 99.95%+ crash-free sessions — Crashlytics triage plus IMOC coordination on P0/P1s, not just fixing stacks alone.”.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q9. OK script? `(45–60s)`
**Answer:**

> “Separately, on shared async dictionaries we had intermittent race crashes. We gated access with GCD serial queues and read-write locks behind a safe API. That removed concurrent-access crashes on that path and fed reliability. I’m not claiming that one fix is the whole 99.95% CFS story — CFS was sustained by triage, incident process, and many engineering inputs including concurrency hygiene.”.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q10. Forbidden script? `(45–60s)`
**Answer:**

> “We hit 99.95% CFS because I synchronised the dictionaries.” > Provenance: Verified · · path-scoped races · must not sole-own metrics.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q11. S2-A1 bridge? `(45–60s)`
**Answer:**

> “For greenfield shared maps I’d evaluate a Swift actor with the same boundary mindset — serialize mutation at the API edge.” > Provenance: How I would apply it · .

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q12. Behavioral variants (same facts)? `(45–60s)`
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

### Q13. Whiteboard crash SDK (10 min)? `(45–60s)`
**Answer:**

> “Handlers → mmap writer → breadcrumb ring → next-launch uploader → dSYM symbolication. Call out signal safety and “no upload in handler.”.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---
