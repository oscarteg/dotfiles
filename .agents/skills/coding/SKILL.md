---
name: coding
description: Use when writing, modifying, or refactoring any code — the entry point that sets the approach before you touch the editor. Routes to code-quality (always), react (React/TSX), and clean-code (craft judgment).
---

# Coding

The single entry point for any code change. Set the approach first, then apply the
specific skills below. This encodes Oscar's `AGENTS.md` philosophy.

## Before you write

1. **Think first.** State your assumptions. If multiple interpretations exist,
   surface them — don't pick silently. If a simpler approach exists, say so.
   Unclear → stop and ask.
2. **Define success.** Turn the task into a verifiable goal ("write a failing test,
   then make it pass"), not "make it work".

## While you write

- **Simplicity first (YAGNI).** Minimum code that solves the problem — nothing
  speculative. If 200 lines could be 50, rewrite.
- **Surgical changes.** Touch only what the task requires; match existing style;
  every changed line traces to the request. Don't refactor what isn't broken.
- **Standards** → always apply the [`code-quality`](../code-quality/SKILL.md) skill
  (strict typing, exports, testing, tooling).
- **React/TSX?** → apply the [`react`](../react/SKILL.md) skill.
- **Craft / refactoring judgment?** → apply the [`clean-code`](../clean-code/SKILL.md) skill.

## Before you finish

Verify with evidence — lint + tests + build. No "done" or "passing" claims without
command output ([`superpowers:verification-before-completion`](https://github.com/obra/superpowers)).
