# Sample 04 — Production S4 and adjacent hooks (Q&A)

> Guided teaching. Verified S4 facts vs S4-A1 design judgment.

---

### Q1. What can you claim under Verified · S4?

**Points to:** [Production bridge · §1 Provenance map](../03-production-bridge.md#1-provenance-map-for-today) · [Production bridge · §2 Verified S4](../03-production-bridge.md#2-verified-s4--star-you-can-deliver-23-min)

**Answer:**

> Verified S4: BookMyShow **Ads** networking migrated **Alamofire → URLSession** with enforced **HTTPS**, **SSL pinning**, and **domain whitelisting** on a high-traffic, revenue-adjacent module. Goal was first-party transport security ownership and reduced dependency surface — not “libraries are evil.” You may **not** claim shadow traffic rollout, a shipped pin-rotation runbook, or that pinning alone moved crash-free rate.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Provenance tag? | Verified · S4 · BookMyShow · Ads; HTTPS; SSL pinning; domain whitelist. |
| Result line? | Reduced MITM exposure; simplified networking ownership on Ads pod path. |
| Lesson line? | Pinning needs rotation **design** (S4-A1) or keys changing bricks the app. |

---

### Q2. What is the S4 STAR story in plain steps?

**Points to:** [Production bridge · §2 Verified S4](../03-production-bridge.md#2-verified-s4--star-you-can-deliver-23-min) · [Deep dive · §9 Migration mechanics](../02-deep-dive.md#9-alamofire--urlsession-migration-mechanics)

**Answer:**

> **Situation:** Ads sat on Alamofire; revenue-adjacent module needed stronger control of transport security. **Action:** Introduced URLSession-backed client behind protocol boundaries; enforced HTTPS; added pinning via trust evaluation; added host whitelist in the builder; treated rotation as incomplete without ops mindset (S4-A1 design). **Result:** First-party security controls and smaller dependency surface on that path. **Lesson:** Security controls need operational paired thinking — backup pins and break-glass are design you insist on.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| 60s version? | Problem → URLSession + HTTPS + pin + whitelist → MITM ↓ → rotation design lesson. |
| Parity tests? | Status mapping, decode, error fixtures through protocol boundary. |
| Observe what after rollout? | TLS failure metrics + Ads health metrics you already have — don’t invent shadow traffic. |

---

### Q3. How do you answer “what happens when the cert rotates?”

**Points to:** [Production bridge · §3 S4-A1](../03-production-bridge.md#3-s4-a1--pin-ops-as-design-speak-carefully) · [Production bridge · §6 Topic mapping](../03-production-bridge.md#6-mapping-chapter-topics--what-you-built-vs-what-you-design)

**Answer:**

> Label **S4-A1 — How I would apply it.** Ship ≥2 backup SPKI pins so planned key transitions don’t hard-brick; know who generates pins from **SPKI DER**; stage pin changes with canary/phased release and watch TLS failure metrics; define monitored break-glass (build flag or remote config) that is time-boxed, not silent forever-off. Default remains fail-closed for MITM resistance. You’re claiming the **control set shipped on Ads** and the **design you’d insist on** — not a named production runbook unless verified.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Backup pins verified shipped? | No — S4-A1 design. |
| Break-glass verified? | No — design; monitored if ever used. |
| Stale pin after rotate? | Mass TLS failures — why backup pins matter in design. |

---

### Q4. How do you hook S3 search cancel without overclaiming S4?

**Points to:** [Production bridge · §5 Search cancel S3](../03-production-bridge.md#search-cancel--s3) · [Deep dive · §5 Cancellation](../02-deep-dive.md#5-cancellation-internals)

**Answer:**

> When asked about cancellation UX, pivot to **Verified S3**: debounce and cancel in-flight search; ignore cancellation errors; prevent out-of-order apply — sibling beat to networking, not part of S4 Ads migration. Networking chapter supplies the mechanism (Task cancel, generation guards); search chapter supplies the product proof on BMS.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| S3 provenance? | Verified · S3 · search debounce / MVVM state. |
| Async vs callback story? | Prefer async URLSession + Task cancel; legacy dataTask needs explicit cancel. |
| Day 08 link? | Debounce lives in ViewModel — transport doesn’t own keystroke timing. |

---

### Q5. How does S5 relate to the networking stack?

**Points to:** [Production bridge · §5 Performance S5](../03-production-bridge.md#performance--s5) · [Deep dive · §3 Interceptors](../02-deep-dive.md#3-interceptor-pipeline-explicit)

**Answer:**

> **Verified S5:** Firebase Performance traces; speak **p50/p90** culture, not vanity averages. Networking relates via path latency in interceptors vs **journey-level** traces (listing → checkout) — placement is judgment (**S5-A1** if you discuss span ownership). Avoid double-counting the same request in both interceptor and journey spans.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Client timeout vs backend p99? | Misaligned timeouts create self-inflicted errors — coherent with backend SLOs. |
| S5-A1 label? | How I would apply it — journey vs interceptor span placement. |
| Invented latency %? | Forbidden on S5 and S4 alike. |

---

### Q6. What is the payment retry hook (S7)?

**Points to:** [Production bridge · §5 Payments S7](../03-production-bridge.md#payments--s7) · [Deep dive · §4.4 Retry policy](../02-deep-dive.md#44-retry-policy-after-refresh)

**Answer:**

> When interviewers ask about retries on charge POSTs, cite **Verified S7** payment UX intent: networking SDK must **not** blindly retry payment POSTs after 401 or 5xx. Checkout needs **idempotency keys** and explicit status polling discipline — generic “retry all methods” interceptors are how you duplicate charges. Single-flight refresh may retry GETs once; POSTs opt in only with server contract.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| 401 on payment POST? | Refresh once, retry only if idempotent contract allows. |
| Generic retry helper? | Never global on all HTTP methods. |
| Drop-off % invented? | Forbidden on S7 — speak intent only. |

---

### Q7. What is the ≤20s interview line for Day 09 production?

**Points to:** [Production bridge · §4 Interview line](../03-production-bridge.md#4-interview-line-20s) · [Deep dive · §15 Ready-to-speak HLD](../02-deep-dive.md#15-ready-to-speak-90s-networking-hld)

**Answer:**

> “I moved Ads off Alamofire onto URLSession so we owned HTTPS, SSL pinning, and a domain whitelist on a high-traffic revenue module — and I’d pair pinning with backup pins and a break-glass design so rotation doesn’t brick the app.” Expand to 90s HLD with single-flight refresh, cancel split, cache boundaries, and SPKI correctness if whiteboarding.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Weak “why URLSession?” | “Libraries bad.” — Strong: threat/value on Ads justified first-party control. |
| ATS enough alone? | Baseline HTTPS policy; pinning is extra identity for threat model. |
| Next day link? | Day 10 SDUI uses repository/offline cache; Day 09 whitelist mindset applies to action URLs. |

---

Back to: [README.md](README.md) · Main questions: [../04-questions.md](../04-questions.md)
