# Route Index - One-Hop Routing & Registration

<!--
  WHY THIS FILE EXISTS (business logic):
  Answering a question used to mean fanning out across SURFACE-MAP.md ->
  screens/README.md -> FEATURE-MAP.md -> the right README - 4-5 reads just to FIND
  the answer. That's slow and error-prone. INDEX.md collapses that to one hop: map
  the question to an exact file, read only that file. INDEX.md is also the single
  registration desk for new pages/features, so the tree never drifts. This file
  defines INDEX.md's format and the rules that keep it accurate.
-->

`product-atlas/INDEX.md` is the brain's routing map. The router (`references/router.md`) reads it FIRST to resolve a question to an exact file path in one hop. Template: `assets/index-template.md`.

## What INDEX.md contains

| Section | Purpose |
|---|---|
| **Per-persona entry points** | "If you're <persona>, start at these files." Lets non-technical teammates skip straight to their lane. |
| **A. Route → file map** | Every route/surface/major feature → exact path + tier + staleness badge + one-line purpose. Grouped (user app / storefront / internal admin). |
| **B. Keyword / alias map** | What people actually say ("free shipping bar", "cart drawer", "bundle") → canonical screen. Sourced from `GLOSSARY.md` synonyms. |
| **C. "Where is X?" reverse lookup** | Major flows/controls → owner screen. |
| **D. Top-level docs map** | Cross-cutting non-screen docs → who they're for and when to use. |
| **Registration desk** | The procedure for adding a new page/feature. |

## Staleness badges

- ✅ documented & current
- ⚠ flagged (needs rewrite, known gap, or `atlas freshness` flagged it stale)
- 🔹 brief/internal coverage (Standard-tier or internal admin, intentionally shallow)

Badges are set when a screen is documented/rewritten and refreshed by `atlas freshness` (see `references/confidence-and-freshness.md`).

## How the router uses it

1. Router Step 1 reads `INDEX.md` (if present) alongside the always-on context.
2. Match the question against Sections B (aliases) → A (routes) → C (flows).
3. Open ONLY the matched file(s). Skip the multi-file fan-out.
4. If no match: fall back to `SURFACE-MAP.md` + `screens/README.md` walk, answer, then **add the missing entry to INDEX.md** so the next lookup is one hop.

## Keeping it in sync (HARD RULE)

`INDEX.md` is only trustworthy if it never drifts. These flows MUST update it:

| Flow | Index update |
|---|---|
| `document <screen>` (new route/feature) | Add Section A row + any Section B aliases + Section C flow if it owns one. |
| `rewrite feature` / `rewrite route` | Update the affected row's one-liner/badge; refresh aliases if behavior changed. |
| `atlas sync` (drift scan) | Mark drifted rows ⚠ until rewritten; remove rows for deleted routes (snapshot first). |
| `atlas freshness` | Recompute ✅/⚠ badges. |
| `exclude <feature/route>` | Remove the row (it now lives in `EXCLUSIONS.md`). |

If `INDEX.md` is missing in an existing atlas, generate it from `SURFACE-MAP.md` + `screens/README.md` + per-route `FEATURE-MAP.md` + `GLOSSARY.md` synonyms, then keep it current.

## Scope discipline

- INDEX.md lists routes, surfaces, and **major** features - not every atomic control. Keep it scannable; deep detail lives in the screen README/metadata it points to.
- One entry per route/feature. Don't duplicate the full FEATURE-MAP tree here.
- Aliases come from real team/user vocabulary - add one whenever a term causes a misroute.
