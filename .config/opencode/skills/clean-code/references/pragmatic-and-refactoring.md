# Pragmatic Programmer & Refactoring

## Pragmatic Programmer

- **DRY**: one authoritative representation of each piece of knowledge — but
  duplication is cheaper than the *wrong* abstraction (rule of three).
- **Orthogonality**: decoupled components; a change in one shouldn't ripple.
- **Tracer bullets / prototypes**: get an end-to-end thin slice working, then grow.
- **Don't live with broken windows**: fix small rot early (Boy Scout Rule, within reason).
- **Design by contract**; fail fast; crash early rather than corrupt state.
- Program deliberately — don't rely on coincidence; know *why* it works.

## Refactoring (Fowler)

- Refactor in small, behaviour-preserving steps behind green tests.
- Watch for smells: long function, large class, feature envy, primitive
  obsession, shotgun surgery, divergent change, data clumps.
- Prefer extract-function/-module and replace-conditional-with-polymorphism over
  sprawling conditionals.
