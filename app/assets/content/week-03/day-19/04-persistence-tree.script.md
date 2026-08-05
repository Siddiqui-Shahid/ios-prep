# Audio script — Sample 04 — Persistence decision tree (Q&A)
> Listen-only sample Q&A from `04-persistence-tree.md`. Spoken answers and follow-ups.

## §0 Q1. What is the persistence decision tree opener?

Next. Q1. What is the persistence decision tree opener? Answer. “It depends on sensitivity and access pattern — secrets in Keychain, prefs in UserDefaults, media in FileManager, queries in SQLite WAL or Core Data for graphs, NSCache for session images, actors for concurrent in-session state.” Quote the full 7-row table in interviews without opening a cheatsheet. Follow-ups. One tool for everything?: No — decision tree discipline.. Main-thread SQLite writes?: No — heavy writes off main.. Caches as sole truth?: No — caches can vanish under memory pressure..

## §1 Q2. Recite the full 7-row table.

Next. Q2. Recite the full 7-row table Answer. | Use case | Store | Notes | Structured data, complex queries: SQLite (WAL). Object graph / Apple ecosystem: Core Data. Secrets, tokens, keys: Keychain. Simple preferences / flags: UserDefaults. Large binary / media: FileManager Caches or App Support. In-session, auto-evict: NSCache / LRU. Concurrent in-session state: Actor / serial queue. Follow-ups. WAL why?: Concurrent readers + one writer — better than default rollback journal for apps.. Core Data for 3 booleans?: Don’t — UserDefaults suffices.. Ticket PDF user saved?: Application Support — not Caches..

## §2 Q3. Walk five quick pairing drills.

Next. Q3. Walk five quick pairing drills Answer. 1. Refresh token → Keychain 2. Dark mode flag → UserDefaults 3. Offline orders query → SQLite WAL 4. Ticket PDF user saved → Application Support 5. Poster images session → NSCache + Caches files 6. Shared in-flight map → Actor / serial queue 7. Complex graph + tooling → Core Data bg writes Follow-ups. Wrong pairings to refuse?: Token in UD · media in UD · Core Data for two booleans · secrets in NSCache.. Encrypted messages DB?: SQLCipher + Keychain-wrapped key when threat model requires.. PII at rest?: Encrypt when required; keys in Keychain/SEP..

## §3 Q4. SQLite WAL vs Core Data — when which?

Next. Q4. SQLite WAL vs Core Data — when which? Answer. SQLite WAL: explicit SQL, complex queries, offline feed with concurrent reads — you own the schema and migrations. Core Data: object graph, Apple tooling, CloudKit bias — still background context for writes. Neither for three booleans. Neither on main thread for heavy writes. Follow-ups. Offline feed with filters?: SQLite WAL — explicit query control.. Rich object relationships + undo?: Core Data tooling wins.. Both in one app?: Yes — different domains, different stores..

## §4 Q5. FileManager: Caches vs Application Support?

Next. Q5. FileManager: Caches vs Application Support? Answer. /Caches: large media, re-downloadable assets — purgeable under storage pressure. /Application Support: user-owned or irreplaceable files (saved PDF, exported doc). Never treat Caches as durable user data. Image pipeline often uses NSCache L1 + Caches L2. Follow-ups. System deletes Caches?: Yes — design re-fetch or re-download.. UserDefaults for file paths?: OK for non-sensitive path prefs; not for secrets.. iCloud backup?: App Support user files may backup; Caches typically excluded..

## §5 Q6. NSCache vs actor for in-session state?

Next. Q6. NSCache vs actor for in-session state? Answer. NSCache: decoded images, parsed blobs — auto-evict on memory warning; set cost limits (e.g. byte count). Not for secrets or authoritative state. Actor / serial queue: shared mutable maps, in-flight request dedup — race-free boundary (links to S 2 / S 2-A1). Pick based on evictable cache vs correct concurrent mutation. Follow-ups. LRU custom vs NSCache?: NSCache is memory-pressure aware — prefer for images.. Actor for image bytes?: Overkill — NSCache fits.. Dictionary without isolation?: Data races — actor or serial queue..

## §6 Q7. Full persistence + security close (45s drill)?

Next. Q7. Full persistence + security close (45s drill)? Answer. Recite 7-row table → “Tokens never in UserDefaults” → tie to S4 transport: “Refresh in Keychain, theme in UD, session images in NSCache, offline queries in SQLite WAL.” If interviewer pushes encryption: SQLCipher + Keychain-wrapped key for sensitive DB; PII policy drives the call. Follow-ups. Day 19 teach-back four items?: ATS ≠ pinning · SPKI DER ≠ SecKey raw · full table · S4 vs S4-A1.. Invent Core Data for flags?: Decision tree discipline fail.. After sample?:../04-questions.md timed practice.. Next:../04-questions.md.
