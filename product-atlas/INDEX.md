# INDEX - Routing Map for the Product Brain

> Read this first when answering any question about this repo.

**Last reconciled:** 2026-07-20

---

## Per-persona entry points

| If you're... | Start at |
|---|---|
| Anyone asking anything about this repo | `OVERVIEW.md` then `MODULES.md` |
| Developer wanting function behavior | `MODULES.md` |
| Wondering why this atlas is so thin | `OVERVIEW.md`'s Meta section + `ATLAS-RULES.md` scope override |

## A. File → doc map

| File | Path | What it is |
|---|---|---|
| `math.js` | `MODULES.md` | 4 pure utility functions |
| `index.js` | `MODULES.md` | standalone demo script |
| Husky/lint/CI tooling | `MODULES.md` | dev tooling, not app logic |

## B. Top-level docs map

| Doc | For | Use when |
|---|---|---|
| `OVERVIEW.md` | Everyone | What this repo actually is (and isn't) |
| `MODULES.md` | Developers | Function-level behavior (replaces screens/) |
| `ATLAS-RULES.md` | Anyone maintaining this atlas | Why it's structured differently than a normal atlas |
| `EXCLUSIONS.md` | Anyone maintaining this atlas | What's deliberately not documented |
| `CHANGELOG.md` | Anyone | History of atlas updates |

## Registration desk

If `math.js` or `index.js` gain new functions, add a row to `MODULES.md`'s function table and note it in `CHANGELOG.md`. No screens tree to update, this repo has none.
