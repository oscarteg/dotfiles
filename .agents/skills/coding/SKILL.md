---
name: coding
description: Use when writing, modifying, or refactoring any code — the entry point that sets the approach before you touch the editor. Routes to karpathy-guidelines (behavioral baseline) and code-quality (always), react (React/TSX), and clean-code (craft judgment).
---

# Coding

The single entry point for any code change. Set the approach first, then apply the
specific skills below. This encodes Oscar's `AGENTS.md` philosophy.

## Behavioral baseline

Apply [`karpathy-guidelines`](../karpathy-guidelines/SKILL.md) throughout: think
before coding (surface assumptions, ask when unclear), simplicity first (YAGNI),
surgical changes (every line traces to the request), and goal-driven execution
(turn the task into a verifiable goal, not "make it work").

## Route to the specific skills

- **Standards** → always apply the [`code-quality`](../code-quality/SKILL.md) skill
  (strict typing, exports, testing, tooling).
- **React/TSX?** → apply the [`react`](../react/SKILL.md) skill.
- **Craft / refactoring judgment?** → apply the [`clean-code`](../clean-code/SKILL.md) skill.

## Before you finish

Verify with evidence — lint + tests + build. No "done" or "passing" claims without
command output ([`superpowers:verification-before-completion`](https://github.com/obra/superpowers)).
