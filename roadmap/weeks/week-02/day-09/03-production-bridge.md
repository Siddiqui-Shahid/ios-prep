# 03 — Production Bridge: BMS Ads Networking & Honest Provenance

> Convert theory into interview stories without overclaiming.

## 1. Provenance map for today

| ID | Label | Exact claim you may make |
|---|---|---|
| **S4** | Verified | Ads networking migrated **Alamofire → URLSession**; enforced **HTTPS**, **SSL pinning**, **domain whitelisting** |
| **S4-A1** | How I would apply it | **Pin rotation**, **backup pins**, staged **break-glass** as **design** — not “I shipped the ops runbook” |
| **S3** | Verified | Search debounce / state / cancel behavior (cancellation UX sibling) |
| **S5** | Verified | Firebase Performance traces; talk **p50/p90** culture |
| **S5-A1** | How I would apply it | Journey-level traces vs per-request interceptor spans |
| **S7** | Verified | Payment processing popup intent — use when discussing **no blind POST retry** |
| Learning-lab | Illustrative | `SingleFlightRefresh`, sample client shapes in this chapter |

### Forbidden overclaims (do not say as fact)

- “I shipped a pin-rotation runbook / break-glass flag to production.”
- “We rolled out with shadow traffic.” (not in Verified S4)
- “Pinning alone caused / fixed app-wide crash-free rate.”
- “ATS is our pinning.”
- “We hash `SecKeyCopyExternalRepresentation` as SPKI.”

## 2. Verified S4 — STAR you can deliver (2–3 min)

### Timed opener (~10s)

> “I’ll walk through migrating BookMyShow Ads networking from Alamofire to URLSession so we owned transport security on a revenue-critical module.”

### Situation / Task (~20s)

Ads networking sat on Alamofire. For a high-traffic, revenue-adjacent module we needed stronger first-party control over transport security and a smaller dependency surface — specifically HTTPS enforcement, SSL pinning, and domain whitelisting.

### Action (~90s)

1. Introduced a first-party networking path on **`URLSession`** behind clear call-site boundaries so Ads code didn’t care about Alamofire types.
2. Enforced **HTTPS** for API traffic on that stack.
3. Added **SSL pinning** via session trust evaluation so unexpected certificates fail closed for pinned hosts.
4. Added a **domain whitelist** so the client only talks to approved hosts — reducing misconfig / unexpected host risk.
5. Treated pinning as incomplete without an ops mindset: rotation and failure behavior must be designed (see S4-A1 — design, not a claim I shipped the runbook).

### Result (~20–30s)

Reduced MITM exposure on a sensitive high-traffic Ads module and simplified first-party networking ownership. Dependency surface shrank on that pod path.

### Lesson (~15–20s)

Pinning without a rotation / backup / break-glass **design** is how teams create self-inflicted outages when certs or keys change. Security controls need operational paired thinking.

### Provenance tag

> **Provenance:** Verified · S4 · BookMyShow · Ads Alamofire → URLSession; HTTPS; SSL pinning; domain whitelist

## 3. S4-A1 — Pin ops as design (speak carefully)

When interviewers ask “what happens when the cert rotates?”, answer as **design judgment**:

| Design element | Intent |
|---|---|
| **Backup pins** | Ship ≥2 acceptable SPKI hashes so a planned key transition doesn’t hard-brick the app |
| **Pin set ownership** | Know who generates pins from **SPKI DER** (not raw key export bytes) |
| **Staged exposure** | Prefer canary / phased release of pin changes; watch TLS failure metrics |
| **Break-glass** | A carefully scoped emergency path (build flag / remote config) — monitored, time-boxed, never “silent forever off” |
| **Fail closed by default** | MITM resistance means mismatch cancels the challenge |

**Script fragment:**

> “On Ads we shipped pinning and whitelist on URLSession. Separately, as design, I’d require backup pins and a monitored break-glass plan — pinning without rotation thinking is an outage generator. I’m not claiming I shipped that full ops runbook; I’m claiming the control set we owned and the design I’d insist on.”

> **Provenance:** How I would apply it · S4-A1 · pin rotation / backup pins / break-glass as design

## 4. Interview line (≤20s)

> “I moved Ads off Alamofire onto URLSession so we owned HTTPS, SSL pinning, and a domain whitelist on a high-traffic revenue module — and I’d pair pinning with backup pins and a break-glass design so rotation doesn’t brick the app.”

## 5. Adjacent production hooks (keep them honest)

### Search cancel — S3

Use when asked about cancellation UX: debounce + cancel in-flight search; ignore cancellation errors; prevent out-of-order apply.

> **Provenance:** Verified · S3 · search debounce / MVVM state

### Performance — S5

Use when asked how networking relates to latency culture: instrument journeys; optimize with p50/p90, not averages.

> **Provenance:** Verified · S5 · Firebase Performance p50/p90

If discussing interceptor vs journey placement:

> **Provenance:** How I would apply it · S5-A1 · journey traces vs interceptor spans

### Payments — S7

Use when asked about retries: networking SDK must not blindly retry charge POSTs; checkout needs idempotency / status polling discipline.

> **Provenance:** Verified · S7 · payment processing UX intent (no invented drop-off %)

## 6. Mapping chapter topics → what you built vs what you design

| Topic | Verified? | How to speak |
|---|---|---|
| Alamofire → URLSession | Yes · S4 | “We migrated Ads networking.” |
| HTTPS enforcement | Yes · S4 | “Enforced HTTPS on that stack.” |
| SSL pinning | Yes · S4 | “Added pinning for Ads hosts.” |
| Domain whitelist | Yes · S4 | “Only approved hosts.” |
| Pin rotation runbook | No · S4-A1 | “Design I’d apply / insist on.” |
| Backup pins | No · S4-A1 | Design |
| Break-glass disable | No · S4-A1 | Design; monitored |
| Shadow traffic rollout | No | Do not claim |
| Single-flight refresh actor | Learning-lab / general architecture | “How I’d implement refresh concurrency.” |
| SPKI DER hashing | Correctness teaching | Technical accuracy, not a BMS metric |

## 7. Threat model for Ads (short)

Why Ads deserved first-party controls:

- High volume / revenue-adjacent traffic.
- Attractive target for injection / MITM on hostile networks.
- Third-party creative ecosystems increase “unexpected URL” risk — **API whitelist** is still valuable even if images load from CDNs under separate rules.
- Dependency ownership: fewer moving parts when security reviews ask “who controls the session delegate?”

## 8. Migration narrative beats (whiteboard)

```text
1. Protocol boundary at call sites
2. URLSession implementation + parity tests
3. HTTPS only
4. Pinning delegate (SPKI hashes)
5. Host whitelist in builder
6. Design: backup pins + rotation + break-glass (S4-A1)
7. Observe TLS failures + Ads health metrics
```

Do not invent a sixth verified bullet like “shadow traffic.” If asked how you’d roll out: answer as judgment — phased release, metrics, canary — labeled as design.

## 9. Common interviewer pushes & honest replies

| Push | Weak reply | Strong reply |
|---|---|---|
| “Why not keep Alamofire?” | “Libraries are bad.” | “Ads needed first-party pinning/whitelist ownership and less dependency surface; cost justified on that module.” |
| “Did pinning break you?” | “Never.” | “Pinning’s failure mode is outage; that’s why backup pins and break-glass are part of the design.” |
| “ATS enough?” | “Yes.” | “ATS is baseline HTTPS policy; pinning is an extra identity check for our threat model.” |
| “Whole app on URLSession?” | “Obviously.” | “Risk-based: start where threat/value highest — we did Ads first.” |
| “Show SPKI code” | Hash raw SecKey bytes | Explain SPKI DER → SHA-256; call out the common mistake |

## 10. Practice: 60s vs 3 min versions

**60s:** problem (Alamofire on Ads) → action (URLSession + HTTPS + pin + whitelist) → result (first-party control / MITM ↓) → lesson (design rotation).

**3 min:** add parity testing, why whitelist, ATS≠pinning, SPKI one-liner, S4-A1 backup/break-glass as design, cancel/refresh only if asked.

## 11. Link back to study artifacts

- Code: [code/SingleFlightRefresh.swift](code/SingleFlightRefresh.swift)
- Questions: [04-questions.md](04-questions.md)
- Revision twin: [../../../revision/weeks/week-02/day-09.md](../../../revision/weeks/week-02/day-09.md)
- Story bank: [../../../stories/story-bank.md](../../../stories/story-bank.md)#s4--ssl-pinning--alamofire--urlsession-bookmyshow
