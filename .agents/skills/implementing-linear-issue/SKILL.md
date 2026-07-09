---
name: implementing-linear-issue
description: Use when asked to build, implement, ship, or fix a Linear issue (e.g. "build CRT-123", "fix CRT-160", "pick up the Renovate story"). Reads the issue from Linear, specs it first if thin, then implements it end-to-end (TDD or debugging) and opens a PR. Built on top of superpowers.
---

# Implementing a Linear issue

Take an existing Linear issue and deliver it: read → spec (if needed) → build →
verify → PR. This is the implement half of the `# Workflow: spec-driven
development in Linear` section in the global `AGENTS.md`. It orchestrates
superpowers skills — don't reinvent their steps, invoke them.

## Input

An issue reference: `CRT-123`, a Linear URL, or nothing (→ pick the top `Todo`
issue in the current repo's project, using the mapping table in `AGENTS.md`).

## Steps

1. **Read the issue** via the `linear-project` MCP (`get_issue`): title,
   description, acceptance criteria, tasks, comments, and the git branch name.

2. **Spec gate.** Does the issue hold a real spec (design + acceptance criteria +
   a task list)?
   - **Thin** (a one-liner) → invoke the [`writing-linear-spec`](../writing-linear-spec/SKILL.md)
     skill to brainstorm and write the spec back into the issue, then **stop and
     confirm** with me before writing code.
   - **Already specced** → continue.
   - **Trivial, no-design** (typo, dep bump, config) → skip to step 4 (fast lane).

3. **Start.** Move the issue to **In Progress** and check out its branch
   (`oscar/crt-123-…`). If the repo has a `.jj` dir, use jj; otherwise git
   (see `AGENTS.md` › Version Control).

4. **Build.** Work the task checklist, ticking tasks off *in the Linear issue* as
   they land:
   - Feature/change → [`superpowers:test-driven-development`](https://github.com/obra/superpowers).
   - Bug/fix → [`superpowers:systematic-debugging`](https://github.com/obra/superpowers)
     (reproduce → failing test → fix).
   - Fan independent tasks out to subagents ([`superpowers:subagent-driven-development`](https://github.com/obra/superpowers)).
   - Apply the [`coding`](../coding/SKILL.md) skill throughout — it pulls in
     [`code-quality`](../code-quality/SKILL.md), [`clean-code`](../clean-code/SKILL.md),
     and [`react`](../react/SKILL.md) for React work.
   - Conventional commits referencing `CRT-123`.

5. **Verify** with [`superpowers:verification-before-completion`](https://github.com/obra/superpowers):
   lint + tests + build. Evidence before claiming done — no green claims without
   command output.

6. **PR.** Open a PR titled `type(CRT-123): concise title`. Linear auto-links and
   moves the issue to **In Review**. Report the PR URL. Never push with
   `--no-verify`.

7. **Done.** On merge the issue moves to **Done**; tick off the remaining
   acceptance checklist.

## Guardrails

- The spec lives in Linear, never in the repo or the vault.
- Don't skip the superpowers skills — they are the discipline this skill depends
  on. If one applies, invoke it.
- If the design is unclear at any point, stop and ask rather than assume.
