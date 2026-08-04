# 05 — Exercises

## A. Conceptual

### A1. Ownership placement
Assign: search query debounce state; button pressed highlight; Stories progress; app theme color.

**Solution:** debounce → observable VM; highlight → @State; progress → player model; theme → Environment.

### A2. T/F
1. @Observable works on iOS 15.  
2. UUID in .id inside body is fine.  
3. Eager VStack of 5k rows is OK.  
4. Stories page ids should be stable.  
5. Environment is ideal for all DI.

**Solution:** 1F (iOS 17+) 2F 3F 4T 5F

### A3. Provenance rewrite
> “I shipped @Observable Stories across 12 apps and cut jank 70%.”

**Solution:** “I designed a reusable Stories SDK with a clear public API and isolation from app-specific networking where possible, adopted across portfolio apps. I’m not claiming an @Observable resume bullet, an exact app count of 12, or a 70% jank metric.”

## B. Coding

### B1. StoriesPlayerModel
Trace pause on disappear; why progress lives in model.

**Solution:** handleDisappear → pause; single ticker; views render progress.

### B2. IdentityTraps
Speak UUID trap in 30s from `explainUUIDTrap()`.

### B3. LazyListNotes
Write a 60s list-perf answer from `interviewParagraph`.

## C. Speaking
S10 20s; S10 2–3m; T1 UUID 90s; T2 AppModel 120s; T9 iOS 17 caveat 60s.

## D. Whiteboard
SDK boundary: DataSource, loaders, events, state machine; mark pause signals.

## E. Timed drill
Q2, Q6, Q5 + T1, T2. Timing guide. Log identity + observation scope misses.

## F. Flashcards

| Front | Back |
|---|---|
| @State | Local UI · Trap: async everywhere |
| @Observable | Feature model · iOS 17+ |
| Identity | Stable ids · Trap: UUID body |
| Lazy | Large lists · Trap: eager thousands |
| body | Cheap · Trap: fetch in body |
| S10 API | DataSource + events + inject |
| Pause | Scene/disappear · S10/S1 |
| God model | Split · Trap: AppModel |

## G. Deeper
1. Write intentional `.id(sessionID)` logout rationale.  
2. Map Day 10 SDUI node id → ForEach.  
3. Contrast S9 AI tooling vs S10 SDK modularity in one paragraph (different stories!).


## H. Scenario drills

### H1. Logout form reset
Explain intentional `.id(userSessionID)` vs accidental UUID.

### H2. Portfolio theming
List 4 theming hooks a Stories SDK might expose without owning the host design system.

**Solution ideas:** primary tint, font provider, corner radius token, progress track colors.

### H3. Observation availability matrix
| Host min iOS | Approach |
|---|---|
| 17+ | @Observable player |
| 15–16 | ObservableObject or callback model |
| Mixed | Availability wrappers / dual modules |

### H4. Progress desync repro
Steps: mint new page id each tick → observe reset. Fix: stable id; progress field separate.

### H5. 45s contrast
S9 = AI tooling envelope at District. S10 = SDK modularity at Raw. Do not conflate.
