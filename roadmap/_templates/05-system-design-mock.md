# Sample 05 — System-design mock: `<Prompt Title>` (Q&A)

> Guided **mock interview** flow. Speak answers aloud against a 45‑min timer.  
> **Source:** [`ios-system-design/docs/<spec>.md`](../../../../ios-system-design/docs/<spec>.md) · timing: [`cheatsheet.md`](../../../../ios-system-design/docs/cheatsheet.md)

---

### Clarify checklist (ask the interviewer — after agenda)

Use in **Q1**. Pick 5–7 that fit the prompt:

1. What is **in / out of scope**? (client-only vs backend services you must sketch)
2. Approximate **DAU / peak concurrency**? (label estimates if they won’t give numbers)
3. **Offline** required, or online-first with last-good cache?
4. **iOS-only**, or note Android parity briefly?
5. Latency / freshness **SLO**? (p50/p90 for critical paths)
6. **Read-heavy vs write-heavy**? Mutation rate? Idempotency needs?
7. Real-time (**WebSocket / push**) or request/response enough?
8. Media: images only, or video/audio in scope?
9. Auth / PCI / E2EE constraints?
10. Feature flags / kill switch expected in ops?

### Load checklist (keep in HLD / API / ops)

- DAU → rough **QPS** (sessions × requests/session ÷ 86400) — label as estimate
- Prefer **cursor** pagination over offset for dynamic feeds (O(1) server cost)
- **Payload size**, gzip, field masking
- **Single-flight** refresh; debounce stampede after outages
- CDN / edge cache vs origin; TTL and invalidate path
- Rate limits, backoff + jitter; degrade path under load

### Optimal 45‑min spine

| Min | Block |
|---|---|
| 0–5 | Clarify + agenda confirm |
| 5–15 | HLD: 4 client layers + backend touchpoints + load notes |
| 15–25 | Data / API |
| 25–40 | Two deep dives |
| 40–45 | Ops: failures, metrics, rollout, kill switch |

---

### Q1. Interviewer: “Design `<system>`.” How do you open?

**Answer:**

> **Agenda (≤20s):** “I’ll take ~5 minutes clarifying scope and scale, then a four-layer client HLD with backend touchpoints and load, then API/data, two deep dives on `<dive1>` and `<dive2>`, and close on failure modes, metrics, and kill switches. Does that work?”  
> **Then ask the interviewer (speak these):**
> 1. …
> 2. …
> …
> Do **not** draw until they answer or you state labeled assumptions.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Skip agenda? | Weak senior signal — interviewer may want different dives. |
| Clarify for 15 min? | Hard stop at 5 — park extras as assumptions. |
| They refuse numbers? | State labeled estimates from DAU context; continue. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q2. After clarify — what does the optimal flow look like?

**Answer:**

> **Scripted outcomes for this mock:** …  
> **Good flow:** agenda → clarify Qs → confirm → HLD with backend + load → API → two crisp dives → ops last 5.  
> **Weak flow:** silent drawing, happy-path only, no QPS/TTL, skip ops, invent metrics.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| They change scope mid-HLD? | Re-confirm in/out in 20s; adjust dives; protect ops. |
| Backend mesh deep-dive? | Out unless asked — sketch touchpoints, stay client-owned. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q3. Walk the HLD — client layers, backend, load.

**Answer:**

> …

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| … | … |

**How can I relate to my case:**
- **Shipped / Design if asked / Lab only / Don’t claim** as appropriate.

---

### Q4. Data / API — entities, endpoints, scale.

**Answer:**

> …

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| … | … |

**How can I relate to my case:**
- **Concept-only — no shipped story.** …

---

### Q5. Deep dive 1 — `<dive1>`?

**Answer:**

> …

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| … | … |

**How can I relate to my case:**
- …

---

### Q6. Deep dive 2 — `<dive2>`?

**Answer:**

> …

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| … | … |

**How can I relate to my case:**
- …

---

### Q7. Ops — failures, metrics, rollout, load?

**Answer:**

> …

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| … | … |

**How can I relate to my case:**
- …

---

### Q8. Flow scorecard — did you hit the optimal spine?

**Answer:**

> **Pass bar:** clarify + agenda in ≤5; HLD shows 4 layers + backend + load; API has cursors/idempotency as needed; two deep dives; ops with kill switch and concrete metrics.  
> **Anti-patterns:** offset pagination on dynamic feeds; main-thread SQLite/decode; inventing QPS as fact; never reaching ops; blob “architecture” with no data flow.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Ran long on dive 1? | Park dive 2 bullets; protect ops 5 min. |
| Forgot load? | One sentence: DAU → labeled QPS, cursor cost, single-flight. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Rehearse this scorecard after every timed mock.
