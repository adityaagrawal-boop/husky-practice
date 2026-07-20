# Atlas Rules - [App Name]

> Per-repo rules and overrides that the product-atlas skill respects.
> Skill loads this file every session alongside OVERVIEW.md.
> Add rules as you discover preferences. Skill never modifies itself - all repo-specific behavior lives here.

---

## Vocabulary

Use these terms throughout the atlas. Override skill defaults.

<!-- Examples:
- Use "workspace" not "account" or "team"
- Use "member" not "user" when referring to people inside a workspace
- Use "project" not "item" or "record"
- "AI-free" is our positioning phrase - never use "non-AI" or "without AI"
-->

(none yet - add as you discover preferences)

---

## Skip patterns

Routes or screens to skip by pattern. Broader than EXCLUSIONS.md (which is item-by-item).

<!-- Examples:
- All routes under `/internal-tools/*` - employee-only debug
- All routes under `/v1/*` - legacy API, being phased out
- Any component file starting with underscore (`_*.tsx`) - internal not user-facing
-->

(none yet)

---

## Documentation rules

Repo-specific writing or documentation rules that extend skill defaults.

<!-- Examples:
- For billing screens, always include link to Stripe customer portal
- Document API endpoint in metadata.json under integrations when a screen uses internal API
- Cap admin-only screen depth at Important (not Critical)
- Include "what happens after this action" in every action's prose
-->

(none yet)

---

## Pattern shortcuts

Tell skill what code patterns to assume, so it stops asking.

<!-- Examples:
- All forms use react-hook-form. Don't flag this, don't ask.
- All buttons use Polaris Button. Treat as standard.
- All routes under /app/* are authenticated. No need to ask about auth per screen.
- Server actions live in app/actions/. Database writes go through these.
-->

(none yet)

---

## Custom checklist items

Add per-screen checklist items specific to this product. Skill runs these in addition to standard checklist.

<!-- Examples:
For every Critical screen:
- Does this screen send a notification? If yes, document trigger + content.
- Does this screen produce an audit log entry? If yes, document what's logged.
- Is this screen accessible via support impersonation? If yes, document scope.
-->

(none yet)

---

## Aggregation overrides

Customize how aggregated files are built.

<!-- Examples:
- ROLES.md should include each role's "what they cannot do" section
- INTEGRATIONS.md should group services by category (analytics, billing, comms, infrastructure)
- PLANS.md should include trial-to-paid conversion notes per plan
-->

(none yet)

---

## Other custom directives

<!-- Examples:
- Always use ISO date format (YYYY-MM-DD) in prose, never US format
- Currency display always USD with $ prefix, 2 decimals
- Screen titles match UI labels exactly (no rephrasing)
- For any screen that integrates with Slack, link to the slack-integration screen documentation
-->

(none yet)

---

## How to add rules

When you notice a preference during build, tell skill: "from now on always do X" or "use the term Y instead of Z". Skill will:
1. Add the rule to the appropriate section above
2. Apply going forward in this session
3. Optionally retroactively fix existing docs (skill will ask)

Hard rules (in `references/hard-rules.md`) override custom rules. Otherwise, custom rules win over skill defaults.
