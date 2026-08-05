# Day 09 — URLSession Networking Layer

> Week 2 · Full study (self-contained) · ~4–5 hrs  
> Revision twin: [revision/weeks/week-02/day-09.md](../../../revision/weeks/week-02/day-09.md)

## Outcomes

By end of day, without notes, you can:

- Sketch a **protocol-oriented networking layer** on `URLSession` (endpoint → build → intercept → execute → decode → map errors)
- Explain **single-flight token refresh** under concurrent 401s (actor / critical section, one retry, failure fan-out)
- Distinguish **HTTP/`URLCache` vs app cache**, and when “no cache” is required
- Cancel correctly: **async `URLSession` participates in `Task` cancellation**; callback `dataTask` needs **explicit cancel + stale guards**
- Explain **SSL pinning basics**, including that **SPKI = SHA-256 of Subject Public Key Info DER** (not raw `SecKeyCopyExternalRepresentation` bytes), and that **ATS ≠ pinning**
- Deliver the **S4** story honestly: Ads **Alamofire → URLSession** with **HTTPS, SSL pinning, domain whitelist** — and treat pin rotation / backup pins / break-glass as **S4-A1 design**, not a shipped runbook

## How to study (in Cursor only)

1. `01-foundations.md` — mental model + glossary (intern → senior ramp)
2. `02-deep-dive.md` — layer shape, interceptors, refresh, cache, cancel, pinning internals
3. `03-production-bridge.md` — Verified S4 + Applied S4-A1 + interview scripts
4. `code/SingleFlightRefresh.swift` — actor-safe single-flight (no racy inner `Task` mutating actor state)
5. `04-questions.md` — cover full answers; speak from **Answer points**; compare
6. `05-exercises.md` — whiteboard + coding + speaking drills
7. Revision twin for timed recall after the full read

## Module map

| Module | File |
|---|---|
| Foundations | [01-foundations.md](01-foundations.md) |
| Deep dive | [02-deep-dive.md](02-deep-dive.md) |
| Production bridge | [03-production-bridge.md](03-production-bridge.md) |
| Sample Q&A | [sample/README.md](sample/README.md) |
| Questions | [04-questions.md](04-questions.md) |
| Exercises | [05-exercises.md](05-exercises.md) |
| Code | [code/SingleFlightRefresh.swift](code/SingleFlightRefresh.swift) |

## Provenance reminder

| Label | Meaning for today |
|---|---|
| **Verified · S4** | Ads networking migrated Alamofire → URLSession; enforced HTTPS, SSL pinning, domain whitelist |
| **How I would apply it · S4-A1** | Pin rotation, backup pins, staged break-glass — **design judgment**, not “I shipped the ops runbook” |
| **Verified · S3** | Search debounce / cancel (cancellation UX hook) |
| **Verified · S5** | Firebase Performance p50/p90 (observability on the same stack) |
| **Learning-lab** | Illustrative client / refresh / pinning snippets in this chapter |

Do **not** claim shadow-traffic rollout, remote pin kill-switches, or a production pin-rotation runbook as shipped work.

## Agenda opener (say this first in a networking HLD)

> “I’ll scope a first-party `URLSession` client — endpoints, interceptors, decode/errors — then single-flight refresh, cancellation, cache boundaries, and the Ads security controls: HTTPS, pinning, and host whitelist.”

## Time budget

| Block | Minutes |
|---|---|
| Foundations | 45–60 |
| Deep dive + code | 90–120 |
| Production bridge + S4 STAR | 30–40 |
| Questions (record 5) | 45–60 |
| Exercises | 30–40 |
| Revision twin skim | 15 |

## Source / version note

Teaching targets **modern Swift concurrency** (`async`/`await`) with `URLSession`. Pinning APIs live on `URLSessionDelegate` authentication challenges. ATS is an Info.plist / system policy layer; pinning is an **app-level** identity check on top of TLS. Optional citations only at the end of `02-deep-dive.md` — this chapter is self-contained.
