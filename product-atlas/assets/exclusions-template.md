# Exclusions

> Features and routes that exist in code but are NOT live in this app.
> Atlas does not document anything listed here.
> Cloned SaaS legacy code, disabled features, hidden experiments, etc.

## How to add an entry

Copy the template below for each excluded item. Fill all required fields.

---

## [Feature or Route Name]
- **Status**: Disabled
- **Type**: [Route / Feature]
- **Reason**: [Plain language: why this is not documented]
- **Code location**: [file paths]
- **Affected screens** (Type=Feature only): [which live screens this used to appear on, or "n/a" for Type=Route]
- **Added**: YYYY-MM-DD
- **Action**: [Skip this route entirely / Skip this section of screen X / etc.]

---

## Example entries (delete after filling real ones)

## /admin/legacy-billing
- **Status**: Disabled
- **Type**: Route
- **Reason**: Cloned from parent SaaS, billing is handled by Shopify billing API instead of legacy custom flow
- **Code location**: app/routes/admin.legacy-billing.tsx
- **Affected screens**: n/a
- **Added**: 2026-05-19
- **Action**: Skip during atlas generation. Do not create a screen folder.

## Wholesale pricing tab
- **Status**: Disabled
- **Type**: Feature
- **Reason**: Wholesale feature not active in new SaaS, code retained for potential re-enable
- **Code location**: app/components/WholesalePricing.tsx, app/routes/products.wholesale.tsx
- **Affected screens**: /products (the wholesale tab section was previously here)
- **Added**: 2026-05-19
- **Action**: When documenting /products, skip the wholesale tab. Do not mention it in "What you can do from here" section.
