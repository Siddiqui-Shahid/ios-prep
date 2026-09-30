# Audio script — Interview checklists (no outside search)

## §0 Introduction

Interview checklists (no outside search) Print this page in your head. If a term is bold, the parenthesis is the definition.

## §1 45-second iOS basics checklist

- [ ] Struct vs class vs actor vs enum - [ ] ARC, weak, unowned, cycle example - [ ] GCD vs async/await vs MainActor - [ ] Codable + URLSession shared session - [ ] 16.7ms frame budget; decode off main

## §2 45-minute mobile design checklist

- [ ] Clarify DAU, offline, platforms - [ ] Draw client + CDN + API + cache + DB + push - [ ] Cursor pagination - [ ] Cache L1/L2 - [ ] Consistency sentence - [ ] Two deep dives - [ ] Metrics + feature flag + failure

## §3 LLD checklist

- [ ] Layers: View → VM → Repo → Client → Store - [ ] LoadState enum - [ ] Sequence 8+ steps - [ ] 401 single-flight refresh - [ ] Tests: fake HTTPClient

## §4 Do / don’t

| Do | Don’t | |---|---| | Timebox and say the agenda | Design Kubernetes for a list app | | Admit trade-offs | Invent production QPS you didn’t measure | | Use mobile constraints | Ignore offline on a travel-related product | | Cursor pagination | page=5 for a live feed | | Keychain for tokens | JWT in UserDefaults |

## §5 Feature flag one-liner

“Flags let us ship dark and kill a crashing path without waiting App Review. Experiments need a stable user bucket from the server.”

## §6 Token refresh one-liner

“A 401 fans in to one refresh Task. Waiters retry once. Failed refresh logs out. Tokens live in Keychain, not UserDefaults.”

## §7 Pagination one-liner

“Opaque cursor, stable under inserts. Offset pagination duplicates or skips when the feed moves.”
