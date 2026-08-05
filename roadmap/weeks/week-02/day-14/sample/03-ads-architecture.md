# Sample 03 — Track A: Ads architecture (Q&A)

> Guided teaching. Each answer stands alone; **Points to** shows where the full module expands the idea.

---

### Q1. What is Track A’s 5-minute agenda opener?

**Points to:** [Deep dive · §2 Track A — Agenda](../02-deep-dive.md#agenda-20s) · [Production bridge · §6 Ads mock line](../03-production-bridge.md#6-interview-lines-20s)

**Answer:**

> “I’ll cover problem scope, type-safe component pipeline with POP and generics, HeroWidget lifecycle, networking and pinning on URLSession, and trade-offs versus SDUI for media.” Deliver in first **20 seconds**. Scope revenue Ads — not entire app architecture.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| ≤20s variant? | “Revenue Ads architecture — POP/generics, HeroWidget lifecycle, URLSession pinning.” |
| Wrong opener? | Jumping to pinning without scope — interviewer lost. |
| Time if over 20s? | Cut examples; keep nouns: POP, HeroWidget, URLSession, trade-offs. |

---

### Q2. What is the Ads problem context beat?

**Points to:** [Deep dive · §2 Beat 1 — Context](../02-deep-dive.md#beats-1-min-each) · [Production bridge · §3 S1 STAR](../03-production-bridge.md#3-s1-talk-track-23-min-star)

**Answer:**

> Highest-revenue Ads module needed safer reusable rendering. Video inside **HeroWidget** needed correct pause/play with lifecycle — visibility, VC disappear, background. Revenue-critical surface: stakeholder coordination and correctness matter. No invented fill-rate percentages.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| S1 provenance? | Verified · BookMyShow · Ads / HeroWidget. |
| Why revenue framing? | Explains strict lifecycle + security choices. |
| CMS role? | May configure placement — renderer stays native. |

---

### Q3. How do POP and generics shape the Ads pipeline?

**Points to:** [Deep dive · §2 Beat 2 — Component model](../02-deep-dive.md#beats-1-min-each) · [Day 02 POP](../../day-02/01-foundations.md) · [Day 01 Week 1 sample POP](../../../week-01/day-02/sample/01-pop-and-generics.md)

**Answer:**

> **Protocol-oriented** ad component contracts + **generics pipeline** — not inheritance trees. New creatives plug in without forking the revenue path. Compile-time safety vs `Any` casts. Generics inside; type erasure only at mixed-list or module boundary if needed — erasure isn’t free (Day 02).

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why not inheritance? | Fragile base on ad variants; POP composes capabilities. |
| Associated types pain? | Stay generic, erase at boundary, or closed enum — Day 02. |
| S10 cousin? | Reusable protocol surfaces — Stories SDK boundary instinct. |

---

### Q4. What is the HeroWidget lifecycle contract?

**Points to:** [Deep dive · §2 Beat 3 — HeroWidget](../02-deep-dive.md#beats-1-min-each) · [Day 11 · Ads visibility](../../day-11/02-deep-dive.md#2-ads--video-visibility-s1)

**Answer:**

> Visibility / VC lifecycle / background → **pause/play** policy. `prepareForReuse` stops player in feed cells. Lifecycle is **part of the product contract**, not plumbing. Full-screen: VC disappear hooks. In-feed: visibility threshold. Background: app lifecycle notification.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Off-screen playback failure? | Visibility + disappear pause. |
| Wrong creative in cell? | Cancel + generation token — Day 11. |
| SDUI the player? | Weak — see Q6 bridge. |

---

### Q5. What is the URLSession / pinning beat? (S4)

**Points to:** [Deep dive · §2 Beat 4 — Networking security](../02-deep-dive.md#beats-1-min-each) · [Production bridge · §5 S4 opener](../03-production-bridge.md#5-supporting-openers-2045s)

**Answer:**

> Alamofire → **URLSession** on high-traffic revenue module. **HTTPS**, **SSL pinning**, **domain whitelist** — you owned the stack. Pin rotation, backup pins, break-glass as **Applied design (S4-A1)** — not “I shipped the ops runbook.” Watch TLS failure rate; don’t claim pinning alone owns crash-free (S8 culture reference only).

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Pin mismatch outage? | Backup pins + staged rotation design; IMOC leadership if tricky mock. |
| Whitelist why? | Reduce attack surface on revenue endpoints. |
| Single-flight? | Refresh waiters — Day 09; pairs with auth on same module. |

---

### Q6. What trade-offs close Track A vs SDUI?

**Points to:** [Deep dive · §2 Beat 5 — Trade-offs](../02-deep-dive.md#beats-1-min-each) · [§4 Why not both architectures](../02-deep-dive.md#4-why-not-both-architectures-as-one-religion)

**Answer:**

> Keep **revenue media native** — lifecycle, billing viewability, typed players. CMS may configure **placement**; SDUI for config ≠ SDUI for the player. Bridge: “I’d SDUI placement and campaign config; I’d keep the video renderer native with HeroWidget’s pause/play contract.” Invite questions at 5:00.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why not SDUI video? | Weak lifecycle/typing for revenue media. |
| SDUI header? | S3 — different surface, complementary story. |
| Full script? | [code/MockTalkTracks.md](../code/MockTalkTracks.md) § Track A. |

---

### Q7. What Ads failure modes should I mention if time allows?

**Points to:** [Deep dive · §2 Failure modes table](../02-deep-dive.md#failure-modes-to-mention-if-time)

**Answer:**

> Off-screen playback → visibility + disappear pause. Pin mismatch outage → backup pins + rotation **design**. Cell reuse wrong creative → cancel + clear + generation token. Refresh stampede → single-flight waiters. Mention 2–3 max in 3:30–4:30 window — don’t blow the agenda.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Invent metrics? | **Forbidden** — fill-rate %, CTR, fake crash deltas. |
| S1 STAR after talk? | Block 4 — 2–3 min full STAR. |
| Also read SDUI sample? | Skim [04-sdui-architecture.md](04-sdui-architecture.md) 20 min after recording. |

---

Back to: [README.md](README.md) · SDUI track: [04-sdui-architecture.md](04-sdui-architecture.md)
