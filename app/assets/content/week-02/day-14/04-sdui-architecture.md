# Sample 04 — Track B: SDUI architecture (Q&A)

> Guided teaching. Each answer stands alone and ends with **How can I relate to my case** using named work — never S-codes.

---

### Q1. What is Track B’s 5-minute agenda opener?
**Answer:**

> “I’ll define SDUI scope, schema and versioning, registry and allowlisted actions, fail-soft fallback and cache, then BMS header and Aces splash — and limits versus native Ads.” First **20 seconds**. Scope CMS-driven UI shell — not entire app rewrite.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| ≤20s variant? | “Fail-soft SDUI pipeline — schema versioning, registry, BMS/Aces production usage.” |
| Fail-soft meaning? | Unknown skip; never crash; hard fallback if root empty. |
| Time box? | Same 5:00 hard stop as Track A. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q2. What problem does SDUI solve?
**Answer:**

> **Content and layout velocity** without app releases for many changes. Personalisation and experimentation on shell UI. Requirement: **crash-free rendering** — bad CMS payload must not take down the app. BMS header/search (BookMyShow backend-driven header & search) and Aces splash (Audio streaming + server-driven splash (Aces)) as production examples — no invented splash milliseconds.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| BookMyShow backend-driven header & search provenance? | backend-driven header + search MVVM. |
| Audio streaming + server-driven splash (Aces) provenance? | server-driven splash + audio — no fake TTFF ms. |
| New component types? | Still need app release for new widget code — admit limit. |

**How can I relate to my case:**
- **Shipped:** Audio streaming + server-driven splash (Aces); BookMyShow backend-driven header & search
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q3. What is the SDUI pipeline architecture?
**Answer:**

> Fetch → **version gate** → parse → **component registry** (type → renderer) → layout → **allowlisted actions only**. Registry maps server type strings to native views. Actions are enumerated — no arbitrary deep links or URL schemes from JSON without allowlist. Injectable dependencies at registry boundary.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Version gate? | Major schema mismatch → hard fallback path. |
| Registry vs switch soup? | Registry scales; closed enum OK for small surfaces. |
| Identity? | Server-stable node ids for lists — Day 12. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q4. How does fail-soft resilience work?
**Answer:**

> Unknown type → **skip + metric**; never throw into crash. **Last-known-good cache** when network fails. Empty root after parse → **hard fallback** header/splash shell. BookMyShow backend-driven header & search-A1: emphasize schema versioning + unknown fallback as **design** when pressed. Measure stability and time-to-interactive — not vanity first-frame alone.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Skip vs placeholder? | Product choice — skip is common fail-soft default. |
| Analytics? | Unknown type counts — ops visibility. |
| Security? | Allowlist actions — prevent CMS injection paths. |

**How can I relate to my case:**
- **Shipped:** BookMyShow backend-driven header & search
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q5. What are the BMS and Aces production beats?
**Answer:**

> **BookMyShow backend-driven header & search:** backend-driven header; search with debounce, loading/empty/error, MVVM; content iteration without release for many header cases. **Audio streaming + server-driven splash (Aces):** Aces live audio streaming + **server-driven splash** for cold-start content freshness — measure **time-to-interactive**, not invented splash ms. Both require fail-soft mindset.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Search cancel? | Debounce VM; cancel Task; ignore stale — Day 08. |
| Splash slow fetch? | Cached last-good splash — failure mode table. |
| District? | District Free Parking + Clean/MVVM + AI tooling separate — MVVM migration spice, not SDUI core. |

**How can I relate to my case:**
- **Shipped:** Audio streaming + server-driven splash (Aces); BookMyShow backend-driven header & search; District Free Parking + Clean/MVVM + AI tooling
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q6. What trade-offs close Track B vs native Ads?
**Answer:**

> SDUI wins velocity on shell/header/splash. **Revenue video Ads often stay native (BookMyShow Ads pipeline + HeroWidget lifecycle)** — lifecycle, viewability, typed players. New widget types still need release. Bridge: SDUI **configures** placement; native **HeroWidget renders** video. Invite questions at 5:00.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| SDUI the video player? | Rarely — weak lifecycle/typing for revenue media. |
| Ads 5-min if stronger BookMyShow Ads pipeline + HeroWidget lifecycle? | Pick Track A — don’t do both cold. |
| Full script? | [code/MockTalkTracks.md](../code/MockTalkTracks.md) § Track B. |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

---

### Q7. What SDUI failure modes should I mention if time allows?
**Answer:**

> Major schema mismatch → version gate + hard fallback. Unknown node → skip, don’t throw. Action injection → allowlist only. Slow splash fetch → cached last-good splash. Mention 2–3 in trade-offs window — preserve agenda in first 20s.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Outage week story? | IMOC + fallback + cache — BookMyShow IMOC + crash-free at scale composure; no fake incident details. |
| BookMyShow backend-driven header & search STAR after talk? | Block 4 — 2–3 min; spice Audio streaming + server-driven splash (Aces) opener 20–45s. |
| Also read Ads sample? | Skim [03-ads-architecture.md](03-ads-architecture.md) 20 min after recording. |

**How can I relate to my case:**
- **Shipped:** Audio streaming + server-driven splash (Aces); BookMyShow backend-driven header & search; BookMyShow IMOC + crash-free at scale
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Attributing 99.95%+ CFS to a single ticket; inventing DAU figures.

Back to: [README.md](README.md) · Ads track: [03-ads-architecture.md](03-ads-architecture.md)

---

## Brain puzzles (cover → think → check)

### Puzzle A — What problem does SDUI solve

**Ask yourself:** What problem does SDUI solve?

**Answer:** “**Content and layout velocity** without app releases for many changes. Personalisation and experimentation on shell UI. Requirement: **crash-free rendering** — bad CMS payload must not take down the app. BMS header/search (BookMyShow backend-driven header & search) and Aces splash (Audio streaming + server-driven splash (Aces)) as production examples — no invented splash milliseconds.”

### Puzzle B — What is the SDUI pipeline architecture

**Ask yourself:** What is the SDUI pipeline architecture?

**Answer:** “Fetch → **version gate** → parse → **component registry** (type → renderer) → layout → **allowlisted actions only**. Registry maps server type strings to native views. Actions are enumerated — no arbitrary deep links or URL schemes from JSON without allowlist. Injectable dependencies at registry boundary.”

### Puzzle C — How does fail-soft resilience work

**Ask yourself:** How does fail-soft resilience work?

**Answer:** “Unknown type → **skip + metric**; never throw into crash. **Last-known-good cache** when network fails. Empty root after parse → **hard fallback** header/splash shell. BookMyShow backend-driven header & search-A1: emphasize schema versioning + unknown fallback as **design** when pressed. Measure stability and time-to-interactive — not vanity first-frame alone.”
