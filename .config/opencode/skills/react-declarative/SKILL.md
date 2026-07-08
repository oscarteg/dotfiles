---
name: react-declarative
description: Use when writing, reviewing, or refactoring React components. Enforces declarative, state-flow-first React — model UI as a function of state, derive instead of sync, and reach for imperative escapes (useRef, useEffect, manual DOM) only as a last resort. Self-improving: when Oscar diverges from what this skill produced, it asks whether to codify the divergence as a rule.
---

# Declarative React

Model the UI as a **function of state**. Before writing imperative code, find the
solution in the state flow. Match Oscar's stack: TypeScript strict, named exports,
named function components, type aliases (see global `AGENTS.md`).

## Core rules

1. **UI = f(state).** The render output should be derivable from props + state.
   If you're "making the DOM match" by hand, the model is wrong.
2. **Derive, don't sync.** Compute values during render instead of storing them in
   state and updating them in an effect. No state that mirrors other state.
3. **`useEffect` is an escape hatch, not glue.** Use it only for *external*
   synchronization (subscriptions, network, non-React widgets). Never to react to
   a prop/state change you could derive, and never to "set state when X changes".
4. **`useRef` is a last resort.** Allowed for: DOM handles you must call
   imperatively (focus, scroll, media), stable mutable values that must not
   trigger renders (timers, previous-value), and integrating non-React libs.
   Not for: anything that affects render output — that's state.
5. **Lift/colocate state deliberately.** State lives at the lowest common owner.
   Prefer derived/local over global.
6. **Events describe intent, not mechanics.** Handlers set state ("selected an
   item"); the render reacts. Don't imperatively mutate the DOM in a handler.
7. **Prefer a state machine for complex flows.** When booleans multiply
   (isLoading/isError/isOpen…), model explicit states instead of flags.
8. **Keys, not manual reconciliation.** Reset a subtree with `key`, don't clear it
   in an effect.
9. **Composition over configuration.** Prefer children/slots and compound
   components over boolean prop explosions.

## Decision order (when tempted to go imperative)

1. Can I **derive** it during render? → do that.
2. Can I **lift or restructure state** so it falls out naturally? → do that.
3. Is it genuinely **external** (DOM/subscription/library)? → `useEffect`/`useRef`, isolated and commented.
4. Still stuck? → say so, show the tradeoff, ask — don't silently reach for `useRef`.

## Self-improvement (important)

This skill is meant to evolve with Oscar's taste.

- **When Oscar changes your React output in a different direction** than what this
  skill recommended (e.g. prefers a specific pattern, library, or structure),
  **pause and ask**: *"Should I make this a rule in `react-declarative`?"*
- If yes, **append it** to the `## Learned rules` section below (edit this file),
  phrased as a concrete, testable rule, and note the date + one-line why.
- If it contradicts an existing rule, propose updating that rule rather than adding
  a duplicate.
- Keep rules specific and behavioural ("use X instead of Y because Z"), not vague.

## Learned rules

<!-- Append codified rules here as they emerge, e.g.:
- 2026-07-08 — Use `useSyncExternalStore` for external store subscriptions instead
  of useEffect+useState. Why: tearing-safe and concurrent-mode correct.
-->
