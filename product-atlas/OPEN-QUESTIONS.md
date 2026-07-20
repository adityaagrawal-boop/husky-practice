# Open Questions

## OQ-001 — atlas sync requested but no atlas exists

- **Date:** 2026-07-20 (updated)
- **Trigger:** `atlas sync` command, first run referencing `f5b3aa3…` → `32cb3cc…`, second run referencing `32cb3cc…` → `859fa26…`
- **Issue:** No documented screens, `STATUS.md`, `SURFACE-MAP.md`, or screen `metadata.json` files exist in `product-atlas/`. The `atlas sync` command requires an existing atlas with documented screens to map changed source files against. There is nothing to diff against — the sync correctly identifies zero drifted screens and zero rewrites to queue.
- **Repo assessment:** `husky-practice` is a small utility/learning project containing:
  - `math.js` — pure functions (`add`, `multiply`, `applyDiscount`, `isEven`)
  - `index.js` — a console.log hello-world script
  - `math.test.js` — Vitest unit tests for `math.js`
  - Tooling config (ESLint, Prettier, Husky, lint-staged)
  - No routes, screens, UI components, API endpoints, or web application structure
- **Conclusion:** This repo is **not a B2B SaaS web application** and is out of scope for the product-atlas skill (see SKILL.md § "What this skill is NOT for").
- **Action needed (human):**
  1. If this repo is a test bed for the atlas-pilot integration, the sync correctly identified there's nothing to do — no action required.
  2. If you want to test `atlas sync` end-to-end, point it at a repo that has a bootstrapped atlas (run `start atlas` first on a SaaS web app repo).
  3. To stop future no-op sync attempts on this repo, remove the `product-atlas/` folder or add a note to `ATLAS-RULES.md` marking it out-of-scope.
