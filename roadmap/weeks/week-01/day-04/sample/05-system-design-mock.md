# Sample 05 — System-design mock: Offline-First Sync Engine (Q&A)

> Guided **mock interview** flow. Speak answers aloud against a 45‑min timer.
> **Source:** `[ios-system-design/docs/offline-sync-engine.md](../../../../ios-system-design/docs/offline-sync-engine.md)` · timing: `[cheatsheet.md](../../../../ios-system-design/docs/cheatsheet.md)`
> **Angle:** Day 04 — **queues / concurrency** (GCD & thread-safety parallel).
>
> **How to use:** Say the **Answer** blocks out loud. Words in parentheses are reminders for you — skip them when speaking.

---

### Q1. Interviewer: “Design an Offline-First Sync Engine.” How do you open?

**Answer (say this):**

> “I’ll take about five minutes to clarify scope and scale. Then I’ll draw a simple client high-level design in four layers, plus how we talk to the backend and rough load. Then API and data. Then two deep dives: first the SyncEngine actor and dirty flags, second background tasks and last-write-wins conflicts. I’ll close with failures, metrics, and a kill switch. Does that plan work for you?”

**Follow-ups:**


| Follow-up                 | Answer (say this)                                                                                         |
| ------------------------- | --------------------------------------------------------------------------------------------------------- |
| Why say the agenda first? | “So we agree on the plan. If you want different deep dives, I’d rather know now.”                         |
| Skip the agenda?          | Don’t skip. Skipping looks junior — they may want a different focus.                                      |
| Clarify for 15 minutes?   | “I’ll hard-stop clarifying at five minutes. Anything left I’ll state as labeled assumptions and move on.” |


**How can I relate to my case:**

- **Design if asked:** Offline sync — say “this is a design exercise; I’ll label assumptions.”
- **Shipped parallel:** BookMyShow concurrency work — same habit: agree the plan before diving into locks / queues.

---

### Q2. What clarifying questions do you ask before drawing?

**Answer (say these, then wait — or state assumptions):**

> “Before I draw, a few questions:
>
> 1. What entities sync — notes, cart, settings, or something else?
> 2. For conflicts, is last-write-wins okay, or do we need fancy merge like OT or CRDT?
> 3. Rough DAU, and at peak how many local unsynced changes per user — the dirty-queue depth?
> 4. Do we need background refresh with BGAppRefresh, or only sync when the app is open?
> 5. Is auth in scope, or can I assume tokens already exist?
> 6. I’d like to put rich media upload — photos and videos — out of scope. Is that okay?”

**Rules while speaking:**

- Do **not** draw until they answer, or you say clear assumptions out loud.
- From minute one, think about how hard the client hits the backend.

**If they give no numbers, say:**

> “I’ll assume about 500k DAU, a few dirty items per user at peak, batches of 50, and last-write-wins for notes only. I’ll label those as assumptions — please correct me.”

**Follow-ups:**


| Follow-up             | Answer (say this)                                                                                                       |
| --------------------- | ----------------------------------------------------------------------------------------------------------------------- |
| What is a dirty note? | “A note changed on device but not yet pushed to the server. We mark it dirty so SyncEngine knows to upload it.”         |
| What is LWW?          | “Last write wins — if two devices edit the same note, the newer timestamp wins. Simple. Good for notes and settings.”   |
| What is OT/CRDT?      | “Real-time merge, like Google Docs. Much harder. I’d park that as out of scope unless you want a collaborative editor.” |
| They refuse numbers?  | Give labeled estimates from DAU and continue. Don’t freeze.                                                             |


**How can I relate to my case:**

- **Design if asked:** Offline sync — label design.
- **Shipped parallel:** Same as agreeing thread-safety scope before coding shared dictionaries / actors.

---

### Q3. After clarify — what did we agree, and what is the good interview flow?

**Answer (say this):**

> “For this mock I’ll assume: SQLite is the source of truth on device. We push local changes first, then pull server changes. Conflicts use last-write-wins. We sync in batches of at most 50 records. Background work gets about 30 seconds. Out of scope: Google-Docs-style merge, and rich media upload.
>
> Good flow for me: agenda, clarify, confirm assumptions, high-level design, API, two deep dives, then last five minutes on ops.
>
> I’ll avoid: drawing in silence, only happy path, inventing QPS as fact, and skipping ops.”

**Follow-ups:**


| Follow-up                           | Answer (say this)                                                                                                            |
| ----------------------------------- | ---------------------------------------------------------------------------------------------------------------------------- |
| They change scope mid-design?       | “Quick check — is X now in or out? I’ll adjust the deep dives, but I’ll still protect the last five minutes for ops.”        |
| They want a full backend deep dive? | “I’ll sketch the two sync endpoints and stay focused on the iOS client unless you want to go deeper on the server.”          |
| Forgot to ask about offline?        | “Assumption: offline-first with a local database. If you prefer online-first plus last-good cache, tell me and I’ll adjust.” |


**How can I relate to my case:**

- **Design if asked:** Offline sync — label design.
- **Shipped parallel:** BookMyShow concurrency stories — confirm in/out before implementing.

---

### Q4. Walk the high-level design — client layers.

**Answer (say this while drawing four boxes top to bottom):**

> “Four client layers.
>
> Top: Feature screens and ViewModels. They only read and write the local database. The UI never talks to the network directly for sync.
>
> Next: Local store — SQLite is the source of truth. Creates, edits, deletes land here first. We mark changed rows dirty.
>
> Next: SyncEngine as a Swift actor. It is the single place that runs sync. It pushes dirty rows, then pulls server changes. Only one sync runs at a time.
>
> Bottom: Network — authenticated calls to push and pull.
>
> Data flow: user edits → SQLite + dirty flag → SyncEngine push → then pull → update SQLite → UI refreshes from local data.”

**Follow-ups:**


| Follow-up                               | Answer (say this)                                                                                                                                                  |
| --------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Why an actor?                           | “Same idea as one exclusive writer. The actor makes sure two syncs don’t run together and corrupt state. Compile-time safety is nicer than a manual serial queue.” |
| Why not let the ViewModel call the API? | “Then every screen invents its own sync. Central SyncEngine keeps one pipeline and one place for retries.”                                                         |
| Can UI wait for network?                | “No. UI reads SQLite immediately — optimistic. Sync runs in the background.”                                                                                       |


**How can I relate to my case:**

- **Design if asked:** Offline sync — label design.
- **Shipped parallel:** Synchronised dictionaries / actor migration — single-writer instinct from BookMyShow concurrency work.

---

### Q5. Backend touchpoints and load — what do you say?

**Answer (say this):**

> “Backend touchpoints are simple: `POST /sync/push` to upload dirty records, and `GET /sync/pull?since=...` with a sync token cursor to download changes since last sync.
>
> Load notes: batch at most 50 records per request. Background refresh about every 15 minutes at minimum, not constantly. Local database reads and writes should stay under about 50 milliseconds. Never block the UI thread — same queue discipline as Day 04.
>
> From DAU I’ll give a labeled QPS estimate, not invent a fake exact number.”

**Follow-ups:**


| Follow-up                  | Answer (say this)                                                                                                 |
| -------------------------- | ----------------------------------------------------------------------------------------------------------------- |
| Push first or pull first?  | “Push first, then pull. That way local edits get to the server before we overwrite local state with server data.” |
| Why batch 50?              | “Fits background time budgets, keeps payloads small, and makes retries easier.”                                   |
| Why a cursor / sync token? | “So pull is ‘give me changes since X,’ not re-download everything. Cheaper for the server.”                       |


**How can I relate to my case:**

- **Design if asked:** Offline sync — label design.
- **Shipped parallel:** Treat sync like a serial work queue — don’t stampede the backend, same mindset as capping concurrent work.

---

### Q6. Data / API — what endpoints and rules?

**Answer (say this):**

> “Push: `POST /v1/sync/push`. Body is dirty records plus client timestamps.
>
> Pull: `GET /v1/sync/pull?since=TOKEN&limit=100`. Response is server changes plus a new sync token.
>
> Deletes use tombstones — a ‘this id was deleted’ marker — so other devices learn about deletes.
>
> Record ids are idempotent — if we retry the same push, the server must not create duplicates.”

**Follow-ups:**


| Follow-up                      | Answer (say this)                                                                       |
| ------------------------------ | --------------------------------------------------------------------------------------- |
| Invalid or expired sync token? | “Fall back to a full resync path. It should be rare. I’ll metric how often it happens.” |
| Push fails halfway?            | “Retry the batch with backoff. Do not clear dirty flags until the server ACKs success.” |
| Why tombstones?                | “If we only delete locally, other devices never learn the row is gone.”                 |


**How can I relate to my case:**

- **Design if asked:** Offline sync — label design.
- **Shipped parallel:** Idempotent retries matter the same way careful enter/leave and single-flight work mattered in concurrency bugs.

---

### Q7. Deep dive 1 — SyncEngine actor and dirty flags?

**Answer (say this):**

> “SyncEngine is a Swift actor, so only one sync pipeline runs at a time — single-flight.
>
> Many things can request a sync: app foreground, network comes back, user pulls to refresh. I coalesce those triggers into one run instead of starting five syncs.
>
> User flow: UI writes to SQLite first, marks the row dirty, updates the screen from local data, and sync goes async.
>
> After a successful push ACK, clear dirty. After pull, apply server rows into SQLite.”

**Follow-ups:**


| Follow-up                                       | Answer (say this)                                                                                         |
| ----------------------------------------------- | --------------------------------------------------------------------------------------------------------- |
| Two syncs at once?                              | “The actor prevents that. One pipeline only.”                                                             |
| How is this like GCD barriers?                  | “Same mental model as an exclusive writer from Day 04 — one writer, many readers from SQLite via the UI.” |
| Sync already running and another trigger fires? | “Set a ‘run again when finished’ flag, or coalesce — don’t start a second sync.”                          |


**How can I relate to my case:**

- **Design if asked:** Offline sync — label design.
- **Shipped parallel:** Synchronised dictionaries / actor migration instincts from BookMyShow — exclusive access to shared mutable state.

---

### Q8. Deep dive 2 — Background tasks and LWW conflicts?

**Answer (say this):**

> “For background: BGAppRefresh gives a short budget, about 30 seconds. In that window I push a batch, pull a batch, save a checkpoint — meaning update the sync token and dirty flags — then stop cleanly if time is almost up.
>
> For conflicts: last-write-wins using the server timestamp. If product needs a ‘your edit was overwritten’ banner, we can show it — but default is quiet LWW.
>
> Deletes stay as tombstones until pull confirms other devices have the delete.”

**Follow-ups:**


| Follow-up                          | Answer (say this)                                                                                                       |
| ---------------------------------- | ----------------------------------------------------------------------------------------------------------------------- |
| They ask for OT/CRDT?              | “I’d call collaborative editing a different prompt. For this sync engine I’d keep LWW unless you want to expand scope.” |
| Battery?                           | “Target under about 2% per day for sync. Batch aggressively — fewer large syncs beat constant tiny ones.”               |
| What if BG time runs out mid-sync? | “Checkpoint what finished. Leave remaining rows dirty for the next sync.”                                               |


**How can I relate to my case:**

- **Design if asked:** Offline sync — label design.
- **Shipped parallel:** Time-boxed background work is like respecting queue budgets — don’t start unbounded work you can’t finish.

---

### Q9. Ops — failures, metrics, kill switch?

**Answer (say this):**

> “Targets I’d track: sync success rate above 99.5%, p99 sync under 5 seconds, dirty-queue length alerts if the backlog grows, and background task completion rate.
>
> Kill switch: remotely pause sync. App stays read-only on local SQLite so users can still open content.
>
> If everyone comes online after an outage: reconnect with jitter and exponential backoff so we don’t thundering-herd the server.”

**Follow-ups:**


| Follow-up                          | Answer (say this)                                                                                                         |
| ---------------------------------- | ------------------------------------------------------------------------------------------------------------------------- |
| What is thundering herd?           | “Millions of clients sync at the same second. Jitter spreads them out.”                                                   |
| How does this relate to Day 04 S2? | “Shared mutable sync state needs one safe owner — the actor is the production-shaped answer to thread-safe shared state.” |
| Invented crash-free percent?       | Don’t invent product metrics as facts. Use resume numbers or say ‘target.’”                                               |


**How can I relate to my case:**

- **Design if asked:** Offline sync — label design.
- **Shipped parallel:** Thread-safe shared state from production concurrency work → SyncEngine actor is the system-design version of that lesson.

---

### Q10. Time scorecard — did you hit the good path?

**Answer (use as a checklist after the mock — or say briefly if asked how you’ll spend 45 minutes):**

> “Timing spine: minutes 0–5 clarify, 5–15 high-level design, 15–25 API, 25–40 two deep dives, 40–45 ops.
>
> Pass bar: agenda and clarify in five; HLD shows four layers plus backend plus load; API has cursor and idempotency; two deep dives; ops with real metrics and a kill switch.
>
> Anti-patterns: offset pagination on changing data; SQLite or JSON decode on the main thread; inventing QPS as fact; never reaching ops; a vague architecture blob with no data flow.”

**Follow-ups:**


| Follow-up                   | Answer (say this)                                                                                       |
| --------------------------- | ------------------------------------------------------------------------------------------------------- |
| Ran long on dive 1?         | “I’ll park dive 2 as bullets and protect the last five minutes for ops.”                                |
| Forgot load entirely?       | One sentence: “From DAU I’ll label QPS, use cursor pulls, and single-flight sync so we don’t stampede.” |
| Feeling lost mid-interview? | Return to spine: clarify → HLD → API → dives → ops.                                                     |


**How can I relate to my case:**

- **Concept-only — no shipped story.** Rehearse this scorecard after every timed mock.

