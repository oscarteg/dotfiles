---
name: handling-pr-reviews
description: Use when a PR has many reviewer comments (10+ threads), multiple reviewers, or repeated review rounds and the user wants to work through them systematically rather than ad-hoc
---

# Handling PR reviews

Triage every comment up front, work in user-gated batches, draft responses but never post on the user's behalf.

## Core rules

- **Never post replies on the PR.** The user posts manually. You draft into the vault.
- **Never resolve threads** unless the user explicitly asks. GitHub UI is theirs.
- **Always check current code state before applying** — some comments are already addressed by prior commits / rebase. Don't blindly trust the triage from earlier in the session.
- **Don't apply the reviewer's suggestion verbatim — evaluate it first.** The reviewer may be pointing at a real problem but suggesting a wrong or sub-optimal fix. Decide whether the suggestion is the actual best fix, a partial fix, or off-target. Apply the right fix and explain in the batch status. Examples that come up often:
  - Reviewer's snippet has a syntax/semantic error (missing `var()`, wrong operator) → apply the intent with correct syntax.
  - Reviewer wants `min-width` removed but the element is flex-shrinking → use `flex-shrink: 0` instead.
  - Reviewer suggests a refactor pattern not used elsewhere → flag the inconsistency, ask before applying.
  - Reviewer's reasoning is wrong but the smell is real → fix the underlying smell, push back on the reasoning.
- **Surgical edits only.** Trace every change to the comment it resolves. Don't refactor adjacent code.
- **Lint after each batch**, not after every edit.

## Process

### 1. Fetch all active threads (GraphQL, not REST)

REST returns comments without resolution state. GraphQL gives `isResolved` + `isOutdated`. Paginate if >100.

```sh
gh api graphql -f query='
query {
  repository(owner: "OWNER", name: "REPO") {
    pullRequest(number: N) {
      reviewThreads(first: 100) {
        pageInfo { hasNextPage endCursor }
        nodes {
          isResolved isOutdated path line
          comments(first: 20) {
            nodes { databaseId author { login } body createdAt }
          }
        }
      }
    }
  }
}'
```

Filter to `isResolved == false and isOutdated == false`.

### 2. Triage into a vault document

Location per the vault routing in user's Codex/AGENTS instructions. Filename:
- First round: `pr-<num>-review-triage-<YYYY-MM-DD>.md`
- Follow-up reviews: `pr-<num>-review-triage-round-<N>-<YYYY-MM-DD>.md` (new file, don't edit old)

Frontmatter:
```yaml
---
date: YYYY-MM-DD
status: in-progress
type: review
project: <repo>
pr: <num>
branch: <branch>
tags: [pr-review, ...]
---
```

Triage every active comment into one bucket:

| Category | Meaning |
|----------|---------|
| **FIX** | Code change I'll apply |
| **RESPONSE** | User will post a reply, I draft it inline |
| **CHECK** | Investigate current state before deciding |
| **PUSH BACK** | Reviewer is wrong; draft a polite, evidence-based counter |
| **POSITIVE** | Reviewer gave thumbs-up / agreement — just resolve |

Group by file / area, but plan batches in PR order.

### 3. Work in batches of 10

Default to 10. The user wants to read each before code changes. Per batch:

1. Re-check current code state per item (`rg`, `Read`, `Bash`). Some will already be fixed.
2. Post a status report: per item → FIX / DONE / PUSH BACK / RESPONSE / CHECK with one-line reason.
3. Wait for user approval.
4. Apply FIXES (Edit/Write tools, surgical).
5. Run `pnpm lint` (or project equivalent) for affected packages.
6. Update the triage doc: `[ ]` → `[x]` with a one-line summary of what changed.

### 4. Draft responses

Match the user's voice from their existing replies on the PR. Read 2-3 before drafting. Common: terse, technical, English with Dutch fragments OK, no hedging. Push back when factually wrong — cite the spec, code, or evidence.

When you push back, explain in the status report so the user sees the argument before posting. Three short options sometimes beats one long draft.

### 5. After the user replies

User says "check again" → re-fetch threads. For each formerly-open item:
- User posted a reply → mark `[x]` RESPONDED in vault
- Code fixed without reply → mark `[x]` FIXED
- Still open → leave for user resolution

Show what's left and what action is pending on each.

### 6. New review round = new doc

Don't edit the old triage doc when new reviewers/comments arrive. Create `pr-<num>-review-triage-round-<N>-<YYYY-MM-DD>.md`.

## When to use

- PR with 10+ open review threads
- Multiple reviewers (human + bot)
- Second/third review round with stale prior triage
- User says "go through the PR comments" / "help me resolve"

Not needed for: single-comment PRs, trivial nits, code-review *requests* (use `requesting-code-review` skill instead).

## Common pitfalls

| Pitfall | Avoid |
|---------|-------|
| Trusting stale line numbers | Rebases shift lines; always re-check current file |
| Applying suggestions blindly | Reviewer can be factually wrong (e.g. `tabular-nums` is not the default) |
| Inventing convention | If reviewer asks for naming/pattern not used elsewhere in the codebase, check first; flag inconsistency |
| Editing the old triage doc | Each review round = new doc; old stays as history |
| Posting replies for the user | Always draft into vault; user pastes |
| Bulk-resolving threads | Only with explicit ask |

## Useful gh recipes

Count active threads:
```sh
jq '[.[] | select(.isResolved == false and .isOutdated == false)] | length' threads.json
```

User's own replies (to mark off):
```sh
gh api repos/OWNER/REPO/pulls/N/comments --paginate \
  | jq '.[] | select(.user.login == "USER") | {id, in_reply_to_id, body}'
```

Resolve a thread (only when asked):
```sh
gh api graphql -f query='mutation { resolveReviewThread(input: { threadId: "..." }) { thread { isResolved } } }'
```
