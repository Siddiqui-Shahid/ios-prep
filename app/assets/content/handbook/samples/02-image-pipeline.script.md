# Audio script — Sample design — image loading library

## §0 Introduction

Sample design — image loading library They say: “Design the image loader for our iOS app.” This is not Kingfisher trivia. This is memory, cancellation, and not decoding 4K on the main thread.

## §1 Problem

Every feed cell, avatar, and hero wants a URL → pixels. Twenty cells appear at once. The user scrolls. Cells reuse. Radio is LTE in a tunnel.

## §2 Requirements

- Display size is known (cell width × scale). Never cache a 4000px camera JPEG decoded at full size for a 40pt avatar. - Cancel when the cell leaves. - Coalesce: twenty cells with the same URL share one download. - Memory warning: drop L1. - Disk: hashed files. OS may purge /Caches . - Auth: optional signed CDN URLs that expire — refresh, don’t log the query string.

## §3 API and data

The library is not REST. The app still hits: GET {cdnUrl} → bytes Your public API: swift func image(url: URL, targetSize: CGSize) async throws - UIImage Key = url.absoluteString + targetSize . Two sizes, two L1 entries. Same URL for avatar and hero must not collide.

## §4 iOS LLD

Pipeline, left to right: 1. L1 NSCache — cost = width × height × 4 (ARGB8888). Responds to memory warnings. 2. In-flight map URL+size → Task — coalesce (one download, many waiters). 3. L2 disk — file named by hash. Check before network. 4. Network — shared URLSession . Not URLSession() per cell. 5. Decode + downsample on a background queue / Task.detached . Then hop to MainActor to assign UIImageView / SwiftUI. UITableView reuse: in prepareForReuse cancel the Task and clear the image so a slow download cannot stamp the wrong row. This is the drill they already burned you on: reuse is not optional poetry. Sequence, cache hit: cell asks → L1 → paint. Miss: L2 decode to target size → L1 → paint. Miss: network → write L2 → decode → L1 → paint. Main thread: layout and assigning the image. Not inflate, not downsample.

## §5 HLD

Images live on a CDN . App origin never serves original camera files to the list. Thumbnails are resized at the edge or via an image proxy ( w= , q= ). That is the scale story: you do not pull 8 MB JPEGs for a grid. TTL on CDN is long for immutable hashes ( /img/{contentHash} ). If the URL is the same forever for a changing avatar, you have a cache-busting problem — add a version query the CDN understands.

## §6 Tradeoffs

- SDWebImage / Kingfisher vs in-house: in an interview, design the pipeline. In production, don’t rewrite it unless you have a reason (auth, metrics, downsample policy). - Write-through L2 vs write-around: decoded bitmaps do not go to disk as raw ARGB; disk stores compressed bytes. - Prefetch next three URLs in a feed. Not the whole timeline.

## §7 60-second close

“If they ask me to wrap: three tiers, coalesce by URL and size, cancel on reuse, downsample off main, cost the cache in decoded bytes. A thousand-by-thousand image is four megabytes in RAM. I will not keep camera originals in a table.”
