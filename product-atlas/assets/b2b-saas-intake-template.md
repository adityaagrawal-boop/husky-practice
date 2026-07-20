# B2B SaaS Adaptive Intake - Paste-Back Template

> Optional template for dev who wants to fill intake offline instead of conversational rounds.
> Fill what applies, leave blank or write "n/a" for what doesn't.
> Skill will use auto-detected pattern data to fill Technical section - skip Section 7 if you don't want to override.

---

## Section 1 - Identity

- **Product name:**
- **App URL (public marketing):**
- **App URL pattern (admin):** (e.g., `app.<product>.com` or `<product>.com/app`)
- **Repo URL:**
- **Category:** (e.g., CRM, Project Management, Analytics, HR, Finance, Marketing Automation, Dev Tools, Customer Support, etc.)
- **One-liner (max 100 chars):**

---

## Section 2 - What it does

- **Full description (3-5 sentences, plain language):**


- **Top 5 features (each as one-liner):**
  1.
  2.
  3.
  4.
  5.

- **Core value prop (single sentence answering "why install this"):**


---

## Section 3 - ICP (Ideal Customer Profile)

- **Primary persona:** (role + company type, e.g., "Marketing manager at 10-100 person B2B SaaS")
- **Top 3 pain points addressed:**
  1.
  2.
  3.
- **Job-to-be-done (single sentence):**
- **Customer size range:** (employee count or revenue range)
- **Industries served:** (list or "horizontal/any")
- **Geography:** (list or "global")

---

## Section 4 - Pricing

(Skip if free / open source. Otherwise fill.)

- **Plan structure:** (free / trial / paid only / freemium / contract)

- **Plan list:**

| Plan name | Price (monthly) | Annual discount? | Key features included |
|---|---|---|---|
|  |  |  |  |
|  |  |  |  |
|  |  |  |  |

- **Plan gating (which major features are locked behind paid plans):**
  - Feature 1 - locked to <plan>
  - Feature 2 - locked to <plan>

- **Free trial:**
  - Length: <days, or "no trial">
  - Conditions: <e.g., "no credit card required, auto-converts to paid">

- **Custom / Enterprise tier:**
  - Exists? <yes/no>
  - If yes, how priced: <contact sales / custom quote>

---

## Section 5 - Users & Roles

- **User roles in app:**

| Role name | What they see | What they can do |
|---|---|---|
|  |  |  |
|  |  |  |
|  |  |  |

- **Multi-user support:** <yes/no>
- **Max seats per plan:** <list per plan, e.g., "Starter: 1, Pro: 5, Scale: unlimited">
- **Permission model:** <role-based / plan-based / custom RBAC / hybrid>
- **Multi-tenancy concept name:** (what we call workspaces - e.g., "workspace," "team," "organization," "account")

---

## Section 6 - Positioning

- **Top 3-5 competitors:**
  1.
  2.
  3.

- **Key differentiator vs each:**
  - vs <competitor 1>: <one sentence>
  - vs <competitor 2>: <one sentence>
  - vs <competitor 3>: <one sentence>

- **Why customers pick this over alternatives:**


- **Common objections / why customers don't pick this:**


---

## Section 7 - Technical (skill will auto-fill from repo scan, override here if needed)

- **Tech stack:** (e.g., Next.js 14 App Router + Tailwind, or Rails + Hotwire, or Ruby on Rails + Shopify Polaris if this is a Shopify app)
- **Database:** (e.g., Postgres via Prisma)
- **Supported locales:** (e.g., en, de, fr)
- **APIs touched:** (e.g., Shopify Admin API, Salesforce, Hubspot)
- **Third-party services:** (e.g., Stripe, PostHog, Postmark)
- **Webhook subscriptions:** (list webhook topics)
- **Background jobs:** (list scheduled / async jobs)

(Leave blank to use auto-detected.)

---

## Section 8 - Setup & Onboarding

- **Install flow:** (one-click / OAuth multi-step / manual setup / etc.)
- **First-run UX:** (wizard / empty state / sample data / nothing)
- **Time to value:** (minutes / hours / days from install to first useful outcome)
- **Required configuration before app works:** (list)
- **Optional configuration:** (list)

---

## Section 9 - Meta

- **Intake date:** YYYY-MM-DD (today)
- **Filled by:** (your name)
- **App version at intake:** (e.g., v2.4.1 or commit hash)
- **Notes / context for Claude:** (anything special)

---

## How to use

1. Fill what you can. Leave the rest blank.
2. Paste back to skill.
3. Skill assembles OVERVIEW.md from your answers + auto-detected technical data.
4. Skill shows you the draft. Review and correct.
5. After approval, moves to surface mapping.

Alternatively, skip the template entirely - skill will ask you conversational questions one batch at a time. Either approach is fine.
