# Sample 04 — Persistence decision tree (Q&A)

> Guided teaching. Each answer stands alone; **Points to** shows where the full module expands the idea.

---

### Q1. What is the persistence decision tree opener?

**Points to:** [Foundations · §3 Full persistence decision tree](../01-foundations.md#3-full-persistence-decision-tree-embedded--recite-this) · [Foundations · Recite opener](../01-foundations.md#3-full-persistence-decision-tree-embedded--recite-this)

**Answer:**

> “It depends on **sensitivity** and **access pattern** — secrets in Keychain, prefs in UserDefaults, media in FileManager, queries in SQLite WAL or Core Data for graphs, NSCache for session images, actors for concurrent in-session state.” Quote the full 7-row table in interviews without opening a cheatsheet.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One tool for everything? | **No** — decision tree discipline. |
| Main-thread SQLite writes? | **No** — heavy writes off main. |
| Caches as sole truth? | **No** — caches can vanish under memory pressure. |

---

### Q2. Recite the full 7-row table.

**Points to:** [Foundations · §3](../01-foundations.md#3-full-persistence-decision-tree-embedded--recite-this) · [Deep dive · §6](../02-deep-dive.md#6-persistence-tree--worked-examples)

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

---

### Q3. Walk five quick pairing drills.

**Points to:** [Deep dive · §11 Persistence tree stress drills](../02-deep-dive.md#11-persistence-tree-stress-drills-embed-again)

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

---

### Q4. SQLite WAL vs Core Data — when which?

**Points to:** [Foundations · §3](../01-foundations.md#3-full-persistence-decision-tree-embedded--recite-this) · [Deep dive · §6 Worked examples](../02-deep-dive.md#6-persistence-tree--worked-examples)

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

---

### Q5. FileManager: Caches vs Application Support?

**Points to:** [Foundations · §3](../01-foundations.md#3-full-persistence-decision-tree-embedded--recite-this) · [Deep dive · §6](../02-deep-dive.md#6-persistence-tree--worked-examples)

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

---

### Q6. NSCache vs actor for in-session state?

**Points to:** [Foundations · §3](../01-foundations.md#3-full-persistence-decision-tree-embedded--recite-this) · [Deep dive · §6](../02-deep-dive.md#6-persistence-tree--worked-examples)

**Answer:**

> **NSCache:** decoded images, parsed blobs — auto-evict on memory warning; set **cost limits** (e.g. byte count). Not for secrets or authoritative state.  
> **Actor / serial queue:** shared mutable maps, in-flight request dedup — race-free boundary (links to S2 / S2-A1). Pick based on **evictable cache** vs **correct concurrent mutation**.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| LRU custom vs NSCache? | NSCache is memory-pressure aware — prefer for images. |
| Actor for image bytes? | Overkill — NSCache fits. |
| Dictionary without isolation? | Data races — actor or serial queue. |

---

### Q7. Full persistence + security close (45s drill)?

**Points to:** [Production bridge · §5 Persistence recite](../03-production-bridge.md#5-persistence-recite-45s-drill) · [Foundations · §7 Teach-back](../01-foundations.md#7-teach-back)

**Answer:**

> Recite 7-row table → “Tokens never in UserDefaults” → tie to S4 transport: “Refresh in Keychain, theme in UD, session images in NSCache, offline queries in SQLite WAL.” If interviewer pushes encryption: SQLCipher + Keychain-wrapped key for sensitive DB; PII policy drives the call.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Day 19 teach-back four items? | ATS ≠ pinning · SPKI DER ≠ SecKey raw · full table · S4 vs S4-A1. |
| Invent Core Data for flags? | Decision tree discipline fail. |
| After sample? | [`../04-questions.md`](../04-questions.md) timed practice. |

---

Next: [`../04-questions.md`](../04-questions.md)
