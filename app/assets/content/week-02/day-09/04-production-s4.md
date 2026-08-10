# Sample 04 — SSL pinning + URLSession migration (Q&A)

> Guided teaching. Separates **shipped** named cases from **design-if-asked** and **lab-only** so you never blur them in an interview.

---

### Q1. What can you claim under BookMyShow SSL pinning + URLSession migration?
**Answer:**

> BookMyShow SSL pinning + URLSession migration: BookMyShow **Ads** networking migrated **Alamofire → URLSession** with enforced **HTTPS**, **SSL pinning**, and **domain whitelisting** on a high-traffic, revenue-adjacent module. Goal was first-party transport security ownership and reduced dependency surface — not “libraries are evil.” You may **not** claim shadow traffic rollout, a shipped pin-rotation runbook, or that pinning alone moved crash-free rate.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Provenance tag? | BookMyShow SSL pinning + URLSession migration · BookMyShow · Ads; HTTPS; SSL pinning; domain whitelist. |
| Result line? | Reduced MITM exposure; simplified networking ownership on Ads pod path. |
| Lesson line? | Pinning needs rotation **design** (Design: pin rotation / break-glass (not shipped runbook)) or keys changing bricks the app. |

**How can I relate to my case:**
- **Shipped:** BookMyShow SSL pinning + URLSession migration
- **Design if asked:** Design: pin rotation / break-glass (not shipped runbook)
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Claiming pin-rotation / break-glass runbook as a shipped production playbook.

---

### Q2. What is the BookMyShow SSL pinning + URLSession migration STAR story in plain steps?
**Answer:**

> **Situation:** Ads sat on Alamofire; revenue-adjacent module needed stronger control of transport security. **Action:** Introduced URLSession-backed client behind protocol boundaries; enforced HTTPS; added pinning via trust evaluation; added host whitelist in the builder; treated rotation as incomplete without ops mindset (Design: pin rotation / break-glass (not shipped runbook) design). **Result:** First-party security controls and smaller dependency surface on that path. **Lesson:** Security controls need operational paired thinking — backup pins and break-glass are design you insist on.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| 60s version? | Problem → URLSession + HTTPS + pin + whitelist → MITM ↓ → rotation design lesson. |
| Parity tests? | Status mapping, decode, error fixtures through protocol boundary. |
| Observe what after rollout? | TLS failure metrics + Ads health metrics you already have — don’t invent shadow traffic. |

**How can I relate to my case:**
- **Shipped:** BookMyShow SSL pinning + URLSession migration
- **Design if asked:** Design: pin rotation / break-glass (not shipped runbook)
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Claiming pin-rotation / break-glass runbook as a shipped production playbook.

---

### Q3. How do you answer “what happens when the cert rotates?”?
**Answer:**

> Label **Design: pin rotation / break-glass (not shipped runbook) — How I would apply it.** Ship ≥2 backup SPKI pins so planned key transitions don’t hard-brick; know who generates pins from **SPKI DER**; stage pin changes with canary/phased release and watch TLS failure metrics; define monitored break-glass (build flag or remote config) that is time-boxed, not silent forever-off. Default remains fail-closed for MITM resistance. You’re claiming the **control set shipped on Ads** and the **design you’d insist on** — not a named production runbook unless verified.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Backup pins verified shipped? | No — Design: pin rotation / break-glass (not shipped runbook) design. |
| Break-glass verified? | No — design; monitored if ever used. |
| Stale pin after rotate? | Mass TLS failures — why backup pins matter in design. |

**How can I relate to my case:**
- **Shipped:** BookMyShow SSL pinning + URLSession migration
- **Design if asked:** Design: pin rotation / break-glass (not shipped runbook)
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Claiming pin-rotation / break-glass runbook as a shipped production playbook.

---

### Q4. How do you hook BookMyShow backend-driven header & search search cancel without overclaiming BookMyShow SSL pinning + URLSession migration?
**Answer:**

> When asked about cancellation UX, pivot to **BookMyShow backend-driven header & search**: debounce and cancel in-flight search; ignore cancellation errors; prevent out-of-order apply — sibling beat to networking, not part of BookMyShow SSL pinning + URLSession migration Ads migration. Networking chapter supplies the mechanism (Task cancel, generation guards); search chapter supplies the product proof on BMS.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| BookMyShow backend-driven header & search provenance? | BookMyShow backend-driven header & search · search debounce / MVVM state. |
| Async vs callback story? | Prefer async URLSession + Task cancel; legacy dataTask needs explicit cancel. |
| Day 08 link? | Debounce lives in ViewModel — transport doesn’t own keystroke timing. |

**How can I relate to my case:**
- **Shipped:** BookMyShow backend-driven header & search; BookMyShow SSL pinning + URLSession migration
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Claiming pin-rotation / break-glass runbook as a shipped production playbook.

---

### Q5. How does BookMyShow Firebase Performance traces relate to the networking stack?
**Answer:**

> **BookMyShow Firebase Performance traces:** Firebase Performance traces; speak **p50/p90** culture, not vanity averages. Networking relates via path latency in interceptors vs **journey-level** traces (listing → checkout) — placement is judgment (**BookMyShow Firebase Performance traces-A1** if you discuss span ownership). Avoid double-counting the same request in both interceptor and journey spans.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Client timeout vs backend p99? | Misaligned timeouts create self-inflicted errors — coherent with backend SLOs. |
| BookMyShow Firebase Performance traces-A1 label? | How I would apply it — journey vs interceptor span placement. |
| Invented latency %? | Forbidden on BookMyShow Firebase Performance traces and BookMyShow SSL pinning + URLSession migration alike. |

**How can I relate to my case:**
- **Shipped:** BookMyShow SSL pinning + URLSession migration; BookMyShow Firebase Performance traces
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Claiming pin-rotation / break-glass runbook as a shipped production playbook.

---

### Q6. What is the payment retry hook (BookMyShow payment processing-status popup)?
**Answer:**

> When interviewers ask about retries on charge POSTs, cite **BookMyShow payment processing-status popup** payment UX intent: networking SDK must **not** blindly retry payment POSTs after 401 or 5xx. Checkout needs **idempotency keys** and explicit status polling discipline — generic “retry all methods” interceptors are how you duplicate charges. Single-flight refresh may retry GETs once; POSTs opt in only with server contract.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| 401 on payment POST? | Refresh once, retry only if idempotent contract allows. |
| Generic retry helper? | Never global on all HTTP methods. |
| Drop-off % invented? | Forbidden on BookMyShow payment processing-status popup — speak intent only. |

**How can I relate to my case:**
- **Shipped:** BookMyShow payment processing-status popup
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented checkout drop-off % from the status popup alone.

---

### Q7. What is the ≤20s interview line for Day 09 production?
**Answer:**

> “I moved Ads off Alamofire onto URLSession so we owned HTTPS, SSL pinning, and a domain whitelist on a high-traffic revenue module — and I’d pair pinning with backup pins and a break-glass design so rotation doesn’t brick the app.” Expand to 90s HLD with single-flight refresh, cancel split, cache boundaries, and SPKI correctness if whiteboarding.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Weak “why URLSession?” | “Libraries bad.” — Strong: threat/value on Ads justified first-party control. |
| ATS enough alone? | Baseline HTTPS policy; pinning is extra identity for threat model. |
| Next day link? | Day 10 SDUI uses repository/offline cache; Day 09 whitelist mindset applies to action URLs. |

**How can I relate to my case:**
- **Shipped:** None for this prompt — keep it conceptual unless they ask for a case.
- **Design if asked:** N/A
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q8. Interceptor vs journey-span — where does observability depth live?
**Answer:**

> Put **lightweight per-path latency** in an interceptor for baseline networking health (method, path template, status, duration). Keep **product journey traces** — listing → checkout, search submit → results — at the call site or coordinator so spans match user-visible flows. Avoid double-counting the same interval under two names; keep trace names free of PII; prefer path templates over raw query strings for cardinality. Speak **p50/p90** culture (BookMyShow Firebase Performance traces); exact interceptor-versus-journey split is judgment (**BookMyShow Firebase Performance traces-A1** when you discuss span ownership).

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Only interceptors? | Trap — journeys answer product questions interceptors cannot. |
| What is p90? | 90% of samples are faster than this value — better than vanity averages. |
| Double-count symptom? | Same request duration appears as both `/v1/cart` path and `checkout_journey` without a clear ownership rule. |

**How can I relate to my case:**
- **Shipped:** BookMyShow Firebase Performance traces
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

Back to: [README.md](README.md) · Main questions: [07-revision-qna.md](07-revision-qna.md)

---

## Brain puzzles (cover → think → check)

### Puzzle A — What is the BookMyShow SSL pinning + URLSession migration STAR story in plain st

**Ask yourself:** What is the BookMyShow SSL pinning + URLSession migration STAR story in plain steps?

**Answer:** “**Situation:** Ads sat on Alamofire; revenue-adjacent module needed stronger control of transport security. **Action:** Introduced URLSession-backed client behind protocol boundaries; enforced HTTPS; added pinning via trust evaluation; added host whitelist in the builder; treated rotation as incomplete without ops mindset (Design: pin rotation / break-glass (not shipped runbook) design). **Result:** First-party security controls and smaller dependency surface on that path. **Lesson:** Security controls need operational paired thinking — backup pins and break-glass are design you insist on.”

### Puzzle B — How do you answer “what happens when the cert rotates?”

**Ask yourself:** How do you answer “what happens when the cert rotates?”?

**Answer:** “Label **Design: pin rotation / break-glass (not shipped runbook) — How I would apply it.** Ship ≥2 backup SPKI pins so planned key transitions don’t hard-brick; know who generates pins from **SPKI DER**; stage pin changes with canary/phased release and watch TLS failure metrics; define monitored break-glass (build flag or remote config) that is time-boxed, not silent forever-off. Default remains fail-closed for MITM resistance. You’re claiming the **control set shipped on Ads** and the **design you’d insist on** — not a named production runbook unless verified.”

### Puzzle C — How do you hook BookMyShow backend-driven header & search search cancel without 

**Ask yourself:** How do you hook BookMyShow backend-driven header & search search cancel without overclaiming BookMyShow SSL pinning + URLSession migration?

**Answer:** “When asked about cancellation UX, pivot to **BookMyShow backend-driven header & search**: debounce and cancel in-flight search; ignore cancellation errors; prevent out-of-order apply — sibling beat to networking, not part of BookMyShow SSL pinning + URLSession migration Ads migration. Networking chapter supplies the mechanism (Task cancel, generation guards); search chapter supplies the product proof on BMS.”
