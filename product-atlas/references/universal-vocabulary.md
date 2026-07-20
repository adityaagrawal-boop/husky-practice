# Universal Vocabulary

The skill uses universal SaaS vocabulary by default. But when writing prose for a specific product, it adopts the dev's domain language.

Two layers: skill's INTERNAL vocab (universal), and atlas's OUTPUT vocab (domain-specific from dev).

## Skill's internal vocabulary

When this skill's reference files refer to entities, they use these universal terms:

| Universal term | Refers to |
|---|---|
| user | any human using the product |
| customer | a paying or trial user (when distinct from end-user, e.g., in B2B contexts where one user pays for many) |
| account | the entity that owns a subscription / workspace / tenant |
| workspace | a multi-tenant container (when applicable) - generic term for organization/team/tenant/etc. |
| item / record / entity | any domain object in the product (a project, a deal, a contact, etc.) |
| screen | a UI page or significant sub-page |
| application | the product itself (any software) |

NEVER use these in skill reference files (Shopify hangovers):
- store, merchant, store owner, products (as commerce), order, fulfillment, app store

## Atlas's output vocabulary

When writing OVERVIEW.md, screens/*/README.md, GLOSSARY.md, etc., use the dev's domain language - NOT universal terms.

Examples by domain:

### Project management product
- "workspace" → may stay "workspace" or become "team" or "organization" per dev
- "item" → "project," "task," "subtask," depending on level
- "user" → "member" (when inside workspace)

### CRM product
- "workspace" → "account" or "team"
- "item" → "deal," "contact," "lead," "company"
- "user" → "sales rep" or "user"

### Healthcare product
- "workspace" → "practice" or "clinic"
- "customer" → "patient" (their customer's customer)
- "user" → "provider," "nurse," "admin," etc.

### Finance / fintech product
- "workspace" → "organization" or "company"
- "item" → "transaction," "account" (banking), "invoice"
- "user" → "approver," "viewer," "owner"

### Marketing automation product
- "workspace" → "workspace" or "account"
- "item" → "campaign," "audience," "list," "segment"
- "user" → "marketer," "admin"

## How dev tells skill the vocabulary

Two places:

### OVERVIEW.md (during intake)
Section 1-3 captures product language naturally. Skill picks up dev's terms from their answers.

Example:
```
Dev: "TaskFlow is project management for teams who hate Jira. Workspaces have projects, projects have tasks, tasks have subtasks. We call paid users 'members' and admins 'workspace admins'."

Skill internalizes:
- workspace = workspace (no override)
- item = project / task / subtask (hierarchical)
- user = member (general), workspace admin (admin)
- "AI-free" positioning phrase
```

All downstream prose uses these terms.

### ATLAS-RULES.md (explicit vocabulary section)

For more durable preferences, dev adds to ATLAS-RULES.md:

```markdown
## Vocabulary

- Use "workspace" not "account" or "team"
- Use "member" not "user" when referring to people inside a workspace
- Use "project" not "item" or "entity"
- "AI-free" is our positioning phrase
```

ATLAS-RULES.md vocabulary overrides skill's universal terms in all output.

## Vocabulary inheritance

Per-screen READMEs inherit ATLAS-RULES.md vocabulary. Aggregated files (ROLES, PLANS, INTEGRATIONS) inherit too. Style is consistent across the atlas.

## Banned vocabulary in all atlas output

These terms NEVER appear in atlas READMEs regardless of product:

| Banned | Why | Use instead |
|---|---|---|
| API | Tech jargon | "connects to <service>" or describe what it does |
| component | Code term | "card," "button," "section," "row" - describe what user sees |
| controller | Code term | "screen" |
| schema | Code term | "data" or "fields" |
| GraphQL | Code term | "data" |
| props, state, hook | Code terms | describe behavior |
| endpoint | Code term | "feature" or describe what it does |
| render | Code term | "show" or "display" |
| modal | Tech term | "popup window" |
| route | Tech term | "page" |
| JSON | Tech term | describe the data shape in words |

These ARE allowed in:
- metadata.json (it's data, terms expected)
- INTEGRATIONS.md (service descriptions can use API/endpoint/auth)
- Reference files in this skill (we're talking about the skill itself, not the product)

## Tone

Prose tone is "smart friend over coffee," not corporate or marketing.

### Good
> "Products is where you spend most of your time once you're past 50 items in your catalog. The auto-SEO toggle saves time: turn it on and the app handles meta titles for new products automatically."

### Bad (corporate marketing-speak)
> "Our powerful Products module delivers seamless catalog management with industry-leading auto-SEO capabilities that drive ROI."

### Bad (mechanical template-fill)
> "The Products screen displays a list of products. The auto-SEO toggle has a default value of false. When set to true, the system performs background SEO operations."

## When dev's vocabulary is unclear

If dev hasn't specified preferred terms and the product is ambiguous (e.g., they use "workspace" sometimes and "team" other times), ask:

```
Skill: I've heard you use both "workspace" and "team." Which is the canonical product term I should use throughout the atlas?
```

Capture answer to ATLAS-RULES.md.

## When skill should ask dev about new terms

If skill encounters a domain term in code or dev answers that it doesn't recognize:

```
Skill: I see references to "encounters" in your code. Is this a healthcare app term meaning patient visit? Should I use "encounter" in prose or use a more general term?
```

Adds answer to GLOSSARY.md if dev confirms it's a domain term.

## Vocabulary in EXCLUSIONS.md and COMMON-COMPONENTS.md

These files describe what to skip. They can use code terms (route names, component names) since they're tooling-facing, not user-facing.

OVERVIEW.md and screens/ use dev's domain language exclusively.

## Naming examples

### Workspace concept naming
Default: "workspace"
Healthcare: "practice" or "clinic"
Sales: "account" or "team"
Marketing: "workspace" or "brand"
Education: "school" or "course"
Government: "agency" or "department"

### User concept naming
Default: "user"
B2B internal: "member" or "team member"
B2C: "user" or product-specific like "creator" or "host"
Healthcare: "provider" or "staff"
Sales: "rep" or "salesperson"

### Item concept naming
Default: "item" or "record"
Always replace with product-specific term: "project," "task," "deal," "contact," "campaign," "ticket," etc.

## Multi-language considerations

If the atlas is being maintained in English but the product is localized to other languages, atlas stays in English by default. Localization team uses i18n view export (`generate i18n keys`) to translate the product UI separately.

ATLAS-RULES.md can specify if atlas itself should be written in non-English language (rare).

## Quality review checks vocabulary consistency

`quality review` includes a vocabulary consistency check: if dev specified "workspace" in ATLAS-RULES.md but screens use "team," flag and offer to batch-fix.
