# Changelog

Reverse-chronological log of atlas updates.

---

## 2026-07-20 - Initial build

- Built by Claude as a plumbing test for the product-atlas pilot server (webhook → clone → agent → PR).
- Repo is non-SaaS (no UI/screens), so documentation is function-level (`MODULES.md`) instead of the usual screen tree.
- Documented: `math.js` (4 functions), `index.js` (1 demo script).
- Bundled the full skill (`SKILL.md`, `references/`, `assets/`) inside this folder so the pilot server can read it without a local Claude Code install.
- No `npm run atlas:*` scripts wired up yet (kept out of scope for this minimal build, see ATLAS-RULES.md).
