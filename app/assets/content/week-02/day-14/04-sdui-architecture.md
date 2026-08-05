# Sample 04 — Track B: SDUI architecture (Q&A)

> Guided teaching. Each answer stands alone; **Points to** shows where the full module expands the idea.

---

### Q1. What is Track B’s 5-minute agenda opener?

**Points to:** [Deep dive · §3 Track B — Agenda](../02-deep-dive.md#agenda-20s-1) · [Production bridge · §6 SDUI mock line](../03-production-bridge.md#6-interview-lines-20s)

**Answer:**

> “I’ll define SDUI scope, schema and versioning, registry and allowlisted actions, fail-soft fallback and cache, then BMS header and Aces splash — and limits versus native Ads.” First **20 seconds**. Scope CMS-driven UI shell — not entire app rewrite.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| ≤20s variant? | “Fail-soft SDUI pipeline — schema versioning, registry, BMS/Aces production usage.” |
| Fail-soft meaning? | Unknown skip; never crash; hard fallback if root empty. |
| Time box? | Same 5:00 hard stop as Track A. |

---

### Q2. What problem does SDUI solve?

**Points to:** [Deep dive · §3 Beat 1 — Problem](../02-deep-dive.md#beats-1) · [Production bridge · §4 S3 STAR](../03-production-bridge.md#4-s3-talk-track-23-min-star)

**Answer:**

> **Content and layout velocity** without app releases for many changes. Personalisation and experimentation on shell UI. Requirement: **crash-free rendering** — bad CMS payload must not take down the app. BMS header/search (S3) and Aces splash (S12) as production examples — no invented splash milliseconds.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| S3 provenance? | Verified · backend-driven header + search MVVM. |
| S12 provenance? | Verified · server-driven splash + audio — no fake TTFF ms. |
| New component types? | Still need app release for new widget code — admit limit. |

---

### Q3. What is the SDUI pipeline architecture?

**Points to:** [Deep dive · §3 Beat 2 — Pipeline](../02-deep-dive.md#beats-1) · [Day 10 foundations](../../day-10/01-foundations.md)

**Answer:**

> Fetch → **version gate** → parse → **component registry** (type → renderer) → layout → **allowlisted actions only**. Registry maps server type strings to native views. Actions are enumerated — no arbitrary deep links or URL schemes from JSON without allowlist. Injectable dependencies at registry boundary.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Version gate? | Major schema mismatch → hard fallback path. |
| Registry vs switch soup? | Registry scales; closed enum OK for small surfaces. |
| Identity? | Server-stable node ids for lists — Day 12. |

---

### Q4. How does fail-soft resilience work?

**Points to:** [Deep dive · §3 Beat 3 — Resilience](../02-deep-dive.md#beats-1) · [Deep dive · §5 Unknown SDUI](../02-deep-dive.md#5-week-2-connective-micro-answers-embedded)

**Answer:**

> Unknown type → **skip + metric**; never throw into crash. **Last-known-good cache** when network fails. Empty root after parse → **hard fallback** header/splash shell. S3-A1: emphasize schema versioning + unknown fallback as **design** when pressed. Measure stability and time-to-interactive — not vanity first-frame alone.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Skip vs placeholder? | Product choice — skip is common fail-soft default. |
| Analytics? | Unknown type counts — ops visibility. |
| Security? | Allowlist actions — prevent CMS injection paths. |

---

### Q5. What are the BMS and Aces production beats?

**Points to:** [Deep dive · §3 Beat 4 — Production](../02-deep-dive.md#beats-1) · [Production bridge · §4–5 S3/S12](../03-production-bridge.md#4-s3-talk-track-23-min-star)

**Answer:**

> **S3:** backend-driven header; search with debounce, loading/empty/error, MVVM; content iteration without release for many header cases. **S12:** Aces live audio streaming + **server-driven splash** for cold-start content freshness — measure **time-to-interactive**, not invented splash ms. Both require fail-soft mindset.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Search cancel? | Debounce VM; cancel Task; ignore stale — Day 08. |
| Splash slow fetch? | Cached last-good splash — failure mode table. |
| District? | S9 separate — MVVM migration spice, not SDUI core. |

---

### Q6. What trade-offs close Track B vs native Ads?

**Points to:** [Deep dive · §3 Beat 5 — Trade-offs](../02-deep-dive.md#beats-1) · [§4 Why not both architectures](../02-deep-dive.md#4-why-not-both-architectures-as-one-religion)

**Answer:**

> SDUI wins velocity on shell/header/splash. **Revenue video Ads often stay native (S1)** — lifecycle, viewability, typed players. New widget types still need release. Bridge: SDUI **configures** placement; native **HeroWidget renders** video. Invite questions at 5:00.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| SDUI the video player? | Rarely — weak lifecycle/typing for revenue media. |
| Ads 5-min if stronger S1? | Pick Track A — don’t do both cold. |
| Full script? | [code/MockTalkTracks.md](../code/MockTalkTracks.md) § Track B. |

---

### Q7. What SDUI failure modes should I mention if time allows?

**Points to:** [Deep dive · §3 Failure modes table](../02-deep-dive.md#failure-modes)

**Answer:**

> Major schema mismatch → version gate + hard fallback. Unknown node → skip, don’t throw. Action injection → allowlist only. Slow splash fetch → cached last-good splash. Mention 2–3 in trade-offs window — preserve agenda in first 20s.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Outage week story? | IMOC + fallback + cache — S8 composure; no fake incident details. |
| S3 STAR after talk? | Block 4 — 2–3 min; spice S12 opener 20–45s. |
| Also read Ads sample? | Skim [03-ads-architecture.md](03-ads-architecture.md) 20 min after recording. |

---

Back to: [README.md](README.md) · Ads track: [03-ads-architecture.md](03-ads-architecture.md)
