# Sample 04 — HeroWidget lifecycle & Aces splash (Q&A)

> Guided teaching. Separates **shipped** named cases from **design-if-asked** and **lab-only** so you never blur them in an interview.

---

### Q1. What can you claim under BookMyShow Ads pipeline + HeroWidget lifecycle?

**Answer:**

> Highest-revenue **Ads refactor** with **POP + Generics** for a safer reusable rendering pipeline. **HeroWidget** with explicit **pause/play** tied to visibility, VC lifecycle, and cell reuse. Prevented creative-type forks. Stakeholder coordination on revenue behavior. You may **not** invent fill-rate percentages or claim you authored NSCache/Kingfisher.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Provenance tag? | BookMyShow Ads pipeline + HeroWidget lifecycle · BookMyShow · Ads / HeroWidget |
| Result without fake metrics? | Maintainable typed pipeline; lifecycle-correct video reduced wasted playback and glitches. |
| Lesson one-liner? | Lifecycle is part of the product contract on revenue UI. |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

---

### Q2. Walk the BookMyShow Ads pipeline + HeroWidget lifecycle STAR spine

**Answer:**

> **Opener:** Highest-revenue Ads — protocols, generics, video lifecycle. **S/T:** Safer reusable rendering; HeroWidget video needed correct pause/play. **Action:** POP contracts + generics pipeline; explicit pause on visibility/VC/reuse; no creative forks; stakeholder alignment. **Result:** Typed pipeline; lifecycle-correct playback (**no fill-rate %**). **Lesson:** Lifecycle = product contract.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Tie to Day 02 POP? | Same capability-composition mindset — ads as module boundary (BookMyShow Ads pipeline + HeroWidget lifecycle soft modularization). |
| Technical depth follow-up? | Off-screen pause, background pause, `prepareForReuse`, weak captures on player callbacks. |
| Behavioral angle? | Revenue stakeholders — lifecycle rules affect billing/viewability. |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

---

### Q3. What can you claim under Audio streaming + server-driven splash (Aces)?

**Answer:**

> **Live audio streaming** for broadcasts — session, buffering, interruption mindset. **Server-driven splash** for cold-start freshness/flexibility. Success oriented around **time-to-interactive**, not vanity first-frame alone. You may **not** invent splash latency milliseconds or say image LRU solved audio.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Provenance tag? | Audio streaming + server-driven splash (Aces) · Raw / Las Vegas Aces |
| Audio vs image in one sentence? | Different failure modes — AVAudioSession interruptions, not bitmap TTL. |
| Splash vs block launch? | Freshness without blocking forever — cache last-good (Applied design). |

**How can I relate to my case:**
- **Shipped:** Audio streaming + server-driven splash (Aces)
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q4. Walk the Audio streaming + server-driven splash (Aces) STAR spine

**Answer:**

> **Opener:** Live audio + server-driven splash on Aces. **S/T:** Live broadcast audio; splash that wasn’t slow/inflexible. **Action:** Integrated streaming with session/interruption awareness; SDUI splash for freshness; TTI-oriented success metrics. **Result:** Richer live audio; faster/more flexible cold-start content (**no invented ms**). **Lesson:** Startup path is product surface; audio ≠ image cache.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| BookMyShow backend-driven header & search soft hook? | Fail-soft SDUI — bad payload shouldn’t white-screen. |
| Day 17 bridge? | Cold start + TTI measurement categories — not fake 847ms. |
| Phone call scenario? | Interruption handler + resume policy — speak from deep dive §7. |

**How can I relate to my case:**
- **Shipped:** Audio streaming + server-driven splash (Aces); BookMyShow backend-driven header & search
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q5. What is the combined ≤20s interview line?

**Answer:**

> “On our highest-revenue Ads surface I built HeroWidget with explicit pause/play tied to visibility — and on Aces I shipped live audio plus a server-driven splash to tighten cold start.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| If only time for one story? | Match question — media lifecycle → BookMyShow Ads pipeline + HeroWidget lifecycle; startup/audio → Audio streaming + server-driven splash (Aces). |
| Add modularization? | Stories SDK (Raw / Miami Heat) soft: inject `ImageLoading` into Stories — don’t force into BookMyShow Ads pipeline + HeroWidget lifecycle STAR. |
| Forbidden extension? | “Splash loaded in 200ms” without evidence. |

**How can I relate to my case:**
- **Shipped:** Stories SDK (Raw / Miami Heat); Audio streaming + server-driven splash (Aces); BookMyShow Ads pipeline + HeroWidget lifecycle
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

---

### Q6. How do interview bridges map questions to stories?

**Answer:**

> Design image loader → L1/L2/L3 + downsample math (Learning-lab). Video off-screen → BookMyShow Ads pipeline + HeroWidget lifecycle HeroWidget. Phone call kills audio → Audio streaming + server-driven splash (Aces) AVAudioSession interruptions. SDK image dependency → Stories SDK (Raw / Miami Heat) inject loader. Memory Graph UIImage spike → decoded L1 / no downsample (Applied triage — label honestly).

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| “Design feed images” question? | Coordinator HLD + ImageIO — then offer BookMyShow Ads pipeline + HeroWidget lifecycle if ads video in same feed. |
| CFS / crash on ads? | Separate day (Day 18) — don’t invent ad crash war story. |
| Learning-lab role? | [`../code/ImageCacheTiers.swift`](../code/ImageCacheTiers.swift) — practice, not BMS metric. |

**How can I relate to my case:**
- **Shipped:** Stories SDK (Raw / Miami Heat); Audio streaming + server-driven splash (Aces); BookMyShow Ads pipeline + HeroWidget lifecycle
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

---

### Q7. What must you never say about BookMyShow Ads pipeline + HeroWidget lifecycle and Audio streaming + server-driven splash (Aces)?

**Answer:**

> No invented fill-rate % or splash ms. No “I wrote Kingfisher” or “I invented NSCache.” No treating Aces audio as image LRU. No collapsing BookMyShow Ads pipeline + HeroWidget lifecycle architecture story into a fake memory Graph ticket. Label Applied triage (memory tools) separately from Verified production stories.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Safe memory mention with BookMyShow Ads pipeline + HeroWidget lifecycle? | “Player retain cycles — weak captures and teardown” as engineering detail, not Verified metric. |
| After this sample? | Code sketches, then [`../04-questions.md`](../04-questions.md). |
| Suggested speaking order? | BookMyShow Ads pipeline + HeroWidget lifecycle STAR → Audio streaming + server-driven splash (Aces) STAR → combined line → bridge table from memory. |

**How can I relate to my case:**
- **Shipped:** Audio streaming + server-driven splash (Aces); BookMyShow Ads pipeline + HeroWidget lifecycle
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

## After this sample

1. Read [`../code/HeroWidgetLifecycle.swift`](../code/HeroWidgetLifecycle.swift) pause triggers.
2. Speak both STARs timed from [`../04-questions.md`](../04-questions.md).
3. Whiteboard L1/L2/L3 + HeroWidget lifecycle in [`../05-exercises.md`](../05-exercises.md).

---

