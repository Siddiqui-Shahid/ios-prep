# Sample 04 — Synchronised dictionaries & actor SafeDict design (Q&A)

> Guided teaching. Separates **shipped** named cases from **design-if-asked** and **lab-only**.  
> Say answers out loud. **Brain puzzles** at the bottom keep claims honest.

---

### Q1. What can you claim under BookMyShow synchronised dictionaries?

**Answer:**

> “At BookMyShow, shared async state was hitting dictionaries from multiple places. We gated them with GCD serial queues — and read-write locks where reads dominated. I introduced a closed access API so call sites couldn’t touch the raw storage. That killed concurrent-access crashes on that shared-state path, and we reused the pattern where mutable maps were shared. What I don’t claim: that this alone produced app-wide 99.95% crash-free. That’s IMOC and crash-free culture at scale — different scope.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| ≤15s opener? | “We had races on shared dictionaries — serial-queue design and trade-offs vs actors.” |
| What caused crashes? | “Unsynchronized dictionary mutation from multiple async contexts — data races.” |
| Forbidden overclaim? | “‘Synchronised dictionaries alone gave us 99.95% CFS.’” |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries; BookMyShow IMOC + crash-free at scale
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Do not steal BookMyShow IMOC / crash-free culture credit for a path-specific dictionary race fix — keep scopes separate.

---

### Q2. What was the fix, technically?

**Answer:**

> “Hide storage behind an API. Writes go on a serial queue. Reads sync for a safe snapshot. RW lock where reads dominated. Call sites never touch the raw dictionary. Lesson: serialize mutation at the boundary — don’t sprinkle locks everywhere. Trade-offs: sync reads can deadlock if you misuse the same queue; extreme read contention may need a different strategy.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why closed API? | “Stops ‘just grab the dict’ races at random call sites.” |
| Validation? | “Concurrency stress plus Crashlytics watch for that failure mode.” |
| Tie to Day 04? | “Same serial-queue mental model. Day 05 adds the actor alternative.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Exact crash %, “fixed all BMS crashes,” or claiming lab SafeDict.swift was the shipped file.

---

### Q3. What is Design: actor SafeDict — and what is it not?

**Answer:**

> “That’s ‘how I would apply it’ — not a verified org-wide BMS rewrite. For greenfield shared maps, I’d expose the same safe get/set surface on a Swift actor so isolation is compiler-checked. Keep the API idea from synchronised dictionaries — hide storage, serialize mutation — change the implementation to language-native isolation. The pitfall shifts from queue.sync deadlock to actor reentrancy. I’d train the team to re-validate after await.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Big-bang rewrite? | “No — strangler at new module boundaries.” |
| Generics? | “`Key: Hashable & Sendable`, `Value: Sendable` — see SafeDictActor.” |
| Never return what? | “A mutable interior reference callers can race on.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries
- **Design if asked:** Design: actor SafeDict (not shipped)
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Exact crash %, “fixed all BMS crashes,” or claiming lab SafeDict.swift was the shipped file.

---

### Q4. Pitch S2 → actor migration in 45–60 seconds

**Answer:**

> “Production fix was GCD serial-queue dictionaries — BookMyShow synchronised dictionaries. For greenfield shared maps I’d use an actor with the same get/set surface so isolation is compiler-checked. I wouldn’t rewrite stable modules for fashion — strangler-migrate at boundaries. Trade-off: reentrancy at await instead of sync deadlock — state must be re-validated after await.” Mention snapshot/get/remove API parity with SafeDictActor.swift.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Step 1 of strangler? | “Don’t big-bang every call site in a revenue app.” |
| Leave legacy when? | “Stable GCD dict until a feature touch requires change.” |
| Bridge one-liner? | “Same boundary idea — compiler isolation, revalidate after await.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries
- **Design if asked:** Design: actor SafeDict (not shipped)
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Exact crash %, “fixed all BMS crashes,” or claiming lab SafeDict.swift was the shipped file.

---

### Q5. How does BookMyShow search tie to Task cancellation?

**Answer:**

> “Backend-driven header & search at BookMyShow covers the header, search debounce, clear loading/empty/error state, and MVVM. For Day 05 the slice is: debounce is not only sleep — cancel the previous in-flight Task so a slower older response can’t overwrite fresher results. Treat CancellationError as normal. Unstructured Task at the UI/VM boundary, cooperative cancel on each query change.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Invent debounce ms? | “No — don’t invent production constants.” |
| MainActor VM? | “UI state on main while search Tasks cancel and restart.” |
| ≤20s line? | “Debounced and cancelled the previous Task so stale responses couldn’t win.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow backend-driven header & search
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q6. What must you never invent?

**Answer:**

> “I can say: GCD synchronised dictionaries at BMS. Search debounce and MVVM from backend-driven header & search. I cannot say: we shipped an org-wide actor rewrite — that’s design-only SafeDict. I don’t invent debounce milliseconds. I don’t hang 99.95% CFS on the dictionary fix alone. Check provenance before you speak, and label verified vs how-I-would-apply it out loud.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Actor rewrite claim? | “Design: actor SafeDict — judgment, not resume fact.” |
| CFS metric? | “IMOC + crash-free culture — don’t attach to dictionaries alone.” |
| Registry? | [`provenance/README.md`](../../../../provenance/README.md) |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries; BookMyShow backend-driven header & search; BookMyShow IMOC + crash-free at scale
- **Design if asked:** Design: actor SafeDict (not shipped)
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Do not steal BookMyShow IMOC / crash-free culture credit for a path-specific dictionary race fix — keep scopes separate.

---

### Q7. How do you compare GCD SafeDict vs actor SafeDict?

**Answer:**

> “Legacy: SafeDict plus serial queue, sync get / async set, manual discipline, sync-deadlock risk. Greenfield design: actor SafeDict, await get / await set, compiler isolation, reentrancy across await. Same boundary idea — hide storage, one writer path — different enforcement and different pitfall.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| When keep GCD? | “Legacy stable modules that work — wrap at edges.” |
| When choose actor? | “New shared mutable state.” |
| Mixing both? | “Expected at BMS scale — strangler, not big-bang.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries
- **Design if asked:** Design: actor SafeDict (not shipped)
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Exact crash %, “fixed all BMS crashes,” or claiming lab SafeDict.swift was the shipped file.

---

### Q8. Full honest answer mixing all three stories

**Answer:**

> “Shared maps at BookMyShow raced under async access — we fixed that with synchronised dictionaries on serial queues and a closed API. For new modules I’d expose the same surface on a Swift actor — design, not shipped org-wide — and train on reentrancy. Search UX used debounce with MVVM, and the concurrency piece I care about is cancelling the previous Task so stale network responses don’t clobber newer queries. I don’t claim we rewrote every dictionary to actors.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What’s verified? | “Dictionary race fix; search debounce / MVVM.” |
| What’s applied judgment? | “Actor SafeDict for greenfield.” |
| After this? | SafeDictActor.swift, then ../04-questions.md. |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries; BookMyShow backend-driven header & search
- **Design if asked:** Design: actor SafeDict (not shipped)
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Exact crash %, “fixed all BMS crashes,” or claiming lab SafeDict.swift was the shipped file.

---

### Q9. Give the full S2 STAR in about two minutes

**Answer:**

> “Situation: shared maps were read and written from multiple async contexts, which caused intermittent crashes. Task: stop the races on that path. Action: we hid storage behind a synchronised-dictionary API — writes on a serial queue, reads synchronized for a safe snapshot, reader-writer where reads dominated. Call sites never touched the raw dictionary. Result: that race class went away on that path; we reused the pattern where mutable maps were shared. Trade-off: sync reads can deadlock if you misuse the same queue, and heavy read contention may need another strategy. Today, for greenfield modules, I’d consider a Swift actor with the same API surface. I don’t claim this alone produced app-wide crash-free percent.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| ≤15s opener only? | “We had races on shared dictionaries — serial-queue design and trade-offs vs actors.” |
| Lesson in one line? | “Serialize mutation at the boundary — don’t sprinkle locks ad hoc.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries
- **Don’t claim:** App-wide 99.95% CFS from this path alone.

---

### Q10. Speak the three short bridges — GCD, cancel, settings

**Answer:**

> “Bridge A — GCD to actors: we serialized dictionary access with GCD. Actors are the language-native equivalent for new code: same boundary idea, compiler isolation, but revalidate after await.
>
> Bridge B — cancellation: unstructured Tasks need ownership. In search I store the Task and cancel on each query change so cancellation is product behavior, not an afterthought.
>
> Bridge C — settings humility: under Swift 6 checking when enabled, Sendable and isolation violations become errors. Default MainActor isolation is a setting, not something I assert as universal.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Which bridge for migration question? | “A — S2 to S2-A1.” |
| Which for search? | “B — S3 cancel.” |
| Which when they say ‘Swift 6 does X’? | “C — when enabled.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries; BookMyShow backend-driven header & search
- **Design if asked:** Design: actor SafeDict (not shipped)

---

## Brain puzzles (cover → think → check)

### Puzzle A — Honest or overclaim?

Interviewer: “So you fixed crash-free sessions with actors at BookMyShow?”

**Good reply:** “No. Shipped fix was GCD synchronised dictionaries on that path. Actors are how I’d design greenfield maps. Crash-free at scale is a broader reliability culture story — I won’t hang that metric on one dictionary fix.”

---

### Puzzle B — Same queue deadlock

```swift
queue.async {
    queue.sync { /* update dict */ }  // same serial queue
}
```

What happens?

**Answer:** Classic GCD deadlock — you’re waiting for the queue you’re already on. Actors don’t fail this way on `await` (they suspend), but you can still hang with `DispatchQueue.sync` from async code.

---

### Puzzle C — Returning the dictionary

```swift
func allValues() -> [String: Item] {
    queue.sync { storage }  // returns the live dictionary reference?
}
```

If `storage` is a class-backed map and you return it without copying…

**Answer:** Callers can mutate outside the queue → race again. Closed API must return a **snapshot copy** (or values), never the live interior.

---

## After this sample

1. Read [SafeDictActor.swift](../code/SafeDictActor.swift) line by line.
2. Continue to [05-system-design-mock.md](05-system-design-mock.md), then [06-module-drills.md](06-module-drills.md).
3. Speak from [`../04-questions.md`](../04-questions.md).
4. Do timed drills in [`../05-exercises.md`](../05-exercises.md).
