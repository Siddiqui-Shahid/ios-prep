# Sample 04 — Synchronised dictionaries & actor SafeDict design (Q&A)

> Guided teaching. Separates **shipped** named cases from **design-if-asked** and **lab-only** so you never blur them in an interview.

---

### Q1. What can you claim under BookMyShow synchronised dictionaries?

**Answer:**

> At BookMyShow, shared async state hit **synchronised dictionaries** gated by **GCD serial queues** (and read-write locks where read-heavy). You introduced a **closed access API** so call sites could not touch raw storage. That eliminated concurrent-access crashes **on that shared-state path** — pattern reused where mutable maps were shared. **Do not** claim this alone produced app-wide 99.95% crash-free — that is BookMyShow IMOC + crash-free at scale reliability culture, not BookMyShow synchronised dictionaries’s scope.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| ≤15s opener? | “We had races on shared dictionaries — serial-queue design and trade-offs vs actors.” |
| What caused the crashes? | Unsynchronized dictionary mutation from multiple async contexts — data races. |
| Forbidden overclaim? | “BookMyShow synchronised dictionaries alone gave us 99.95% CFS.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries; BookMyShow IMOC + crash-free at scale
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Do not steal BookMyShow IMOC / crash-free culture credit for a path-specific dictionary race fix — keep scopes separate.

---

### Q2. What was the BookMyShow synchronised dictionaries fix, technically?

**Answer:**

> Hide storage behind an API: writes on a **serial queue**, reads synchronized for a safe snapshot, **RW lock** where reads dominated. Call sites never touch the raw dictionary. Lesson: **serialize mutation at the boundary** — don’t sprinkle locks ad hoc. Trade-offs: `sync` reads can deadlock if misused on the same queue; extreme read contention may need strategy revisits.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why closed API? | Prevents “just grab the dict” races at random call sites. |
| Validation? | Concurrency stress + Crashlytics watch for that failure mode. |
| Tie to Day 04? | Same serial-queue mental model — Day 05 adds actor alternative. |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Exact crash %, “fixed all BMS crashes,” or claiming lab SafeDict.swift was the shipped file.

---

### Q3. What is Design: actor SafeDict (not shipped), and what is it not?

**Answer:**

> **Design: actor SafeDict (not shipped)** is **How I would apply it** — not verified as org-wide BMS rewrite. For **greenfield** shared maps, expose the same safe get/set surface on a Swift **`actor`** so isolation is compiler-checked. Keep API ideas from BookMyShow synchronised dictionaries (hide storage, serialize mutation); change implementation to language-native isolation. Pitfall shifts from `queue.sync` deadlock to **actor reentrancy** — train the team to re-validate after `await`.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Big-bang rewrite? | **No** — strangler at new module boundaries. |
| Generic constraints? | `Key: Hashable & Sendable`, `Value: Sendable` — see SafeDictActor. |
| Never return what? | Mutable interior reference callers can race on. |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries
- **Design if asked:** Design: actor SafeDict (not shipped)
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Exact crash %, “fixed all BMS crashes,” or claiming lab SafeDict.swift was the shipped file.

---

### Q4. How do you pitch BookMyShow synchronised dictionaries → Design: actor SafeDict (not shipped) migration in 45–60 seconds?

**Answer:**

> “Production fix was GCD serial-queue dictionaries — BookMyShow synchronised dictionaries. For greenfield shared maps I’d use an actor with the same get/set surface so isolation is compiler-checked. I wouldn’t rewrite stable modules for fashion — strangler-migrate at boundaries. Trade-off: reentrancy at await instead of sync deadlock — state must be re-validated after await.” Mention snapshot/get/remove API parity with [`SafeDictActor.swift`](../code/SafeDictActor.swift).

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Step 1 of strangler? | Don’t big-bang every call site in a revenue app. |
| Leave legacy when? | Stable GCD dict until a feature touch requires change. |
| Bridge A one-liner? | “Same boundary idea — compiler isolation, revalidate after await.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries
- **Design if asked:** Design: actor SafeDict (not shipped)
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Exact crash %, “fixed all BMS crashes,” or claiming lab SafeDict.swift was the shipped file.

---

### Q5. How does BookMyShow backend-driven header & search tie to Task cancellation?

**Answer:**

> BookMyShow backend-driven header & search at BookMyShow covers backend-driven header, **search debounce**, explicit loading/empty/error state, and MVVM. For Day 05 the slice is: debounce is not only sleep — **cancel the previous in-flight Task** so slower older responses cannot overwrite fresher results. Treat `CancellationError` as normal. Unstructured Task at UI/VM boundary + cooperative cancel on each query change.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Invent debounce ms from prod? | **No** — don’t invent specific constants. |
| `@MainActor` VM role? | UI state updates on main while search Tasks cancel and restart. |
| ≤20s line? | “Debounced and cancelled the previous Task so stale responses couldn’t win.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow backend-driven header & search
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q6. What must you never invent?

**Answer:**

> ✅ GCD synchronised dictionaries at BMS — BookMyShow synchronised dictionaries. ✅ Search debounce / MVVM — BookMyShow backend-driven header & search. ❌ Actor migration shipped org-wide at BMS — use Design: actor SafeDict (not shipped) only. ❌ Specific debounce milliseconds from production. ❌ BookMyShow synchronised dictionaries caused app-wide 99.95% CFS alone. Check registry before you speak; label Verified vs How I would apply it out loud.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Actor rewrite claim? | Design: actor SafeDict (not shipped) — design judgment, not resume fact. |
| CFS metric? | BookMyShow IMOC + crash-free at scale culture — don’t attach to BookMyShow synchronised dictionaries alone. |
| Registry path? | [`provenance/README.md`](../../../../provenance/README.md) |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries; BookMyShow backend-driven header & search; BookMyShow IMOC + crash-free at scale
- **Design if asked:** Design: actor SafeDict (not shipped)
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Do not steal BookMyShow IMOC / crash-free culture credit for a path-specific dictionary race fix — keep scopes separate.

---

### Q7. How do BookMyShow synchronised dictionaries and actors compare in an interview table?

**Answer:**

> | Legacy BookMyShow synchronised dictionaries | Greenfield Design: actor SafeDict (not shipped) |
> |---|---|
> | `SafeDict` + serial queue | `actor SafeDict` |
> | `sync` get / async set on queue | `await get` / `await set` |
> | Manual discipline | Compiler isolation |
> | `queue.sync` deadlock risk | Reentrancy across `await` |
> Same **boundary** idea — different enforcement and pitfall class.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| When keep GCD? | Legacy stable modules that work — wrap at edges. |
| When choose actor? | New shared mutable state. |
| Mixing both in one app? | Expected at BMS scale — strangler, not big-bang. |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries
- **Design if asked:** Design: actor SafeDict (not shipped)
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Exact crash %, “fixed all BMS crashes,” or claiming lab SafeDict.swift was the shipped file.

---

### Q8. Give a full honest answer mixing BookMyShow synchronised dictionaries, Design: actor SafeDict (not shipped), and BookMyShow backend-driven header & search

**Answer:**

> “Shared maps at BookMyShow raced under async access — we fixed that with synchronised dictionaries on serial queues and a closed API, BookMyShow synchronised dictionaries. For new modules I’d expose the same surface on a Swift actor — Design: actor SafeDict (not shipped) — and train on reentrancy. Search UX used debounce with MVVM — BookMyShow backend-driven header & search — and the concurrency piece I care about is cancelling the previous Task so stale network responses don’t clobber newer queries. I don’t claim we rewrote every dictionary to actors org-wide.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Where is Verified? | BookMyShow synchronised dictionaries dictionary fix; BookMyShow backend-driven header & search search/debounce/MVVM. |
| Where is applied? | Design: actor SafeDict (not shipped) actor migration for greenfield. |
| After this sample? | [`SafeDictActor.swift`](../code/SafeDictActor.swift), then [`../04-questions.md`](../04-questions.md). |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries; BookMyShow backend-driven header & search
- **Design if asked:** Design: actor SafeDict (not shipped)
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Exact crash %, “fixed all BMS crashes,” or claiming lab SafeDict.swift was the shipped file.

## After this sample

1. Read [SafeDictActor.swift](../code/SafeDictActor.swift) line by line.
2. Speak from **Answer points** in [`../04-questions.md`](../04-questions.md).
3. Do timed drills in [`../05-exercises.md`](../05-exercises.md).

---

