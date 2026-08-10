# Sample 02 — Brief A: paginated list + cache (Q&A)

> Guided teaching. Practice **structure** for the 3hr list brief — not a full implementation here.

---

### Q1. What is Brief A asking for?
**Answer:**

> Paginated remote list (cursor or page number). Loading / empty / error states. Pull-to-refresh and next-page on scroll. **Cache** so revisiting shows last-good data quickly, then refresh. **Unit tests** for pagination and cache policy.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Clarify at 0:15? | Cursor vs page number; offline behavior; UIKit vs SwiftUI; minimum test count. |
| Stub vs live API? | Stub first for progress; one live call if stable. |
| Cut lines OK? | Fancy skeletons, Diffable animations, image pipeline, auth refresh. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q2. What architecture should I sketch in 90s?
**Answer:**

> SwiftUI List (or UIKit equivalent) → **ListViewModel** (items, page/cursor, isLoading, error) → **ListRepository protocol** → RemoteDataSource + CacheDataSource. Say: “Stub remote and memory SWR cache. Page-based pagination with in-flight guard and request generation id. Three unit tests. Cut: images, disk, auth.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why protocol repo? | Fake for tests; swap live without VM rewrite. |
| Generation id? | Stale response rule — commit only if generation matches. |
| MVVM enough? | Yes — pragmatic layers beat over-Clean in 3 hrs. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q3. What are must-have acceptance criteria?
**Answer:**

> **(1)** First page renders from network/stub. **(2)** Next page appends without wiping. **(3)** Failure on page 2 keeps page 1 visible. **(4)** Cache: cold open shows stale then refresh — **define policy aloud**. **(5)** Tests: pagination reducer/repository with mock — not only UI snapshots.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Wipe on refresh? | Usually replace page 1 — say policy. |
| Empty first page? | Empty state UI — not error. |
| Error on refresh with cache? | Keep stale + nonblocking error — state machine. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q4. What cache policy should I pick and defend?
**Answer:**

> **Memory LRU only** — fast interview slice; lost on kill. **Memory + disk (Codable)** — stronger senior story; serialization cost. **Stale-while-revalidate** — best UX; need generation/TTL. Pick one at 0:18 and repeat at 2:10.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| SWR in one sentence? | Show cache immediately; fetch fresh; swap when arrives. |
| Disk scope? | Optional depth 2:00–2:30 — don’t block slice. |
| Test cache how? | Mock cache data source; assert VM shows stale then updated. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q5. What is the pagination state machine?
**Answer:**

> idle → loadingFirst → loaded | empty | error. loaded → loadingMore | refreshing. loadingMore → loaded (append) or loaded (keep + nonblocking error). refreshing → loaded (replace) or loaded (keep stale + error). **Stale response:** fetch captures generation; commit only if `generation == viewModel.generation`.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Double fetch page 2? | In-flight guard on loadingMore. |
| Pull during loadingMore? | Queue or cancel — state aloud. |
| Test names? | `test_appendPage2`, `test_page2FailureKeepsPage1`, `test_staleCacheThenRefresh`. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q6. What tests are “meaningful” for Brief A?
**Answer:**

> Test **ViewModel** or **repository** with injected fakes: append pagination, failed page 2 preserves page 1, cache SWR or stale-then-refresh, generation id ignores stale response. **3+ fast unit tests** — not snapshot-only, not 100% coverage chase.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| District Free Parking + Clean/MVVM + AI tooling AI tests? | You review — assert behavior not implementation trivia. |
| UI test one? | Optional cut — unit tests pass bar. |
| Async tests? | Use async test or inject synchronous fake repo. |

**How can I relate to my case:**
- **Shipped:** District Free Parking + Clean/MVVM + AI tooling
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q7. Brief A trade-offs to narrate?
**Answer:**

> SwiftUI list faster slice; UIKit shop may want Diffable — state assumption. Protocol + fake repo first — progress + tests. Real network impressive but flaky. Perfect Clean Architecture rarely fits 3 hrs.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| BookMyShow backend-driven header & search production hook? | Pagination/debounce instincts — not claim this project is BMS. |
| Image loading? | Cut line. |
| Debrief? | Sample 04 + [07-revision-qna.md](07-revision-qna.md). |

**How can I relate to my case:**
- **Shipped:** BookMyShow backend-driven header & search
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

Next: [03-brief-b-sdui.md](03-brief-b-sdui.md) · or run Brief A in [`../05-exercises.md`](../05-exercises.md)

---

## Brain puzzles (cover → think → check)

### Puzzle A — What architecture should I sketch in 90s

**Ask yourself:** What architecture should I sketch in 90s?

**Answer:** “SwiftUI List (or UIKit equivalent) → **ListViewModel** (items, page/cursor, isLoading, error) → **ListRepository protocol** → RemoteDataSource + CacheDataSource. Say: “Stub remote and memory SWR cache. Page-based pagination with in-flight guard and request generation id. Three unit tests. Cut: images, disk, auth.”

### Puzzle B — What are must-have acceptance criteria

**Ask yourself:** What are must-have acceptance criteria?

**Answer:** “**(1)** First page renders from network/stub. **(2)** Next page appends without wiping. **(3)** Failure on page 2 keeps page 1 visible. **(4)** Cache: cold open shows stale then refresh — **define policy aloud**. **(5)** Tests: pagination reducer/repository with mock — not only UI snapshots.”

### Puzzle C — What cache policy should I pick and defend

**Ask yourself:** What cache policy should I pick and defend?

**Answer:** “**Memory LRU only** — fast interview slice; lost on kill. **Memory + disk (Codable)** — stronger senior story; serialization cost. **Stale-while-revalidate** — best UX; need generation/TTL. Pick one at 0:18 and repeat at 2:10.”
