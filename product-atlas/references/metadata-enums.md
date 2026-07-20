# metadata.json Fixed Enums

These enums are locked at schema v1.0. Invalid enum values block write at validation time.

## screen.screen_type

| Value | Meaning |
|---|---|
| `route` | Full route page |
| `popup` | Modal dialog |
| `drawer` | Side panel |
| `wizard` | Multi-step flow |
| `tab` | Tab view within parent screen |
| `inline-section` | Expanded section on parent screen |

## controls[].type

| Value | Meaning |
|---|---|
| `toggle` | On/off switch |
| `checkbox` | Checked/unchecked (often in lists) |
| `radio` | One of N options |
| `dropdown` | Single select from options |
| `multi-dropdown` | Multi select from options |
| `slider` | Numeric range |
| `input-text` | Free text input |
| `input-number` | Numeric input |
| `input-email` | Email input |
| `input-url` | URL input |
| `date-picker` | Date selection |
| `color-picker` | Color selection |
| `file-upload` | File input |

## actions[].type

| Value | Meaning |
|---|---|
| `button` | Clickable button |
| `link` | Text link |
| `menu-item` | Dropdown menu item |
| `icon-button` | Icon-only button |
| `row-action` | Action inside table row |
| `bulk-action` | Action on selected rows |

## actions[].opens.type

| Value | Meaning |
|---|---|
| `popup` | Modal dialog |
| `drawer` | Side panel |
| `wizard` | Multi-step flow |
| `new-screen` | Full route change |
| `inline` | Expands in place |
| `dropdown-menu` | Menu expansion |
| `confirmation` | Confirm dialog only |

## _confidence levels

| Value | Meaning |
|---|---|
| `high` | Bare value used, no `_inferred` wrapper |
| `medium` | Wrapped object with `_inferred: true, _confidence: "medium"` |
| `low` | Wrapped object with `_inferred: true, _confidence: "low"` |

UNKNOWN is not a confidence level - it means no inference was attempted and the field is left empty + logged to OPEN-QUESTIONS.md.
