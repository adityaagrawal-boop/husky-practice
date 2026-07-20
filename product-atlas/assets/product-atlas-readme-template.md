# [App Name] - Product Atlas

> Single source of truth for everything about this app.
> Designed to be loaded as a cowork project for Q&A, support, PM, sales, dev onboarding, QA, and i18n use cases.

## How to use this folder

### Start here
- **[OVERVIEW.md](./OVERVIEW.md)** - Product brief: name, ICP, pricing, positioning, tech stack. Always read this first.
- **[screens/README.md](./screens/README.md)** - Navigation tree: every screen, every button, every option.

### Reference docs
- **[ROLES.md](./ROLES.md)** - Per-role access map (auto-aggregated)
- **[PLANS.md](./PLANS.md)** - Per-plan feature map (auto-aggregated)
- **[INTEGRATIONS.md](./INTEGRATIONS.md)** - Third-party services and APIs (auto-aggregated)
- **[GLOSSARY.md](./GLOSSARY.md)** - Business terms used in this app
- **[OPEN-QUESTIONS.md](./OPEN-QUESTIONS.md)** - Items awaiting dev review
- **[CHANGELOG.md](./CHANGELOG.md)** - Version history of these docs

### Style reference
- **[STYLE.md](./STYLE.md)** - Writing conventions for anyone editing these docs

## What this is

This folder is the canonical product knowledge base for [App Name]. It mirrors the app's actual UI navigation as a tree of folders, with detailed READMEs at every level. Every screen, button, dropdown, and toggle is documented with what it does, who can use it, and how it helps the business.

## What it powers

- **Support docs** - per-screen articles ready for help center
- **PM specs** - feature one-pagers
- **Developer onboarding** - mental map of the app
- **Sales scripts** - demo flow + ROI per feature
- **QA test plans** - every option enumerated
- **i18n scoping** - translation key inventory
- **AI Q&A** - cowork agent context
- **Audit trail** - versioned UI surface history

## How to query this folder

Open this folder as a cowork project. Ask any product question. The AI will load OVERVIEW.md, walk the screens tree, and answer with citations.

## How to update

- **Single feature changed?** Run `rewrite feature <name>` via the product-atlas skill.
- **Whole route changed?** Run `rewrite route <slug>`.
- **First time setup or major rebuild?** Run `build atlas`.

## Schema version

This atlas uses product-atlas schema v1.0.
