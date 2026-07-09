# Parse, don't validate

Source: [cekrem.github.io — Parse, don't validate (TypeScript)](https://cekrem.github.io/posts/parse-dont-validate-typescript/),
after Alexis King's original essay.

## The principle

**Validation throws information away; parsing preserves it in the type.** A
validator checks a value and hands you back the *same* wide type, so every later
caller has to trust that the check happened (or re-check). A parser turns the wide
input into a *narrower type that can only exist if the check passed* — the type
system then proves the invariant for the rest of the program.

> Push the uncertainty to the boundary. Parse unknown input **once**, at the edge
> (API responses, form input, env vars, `JSON.parse` output). Everything inside
> the boundary works with typed values and is *total* — no defensive re-checking.

## Validate (worse)

```ts
// Returns boolean — the knowledge that `email` is valid is lost immediately.
function isEmail(value: string): boolean {
  return /^[^@]+@[^@]+$/.test(value);
}

function sendWelcome(email: string) {
  // No guarantee this string was ever validated. Callers must remember to check.
  // ...
}
```

## Parse (better)

```ts
// A branded type that CANNOT be constructed without going through the parser.
type Email = string & { readonly __brand: "Email" };

function parseEmail(value: string): Email {
  if (!/^[^@]+@[^@]+$/.test(value)) {
    throw new TypeError(`Not an email: ${value}`);
  }
  return value as Email;
}

// Now the type itself is the proof. No re-checking, ever.
function sendWelcome(email: Email) {
  // ...
}
```

## In Oscar's stack: Valibot at the boundary

The [tooling](tooling.md) choice of **Valibot** is parse-don't-validate in
practice — a schema *parses* `unknown` into a typed, total value, and the derived
type flows through the rest of the code:

```ts
import * as v from "valibot";

const User = v.object({
  id: v.pipe(v.string(), v.uuid()),
  email: v.pipe(v.string(), v.email()),
  age: v.pipe(v.number(), v.integer(), v.minValue(0)),
});

type User = v.InferOutput<typeof User>; // { id: string; email: string; age: number }

// At the edge: parse once. Throws on bad input; returns a typed User on success.
async function loadUser(raw: unknown): Promise<User> {
  return v.parse(User, raw);
}
```

## Rules of thumb

- **Parse at the boundary, not in the core.** Do it where untrusted data enters;
  keep inner functions total.
- **Return a value, not a boolean.** If a check produces knowledge, encode that
  knowledge in the return type (branded type, narrowed union, parsed struct).
- **Make illegal states unrepresentable.** Prefer a type that can't hold bad data
  over runtime guards scattered through the code.
- **Fail fast at the edge** — a parse error at the boundary beats a corrupt value
  three layers deep.
