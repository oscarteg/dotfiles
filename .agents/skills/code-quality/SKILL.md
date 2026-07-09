---
name: code-quality
description: Use when writing or reviewing TypeScript/JavaScript (and React) code — Oscar's concrete, enforceable standards and tooling stack. Covers strict typing, exports, testing, accessibility, and the parse-don't-validate principle.
---

# Code Quality

Oscar's hard rules for code. These are **specific and enforceable** — unlike the
craft *judgment* in the [`clean-code`](../clean-code/SKILL.md) skill. When a rule
conflicts with the established style of the surrounding code, match the code and
flag the discrepancy — don't silently reformat.

## Standards

- **TypeScript strict mode.** Never `any`; never `enum` (use union types or
  `as const` objects).
- **Named exports only** — no default exports.
- **Named functions for components** — no arrow-function components.
- **Type aliases over interfaces.**
- **Parse, don't validate.** Turn unknown input into a typed value at the boundary
  so the rest of the code is total. See
  [references/parse-dont-validate.md](references/parse-dont-validate.md).
- **Self-documenting code** — inline comments only for complex logic; TSDoc for
  all public APIs.
- **Accessibility** — WCAG 2.1 Level AA.

## Testing

- **Integration tests over unit tests** — test user behaviour, not implementation.
- **MSW** for API mocking in tests.

## Tooling

The fixed stack for personal projects — see [references/tooling.md](references/tooling.md)
for the full list (pnpm, Vitest, Biome, TanStack Query, Zustand, Valibot, Wretch,
Changesets).
