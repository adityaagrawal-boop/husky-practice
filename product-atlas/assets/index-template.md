<!--
  TEMPLATE: INDEX.md
  WHY: The one-hop routing map for the product brain. Lets the router resolve a
  question to an exact file in a single read instead of fanning out across
  SURFACE-MAP -> screens/README -> FEATURE-MAP -> the right README. Also the
  single registration desk for new pages/features. Copy into product-atlas/INDEX.md
  and populate from SURFACE-MAP.md + screens/README.md + FEATURE-MAP.md + GLOSSARY.md.
  Format spec: skill references/route-index.md.
-->
# INDEX - Routing Map for the Product Brain

> Read this FIRST when answering any question. Resolve to an exact file path here, then open only that file. Fan out only if there's no match (then add the missing entry).

**Legend:** ✅ documented & current · ⚠ flagged (needs rewrite / known gap) · 🔹 brief/internal coverage
**Last reconciled:** <YYYY-MM-DD> · run `atlas freshness` to refresh badges, `atlas sync` after code changes.

---

## Per-persona entry points (start here)

| If you're... | Start at |
|---|---|
| New to the app | `OVERVIEW.md` → `SURFACE-MAP.md` → this index |
| Developer | `INTEGRATIONS.md`, `COMMON-COMPONENTS.md`, then the screen's `metadata.json` |
| PM | `STATUS.md`, `OPEN-QUESTIONS.md`, any `PM-*` / roadmap docs |
| Support | support playbook(s), affected `screens/<route>/README.md`, `OPEN-QUESTIONS.md` |
| QA | QA test plan / `views/qa/`, the screen's `metadata.json` |
| Marketing | `OVERVIEW.md` positioning, `PLANS.md` |
| Data analyst | analytics screen docs, `PLANS.md`, `INTEGRATIONS.md` |
| Sales | `OVERVIEW.md`, `PLANS.md`, per-feature business value |
| Designer | UI snapshots, UX docs |

---

## A. Route → file map

| Route / surface | Tier | Path | What it is |
|---|---|---|---|
| `<route>` | <tier> <badge> | `screens/<route>/README.md` | <one line> |
| ↳ `<major feature>` | | `screens/<route>/<feature>/` | <one line> |

(Group by: end-user-facing app, public/unauthenticated surfaces, internal/admin.)

## B. Keyword / alias map

| If they say... | They mean | Go to |
|---|---|---|
| <synonym>, <synonym> | <canonical term> | `screens/<route>/...` |

(Source synonyms from `GLOSSARY.md`. Add one whenever a term causes a misroute.)

## C. "Where is X?" reverse lookup

| Question | Owner screen |
|---|---|
| Where do users <do major flow>? | `screens/<route>/<feature>/` |

## D. Top-level docs map

| Doc | For | Use when |
|---|---|---|
| `OVERVIEW.md` | All | Product brief |
| ... | ... | ... |

---

## Registration desk (adding a new page / feature)

1. Add a Section A row (path + tier + one-liner + badge).
2. Add Section B aliases the team will use.
3. Add a Section C entry if it owns a major flow.
4. Run `document <screen>` / `rewrite feature <name>` to fill the docs and update SURFACE-MAP / screens-README / FEATURE-MAP.

`document`, `rewrite`, and `atlas sync` MUST keep this index in sync (skill `references/route-index.md`).
