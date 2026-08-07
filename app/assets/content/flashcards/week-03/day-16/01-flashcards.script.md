# Audio script — Flashcards — Image/Video Pipelines, Caching & Memory Pressure
> Listen-only flashcard Q&A from `week-03.md`. Spoken answers.

## §0 Q1. HTTP cache

Next. HTTP cache? Answer. Not a UIImage cache — still need decode + L1 policy.

## §1 Q2. Decoded 1000×1000 ARGB

Next. Decoded 1000×1000 ARGB? Answer. ≈ 4 MB — key by url + targetSize.

## §2 Q3. Wrong image in cell

Next. Wrong image in cell? Answer. Missing cancel/token on reuse.

## §3 Q4. HeroWidget

Next. HeroWidget? Answer. Pause when off-screen / background / reuse — product contract.

## §4 Q5. Aces audio

Next. Aces audio? Answer. Not image LRU — AVAudioSession + interruptions.

## §5 Q6. BookMyShow Ads pipeline + HeroWidget lifecycle / Audio streaming + server-driven splash (Aces)

Next. BookMyShow Ads pipeline + HeroWidget lifecycle / Audio streaming + server-driven splash (Aces)? Answer. No invented fill-rate % or splash ms.
