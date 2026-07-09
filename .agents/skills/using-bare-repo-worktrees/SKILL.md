---
name: using-bare-repo-worktrees
description: Use when working in a git repo whose root holds a `.bare/` directory and a `.git` gitfile (bare repo + sibling-worktree layout, aka matklad-style) and you need to create, enter, or remove a worktree — or when `git rev-parse --show-toplevel` fails with "must be run in a work tree" from the repo root. Supersedes using-git-worktrees for this layout.
---

# Using Bare-Repo Worktrees

## Overview

Some repos use a **bare repository at the root** with every branch checked out as a
*sibling* worktree directory — there is no privileged "main" checkout, and the root
itself is not a working tree.

**Core principle:** operate from the root, create worktrees as **siblings of `.bare`**,
and never nest them inside another checkout.

**Announce at start:** "Using the using-bare-repo-worktrees skill for this bare-repo layout."

## Detect this layout

- Root contains `.bare/` and a `.git` **file** reading `gitdir: ./.bare`
- `git worktree list` shows a `(bare)` entry plus sibling worktree dirs
- `git rev-parse --show-toplevel` **fails** ("must be run in a work tree") from the root

If instead it's a normal clone (real `.git/` directory, a working tree at the root),
STOP — use `superpowers:using-git-worktrees` instead.

## Layout

```
project/
├── .bare/              # the repository (objects, refs)
├── .git                # gitfile → "gitdir: ./.bare"
├── main/               # a worktree — may be on ANY branch, don't assume
├── <ticket-slug>/      # feature/fix worktrees, siblings at root
└── poc/<name>/         # experiments / spikes, grouped
```

## Create a worktree

Run from the project **root** — git resolves the repo through `.git` → `.bare`:

```bash
git fetch origin
git worktree add -b <branch> ./<dir> origin/<default-branch>
cd ./<dir>
```

- Always base on the **remote default branch** (`origin/main`), never on a local
  worktree's HEAD — the `main/` dir is often checked out to some other branch.
- `git worktree add` works from the root. If git can't resolve the repo from your
  cwd, `cd` into any existing worktree first and use `../<dir>`.
- No `--dry-run` support in older git; inspect with `git worktree list` after.

## Naming the directory

| Branch kind | Worktree dir |
|---|---|
| feature / fix (`feat/AE-2082`, `fix/audio-embeds`) | ticket or short slug at root: `ae-2082/`, `audio-picker/` |
| experiment / spike / poc / ci | grouped under `poc/<name>/` |

Strip the `feat/` `fix/` `ci/` prefix; keep the dir short and human. If the right
slug is ambiguous, propose one and confirm before running the add.

## Setup after create (project-dependent)

Worktrees do **not** share `node_modules` or build artifacts. Detect the toolchain
and run the matching install:

- `pnpm-lock.yaml` → `pnpm install` · `package-lock.json` → `npm install` · `yarn.lock` → `yarn`
- `Cargo.toml` → `cargo build` · `go.mod` → `go mod download` · `pyproject.toml` → install per its tool

Run a test/build **baseline** only when it's fast and the task needs a known-good
starting point — skip it for heavy monorepos unless asked.

## Cleanup

```bash
git worktree remove ./<dir>      # from root; add --force if it refuses (uncommitted work)
git branch -d <branch>           # only if the branch itself is finished
```

## Common mistakes

| Mistake | Reality |
|---|---|
| "must be run in a work tree" from root, then giving up | Root has no working tree; `git worktree add` still works from root — or `cd` into a worktree |
| `cd main` assuming it's on `main` | `main/` can be on any branch; base new work on `origin/<default>` |
| Creating `.worktrees/<name>` inside a checkout | That's the normal-clone pattern; here worktrees are **siblings** of `.bare` |
| `git checkout -b` to switch branches | Don't switch — each branch has its own worktree |
| Forgetting per-worktree install | A fresh worktree has no `node_modules`; run the detected install |
