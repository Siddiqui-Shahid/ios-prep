# Weak points from your recorded interviews

These are **not** generic blog weaknesses. They come from **interview recordings** in `~/Movies` (audio extracted with ffmpeg, speech parsed with Whisper tiny.en). **KT** (Knowledge Transfer: onboarding/code walkthroughs) videos were ignored.

Tiny.en mis-hears names. The substance is still clear.

## How to use this on a 60–90 minute ride

Pick **one** drill. Speak the sample answer. Tap **Mark complete** on Home when you can do it without looking. Do not binge all seven on one train.

## The list

1. **45-second intro** — you started with AI / “vibe coding” instead of a crisp stack + impact.
2. **Struct vs class** — you said value types are “much more faster.” You named **COW** (Copy-On-Write) but used it backwards, and called the heap “heat memory” / **ARC** “CCR.”
3. **UITableView reuse** — you could not name `reuseIdentifier` / dequeue-by-type when asked how three cell kinds stay correct.
4. **Request model vs download** — 21 Aug: mixed a generic HTTP request type with a download task; guessed GET; offered callbacks instead of a download manager for two parallel books.
5. **Think out loud (DSA)** — 28 Aug opened with “think out loud… algorithm is fine.” You still went quiet until steered.
6. **Crashes that don’t repro locally** after a **1% phased release** (App Store gradual rollout).
7. **Rambling under pressure** — 26 Aug you asked for five minutes on SwiftUI parent→child. They said keep it short.
8. **Sendable / actors** — “Sendable makes the class aggressive” is not an answer. Compile-time isolation, not a personality trait.
9. **Coordinator + Codable** — one coordinator for “set thanks screens”; JSON models: “apart from decoder I don’t know.”

Each item has its own drill chapter. Mark each complete yourself — auto “reached last section” is not enough.
