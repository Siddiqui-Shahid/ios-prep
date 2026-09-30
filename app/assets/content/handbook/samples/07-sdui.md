# Sample design — Server-Driven UI

They say: “Marketing wants a home without App Review.” That is **SDUI** (Server-Driven UI: JSON describes widgets).

## Problem

A home surface of cards, banners, and CTAs that change weekly. You still need safety: no remote code execution, no blank screen on a bad payload. If you promise “the server sends Swift,” you have failed.

## Requirements (2 minutes — ask, then lock)

Client **registry**: `type` string → SwiftUI/UIKit builder. Unknown type → skip (forward compatible), log, keep the rest. Schema version on the document. Cache last-good document for offline. Analytics at the renderer (impression when actually shown). Don’t execute JS from JSON.

Confirm: “JSON widgets, skip unknown, last-good cache, no eval. Marketing can change copy and layout within the registry. OK?”

## API and data

```
GET /v1/home?surface=home
→ { schema: 3, etag, sections: [ { type, id, props } ] }
```

Props are JSON. Decode per type into a small Codable struct. Unknown keys ignored.

## iOS LLD (types and sequence)

`HomeView` → `SDUIViewModel` → `DocumentStore` + `HomeAPI` → `WidgetRegistry`.

Load: cache → paint → conditional GET. If decode of one section fails, drop that section. The home is never a spinner forever if disk has last week’s document.

Actions: `type: deeplink | request | flag`. Deep links go through the same coordinator as Universal Links. Requests use the HTTP client sample. Never `eval`.

Version: if `schema > appMax`, show a “please update” card, still render known types. Preview in debug dumps unknown types. Production: silence plus a metric.

## HLD (scale, cache, consistency)

CMS publishes JSON → CDN or API with short TTL for home (minutes, not days) because marketing is impatient. Auth personalization happens at the origin; anonymous users get a public document. Kill switch: a flag that forces a baked-in fallback layout if the CMS ships poison.

Scale: one document per surface per user segment, not one request per widget. Images still go through the image pipeline. SDUI is layout, not a second downloader.

## Tradeoffs

Full Flutter-from-JSON vs typed widgets: typed widgets are how you sleep. SDUI vs feature flags plus a few baked screens: flags are simpler until the surface is truly a CMS.

## 60-second close

“If they ask me to wrap: JSON widgets, registry, skip unknown, cache last-good, version the schema, no code execution, fallback layout if the document is poison. Marketing speed without a blank home.”
