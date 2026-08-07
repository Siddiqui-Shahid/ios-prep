# Day 21 — System-Design Mock #3 (45 min)

> Week 3 · Revision pass ~45–60 min  
> Full study: [weeks/week-03/day-21/](../../../weeks/week-03/day-21/README.md)  
> Sample Q&A (guided): [weeks/week-03/day-21/sample/](../../../weeks/week-03/day-21/sample/README.md)

## 1. Outcome

Explain aloud, in plain sentences:

- Run a **45-min** mobile SD: **clarify → HLD → API → deep dive → ops**
- Deliver a full script for **either** SDUI **or** Networking+pinning — pick one live, skim the other after
- Ground claims in resume-true proof only — **no fabricated metrics**
- Self-score with the **two-layer** rubric: **≥70** with **ops ≥6/10**

## 2. Concept refresh (simple)

### 2.1 Mock spine

```text
Clarify 5 min → HLD 10 min → API 10 min → Deep dive 15 min → Ops 5 min
```

Open with: “I’ll spend ~5 minutes on scope and scale, then architecture, then deep-dive X and Y — does that match what you want?”

**Ops is mandatory** — cut deep dive before skipping ops.

### 2.2 Prompt pick

| Prompt | Verified hooks |
|---|---|
| **A · SDUI** | BookMyShow backend-driven header & search header/search; Audio streaming + server-driven splash (Aces) splash; optional BookMyShow LE Bottom Sheet **30%+** nav as UX beat |
| **B · Networking+pin** | BookMyShow SSL pinning + URLSession migration URLSession/HTTPS/pin/whitelist; BookMyShow Firebase Performance traces p50/p90; BookMyShow synchronised dictionaries path races; **Design: pin rotation / break-glass (not shipped runbook) rotation as design** |
| **Ops (both)** | BookMyShow IMOC + crash-free at scale **99.95%+ CFS** / IMOC pause; **30L+ DAU** scale context |

### 2.3 Provenance guardrails

Do **not**: invent QPS; claim BookMyShow synchronised dictionaries alone caused CFS; claim Design: pin rotation / break-glass (not shipped runbook) runbook shipped; claim SecKey bytes are SPKI.

### 2.4 Critical truths (pin)

| Claim | Truth |
|---|---|
| Spine | Clarify 5 → HLD 10 → API 10 → Dive 15 → Ops 5 |
| Pick one prompt | SDUI **or** Networking+pin live — skim the other after |
| Scale | **30L+ DAU** from resume — don’t invent precise QPS |
| Ops | Last 5 minutes mandatory — cut dive rather than skip ops |
| Pass bar | **≥70** with **ops ≥6/10** and **no fabricated metrics** |
| Provenance | Design: pin rotation / break-glass (not shipped runbook) = design; BookMyShow synchronised dictionaries ≠ sole CFS; SPKI ≠ SecKey raw bytes |

## 3. Read these

| Priority | Resource | Why |
|---|---|---|
| Must | [Sample Q&A](../../../weeks/week-03/day-21/sample/) | Mock prep cards |
| Must | [02-deep-dive.md](../../../weeks/week-03/day-21/02-deep-dive.md) | Full spoken scripts |
| Must | [04-questions](../../../weeks/week-03/day-21/04-questions.md) | Rubric + warm-up Qs |
| Live | [05-exercises](../../../weeks/week-03/day-21/05-exercises.md) | Full 45-min mock |

## 4. Map to your work

**Prompt A · SDUI:** BookMyShow backend-driven header & search backend-driven header/search; Audio streaming + server-driven splash (Aces) server-driven splash; BookMyShow LE Bottom Sheet **30%+** fewer full-screen navigations as UX performance beat.  
**Prompt B · Networking+pin:** BookMyShow SSL pinning + URLSession migration Ads URLSession migration; BookMyShow Firebase Performance traces journey p50/p90; BookMyShow synchronised dictionaries path-scoped races if token cache; Design: pin rotation / break-glass (not shipped runbook) rotation as design.  
**Ops both:** BookMyShow IMOC + crash-free at scale **30L+ DAU**, **99.95%+ CFS**, IMOC pause on rollout cliffs.

**Interview line (≤20s):** “I’ll clarify scope and 30L+ DAU scale first, then architecture and two deep dives — and I always close with observability, rollout gates, and incident response.”

→ [BookMyShow backend-driven header & search SDUI](../../stories/story-bank.md#s3--backend-driven-header--search-bookmyshow) · [BookMyShow SSL pinning + URLSession migration Pinning](../../stories/story-bank.md#s4--ssl-pinning--alamofire--urlsession-bookmyshow)

## 5. Flash prompts

1. 45-min spine — timeboxes aloud
2. Clarify phase — five questions you always ask
3. SDUI: schema → registry → fallback → cache
4. Networking: client layers, cancel, pin, whitelist
5. Ops block — CFS, rollout pause, IMOC (BookMyShow IMOC + crash-free at scale)
6. Scale honesty — 30L+ DAU, no invented QPS
7. Design: pin rotation / break-glass (not shipped runbook) vs BookMyShow SSL pinning + URLSession migration verified — design vs shipped
8. BookMyShow synchronised dictionaries ≠ sole CFS — say the honest coupling
9. SPKI ≠ SecKey raw bytes — one sentence
10. Pass bar — ≥70, ops ≥6/10, no fake metrics

## 6. Timed drills

| Drill | Budget |
|---|---|
| Clarify phase (either prompt) | 5 min |
| HLD whiteboard | 10 min |
| API / component contracts | 10 min |
| One deep dive (cache **or** pin) | 15 min |
| Ops close (BookMyShow IMOC + crash-free at scale rollout gates) | 5 min |
| Self-grade with rubric | 10 min |

Run the full mock from [05-exercises](../../../weeks/week-03/day-21/05-exercises.md). Score with [04-questions](../../../weeks/week-03/day-21/04-questions.md) Part II.
