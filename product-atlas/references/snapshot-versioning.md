# Snapshot & Versioning

Before any write to an existing screen's `README.md` or `metadata.json`, snapshot the current files to `history/`.

## Snapshot triggers

| Phase | Trigger |
|---|---|
| Phase 1 | NEVER snapshots (no previous version exists) |
| Phase 2 | ALWAYS snapshots affected screen folder(s) before writing |
| Phase 3 | ALWAYS snapshots entire route folder before writing |

## Snapshot path format

### Phase 2 (single feature)
```
history/<YYYY-MM-DD>-<feature-slug>/
├── README.md           (snapshot of old version)
└── metadata.json       (snapshot of old version)
```

If multiple screens affected by one feature, snapshot each:
```
history/<YYYY-MM-DD>-<feature-slug>/
├── <screen-1>/
│   ├── README.md
│   └── metadata.json
└── <screen-2>/
    └── ...
```

### Phase 3 (whole route)
```
history/<YYYY-MM-DD>-route-<route-slug>/
├── <screen-1>/
│   ├── README.md
│   └── metadata.json
├── <screen-2>/
│   ├── README.md
│   └── metadata.json
└── ...
```

## Date format

Use ISO date in UTC: `YYYY-MM-DD`. If multiple snapshots happen on the same day for the same feature, suffix with hour: `YYYY-MM-DD-HHMM`.

## What to snapshot

Snapshot the full screen folder including:
- `README.md`
- `metadata.json`
- Any sub-folders if a sub-screen is being rewritten

Do NOT snapshot:
- Files outside `screens/`
- Aggregated files (ROLES.md, PLANS.md, INTEGRATIONS.md, OPEN-QUESTIONS.md) - these get re-aggregated, not versioned
- Top-level files (OVERVIEW.md, STYLE.md, GLOSSARY.md, CHANGELOG.md) - these have their own update protocols

## When NOT to snapshot

- Phase 1 first-gen (no previous version)
- Auto-aggregation rebuilds of ROLES/PLANS/INTEGRATIONS/OPEN-QUESTIONS (these are derived files)
- Cosmetic-only changes to writing style that don't affect facts

## After snapshot, before write

1. Confirm snapshot files exist in `history/<dated-folder>/`
2. Confirm snapshot README + metadata match the current state of the screen folder
3. Then write the new content over the original location

## CHANGELOG entry required

Every snapshot creates a CHANGELOG.md entry at the top. The entry references the snapshot path so future readers can find the old version.

## Pruning old snapshots

Do not auto-prune. Snapshots accumulate over time. If dev requests cleanup, that's a separate manual operation. Default behavior: keep everything.
