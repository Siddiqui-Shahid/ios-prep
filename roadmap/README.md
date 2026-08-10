# Senior iOS Interview Prep — Muhammed Shahid Siddiqui

Personalized 4-week senior iOS system. **Full chapters are self-contained in Cursor** — you should not need to leave the repo to understand a topic.

**Profile anchors:** BookMyShow · District · Raw Engineering · FinTrack / GymFlow

---

## Two tracks

| Track | Path | Use when |
|---|---|---|
| **Full study** | [`weeks/week-XX/day-YY/README.md`](weeks/week-01/day-01/README.md) | First time learning a topic |
| **Sample Q&A** | [`weeks/.../day-YY/sample/`](weeks/week-01/day-01/sample/README.md) | Guided teaching cards (also what the audiobook app plays) |
| **Revision** | [`revision/weeks/`](revision/README.md) | After sample/full study — timed drills only |
| **Audiobook app** | [`../app/README.md`](../app/README.md) | Listen + read Days 01–28 sample Q&A offline (iOS & Android) |

### How to study a day

1. Open `weeks/week-XX/day-YY/README.md`
2. Prefer guided cards in `sample/` (question → answer → follow-ups), or read Q&A modules `01-foundations` → `02-deep-dive` → `03-production-bridge`
3. Run / read `code/` when present
4. Do `sample/05-system-design-mock.md` — mock interview flow (clarify → HLD/load → API → dives → ops)
5. Speak practice in `sample/07-revision-qna.md` — **Normal** + **Indirect** + **Tricky** (cover → speak → check)
6. Do `05-exercises.md` (Q&A drills)
7. Drill with the revision twin (`revision/weeks/...`) — flash prompts + timed budgets only

### Answer timing budgets

| Format | Budget |
|---|---|
| Definition | 30–45s |
| Conceptual deep dive | 90–120s |
| Coding approach | 2–3 min |
| Architecture walkthrough | 3–5 min |
| Mobile system design | 45 min |
| Behavioral STAR | 2–3 min |

Details: [timing/answer-timing-guide.md](timing/answer-timing-guide.md)

### Provenance (important)

- **Verified** = resume-backed ([provenance/README.md](provenance/README.md))
- **How I would apply it** = design judgment, not claimed as shipped

---

## Progress tracker

### Week 1
- [ ] [01](weeks/week-01/day-01/README.md) · [02](weeks/week-01/day-02/README.md) · [03](weeks/week-01/day-03/README.md) · [04](weeks/week-01/day-04/README.md) · [05](weeks/week-01/day-05/README.md) · [06](weeks/week-01/day-06/README.md) · [07](weeks/week-01/day-07/README.md)

### Week 2
- [ ] [08](weeks/week-02/day-08/README.md) · [09](weeks/week-02/day-09/README.md) · [10](weeks/week-02/day-10/README.md) · [11](weeks/week-02/day-11/README.md) · [12](weeks/week-02/day-12/README.md) · [13](weeks/week-02/day-13/README.md) · [14](weeks/week-02/day-14/README.md)

### Week 3
- [ ] [15](weeks/week-03/day-15/README.md) · [16](weeks/week-03/day-16/README.md) · [17](weeks/week-03/day-17/README.md) · [18](weeks/week-03/day-18/README.md) · [19](weeks/week-03/day-19/README.md) · [20](weeks/week-03/day-20/README.md) · [21](weeks/week-03/day-21/README.md)

### Week 4
- [ ] [22](weeks/week-04/day-22/README.md) · [23](weeks/week-04/day-23/README.md) · [24](weeks/week-04/day-24/README.md) · [25](weeks/week-04/day-25/README.md) · [26](weeks/week-04/day-26/README.md) · [27](weeks/week-04/day-27/README.md) · [28](weeks/week-04/day-28/README.md)

---

## Generate PDFs

```bash
cd roadmap/pdf && ./generate.sh
```

Produces:

- `interview-prep-roadmap.pdf` — full chapters
- `interview-prep-revision.pdf` — revision track

Validate:

```bash
python3 scripts/validate_roadmap.py
```

---

## Index

| Path | Purpose |
|---|---|
| [PHASES.md](PHASES.md) | Calendar |
| [stories/story-bank.md](stories/story-bank.md) | STAR stories |
| [provenance/](provenance/) | Verified vs Applied registry |
| [flashcards/](flashcards/) | Decks + Anki CSV |
| [coding/dsa-track.md](coding/dsa-track.md) | DSA list |
| [revision/](revision/) | Short drill notes |
| [SAMPLE_COVERAGE_TRACKER.md](SAMPLE_COVERAGE_TRACKER.md) | Sample Q&A vs day-module gap checklist |
