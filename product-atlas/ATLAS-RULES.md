# Atlas Rules - husky-practice

> Per-repo rules and overrides that the product-atlas skill respects.
> Skill loads this file every session alongside OVERVIEW.md.

---

## Scope override (read this first)

This repo is **not a SaaS web app** and falls outside product-atlas's intended scope (see the skill's own "What this skill is NOT for"). It was built anyway, minimally, to unblock the product-atlas pilot server's requirement that `product-atlas/SKILL.md` exist and be committed before the `atlas sync` webhook path can run end to end. This is a plumbing/mechanism test, not a real customer use case.

Because of that:

- **Skip screen-first documentation entirely.** There are no routes, screens, or UI. Do not create a `screens/` tree, do not try to force `math.js` or `index.js` into a "screen" shape.
- **Document at module/function level instead.** See `MODULES.md`. When `atlas sync` runs after a code change, update `MODULES.md`, not a screens tree.
- **Keep it short.** This repo has ~15 lines of real logic total. Do not pad documentation to look more substantial than the code is.
- **`atlas:validate` / `atlas:quality` etc. are not wired up here.** `npm run atlas:*` scripts were intentionally not added to `package.json` for this minimal build, keep changes to markdown files only unless asked to wire up the full script suite.

## Vocabulary

(none, no domain-specific vocabulary in a 15-line utility file)

## Skip patterns

- Skip `node_modules/`, `coverage/`, `.husky/_/` (generated/vendored, not source).
- Skip `.claude/skills/*` (these are installed Claude Code skill definitions, not this repo's own product code).

## Documentation rules

- On `atlas sync`: if the diff only touches `test-atlas-pilot.txt` or other test/scratch files unrelated to `math.js`/`index.js`, it's fine to make no changes and say so, don't invent updates for a file with no real functionality.
- On `atlas sync`: if `math.js` gains, loses, or changes a function's behavior, update the matching row in `MODULES.md`'s function table.

## Pattern shortcuts

- All code is plain ESM JavaScript, no framework, no build step beyond none.

## Custom checklist items

(none, this repo is too small to need one)

## Aggregation overrides

(none, ROLES.md / INTEGRATIONS.md / PLANS.md are not applicable here, skip generating them)

## Other custom directives

(none yet)
