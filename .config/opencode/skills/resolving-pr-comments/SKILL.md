---
name: resolving-pr-comments
description: Use when working through review comments on a PR. Fetches the comment threads, batches them, and iterates — for each it asks how to resolve, proposes a fix or a better approach, or drafts a short reply in Oscar's voice explaining why the comment doesn't apply here.
---

# Resolving PR comments

Work through reviewer comments on a PR systematically instead of ad-hoc. You
triage and draft; Oscar decides.

## Gather

```bash
gh pr view <pr> --json number,title,url
gh api repos/{owner}/{repo}/pulls/<pr>/comments   # review (inline) comments
gh pr view <pr> --comments                        # top-level discussion
```

Collect every unresolved comment with its `file:line`, author, and body.

## Batch

Group comments so related ones are handled together:

- by **file/area**, and
- by **theme** (naming, tests, architecture, style, bug, question).

Show the batches as a short numbered list so Oscar sees the shape before diving in.

## Iterate — one comment (or batch) at a time

For each, pick the right move and **use the `question` tool** to let Oscar choose:

1. **Fix it** — the comment is right. Propose the concrete change (diff-level) and,
   on approval, apply it.
2. **Better approach** — the comment has a point but there's a cleaner solution.
   Lay out the options with a recommendation, ask which to take.
3. **Push back** — the comment is wrong or doesn't apply here. Draft a **short
   reply in Oscar's voice** explaining why (see tone below), for him to post.
4. **Clarify** — the comment is ambiguous. Draft a brief question back to the
   reviewer.

Always ask before applying code changes or posting replies. Track progress with a
todo list so nothing is dropped.

## Tone of voice for replies (pushback / discussion)

Match how Oscar writes to another developer:

- **Short and plain.** One or two sentences. No essays, no corporate softening.
- **Direct and honest** — if the suggestion doesn't apply, say so and why, plainly.
- Normal developer language; technical terms fine, no ceremony.
- Lead with the reason, not an apology. e.g. *"This is intentional — the widget
  can't refresh faster than iOS allows, so the tap-to-refresh is the fix, not a
  workaround."*
- Not dismissive: acknowledge a fair point when it is one.

## Finish

- Summarize what was fixed, what was replied to (with drafts), and what's still
  open awaiting Oscar's call.
- If commits were made, use conventional messages referencing the issue/PR.
