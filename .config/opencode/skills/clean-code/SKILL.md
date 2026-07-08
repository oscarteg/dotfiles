---
name: clean-code
description: Use when writing or refactoring any code — the baseline craft rules distilled from Clean Code, Clean Architecture, The Pragmatic Programmer, Refactoring, and A Philosophy of Software Design. Bias toward simplicity, clear naming, small focused units, and dependencies pointing at abstractions.
---

# Clean Code

Baseline craft for all code. This encodes Oscar's `AGENTS.md` philosophy
(simplicity first, YAGNI, DRY with judgment, explicit over clever, composition
over inheritance, surgical changes) with the reasoning from the canonical books.
When a rule here conflicts with the surrounding code's established style, match
the code and mention the discrepancy — don't silently reformat.

## Naming (Clean Code)

- Intention-revealing names; the name answers *why it exists and how it's used*.
- No encodings/abbreviations; searchable names over single letters.
- Verbs for functions, nouns for things; consistent vocabulary per concept.
- One word per concept — don't mix `fetch`/`get`/`retrieve` for the same idea.

## Functions (Clean Code)

- Small; do **one thing** at one level of abstraction.
- Few arguments (0-2 ideal); avoid boolean/flag args — split the function.
- No side effects the name doesn't advertise. Command-query separation.
- Prefer exceptions/Result over error codes; don't return null, don't pass null.

## Comments & formatting

- Prefer self-documenting code; comments explain *why*, never *what*.
- Delete commented-out/dead code (git remembers). No TODOs left as litter.

## Design (A Philosophy of Software Design)

- **Deep modules**: simple interface hiding real complexity. Distrust shallow
  wrappers that add surface without hiding anything.
- **Reduce cognitive load**; make the common path obvious.
- Pull complexity **downward** — the module absorbs it so callers stay simple.
- Design for the reader, not the writer. Comments capture *design intent* that
  isn't obvious from code.

## Architecture (Clean Architecture / DDD)

- **Dependencies point inward**, toward abstractions/policy; details (DB, UI,
  frameworks) depend on the domain, not the reverse.
- Keep business rules free of framework/IO concerns; push those to the edges
  (ports & adapters). Match the repo's bounded contexts / feature isolation.
- Stable things shouldn't depend on volatile things.

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

## The test (before finishing)

- Would a senior engineer call this overcomplicated? If yes, simplify.
- Could it be half the code? If yes, rewrite.
- Does every changed line trace to the task? If not, revert the extras.
