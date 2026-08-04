# 04 — Questions (two-layer answers)

> Study flow: cover the full spoken answer → speak from **Answer points** only → uncover and compare timing.  
> Totals: **12 normal + 10 tricky = 22**.

---

## Normal questions

### Q1. @State vs @Observable — when each? `(30–45s)`

**Answer points (frame first):**
- @State local ephemeral UI
- @Observable feature/async shared state
- @Bindable for forms
- @Observable is iOS 17+
- Know ObservableObject legacy

**Agenda opener:** “I’d place state by ownership, and note the OS version…”

**Full spoken answer:**
> “I use @State for view-local ephemeral UI like chrome toggles. For feature-level async and state shared across children I use an @Observable model on iOS 17+, with @Bindable when controls write into that model. On older deployment targets I’d use ObservableObject and @Published. Stories player timeline belongs in the model; local overlay chrome can stay @State.”

**Common wrong answer:** Put everything in @State or everything in a VM.

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Legacy codebases? | Explain @Published + objectWillChange. |
| L2 | EnvironmentObject? | Avoid god bags. |
| L3 | Day 08? | MVVM still valid with Observation. |

**Provenance:** Learning-lab · iOS 17+ note; S10 player

---
### Q2. What is view identity? `(45–60s)`

**Answer points (frame first):**
- How SwiftUI recognizes same view across updates
- Structural vs explicit .id
- @State tied to identity
- Stable IDs preserve state

**Agenda opener:** “I’d define identity before blaming SwiftUI bugs…”

**Full spoken answer:**
> “View identity is how SwiftUI decides two renders are the same view. Structural identity comes from type and position; explicit identity uses .id or ForEach identifiers. @State storage follows identity — change the id and state resets. That’s why stable Stories page IDs matter and why UUID-in-body is catastrophic.”

**Common wrong answer:** Identity means Equatable views only.

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Force new identity? | Intentional reset on logout. |
| L2 | Representable? | Parent id churn remakes VC — S13. |
| L3 | S10? | Page identity must survive progress ticks. |

**Provenance:** Learning-lab · identity; S10 pages

---
### Q3. Why did my Representable reset? `(45s)`

**Answer points (frame first):**
- Parent identity changed
- id churn → remake
- Stabilize IDs
- Update props instead of recreate

**Agenda opener:** “I’d suspect identity before UIKit…”

**Full spoken answer:**
> “Usually the parent’s identity changed or an .id churned, so SwiftUI remade the representable instead of calling update. Stabilize identifiers and push prop changes through updateUIViewController. Recreate only when you truly need a fresh controller — hybrid apps feel this cost immediately.”

**Common wrong answer:** SwiftUI randomly remakes controllers.

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Day 11 link? | Hybrid hosting. |
| L2 | Players restart? | Classic remake symptom. |
| L3 | Debug? | Log make vs update counts. |

**Provenance:** Verified · S13 adjacent

---
### Q4. ForEach best practices? `(45s)`

**Answer points (frame first):**
- Stable Identifiable
- Avoid indices when reordering
- Don’t create new IDs in body
- Duplicate IDs are undefined weirdness

**Agenda opener:** “I’d treat IDs as product keys…”

**Full spoken answer:**
> “ForEach needs stable Identifiable keys from your models. Don’t use indices when rows reorder, and never mint UUID ids inside body. Duplicate IDs cause undefined weirdness. Stories pages should carry host/server ids that survive progress updates.”

**Common wrong answer:** id: \.self always.

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Value type changes equality? | Prefer explicit id property. |
| L2 | CMS lists? | Server-stable ids — Day 10. |
| L3 | Diffable cousin? | Same identity lesson UIKit. |

**Provenance:** Learning-lab · S10 pages

---
### Q5. Make a long list smooth. `(60–90s)`

**Answer points (frame first):**
- Lazy containers
- Async images
- Cheap body
- Stable IDs
- Pagination
- Avoid observing whole catalog per row

**Agenda opener:** “I’d start with lazy + identity + cheap rows…”

**Full spoken answer:**
> “Use List or LazyVStack, keep Identifiable IDs stable, make row body cheap with precomputed formatting, load images asynchronously with size budgets, paginate when needed, and don’t observe a giant catalog from every row. If it’s still janky, profile decode and main-thread work — Lazy alone isn’t a silver bullet.”

**Common wrong answer:** Only wrap in Lazy and ship.

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Instruments? | SwiftUI + Time Profiler. |
| L2 | SDK consumers? | Portfolio scale — S10 mindset. |
| L3 | Eager VStack? | Tiny lists only. |

**Provenance:** Learning-lab · list perf

---
### Q6. How do you design Stories SDK API? `(60–90s)`

**Answer points (frame first):**
- Player entry
- DataSource protocol
- Event callbacks
- Injectable image/video loader
- Versioned module
- Host supplies DTOs

**Agenda opener:** “I’d design protocols in, events out…”

**Full spoken answer:**
> “I’d expose a StoriesPlayer entry point, a data source protocol so hosts supply story groups, event callbacks for open/close/CTA, and injectable image/video loaders so networking stays host-owned where needed. The module is versioned and theming-hooked. That’s how we kept a reusable Stories SDK isolatable across portfolio apps instead of hardcoding one app’s networking.”

**Common wrong answer:** Hardcode host URLs inside the SDK.

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Why not hardcode net? | Portfolio variance + tests — S10. |
| L2 | UIKit host? | Hosting façade OK. |
| L3 | Analytics? | Callbacks; host decides Mixpanel. |

**Provenance:** Verified · S10 · public API / isolation

---
### Q7. Pause stories on background/disappear? `(45s)`

**Answer points (frame first):**
- Scene phase / onDisappear
- Pause timers & AVPlayer
- Explicit resume policy
- Same discipline as Ads video

**Agenda opener:** “I’d put pause in the model lifecycle…”

**Full spoken answer:**
> “On disappear and background scene phase I pause the player model — timers and AVPlayer — with an explicit resume policy when returning. Views shouldn’t keep rogue timers alive. It’s the same lifecycle discipline as Ads HeroWidget pause/play: media without visibility policy wastes resources and surprises users.”

**Common wrong answer:** Let stories run forever in background.

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | S1 parallel? | Yes — media lifecycle contract. |
| L2 | Hold to pause? | User intent → model.pause(). |
| L3 | S10? | SDK must expose/handle pause. |

**Provenance:** Verified · S10 + S1 cousin

---
### Q8. Environment for DI — good idea? `(45s)`

**Answer points (frame first):**
- Good for theme/shallow deps
- Bad as hidden NetworkClient locator
- SDK prefers explicit init
- Day 08 DI link

**Agenda opener:** “I’d allow Environment narrowly…”

**Full spoken answer:**
> “Environment is great for theme and layout direction. It’s a poor service locator for NetworkClient everywhere — hidden dependencies hurt tests and SDK hosts. Stories SDK should take injectable loaders through init so hosts see the graph. That matches Day 08’s constructor DI default.”

**Common wrong answer:** Put all services in Environment.

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Feature store in Environment? | OK if deliberate and scoped. |
| L2 | Testing? | Init fakes beat Environment surgery. |
| L3 | S10? | Injectable deps verified direction. |

**Provenance:** Verified · S10 · isolation; Day 08 DI

---
### Q9. Animation causes list jump — causes? `(45–60s)`

**Answer points (frame first):**
- Identity changes
- Height changes without transaction
- Diff mismatch
- Scroll position loss
- Stable IDs + scoped animation

**Agenda opener:** “I’d debug identity and height first…”

**Full spoken answer:**
> “List jumps usually come from identity changes, row height changes without a careful transaction, or scroll position loss when IDs reshuffle. Fix stable Identifiable keys, animate data changes carefully, and avoid applying animation modifiers to entire giant trees.”

**Common wrong answer:** SwiftUI scrolling is just broken.

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | .animation on root? | Scope it. |
| L2 | Images loading? | Reserve height/placeholders. |
| L3 | Stories? | Progress shouldn’t change page id. |

**Provenance:** Learning-lab · animation/identity

---
### Q10. body called often — is that a problem? `(45s)`

**Answer points (frame first):**
- Frequent calls expected
- Problem is heavy work inside
- Keep body cheap
- No side effects
- Move work to model

**Agenda opener:** “I’d normalize frequent body, attack cost…”

**Full spoken answer:**
> “body being called often is normal — SwiftUI diffs descriptions. It becomes a problem when body does heavy formatting, sorting, or side effects like networking. Keep body cheap and pure-ish; precompute in the model. Fetching in body is an interview classic fail.”

**Common wrong answer:** Cache body manually with ugly globals.

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Logging body? | Debug counts OK; don’t ship noise. |
| L2 | Observation? | Depend on fewer properties. |
| L3 | AnyView? | Can obscure optimization. |

**Provenance:** Learning-lab · performance classic

---
### Q11. Cross-app reuse challenges for Stories? `(45–60s)`

**Answer points (frame first):**
- Theming
- Analytics hooks
- Media formats
- Nav/CTA exits
- Dependency versions
- Protocols + defaults

**Agenda opener:** “I’d list variance, then seams…”

**Full spoken answer:**
> “Portfolio reuse hits theming, analytics, media formats, how CTAs exit into host navigation, and dependency versions. You solve it with protocols, sensible defaults, and a versioned module — not by forking the SDK per team. That’s the modularity lesson behind the Stories SDK adoption across apps.”

**Common wrong answer:** Copy-paste and rename HeatStories.

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | SPM preview? | Day 15 modularization. |
| L2 | Breaking API? | Semantic version + migration notes. |
| L3 | S10? | Portfolio reuse verified. |

**Provenance:** Verified · S10 · portfolio reuse

---
### Q12. SwiftUI + SDUI registry? `(45–60s)`

**Answer points (frame first):**
- Registry returns SwiftUI views by type
- Leaves dumb
- VM owns payload
- Identity from server id

**Agenda opener:** “I’d keep leaves dumb and ids stable…”

**Full spoken answer:**
> “An SDUI registry can return SwiftUI views keyed by type while the ViewModel owns payload lifecycle. Keep leaf views dumb. Give each node a server-stable id so ForEach identity doesn’t break when CMS inserts content — same identity rules as Stories pages.”

**Common wrong answer:** Use array indices for CMS nodes.

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Day 10? | Unknown skip still applies. |
| L2 | Observation? | Observe document model, not each leaf service. |
| L3 | S3? | Header components as leaves. |

**Provenance:** Day 10 crossover · S3

---

## Tricky questions

### T1. I put UUID in .id inside body — why is state broken? `(90s)`

**Answer points (frame first):**
- New identity every render
- Resets @State
- Remakes children
- IDs must be stable model keys
- UUID ok only if stored once on model

**Agenda opener:** “I’d explain identity lifetime…”

**Full spoken answer:**
> “UUID() inside body creates a brand-new identity on every evaluation. SwiftUI treats it as a different view, so @State resets, animations restart, and representables remake. IDs must be stable model keys. A UUID is fine only if the model created it once and stored it — not if you mint it while rendering.”

**Common wrong answer:** Blame SwiftUI bugs.

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | When UUID ok? | Created once, stored on model. |
| L2 | Stories? | Server/host page ids. |
| L3 | Intentional reset? | .id(sessionID) on logout. |

**Provenance:** Learning-lab · identity trap

---
### T2. One @Observable AppModel for everything. `(90–120s)`

**Answer points (frame first):**
- Broad invalidation
- Tight coupling
- Split by feature
- Pass slices
- SDK mustn’t depend on host AppModel

**Agenda opener:** “I’d reject the god object…”

**Full spoken answer:**
> “A single AppModel is convenient until every property change invalidates half the UI and every feature couples together. Split by feature, pass slices into children, and never make a Stories SDK depend on the host’s AppModel. Observation’s granularity helps only if you don’t stuff the universe into one type.”

**Common wrong answer:** Convenient architecture forever.

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | S10 isolation? | SDK protocols, not AppModel. |
| L2 | Migration? | Extract feature models incrementally. |
| L3 | EnvironmentObject same sin? | Yes — god bag. |

**Provenance:** Learning-lab · S10 isolation

---
### T3. LazyVStack still janky. `(90–120s)`

**Answer points (frame first):**
- Profile image decode
- Main-thread JSON
- Overlapping observations
- Complex effects
- Unbounded prefetch
- Fix data path

**Agenda opener:** “I’d profile beyond the container…”

**Full spoken answer:**
> “If LazyVStack still janks, the container isn’t the only culprit. I’d profile image decode, main-thread parsing, overlapping observations, expensive materials/shadows, and unbounded prefetch. Fix the data path and observation scope. Switching to List without fixing decode often changes nothing meaningful.”

**Common wrong answer:** Only ‘use List instead.’

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Week 3? | Image pipeline. |
| L2 | Instruments? | Time Profiler + SwiftUI. |
| L3 | Prefetch? | Day 11 budgets. |

**Provenance:** Learning-lab · perf

---
### T4. Should Stories SDK be SwiftUI-only? `(90s)`

**Answer points (frame first):**
- SwiftUI-first OK
- UIKit hosting façade for legacy
- Public API shouldn’t force nav paradigm
- Hosts vary

**Agenda opener:** “I’d be SwiftUI-first, not SwiftUI-only dogma…”

**Full spoken answer:**
> “SwiftUI-first is fine if hosts can host it, but a portfolio SDK should offer a UIKit façade via UIHostingController for legacy screens. The public API shouldn’t force one navigation paradigm — Grizzlies-style hybrid hosts need flexibility. Being SwiftUI-only without an escape hatch slows adoption.”

**Common wrong answer:** Binary SwiftUI-only forever.

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | S13? | Hybrid hosts embed SDK. |
| L2 | API surface? | Player + data source unchanged. |
| L3 | Tests? | Model tests don’t need UI. |

**Provenance:** Verified · S10 + S13 host reality

---
### T5. Equatable View conformance — worth it? `(90s)`

**Answer points (frame first):**
- Useful for expensive rare-changing subtrees
- Don’t sprinkle early
- Prefer smaller observed state
- Measure first
- Know Observation interaction

**Agenda opener:** “I’d treat it as measured micro-opt…”

**Full spoken answer:**
> “Equatable View can help expensive subtrees that rarely change, but sprinkling it everywhere early is noise. Prefer narrowing observation first. Measure before and after. Understanding how Observation already tracks accesses matters more than ritual Equatable.”

**Common wrong answer:** Micro-optimize all views on day one.

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | When yes? | Heavy chart leaf, rare updates. |
| L2 | When no? | Simple Text rows. |
| L3 | AnyView? | Usually worse for clarity. |

**Provenance:** Learning-lab · micro-opt

---
### T6. How do you test SwiftUI state logic? `(90s)`

**Answer points (frame first):**
- Test observable models/UseCases in XCTest
- Snapshots optional
- UITests for critical open/close
- Avoid sleepy flaky tests

**Agenda opener:** “I’d test the model first…”

**Full spoken answer:**
> “I unit-test observable models and UseCases in XCTest — that’s where Stories phase transitions and pause rules live. Snapshots are optional for chrome. UITests cover critical open/close paths only. Flaky sleep-based UITests are a smell — same testing culture as District’s review gates.”

**Common wrong answer:** Only UITests.

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | S9 link? | Tests as gate, not theater. |
| L2 | ViewInspector? | Optional aid. |
| L3 | Async? | Swift Testing / XCTest async. |

**Provenance:** Learning-lab · S9 culture applied

---
### T7. Progress bar desyncs when paging stories. `(90–120s)`

**Answer points (frame first):**
- Single timeline in model
- View renders progress
- Page identity mustn’t reset timer state
- Pause/resume explicit
- State machine > scattered onAppear timers

**Agenda opener:** “I’d centralize time in the model…”

**Full spoken answer:**
> “Desync usually means multiple timers or identity resets mid-page. Keep a single timeline in the player model; views only render progress. Page identity must stay stable across ticks. Pause and resume are explicit events. Scattered onAppear timers are how progress bars lie.”

**Common wrong answer:** Add more timers in views.

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Advance on complete? | Model.advance(). |
| L2 | Hold gesture? | pause()/resume(). |
| L3 | S10? | SDK owns this correctness. |

**Provenance:** Learning-lab · S10 player

---
### T8. Host app injects different image pipelines. `(90s)`

**Answer points (frame first):**
- ImageLoading protocol in SDK
- Hosts adapt
- Default implementation optional
- Same DI lesson as networking

**Agenda opener:** “I’d inject loaders at the boundary…”

**Full spoken answer:**
> “The SDK defines an ImageLoading protocol; hosts adapt their pipeline — whether custom URLSession or a library — and a default can ship for demos. That preserves isolation from app-specific networking and keeps tests fakeable. It’s the same DI lesson as Day 08/09: protocols at boundaries.”

**Common wrong answer:** SDK bundles one library only, forever.

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Video? | Separate VideoLoading protocol. |
| L2 | S10? | Isolation where possible — verified. |
| L3 | Versioning? | Protocol evolution carefully. |

**Provenance:** Verified · S10 · injectable isolation

---
### T9. @Observable is iOS 17+ — how do you talk deployment? `(60–90s)`

**Answer points (frame first):**
- State the caveat
- Observation for modern targets
- ObservableObject for older
- SDK may abstract observation
- Don’t pretend macros run on iOS 15

**Agenda opener:** “I’d lead with the version constraint…”

**Full spoken answer:**
> “I’d say explicitly: @Observable and the Observation framework need iOS 17+. For an app still supporting earlier OS versions, I’d use ObservableObject or isolate Observation behind availability. A portfolio SDK might keep models observation-agnostic with callbacks, or offer dual bindings. Pretending macros work on iOS 15 is how interviews catch you.”

**Common wrong answer:** Ignore deployment targets.

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Availability? | if #available / separate types. |
| L2 | Interview? | Know both stacks. |
| L3 | S10 hosts? | Portfolio OS matrices differ. |

**Provenance:** Learning-lab · version honesty

---
### T10. How does Stories SDK avoid becoming a mini-app? `(90s)`

**Answer points (frame first):**
- Narrow public API
- No host AppModel dependency
- Callbacks for nav exits
- Theming hooks not full design system fork
- Version boundaries

**Agenda opener:** “I’d keep the SDK a player, not a platform…”

**Full spoken answer:**
> “A Stories SDK goes wrong when it absorbs navigation, networking, analytics, and design systems. Keep a narrow public API, injectable loaders, callbacks for CTA/nav exits, and theming hooks without forking the host design system. Version the module. That’s how reuse stays leverage instead of a second app inside the app.”

**Common wrong answer:** SDK owns entire fan engagement stack.

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | S10 lesson? | API + independence. |
| L2 | Feature creep? | Host feature flags outside SDK. |
| L3 | Live scoreboard? | Different module — S11. |

**Provenance:** Verified · S10 · modularity judgment

---
