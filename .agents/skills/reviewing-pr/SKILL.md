---
name: reviewing-pr
description: Use when asked to review a PR or the current branch's changes. Reviews the diff from multiple expert roles (React, Architecture, Testing, Bug, Clean code, Code style, Security) and writes a structured review note into the routed Obsidian vault — it does not change code.
---

# Reviewing a PR (multi-role)

Review a change set from several expert perspectives and **write the findings
into the Obsidian vault** as a note. This skill is read-only on code — it
critiques, it does not edit.

## Scope

Default to the current branch vs its merge base. If given a PR number/URL, review
that PR's diff (via `gh` / the git remote).

```bash
git fetch origin
git diff --merge-base origin/main   # or the PR's base
```

Read the changed files in full (not just the hunks) for real context.

## Roles

Put on each hat in turn; only report what genuinely applies (skip a role if the
diff doesn't touch its concern):

- **Architect** — boundaries, dependency direction, coupling, where logic lives, layering (see [`clean-code`](../clean-code/SKILL.md) › Architecture).
- **React** — declarative/state-flow correctness, hooks misuse, needless `useRef`/`useEffect` (see [`react`](../react/SKILL.md)).
- **Testing** — coverage of new behaviour, integration-over-unit, missing edge/negative cases, brittle tests.
- **Bug hunter** — logic errors, off-by-one, null/undefined, race conditions, error handling, boundary conditions.
- **Clean code** — naming, function size, duplication, dead code, complexity (see [`clean-code`](../clean-code/SKILL.md)).
- **Code style** — consistency with the repo, Biome/lint conventions, import organization.
- **Security** — input validation, secrets, authz, injection, unsafe deps (only if relevant).

## Severity

Tag each finding: **blocker** / **should-fix** / **nit**. Include
`file:line` and a concrete suggestion, not just a complaint.

## Output → Obsidian vault

Write a note (do **not** print the whole thing into chat — summarize in chat, put
detail in the vault). Route the vault per the global `AGENTS.md` routing table
(personal repos → `personal/Journal of Everything`; DPG → `work/DPG`). Base path
is in `AGENTS.md` › Obsidian Vault.

- **Path:** `<vault>/2-areas/pr-reviews/<repo>-<branch-or-pr>-<YYYY-MM-DD>.md`
  (personal vault has no PARA folders required — put it under a `pr-reviews/`
  folder at the vault root if `2-areas/` doesn't exist).
- **Frontmatter:** `date`, `status: review`, `repo`, `pr`/`branch`, `type: review`.
- **Body:** one `##` section per role that has findings, each finding as a bullet
  with severity + `file:line` + suggestion. End with a short **Verdict**
  (approve / approve-with-nits / needs-work) and the top 3 things to fix.

In chat, report only: the note path, the verdict, and the blockers.

## Guardrails

- Read-only on code. Never edit to "fix" during review.
- Be specific and honest (Oscar's `AGENTS.md`: direct, no hedging). Praise only
  what's genuinely worth calling out; focus on what to improve.
