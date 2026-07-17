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

## Modularity & coupling

- **Separate policy from mechanism.** Mechanism = *how* it works (the
  implementation); policy = *when/whether* it should happen (the rules). Keep
  mechanism in the component; push policy to the caller who has the context.
- **Hollywood principle / inversion of control** — "don't call us, we'll call
  you". A component receives what it needs through its interface; it doesn't
  reach out to env vars, globals, or context. Explicit dependencies over hidden
  ones (this is what makes test doubles trivial to pass in).
- **Interface segregation — pass only what's needed.** A function that needs an
  email takes the string, not the whole `User`. Extract the value at the
  boundary; the fewer things a unit depends on, the easier it is to reuse.
- **Law of Demeter** — talk only to immediate collaborators. `a.getB().getC().do()`
  couples you to a chain of internals; ask for what you need directly. Not a ban
  on all chaining — a limit on coupling to *distant* structure.
