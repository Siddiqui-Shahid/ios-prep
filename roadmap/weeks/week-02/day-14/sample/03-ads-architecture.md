# Sample 03 — Track A: Ads architecture (Q&A)

> Guided teaching. Each answer stands alone and ends with **How can I relate to my case** using named work — never S-codes.

---

### Q1. What is Track A’s 5-minute agenda opener?
**Answer:**

> “I’ll cover problem scope, type-safe component pipeline with POP and generics, HeroWidget lifecycle, networking and pinning on URLSession, and trade-offs versus SDUI for media.” Deliver in first **20 seconds**. Scope revenue Ads — not entire app architecture.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| ≤20s variant? | “Revenue Ads architecture — POP/generics, HeroWidget lifecycle, URLSession pinning.” |
| Wrong opener? | Jumping to pinning without scope — interviewer lost. |
| Time if over 20s? | Cut examples; keep nouns: POP, HeroWidget, URLSession, trade-offs. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q2. What is the Ads problem context beat?
**Answer:**

> Highest-revenue Ads module needed safer reusable rendering. Video inside **HeroWidget** needed correct pause/play with lifecycle — visibility, VC disappear, background. Revenue-critical surface: stakeholder coordination and correctness matter. No invented fill-rate percentages.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| BookMyShow Ads pipeline + HeroWidget lifecycle provenance? | BookMyShow · Ads / HeroWidget. |
| Why revenue framing? | Explains strict lifecycle + security choices. |
| CMS role? | May configure placement — renderer stays native. |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

---

### Q3. How do POP and generics shape the Ads pipeline?
**Answer:**

> **Protocol-oriented** ad component contracts + **generics pipeline** — not inheritance trees. New creatives plug in without forking the revenue path. Compile-time safety vs `Any` casts. Generics inside; type erasure only at mixed-list or module boundary if needed — erasure isn’t free (Day 02).

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why not inheritance? | Fragile base on ad variants; POP composes capabilities. |
| Associated types pain? | Stay generic, erase at boundary, or closed enum — Day 02. |
| Stories SDK (Raw / Miami Heat) cousin? | Reusable protocol surfaces — Stories SDK boundary instinct. |

**How can I relate to my case:**
- **Shipped:** Stories SDK (Raw / Miami Heat)
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q4. What is the HeroWidget lifecycle contract?
**Answer:**

> Visibility / VC lifecycle / background → **pause/play** policy. `prepareForReuse` stops player in feed cells. Lifecycle is **part of the product contract**, not plumbing. Full-screen: VC disappear hooks. In-feed: visibility threshold. Background: app lifecycle notification.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Off-screen playback failure? | Visibility + disappear pause. |
| Wrong creative in cell? | Cancel + generation token — Day 11. |
| SDUI the player? | Weak — see Q6 bridge. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q5. What is the URLSession / pinning beat? (BookMyShow SSL pinning + URLSession migration)?
**Answer:**

> Alamofire → **URLSession** on high-traffic revenue module. **HTTPS**, **SSL pinning**, **domain whitelist** — you owned the stack. Pin rotation, backup pins, break-glass as **Applied design (Design: pin rotation / break-glass (not shipped runbook))** — not “I shipped the ops runbook.” Watch TLS failure rate; don’t claim pinning alone owns crash-free (BookMyShow IMOC + crash-free at scale culture reference only).

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Pin mismatch outage? | Backup pins + staged rotation design; IMOC leadership if tricky mock. |
| Whitelist why? | Reduce attack surface on revenue endpoints. |
| Single-flight? | Refresh waiters — Day 09; pairs with auth on same module. |

**How can I relate to my case:**
- **Shipped:** BookMyShow SSL pinning + URLSession migration; BookMyShow IMOC + crash-free at scale
- **Design if asked:** Design: pin rotation / break-glass (not shipped runbook)
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Claiming pin-rotation / break-glass runbook as a shipped production playbook.

---

### Q6. What trade-offs close Track A vs SDUI?
**Answer:**

> Keep **revenue media native** — lifecycle, billing viewability, typed players. CMS may configure **placement**; SDUI for config ≠ SDUI for the player. Bridge: “I’d SDUI placement and campaign config; I’d keep the video renderer native with HeroWidget’s pause/play contract.” Invite questions at 5:00.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why not SDUI video? | Weak lifecycle/typing for revenue media. |
| SDUI header? | BookMyShow backend-driven header & search — different surface, complementary story. |
| Full script? | [code/MockTalkTracks.md](../code/MockTalkTracks.md) § Track A. |

**How can I relate to my case:**
- **Shipped:** BookMyShow backend-driven header & search
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q7. What Ads failure modes should I mention if time allows?
**Answer:**

> Off-screen playback → visibility + disappear pause. Pin mismatch outage → backup pins + rotation **design**. Cell reuse wrong creative → cancel + clear + generation token. Refresh stampede → single-flight waiters. Mention 2–3 max in 3:30–4:30 window — don’t blow the agenda.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Invent metrics? | **Forbidden** — fill-rate %, CTR, fake crash deltas. |
| BookMyShow Ads pipeline + HeroWidget lifecycle STAR after talk? | Block 4 — 2–3 min full STAR. |
| Also read SDUI sample? | Skim [04-sdui-architecture.md](04-sdui-architecture.md) 20 min after recording. |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

---

### Q8. Refresh stampede + pin outage same week — how do you lead? (T3)?
**Answer:**

> “I’d lead with blast radius and owners first — feature guards, rollback, break-glass design — while engineering fixes **single-flight refresh** and **pin backups**. I’d watch TLS failure rate and crash-free. At BMS scale we held a **99.95%+ CFS** bar at **30L+ DAU** — I’m not claiming pinning alone created that number, but that reliability culture shapes how I’d run the week.” 
> **Provenance:** BookMyShow IMOC + crash-free at scale culture · BookMyShow SSL pinning + URLSession migration controls · Design: pin rotation / break-glass (not shipped runbook)

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Comms? | Status cadence — don’t silent-fix. |
| Stories to cite? | BookMyShow IMOC + crash-free at scale + BookMyShow SSL pinning + URLSession migration + Design: pin rotation / break-glass (not shipped runbook) design. |
| Only technical rabbit hole? | Trap — lead ops first, then fixes. |

**How can I relate to my case:**
- **Shipped:** BookMyShow SSL pinning + URLSession migration; BookMyShow IMOC + crash-free at scale
- **Design if asked:** Design: pin rotation / break-glass (not shipped runbook)
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Claiming pin-rotation / break-glass runbook as a shipped production playbook.

Back to: [README.md](README.md) · SDUI track: [04-sdui-architecture.md](04-sdui-architecture.md)

---

## Brain puzzles (cover → think → check)

### Puzzle A — What is the Ads problem context beat

**Ask yourself:** What is the Ads problem context beat?

**Answer:** “Highest-revenue Ads module needed safer reusable rendering. Video inside **HeroWidget** needed correct pause/play with lifecycle — visibility, VC disappear, background. Revenue-critical surface: stakeholder coordination and correctness matter. No invented fill-rate percentages.”

### Puzzle B — How do POP and generics shape the Ads pipeline

**Ask yourself:** How do POP and generics shape the Ads pipeline?

**Answer:** “**Protocol-oriented** ad component contracts + **generics pipeline** — not inheritance trees. New creatives plug in without forking the revenue path. Compile-time safety vs `Any` casts. Generics inside; type erasure only at mixed-list or module boundary if needed — erasure isn’t free (Day 02).”

### Puzzle C — What is the HeroWidget lifecycle contract

**Ask yourself:** What is the HeroWidget lifecycle contract?

**Answer:** “Visibility / VC lifecycle / background → **pause/play** policy. `prepareForReuse` stops player in feed cells. Lifecycle is **part of the product contract**, not plumbing. Full-screen: VC disappear hooks. In-feed: visibility threshold. Background: app lifecycle notification.”
