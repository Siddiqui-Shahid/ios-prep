# Sample 05 — System-design mock: Collaborative Document Editor (Q&A)

> Guided **mock interview** flow. Speak answers aloud against a 45‑min timer.
> **Source:** [`ios-system-design/docs/collaborative-editor.md`](../../../../ios-system-design/docs/collaborative-editor.md) · timing: [`cheatsheet.md`](../../../../ios-system-design/docs/cheatsheet.md)
> **Angle:** Day 22 DSA trees day — **OT collab** SD mock.

---

### Q1. Interviewer: “Design Collaborative Document Editor.” How do you open?
**Answer:**

> **Agenda (≤20s):** “I’ll take ~5 minutes clarifying scope and scale, then a four-layer client HLD with backend touchpoints and load, then API/data, two deep dives on **OT transform engine** and **Pending queue + desync**, and close on failure modes, metrics, and kill switches. Does that work?”
> **Then ask the interviewer (speak these):**
> 1. Multi-user realtime text — rich formatting out?
> 2. OT vs CRDT preference?
> 3. Max concurrent editors (~100)?
> 4. Offline op log?
> 5. Presence/cursors?
> Do **not** draw until they answer or you state **labeled assumptions**. Keep backend load in mind from the first minute.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Skip agenda? | Weak senior signal — interviewer may want different dives. |
| Clarify for 15 min? | Hard stop at 5 — park extras as labeled assumptions. |
| They refuse numbers? | State labeled estimates from DAU context; continue. |

**How can I relate to my case:**
- **Concept-only** — collaborative editor design vocabulary.

---

### Q2. After clarify — what does the optimal flow look like?
**Answer:**

> **Scripted outcomes for this mock:** OT transforms; WS sequencer; offline op queue; presence; out: rich ACLs/folders.
> **Good flow:** agenda → clarify Qs → confirm → HLD (4 layers + backend + load) → API → two crisp dives → ops last 5.
> **Weak flow:** silent drawing, happy-path only, no QPS/TTL, invent metrics, skip ops.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| They change scope mid-HLD? | Re-confirm in/out in 20s; adjust dives; protect ops. |
| Backend mesh deep-dive? | Out unless asked — sketch touchpoints, stay client-owned. |
| Forgot to ask offline? | State online-first + last-good cache as assumption; invite correction. |

**How can I relate to my case:**
- **Concept-only** — collaborative editor design vocabulary.

---

### Q3. Walk the HLD — client layers, backend, load?
**Answer:**

> Editor UI → OT engine → pending op queue → WS → server sequencer. Snapshot store periodically.
> **Load:** presence ~500ms; batch ops ~500ms; snapshot ~100 ops; sync <100ms target.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| CRDT instead? | Valid — state trade-off; pick one and go deep. |
| Tree DSA link? | Op transform ≠ tree problem — don’t force. |

**How can I relate to my case:**
- **Concept-only** — collaborative editor design vocabulary.

---

### Q4. Data / API — entities, endpoints, scale?
**Answer:**

> `GET /docs/{id}/snapshot`; WS `submit_ops` / `apply_ops` / `presence`.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Desync? | Hash mismatch → full snapshot reload. |
| ACL? | Out unless asked. |

**How can I relate to my case:**
- **Concept-only** — collaborative editor design vocabulary.

---

### Q5. Deep dive 1 — OT transform engine?
**Answer:**

> Transform local vs remote ops against revision; apply optimistically; ACK revisions.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Cursor presence? | Separate channel; ephemeral. |
| CPU? | Metric OT time; compact history. |

**How can I relate to my case:**
- **Concept-only** — collaborative editor design vocabulary.

---

### Q6. Deep dive 2 — Pending queue + desync?
**Answer:**

> Queue offline; replay on reconnect; if >1000 ops warn/compact; desync → snapshot.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Partial apply? | Atomic per revision batch. |
| Conflict UX? | Rare with OT — still handle snapshot. |

**How can I relate to my case:**
- **Concept-only** — collaborative editor design vocabulary.

---

### Q7. Ops — failures, metrics, rollout, load?
**Answer:**

> Sync latency, desync rate, OT CPU. Kill: read-only mode.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Redis presence? | Backend sketch only. |
| Invent editors count? | Use labeled ≤100 from spec. |

**How can I relate to my case:**
- **Concept-only** — collaborative editor design vocabulary.

---

### Q8. Flow scorecard — did you hit the optimal spine?
**Answer:**

> **Pass bar:** clarify + agenda in ≤5; HLD shows 4 layers + backend + load; API has cursors/idempotency as needed; two deep dives; ops with kill switch and concrete metrics.
> **Anti-patterns:** offset pagination on dynamic feeds; main-thread SQLite/decode; inventing QPS as fact; never reaching ops; blob “architecture” with no data flow.
> **Spine:** 0–5 clarify · 5–15 HLD · 15–25 API · 25–40 dives · 40–45 ops.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Ran long on dive 1? | Park dive 2 bullets; protect ops 5 min. |
| Forgot load? | One sentence: DAU → labeled QPS, cursor cost, single-flight. |
| Invented crash-free %? | Forbidden — use resume-backed numbers or label as target. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Rehearse this scorecard after every timed mock.
