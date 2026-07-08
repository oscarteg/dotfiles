---
name: clean-code
description: Use when writing or refactoring any code — the baseline craft rules distilled from Clean Code, Clean Architecture, The Pragmatic Programmer, Refactoring, and A Philosophy of Software Design. Bias toward simplicity, clear naming, small focused units, and dependencies pointing at abstractions.
---

# Clean Code

Baseline craft for all code — the timeless *reasoning* from the canonical books.
For Oscar's concrete, enforceable rules (typing, exports, tooling) see the
[`code-quality`](../code-quality/SKILL.md) skill; both are pulled in by the
[`coding`](../coding/SKILL.md) orchestrator. When a rule here conflicts with the
surrounding code's established style, match the code and mention the discrepancy —
don't silently reformat.

## Quick reference

Each row is the essence; open the reference for the reasoning and detail.

| Area | Essence | Detail |
| --- | --- | --- |
| **Naming** | Intention-revealing, one word per concept, searchable — no encodings | [references/naming-and-functions.md](references/naming-and-functions.md) |
| **Functions** | Small; do one thing at one level; 0–2 args; no hidden side effects | [references/naming-and-functions.md](references/naming-and-functions.md) |
| **Comments** | Self-documenting code; comments explain *why*; delete dead code | [references/naming-and-functions.md](references/naming-and-functions.md) |
| **Design** | Deep modules: simple interface hiding complexity; pull complexity down | [references/design-and-architecture.md](references/design-and-architecture.md) |
| **Architecture** | Dependencies point inward at abstractions; business rules free of IO | [references/design-and-architecture.md](references/design-and-architecture.md) |
| **Pragmatic** | DRY with judgment (rule of three); orthogonality; fail fast | [references/pragmatic-and-refactoring.md](references/pragmatic-and-refactoring.md) |
| **Refactoring** | Small behaviour-preserving steps behind green tests; watch the smells | [references/pragmatic-and-refactoring.md](references/pragmatic-and-refactoring.md) |

## The test (before finishing)

- Would a senior engineer call this overcomplicated? If yes, simplify.
- Could it be half the code? If yes, rewrite.
- Does every changed line trace to the task? If not, revert the extras.
