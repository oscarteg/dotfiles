# Personal Development Preferences

## Branching Strategy

- **Trunk-based development** - work directly on `main` or use short-lived feature branches
- Feature branches should be small and merge back to `main` quickly (ideally within a day)
- Rebase onto `main` before merging (`git pull origin main --rebase`)
- No long-lived feature branches or release branches
- No feature flags - release when ready
- Keep the trunk always releasable

## Commit Conventions

- **Conventional Commits** - format: `type(scope): description`
- Types: `feat`, `fix`, `chore`, `refactor`, `ci`, `revert`
- Add `!` for breaking changes: `feat(api)!: remove deprecated endpoint`
- Commit messages start with lowercase
- Explain the "why" in the commit body, not just the "what"
- Commit often - small, focused commits representing a single logical change
- Don't commit dead code - remove unused code rather than commenting it out

## Development Philosophy

- **Declarative over imperative** - describe what you want, not how to do it
- **Domain-Driven Design (DDD)** - bounded contexts, domain services, feature isolation
- **Simplicity first** - minimum code that solves the problem, nothing speculative
- **YAGNI** - don't build features you don't need yet
- **DRY with judgment** - duplication is cheaper than the wrong abstraction
- **Prefer explicit over clever** - readable code beats clever one-liners
- **Composition over inheritance** - favor composition patterns
- **Surgical changes** - touch only what you must, match existing style
- **Boy Scout Rule** - leave code better than you found it (within reason)

## Code Quality Standards

The concrete, enforceable standards — TypeScript strict (no `any`/enums), named
exports only, named-function components, type aliases, integration-over-unit
tests, self-documenting code + TSDoc, WCAG 2.1 AA — live in the **`code-quality`**
skill (the single source of truth), pulled in by the **`coding`** orchestrator.

## Tooling Preferences

The fixed stack (pnpm, Vitest, Biome, MSW, TanStack Query, Zustand, Valibot,
Wretch, Changesets, Obsidian) lives in the **`code-quality`** skill →
`references/tooling.md`.

## PR Workflow

- Keep PRs small and reviewable - single-purpose
- Self-review before requesting others' reviews
- Run linting and tests locally before pushing
- Never push with `--no-verify`
- Write meaningful PR descriptions with context and how to test
- PR title format: `type(CRT-123): concise title` — reference the Linear issue id

## Debugging Approach

- **Recall past work first** - before debugging or re-implementing something, run `deja "<query>"` (or the MCP recall tool) to search past agent sessions across Claude Code, Codex, and opencode, indexed locally. Cite what you reuse.
- Read the full error message including stack trace before debugging
- Reproduce the bug before writing a fix
- Write a test that reproduces the bug, then make it pass
- Define success criteria before starting work

## Version Control

- **Check for `.jj` before running any `git` command** — if the repo has a `.jj` directory at the root, use jj. The repo is colocated and `git` commands will work but bypass jj's tracking, which is unsafe.
- **Prefer jj for personal projects** — for my own repos, default to jj over git. It's safer (operation log, `jj undo`), simpler (no staging area), and colocated so GitHub remotes still work.
- **The hygiene principles below apply to both VCSes** — small commits, conventional messages, lint before pushing.

## Git Hygiene

- **Commit often** - small, focused commits that each represent a single logical change
- **Write descriptive commit messages** - explain the "why", not just the "what"
- **Keep PRs small and reviewable** - aim for single-purpose PRs
- **Don't commit dead code** - remove unused code rather than commenting it out
- **Read the error message** - before debugging, read the full error including the stack trace
- **Reproduce before fixing** - confirm the bug exists before writing a fix
- **Run linting and tests before pushing** - catch issues locally before CI

---

# Workflow: spec-driven development in Linear

**This is the way of working for every repo under `~/Developer/Personal/`.** It
applies automatically — no per-repo `AGENTS.md`/`CLAUDE.md` section is required.

Linear is the single source of truth. **The spec lives in the Linear issue** —
never in the repo (no `docs/specs/`, plan files, or scratch specs) and never in
the Obsidian vault. Obsidian stays for personal notes and journalling only.

- **Workspace:** createch. **Team:** Createch (`CRT`).
- **Repo → Linear project** (create a project on the same team for any repo not
  listed):

  | Repo                  | Linear project        |
  | --------------------- | --------------------- |
  | citadel               | Citadel               |
  | alfred                | Alfred                |
  | oscartegiffel.com     | Homepage              |
  | village-map           | Village Map           |
  | blackjack-learner     | Blackjack             |
  | pellikaan_companion   | Pellikaan Companion   |
  | scan-bonnetje         | Bonnetje              |
  | workflowy             | Workflowy             |
  | family-table          | Family Table          |
  | template              | Template              |

- **New web apps start from the template repo.** For any new personal web
  application, clone/degit the template (`oscarteg/tanstarter-monorepo`,
  `~/Developer/Personal/template` → Linear project **Template**) instead of
  scaffolding a fresh stack. It ships the house standard: TanStack Start +
  React, pnpm + Vite+, Drizzle, Better Auth, shadcn/ui, Valibot — plus a
  static Astro marketing app (`apps/marketing`).

## Infrastructure & deployment live in citadel

**All Terraform, infrastructure, and deployment config for every personal repo
lives in the `citadel` repo — never in the individual project repo.** Cloudflare
resources (Pages projects, DNS, Workers, etc.) are managed as Terraform in
citadel. When a task calls for Terraform or deployment changes, make them in
citadel (its own `CRT`-tracked Linear story), not in the app repo.

Consequences for app repos:

- App repos should not contain `.tf` files or hand-rolled deploy workflows that
  duplicate what citadel manages.
- Prefer **Git-connected** Cloudflare Pages (build + deploy driven by Cloudflare,
  configured via Terraform in citadel) over in-repo `wrangler`/upload workflows
  and per-repo API-token secrets.
- Keep app-repo CI (tests, lint, typecheck, build) — Git-connected Pages only
  runs the build command, never your test suite.

## The loop — one story = one change = one PR

0. **Capture** — idea → Linear issue in the repo's project (Backlog): title +
   the "why".
1. **Brainstorm** (superpowers:brainstorming) — sharpen intent, scope, and
   design. Write the **spec into the issue description**: what, why, design
   decisions, and acceptance criteria as a checklist. Move → Todo.
2. **Plan** — break the work into a task checklist (or sub-issues) on the story.
   This is the spec-review gate: agree the plan before writing code.
3. **Implement** — move → In Progress. Branch = Linear's generated name
   (`oscar/crt-123-…`). Work the checklist with TDD
   (superpowers:test-driven-development); fan independent tasks out to subagents.
   Conventional commits referencing `CRT-123`.
4. **Verify** (superpowers:verification-before-completion) — lint + tests +
   build; evidence before claiming done.
5. **PR** — title `type(CRT-123): concise title`. Linear auto-links → In Review.
6. **Done** — on merge, issue → Done; tick off the acceptance checklist.

**Fast lane:** trivial, no-design changes (typo, dep bump, config tweak) skip
steps 1–2 — just an issue + PR.

## Creating a spec / planning a feature

- The spec IS the Linear issue. Put the plan in its **description**; never create
  spec or plan files in the repo or the vault.
- To review or continue work on a story, read it from Linear first.

---

# Obsidian Vault

Notes and documentation are stored in Obsidian vaults on ProtonDrive:

- **Base path:** `/Users/oscar/Library/CloudStorage/ProtonDrive-oscartegiffel@protonmail.com-folder/Apps/Obsidian`
- **Vaults:** `personal`, `work` (contains `DPG`, `Pixcelium`)

## Routing rules

| Working directory                  | Target vault                         |
| ---------------------------------- | ------------------------------------ |
| `/Users/oscar/Developer/Work/dpg/` | `work/DPG`                           |
| Everything else (default)          | `personal/Journal of Everything`     |

## DPG vault structure (PARA)

```
DPG/
├── 0-inbox/          # Unprocessed notes
├── 1-projects/       # Active projects with deadlines
├── 2-areas/          # Ongoing responsibilities (architecture, pr-reviews)
├── 3-resources/      # Reference material
├── 4-archive/        # Completed/inactive items
├── _templates/       # Note templates (adr, technical-spec, etc.)
├── daily-notes/
├── meetings/
└── people/
```

## Conventions

- Templates use YAML frontmatter with `date` and `status` fields
- Architecture docs go in `2-areas/architecture/`
- Project-specific docs go in `1-projects/<project-name>/`
- Use kebab-case for file names

## Specs and design docs

- **Specs, design docs, and implementation plans live in Linear — never in the
  Obsidian vault and never in the repo.** See the `# Workflow: spec-driven
  development in Linear` section above. Do
  not create `docs/specs/`, `docs/superpowers/`, or similar inside any project
  directory, and do not create spec files under `1-projects/<project-name>/`.
- **When asked to "create a spec" or "plan" a feature**, create or refine a
  Linear issue with the plan in its description. When asked to review or
  continue work on a spec, read the Linear issue first.
- **The vault is for notes only** — reflections, journalling, meeting notes,
  reference material. Not specs. The routing table and PARA layout above still
  apply to those.

## Writing tone of voice

When writing into my Obsidian vaults, match my natural writing style:

- **Dutch is my default language** for personal notes, reflections, and quick captures. English for technical docs, blog drafts, and public-facing content. Code-switch freely -- technical terms stay in English even in Dutch sentences (e.g. "Zustand toevoegen voor global state").
- **Bullet points over prose.** Default to short, itemized lists. Only use paragraphs for blog drafts, RFCs, or formal documents.
- **Thought fragments, not polished sentences.** In personal notes, write how I think -- strip articles, drop verbs, capture the core idea and move on. No filler. (e.g. "mensen hebben ownership", "ruis afleiding", not full grammatically correct sentences.)
- **Direct and honest.** State things plainly, no hedging or softening. If something is broken, say it's broken.
- **First person, no ceremony.** Use "ik" / "I" naturally. No third-person abstractions.
- **Leave typos and rough edges** in personal notes -- polish is for public writing only.
- **Use `->` for transformations** and shorthand arrows (e.g. "ipv 'heel erg goed' -> 'uitstekend'").
- **Questions as headers** for reflective notes (e.g. "Waar wil ik zijn?", "Welke skills moet ik ontwikkelen?").
- **Problem-then-solution** structure in technical writing. Identify the pain first, then propose the fix with concrete examples.
- **Bold for key concepts**, blockquotes (`>`) for important conclusions, minimal use of italics.
- **It's fine to leave sections empty.** Not every template field needs filling. Capture what matters, skip the rest.

 <!-- https://github.com/forrestchang/andrej-karpathy-skills -->

Behavioral guidelines to reduce common LLM coding mistakes. Merge with project-specific instructions as needed.

**Tradeoff:** These guidelines bias toward caution over speed. For trivial tasks, use judgment.

## 1. Think Before Coding

**Don't assume. Don't hide confusion. Surface tradeoffs.**

Before implementing:

- State your assumptions explicitly. If uncertain, ask.
- If multiple interpretations exist, present them - don't pick silently.
- If a simpler approach exists, say so. Push back when warranted.
- If something is unclear, stop. Name what's confusing. Ask.

## 2. Simplicity First

**Minimum code that solves the problem. Nothing speculative.**

- No features beyond what was asked.
- No abstractions for single-use code.
- No "flexibility" or "configurability" that wasn't requested.
- No error handling for impossible scenarios.
- If you write 200 lines and it could be 50, rewrite it.

Ask yourself: "Would a senior engineer say this is overcomplicated?" If yes, simplify.

## 3. Surgical Changes

**Touch only what you must. Clean up only your own mess.**

When editing existing code:

- Don't "improve" adjacent code, comments, or formatting.
- Don't refactor things that aren't broken.
- Match existing style, even if you'd do it differently.
- If you notice unrelated dead code, mention it - don't delete it.

When your changes create orphans:

- Remove imports/variables/functions that YOUR changes made unused.
- Don't remove pre-existing dead code unless asked.

The test: Every changed line should trace directly to the user's request.

## 4. Goal-Driven Execution

**Define success criteria. Loop until verified.**

Transform tasks into verifiable goals:

- "Add validation" → "Write tests for invalid inputs, then make them pass"
- "Fix the bug" → "Write a test that reproduces it, then make it pass"
- "Refactor X" → "Ensure tests pass before and after"

For multi-step tasks, state a brief plan:

```
1. [Step] → verify: [check]
2. [Step] → verify: [check]
3. [Step] → verify: [check]
```

Strong success criteria let you loop independently. Weak criteria ("make it work") require constant clarification.

---

**These guidelines are working if:** fewer unnecessary changes in diffs, fewer rewrites due to overcomplication, and clarifying questions come before implementation rather than after mistakes.
