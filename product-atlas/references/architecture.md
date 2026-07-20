# Architecture

The `product-atlas/` folder sits at the target app's git repo root. Self-contained, exportable, no external references.

## Full structure

```
[target-app-repo]/
└── product-atlas/                  ← cowork project root, in repo
    ├── README.md                   ← what this folder is, how to navigate
    ├── STATUS.md                   ← current state, auto-maintained (NEW)
    ├── OVERVIEW.md                 ← product brain, always loads with Q&A
    ├── ATLAS-RULES.md              ← per-repo rules + overrides (NEW)
    ├── EXCLUSIONS.md               ← dead code / disabled features to skip
    ├── COMMON-COMPONENTS.md        ← shared infra to treat as black box
    ├── SURFACE-MAP.md              ← flat list of screens with tiers (NEW)
    ├── STYLE.md                    ← writing conventions for atlas authors
    ├── ROLES.md                    ← auto-aggregated per-role access map
    ├── PLANS.md                    ← auto-aggregated per-plan feature map
    ├── INTEGRATIONS.md             ← auto-aggregated third-party services map
    ├── GLOSSARY.md                 ← hand-curated business term definitions
    ├── CHANGELOG.md                ← reverse-chronological doc version log
    ├── OPEN-QUESTIONS.md           ← auto-aggregated unresolved INFERRED items
    │
    ├── screens/                    ← navigation tree, mirrors app's UI
    │   ├── README.md               ← home screen + full nav tree as links
    │   └── <route-slug>/
    │       ├── README.md           ← screen prose (human-readable)
    │       ├── metadata.json       ← structured data (machine-readable)
    │       └── <sub-screen-slug>/  ← popups, drawers, wizards, tabs
    │           ├── README.md
    │           ├── metadata.json
    │           └── <deeper-slug>/...
    │
    ├── history/                    ← snapshots before rewrites
    │   └── <YYYY-MM-DD>-<feature-slug>/
    │       ├── README.md           ← previous version
    │       └── metadata.json       ← previous metadata
    │
    └── views/                      ← exported use-case docs (NEW)
        ├── support/<YYYY-MM-DD>-help-articles.md
        ├── pm-specs/<YYYY-MM-DD>-feature-specs.md
        ├── qa/<YYYY-MM-DD>-test-matrix.md
        ├── i18n/<YYYY-MM-DD>-string-keys.md
        ├── sales/<YYYY-MM-DD>-demo-script.md
        └── onboarding/<YYYY-MM-DD>-dev-walkthrough.md
```

## Why this structure

- `STATUS.md` at top because every session reads it first to know where to resume.
- `OVERVIEW.md` at top because it loads with every Q&A and every Phase 2/3 rewrite.
- `ATLAS-RULES.md` at top because skill loads it every session for per-repo overrides.
- `EXCLUSIONS.md` and `COMMON-COMPONENTS.md` at top because they load every phase to filter out dead code and shared infrastructure.
- `SURFACE-MAP.md` at top because it shows full app surface with importance tiers (drives documentation order).
- `screens/` mirrors the app's actual UI navigation, so anyone can browse it like the app itself.
- Aggregated files (`ROLES.md`, `PLANS.md`, `INTEGRATIONS.md`, `OPEN-QUESTIONS.md`) at top so cross-cutting reference is easy.
- `history/` separate from `screens/` so the active tree stays clean.
- `views/` separate so derived exports don't clutter the source-of-truth tree.
- Each screen has paired `README.md` (prose) + `metadata.json` (data) so machines and humans share one source of truth.

## What lives outside the atlas

This skill itself (SKILL.md, references/, assets/) lives outside `product-atlas/`. Build-time tooling never goes inside the deliverable.

The `RULESET.md` file (if present in workspace) is the old monolithic version of this skill's content. It is not used by the skill and can be deleted once the skill is in place.
