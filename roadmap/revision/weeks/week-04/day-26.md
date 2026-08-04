# Day 26 — Behavioral + Leadership (STAR Polish)

> Week 4 · Phase: Behavioral / leadership judgment · Time budget today: ~4–5 hrs

## 1. Outcome

By end of day you can explain aloud (no notes):

- Deliver any story from [story-bank.md](../../stories/story-bank.md) in **2–3 minutes** with clock discipline (20s S/T → 90s Action → 30s Result → 20s Lesson).
- Handle **conflict, incident, mentorship, and AI tooling judgment** without rambling or inventing metrics.
- Tell the **District Context Engineering** story as *architecture/process judgment* — **not tool-worship** (Cursor/Claude are accelerators).
- Map interviewer prompts → story IDs in ≤10s using the quick picker.
- Use only resume-backed numbers: **30L+ DAU**, **99.95% crash-free**, **30%+ nav reduction** (LE Bottom Sheet), plus qualitative SDK/migration outcomes.

## 2. Concept deep dive

### 2.1 STAR operating rhythm

| Segment | Time | Do | Don’t |
|---|---|---|---|
| Situation + Task | ~20s | Scale + your ownership | Company history lecture |
| Action | ~90s | 3–5 concrete steps, one trade-off | “We” without your role |
| Result | ~30s | Metric or crisp outcome | Fake numbers |
| Lesson | ~20s | Principle you’d reuse | Humble-brag essay |

**Opener template:**  
> “I’ll take ~2 minutes on [X] — context, what I owned, outcome.”

### 2.2 Prompt → story routing (practice until instant)

| Interviewer asks | Reach for | Backup |
|---|---|---|
| Hard technical project | S1 Ads/HeroWidget | S10 Stories SDK |
| Conflict / disagreement | S6 LE sheet contracts **or** S8 IMOC | S14 migration priorities |
| Incident / on-call / ownership | S8 IMOC + crash-free culture | S2 races |
| Mentorship / leadership sans title | S6, S10, S14 | S1 stakeholder coord |
| Failure / mistake | Pinning/ops gap, race shipped, SDUI fallback miss — real | Don’t invent hero failure |
| Why senior / impact | S6 **30%+ nav**; S8 **99.95%**; scale **30L+ DAU** | S10 portfolio reuse |
| AI / productivity tools | **S9 District** — context engineering | S15/S16 product AI (different!) |
| Privacy / on-device AI | S15 FinTrack | S16 GymFlow |
| Cross-platform / hybrid | S13 Grizzlies | S12 Aces |
| Security | S4 pinning | — |
| Performance culture | S5 Firebase p50/p90 | S17-era Instruments language |

### 2.3 Conflict script (structure, not drama)

1. Disagreement named specifically (API shape, scope, timeline, approach).
2. What you did: data, prototype, user impact, written options.
3. How you disagreed *with* people, not *at* them.
4. Resolution + relationship intact.
5. Lesson: prefer contracts and metrics over opinions.

**LE Bottom Sheet angle (S6):** Align PM/Design/Backend on API + UX; shipped lighter overview; **30%+ flows** with fewer full-screen navigations.

### 2.4 Incident script (S8)

1. Severity + user impact (crash/reliability).
2. Your role in triage (IMOC-style): stabilize → communicate → root cause → prevent.
3. Concrete technical action (not “worked hard”).
4. Result tied to **99.95%+ crash-free** culture / reduction of class of failures.
5. Lesson: observability + ownership > blame.

### 2.5 Mentorship / leadership without title

Use **end-to-end ownership** stories: S1, S6, S10, S14.

**Say:**  
> “Leadership was setting the technical direction, unblocking others, and owning the rollout checklist — not waiting for a manager title.”

Concrete mentorship beats: pairing on architecture, writing the zero-regression checklist others used (S14), SDK boundaries that helped multiple apps (S10).

### 2.6 AI tooling judgment — District Context Engineering (no tool-worship)

**Wrong answer:** “I use Cursor/Claude for everything; AI writes my code; 10× engineer.”  
**Senior answer:**

1. **Problem:** migration / test generation needed leverage without surrendering design.
2. **Action:** You shaped **context** — modules, conventions, acceptance criteria, review bar — so AI output was usable.
3. **Judgment:** You rejected bad generations; tests still need human oracle; architecture stays human-owned.
4. **Separate from product AI:** FinTrack/GymFlow are *product* on-device systems (Day 24); District is *engineering process*.
5. **Lesson:** Tools amplify clear thinking; they don’t replace ownership at **30L DAU** stakes.

**Timed opener:**  
> “At District I used AI as an accelerator for migration/tests — the skill was context engineering and review judgment, not prompting theater.”

→ [story-bank.md](../../stories/story-bank.md)#S9

### 2.7 Trade-offs

| Choice | When | Cost |
|---|---|---|
| Data-backed disagreement | Cross-functional conflict | Takes prep time |
| Escalate early | Safety/security/revenue | Political capital |
| Absorb and ship | Low-risk preference fights | Resentment if chronic |
| AI-generated tests | Boilerplate coverage | False green; review cost |
| Hand-written critical path tests | Money, identity, crashes | Slower |
| Long STAR (>4 min) | Never in interview | Looks junior / unfocused |

## 3. Read these

| Priority | Resource | Why |
|---|---|---|
| Must | [stories/story-bank.md](../../stories/story-bank.md) | Full bank + quick picker |
| Must | [timing/answer-timing-guide.md](../../timing/answer-timing-guide.md) § Behavioral | 2–3 min budgets |
| Deepen | Day 24 notes — product AI vs tooling AI | Avoid conflation in interviews |
| Repo | Resume bullets only for metrics | No invented stats |

## 4. Map to your work

**Company / feature:** BMS (Ads, LE sheet, IMOC/crash-free, pinning); District (Clean/MVVM + AI-assisted engineering); Raw (SDK, hybrid, migrations); FinTrack/GymFlow (on-device AI).  
**What you did:** Owned revenue-critical and reliability paths; drove cross-functional UX wins; migrated with checklists; used AI with judgment; shipped privacy-first AI products.  
**Interview line (≤20s):**  
> “I lead through ownership — crash-free discipline at 30L+ DAU scale, measurable UX wins like the LE sheet, and clear judgment on where AI helps versus where architecture must stay human.”

→ Rotate: [story-bank.md](../../stories/story-bank.md) S1–S16 as needed.

## 5. Normal questions

### Q1. Tell me about yourself / walk me through your experience. `(90–120s — still structured)`
**Skeleton:** Current focus → BMS scale highlights → District architecture → Raw SDK/apps → FinTrack/GymFlow AI → what you want next (senior iOS ownership).  
**Follow-up:** Deep dive one stop.  
**Story:** Collage, not one STAR.

### Q2. Tell me about a conflict with PM/Design. `(2–3 min STAR)`
**Skeleton:** S6 — contracts, options, **30%+ nav** outcome.  
**Follow-up:** What would you do differently?  
**Story:** S6.

### Q3. Describe an incident you owned. `(2–3 min)`
**Skeleton:** S8 IMOC path + crash-free mindset; or S2 race class.  
**Follow-up:** Prevention.  
**Story:** S8 / S2.

### Q4. How have you mentored or led without authority? `(2–3 min)`
**Skeleton:** S10 SDK reuse / S14 checklist / S1 ads standards.  
**Follow-up:** Difficult mentee?  
**Story:** S10/S14.

### Q5. How do you use AI in your workflow? `(45–90s)`
**Skeleton:** District S9 — context, review, accelerator; **not** autopilot; contrast product AI S15.  
**Follow-up:** When do you forbid AI?  
**Story:** S9.

### Q6. What’s your biggest impact metric? `(30–45s)`
**Skeleton:** Pick one: **30%+ nav reduction**, **99.95% crash-free**, **30L+ DAU** ownership context — explain briefly.  
**Follow-up:**  
**Story:** S6 / S8.

## 6. Tricky questions

### T1. “Tell me about a failure.” `(90–120s)`
**Trap:** Fake failure that’s actually a win; or blame-only.  
**Senior answer:** Real miss (e.g. under-specified pin rotation, SDUI unknown-type gap, race that escaped) → impact → what you changed in process → lasting prevention. Keep ego out; keep ownership in.  
**Follow-up:** How do you know it won’t recur?

### T2. “Engineers on your team lean on Copilot and ship junk — what do you do?” `(90–120s)`
**Trap:** Ban all AI or shrug.  
**Senior answer:** Set review bar; critical paths require human-designed tests; pair on architecture; measure escaped defects; teach context engineering (S9). Tools stay; accountability stays.  
**Follow-up:** Personal use policy.

### T3. “Why should we hire you as senior vs mid?” `(90–120s)`
**Trap:** Buzzwords only.  
**Senior answer:** Scope (30L+ DAU), revenue module ownership, reliability culture, SDK-level thinking, cross-functional delivery with metrics, incident ownership, architecture migration judgment, privacy-aware AI.  
**Follow-up:** Growth area? — honest (e.g. deeper ML math) + how you compensate with systems thinking.

### T4. “District migration — did AI do the work?” `(90–120s)`
**Trap:** Yes/no extremism.  
**Senior answer:** AI accelerated boilerplate/tests; you owned module boundaries, Clean/MVVM decisions, and acceptance. Context engineering = specifying constraints models don’t know.  
**Follow-up:** Example of rejected AI output.

### T5. “Push back on a bad deadline.” `(90–120s)`
**Trap:** Hero overtime narrative only.  
**Senior answer:** Make risk visible (quality, crash-free, scope cut options); propose MVP cut; protect **99.95%** class outcomes; escalate with data.  
**Follow-up:** S14 / S6 style negotiation.

## 7. Flashcards for today

| Front | Back |
|---|---|
| STAR timing | 20 / 90 / 30 / 20 · Trap: 5-min Action · Prod: all stories |
| Conflict router | S6 or S8 · Trap: vague drama · Prod: 30% nav / IMOC |
| Incident lesson | Stabilize → RCA → prevent · Trap: blame · Prod: 99.95% CFS |
| Mentorship signal | Checklist, SDK, standards · Trap: “I’m nice” · Prod: S10/S14 |
| AI tooling | Context + review · Trap: tool-worship · Prod: S9 |
| Product vs process AI | S15/S16 vs S9 · Trap: conflate · Prod: Day 24 |
| Metrics allowed | 30L DAU, 99.95%, 30% nav · Trap: invent · Prod: resume |
| Failure STAR | Real miss + process change · Trap: humblebrag fail · Prod: — |
| Senior why | Scope + ownership + judgment · Trap: years only · Prod: — |
| Quick picker | Tags → IDs in story bank · Trap: search mid-answer · Prod: — |

## 8. Practice

- **Coding / SD:** None required. Optional: 15-min SDUI or networking **agenda only** if restless — do not deep-work code today.
- **Story bank reps:**  
  1. Full pass: **S6, S8, S9, S1** (priority).  
  2. Second pass: **S10, S14, S15, S2**.  
  3. Cold prompts: friend/partner throws random questions from §5–6; you only answer with bank stories.
- **Complexity / agenda to say first:** For every STAR, speak the 10s opener before the story.

## 9. Timed drill

1. Record **5 STARs** (must include conflict, incident, AI tooling).
2. Score each vs [answer-timing-guide.md](../../timing/answer-timing-guide.md) behavioral rubric (target ≥4).
3. Re-record any story >3:15 — cut Action to 3 bullets.
4. Log gotchas: invented metrics, tool-worship, missing lesson line.
5. Tomorrow is Mock #4 — sleep; do not cram new tech.
