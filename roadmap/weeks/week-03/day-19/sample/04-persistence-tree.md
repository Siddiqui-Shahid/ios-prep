# Sample 04 — Persistence decision tree (Q&A)

> Guided teaching. Each answer stands alone and ends with **How can I relate to my case** using named work — never S-codes.

---

### Q1. What is the persistence decision tree opener?
**Answer:**

> “It depends on **sensitivity** and **access pattern** — secrets in Keychain, prefs in UserDefaults, media in FileManager, queries in SQLite WAL or Core Data for graphs, NSCache for session images, actors for concurrent in-session state.” Quote the full 7-row table in interviews without opening a cheatsheet.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One tool for everything? | **No** — decision tree discipline. |
| Main-thread SQLite writes? | **No** — heavy writes off main. |
| Caches as sole truth? | **No** — caches can vanish under memory pressure. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q2. Recite the full 7-row table?
**Answer:**

> | Use case | Store | Notes |
> | Structured data, complex queries | **SQLite (WAL)** | `PRAGMA journal_mode=WAL`; off-main writes |
> | Object graph / Apple ecosystem | **Core Data** | `NSPersistentContainer`; **background context for writes** |
> | Secrets, tokens, keys | **Keychain** | AfterFirstUnlock or stricter; no sync for auth |
> | Simple preferences / flags | **UserDefaults** | **Non-sensitive only** |
> | Large binary / media | **FileManager** Caches or App Support | Caches purgeable; user data → App Support |
> | In-session, auto-evict | **NSCache / LRU** | Memory-pressure aware; cost bounds |
> | Concurrent in-session state | **Actor** / serial queue | Race-free mutation boundary |

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| WAL why? | Concurrent readers + one writer — better than default rollback journal for apps. |
| Core Data for 3 booleans? | **Don’t** — UserDefaults suffices. |
| Ticket PDF user saved? | **Application Support** — not Caches. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q3. Walk five quick pairing drills?
**Answer:**

> 1. Refresh token → **Keychain** 
> 2. Dark mode flag → **UserDefaults** 
> 3. Offline orders query → **SQLite WAL** 
> 4. Ticket PDF user saved → **Application Support** 
> 5. Poster images session → **NSCache** + **Caches** files 
> 6. Shared in-flight map → **Actor** / serial queue 
> 7. Complex graph + tooling → **Core Data** bg writes

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Wrong pairings to refuse? | Token in UD · media in UD · Core Data for two booleans · secrets in NSCache. |
| Encrypted messages DB? | SQLCipher + Keychain-wrapped key when threat model requires. |
| PII at rest? | Encrypt when required; keys in Keychain/SEP. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q4. SQLite WAL vs Core Data — when which?
**Answer:**

> **SQLite WAL:** explicit SQL, complex queries, offline feed with concurrent reads — you own the schema and migrations. 
> **Core Data:** object graph, Apple tooling, CloudKit bias — still **background context for writes**. 
> Neither for three booleans. Neither on main thread for heavy writes.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Offline feed with filters? | SQLite WAL — explicit query control. |
| Rich object relationships + undo? | Core Data tooling wins. |
| Both in one app? | Yes — different domains, different stores. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q5. FileManager: Caches vs Application Support?
**Answer:**

> **`/Caches`:** large media, re-downloadable assets — **purgeable** under storage pressure. 
> **`/Application Support`:** user-owned or irreplaceable files (saved PDF, exported doc). 
> Never treat Caches as durable user data. Image pipeline often uses NSCache L1 + Caches L2.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| System deletes Caches? | Yes — design re-fetch or re-download. |
| UserDefaults for file paths? | OK for non-sensitive path prefs; not for secrets. |
| iCloud backup? | App Support user files may backup; Caches typically excluded. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q6. NSCache vs actor for in-session state?
**Answer:**

> **NSCache:** decoded images, parsed blobs — auto-evict on memory warning; set **cost limits** (e.g. byte count). Not for secrets or authoritative state. 
> **Actor / serial queue:** shared mutable maps, in-flight request dedup — race-free boundary (links to BookMyShow synchronised dictionaries / Design: actor SafeDict (not shipped)). Pick based on **evictable cache** vs **correct concurrent mutation**.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| LRU custom vs NSCache? | NSCache is memory-pressure aware — prefer for images. |
| Actor for image bytes? | Overkill — NSCache fits. |
| Dictionary without isolation? | Data races — actor or serial queue. |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries
- **Design if asked:** Design: actor SafeDict (not shipped)
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Exact crash %, “fixed all BMS crashes,” or claiming lab SafeDict.swift was the shipped file.

---

### Q7. Full persistence + security close (45s drill)?
**Answer:**

> Recite 7-row table → “Tokens never in UserDefaults” → tie to BookMyShow SSL pinning + URLSession migration transport: “Refresh in Keychain, theme in UD, session images in NSCache, offline queries in SQLite WAL.” If interviewer pushes encryption: SQLCipher + Keychain-wrapped key for sensitive DB; PII policy drives the call.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Day 19 teach-back four items? | ATS ≠ pinning · SPKI DER ≠ SecKey raw · full table · BookMyShow SSL pinning + URLSession migration vs Design: pin rotation / break-glass (not shipped runbook). |
| Invent Core Data for flags? | Decision tree discipline fail. |
| After sample? | [07-revision-qna.md](07-revision-qna.md) timed practice. |

**How can I relate to my case:**
- **Shipped:** BookMyShow SSL pinning + URLSession migration
- **Design if asked:** Design: pin rotation / break-glass (not shipped runbook)
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Claiming pin-rotation / break-glass runbook as a shipped production playbook.

Next: [07-revision-qna.md](07-revision-qna.md)

---

## Brain puzzles (cover → think → check)

### Puzzle A — Recite the full 7-row table

**Ask yourself:** Recite the full 7-row table?

**Answer:** “| Use case | Store | Notes |
> | Structured data, complex queries | **SQLite (WAL)** | `PRAGMA journal_mode=WAL`; off-main writes |
> | Object graph / Apple ecosystem | **Core Data** | `NSPersistentContainer`; **background context for writes** |
> | Secrets, tokens, keys | **Keychain** | AfterFirstUnlock or stricter; no sync for auth |
> | Simple preferences / flags | **UserDefaults** | **Non-sensitive only** |
> | Large binary / media | **FileManager** Caches or App Support | Caches purgeable; user data → App Support |
> | In-session, auto-evict | **NSCache / LRU** | Memory-pressure aware; cost bounds |
> | Concurrent in-session state | **Actor** / serial queue | Race-free mutation boundary |”

### Puzzle B — Walk five quick pairing drills

**Ask yourself:** Walk five quick pairing drills?

**Answer:** “1. Refresh token → **Keychain** 
> 2. Dark mode flag → **UserDefaults** 
> 3. Offline orders query → **SQLite WAL** 
> 4. Ticket PDF user saved → **Application Support** 
> 5. Poster images session → **NSCache** + **Caches** files 
> 6. Shared in-flight map → **Actor** / serial queue 
> 7. Complex graph + tooling → **Core Data** bg writes”

### Puzzle C — SQLite WAL vs Core Data — when which

**Ask yourself:** SQLite WAL vs Core Data — when which?

**Answer:** “**SQLite WAL:** explicit SQL, complex queries, offline feed with concurrent reads — you own the schema and migrations. 
> **Core Data:** object graph, Apple tooling, CloudKit bias — still **background context for writes**. 
> Neither for three booleans. Neither on main thread for heavy writes.”
