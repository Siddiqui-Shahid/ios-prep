# Sample 04 — Synchronised dictionaries & actor SafeDict design (Q&A)

> Guided teaching. Say the **Answer** out loud like you’re talking to an interviewer. 
> Separates **shipped** named cases from **design-if-asked** and **lab-only** so you never blur them. 
> **Brain puzzles** at the bottom — cover the answer, think, then check.

---

### Q1. What can you claim for BookMyShow synchronised dictionaries?
**Answer:**

> “Shared async state at BookMyShow was hit from multiple queues — data races and intermittent crashes. I introduced synchronised dictionary wrappers gated by GCD serial queues, and read-write locks where access was read-heavy. We standardized the access API so call sites could not touch raw storage, validated under concurrency stress and Crashlytics watch, and eliminated concurrent-access crashes on that path. Pattern reused for similar shared maps.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| ≤20s pitch? | “We gated shared dictionaries behind a serial queue API so call sites couldn’t race the storage — crashes went away on that path.” |
| Timed opener? | “We had races on shared dictionaries — I’ll cover the serial-queue design and trade-offs vs actors.” |
| Named-case label? | “BookMyShow synchronised dictionaries.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Don’t claim:** Exact crash %, “fixed all BMS crashes,” or claiming lab SafeDict.swift was the shipped file.

---

### Q2. What must you NOT invent for BookMyShow synchronised dictionaries?
**Answer:**

> “Do not invent exact crash counts or percentages fixed by this work alone. Do not say I alone brought the app to 99.95% crash-free — that’s BookMyShow IMOC and crash-free-at-scale culture, not dictionary attribution. Do not claim every dictionary in the app was converted. Do not claim production used the Learning-lab SafeDict.swift file literally.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Safe result phrasing? | “Eliminated concurrent-access crashes in that shared state path.” |
| Forbidden breadth? | “Fixed all crashes at BMS.” |
| Learning-lab label? | “SafeDict and BarrierDict demos — not shipped BMS source.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries; BookMyShow IMOC + crash-free at scale
- **Don’t claim:** Do not steal IMOC / crash-free culture credit for a path-specific dictionary race fix — keep scopes separate.

---

### Q3. What is the full BookMyShow synchronised dictionaries STAR Action (~90s)?
**Answer:**

> “Shared mutable dictionaries were accessed from multiple queues, which produced data races and intermittent crashes. I introduced synchronised dictionary wrappers gated by GCD serial queues — and read-write locking where the access pattern was read-heavy — and standardized the access API so call sites could not touch raw storage. We validated under concurrency stress and watched Crashlytics. The races on that path went away, and we reused the pattern wherever shared async maps showed up.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Lesson line? | “Serialize at the boundary — don’t sprinkle locks ad hoc.” |
| Result line? | “Eliminated concurrent-access crashes in that shared state path; pattern reused.” |
| Full STAR budget? | “Three minutes or less including trade-offs if asked.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Don’t claim:** Exact crash %, “fixed all BMS crashes,” or claiming lab SafeDict.swift was the shipped file.

---

### Q4. What is the actor SafeDict design coda (not shipped)?
**Answer:**

> “Design direction, not a shipped rewrite: production used GCD. How I’d apply it in a new module is an actor SafeDict with get/set/snapshot — callers await, isolation is in the type system, same boundary idea. Point at Day 05 SafeDictActor as Learning-lab. Say design, not shipped aloud so the interviewer hears honesty.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| 20s actor coda? | “Same API as an actor for new modules — design only, not a claim we rewrote production.” |
| Why mention actors at all? | “Shows modern Swift awareness without faking migration history.” |
| Actor API cost? | “Async surface; reentrancy across await — different traps than GCD sync.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries
- **Design if asked:** Design: actor SafeDict (not shipped)
- **Lab only:** Learning-lab demos — not production source.
- **Don’t claim:** Exact crash %, “fixed all BMS crashes,” or claiming lab SafeDict.swift was the shipped file.

---

### Q5. How do BookMyShow synchronised dictionaries concepts map to interview questions?
**Answer:**

> “Serial vs concurrent — definitions; SafeDict uses serial. Thread-safe dict — private queue API from BookMyShow synchronised dictionaries. Async vs sync write — visibility caveat; prefer sync for read-after-write. Barrier — RW pattern for read-heavy. Deadlock — sync re-entry on any serial queue. Actors — Design: actor SafeDict coda. Why hide queue — call sites re-race if they touch storage or queue.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why not always barrier? | “Serial default; RW where read-heavy and measured — BookMyShow honesty.” |
| If asked visibility? | “Teach async-write / sync-read rule; prefer sync set.” |
| If asked modern approach? | “Actor SafeDict coda — labeled design, not shipped.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries
- **Design if asked:** Design: actor SafeDict (not shipped)
- **Don’t claim:** Exact crash %, “fixed all BMS crashes,” or claiming lab SafeDict.swift was the shipped file.

---

### Q6. What are the BookMyShow synchronised dictionaries anti-patterns to avoid?
**Answer:**

> “Saying fixed all crashes at BMS — path-specific race elimination only. Inventing crash percent — stick to qualitative intermittent races eliminated on path. Spelling Final class — it’s final class lowercase. Claiming async set is always visible on the next line — teach sync set. Skipping the actor coda when asked modern approach — give Design: actor SafeDict with an honest label.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Public var storage? | “Anti-pattern — private plus snapshot.” |
| Exposing queue? | “Anti-pattern — standardized API was the fix.” |
| Concurrent writes without barrier? | “Anti-pattern — barrier or serial.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries
- **Design if asked:** Design: actor SafeDict (not shipped)
- **Don’t claim:** Exact crash %, “fixed all BMS crashes,” or claiming lab SafeDict.swift was the shipped file.

---

### Q7. How does synchronised dictionaries relate to IMOC / crash-free culture without stealing credit?
**Answer:**

> “BookMyShow synchronised dictionaries is the specific fix — synchronised dictionaries, races on that path. BookMyShow IMOC and crash-free at scale is reliability culture — Crashlytics triage, high crash-free bar at scale. I may say validation included watching Crashlytics. I may not attribute app-wide 99.95% CFS solely to dictionaries or use culture metrics as if they were dictionary results.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Safe Crashlytics mention? | “Validated under concurrency stress and watched Crashlytics on that path.” |
| Behavioral question — lead with? | “Synchronised dictionaries STAR for concurrency questions; IMOC culture for reliability-culture questions.” |
| Blurring the two? | “Interview red flag — keep provenance labels separate.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries; BookMyShow IMOC + crash-free at scale
- **Don’t claim:** Do not steal IMOC / crash-free culture credit for a path-specific dictionary race fix.

---

### Q8. What should you deliver in a timed synchronised dictionaries drill?
**Answer:**

> “Twenty seconds: serial-queue API, races gone on path. Three-minute STAR: problem — multi-queue shared dicts — action — serial queue or RW, standardized API, stress plus Crashlytics — result — path clean, pattern reused — lesson — serialize at boundary — then actor coda as design-only SafeDict actor. Flash card: BookMyShow synchronised dictionaries; GCD serial or RW; safe access API.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| After the drill? | “Main 07-revision-qna for two-layer Q&A timing — including T1 through T10.” |
| Code aloud? | “Tour SafeDict.swift line-by-line — Learning-lab.” |
| Actor coda honesty? | “Say design, not shipped — never invent a big-bang rewrite.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries
- **Design if asked:** Design: actor SafeDict (not shipped)
- **Lab only:** Learning-lab demos — not production source.
- **Don’t claim:** Exact crash %, “fixed all BMS crashes,” or claiming lab SafeDict.swift was the shipped file.

---

## Brain puzzles (cover → think → check)

### Puzzle A — S2-A1 labeled design not shipped

Interviewer: “So you rewrote all BMS dictionaries as actors?”

**Ask yourself:** What’s the honest reply?

**Answer:** “No. Shipped fix was GCD synchronised dictionaries. For greenfield I’d use Design: actor SafeDict — same get/set/snapshot surface — labeled design, not a claim we rewrote production. Strangler at module boundaries.”

---

### Puzzle B — “Fixed all crashes”

Someone says: “SafeDict fixed all BookMyShow crashes and got us to 99.95% CFS.”

**Ask yourself:** What’s wrong?

**Answer:** Scope theft. Path-specific race elimination ≠ org-wide crash-free. Don’t invent %; don’t steal IMOC culture credit.

---

### Puzzle C — `Final class` spelling trap

Whiteboard: `Final class SafeDict<Key: Hashable, Value>`.

**Ask yourself:** What’s the bug?

**Answer:** Swift keyword is `final` lowercase. `Final class` won’t compile. Type it five times correctly in drills.

---

### Puzzle D — Honesty vs “fixed all crashes” under pressure

Panel pushes for a single number: “How many crashes did this remove?”

**Ask yourself:** Safe answer?

**Answer:** “I don’t invent a percentage. We saw intermittent concurrent-access crashes on that shared-map path go away under stress and Crashlytics watch, and we reused the pattern. App-wide CFS is a broader reliability story.”

---

Back to: [README.md](README.md) · Next drills: [06-module-drills.md](06-module-drills.md)
