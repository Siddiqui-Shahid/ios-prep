# Day 27 — Expert Mock #4 (Full Loop)

> Week 4 · Revision pass ~45–60 min  
> Full study: [weeks/week-04/day-27/](../../../weeks/week-04/day-27/README.md)  
> Sample Q&A (guided): [weeks/week-04/day-27/sample/](../../../weeks/week-04/day-27/sample/README.md)

## 1. Outcome

Explain aloud, in plain sentences:

- Execute full loop: **Warm-up 15 → Coding 45 → iOS 45 → SD 45 → debrief**
- Open **every segment** with the correct agenda — no notes in-frame
- Score against **1–5 segment scorecards**; leave **≤3 fix-forwards** for Day 28
- Keep proof trio loaded: **30L+ DAU**, **99.95%+**, **30%+ nav**

## 2. Concept refresh (simple)

### 2.1 Full loop schedule

```text
Warm-up   15 min   mixed Normal/Tricky from pools
Coding    45 min   Medium, unlabeled pattern — fresh DSA
iOS       45 min   concurrency, architecture, networking/SDUI, perf/crashes
SD        45 min   SDUI OR networking+pinning OR on-device AI
Debrief   score + ≤3 fix-forwards → stop
```

**Fresh DSA** — prefer unlabeled Medium, not Day 25 app comfort.

### 2.2 Segment openers

Every segment starts with agenda + scope invite. **Agenda first** — no notes visible in-frame.

| Segment | Push |
|---|---|
| Coding | Clarify → brute → optimize → edges → code |
| iOS | Trade-offs, not trivia — concurrency, lifecycle, perf |
| SD | **Never skip last 5 min** for failure modes / metrics / rollout |

### 2.3 Scorecards (1–5 each)

Score communication, timing, trade-offs, production grounding. Harsh on: silent coding, no ops closer, fake metrics, >4 min STAR drift.

### 2.4 Fix-forwards for Day 28

From debrief, write **exactly ≤3** flashcard fronts — chronic gotcha, one pattern miss, one provenance slip. Then **stop**. Day 28 reviews only these + weak cards.

### 2.5 Critical truths (pin)

| Claim | Truth |
|---|---|
| Full loop | Warm-up 15 → Coding 45 → iOS 45 → SD 45 → debrief |
| Fix-forwards | **Exactly ≤3** flashcard fronts for Day 28 — then stop |
| SD ops block | **Never** skip last 5 min for failure modes / metrics |
| Fresh DSA | Prefer unlabeled Medium — not Day 25 app comfort |
| Proof trio | **30L+ DAU**, **99.95%+**, **30%+** nav — always loaded |
| Agenda first | Every segment — no notes in-frame |

## 3. Read these

| Priority | Resource | Why |
|---|---|---|
| Must | [Sample Q&A](../../../weeks/week-04/day-27/sample/) | Schedule + scorecards |
| Must | [02-deep-dive](../../../weeks/week-04/day-27/02-deep-dive.md) | Segment playbooks + rubrics |
| Run | [05-exercises](../../../weeks/week-04/day-27/05-exercises.md) | Full mock loop |
| Warm-up | [07-revision-qna](../../../weeks/week-04/day-27/sample/07-revision-qna.md) | Two-layer Q pools |

No `code/` kit — fresh DSA problem day-of.

## 4. Map to your work

**Proof trio (always loaded):** **30L+ DAU** (BookMyShow IMOC + crash-free at scale) · **99.95%+ crash-free** (BookMyShow IMOC + crash-free at scale) · **30%+ nav** on targeted flows (BookMyShow LE Bottom Sheet).

| If they ask… | Reach |
|---|---|
| SDUI | BookMyShow backend-driven header & search / Audio streaming + server-driven splash (Aces) + schema fallback |
| Networking security | BookMyShow SSL pinning + URLSession migration pinning |
| Concurrency | BookMyShow synchronised dictionaries |
| Architecture / AI tools | District Free Parking + Clean/MVVM + AI tooling |
| On-device AI | FinTrack on-device AI / GymFlow on-device AI |
| SDK | Stories SDK (Raw / Miami Heat) |
| Hybrid UI | Hybrid UI / deeplinks |

**Interview line (≤20s):** “I’ll run this like a real loop — agenda first, trade-offs, and metrics I actually shipped.”

→ [BookMyShow IMOC + crash-free at scale](../../stories/story-bank.md#s8--imoc--crash-free-at-scale-bookmyshow) · [BookMyShow LE Bottom Sheet](../../stories/story-bank.md#s6--le-bottom-sheet-bookmyshow)

## 5. Flash prompts

1. Full loop clock — 15 / 45 / 45 / 45
2. Coding opener — clarify before code
3. iOS segment — three trade-off areas to push
4. SD closer — failure modes + metrics + rollout (last 5 min)
5. Scorecard dimensions — what earns a 5?
6. Blank recovery — restate, brute, pivot
7. Proof trio — say all three with story IDs
8. Fix-forward discipline — ≤3 cards, then stop

## 6. Timed drills

| Drill | Budget |
|---|---|
| Segment openers (×3) | 20s each |
| Warm-up pool (×3) | 45–60s each |
| Mock #4 full loop | ~4.5 hr (if not done) |
| Debrief + scorecards | 30 min |
| Write ≤3 fix-forwards | 10 min |

If Mock #4 is done: rehearse openers + score one recorded segment. If not: run [05-exercises](../../../weeks/week-04/day-27/05-exercises.md) first, then return here for fix-forward capture.
