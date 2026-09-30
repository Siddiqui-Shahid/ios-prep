# Audio script — Trip 2 — 75 min: iOS memory and types (new depth)

## §0 Introduction

Trip 2 — 75 min: iOS memory and types (new depth) New today: ARC , retain cycles, weak / unowned , actors — beyond the struct-vs-class drill. From interviews: 26 Aug already poked performance; you still need cycle examples.

## §1 Keywords

ARC (Automatic Reference Counting). Retain cycle (two strong refs keep each other alive). MainActor (UI-thread actor).

## §2 Clock

| Min | Do | |---|---| | 0–15 | Speak ARC + weak delegate | | 15–40 | Closure [weak self] vs unowned | | 40–60 | Actor vs class for a cache | | 60–75 | One Instruments sentence (Memory Graph) | Continue later: Topic “iOS memory”; Trip 3 is lists.
