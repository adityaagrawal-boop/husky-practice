# Surface Map - [App Name]

> Complete list of every screen in this product, with importance tier.
> Drives documentation depth and effort allocation.
> Auto-maintained by skill - regenerated on `start atlas`, updated on `continue atlas`.

**Generated:** YYYY-MM-DD
**Source commit:** <hash>
**Total screens:** 0 (0 to document, 0 excluded)

---

## By tier

### Critical (0) - Full depth, all edge cases

| Screen | Route | Documented? | Last touched |
|---|---|---|---|

### Important (0) - Full depth, key edge cases

| Screen | Route | Documented? | Last touched |
|---|---|---|---|

### Standard (0) - Summary depth

| Screen | Route | Documented? | Last touched |
|---|---|---|---|

### Excluded (0) - See EXCLUSIONS.md

| Screen | Route | Reason |
|---|---|---|

---

## By route group

### Core product
<!-- list -->

### Settings
<!-- list -->

### Reports / Analytics
<!-- list -->

### Admin
<!-- list -->

### Auth
<!-- list -->

### Profile
<!-- list -->

### Integrations
<!-- list -->

### Help
<!-- list -->

---

## Documentation order

Suggested order for `continue atlas` queue:

1. Critical screens (highest tier first)
   - Core entity CRUD before settings
   - Billing before profile
   - Workspace admin before individual user
2. Important screens
   - Reports / analytics
   - Settings (non-billing)
   - Integration management
3. Standard screens
   - Profile / preferences
   - Help / documentation
   - Auth flows

Dev can override via `document <screen>` to jump queue order.

---

## Re-tiering

To change a screen's tier, run: `tier <screen> as <new-tier>`

- Upgrading tier suggests re-documenting screen with deeper coverage
- Downgrading tier keeps existing content (no auto-delete)

---

## Coverage metrics

- **Critical coverage:** 0%
- **Important coverage:** 0%
- **Standard coverage:** 0%
- **Overall coverage:** 0%

Updated on every `continue atlas` session.
