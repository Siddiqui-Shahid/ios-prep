# 03 — Production Bridge: Mock Story Map (Q&A)

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

### Q2. Forbidden? `(45–60s)`
**Answer:**

> “- Invented fill-rate % or splash latency ms - “Shipped pin rotation runbook / shadow traffic” as fact - Claiming both tracks as one giant project you did in a week.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q3. Track → story pairing? `(45–60s)`
**Answer:**

> “Spice either track: (migration + AI judgment), (product UX metric), / (modular/hybrid).”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q4. Opener (~10s)? `(45–60s)`
**Answer:**

> “I’ll walk through our highest-revenue Ads refactor — protocols, generics, and video lifecycle.”.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q5. S/T (~20s)? `(45–60s)`
**Answer:**

> “Highest-revenue Ads module needed a safer reusable rendering path. Video ads inside HeroWidget needed correct pause/play with lifecycle.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q6. Action (~90s)? `(45–60s)`
**Answer:**

> “1. Refactored around protocol-oriented ad component contracts + generics for a type-safe pipeline. 2. Built reusable HeroWidget with explicit pause/play tied to visibility / VC lifecycle. 3. Kept revenue paths behind clear protocols so new ad types didn’t fork the pipeline. 4. Coordinated with stakeholders on behavior without breaking the revenue path.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q7. Result (~20–30s)? `(45–60s)`
**Answer:**

> “Maintainable type-safe ads pipeline; lifecycle-correct video reduced wasted playback and UI glitches on a module that mattered for revenue. (No invented fill-rate %.).”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q8. Lesson (~15–20s)? `(45–60s)`
**Answer:**

> “For revenue-critical UI, prefer POP + generics over inheritance trees; lifecycle is part of the product contract. > Provenance: Verified · · BookMyShow · Ads / HeroWidget.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q9. Opener (~10s)? `(45–60s)`
**Answer:**

> “I’ll cover our backend-driven header and the search UX we aligned to MVVM.”.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q10. S/T (~20s)? `(45–60s)`
**Answer:**

> “Main header needed to be CMS/backend-driven; search needed modern UX — debounce and explicit state — aligned to MVVM.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q11. Action (~90s)? `(45–60s)`
**Answer:**

> “1. Migrated header to a generalised, protocol-driven main-screen implementation. 2. Search: debouncing, loading/empty/error state, MVVM binding; cancel in-flight appropriately. 3. Contracted with backend so layout/content could change without app release for many cases. 4. Fail-soft mindset: unknown/bad payloads must not crash the shell (emphasize as design if asked about versioning).”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q12. Result (~20–30s)? `(45–60s)`
**Answer:**

> “Faster content iteration on header; snappier, race-safer search UX.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q13. Lesson (~15–20s)? `(45–60s)`
**Answer:**

> “SDUI needs schema/versioning + client fallbacks — not just “render JSON.” > Provenance: Verified · · BookMyShow · backend-driven header / search.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q14. Supporting openers (≤20–45s)? `(45–60s)`
**Answer:**

> “: “We moved Ads networking off Alamofire onto URLSession so we owned HTTPS, SSL pinning, and a domain whitelist on a high-traffic revenue module.” : “On Aces I integrated live audio streaming and a server-driven splash so cold-start content could stay fresh — measuring time-to-interactive, not just first frame.”.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q15. Interview lines (≤20s)? `(45–60s)`
**Answer:**

> “Ads mock: “I’ll walk a revenue Ads architecture — POP/generics, HeroWidget lifecycle, and URLSession pinning.” SDUI mock: “I’ll walk a fail-soft SDUI pipeline — schema versioning, registry, and BMS/Aces production usage.”.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q16. Leadership hybrid (T3)? `(45–60s)`
**Answer:**

> “When refresh stampede + pin outage same week: > “I’d lead IMOC-style: blast radius, feature guards, rollback/break-glass design, owners, comms — then technical fixes: single-flight refresh, backup pins. Watch TLS failure rate and crash-free. Verified culture: 30L+ DAU and 99.95%+ CFS bar from — without claiming pinning alone owns CFS.”.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---
