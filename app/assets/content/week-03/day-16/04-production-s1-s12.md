# Sample 04 — Production S1 and S12 (Q&A)

> Guided teaching. Separates **Verified** resume facts from forbidden overclaims.

---

### Q1. What can you claim under Verified · S1?

**Points to:** [Production bridge · §1 Provenance map](../03-production-bridge.md#1-provenance-map) · [§2 S1 STAR](../03-production-bridge.md#2-s1-star--herowidget-2-3-min)

**Answer:**

> Highest-revenue **Ads refactor** with **POP + Generics** for a safer reusable rendering pipeline. **HeroWidget** with explicit **pause/play** tied to visibility, VC lifecycle, and cell reuse. Prevented creative-type forks. Stakeholder coordination on revenue behavior. You may **not** invent fill-rate percentages or claim you authored NSCache/Kingfisher.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Provenance tag? | Verified · S1 · BookMyShow · Ads / HeroWidget |
| Result without fake metrics? | Maintainable typed pipeline; lifecycle-correct video reduced wasted playback and glitches. |
| Lesson one-liner? | Lifecycle is part of the product contract on revenue UI. |

---

### Q2. Walk the S1 STAR spine

**Points to:** [Production bridge · §2 S1 STAR](../03-production-bridge.md#2-s1-star--herowidget-2-3-min)

**Answer:**

> **Opener:** Highest-revenue Ads — protocols, generics, video lifecycle. **S/T:** Safer reusable rendering; HeroWidget video needed correct pause/play. **Action:** POP contracts + generics pipeline; explicit pause on visibility/VC/reuse; no creative forks; stakeholder alignment. **Result:** Typed pipeline; lifecycle-correct playback (**no fill-rate %**). **Lesson:** Lifecycle = product contract.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Tie to Day 02 POP? | Same capability-composition mindset — ads as module boundary (S1 soft modularization). |
| Technical depth follow-up? | Off-screen pause, background pause, `prepareForReuse`, weak captures on player callbacks. |
| Behavioral angle? | Revenue stakeholders — lifecycle rules affect billing/viewability. |

---

### Q3. What can you claim under Verified · S12?

**Points to:** [Production bridge · §1 Provenance map](../03-production-bridge.md#1-provenance-map) · [§3 S12 STAR](../03-production-bridge.md#3-s12-star--audio--splash-2-3-min)

**Answer:**

> **Live audio streaming** for broadcasts — session, buffering, interruption mindset. **Server-driven splash** for cold-start freshness/flexibility. Success oriented around **time-to-interactive**, not vanity first-frame alone. You may **not** invent splash latency milliseconds or say image LRU solved audio.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Provenance tag? | Verified · S12 · Raw / Las Vegas Aces |
| Audio vs image in one sentence? | Different failure modes — AVAudioSession interruptions, not bitmap TTL. |
| Splash vs block launch? | Freshness without blocking forever — cache last-good (Applied design). |

---

### Q4. Walk the S12 STAR spine

**Points to:** [Production bridge · §3 S12 STAR](../03-production-bridge.md#3-s12-star--audio--splash-2-3-min)

**Answer:**

> **Opener:** Live audio + server-driven splash on Aces. **S/T:** Live broadcast audio; splash that wasn’t slow/inflexible. **Action:** Integrated streaming with session/interruption awareness; SDUI splash for freshness; TTI-oriented success metrics. **Result:** Richer live audio; faster/more flexible cold-start content (**no invented ms**). **Lesson:** Startup path is product surface; audio ≠ image cache.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| S3 soft hook? | Fail-soft SDUI — bad payload shouldn’t white-screen. |
| Day 17 bridge? | Cold start + TTI measurement categories — not fake 847ms. |
| Phone call scenario? | Interruption handler + resume policy — speak from deep dive §7. |

---

### Q5. What is the combined ≤20s interview line?

**Points to:** [Production bridge · §4 Combined line](../03-production-bridge.md#4-combined-20s-line)

**Answer:**

> “On our highest-revenue Ads surface I built HeroWidget with explicit pause/play tied to visibility — and on Aces I shipped live audio plus a server-driven splash to tighten cold start.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| If only time for one story? | Match question — media lifecycle → S1; startup/audio → S12. |
| Add modularization? | S10 soft: inject `ImageLoading` into Stories — don’t force into S1 STAR. |
| Forbidden extension? | “Splash loaded in 200ms” without evidence. |

---

### Q6. How do interview bridges map questions to stories?

**Points to:** [Production bridge · §5 Interview bridges](../03-production-bridge.md#5-interview-bridges)

**Answer:**

> Design image loader → L1/L2/L3 + downsample math (Learning-lab). Video off-screen → S1 HeroWidget. Phone call kills audio → S12 AVAudioSession interruptions. SDK image dependency → S10 inject loader. Memory Graph UIImage spike → decoded L1 / no downsample (Applied triage — label honestly).

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| “Design feed images” question? | Coordinator HLD + ImageIO — then offer S1 if ads video in same feed. |
| CFS / crash on ads? | Separate day (Day 18) — don’t invent ad crash war story. |
| Learning-lab role? | [`../code/ImageCacheTiers.swift`](../code/ImageCacheTiers.swift) — practice, not BMS metric. |

---

### Q7. What must you never say about S1 and S12?

**Points to:** [Production bridge · Forbidden](../03-production-bridge.md#1-provenance-map)

**Answer:**

> No invented fill-rate % or splash ms. No “I wrote Kingfisher” or “I invented NSCache.” No treating Aces audio as image LRU. No collapsing S1 architecture story into a fake memory Graph ticket. Label Applied triage (memory tools) separately from Verified production stories.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Safe memory mention with S1? | “Player retain cycles — weak captures and teardown” as engineering detail, not Verified metric. |
| After this sample? | Code sketches, then [`../04-questions.md`](../04-questions.md). |
| Suggested speaking order? | S1 STAR → S12 STAR → combined line → bridge table from memory. |

---

## After this sample

1. Read [`../code/HeroWidgetLifecycle.swift`](../code/HeroWidgetLifecycle.swift) pause triggers.
2. Speak both STARs timed from [`../04-questions.md`](../04-questions.md).
3. Whiteboard L1/L2/L3 + HeroWidget lifecycle in [`../05-exercises.md`](../05-exercises.md).
