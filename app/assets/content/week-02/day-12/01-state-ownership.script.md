# Audio script — Sample 01 — State ownership (Q&A)
> Listen-only sample Q&A from `01-state-ownership.md`. Spoken answers and follow-ups.

## §0 Q1. What is SwiftUI’s core mental model?

Next. Q1. What is SwiftUI’s core mental model? Answer. SwiftUI is a state → U I engine. You describe views as a function of state; the framework diffs and updates. Most “SwiftUI is buggy” reports are state in the wrong place or identity that resets. body is called often — that is normal. The problem is heavy work or side effects inside body, not the call frequency itself. Follow-ups. Theater metaphor?: Script = model/state; stage directions = body; actor continuity = identity.. OK in body?: Compose views from state; cheap cached formatting.. Not OK in body?: Start network; sort 10k rows; write to disk..

## §1 Q2. Where does `@State` belong?

Next. Q2. Where does `@State` belong? Answer. @State is view-owned private storage for ephemeral U I — toggle chrome, local draft text, tooltip seen flags. Lifetime is tied to view identity. Do not hoist every toggle into the view model. Pure U I chrome stays @State; async and domain state hoists to an observable model (Day 08 M V V M alignment). Follow-ups. @State vs VM for a switch?: Switch that is pure U I chrome → @State. Switch that drives network → model.. Private why?: Encapsulation — child gets @Binding if it must write.. Testability?: Domain logic in observable model / UseCase — not buried in @State only views..

## §2 Q3. When do I use `@Binding`, `@Bindable`, and Environment?

Next. Q3. When do I use `@Binding`, `@Bindable`, and Environment? Answer. @Binding: child controls need to write parent-owned state. @Bindable: bridge bindings into @Observable fields (i O S 17+). Environment: tree-wide values — theme, color scheme, layout direction — not a hidden service-locator for every NetworkClient. SDKs like S 10 prefer explicit injectable protocols over forcing host AppModel through Environment. Follow-ups. Environment for DI?: Light touch OK for theme; risky as sole hidden service locator.. @Bindable vs $ on ObservableObject?: @Bindable for Observation; $ projected values for @Published legacy.. Over-abstracting?: If not theme/locale and not shared feature state — keep it simple..

## §3 Q4. What is `@Observable` and what is the iOS 17+ caveat?

Next. Q4. What is `@Observable` and what is the iOS 17+ caveat? Answer. @Observable (Observation framework) is i O S 17+. The macro tracks property access for fine-grained invalidation. Prefer it on modern targets for feature/async screen models. Still explain ObservableObject + @Published for legacy codebases and interviews. Say aloud: “For new code on i O S 17+ I prefer @Observable; on older OS I’d use ObservableObject.” Follow-ups. Verified S 10 claim @Observable?: Forbidden as resume A P I name — teaching detail only.. Granularity win?: Changing an unread property shouldn’t invalidate a view that didn’t read it.. Monolithic model risk?: 50 fields on one observable read by root → invalidation storms — split models..

## §4 Q5. How does `@Observable` differ from `ObservableObject`?

Next. Q5. How does `@Observable` differ from `ObservableObject`? Answer. @Observable: property-access tracking, less boilerplate, @Bindable for bindings, i O S 17+. ObservableObject: often broadcasts more coarsely via objectWillChange, needs @Published, works on older OS. Interview sentence: prefer Observation on modern targets; still explain @Published when asked about legacy codebases. Follow-ups. Storm on ObservableObject?: Any @Published change may invalidate all views observing the object.. Split models fix?: Player vs chrome vs catalog — pass slices to children.. Fetch in model vs body?: Model +.task / appear — never side-effect network in body..

## §5 Q6. What are common state ownership anti-patterns?

Next. Q6. What are common state ownership anti-patterns? Answer. Every toggle in VM. Fetch inside body. One AppModel for the entire app. Environment-only NetworkClient with no test seam. God observable causing whole-screen redraws. Fix: keep chrome @State, split models, explicit init for S D K seams, Tasks on appear with cancel on disappear. Follow-ups. Whole screen redraws?: God observable — split by feature.. Stories progress desync?: Timers scattered in views — centralize in player model timeline.. Duplicate state?: Single source of truth in observable model; @State only for pure U I..

## §6 Q7. What should I be able to say after state foundations?

Next. Q7. What should I be able to say after state foundations? Answer. “SwiftUI state is either view-local @State or a feature @Observable model on i O S 17+, with ObservableObject when I must support older OS. Bindings and Environment have narrow jobs. Domain and async live in the model; body stays pure. Split observables to avoid invalidation storms.” Follow-ups. Pure U I rule?: @State. Async/domain rule?: @Observable / VM. Next topic?: Identity — 02-identity-traps.md.. Next: 02-identity-traps.md.
