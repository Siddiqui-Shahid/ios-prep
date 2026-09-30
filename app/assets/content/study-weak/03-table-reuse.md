# Drill — UITableView reuse

**From:** 27 Aug interview. They asked: three cell types A/B/C — how does the table know which view to reuse? Your answer stayed “dynamic / depending on cell type” without the API names.

## Keywords

- **reuseIdentifier** (string key that buckets identical cell classes).
- **dequeueReusableCell** (pull a recycled cell or create one).
- **prepareForReuse** (reset UI so the previous row does not leak into the next).
- **Diffable data source** (UIKit list updates by item id, not `reloadData`).

## Target answer (45s)

> “Each cell class registers with a reuse identifier. In `cellForRow` I dequeue with the identifier that matches that row’s type so an A cell is never filled as B. `prepareForReuse` clears images and highlights. If identifiers are wrong, you get flickering wrong layouts — that’s the bug they want named.”

SwiftUI analogue: `ForEach` **must** have stable `id`s or identity glitches look the same.
