# husky-practice - product-atlas

> This repo has no UI, so this folder doesn't mirror app navigation the way product-atlas normally does.
> Start with `OVERVIEW.md` to understand what this repo actually is (a small practice project, not a SaaS app),
> then `MODULES.md` for what the two source files do.

## Contents

- `OVERVIEW.md` - what this repo is, honestly (not a product)
- `MODULES.md` - `math.js` and `index.js`, documented at function level (replaces the usual `screens/` tree)
- `ATLAS-RULES.md` - the scope override explaining why this atlas is structured differently
- `EXCLUSIONS.md` - vendored/generated content this atlas deliberately skips
- `STATUS.md` / `INDEX.md` / `ASK-ME-FIRST.md` - standard product-atlas scaffolding, kept minimal
- `CHANGELOG.md` - history of atlas updates
- `SKILL.md`, `references/`, `assets/` - the product-atlas skill itself, bundled here so the pilot server can read it without any local Claude Code install

## Why this exists

This atlas was built specifically to unblock the product-atlas pilot server's `atlas sync` webhook path, which requires `product-atlas/SKILL.md` to already exist in a repo before it can react to pushes. See `OVERVIEW.md`'s Meta section for the full story.
