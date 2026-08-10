# 02 — Deep Dive: Routing, Airship, CI Gates (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Simple language. Named work only — never S-codes in speech.

---

### Q1. Universal Links debugging checklist? `(45–60s)`
**Answer:**

> “When links open Safari instead of the app: 1. AASA reachable over HTTPS; correct content-type 2. appID = TEAMID.bundle 3. Paths match (not excluded) 4. Entitlements associated domains 5. Apple CDN / device cache delay after AASA changes 6. User long-press “Open in Safari” preference 7. Universal Links vs opening from notes/apps quirks.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q2. Router architecture? `(45–60s)`
**Answer:**

> “text Entrypoints: UL Spotlight (optional) ↓ DeepLinkParser → AppRoute (typed enum) ↓ AuthGate / Validate params ↓ Coordinator.navigate(route) OR PendingDeepLinkStore.enqueue Why one table: dual routers (push vs UL) drift — checkout works from one entry and 404s from another.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q3. Deferred deep links? `(45–60s)`
**Answer:**

> “- Install attribution window; first launch fetches pending route - Expiry (industry often ~days, not forever) - Privacy / probabilistic matching limits — don’t overclaim certainty - Prefer first-party login then route when identity matters ---.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q4. Push deep dive? `(45–60s)`
**Answer:**

> “Airship vs Mixpanel: Airship = push/engagement; Mixpanel = analytics product behavior — complementary, not synonyms.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q5. PR checks? `(45–60s)`
**Answer:**

> “Lint + build + unit tests on macOS runners; selective tests when modularized; quarantine flakes.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q6. Signing? `(45–60s)`
**Answer:**

> “Encrypted certs/profiles (match-style); CI secrets / OIDC; CODE_SIGNING deterministic; never log secrets.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q7. TestFlight + phased release? `(45–60s)`
**Answer:**

> “- Internal smoke before external - Phased % with stop criteria: CFS drop, pin-fail spike, journey p90 cliff - Feature flags decouple binary ship from exposure.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q8. dSYM? `(45–60s)`
**Answer:**

> “Upload every build that can reach users — Day 18 triage depends on it.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q9. AI on PRs (S9)? `(45–60s)`
**Answer:**

> “AI accelerates review for obvious regressions; humans own architecture, security, and product trade-offs. I never say ‘AI approved so it’s fine.’” ---.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q10. Secure checkout link? `(45–60s)`
**Answer:**

> “- Auth gate - Server-authoritative cart/price - Ignore spoofed query prices - Confirm destructive actions ---.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q11. Trade-offs? `(45–60s)`
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

### Q12. Failure modes? `(45–60s)`
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

### Q13. End-to-end story you can draw in 3 minutes? `(45–60s)`
**Answer:**

> “text Campaign https link ──► AASA / UL Airship push tap ──► payload route \ / → DeepLinkParser → AppRoute ↓ AuthGate (checkout?) ↓ Coordinator (hybrid UIKit/SwiftUI stack) ↓ Mixpanel screen event | Airship engagement attribution Meanwhile release train: PR Actions → TestFlight → phased % → CFS/p90 monitors → pause/IMOC.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q14. BMS CI elevator (45s) + Grizzlies (90s) back-to-back? `(45–60s)`
**Answer:**

> “CI: “We automated GitHub Actions for lint, build, and TestFlight upload so the release path stopped depending on who remembered the manual checklist. Signing secrets stay in CI — not the repo. Phased rollout still needs human stop criteria on crash-free and perf.” Grizzlies: “On Grizzlies I designed hybrid SwiftUI/UIKit surfaces with real navigation ownership, deep links into that stack, Mixpanel for product analytics, and Airship for push engagement — one router mindset so campaigns and https links don’t drift.”.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q15. Optional citations? `(45–60s)`
**Answer:**

> “- deep-linking / push / mobile-ci-cd docs - Stories , , Self-contained without opens.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---
