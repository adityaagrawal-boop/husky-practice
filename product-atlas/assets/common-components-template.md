# Common Components

> Shared infrastructure components from the starter kit / cloned codebase.
> Treat these as documented black boxes. Do NOT dive into their source when documenting screens that use them.
> Document what each SCREEN does, not what the wrapper component does.

## How to add an entry

Copy the template below for each common component. Fill all required fields. The "When you see this in a screen" field is critical - it tells Claude what to document and what to skip.

---

## [ComponentName]
- **What it does**: [One-line description]
- **Provides**: [List of capabilities it adds to any screen using it]
- **Code location**: [file path(s)]
- **When you see this in a screen**: [Instructions: what to document, what to skip]
- **Common props to ignore** (optional): [Props that are plumbing, not user-facing]
- **Props worth documenting** (optional): [Props that affect what the user sees]

---

## Example entries (delete after filling real ones)

## CommonForm
- **What it does**: Generic form wrapper used across all screens for create/edit forms
- **Provides**: Field rendering, validation, submission, error display, loading states
- **Code location**: app/components/common/CommonForm.tsx
- **When you see this in a screen**: Document the FIELDS the form contains, the submit BEHAVIOR (where data goes after save), and any custom validation. Do NOT document CommonForm itself.
- **Common props to ignore**: `schema`, `defaultValues`, `onError`, `loadingState`
- **Props worth documenting**: `submitLabel` (the actual button text user sees)

## CommonTable
- **What it does**: Generic table wrapper with pagination, sorting, row actions
- **Provides**: Column rendering, sort handlers, pagination controls, bulk selection
- **Code location**: app/components/common/CommonTable.tsx
- **When you see this in a screen**: Document the COLUMNS displayed, the ROW ACTIONS available, and the BULK ACTIONS. Do NOT document pagination/sorting mechanics.
- **Common props to ignore**: `onSortChange`, `onPageChange`, `paginationConfig`
- **Props worth documenting**: `columns` (defines what user sees), `rowActions` (per-row buttons), `bulkActions` (multi-select actions)

## AdminLayout
- **What it does**: Wraps all admin pages with navigation, header, footer
- **Provides**: Sidebar nav, top bar, page title, breadcrumbs, mobile drawer
- **Code location**: app/components/layout/AdminLayout.tsx
- **When you see this in a screen**: Skip entirely. The screen's own README documents what's INSIDE the layout, not the layout itself.
- **Common props to ignore**: All props (purely structural)
- **Props worth documenting**: None

## CommonModal
- **What it does**: Generic popup/modal wrapper
- **Provides**: Open/close behavior, backdrop, close button, focus trap
- **Code location**: app/components/common/CommonModal.tsx
- **When you see this in a screen**: Document the CONTENT of the modal (fields, buttons, what user does), not the wrapper. Modal becomes a sub-folder if content is complex enough per split-criteria.
- **Common props to ignore**: `isOpen`, `onClose`, `size`, `backdrop`
- **Props worth documenting**: `title` (what user sees as modal header), `primaryAction` (the main button)

## CommonDropdown
- **What it does**: Generic dropdown menu wrapper
- **Provides**: Trigger button, menu positioning, item click handlers, keyboard navigation
- **Code location**: app/components/common/CommonDropdown.tsx
- **When you see this in a screen**: Document the ITEMS in the dropdown (what each option does), not the dropdown mechanics.
- **Common props to ignore**: `placement`, `trigger`, `onSelect`
- **Props worth documenting**: `items` (the options user sees), `triggerLabel` (the button text)
