# Image cache tiers — cheatsheet (embedded)

```text
L1 Memory  NSCache / LRU actor     key = url + targetSize     cost ≈ w×h×4
L2 Disk    /Caches + TTL ~7d       encoded bytes              OS may purge
L3 Network URLSession (+ URLCache) HTTP bytes                 not UIImage policy
```

**Always:** downsample with ImageIO before keeping display bitmaps.  
**Never:** equate URLCache with decoded image cache.  
**Video (S1):** pause on invisible / disappear / background / reuse.  
**Audio (S12):** AVAudioSession interruptions — not bitmap LRU.
