# 05 — Exercises

> Do these after foundations + deep dive + production bridge. Prefer speaking out loud even for coding prompts.

---

## Exercise 1 — Mini ads pipeline `(25–35 min)`

**Prompt:** Using [`code/AdsPipeline.swift`](code/AdsPipeline.swift) as a base (or rewrite from memory):

1. Define `Creative` with `associatedtype Body` + `AdTrackable`.
2. Implement `ImageCreative` (struct) and `VideoCreative` (class + `PlaybackControllable`).
3. Implement `AdPipeline<C: Creative & AdTrackable>` with `install() -> C.Body`.
4. Add `bindPlayback` generic constrained to `PlaybackControllable`.

**Agenda to say before coding (30s):**  
> “Capabilities first — Creative and Trackable — then a generic pipeline, then video-only playback composition.”

**Done when:** You can explain why `VideoCreative` is a class while `ImageCreative` is a struct.

**Stretch:** Add `CarouselCreative` without touching `AdPipeline`’s body — only new conformance.

---

## Exercise 2 — Type eraser `(20–30 min)`

**Prompt:** Implement `AnyTrackable` as in [`code/TypeErasureDemo.swift`](code/TypeErasureDemo.swift).

1. Store `id` + `track` closure.  
2. Build `[AnyTrackable]` with two concrete types.  
3. Speak costs in ≤30s.

**Speak (≤60s) after coding:**  
> When you’d erase vs keep generics on an ads feed.

**Honesty check:** Label as Learning-lab — not shipped BMS source.

---

## Exercise 3 — Extension dispatch surprise `(15–20 min)`

**Prompt:** Reproduce the greet/wave trap from deep dive §3.2 in a playground or scratch file.

Write predicted output **before** running.  
Then fix by promoting `wave` to a protocol requirement.

**Speak (30s):**  
> “Requirements witness-dispatch; extension-only methods may bind statically.”

---

## Exercise 4 — HeroWidget lifecycle sketch `(20–25 min)`

**Prompt:**

```swift
final class HeroWidget {
    // own a VideoCreative or player façade
    // didEnterVisibleViewport / didLeaveVisibleViewport
}
```

1. Implement pause/play wiring.  
2. Conform to `PlaybackControllable`.  
3. Speak Verified · S1 Action slice in 90s tying widget to pipeline.

**Honesty check:** No fill-rate %. Lifecycle-correct video is the claim.

---

## Exercise 5 — Open vs closed registry `(20–25 min)`

**Prompt:** Sketch both:

1. `enum AdKind { case image; case video }` switch renderer.  
2. `AdRegistry` with `AdComponentFactory` protocol and unknown fallback returning a placeholder.

**Speak (90s):**  
Trade-offs; mention S3 soft + S3-A1 as design for unknown fallback.

---

## Exercise 6 — Timed speaking drill `(30–40 min)`

Record:

1. Q1 POP  
2. Q4 generics in ads  
3. Q6 type erasure  
4. T1 PAT array  
5. T5 YAGNI vs revenue  

Optional: 5 min S1 architecture dry-run.

Score with [`../../../timing/answer-timing-guide.md`](../../../timing/answer-timing-guide.md):

| Check | Pass? |
|---|---|
| Agenda in first 10s | |
| Trade-off mentioned | |
| Production hook without invented metrics | |
| Finished inside budget | |

Log misses → gotchas.

---

## Exercise 7 — Stories SDK boundary `(15 min)`

**Prompt:** Write 5 bullet API rules for a reusable Stories SDK surface (protocols vs concretes, versioning, what not to expose).

**Speak ≤20s S10 bridge** after writing.

> **Provenance:** Verified · S10 · portfolio reuse — no invented client counts.

---

## Solutions pointers

| Exercise | Look at |
|---|---|
| 1, 4 | [`code/AdsPipeline.swift`](code/AdsPipeline.swift) |
| 2 | [`code/TypeErasureDemo.swift`](code/TypeErasureDemo.swift) |
| 3 | Deep dive §3.2 |
| 5 | Deep dive §6 |
| 6 | [`04-questions.md`](04-questions.md) |
| 7 | Production bridge §4 |

---

## Exit criteria

You may mark Day 02 complete when you can, **without notes**:

- [ ] POP one-liner + capability example  
- [ ] associatedtype vs generic parameter in 20s  
- [ ] Type erasure cost in one breath  
- [ ] Extension dispatch trap named  
- [ ] ≤20s S1 pitch + ≤5 min architecture talk once  
- [ ] Honest provenance (no fill-rate invention)

Then use the revision twin:  
[`../../../revision/weeks/week-01/day-02.md`](../../../revision/weeks/week-01/day-02.md)
