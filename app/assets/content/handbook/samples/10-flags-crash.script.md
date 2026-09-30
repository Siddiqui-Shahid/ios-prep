# Audio script — Sample design — feature flags, kill switches, crashes

## §0 Introduction

Sample design — feature flags, kill switches, crashes Two prompts that show up after a production story. You already had the 1% phased-release round. This page is how you design the systems, not only the war story.

## §1 Problem A — flags

Product wants A/B and a kill switch (turn off a crashing module in minutes) without waiting for App Review. If flags require a network round trip before first paint, the home is a spinner on the train.

## §2 Requirements (flags)

Remote config plus local cache so launch works offline. Eval is synchronous on the render path — no network in body . Bucket from the server (stable user id hash), not a coin flip each launch. Phased App Store percent and server flags together.

## §3 API / LLD / HLD (flags)

GET /v1/config → { flags, experiments, etag } FlagStore loads disk in didFinishLaunching before first frame. Refresh in background. Change notifies observers; don’t swap a payment SDK mid-charge. Kill switch: boolean checkout v2 enabled . Ops can flip without a binary. A/B: deterministic hash of userId + experimentId. Exposure event when the UI actually shows.

## §4 Problem B — crash reporting

They say: “Design crash reporting.” Or they say: “1% rollout is crashing and it isn’t on your desk.” A handler writes a minidump carefully, not a full upload on the crashing thread. dSYM (debug symbols) on the server for symbolication. A breadcrumb ring buffer (last N actions). OOM / Jetsam often has no Swift stack — MetricKit / Jetsam clusters, not catch . Upload on next launch. Signal-safe path: write file. Next cold start: upload, then run as usual. Never block the crashing thread on network. Breadcrumbs live in memory, flush periodically to disk so the last tap survives. Ops speech you already know: pause the phased release , slice by OS/device, symbolicate, kill switch, then hotfix. Design and ops are the same story.

## §5 Tradeoffs

Firebase vs in-house: interview the pipeline, not the logo. Sample 100% of crashes, 1% of debug logs. Flags that require a restart vs hot: restart is safer for linking native code.

## §6 60-second close

“If they ask me to wrap flags: disk-backed config, sync eval, server kill switch, sticky buckets. If they ask crashes: minidump off the dying thread, dSYM, breadcrumbs, upload next launch, pause the 1% ramp before you hero-hotfix.”
