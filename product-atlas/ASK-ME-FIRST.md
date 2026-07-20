# Ask Me First

This is the front door of this atlas. Note: this repo is a tiny non-SaaS practice project (see `OVERVIEW.md`), so most of the persona-routing machinery product-atlas normally provides (screens, roles, plans, integrations) doesn't apply here. Kept intentionally minimal.

## Step 1 - Identify intent

| Intent | Load |
|---|---|
| Understand what this repo is | `OVERVIEW.md` |
| Understand what a specific function does | `MODULES.md` |
| Understand why this atlas looks unusually thin | `OVERVIEW.md` Meta section, `ATLAS-RULES.md` |
| Maintain docs after a code change | `MODULES.md`, `STATUS.md`, `CHANGELOG.md` |

## Step 2 - Depth & fallback

1. `OVERVIEW.md` for orientation.
2. `MODULES.md` for exact function behavior.
3. If the atlas doesn't cover something: read the source file directly (`math.js`, `index.js`, only two files exist) and answer from that, flag as not-yet-in-atlas if it's a real gap.

## Answering rules

- Don't invent SaaS-style structure (roles, plans, screens) that this repo doesn't have.
- If asked something this repo genuinely has no answer for (it has no users, no billing, no UI), say so plainly rather than guessing.
