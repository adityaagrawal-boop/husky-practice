# Open Questions

## OQ-001 - This repo is not a B2B SaaS web application

- **Date:** 2026-07-20
- **Trigger:** `start atlas` (first-time automated build)
- **Confidence:** HIGH
- **Issue:** The product-atlas skill is scoped to B2B SaaS web applications with routes, screens, and UI components. This repo (`husky-practice`) is a small JavaScript learning/practice project containing:
  - `index.js`: a greeting function (5 lines)
  - `math.js`: four math utility functions (add, multiply, applyDiscount, isEven)
  - `math.test.js`: Vitest tests for the math functions
  - Git hooks (Husky pre-commit for lint-staged, pre-push for test gating)
  - CI workflow (GitHub Actions running Vitest)
  - Linting and formatting config (ESLint + Prettier)
- **What's missing for a real atlas:**
  - No web framework (no React, Next.js, Remix, Vue, Svelte, Rails, etc.)
  - No routing (no routes, no pages, no screens)
  - No UI components (no buttons, forms, tables, modals)
  - No auth or user system
  - No database
  - No billing or multi-tenancy
  - No user-facing application of any kind
- **Action needed (human):**
  1. If this was a test of the product-atlas GitHub App integration, the automated build correctly identified the repo is out of scope. The integration pipeline is working.
  2. If you intended to document a different repo, point the product-atlas GitHub App at the correct B2B SaaS web app repository instead.
  3. If this repo will eventually grow into a web application, re-run `start atlas` once routes and screens exist.
- **Impact:** No screens can be documented. No SURFACE-MAP.md, FEATURE-MAP.md, or screen READMEs can be created. The atlas foundation files (OVERVIEW.md, STATUS.md, CHANGELOG.md, etc.) have been initialized with accurate information about what the repo actually contains.

## OQ-002 - Prior atlas sync attempted before atlas existed

- **Date:** 2026-07-20
- **Trigger:** `start atlas` found existing `OPEN-QUESTIONS.md` from a prior `atlas sync` run
- **Issue:** A previous automated run attempted `atlas sync` on this repo before any atlas existed. That run correctly identified the problem and logged it. This `start atlas` run has now created the foundation files, but the core scope concern (OQ-001) remains.
- **Action needed (human):** See OQ-001. The prior sync's concern was valid.
