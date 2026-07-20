# OVERVIEW.md Intake Spec

OVERVIEW.md is the product brain. Built during `start atlas` Step 4 via adaptive intake (not fixed 43-question form).

For dynamic intake flow that adapts to detected patterns, see `references/adaptive-intake.md`.

This file lists the 9 sections + questions; `adaptive-intake.md` covers HOW to ask them based on what pattern detection found.

## The 9 sections (covered by adaptive intake)

OVERVIEW.md has 9 sections, 43 questions total. But the dev rarely sees all 43 questions because:

- Section 7 (Technical) is auto-filled from `references/pattern-detection.md` output
- Sections 4 (Pricing) and 5 (Users & Roles) use paste-back templates when complex
- Hypothesis-confirm reduces multi-round Q&A to single confirmations
- Pattern shortcuts in ATLAS-RULES.md suppress questions for known patterns

Typical intake: 6-10 question rounds, ~15-25 minutes.

## Delivery method (adaptive, not fixed)

| Section content | Delivery mode |
|---|---|
| Auto-detectable patterns (Section 7 mostly) | Mode 1 - auto-fill from pattern detection, dev reviews |
| Code-evident structures (pricing tiers, roles when detectable) | Mode 2 - hypothesis-confirm |
| Product context (description, ICP, positioning) | Mode 3 - open-ended conversational |
| Tabular data (when complex) | Mode 4 - paste-back template |

Full mode descriptions in `references/adaptive-intake.md`.

Use `assets/b2b-saas-intake-template.md` for paste-back of full intake (optional offline mode).
Use `assets/overview-template.md` for the OVERVIEW.md output format.

## The 9 sections

### Section 1 - Identity (Required)

1. Product name
2. Shopify App Store URL (or app live URL if not Shopify)
3. Repo URL
4. Category (SEO / Email / Upsell / Loyalty / Subscription / Analytics / etc.)
5. One-liner (≤100 chars, App Store subtitle style)

### Section 2 - What it does (Required)

6. Full description (3-5 sentences, plain language)
7. Top 5 features (each one-liner)
8. Core value prop (single sentence answering "why install this")

### Section 3 - ICP (Required)

9. Primary persona (role + store type)
10. Top 3 pain points addressed
11. Job-to-be-done (single sentence)
12. Store size range (revenue / order count / product count)
13. Industries served (list or "all")
14. Geography (list or "global")

### Section 4 - Pricing (Required; if free, answer "free, no plans")

15. Plan structure (free / trial / paid-only / freemium)
16. Plan list: name, price, key features per plan (table)
17. Plan gating: which major features are locked behind plans
18. Free trial: length + conditions
19. Custom/Enterprise tier: yes/no, how priced

### Section 5 - Users & Roles (Required)

20. User roles in app (list)
21. Per role: what they see, what they can do (table)
22. Multi-user support: yes/no, max seats per plan
23. Permission model: role-based / plan-based / custom / hybrid

### Section 6 - Positioning (Required)

24. Top 3-5 competitors
25. Key differentiator vs each competitor (one sentence each)
26. Why users pick this over alternatives
27. Common objections / why users don't pick this

### Section 7 - Technical (Required, auto-drafted from repo)

28. Tech stack (Remix / Next / Rails, Polaris / Tailwind / custom UI)
29. Shopify APIs touched (Products, Orders, Customers, Themes, Webhooks, etc.)
30. Third-party services (Klaviyo, OpenAI, Stripe, Postmark, etc.)
31. Webhook subscriptions (list of webhook topics consumed)
32. Background jobs (list of cron/scheduled tasks)
33. Database (Postgres / MySQL / MongoDB / Prisma / etc.)
34. Supported locales (list of language codes)

### Section 8 - Setup & Onboarding (Required)

35. Install flow (one-click / auth flow / config required)
36. First-run UX (what happens immediately after install)
37. Time to value (how long until user sees results)
38. Required configuration before app works
39. Optional configuration

### Section 9 - Meta (Required)

40. Intake date (YYYY-MM-DD)
41. Person filling it out
42. App version at time of intake
43. Notes / context Claude should know

## Refresh policy

OVERVIEW.md refreshes manually only. User runs explicit command (`refresh overview`). No auto-refresh from repo changes.
