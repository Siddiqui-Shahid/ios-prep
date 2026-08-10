# Day 09 — URLSession Networking · Refresh · Pinning

> Week 2 · Revision pass ~45–60 min  
> Full study: [weeks/week-02/day-09/](../../../weeks/week-02/day-09/README.md)  
> Sample Q&A (guided): [weeks/week-02/day-09/sample/](../../../weeks/week-02/day-09/sample/README.md)

## 1. Outcome

Explain aloud, in plain sentences:

- A clean networking pipeline: endpoint → build → intercept → execute → decode → map errors
- Single-flight token refresh: many concurrent 401s share one refresh; retry originals once
- Task cancellation with async/await vs callback APIs
- ATS vs SSL pinning vs domain whitelist — and the SPKI hashing trap
- BookMyShow SSL pinning + URLSession migration Ads migration: Alamofire → URLSession with HTTPS, pinning, whitelist

## 2. Concept refresh (simple)

### 2.1 Pipeline shape

Endpoint describes path/method/body → builder assembles `URLRequest` → interceptors attach auth/headers → execute via `URLSession` → decode DTO → map to typed domain errors. Keep transport out of ViewModels.

### 2.2 Refresh + cancel

**Single-flight:** first 401 starts refresh; concurrent callers enqueue as waiters (FIFO continuations); one refresh completes; fan-out retries originals **once** — no refresh stampede.

**Cancellation:** `URLSession.data(for:)` participates in `Task` cancellation. Callback APIs need explicit `task.cancel()` plus generation/stale guards.

### 2.3 Security layers

| Layer | What it does |
|---|---|
| **ATS** | HTTPS baseline — not pinning |
| **SSL pinning** | Extra identity check on pinned hosts — fail closed |
| **Domain whitelist** | Client only talks to approved hosts |
| **SPKI** | Hash **SPKI DER** — not raw `SecKeyCopyExternalRepresentation` bytes |

### 2.4 Critical truths (pin)

| Claim | Truth |
|---|---|
| Pipeline | Endpoint → build → intercept → execute → decode → map errors |
| Single-flight | Many concurrent 401s share **one** refresh; retry originals **once** |
| Async cancel | `URLSession.data(for:)` participates in `Task` cancellation |
| Callback cancel | Explicit `task.cancel()` + generation/stale guard |
| ATS ≠ pinning | ATS is HTTPS baseline; pinning is extra identity check |
| SPKI | Hash **SPKI DER** — not raw `SecKeyCopyExternalRepresentation` bytes |
| BookMyShow SSL pinning + URLSession migration verified | Alamofire → URLSession; HTTPS; SSL pinning; domain whitelist |
| Design: pin rotation / break-glass (not shipped runbook) | Pin rotation / backup pins / break-glass = **design**, not shipped runbook |

## 3. Read these

| Priority | Resource | Why |
|---|---|---|
| Must | [Sample Q&A](../../../weeks/week-02/day-09/sample/) | Guided cards |
| Must | Full modules [01–03](../../../weeks/week-02/day-09/01-foundations.md) | Gaps |
| Drill | [07-revision-qna](../../../weeks/week-02/day-09/sample/07-revision-qna.md) | Timed answers |

Suggested sample order: `01-networking-layer` → `02-refresh-and-cancel` → `03-pinning-security` → `04-production-s4`.

## 4. Map to your work

**BookMyShow SSL pinning + URLSession migration:** BookMyShow Ads — migrated Alamofire → URLSession; enforced HTTPS, SSL pinning, domain whitelisting on a revenue-critical module.  
**Design: pin rotation / break-glass (not shipped runbook):** Pin rotation, backup pins, break-glass as **design judgment** — not a shipped ops runbook.

**Interview line (≤20s):** “I migrated Ads networking to URLSession so we owned transport security — HTTPS, pinning, and a domain whitelist on a high-traffic revenue path.”

→ [BookMyShow SSL pinning + URLSession migration Ads networking](../../stories/story-bank.md#s4--ads-networking-migration-bookmyshow)

## 5. Flash prompts

1. Networking pipeline end-to-end in one breath
2. Single-flight refresh — why not one refresh per 401?
3. Async cancel vs callback cancel
4. ATS vs pinning vs whitelist — three different jobs
5. SPKI trap — what bytes do you hash?
6. What happens when the cert rotates? (Design: pin rotation / break-glass (not shipped runbook) design answer)
7. BookMyShow SSL pinning + URLSession migration ≤20s pitch — no invented shadow-traffic claims
8. No blind POST retry — tie to BookMyShow payment processing-status popup payment intent if asked

## 6. Timed drills

| Drill | Budget |
|---|---|
| Pipeline whiteboard | 60s |
| Single-flight refresh walkthrough | 90s |
| ATS vs pinning vs whitelist | 45s |
| Cert rotation design (Design: pin rotation / break-glass (not shipped runbook)) | 90s |
| BookMyShow SSL pinning + URLSession migration ≤20s pitch | 20s |

Expand from [sample cards](../../../weeks/week-02/day-09/sample/) and [07-revision-qna](../../../weeks/week-02/day-09/sample/07-revision-qna.md) answer points.
