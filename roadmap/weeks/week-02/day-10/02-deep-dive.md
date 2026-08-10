# 02 — Deep Dive: Schema, Registry, Fallbacks, Cold Start, Parity (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Simple language. Named work only — never S-codes in speech.

---

### Q1. End-to-end data flow? `(45–60s)`
**Answer:**

> “text ┌─────────────┐ fetch ┌────────────────┐ │ Header/Splash│ ───────► │ SDUI Repository │ │ ViewModel │ └────────┬───────┘ └─────────────┘ │ network or cache ▼ ┌────────────────┐ │ Version gate │ reject → FallbackEngine └────────┬───────┘ │ ok ▼ ┌────────────────┐ │ Parser / tree │ └────────┬───────┘ ▼ ┌────────────────┐ │ Registry walk │ unknown → skip + metric └────────┬───────┘ ▼ ┌────────────────┐ │ Native views │ + ActionHandler (allowlist) └────────────────┘.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q2. Responsibilities? `(45–60s)`
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

### Q3. Schema shape (illustrative)? `(45–60s)`
**Answer:**

> “json { "schemaVersion": 3, "id": "home_header", "root": { "type": "vstack", "children": [ { "type": "logo", "props": { "style": "primary" } }, { "type": "promoBanner", "props": { "title": "Weekend deals" }, "action": { "type": "open_deeplink", "payload": { "url": "bms://offers/weekend" } } }, { "type": "sparkle_v9", "props": {} } ] } } Client with registry {vstack, logo, promoBanner}:.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q4. Version gate mechanics? `(45–60s)`
**Answer:**

> “See code/SchemaVersionGate.swift.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q5. Design rules? `(45–60s)`
**Answer:**

> “1. Fail soft on unknown — never fatalError on CMS strings. 2. Validate known props strictly — bad props on a known type may skip that node or use safe defaults (pick a policy; be consistent). 3. Stable identity — each node should carry a server id for SwiftUI identity / analytics (Day 12 link). 4. Keep leaves dumb — registry returns views; VM owns payload lifecycle. 5. App vs SDK ownership — app-specific header components in app module; shared primitives can live in a UI kit. Stories SDK lesson: clear public API if shared.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q6. Partial failure vs empty root? `(45–60s)`
**Answer:**

> “Skipping children is fine. If the root resolves to nothing meaningful (no logo on splash, no header chrome), engage hard fallback. Skipping forever without metrics hides broken contracts.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q7. FallbackEngine? `(45–60s)`
**Answer:**

> “See code/FallbackEngine.swift.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q8. Actions & security? `(45–60s)`
**Answer:**

> “text ActionHandler.handle(action) → type in allowlist? no → metric + return yes → validate payload (URL host, deeplink scheme) → dispatch to Router / Safari / refresh.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q9. Analytics in SDUI? `(45–60s)`
**Answer:**

> “Server may attach analytics: { event, params }. Client should: - Validate event names against allowlist or prefix rules - Inject common context (screen, app version, user bucket) - Refuse to log unchecked PII from CMS.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q10. BMS header (S3) — architecture reading? `(45–60s)`
**Answer:**

> “Verified claims: - Protocol-driven generalised main-screen header from backend/CMS - Contracts so many layout/content changes don’t need App Store - Search MVVM sibling (Day 08).”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q11. Aces splash (S12) — cold start reading? `(45–60s)`
**Answer:**

> “Verified: server-driven splash; cold-start flexibility/freshness; audio streaming companion work. No invented milliseconds. Design checklist for splash SDUI:.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q12. iOS / Android parity? `(45–60s)`
**Answer:**

> “Parity is negotiated, not hoped.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q13. Testing SDUI? `(45–60s)`
**Answer:**

> “Don’t try to UITest every CMS combination — combinatorial explosion.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q14. SDUI vs feature flags vs A/B? `(45–60s)`
**Answer:**

> “Often combined: flag enables SDUI surface; CMS/A/B supplies variant layout.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q15. When SDUI is a bad idea? `(45–60s)`
**Answer:**

> “- Highly interactive unique UI with heavy custom animation - Strong one-off a11y requirements hard to schema - Rarely changing surfaces - Team without schema QA / contract tests - Revenue video lifecycle that needs native pause/play guarantees ( HeroWidget) — use SDUI for config/placement, keep media native.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q16. Performance notes? `(45–60s)`
**Answer:**

> “- Parse off main when payloads grow - Budget interaction frames; prewarm splash cache - Incremental render if tree is large - Image props still go through a bounded image pipeline (Week 3) Parser-on-main dropping frames is an NFR bug, not “JSON’s fault.”.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q17. Trade-off tables? `(45–60s)`
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

### Q18. Whiteboard script (5 min) — Mock #2 style? `(45–60s)`
**Answer:**

> “1. Draw schema → gate → registry → actions → fallback 2. State unknown-component policy 3. Map BMS header + Aces splash 4. Call out versioning as design 5. Contrast native Ads media if asked Agenda:.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q19. Failure modes? `(45–60s)`
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

### Q20. Decision rule card? `(45–60s)`
**Answer:**

> “text 1. Dynamic content/layout need + native quality? → SDUI hybrid 2. Always: version gate + unknown skip + fallback 3. Actions allowlisted; no script exec 4. Splash: cache + timeout default 5. New types need app release; CMS isn’t infinite 6. Speak verified; as design.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q21. Optional citations (appendix)? `(45–60s)`
**Answer:**

> “- In-repo: ios-system-design/docs/sdui-engine.md, feature-flag-system.md, ab-testing-experimentation-sdk.md - Apple: native view performance / accessibility guidance (not required to study).”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q22. Bridge? `(45–60s)`
**Answer:**

> “Next: 03-production-bridge.md — , , honesty.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---
