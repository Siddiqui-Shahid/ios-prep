# 03 — Production Bridge: BMS Header, Aces Splash, S3-A1 Design (Q&A)

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

> “- “We eval CMS JavaScript.” - Invented cold-start latency numbers. - “ was our production VersioningService I named in resume.” - “SDUI alone produced 99.95% crash-free.” - Claiming Ads HeroWidget was fully SDUI ( is native lifecycle).”

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

> “I’ll walk through making BookMyShow’s main header backend-driven with a protocolised client so content could move faster without waiting on releases.”.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q4. Situation / Task? `(45–60s)`
**Answer:**

> “Main header needed CMS/backend-driven flexibility; content and layout iteration was gated by app releases more than necessary.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q5. Action? `(45–60s)`
**Answer:**

> “1. Migrated header toward a generalised, protocol-driven main-screen implementation. 2. Contracted APIs with backend so many layout/content changes didn’t need App Store. 3. Kept client native and structured — not a WebView rewrite of chrome. 4. Paired with search MVVM improvements (debounce/states) on the same surface family.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q6. Result? `(45–60s)`
**Answer:**

> “Faster content iteration on header; clearer client contracts.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q7. Lesson? `(45–60s)`
**Answer:**

> “SDUI needs schema/versioning and client fallbacks — not just “render JSON.” That lesson is why design matters in interviews. > Provenance: Verified · · BookMyShow · backend-driven header.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q8. S3-A1 — Versioning & unknown fallback as design? `(45–60s)`
**Answer:**

> “When asked “what if backend sends a new component type / breaking schema?”, answer as design judgment:.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q9. Opener (~10s)? `(45–60s)`
**Answer:**

> “On Las Vegas Aces I revamped splash to be server-driven so cold-start content could stay fresh and flexible — alongside live audio streaming work.”.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q10. Action highlights? `(45–60s)`
**Answer:**

> “1. Server-driven splash content path. 2. Treat startup as product surface: prefer cached/flexible content with safe defaults over blocking forever. 3. Audio streaming integrated as separate live capability — don’t serialize everything on launch.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q11. Result? `(45–60s)`
**Answer:**

> “Richer live audio; more flexible cold-start content. Do not invent ms.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q12. Lesson? `(45–60s)`
**Answer:**

> “Measure time-to-interactive; cache + timeout-to-default. > Provenance: Verified · · Raw/Aces · server-driven splash.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q13. Interview lines (≤20s)? `(45–60s)`
**Answer:**

> “: “I made the BMS main header backend-driven with a protocolised client so many layout changes didn’t need a release — and I’d pair that with version gates and fail-soft unknowns as design.” : “On Aces I shipped a server-driven splash for colder-start flexibility and freshness, with safe defaults so startup never depended on a perfect network.”.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q14. Topic mapping? `(45–60s)`
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

### Q15. Interviewer pushes? `(45–60s)`
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

### Q16. Practice versions? `(45–60s)`
**Answer:**

> “60s : problem (release-gated header) → protocolised CMS header → faster iteration → lesson (versioning/fallback design). 60s : inflexible splash → server-driven splash + safe defaults → flexible cold start → lesson (TTI mindset).”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q17. Links? `(45–60s)`
**Answer:**

> “- Code: code/ - Questions: sample/07-revision-qna.md - Revision: ../../../revision/weeks/week-02/day-10.md - Stories: #s3--backend-driven-header--search-bookmyshow · #s12--audio-streaming--server-driven-splash-raw--las-vegas-aces.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---
