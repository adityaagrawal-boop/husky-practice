# Open Questions

## OQ-001 — atlas sync requested but no atlas exists

- **Date:** 2026-07-20
- **Trigger:** `atlas sync` command referencing commits `f5b3aa3…` → `32cb3cc…`
- **Issue:** No `product-atlas/` folder, `STATUS.md`, `SURFACE-MAP.md`, or documented screens exist. `atlas sync` requires an existing atlas with screen `metadata.json` files to map changed source files to documented features. There is nothing to diff against.
- **Additional concern:** This repo (`husky-practice`) appears to be a small utility/learning project with `math.js`, `index.js`, and tooling config — not a B2B SaaS web application. The product-atlas skill is scoped to B2B SaaS web apps with routes, screens, and UI components.
- **Action needed (human):**
  1. If this repo *is* intended to have an atlas, run `start atlas` first to bootstrap the `product-atlas/` folder, then use `atlas sync` for future drift detection.
  2. If this was a test of the pilot integration, the sync correctly identified there's nothing to do.
  3. Confirm whether this repo is in-scope for product-atlas documentation.
