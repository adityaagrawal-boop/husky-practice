# husky-practice - Product Overview

## Identity
- **Name**: husky-practice
- **URL**: n/a (no deployed application)
- **Repo**: (local repository)
- **Category**: Developer tooling practice / learning project
- **One-liner**: A small practice repo demonstrating Husky git hooks, ESLint, Prettier, and Vitest

## What it does

This repository is a learning/practice project that demonstrates how to set up a JavaScript development workflow with pre-commit linting (via Husky + lint-staged), pre-push test gating (via Husky + Vitest), code formatting (Prettier), and continuous integration (GitHub Actions running Vitest). It contains a handful of utility functions (`math.js`) and their tests (`math.test.js`), plus a simple greeting script (`index.js`).

### Top features
1. Pre-commit hook runs ESLint and Prettier via lint-staged
2. Pre-push hook runs Vitest test suite and blocks push on failure
3. GitHub Actions CI workflow runs Vitest on every push and pull request
4. Math utility functions (add, multiply, applyDiscount, isEven) with full test coverage
5. ESLint + Prettier configuration for consistent code style

### Core value prop
Demonstrates a complete JavaScript quality gate workflow (lint on commit, test on push, CI on PR).

## ICP - Who uses this

### Primary persona
Developer learning Git hooks and CI/CD basics.

### Pain points addressed
1. UNKNOWN - this is a practice repo, not a product

### Job-to-be-done
UNKNOWN - learning exercise, not a user-facing product

### Customer profile
- **Size**: n/a
- **Industries**: n/a
- **Geography**: n/a

## Pricing

### Plan structure
n/a - not a product

## Users & Roles

n/a - no user system, no roles, no auth

## Positioning

n/a - not a product

## Technical
- **Stack**: Node.js (ES modules), no web framework
- **Database**: none
- **Locales**: none
- **External APIs consumed**: none
- **Third-party services**: GitHub Actions (CI)
- **Webhook subscriptions**: none
- **Background jobs**: none
- **Dev tooling**: Husky 9.x, lint-staged 17.x, ESLint 10.x, Prettier 3.x, Vitest 4.x

## Setup & Onboarding
- **Install flow**: `npm install` (Husky prepare script auto-installs hooks)
- **First-run UX**: n/a (no application UI)
- **Time to value**: n/a
- **Required config**: Node.js 20+
- **Optional config**: none

## Meta
- **Intake date**: 2026-07-20
- **Filled by**: product-atlas (automated, no developer present)
- **App version**: 1.0.0 (from package.json)
- **Notes**: This repo is NOT a B2B SaaS web application. It has no routes, no screens, no UI framework, no auth, no database, and no user-facing features. The product-atlas skill is designed for B2B SaaS web apps. See OPEN-QUESTIONS.md for the scope concern.
