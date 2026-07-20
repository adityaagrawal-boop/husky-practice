# package.json Setup (Wiring the `npm run atlas:*` Commands)

<!--
  WHY THIS FILE EXISTS (business logic):
  SKILL.md, command-surface.md, and ~20 other reference files instruct running `npm run
  atlas:validate`, `atlas:quality`, `atlas:compile`, and so on, as if those scripts already
  exist in the target repo. They don't, by default. Nothing in the original `start atlas` flow
  ever wrote them into the target repo's package.json, so every one of those documented commands
  would fail with "missing script" the first time someone actually tried to run it. This file is
  the fix: the one step that makes the documented commands real, run once during `start atlas`,
  never silently skipped.
-->

`start atlas` (Step 10a, `references/cmd-start-atlas.md`) must add the `npm run atlas:*` scripts to the target repo's own root `package.json`, not this skill's folder. `product-atlas/scripts/*.mjs` are plain Node scripts, they only become the documented one-word commands once something wires them into the repo's `scripts` block.

## What to do

1. Read the target repo's root `package.json`. If none exists (rare, but possible for a very early-stage repo), tell the dev this app needs one before the `npm run atlas:*` commands can work, and stop, don't invent a bare-minimum `package.json` for an app that doesn't already use npm, that's outside this skill's scope.
2. Read `assets/package-json-scripts-template.json`, this is the full, current mapping of every documented `atlas:*` command to its script file, kept in sync with `references/command-surface.md`, don't hand-write the mapping again here.
3. Merge its `scripts` object into the target's existing `scripts` object. **Union, never overwrite**:
   - If a key like `atlas:validate` doesn't exist yet in the target, add it as-is.
   - If the target already has a script under that exact name (unlikely, but the dev may have their own `atlas:*` convention already), do NOT clobber it, tell the dev about the collision and ask whether to rename the incoming key (e.g. `atlas:validate:product-atlas`) or skip it.
   - Every other existing script in the target's `package.json` is untouched.
4. Write the merged `package.json` back, preserving key order and formatting as closely as possible (don't reformat the whole file, a minimal diff is the goal so the dev's `git diff` is easy to review).
5. Mention in the Step 10a summary to the dev which scripts were added, so it isn't a silent change to their build tooling.

## Commands with extra arguments

Some documented commands take flags at the call site (`--since=<ref>`, a search query, `--json`, `--strict`, `--dry`, `--apply`). Those are passed through npm's own `--` separator and are NOT baked into the template, e.g.:

```bash
npm run atlas:impact -- --since=origin/main
npm run atlas:search -- "free shipping" --limit=5
npm run atlas:migrate -- --apply
```

The template script strings only need to invoke the right file with the right base path, per-invocation flags are the caller's job.

## Keeping this in sync

If a new `scripts/atlas-*.mjs` file is added later and documented in `references/command-surface.md` as an `npm run atlas:*` command, add the matching entry to `assets/package-json-scripts-template.json` in the same change, a documented command with no template entry is exactly the gap this file exists to close.

## Re-running on an existing atlas

If `start atlas` is re-run after a deletion/rebuild, or a dev asks to sync the scripts (e.g. after pulling a skill update that documents a new command), re-apply this merge, it's idempotent, existing correct entries are simply left as-is.
