---
name: writing-linear-spec
description: Use when starting a feature or non-trivial change in a ~/Developer/Personal repo — turning a rough idea into a spec. Brainstorms the design, then writes the full spec into a Linear issue (the issue IS the spec). Nothing is written to the repo or the Obsidian vault.
---

# Writing a Linear spec

Turn a rough idea into a Linear story that holds the full spec. Nothing is
written to the repo or the Obsidian vault — the Linear issue *is* the spec. This
is step 0–2 (capture → brainstorm → plan) of the `# Workflow: spec-driven
development in Linear` section in the global `AGENTS.md`.

## Steps

1. **Find the target Linear project.** Map the current repo to its Linear
   project using the table in the global `AGENTS.md`
   (`# Workflow: spec-driven development in Linear`). If the repo isn't listed,
   ask which project — offer to create one on team Createch (`CRT`).

2. **Brainstorm (superpowers).** Invoke the `superpowers:brainstorming` skill to
   sharpen intent, scope, edge cases, and design. Ask the questions it surfaces;
   do not assume or skip ahead. Keep going until the design is genuinely settled.

3. **Write the spec into a Linear issue** (via the `linear-project` MCP). Create
   the issue in the mapped project with:
   - **Title** — concise imperative (e.g. "Add Renovate for auto-updates").
   - **Description** = the spec:
     - `## Why` — problem / motivation.
     - `## Design` — decisions and approach.
     - `## Acceptance criteria` — a `- [ ]` checklist.
     - `## Tasks` — a `- [ ]` implementation checklist (the plan / review gate).
     - `## Out of scope` — what this explicitly does not do.
     - Links / references.
   - **Status** — Todo.

4. **Report** the issue URL and the Linear branch name. Create **no files** in
   the repo or the vault.

## Requirement keywords

Write requirements with [RFC 2119](https://datatracker.ietf.org/doc/html/rfc2119)
keywords so the obligation level is unambiguous:

- **MUST** / **MUST NOT** — absolute requirement.
- **SHOULD** / **SHOULD NOT** — recommended; deviating needs a stated reason.
- **MAY** — genuinely optional.

Capitalise them, and only where the normative sense is intended. Prefer them over
"needs to", "has to", or a lowercase "should" in `## Design` and
`## Acceptance criteria`.

This does not apply to `## Tasks` — that is a plan, not a contract. Keep it as
plain imperative steps.

## Fast lane

For a trivial, no-design change, skip the brainstorm — just create a short issue
and stop. To then build it, pick up the issue and follow the implement → verify
→ PR steps in the `AGENTS.md` workflow.
