# Tooling stack

The fixed toolchain for Oscar's personal projects. Prefer these unless a repo has
already committed to something else (then match the repo and flag it).

| Concern | Tool | Not |
| --- | --- | --- |
| Package manager | **pnpm** | npm, yarn |
| Test runner | **Vitest** | Jest |
| Format + import organization | **Biome** | ESLint + Prettier |
| API mocking (tests) | **MSW** | hand-rolled fetch mocks |
| Server state | **TanStack Query** | — |
| Global client state | **Zustand** | Redux |
| Runtime validation | **Valibot** | Zod |
| HTTP client | **Wretch** | Axios, bare `fetch` |
| Versioning + changelogs | **Changesets** | manual bumps |
| Notes / docs | **Obsidian** (PARA) | — |

Runtime validation with **Valibot** is also how [parse-don't-validate](parse-dont-validate.md)
is applied in practice: a Valibot schema parses unknown input into a typed value.
