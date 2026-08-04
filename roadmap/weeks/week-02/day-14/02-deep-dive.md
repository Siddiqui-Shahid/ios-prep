# 02 — Deep Dive: Full Mock Script + Ads/SDUI Spines

> Everything you need to run Mock #2 without leaving Cursor.

## 1. Facilitator script — Mock #2 (self or peer)

### Setup (2 min)

1. Timer visible; recording on.  
2. Candidate declares **Track A (Ads)** or **Track B (SDUI)**.  
3. Facilitator (or you) opens this section and [04-questions.md](04-questions.md).  
4. Score sheet: timing guide rubric 1–5.

### Block 1 — Warm-ups (15–20 min)

Ask **4–5** Normals. Prefer mix:

- Layers/DI or search cancel (Day 08 / S3)  
- Single-flight refresh (Day 09)  
- Unknown SDUI node (Day 10)  
- HeroWidget pause **or** SwiftUI identity (S1 / S10)  
- One DSA composure (Array queue **or** agenda-first)

**Facilitator line:** “45–60 seconds. Agenda first if it’s conceptual.”

### Block 2 — Tricky (15–20 min)

Ask **2** of:

- Refresh stampede + pin outage leadership  
- Why not SDUI the Ads video player?  
- Hybrid deeplink dual-stack failure  
- Debounce VM vs repository (pick a side)  
- Ran 8 minutes on architecture — how fix?

### Block 3 — Architecture talk (5:00 hard stop)

**Facilitator:** “Five minutes. I’ll hard-stop. Agenda in the first twenty seconds.”

- Track A → §2 below  
- Track B → §3 below  

Record this block as its own take.

### Block 4 — STAR (10 min)

- Track A: **S1** (2–3 min) + spice **S4** opener (20s)  
- Track B: **S3** (2–3 min) + spice **S12** opener (20–45s)  
- Optional either: **S9** AI tooling judgment (45–60s)

Talk tracks: [code/MockTalkTracks.md](code/MockTalkTracks.md).

### Block 5 — Retro (10–15 min)

1. Score each answer 1–5.  
2. Note: agenda missing? overclaim? over time?  
3. Log gotchas tagged `week-02`.  
4. Checklist:

- [ ] 5-min talk < 5:30 (ideal ≤ 5:00)  
- [ ] S1/S3/S4/S9 openers ≤ 20–45s each  
- [ ] Refresh + unknown component clean  
- [ ] DSA basics not blocking  

---

## 2. Track A — Ads architecture (5 min spine)

### Agenda (≤20s)

> “I’ll cover problem scope, type-safe component pipeline with POP and generics, HeroWidget lifecycle, networking and pinning on URLSession, and trade-offs versus SDUI for media.”

### Beats (~1 min each)

**1. Context**  
Highest-revenue Ads module needed safer reusable rendering; video inside HeroWidget needed correct pause/play with lifecycle.

**2. Component model**  
Protocol-oriented ad contracts + generics pipeline — not inheritance trees — so new creatives plug in without forking.

**3. HeroWidget**  
Visibility / VC lifecycle / background → pause/play; `prepareForReuse` stops player; lifecycle is part of the product contract.

**4. Networking security**  
Alamofire → URLSession; HTTPS; SSL pinning; domain whitelist. Pin rotation / backup / break-glass as **design** (S4-A1), not a fake shipped runbook claim.

**5. Trade-offs / close**  
Keep revenue media native; CMS may configure placement; SDUI for config ≠ SDUI for the player. Invite questions.

### Failure modes to mention if time

| Failure | Mitigation |
|---|---|
| Off-screen playback | Visibility + disappear pause |
| Pin mismatch outage | Backup pins + staged rotation design |
| Cell reuse wrong creative | Cancel + clear + generation token |

### Full spoken 5-min talk

See [code/MockTalkTracks.md](code/MockTalkTracks.md) § Track A full script.

---

## 3. Track B — SDUI architecture (5 min spine)

### Agenda (≤20s)

> “I’ll define SDUI scope, schema and versioning, registry and allowlisted actions, fail-soft fallback and cache, then BMS header and Aces splash — and limits versus native Ads.”

### Beats

**1. Problem**  
Content/layout velocity without releases; personalisation; crash-free rendering.

**2. Pipeline**  
Fetch → version gate → parse → component registry → layout → allowlisted actions only.

**3. Resilience**  
Unknown type → skip + metric; last-known-good cache; empty root → hard fallback header/splash; never crash on bad CMS.

**4. Production**  
BMS backend-driven header + search (S3); Aces server-driven splash / cold-start freshness (S12). Measure time-to-interactive, not vanity TTFF alone.

**5. Trade-offs / close**  
New component types still need app release; revenue video Ads often stay native (S1). Invite questions.

### Failure modes

| Failure | Mitigation |
|---|---|
| Major schema mismatch | Version gate + hard fallback |
| Unknown node | Skip, don’t throw |
| Action injection | Allowlist only |
| Slow splash fetch | Cached last-good splash |

### Full spoken 5-min talk

See [code/MockTalkTracks.md](code/MockTalkTracks.md) § Track B full script.

---

## 4. Why not both architectures as one religion

| Choice | When | Cost |
|---|---|---|
| Native Ads media (S1) | Lifecycle, billing viewability, typed players | Less CMS flexibility on the player itself |
| SDUI header/splash (S3/S12) | Content velocity, experimentation | New widgets need release; must fail-soft |
| SDUI configures Ads placement | Best of both | Clear boundary — config vs renderer |
| SDUI the video player | Rarely | Weak lifecycle/typing for revenue media |

**Bridge answer (T4 energy):**  
> “I’d SDUI the placement and campaign config; I’d keep the video renderer native with HeroWidget’s pause/play contract.”

---

## 5. Week 2 connective micro-answers (embedded)

### Single-flight refresh (30s spine)

N×401 → one refresh Task; waiters await; retry once; failure → logout fan-out.

### Unknown SDUI (20s spine)

Skip + metric; never crash; empty root → hard fallback.

### Search cancel (20s spine)

Debounce in VM; cancel Task; cancellation ≠ user-facing error; ignore stale.

### SwiftUI identity (20s spine)

Stable IDs; UUID in `body` resets state; Stories pages need stable identity (S10).

### Array as queue (15s spine)

`removeFirst` O(n); deque / two-stack.

---

## 6. Trade-offs (meta mock)

| Choice | When | Cost |
|---|---|---|
| Ads 5-min | Strong S1/S4 | Less CMS vocab |
| SDUI 5-min | Strong S3/S12 | Must admit native limits |
| Both cold | Ego | Neither crisp |
| Skip STAR | Fatigue | Lose behavioral signal |
| Skip retro | Hubris | No compounding |

---

## 7. Optional citations (not required)

- `ios-system-design/docs/networking-layer.md`  
- `ios-system-design/docs/sdui-engine.md`  
- Timing: `roadmap/timing/answer-timing-guide.md`
