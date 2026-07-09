# TigerStyle (TigerBeetle)

Source: [TigerBeetle — TIGER_STYLE.md](https://github.com/tigerbeetle/tigerbeetle/blob/main/docs/TIGER_STYLE.md).
A craft-philosophy source in the same spirit as the canonical books — read it for
*reasoning*, distil the transferable ideas, don't apply it as law. Its design
goals, in order: **safety, performance, developer experience.**

## Simplicity & technical debt

- Simplicity is the **hardest revision, not the first attempt** — the "super idea"
  that solves several axes at once. Spend the thinking upfront; an hour of design
  saves weeks in production.
- **Zero technical debt.** Fix showstoppers in design/implementation, not
  production — code, like steel, is cheapest to change while hot.

## Safety (the transferable core)

- **Assertions detect programmer errors.** Assert function arguments, return
  values, pre/postconditions and invariants; aim ~2 assertions per function.
  - **Pair assertions** — enforce a property on two different code paths (e.g.
    before writing to disk *and* after reading back).
  - Assert the **positive space you expect AND the negative space you don't** —
    bugs live on the valid/invalid boundary. Tests must exercise both.
  - Split compound assertions: `assert(a); assert(b);` over `assert(a and b);`.
- **Put a limit on everything.** Every loop/queue has a fixed upper bound
  (fail-fast); unbounded event loops must assert their invariants.
- **Handle every error.** Most catastrophic failures are mishandled *non-fatal*
  errors (OSDI'14: 92%).
- **Simple, explicit control flow.** Avoid recursion (keep bounded things
  bounded); use a minimum of excellent abstractions (they're never zero-cost).
- **State invariants positively** (`if (index < length)` over the negation).
  Split compound conditions into nested `if/else`; consider whether each `if`
  needs a matching `else` for the negative space.

## Performance

- **Solve performance in the design phase** — the 1000x wins come before you can
  profile. Have mechanical sympathy.
- **Back-of-the-envelope sketches** across the four resources (network, disk,
  memory, CPU) × two characteristics (bandwidth, latency). Optimise the slowest
  first, weighted by frequency.
- **Batch** to amortise costs; separate control plane from data plane.

## Developer experience

- **Naming.** Get the nouns and verbs right — names are a mental model. No
  abbreviations; units/qualifiers last, most-significant word first
  (`latency_ms_max`, not `max_latency_ms`, so `_min`/`_max` line up). Prefix a
  helper with its caller (`read_sector` → `read_sector_callback`). Nouns over
  participles (`replica.pipeline` over `replica.preparing`).
- **Functions ~70 lines.** "Push `if`s up and `for`s down": centralise control
  flow and state in the parent, keep leaf helpers pure.
- **Cache invalidation.** Don't duplicate or alias state. Compute/check variables
  **close to where they're used** to avoid POCPOU (place-of-check to
  place-of-use, cousin of TOCTOU) — most bugs come from a gap in time or space.
- **Off-by-one.** Treat `index` (0-based), `count` (1-based), `size` (× unit) as
  distinct types with explicit casts. Show intent in division (`divExact`/
  `divFloor`/`div_ceil`).
- **Always say why** — comments explain rationale, not the "what". Also say *how*
  (e.g. a test's goal + methodology at the top).
- **Reduce return-type dimensionality** at the call site: `void > bool > u64 >
  ?u64 > !u64`.

## Zig-specific — does NOT transfer to Oscar's TS stack

Read for context, don't adopt (these conflict with the [`code-quality`](../../code-quality/SKILL.md) skill):

- `snake_case` names / `CamelCase.zig` files / capitalised acronyms — TS uses its
  own idiom, Biome-enforced.
- Static allocation, "no dynamic memory after init", `u32`/explicit-width types —
  N/A in TS/JS.
- **Zero dependencies** + tooling written in Zig — Oscar's stack is deliberately
  pnpm + Vitest + Biome + TanStack + Zustand + Valibot + Wretch.
- 4-space indent, 100-column limit, `zig fmt` — formatting is Biome's job here.
