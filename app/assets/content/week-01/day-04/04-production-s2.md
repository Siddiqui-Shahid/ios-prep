# Sample 04 — Synchronised dictionaries & actor SafeDict design (Q&A)

> Guided teaching. Separates **shipped** named cases from **design-if-asked** and **lab-only** so you never blur them in an interview.

---

### Q1. What can you claim for BookMyShow synchronised dictionaries?

**Answer:**

> Shared async state at BookMyShow was hit from **multiple queues** → **data races** and **intermittent crashes**. You introduced **synchronised dictionary wrappers** gated by **GCD serial queues** (and **read-write locks** where access was read-heavy), standardized the **access API** so call sites could not touch raw storage, validated under concurrency stress and **Crashlytics** watch, and **eliminated concurrent-access crashes on that path**. Pattern reused for similar shared maps.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| ≤20s pitch? | “We gated shared dictionaries behind a serial queue API so call sites couldn’t race the storage — crashes went away on that path.” |
| Timed opener? | “We had races on shared dictionaries — I’ll cover the serial-queue design and trade-offs vs actors.” |
| Named-case label? | BookMyShow synchronised dictionaries |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Exact crash %, “fixed all BMS crashes,” or claiming lab SafeDict.swift was the shipped file.

---

### Q2. What must you NOT invent for BookMyShow synchronised dictionaries?

**Answer:**

> Do **not** invent exact crash counts or percentages fixed by this work alone. Do **not** say “I alone brought the app to 99.95% CFS” — that is **BookMyShow IMOC + crash-free at scale culture**, not BookMyShow synchronised dictionaries attribution. Do **not** claim every dictionary in the app was converted. Do **not** claim production used your Learning-lab [`SafeDict.swift`](../code/SafeDict.swift) file literally.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Safe result phrasing? | “Eliminated concurrent-access crashes **in that shared state path**.” |
| Forbidden breadth? | “Fixed all crashes at BMS.” |
| Learning-lab label? | SafeDict / BarrierDict demos — not shipped BMS source. |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries; BookMyShow IMOC + crash-free at scale
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Do not steal BookMyShow IMOC / crash-free culture credit for a path-specific dictionary race fix — keep scopes separate.

---

### Q3. What is the full BookMyShow synchronised dictionaries STAR Action (~90s)?

**Answer:**

> “Shared mutable dictionaries were accessed from multiple queues, which produced data races and intermittent crashes. I introduced synchronised dictionary wrappers gated by GCD serial queues — and read-write locking where the access pattern was read-heavy — and standardized the access API so call sites could not touch raw storage. We validated under concurrency stress and watched Crashlytics. The races on that path went away, and we reused the pattern wherever shared async maps showed up.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Lesson line? | “Serialize at the boundary — don’t sprinkle locks ad hoc.” |
| Result line? | “Eliminated concurrent-access crashes in that shared state path; pattern reused.” |
| Full STAR budget? | ≤3 minutes including trade-offs if asked. |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Exact crash %, “fixed all BMS crashes,” or claiming lab SafeDict.swift was the shipped file.

---

### Q4. What is the actor SafeDict design coda (not shipped)?

**Answer:**

> **Design direction**, not a shipped rewrite: “Production used GCD. How I’d apply it in a new module is an **`actor SafeDict`** with get/set/snapshot — callers **await**, isolation is in the type system, same boundary idea.” Point at Day 05 [`SafeDictActor.swift`](../day-05/code/SafeDictActor.swift) as Learning-lab. Say **design, not shipped** aloud so the interviewer hears honesty.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| 20s actor coda? | “Same API as an actor for new modules — design only, not a claim we rewrote production.” |
| Why mention actors at all? | Shows modern Swift awareness without faking migration history. |
| Actor API cost? | Async surface; reentrancy across `await` — different traps than GCD sync. |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries
- **Design if asked:** Design: actor SafeDict (not shipped)
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Exact crash %, “fixed all BMS crashes,” or claiming lab SafeDict.swift was the shipped file.

---

### Q5. How do BookMyShow synchronised dictionaries concepts map to interview questions?

**Answer:**

> **Serial vs concurrent** → definitions; SafeDict uses serial. **Thread-safe dict** → private queue API (BookMyShow synchronised dictionaries). **async vs sync write** → visibility caveat; prefer sync for read-after-write. **Barrier** → RW pattern for read-heavy (BookMyShow synchronised dictionaries mention). **Deadlock** → sync re-entry on any serial queue. **Actors** → Design: actor SafeDict (not shipped) coda. **Why hide queue** → call sites re-race if they touch storage or queue.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| If asked “why not always barrier”? | BookMyShow synchronised dictionaries honesty: serial default; RW where read-heavy and measured. |
| If asked visibility? | Teach async-write / sync-read rule; prefer sync set. |
| If asked modern approach? | Actor SafeDict coda — labeled design, not shipped. |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries
- **Design if asked:** Design: actor SafeDict (not shipped)
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Exact crash %, “fixed all BMS crashes,” or claiming lab SafeDict.swift was the shipped file.

---

### Q6. What are the BookMyShow synchronised dictionaries anti-patterns to avoid?

**Answer:**

> **“Fixed all crashes at BMS”** → path-specific race elimination. **Inventing crash %** → qualitative intermittent races → eliminated on path. **`Final class` spelling** → **`final class`**. **“Async set always visible on next line”** → teach sync set / visibility. **Skipping actor coda** when asked modern approach → give Design: actor SafeDict (not shipped) with honest label.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Public `var storage`? | Anti-pattern — private + snapshot. |
| Exposing queue? | Anti-pattern — standardized API was the fix. |
| Concurrent writes without barrier? | Anti-pattern — barrier or serial. |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries
- **Design if asked:** Design: actor SafeDict (not shipped)
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Exact crash %, “fixed all BMS crashes,” or claiming lab SafeDict.swift was the shipped file.

---

### Q7. How does BookMyShow synchronised dictionaries relate to BookMyShow IMOC + crash-free at scale without stealing credit?

**Answer:**

> **BookMyShow synchronised dictionaries** is the **specific fix** — synchronised dictionaries, races on that path. **BookMyShow IMOC + crash-free at scale** is soft **reliability culture** — Crashlytics triage, high CFS bar at scale. You may say BookMyShow synchronised dictionaries validation included watching Crashlytics. You may **not** attribute app-wide 99.95% CFS solely to BookMyShow synchronised dictionaries or use BookMyShow IMOC + crash-free at scale metrics as if they were BookMyShow synchronised dictionaries results.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Safe Crashlytics mention for BookMyShow synchronised dictionaries? | “Validated under concurrency stress and watched Crashlytics” on **that path**. |
| Behavioral question — lead with? | BookMyShow synchronised dictionaries STAR for concurrency/dictionary question; BookMyShow IMOC + crash-free at scale for reliability culture question. |
| Blurring BookMyShow synchronised dictionaries and BookMyShow IMOC + crash-free at scale? | Interview red flag — keep provenance labels separate. |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries; BookMyShow IMOC + crash-free at scale
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Do not steal BookMyShow IMOC / crash-free culture credit for a path-specific dictionary race fix — keep scopes separate.

---

### Q8. What should you deliver in a timed BookMyShow synchronised dictionaries drill?

**Answer:**

> **≤20s:** serial-queue API, races gone on path. **≤3 min STAR:** problem (multi-queue shared dicts) → action (serial queue / RW, standardized API, stress + Crashlytics) → result (path clean, pattern reused) → lesson (serialize at boundary) → **actor coda** (design-only SafeDict actor). Flash card: BookMyShow synchronised dictionaries; GCD serial / RW; safe access API.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Story bank link? | [BookMyShow synchronised dictionaries](../../../stories/story-bank.md#s2--synchronised-dictionaries-bookmyshow) |
| After BookMyShow synchronised dictionaries drill? | Main [`../04-questions.md`](../04-questions.md) for two-layer Q&A timing. |
| Code aloud? | Tour [`SafeDict.swift`](../code/SafeDict.swift) line-by-line — Learning-lab. |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries
- **Design if asked:** Design: actor SafeDict (not shipped)
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Exact crash %, “fixed all BMS crashes,” or claiming lab SafeDict.swift was the shipped file.

Back to: [README.md](README.md)

---

