# Auto-Aggregation Rules

These files are auto-rebuilt from metadata.json aggregation. Never hand-edited.

## When to rebuild

Trigger rebuild when any change happens to relevant fields across any metadata.json. Specifically:

| File | Rebuild trigger |
|---|---|
| `ROLES.md` | Any change to `access.roles` in any metadata.json |
| `PLANS.md` | Any change to `access.plans` or `controls[].gating.plans` |
| `INTEGRATIONS.md` | Any change to `integrations[]` |
| `OPEN-QUESTIONS.md` | Any new `_inferred: true` field or `meta.open_questions` entry |

In practice: rebuild all four at the end of every Phase 1, Phase 2, or Phase 3 run.

## ROLES.md structure

Built from all `metadata.access.roles` across screens.

```markdown
# User Roles

> Auto-aggregated from screen metadata. Do not edit directly.

## [Role Name]

**Screens accessible:**
- [Screen Name] - path to screen folder
- [Screen Name] - path to screen folder

**Controls available:**
- [Control Name] on [Screen Name] - purpose

**Restrictions:**
- What this role cannot do (compared to higher roles)
```

One section per role. Roles ordered by access scope (most permissive first).

## PLANS.md structure

Built from all `metadata.access.plans` and `controls[].gating.plans`.

```markdown
# Pricing Plans

> Auto-aggregated from screen metadata. Do not edit directly.

## [Plan Name] - [Price]

**Screens unlocked:**
- [Screen Name]

**Controls unlocked:**
- [Control Name] on [Screen Name]

**Locked behind higher plans:**
- What this plan does NOT include
```

One section per plan. Plans ordered cheapest to most expensive.

## INTEGRATIONS.md structure

Built from all `metadata.integrations[]` grouped by service.

```markdown
# Third-Party Integrations

> Auto-aggregated from screen metadata. Do not edit directly.

## [Service Name]

**Purpose:** What this service does for the app
**Auth method:** shop_token / api_key / oauth / etc.

**Endpoints used:**
- [Method] [endpoint] - purpose (used on [screen])

**Data flow:**
- Reads: what data comes from this service
- Writes: what data is sent to this service
```

One section per third-party service. Services ordered alphabetically or by frequency of use.

## OPEN-QUESTIONS.md structure

Built from all `_inferred: true` fields and `meta.open_questions` arrays across screens.

```markdown
# Open Questions

> Items awaiting dev review. Confirm or correct each.
> Auto-aggregated from screen metadata. Do not edit directly.

## [Screen Name]

- [ ] **Confirm:** "[inferred value]" - inferred from code, [confidence] confidence. (`metadata.field.path`)
- [ ] **Question:** [explicit question logged in meta.open_questions]
```

Grouped by screen. Each item references the exact metadata field path so the dev can find and fix it.

## GLOSSARY.md (hand-curated, NOT auto-aggregated)

Grows hand-curated as terms get used in READMEs and need clarifying for non-technical readers.

```markdown
# Glossary

## [Term]
Definition. Used in: [screen names].
```

When generating screens, if a term appears that might need glossary entry, optionally suggest to dev but never auto-add.

## Rebuild process

1. Walk every screen folder in `product-atlas/screens/`
2. Read each metadata.json
3. Collect relevant fields per aggregation type
4. Sort and group per the structures above
5. Overwrite the aggregated file
6. Note in CHANGELOG.md if aggregation produced different output than before
