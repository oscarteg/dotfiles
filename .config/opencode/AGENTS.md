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

- TypeScript strict mode, never use `any` or enums
- Named exports only, no default exports
- Named functions for components, no arrow function components
- Type aliases over interfaces
- Integration tests over unit tests - test user behavior, not implementation
- Self-documenting code - inline comments only for complex logic
- TSDoc for all public APIs
- WCAG 2.1 Level AA accessibility compliance

## Tooling Preferences

- **pnpm** as package manager
- **Vitest** as test runner
- **Biome** for formatting and import organization
- **MSW** (Mock Service Worker) for API mocking in tests
- **TanStack Query** for server state
- **Zustand** for global client state
- **Valibot** for runtime validation (not Zod)
- **Wretch** for HTTP client (not Axios/fetch)
- **Changesets** for versioning and changelogs
- **Obsidian** for notes and documentation (PARA method)

## PR Workflow

- Keep PRs small and reviewable - single-purpose
- Self-review before requesting others' reviews
- Run linting and tests locally before pushing
- Never push with `--no-verify`
- Write meaningful PR descriptions with context and how to test
- PR title format: `type(JIRA-TICKET): concise title`

## Debugging Approach

- Read the full error message including stack trace before debugging
- Reproduce the bug before writing a fix
- Write a test that reproduces the bug, then make it pass
- Define success criteria before starting work

## Git Hygiene

- **Commit often** - small, focused commits that each represent a single logical change
- **Write descriptive commit messages** - explain the "why", not just the "what"
- **Keep PRs small and reviewable** - aim for single-purpose PRs
- **Don't commit dead code** - remove unused code rather than commenting it out
- **Read the error message** - before debugging, read the full error including the stack trace
- **Reproduce before fixing** - confirm the bug exists before writing a fix
- **Run linting and tests before pushing** - catch issues locally before CI

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
