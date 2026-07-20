# Technical Flow Diagrams (Developer-only companion)

<!--
  WHY THIS FILE EXISTS (business logic):
  FLOWS.md and JOURNEYS.md diagram navigation, screen to screen, for PM/sales/onboarding readers.
  Neither shows what happens INSIDE a single action, the branching, the async calls, the retry
  logic. Mintlify auto-generates exactly this at the function level; not having it is a real
  parity gap for the Developer persona specifically, everyone else has no use for it. This is
  intentionally NOT part of the screen README (writing-rules.md rule 6: no technical terms in
  body prose) - it is a separate, optional, developer-only file so the two audiences never
  compete for the same page.
-->

A technical flow diagram is a Mermaid sequence or flow diagram of what happens inside one action or control when it fires, the code-level counterpart to the plain-language "What this changes behind the scenes" line already required in the README (`references/screen-readme-format.md`). It answers "walk me through what actually executes," which only the Developer persona asks.

## When to generate one

Not every action needs this, most don't. Generate a technical flow diagram only when an action's logic is genuinely non-trivial:

- Multiple conditional branches (different outcomes depending on state, role, or plan)
- An async call chain (API call → wait → conditional follow-up call → UI update)
- Retry, debounce, or optimistic-update logic
- A multi-step effect that touches more than one system (e.g. writes to the database, fires a webhook, and updates client state)

Skip it for anything a single sentence already covers fully, a toggle that flips one boolean and re-renders needs no diagram, drawing one would be noise, not signal.

## How to build one

Same discipline as the README: read the actual code in `screen.code_files` (and whatever it calls into) before drawing anything, hypothesis-confirm the flow with the dev the same way the rest of the screen is validated, never infer branching logic from the UI alone. This is not a mechanical script like `atlas:journeys` (which derives navigation purely from `atlas.json`'s screen hierarchy), it requires real code comprehension, so it gets built during the same feature-first reasoning pass as the README (`references/feature-first-reasoning.md`), not as a separate automated step.

Use a Mermaid `sequenceDiagram` when the flow crosses systems (client → server → third-party), or a `flowchart TD` when it's branching logic within one system. Keep node/step labels in code terms here, this is the one place in the atlas where that's correct, since the audience is exclusively developers.

## Output location

`screens/<route>/TECHNICAL-FLOW.md`, sibling to that feature's `README.md`, one file per feature covering all of that feature's non-trivial actions (not one file per action). Template: `assets/technical-flow-template.md`.

This file is loaded by the Developer persona's "Build" intent (`references/router.md`) alongside `metadata.json`'s `code_files`, never surfaced to any other persona, and never referenced from the README body, keep the plain-language and technical docs fully decoupled so editing one never risks breaking the other's tone.

## Freshness

Same rules as everything else in the atlas: covered by `atlas:freshness` drift detection like any other screen file, and snapshotted before rewrite per `references/snapshot-versioning.md`. If the action's code changes, this file is exactly as stale-checkable as the README is.
