# Prototype — 10–15 minute overflow sketch (not a 90-minute build)

The ride only has **optional tiny overflow**. You will **not** ship an app on the train. If Trip A–E still have 10–15 minutes, do this. Otherwise skip.

## Definition of done (overflow)

Say out loud, or type only if a laptop is already open:

1. `Item: Identifiable, Codable`
2. `LoadState` enum: idle / loading / loaded / failed
3. `HTTPClient` protocol + fake
4. Cache then network
5. What you would add tomorrow: SQLite, images, 401 **single-flight** (one shared refresh `Task`)

If you name those five, the overflow is **won**. Styling is failure.

## Pick one sketch

- **P1 list:** stale-while-revalidate (show cache, then refresh).
- **P2 images:** `actor ImageLoader` + cancel on disappear.
- **P3 checkout:** enum steps + disable double tap.
- **P4 SDUI:** unknown `type` skipped (forward compatible).

Full Swift skeleton is the next chapter — read it at home, not instead of the 30 questions.
