# 02 — Deep Dive: Schema, Registry, Fallbacks, Cold Start, Parity

> Senior depth. Assumes [01-foundations.md](01-foundations.md). Self-contained.

## 1. End-to-end data flow

```text
┌─────────────┐  fetch   ┌────────────────┐
│ Header/Splash│ ───────► │ SDUI Repository │
│ ViewModel    │          └────────┬───────┘
└─────────────┘                   │ network or cache
                                  ▼
                          ┌────────────────┐
                          │ Version gate   │  reject → FallbackEngine
                          └────────┬───────┘
                                   │ ok
                                   ▼
                          ┌────────────────┐
                          │ Parser / tree  │
                          └────────┬───────┘
                                   ▼
                          ┌────────────────┐
                          │ Registry walk  │  unknown → skip + metric
                          └────────┬───────┘
                                   ▼
                          ┌────────────────┐
                          │ Native views   │  + ActionHandler (allowlist)
                          └────────────────┘
```

### Responsibilities

| Piece | Owns | Does not own |
|---|---|---|
| ViewModel | Fetch/cache UI state; loading/error | Component drawing details |
| Repository | Network + disk cache policy | Business checkout rules |
| Version gate | Compatibility decision | Visual design |
| Registry | type → native factory | Networking |
| ActionHandler | Allowlisted side effects | Arbitrary script exec |
| FallbackEngine | Defaults / last-known-good | Inventing new component types |

## 2. Schema shape (illustrative)

```json
{
  "schemaVersion": 3,
  "id": "home_header",
  "root": {
    "type": "vstack",
    "children": [
      { "type": "logo", "props": { "style": "primary" } },
      { "type": "promoBanner", "props": { "title": "Weekend deals" },
        "action": { "type": "open_deeplink", "payload": { "url": "bms://offers/weekend" } } },
      { "type": "sparkle_v9", "props": {} }
    ]
  }
}
```

Client with registry `{vstack, logo, promoBanner}`:

- Renders logo + promo
- Skips `sparkle_v9`
- Emits `unknown_component` metric with type name + schemaVersion

## 3. Version gate mechanics

See [code/SchemaVersionGate.swift](code/SchemaVersionGate.swift).

| Case | Gate result | UI |
|---|---|---|
| `payload.version <= clientMax` and `>= clientMin` | accept | Render |
| `payload.version > clientMax` | reject_too_new | Fallback |
| `payload.version < clientMin` | reject_too_old | Fallback or force-upgrade messaging (product) |
| Missing version on legacy payload | treat as v1 policy | Documented default |

**Dual-publish:** Backend serves old and new majors during transition; clients advertise capability. Don’t force-upgrade 30L users for a banner experiment.

**Additive fields:** Old clients ignore unknown keys. Prefer additive evolution; reserve majors for structural breaks.

## 4. Component registry

See [code/ComponentRegistry.swift](code/ComponentRegistry.swift).

### Design rules

1. **Fail soft on unknown** — never `fatalError` on CMS strings.
2. **Validate known props strictly** — bad props on a *known* type may skip that node or use safe defaults (pick a policy; be consistent).
3. **Stable identity** — each node should carry a server `id` for SwiftUI identity / analytics (Day 12 link).
4. **Keep leaves dumb** — registry returns views; VM owns payload lifecycle.
5. **App vs SDK ownership** — app-specific header components in app module; shared primitives can live in a UI kit. Stories SDK lesson (S10): clear public API if shared.

### Partial failure vs empty root

Skipping children is fine. If the **root** resolves to nothing meaningful (no logo on splash, no header chrome), engage **hard fallback**. Skipping forever without metrics hides broken contracts.

## 5. FallbackEngine

See [code/FallbackEngine.swift](code/FallbackEngine.swift).

| Layer | When | Risk |
|---|---|---|
| Memory cache | Fast revisit | Process death loses it |
| Disk last-known-good | Offline / 5xx / parse fail | Stale content — TTL + version stamp |
| Baked default | No cache | Less fresh; always safe |
| Feature flag kill | Bad schema in wild | Disable SDUI surface → native default |

**TTL + freshness:** Optional “updated earlier” affordance if product needs honesty. Splash often prioritizes **fast safe paint** over perfect freshness — with timeout to default.

**Cache keying / privacy:** Personalized headers must key by user/session; clear on logout. Don’t leak user A’s promo into user B’s disk slot.

## 6. Actions & security

```text
ActionHandler.handle(action)
  → type in allowlist?
      no  → metric + return
      yes → validate payload (URL host, deeplink scheme)
          → dispatch to Router / Safari / refresh
```

| Action type (examples) | Notes |
|---|---|
| `open_deeplink` | App schemes only; router owns nav (S13) |
| `open_url` | HTTPS + domain policy; prefer in-app browser |
| `refresh_module` | Re-fetch payload |
| `custom_js` | **Never** |

Tie to Day 09: domain whitelist mindset for anything that leaves the app.

## 7. Analytics in SDUI

Server may attach `analytics: { event, params }`. Client should:

- Validate event names against allowlist or prefix rules
- Inject common context (screen, app version, user bucket)
- Refuse to log unchecked PII from CMS

Don’t trust CMS as a raw logging pipe.

## 8. BMS header (S3) — architecture reading

Verified claims:

- Protocol-driven generalised main-screen header from backend/CMS
- Contracts so many layout/content changes don’t need App Store
- Search MVVM sibling (Day 08)

Senior elaboration (honest):

- Registry + fail-soft are how you keep CMS velocity from becoming crash velocity
- **S3-A1:** schema versioning + unknown-component fallback as the design you’d insist on — even if resume doesn’t name a “VersionGate” type

**Limits:** New component *types* still need a client release. SDUI is not infinite flexibility.

## 9. Aces splash (S12) — cold start reading

Verified: server-driven splash; cold-start flexibility/freshness; audio streaming companion work. **No invented milliseconds.**

Design checklist for splash SDUI:

1. Prewarm / read disk cache on launch path
2. Network fetch with **short timeout** → default if slow
3. Minimum viable tree (logo / brand) if partial skip
4. Don’t serialize audio init *and* splash network on one blocking main-thread chain
5. Measure time-to-interactive, not only first frame

**Interview line:** “Startup is a product surface — cached splash with timeout-to-default beats blocking on perfection.”

## 10. iOS / Android parity

| Practice | Why |
|---|---|
| Shared schema spec | One contract |
| Capability negotiation | Temporary gaps OK |
| Contract tests per platform registry | Catch drift in CI |
| Server targeting | Don’t send iOS-only types to old Android blindly |
| Dual-publish rules | Breaking changes need runway |

Parity is **negotiated**, not hoped.

## 11. Testing SDUI

| Test | Catches |
|---|---|
| Fixture per schema version | Decode + gate |
| Registry unit tests | Known types render/factory |
| Chaos payload (unknown types) | Skip path / no crash |
| Empty root fixture | Hard fallback |
| Action allowlist tests | Unknown action no-op |
| Snapshot critical layouts | Visual chrome |
| Few XCUITest golden paths | Launch → header visible |

Don’t try to UITest every CMS combination — combinatorial explosion.

## 12. SDUI vs feature flags vs A/B

| Tool | Changes |
|---|---|
| Feature flag | Code path on/off |
| A/B assignment | Variant bucketing |
| SDUI | Layout/content via payload |

Often combined: flag enables SDUI surface; CMS/A/B supplies variant layout.

## 13. When SDUI is a bad idea

- Highly interactive unique UI with heavy custom animation
- Strong one-off a11y requirements hard to schema
- Rarely changing surfaces
- Team without schema QA / contract tests
- Revenue video lifecycle that needs native pause/play guarantees (S1 HeroWidget) — use SDUI for config/placement, keep media native

## 14. Performance notes

- Parse **off main** when payloads grow
- Budget interaction frames; prewarm splash cache
- Incremental render if tree is large
- Image props still go through a bounded image pipeline (Week 3)

Parser-on-main dropping frames is an NFR bug, not “JSON’s fault.”

## 15. Trade-off tables

| Choice | When | Cost |
|---|---|---|
| Full SDUI home | Super-app experiment velocity | QA matrix explosion |
| Hybrid slots + native chrome | Most consumer apps | Slot contract discipline |
| Native-only | Rare change / regulated | Slow iteration |
| Skip unknown | Always for resilience | Visual gaps — measure |
| Disk cache splash/header | Cold start + offline | Stale risk — TTL + version |
| WebView island | Docs/legal | Perf/a11y/brand trade-offs |

## 16. Whiteboard script (5 min) — Mock #2 style

1. Draw schema → gate → registry → actions → fallback
2. State unknown-component policy
3. Map BMS header + Aces splash
4. Call out S3-A1 versioning as design
5. Contrast native Ads media if asked

Agenda:

> “I’ll define schema + registry + versioning + fail-soft, then map to BMS header and Aces splash, then trade-offs vs native Ads.”

## 17. Failure modes

| Failure | Mitigation |
|---|---|
| Breaking schema to 100% users | Version gate + canary + fallback + kill switch |
| Blank splash | Minimum tree + hard fallback |
| Personalized cache leak | User-keyed cache; clear on logout |
| Action open any URL | Allowlist + host policy |
| Silent skip spike | Alert on `unknown_component` rate |
| Main-thread parse jank | Background parse + budget |

## 18. Decision rule card

```text
1. Dynamic content/layout need + native quality? → SDUI hybrid
2. Always: version gate + unknown skip + fallback
3. Actions allowlisted; no script exec
4. Splash: cache + timeout default
5. New types need app release; CMS isn’t infinite
6. Speak S3 verified; S3-A1 as design
```

## 19. Optional citations (appendix)

- In-repo: `ios-system-design/docs/sdui-engine.md`, `feature-flag-system.md`, `ab-testing-experimentation-sdk.md`
- Apple: native view performance / accessibility guidance (not required to study)

## 20. Bridge

Next: [03-production-bridge.md](03-production-bridge.md) — S3, S12, S3-A1 honesty.
