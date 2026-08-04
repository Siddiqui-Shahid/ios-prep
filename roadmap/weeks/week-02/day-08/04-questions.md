# 04 — Questions (two-layer answers)

> Study flow: cover the full spoken answer → speak from **Answer points** only → uncover and compare timing.  
> Totals: **12 normal + 8 tricky = 20**.

---

## Normal questions

### Q1. Explain MVVM vs MVC. `(30–45s)`

**Answer points (frame first):**
- MVC VCs accumulate networking + state
- MVVM: View renders; VM presentation + async
- Model/domain separate
- UIKit bindings vs SwiftUI Observation

**Agenda opener:** “I’d contrast ownership, not acronyms…”

**Full spoken answer:**
> “In UIKit MVC, view controllers often accumulate networking, state, and layout — Massive View Controller. MVVM keeps the View focused on rendering and forwarding intents, while the ViewModel owns presentation state and screen-level async. The model or domain stays free of UIKit. In UIKit you bind with closures or Combine; in SwiftUI you typically observe an @Observable model. I used that split on BookMyShow search and when thinning layers during District’s migration.”

**Common wrong answer:** “MVVM means no ViewControllers.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Where does networking live? | Repository behind a protocol — not in the View. |
| L2 | UIKit without Combine? | Closures/`onStateChange` with `[weak self]`. |
| L3 | SwiftUI kill VM? | No — hoist async/domain; keep pure UI local. |

**Provenance:** Verified · S3 · search VM; Verified · S9 · migration

---
### Q2. When do you introduce Clean Architecture? `(45–60s)`

**Answer points (frame first):**
- Non-trivial or shared domain rules
- Migration seam under fat VC/VM
- Entities/UseCases independent of UI
- Don’t Clean-ify a settings toggle

**Agenda opener:** “I’d scope Clean to risk and domain…”

**Full spoken answer:**
> “I introduce Clean boundaries when domain rules are non-trivial, shared across screens, or I’m migrating safely under a fat layer. UseCases and entities stay independent of UIKit and SwiftUI; the ViewModel becomes a thin adapter that maps results to view state and still cancels tasks. I don’t Clean-ify a settings toggle — ceremony has to earn its keep. At District, Free Parking billing rules were a natural UseCase extraction while simpler chrome stayed MVVM.”

**Common wrong answer:** “Every screen should be Clean Architecture.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | How thin is the VM? | Maps UseCase output → UI state; cancels work. |
| L2 | Folders required? | No — dependency rule matters, not folder cosplay. |
| L3 | Pass-through UseCase? | Delete it; call repository from VM. |

**Provenance:** Verified · S9 · Free Parking / Clean edge

---
### Q3. What is MVI / unidirectional data flow? `(45s)`

**Answer points (frame first):**
- Intent → reduce/process → State → View
- Side effects explicit
- Great for multi-source UI
- Heavier than MVVM for CRUD

**Agenda opener:** “I’d describe the loop and when I’d pay for it…”

**Full spoken answer:**
> “MVI or unidirectional flow means the View sends Intents into a processor that produces a new immutable State, and the View renders that state. Side effects like networking are explicit and usually feed results back as Intents. It’s excellent when checkout or a live scoreboard has many async inputs fighting one screen. For simple CRUD, MVVM with an enum state machine is usually enough — I don’t pay reducer boilerplate by default.”

**Common wrong answer:** “MVI replaces MVVM everywhere.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Relation to TCA? | Same family; discuss framework vs hand-rolled trade-off. |
| L2 | Payment UI? | Enum states are cousins — S7 mindset. |
| L3 | Testing? | Replay intents; assert states. |

**Provenance:** Learning-lab · pattern judgment; cousins S7/S11

---
### Q4. How do you do DI on iOS without a container? `(45–60s)`

**Answer points (frame first):**
- Protocol boundaries
- Constructor injection
- Feature factory/assembler
- Avoid service locator for domain
- Environment carefully

**Agenda opener:** “I’d start with protocols and constructors…”

**Full spoken answer:**
> “My default is protocol boundaries with constructor injection — ViewModels and UseCases receive repositories and clients through init. A feature assembler builds the graph at the module edge. Tests inject fakes. I avoid service locators for domain dependencies. SwiftUI Environment is fine for theme and shallow UI deps, but I don’t hide the NetworkClient only in Environment for an SDK-style feature.”

**Common wrong answer:** “You must use Swinject/Needle to be senior.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Circular deps? | Split protocols; emit nav events instead of UseCase→Router cycles. |
| L2 | SDK hosts? | Explicit injectable deps — S10 mindset. |
| L3 | When a container? | When manual graph pain is real and team agrees. |

**Provenance:** Verified · S9 · testable boundaries; Learning-lab · assembler

---
### Q5. How would you structure BMS search in MVVM? `(60–90s)`

**Answer points (frame first):**
- SearchViewModel owns debounce + cancel
- State enum idle/loading/results/empty/error
- Repository hides networking
- Ranking usually server-side
- Ignore cancellation errors

**Agenda opener:** “I’d place debounce and cancel in the ViewModel…”

**Full spoken answer:**
> “I’d give SearchViewModel a query handler that debounces around 300ms, cancels the previous Task, and moves through an explicit state enum — idle, loading, results, empty, error. The View only renders state and forwards text changes. A SearchRepository returns domain models; ranking stays server-side unless product needs local filter. Cancellation must not surface as a scary error. That’s aligned with how we made BookMyShow search race-safer under MVVM.”

**Common wrong answer:** “Fire a request on every keystroke and hope.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Why debounce + cancel? | Avoid out-of-order apply; save network/battery. |
| L2 | Stale response without cancel? | Generation token / monotonic ID ignore. |
| L3 | Where debounce must not live? | URLSession/transport-only. |

**Provenance:** Verified · S3 · BMS search MVVM

---
### Q6. Fat ViewModel — smells and fix? `(45s)`

**Answer points (frame first):**
- Smells: URLs, routing, business rules, analytics dumps
- Fix: UseCase + Router + AnalyticsClient
- Extract under test first

**Agenda opener:** “I’d name smells, then extraction order…”

**Full spoken answer:**
> “A fat ViewModel mixes networking strings, routing, analytics, and business rules. The fix is extraction: UseCase for policy, Router/Coordinator for navigation, AnalyticsClient protocol for events. I extract the UseCase under characterization or unit tests first so behavior doesn’t drift — that was the spirit of District’s incremental migration.”

**Common wrong answer:** “Just split the file into extensions.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Migration order? | UseCase first, then repo/router. |
| L2 | Keep VM? | Yes — as adapter for UI state. |
| L3 | AI risk? | Generates empty layers — review checklist. |

**Provenance:** Verified · S9 · extract under migration

---
### Q7. How do View and ViewModel communicate in UIKit vs SwiftUI? `(45s)`

**Answer points (frame first):**
- UIKit: closures/Combine/delegates
- SwiftUI: @Observable/@Bindable
- State down, events up
- Watch retain cycles in UIKit

**Agenda opener:** “I’d separate binding mechanism from ownership…”

**Full spoken answer:**
> “In UIKit, ViewModels typically push state through closures, Combine publishers, or occasionally delegates for one-off events — always mind `[weak self]`. In SwiftUI, I prefer an @Observable model with @Bindable for two-way fields. Pattern is state down, events up. Observation reduces some Combine cycle footguns, but long-lived Tasks still need cancellation on disappear.”

**Common wrong answer:** “SwiftUI doesn’t use ViewModels.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Hybrid hosting? | Same VM; hosting lifecycle Day 11/S13. |
| L2 | Legacy ObservableObject? | Know @Published for interviews. |
| L3 | Cell closures? | Clear in prepareForReuse. |

**Provenance:** Learning-lab · binding; hybrid S13 adjacent

---
### Q8. How did you use AI in the District migration without losing seniority? `(60–90s)`

**Answer points (frame first):**
- Context Engineering envelope
- AI drafts migrations/tests
- Human reviews boundaries
- Never “AI wrote the app”
- Own on-call regressions

**Agenda opener:** “I’d separate accelerator from author of record…”

**Full spoken answer:**
> “At District I used Context Engineering — feeding architecture constraints, existing module patterns, and acceptance intent into Cursor/Claude/Copilot. AI accelerated scaffolding, review assistance, and XCTest/XCUITest drafts. I reviewed every boundary-sensitive diff for misplaced rules, missing cancellation, and naming. Success wasn’t lines generated; it was shipping Free Parking and migrating patterns without skipping design ownership. I never say AI wrote the app.”

**Common wrong answer:** “We let Copilot own architecture.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | What did AI get wrong? | Be ready: rules in repository / missing cancel. |
| L2 | Metric of success? | Regression rate + review quality, not LOC. |
| L3 | Vs product AI? | S9 tooling ≠ FinTrack on-device AI (S15). |

**Provenance:** Verified · S9 · Context Engineering — critical story

---
### Q9. Repository vs UseCase — difference? `(30–45s)`

**Answer points (frame first):**
- UseCase = application policy
- Repository = data policy
- VM shouldn’t know URLSession
- UseCase shouldn’t know UIKit
- UseCase may orchestrate multiple repos

**Agenda opener:** “I’d split product policy from data policy…”

**Full spoken answer:**
> “A UseCase answers what the product should do — adjust Free Parking billing under eligibility rules. A Repository answers where data comes from and how cache versus remote is applied, including DTO mapping. The ViewModel shouldn’t know URLSession; the UseCase shouldn’t know UIKit. UseCases often orchestrate multiple repositories; repositories usually shouldn’t encode billing policy.”

**Common wrong answer:** “They’re the same layer with different names.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Cache TTL where? | Repository. |
| L2 | Eligibility where? | UseCase. |
| L3 | Can VM call repo directly? | Yes for simple screens — no fake UseCase. |

**Provenance:** Verified · S9 · Free Parking policy placement

---
### Q10. How do you keep feature modules testable? `(45–60s)`

**Answer points (frame first):**
- Protocols at edges
- Pure UseCases
- Deterministic fakes
- UITests sparingly
- CI gates

**Agenda opener:** “I’d optimize for cheap tests at policy boundaries…”

**Full spoken answer:**
> “Protocols at the edges, pure UseCases, and deterministic fakes give a cheap unit-test core. I add snapshot or UI tests sparingly for critical flows. CI gates matter more than clever mocks. At District, AI-assisted XCTest/XCUITest drafts were useful only inside a review loop — theater tests that never fail when policy flips are worse than no tests.”

**Common wrong answer:** “Mock every type including value models.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Fake vs mock? | Prefer fakes with real behavior. |
| L2 | Ads parallel? | S1 protocol pipelines aid tests. |
| L3 | Flaky UITest? | Remove sleeps; wait on conditions. |

**Provenance:** Verified · S9 · XCTest/XCUITest assist

---
### Q11. Coordinator vs Router vs NavigationPath? `(45s)`

**Answer points (frame first):**
- Coordinator/Router owns cross-feature nav
- VM emits events
- SwiftUI NavigationPath at app edge
- No UINavigationController in UseCases

**Agenda opener:** “I’d keep navigation out of domain…”

**Full spoken answer:**
> “For simple pushes, the ViewModel can emit a NavigationEvent. Cross-feature flows, auth gates, and deeplinks belong in a Coordinator or Router so VMs stay testable. In SwiftUI, NavigationPath and deeplink handlers live at the app edge — Grizzlies taught deliberate ownership. UseCases must not push UIKit controllers.”

**Common wrong answer:** “Put nav in the UseCase for Clean.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Deep links? | Parse at app boundary → intent → router (S13). |
| L2 | Sheet vs push? | Product choice — S6 LE sheet. |
| L3 | Test? | Assert events, don’t push VCs. |

**Provenance:** Verified · S13 adjacent; S6 presentation choice

---
### Q12. How does architecture relate to crash-free at 30L+ DAU? `(45–60s)`

**Answer points (frame first):**
- Clear ownership reduces nil races
- Fail-soft states
- Fewer god objects
- Doesn’t replace Crashlytics/IMOC
- Blast radius thinking

**Agenda opener:** “I’d connect structure to blast radius…”

**Full spoken answer:**
> “Architecture doesn’t magically create 99.95% crash-free sessions — observability and incident process still matter. What layers buy you is smaller blast radius: fail-soft UI states, fewer god objects, and clearer cancellation so you don’t force-unwrap your way through races. At BookMyShow scale, search error states and disciplined ownership are reliability features.”

**Common wrong answer:** “If we use Clean we won’t crash.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Fail-soft example? | Search error + retry; SDUI skip unknown. |
| L2 | S8 link? | IMOC/Crashlytics complement architecture. |
| L3 | Fat VC risk? | Lifecycle + nil races under load. |

**Provenance:** Verified · S8 culture + S3 states; scale context

---

## Tricky questions

### T1. Isn’t Clean Architecture overengineering for mobile? `(90–120s)`

**Answer points (frame first):**
- Trap: binary yes/no
- Scope to domain + multi-team + migration risk
- District: UseCases where billing lived
- Counterexample screen you’d skip
- Measure ceremony vs regression cost

**Agenda opener:** “I’d refuse the binary and scope it…”

**Full spoken answer:**
> “It can be overengineering — if you wrap every toggle in entities and four empty protocols. It’s worth it when domain rules are real, multiple teams touch the module, or you’re strangling a risky legacy path. At District we extracted UseCases where Free Parking billing rules lived and left simple UI as MVVM. The senior move is measuring ceremony against regression cost, not defending a folder religion.”

**Common wrong answer:** Always Clean / never Clean.

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Show a screen you wouldn’t Clean-ify. | Settings toggle / static about page. |
| L2 | How know extraction worked? | UseCase tests fail when policy inverted. |
| L3 | Android parity? | Shared policy concepts; separate UI adapters. |

**Provenance:** Verified · S9 · scoped Clean

---
### T2. Where should debounce live — View, VM, or Repository? `(90s)`

**Answer points (frame first):**
- Presentation policy → VM or UseCase
- Repository shouldn’t know keystrokes
- Network may still cancel
- BMS: debounce in search VM

**Agenda opener:** “I’d put timing with presentation policy…”

**Full spoken answer:**
> “Debounce is a presentation policy about human typing cadence, so it belongs in the ViewModel — or in a UseCase if the product standardizes that policy across surfaces. The Repository shouldn’t know keystroke timing. The networking layer may still cancel tasks, but it doesn’t own the 300ms decision. On BookMyShow search, debounce plus cancel lived with the MVVM presentation layer so out-of-order responses couldn’t win.”

**Common wrong answer:** Only in UIControl or only in URLSession.

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Different debounce for analytics? | Separate pipelines. |
| L2 | View-level debounce? | Possible but harder to test; prefer VM. |
| L3 | Server-side debounce? | Doesn’t stop client races. |

**Provenance:** Verified · S3 · search debounce placement

---
### T3. MVVM doesn’t work with SwiftUI — discuss. `(90–120s)`

**Answer points (frame first):**
- SwiftUI wants clear state ownership
- VM/@Observable still useful for async + tests
- Don’t duplicate every @State
- Hoist async/domain; local for pure UI

**Agenda opener:** “I’d reframe as ownership, not tribalism…”

**Full spoken answer:**
> “SwiftUI doesn’t kill MVVM; it demands clearer state ownership. An @Observable ViewModel is still useful for async work, testability, and sharing screen state across child views. What fails is cloning every toggle into a VM. Prefer view-local @State for pure UI chrome and hoist async or domain state. That’s compatible with Day 12’s Observation guidance and with how I’d structure search or Free Parking screens.”

**Common wrong answer:** “Delete all ViewModels in SwiftUI.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | @Observable vs ObservableObject? | Prefer Observation in new iOS 17+ code; know legacy. |
| L2 | EnvironmentObject god bag? | Avoid — split models. |
| L3 | Test? | Test observable models in XCTest. |

**Provenance:** Learning-lab · SwiftUI MVVM; Day 12 bridge

---
### T4. How do you migrate a live app from MVC to Clean without a rewrite? `(120s)`

**Answer points (frame first):**
- Strangler pattern
- New features on new boundaries
- Extract UseCases behind old VC
- Characterization tests + flags
- Ship value while migrating — Free Parking

**Agenda opener:** “I’d describe strangler, not big-bang…”

**Full spoken answer:**
> “You don’t rewrite. You strangle: put new features on new boundaries, extract UseCases behind old view controllers, add characterization tests around risky behavior, and use feature flags for rollback. At District we shipped Free Parking value while migrating MVVM and Clean incrementally. Big-bang rewrites on live consumer apps are how you buy regressions without shipping product.”

**Common wrong answer:** Freeze the app for a quarter and rewrite.

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Rollback plan? | Keep old path behind flag. |
| L2 | What to extract first? | Highest policy risk / shared rules. |
| L3 | AI role? | Scaffold inside envelope; human owns gate. |

**Provenance:** Verified · S9 · incremental migration

---
### T5. Dependency injection frameworks on iOS — yes/no? `(90s)`

**Answer points (frame first):**
- Optional
- Manual constructor DI until graph pain
- Frameworks help large graphs
- Cost: magic/opacity
- Protocols first

**Agenda opener:** “I’d treat frameworks as optional tooling…”

**Full spoken answer:**
> “Yes or no is the wrong frame. Prefer manual constructor injection and feature factories until the object graph’s pain is real. DI frameworks can help large multi-team graphs, but they add magic and compile/runtime opacity. Protocols at boundaries come first either way. Stories SDK-style modules should expose injectable dependencies clearly to hosts rather than hiding a container.”

**Common wrong answer:** Framework advocacy without trade-offs.

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Swinject in interviews? | Discuss trade-offs; don’t require it. |
| L2 | Testing without framework? | Init fakes directly. |
| L3 | Circular registration? | Smell — split protocols. |

**Provenance:** Learning-lab · DI judgment; S10 adjacent

---
### T6. Who owns navigation — VM or Coordinator? `(90s)`

**Answer points (frame first):**
- Simple: VM emits NavigationEvent
- Cross-feature/deeplink: Coordinator
- Test via events
- No absolute rule

**Agenda opener:** “I’d split by complexity and testability…”

**Full spoken answer:**
> “There’s no absolute rule. For a simple push after a row tap, the ViewModel can emit a NavigationEvent and the view or a thin router performs it. Cross-feature flows, auth gates, and deeplinks need a Coordinator or app-edge router — otherwise you get dual stacks and untestable VMs. I test ViewModels by asserting events, not by pushing real controllers. Product choices like LE Bottom Sheet versus push stay presentation decisions with clear contracts.”

**Common wrong answer:** Always VM / always Coordinator.

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | LE sheet? | Sheet for shallow overview — S6. |
| L2 | UseCase push? | Never. |
| L3 | SwiftUI path? | NavigationPath owned at edge. |

**Provenance:** Verified · S13/S6 adjacent nav judgment

---
### T7. How do you prevent AI-generated Clean Architecture from becoming nonsense layers? `(90–120s)`

**Answer points (frame first):**
- Documented layering envelope
- Example PRs + checklist
- Human review boundaries
- Tests must fail for wrong layer
- Context Engineering = control plane

**Agenda opener:** “I’d describe the control plane…”

**Full spoken answer:**
> “You prevent nonsense with an envelope: documented layering, exemplar PRs, and a checklist — no UIKit in UseCases, no URLSession in ViewModels, no empty pass-through types. AI proposes; humans review boundaries; tests must fail when policy is inverted. Context Engineering is the control plane: if you don’t feed constraints, you get ceremony. At District that discipline let AI accelerate Free Parking and migration work without becoming author of record.”

**Common wrong answer:** Ban AI / praise AI blindly.

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Success metric? | Escaped defects + review cycle, not LOC. |
| L2 | Common AI miss? | Debounce in repo; empty protocols. |
| L3 | Junior team? | Same envelope; pair on first extractions. |

**Provenance:** Verified · S9 · AI envelope

---
### T8. Should ranking live in the search ViewModel? `(90s)`

**Answer points (frame first):**
- Usually server-side
- Client filter only if product requires
- VM maps display models
- Don’t reimplement relevance in UI

**Agenda opener:** “I’d separate relevance from presentation…”

**Full spoken answer:**
> “Relevance ranking usually belongs on the server where you have signals and can iterate without app releases. The ViewModel maps results into display models and owns UX state. Local filtering is fine for constrained product needs — like filtering an already-fetched list — but reimplementing relevance in the VM duplicates logic and drifts from Android. On a high-traffic BMS-style search, keep ranking server-side unless product explicitly needs on-device filter.”

**Common wrong answer:** Always rank on device for “senior” control.

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Offline search? | Cached index is a product decision + repo. |
| L2 | Personalization? | Server + privacy-safe client context. |
| L3 | A/B rankers? | Server experiments; client renders. |

**Provenance:** Verified · S3 · search responsibilities

---
