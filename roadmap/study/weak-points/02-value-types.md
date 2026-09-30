# Drill — struct vs class (stop saying “always faster”)

**From:** 26 Aug interview. After memory, they asked **performance and when to use which**. You said value types are much faster and reference types handle “more complex data.” You mentioned copy-on-write in the same breath as “they do not have additional functions,” then heap as “heat memory” and ARC as “CCR.” That is half-true and easy to trap.

## Keywords

- **Value type** (`struct`/`enum`: copies are independent).
- **Reference type** (`class`/`actor`: shared identity).
- **COW** (Copy-On-Write: `Array`/`Dictionary`/`String` share a buffer until a unique mutation).
- **ARC** (Automatic Reference Counting: objects die at zero strong owners).

## Target answer (60s)

> “I pick struct for models because of semantics, not a speed myth. A fat struct copied in a hot loop can be slower than one class. Collections are fast because of copy-on-write, which my own types do not get for free. I use class for identity — UIKit, a shared URLSession client. I use actor when shared mutable state is hit from many tasks. `let` vs `var` is not value vs reference.”

## Trap they almost sprung

“Structs are always faster” → they can ask you to copy a 200-field struct every frame. Say **measure**, **COW**, **identity**.
