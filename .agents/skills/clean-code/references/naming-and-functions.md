# Naming, functions & comments (Clean Code)

## Naming

- Intention-revealing names; the name answers *why it exists and how it's used*.
- No encodings/abbreviations; searchable names over single letters.
- Verbs for functions, nouns for things; consistent vocabulary per concept.
- One word per concept — don't mix `fetch`/`get`/`retrieve` for the same idea.

## Functions

- Small; do **one thing** at one level of abstraction.
- Few arguments (0–2 ideal); avoid boolean/flag args — split the function.
- No side effects the name doesn't advertise. Command-query separation.
- Prefer exceptions/Result over error codes; don't return null, don't pass null.

## Comments & formatting

- Prefer self-documenting code; comments explain *why*, never *what*.
- Delete commented-out/dead code (git remembers). No TODOs left as litter.
