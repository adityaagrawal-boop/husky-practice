# metadata.json Schema v1.0

Every **feature** folder contains a `metadata.json` alongside its `README.md`. Structured data for machine consumption.

A feature folder may be a route-level hub OR a per-feature node (tab, modal, paywall, edit-form, etc.). The same schema applies at any depth. The `screen.screen_type` field tells consumers which level a given metadata file is documenting.

Template: `assets/metadata-template.json`.
Enums: `references/metadata-enums.md`.

## Top-level structure

15 top-level sections:

1. `schema_version` - always `"1.0"`
2. `screen` - identity + code trace
3. `access` - roles, plans, conditions
4. `purpose` - what/jtbd/business value
5. `controls` - every toggle/slider/dropdown
6. `actions` - every button/link
7. `states` - empty/loading/errors
8. `events_fired` - analytics events
9. `integrations` - third-party services
10. `data` - reads/writes
11. `i18n_keys` - translation key list
12. `navigation` - linked screens in/out
13. `related_screens` - semantic connections
14. `meta` - generation metadata
15. `verified` - freshness stamp (see below)

## Required vs optional fields

**Always required:**
- `schema_version`
- `screen.id`, `screen.name`, `screen.route`, `screen.screen_type`, `screen.code_files`
- `access.roles`
- `purpose.what`
- `meta.generated_at`, `meta.doc_version`

**Required when applicable (skip if empty):**
- `controls`, `actions`, `events_fired`, `integrations`, `i18n_keys`

**Optional:**
- `access.plans` (if no plan gating)
- `access.conditions` (if always visible)
- `purpose.jtbd`, `purpose.business_value` (strongly recommended)
- `states.errors` (if none)
- `data.reads`, `data.writes`
- `related_screens`
- `meta.open_questions`, `meta.generated_from_commit`
- `verified` (freshness stamp - see below)

## `verified` - freshness stamp

WHY: the freshness check (`references/confidence-and-freshness.md`) needs a per-screen
"last verified against code" marker to compare against git history. Without it, staleness
falls back to the single global `STATUS.md` atlas-version commit and per-screen drift is invisible.

Three states:
- `"verified": { "date": "YYYY-MM-DD", "commit": "<hash>" }` - the screen's prose was
  read against the code at this commit/date. `node scripts/validate-atlas.mjs --freshness`
  flags it stale if any of its `code_files` were committed after this date.
- `"verified": null` - **explicitly known-stale.** The screen's code moved or was
  re-architected and the prose has NOT yet been re-checked. Pair with a
  `meta.open_questions` note explaining what drifted and the rewrite needed.
- field absent - never stamped; freshness falls back to `meta.generated_at`.

Stamp `{date, commit}` when documenting or running `rewrite feature`/`rewrite route`.
Set `null` when reconciling code_files after a refactor but deferring the prose rewrite.

## INFERRED field format

When a value is uncertain, wrap it as an object:
```json
"on_effect": {
  "value": "App scans products nightly",
  "_inferred": true,
  "_confidence": "medium"
}
```

When a value is certain, use the bare value:
```json
"on_effect": "App scans products nightly"
```

The `_confidence` levels are: `"high"`, `"medium"`, `"low"`. See `references/confidence-rules.md`.

## Per-section field reference

### screen
```json
{
  "id": "products-list",
  "name": "Products",
  "route": "/admin/products",
  "parent_screen_id": null,
  "screen_type": "route-hub",
  "code_files": ["app/routes/products._index.tsx"]
}
```

`screen_type` enum (feature-first granularity):

| Value | Meaning |
|---|---|
| `route-hub` | Top-level route container; usually thin, links to per-feature folders. |
| `route` | Legacy single-file-per-route. Used only if Phase A feature mapping hasn't been done yet. |
| `tab` | Polaris Tabs item OR custom tab inside a route or another feature. |
| `sub-tab` | A nested tab inside a tab (secondaryTab / subTabs config). |
| `modal` | Popup with its own form / state / actions. |
| `drawer` | Side drawer or sheet. |
| `paywall` | Variant of a feature that appears when the user lacks the plan/feature flag. |
| `confirm-flow` | Multi-step confirmation flow (single-step confirms are inline). |
| `filter-panel` | Filter / search panel with its own controls. |
| `edit-form` | Standalone form (singleton, not list+create+edit). |
| `row-editor` | Edit/detail view folded from a separate route into a parent feature. |
| `wizard-step` | One step of a multi-step wizard. |
| `right-panel` | Persistent side panel with controls / scores / context. |
| `empty-state` | Specific empty-state surface with its own CTA (when complex enough to warrant a feature). |

For folded edit/detail features, also include:

```json
"opens_as_route": "/items/[id]/edit"
```

Indicates the URL the feature is reachable at, even though it's documented inside the parent.

### access
```json
{
  "roles": ["admin", "manager"],
  "plans": ["pro", "scale"],
  "conditions": ["data.products.count > 0"]
}
```

### purpose
```json
{
  "what": "List of all products in store",
  "jtbd": "Quickly find and bulk-manage products",
  "business_value": "Saves hours of catalog management per week"
}
```

### controls (array)
Each control:
```json
{
  "id": "auto-seo-toggle",
  "label": "Auto-generate SEO",
  "type": "toggle",
  "default": false,
  "gating": { "plans": ["pro"] },
  "options": null,
  "on_effect": "App scans products nightly",
  "off_effect": "Manual SEO only",
  "backend_behavior": "Triggers cron job products.seo.scan at 00:00 UTC",
  "business_recommendation": "Turn on for stores with 50+ products",
  "code_ref": "app/components/SeoToggle.tsx:42"
}
```

For dropdown/radio controls, `options` is an array of `{value, label, effect}`.
For sliders, include `min`, `max`, `low_end_effect`, `high_end_effect`, `sweet_spot`.

### actions (array)
Each action:
```json
{
  "id": "bulk-edit",
  "label": "Bulk Edit",
  "type": "button",
  "opens": { "type": "drawer", "target_screen_id": "products-bulk-edit" },
  "business_value": "Update 100 products at once",
  "code_ref": "app/components/BulkEditButton.tsx:12"
}
```

### states
```json
{
  "empty": { "ui": "...", "copy_keys": ["..."] },
  "loading": { "ui": "..." },
  "errors": [
    { "scenario": "...", "ui_shown": "...", "copy_key": "...", "code_ref": "..." }
  ]
}
```

### events_fired (array)
```json
{
  "name": "products.list.viewed",
  "trigger": "Screen mount",
  "properties": ["user_id", "product_count"],
  "code_ref": "..."
}
```

### integrations (array)
```json
{
  "service": "Shopify Admin API",
  "endpoint": "GET /admin/api/2024-01/products.json",
  "purpose": "Fetch product list",
  "auth": "shop_token",
  "code_ref": "..."
}
```

### data
```json
{
  "reads": [{ "source": "shopify.products", "fields": ["id", "title"] }],
  "writes": [{ "target": "internal.product_settings", "fields": ["auto_seo_enabled"] }]
}
```

### i18n_keys (array of strings)
```json
["products.title", "products.empty.cta"]
```

### navigation
```json
{
  "linked_screens": [
    { "screen_id": "products-bulk-edit", "label": "Bulk Edit", "via": "bulk-edit button" }
  ],
  "linked_from": ["home", "navigation-menu"]
}
```

### related_screens (array)
```json
[
  { "screen_id": "settings-seo", "relationship": "configures auto-SEO behavior used here" }
]
```

### meta
```json
{
  "generated_at": "2026-05-18T10:30:00Z",
  "generated_from_commit": "abc123",
  "doc_version": "v3",
  "open_questions": []
}
```
