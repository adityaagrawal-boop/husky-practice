# Pattern Detection

Before asking the dev anything, scan the repo to detect patterns. This shapes the adaptive intake (`references/adaptive-intake.md`) and cuts dev questions by 40-60%.

## When to run

- At the start of `start atlas` (before any dev interaction)
- At the start of `rewrite feature` and `rewrite route` (light re-scan)
- Manually via `refresh patterns` if dev requests

## What to detect (B2B SaaS targets)

### Framework
| Signal | Inferred framework |
|---|---|
| `package.json` has `next` | Next.js (check version + App Router vs Pages) |
| `package.json` has `@remix-run/*` | Remix |
| `Gemfile` has `rails` | Rails |
| `package.json` has `react` only | React SPA |
| `package.json` has `nuxt` | Nuxt |
| `package.json` has `@sveltejs/kit` | SvelteKit |
| `package.json` has `vue` | Vue |

### Auth provider
| Signal | Inferred auth |
|---|---|
| `@clerk/*` deps | Clerk (check for Organizations = multi-tenant) |
| `@auth0/*` deps | Auth0 |
| `next-auth` / `@auth/*` deps | NextAuth.js |
| `@supabase/supabase-js` + auth imports | Supabase Auth |
| `lucia` dep | Lucia |
| `devise` gem | Devise (Rails) |
| Custom JWT code in lib/auth/ | Custom auth |

### Multi-tenancy model
| Signal | Inferred model |
|---|---|
| Clerk `organizations()` API used | Clerk Organizations |
| Tables/models have `tenant_id` or `workspace_id` foreign key | Row-level multi-tenant |
| Database connection string includes `tenant` parameter | Schema-per-tenant |
| No tenant references at all | Single-tenant / per-user |

### Billing provider
| Signal | Inferred billing |
|---|---|
| `stripe` dep + webhook handlers | Stripe Subscriptions |
| `@paddle/*` dep | Paddle |
| `lemon-squeezy` dep | LemonSqueezy |
| Internal `BillingService` class | Custom billing |
| No billing code | Free / no billing |

### Real-time
| Signal | Inferred real-time |
|---|---|
| `pusher` / `@pusher/*` dep | Pusher |
| `ably` dep | Ably |
| Native `WebSocket` server | Custom WebSockets |
| `eventsource` / SSE patterns | Server-Sent Events |
| Polling patterns (setInterval + fetch) | Polling |
| None of above | No real-time |

### Background jobs
| Signal | Inferred jobs |
|---|---|
| `bullmq` / `bull` deps | BullMQ |
| `inngest` dep | Inngest |
| `trigger.dev` dep | Trigger.dev |
| `sidekiq` gem | Sidekiq (Rails) |
| Cron config (vercel.json, etc.) | Cron-based |
| None | No background jobs |

### File storage
| Signal | Inferred storage |
|---|---|
| `aws-sdk` or `@aws-sdk/client-s3` | AWS S3 |
| `@cloudflare/r2` | Cloudflare R2 |
| `uploadcare` / `uploadthing` deps | Managed upload service |
| Local filesystem writes | Local (warning: doesn't scale) |

### Email provider
| Signal | Inferred email |
|---|---|
| `postmark` dep | Postmark |
| `resend` dep | Resend |
| `@sendgrid/*` deps | SendGrid |
| `nodemailer` with SES config | Amazon SES |
| `mailgun-js` | Mailgun |

### AI features
| Signal | Inferred AI |
|---|---|
| `openai` dep | OpenAI |
| `@anthropic-ai/*` dep | Anthropic |
| `@google/generative-ai` | Google Gemini |
| `fal-ai` dep | fal (image/video gen) |
| None | No AI features |

### Analytics
| Signal | Inferred analytics |
|---|---|
| `posthog-js` / `posthog-node` | PostHog |
| `mixpanel` | Mixpanel |
| `@amplitude/*` | Amplitude |
| `@segment/*` | Segment |
| Google Analytics gtag | GA4 |
| Custom `track()` function | Custom analytics |

### i18n setup
| Signal | Inferred i18n |
|---|---|
| `next-intl` dep | next-intl |
| `react-intl` dep | react-intl |
| `i18next` dep | i18next |
| `messages/` or `locales/` folder | Some i18n setup |
| No `t()` calls anywhere | No i18n |

### Database
| Signal | Inferred database |
|---|---|
| `prisma/schema.prisma` + `provider = "postgresql"` | Postgres via Prisma |
| `prisma/schema.prisma` + `provider = "mysql"` | MySQL via Prisma |
| `drizzle.config.ts` | Drizzle |
| `mongoose` dep | MongoDB via Mongoose |
| `pg` direct usage | Raw Postgres |
| `mysql2` direct | Raw MySQL |
| `sqlite3` dep | SQLite (often local dev) |

### Permission model
| Signal | Inferred permissions |
|---|---|
| Clerk Roles API used | Clerk role-based |
| `role` enum in user model | Simple role-based |
| Custom permission tables (Permission, Role, RolePermission) | RBAC |
| `cancan` / `pundit` (Rails) | Policy-based |
| Plan-based gating (no role checks) | Plan-based only |

### API surface
| Signal | Inferred API surface |
|---|---|
| `/app/api/` or `/pages/api/` with REST endpoints | Internal API |
| `/api/v1/*` public structure + auth headers | Public API |
| GraphQL schema files | GraphQL API |
| OpenAPI/Swagger config | API-as-product candidate |
| No API code | No external API |

### Routing
| Signal | Inferred routing |
|---|---|
| Next.js App Router (`app/` folder) | File-based routing |
| Next.js Pages (`pages/` folder) | File-based routing (legacy) |
| Remix (`app/routes/`) | File-based routing |
| `react-router` config | Programmatic routing |
| Rails routes.rb | Programmatic |

## Output of pattern detection

Skill builds an internal profile (does not write to disk yet). Used to shape intake questions.

```
{
  "framework": "Next.js 14 (App Router)",
  "auth": "Clerk with Organizations",
  "multi_tenancy": "Clerk Orgs (B2B multi-tenant)",
  "billing": "Stripe Subscriptions",
  "real_time": "none",
  "background_jobs": "Inngest",
  "file_storage": "Cloudflare R2",
  "email": "Postmark",
  "ai_features": "none",
  "analytics": "PostHog",
  "i18n": "next-intl (3 locales: en, de, fr)",
  "database": "Postgres via Prisma",
  "permission_model": "Clerk role-based with custom permissions table",
  "api_surface": "Internal API only",
  "routing": "Next.js App Router file-based",
  "route_count": 34,
  "estimated_screens": 40
}
```

## What to do after detection

1. State summary to dev (use hypothesis-confirm pattern):
   ```
   "I see Next.js 14 + Clerk Organizations + Stripe + Inngest + 34 routes detected.
   Looks like a B2B SaaS with multi-tenant workspaces and subscription billing.
   Sound right?"
   ```
2. Dev confirms or corrects
3. Skill uses confirmed profile to shape adaptive intake (next step)

## Why hypothesis-confirm here matters

Without this pattern, skill would later ask:
- "What auth provider do you use?"
- "Is your product multi-tenant?"
- "Do you have a billing system?"
- ...etc.

With pattern detection + hypothesis-confirm, skill skips all these questions. Dev only confirms or corrects the inferred profile.

## When patterns conflict

If detection finds contradictory signals (e.g., both Stripe AND Paddle code), state both:
> "I see both Stripe and Paddle integrations. Are you migrating? Which is the current billing provider?"

Let dev clarify. Don't pick one silently.

## When patterns are unclear

If a signal exists but is ambiguous, ask:
> "I see WebSocket code in `lib/realtime/socket.ts` but it's only used in `/admin/diagnostics`. Is real-time a product feature, or just for internal diagnostics?"

Specific question with code reference. Faster than open-ended.

## Re-running pattern detection

On `rewrite feature` and `rewrite route`, run a LIGHT scan only on affected files. Full repo re-scan only on `refresh patterns` (manual command).

## Pattern detection respects ATLAS-RULES.md

If ATLAS-RULES.md has `## Pattern shortcuts` section telling skill to assume certain patterns, those override detection. Example: ATLAS-RULES says "all auth is via Clerk, don't ask again" → skill skips even confirming Clerk.
