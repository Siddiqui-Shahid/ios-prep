# 03 — Production Bridge: S8 IMOC/CFS + S2 Honesty

## 1. Provenance map

| ID | Label | Exact claim |
|---|---|---|
| **S8** | Verified | **30+ lakh DAU**; **99.95%+ CFS**; Crashlytics triage; **IMOC** for P0/P1 |
| **S2** | Verified | Synchronised dictionaries (GCD serial / RW) — eliminated concurrent-access crashes **on that path** |
| **S2-A1** | Applied | Greenfield shared maps as Swift `actor` |
| Learning-lab | Illustrative | Breadcrumb ring / crash notes sketches |

### Forbidden overclaims

- “S2 alone caused / delivered 99.95% CFS”
- “I wrote our in-house signal handler crash SDK” (unless you add evidence — default is Crashlytics workflows)
- Invented downtime minutes or crash counts
- “CFS proves no hangs”

## 2. Verified S8 — STAR (2–3 min)

### Opener (~10s)

> “I’ll cover sustaining 99.95%+ crash-free sessions at 30L+ DAU — Crashlytics triage plus IMOC coordination on P0/P1s.”

### Situation / Task (~20s)

Consumer ticketing app at very large DAU. Reliability is a product feature during peak traffic. Need structured crash response and multi-team incident command.

### Action (~90s)

1. Crashlytics triage with structured workflows — detect, classify, reproduce, mitigate, fix, write-up.
2. As **IMOC**, coordinated **iOS, backend, and QA** on P0/P1 during high-traffic events.
3. Drove mitigations first: feature guards, rollout pause, hotfix path, cadenced comms.
4. Treated CFS as a sustained operational bar, not a slide metric.

### Result (~20–30s)

Sustained high crash-free sessions; reduced downtime impact in peak events through clear ownership and blast-radius thinking.

### Lesson (~15–20s)

Incident leadership is owner + blast radius + rollback — not lone-hero stack debugging.

> **Provenance:** Verified · S8 · BookMyShow · 30L+ DAU · 99.95%+ CFS · IMOC

## 3. Interview line (≤20s)

> “At 30L+ DAU we held 99.95%+ crash-free sessions — Crashlytics triage plus IMOC coordination on P0/P1s, not just fixing stacks alone.”

## 4. S2 as technical add-on (≤90s) — correct coupling

### OK script

> “Separately, on shared async dictionaries we had intermittent race crashes. We gated access with GCD serial queues and read-write locks behind a safe API. That removed concurrent-access crashes on that path and fed reliability. I’m not claiming that one fix is the whole 99.95% CFS story — CFS was sustained by triage, incident process, and many engineering inputs including concurrency hygiene.”

### Forbidden script

> “We hit 99.95% CFS because I synchronised the dictionaries.”

> **Provenance:** Verified · S2 · path-scoped races · must not sole-own S8 metrics

## 5. S2-A1 bridge

> “For greenfield shared maps I’d evaluate a Swift actor with the same boundary mindset — serialize mutation at the API edge.”

> **Provenance:** How I would apply it · S2-A1

## 6. Behavioral variants (same facts)

| Prompt type | Emphasize |
|---|---|
| Conflict | IMOC forces shared timeline vs blame |
| Pressure / peak sale | Mitigate first, cadence comms |
| Leadership | Owner clarity, handoff, postmortem actions |
| Technical depth | Add S2 path + signal-safety vocabulary |

## 7. Whiteboard crash SDK (10 min)

Handlers → mmap writer → breadcrumb ring → next-launch uploader → dSYM symbolication. Call out signal safety and “no upload in handler.”
