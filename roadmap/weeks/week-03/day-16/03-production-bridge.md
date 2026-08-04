# 03 — Production Bridge: HeroWidget (S1) + Aces (S12)

## 1. Provenance map

| ID | Label | Exact claim |
|---|---|---|
| **S1** | Verified | Ads refactor; POP+Generics; HeroWidget pause/play on revenue-critical module |
| **S12** | Verified | Live audio streaming; server-driven splash; cold-start improvement (**no invented ms**) |
| **S10** | Soft | Inject image loader into Stories SDK |
| **S3** | Soft | Fail-soft / SDUI mindset for splash payloads |
| Learning-lab | Sketches | `code/` image cache + lifecycle |

### Forbidden

- Invented fill-rate % or splash latency ms  
- “I wrote Kingfisher” / “I invented NSCache”  
- Treating Aces audio as “we used image LRU for audio”  

## 2. S1 STAR — HeroWidget (2–3 min)

### Opener

> “I’ll walk through our highest-revenue Ads refactor — protocols, generics, and video lifecycle.”

### S/T

Highest-revenue Ads module needed safer reusable rendering; video inside HeroWidget needed correct pause/play with lifecycle.

### Action

1. Protocol-oriented ad contracts + generics pipeline.  
2. HeroWidget with explicit pause/play tied to visibility / VC lifecycle / reuse.  
3. Prevented creative-type forks.  
4. Stakeholder coordination on revenue behavior.

### Result

Maintainable typed pipeline; lifecycle-correct video reduced wasted playback and glitches. (**No fill-rate %.**)

### Lesson

Lifecycle is part of the product contract on revenue UI.

> **Provenance:** Verified · S1 · BookMyShow · Ads / HeroWidget

## 3. S12 STAR — Audio + splash (2–3 min)

### Opener

> “On Aces I’ll cover live audio streaming and a server-driven splash for cold-start freshness.”

### S/T

Need live broadcast audio and a splash that wasn’t slow/inflexible.

### Action

1. Integrated **audio streaming** for live broadcasts (session, buffering, interruption mindset).  
2. Revamped splash with **server-driven content** for freshness / flexibility.  
3. Oriented success around **time-to-interactive**, not vanity first-frame alone.

### Result

Richer live audio; faster/more flexible cold-start content. (**No invented ms.**)

### Lesson

Startup path is a product surface; audio failure modes ≠ image cache failure modes.

> **Provenance:** Verified · S12 · Raw / Las Vegas Aces

## 4. Combined ≤20s line

> “On our highest-revenue Ads surface I built HeroWidget with explicit pause/play tied to visibility — and on Aces I shipped live audio plus a server-driven splash to tighten cold start.”

## 5. Interview bridges

| Question | Hook |
|---|---|
| Design image loader | L1/L2/L3 + downsample math (Learning-lab) |
| Video off-screen | S1 HeroWidget |
| Phone call kills audio | S12 AVAudioSession interruptions |
| SDK image dependency | S10 inject loader |
| Memory graph UIImage spike | Decoded L1 / no downsample |
