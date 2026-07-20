# Naming Map (Locked)

These names are locked at schema v1.0. Do not improvise alternatives.

## Folder and file names

| Element | Name | Notes |
|---|---|---|
| Cowork project root | `product-atlas/` | At target app's repo root |
| Navigation tree folder | `screens/` | Literal and instantly readable |
| Product brief | `OVERVIEW.md` | Always loads with Q&A |
| Style guide | `STYLE.md` | Writing conventions |
| Per-screen prose | `README.md` | One per screen folder |
| Per-screen data | `metadata.json` | Paired with README.md |
| Pending dev items | `OPEN-QUESTIONS.md` | Auto-aggregated |
| Per-role aggregation | `ROLES.md` | Auto-aggregated |
| Per-plan aggregation | `PLANS.md` | Auto-aggregated |
| Third-party services | `INTEGRATIONS.md` | Auto-aggregated |
| Business terms | `GLOSSARY.md` | Hand-curated |
| Version log | `CHANGELOG.md` | Reverse-chronological |
| Snapshot folder | `history/` | Pre-rewrite snapshots |
| Snapshot subfolder | `<YYYY-MM-DD>-<feature-slug>/` | One per snapshot event |

## Slug conventions

- `<route-slug>` - kebab-case, matches actual UI label (e.g., `products`, `settings`, `bulk-edit`)
- `<sub-screen-slug>` - kebab-case, matches popup/drawer/wizard label (e.g., `bulk-edit`, `product-detail`, `seo-settings`)
- `<feature-slug>` - kebab-case feature name for history snapshots (e.g., `auto-seo-toggle`, `pricing-tier-rename`)

Folder slugs should make the tree readable on its own. Someone scanning folder names should understand the app structure without opening files.
