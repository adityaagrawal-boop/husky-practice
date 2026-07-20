# husky-practice - Overview

## Identity
- **Name**: husky-practice
- **URL**: n/a (not deployed, no UI)
- **Repo**: adityaagrawal-boop/husky-practice
- **Category**: Personal learning/practice repo, NOT a SaaS product
- **One-liner**: A small local repo used to practice Husky git hooks (pre-commit/pre-push), linting, and Vitest, wrapped around a tiny math-utility module.

## What it does
This is not a product with users or screens. It's a practice sandbox: a handful of small JavaScript functions (`math.js`) with tests (`math.test.js`), a demo script (`index.js`), and Husky hooks that run lint/tests before commits and pushes. There is no UI, no routes, no backend, no persistence, and nothing a customer would ever interact with.

### Top features (loosely speaking)
1. `math.js` - four small utility functions (see MODULES.md)
2. `index.js` - a one-off script that logs a greeting
3. Husky pre-commit / pre-push hooks wired via `.husky/`
4. Vitest test suite (`math.test.js`) with coverage reporting
5. ESLint + Prettier config for code style

### Core value prop
There isn't one, this repo has no end users. Its only purpose is practicing tooling (git hooks, linting, testing) and, as of this build, serving as a plumbing test bed for the product-atlas pilot server.

## ICP - Who uses this
n/a - single developer's personal practice repo, not a product with a customer base.

## Pricing
n/a - not a product.

## Users & Roles
n/a - no application, no users, no roles. Just source files a developer edits locally.

## Positioning
n/a - not a product being sold or compared against anything.

## Technical
- **Stack**: Plain Node.js (ESM, `"type": "module"` in package.json)
- **Database**: none
- **Locales**: none
- **External APIs consumed**: none
- **Third-party services**: none
- **Webhook subscriptions**: none in the app itself (the product-atlas GitHub App webhook is external tooling pointed AT this repo, not part of the repo's own functionality)
- **Background jobs**: none

## Setup & Onboarding
- **Install flow**: `npm install`
- **First-run UX**: n/a, no app to run in the traditional sense; `node index.js` prints a greeting to the console
- **Time to value**: n/a
- **Required config**: none
- **Optional config**: `.prettierrc.json`, `eslint.config.js`

## Meta
- **Intake date**: 2026-07-20
- **Filled by**: product-atlas pilot end-to-end test (built by Claude, server-side proof run)
- **App version**: n/a, no versioned releases
- **Notes**: This atlas exists specifically to unblock the product-atlas pilot's requirement that `product-atlas/SKILL.md` already be present and committed before the sync (`atlas sync`) webhook path can run. This repo is explicitly out of product-atlas's intended scope per `SKILL.md`'s own "What this skill is NOT for" section (non-SaaS products). Treat this atlas as a mechanism/plumbing test, not a representative example of product-atlas's output quality on a real SaaS app. See ATLAS-RULES.md for the scope override this build operates under.
