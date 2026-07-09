# Design & architecture

## Design (A Philosophy of Software Design)

- **Deep modules**: simple interface hiding real complexity. Distrust shallow
  wrappers that add surface without hiding anything.
- **Reduce cognitive load**; make the common path obvious.
- Pull complexity **downward** — the module absorbs it so callers stay simple.
- Design for the reader, not the writer. Comments capture *design intent* that
  isn't obvious from code.

## Architecture (Clean Architecture / DDD)

- **Dependencies point inward**, toward abstractions/policy; details (DB, UI,
  frameworks) depend on the domain, not the reverse.
- Keep business rules free of framework/IO concerns; push those to the edges
  (ports & adapters). Match the repo's bounded contexts / feature isolation.
- Stable things shouldn't depend on volatile things.
