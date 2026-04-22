# Brand: CommerceKing

Ecommerce and CMS platform development. The builder of the ecosystem. System integration, platform migrations, and ongoing technical delivery.

## Brand Identity

| Field | Value |
|---|---|
| **Name** | CommerceKing |
| **Domain** | commerceking.ai |
| **Type** | Solution Integrator / Development Agency |
| **Word** | Integrate |
| **Tagline** | Commerce experts who build platforms that run your business. |
| **Primary Color** | #1e3a5f (deep navy) |
| **Secondary Color** | #00B2A9 (teal) |
| **Accent Color** | #EF426F (coral) |
| **Contact** | brent@commerceking.ai |
| **LinkedIn** | commerceking |

## Positioning

**Sentence:** CommerceKing builds, migrates, and integrates ecommerce and CMS platforms with certified developers and 16+ years of commerce experience.

**Paragraph:** CommerceKing is a solution integrator for ecommerce and CMS platforms. Adobe Commerce, Shopify, BigCommerce, WooCommerce, Shopware, WordPress, Astro. The team has 16+ years in commerce, a 5x Magento Master as founder, and a certified development partner (Evrig Solutions) that Brent has worked with since 2013. US-based project management handles every engagement. LoopStack is the delivery methodology: Build the platform, Fill it with content (via Content Cucumber), Grow traffic and revenue, Automate operations (via RequestDesk). One relationship, four capabilities that compound.

## What It Does

- Ecommerce platform builds (new stores, full implementations)
- Platform migrations (zero-downtime, SEO-preserved)
- System integrations (ERP, PIM, OMS, payments, shipping, marketing automation)
- CMS implementation (WordPress, Astro, headless)
- HubSpot CRM integration and marketing automation
- AEO optimization (Answer Engine Optimization for AI search visibility)
- Competitive intelligence and platform audits
- Ongoing maintenance and support

**Key differentiator:** 16+ years of commerce expertise. Adobe Commerce Partner. 5x Magento Master founder. Not an AI shop that learned commerce yesterday. Commerce experts who use modern tools (including AI) to deliver faster.

## LoopStack (Delivery Methodology)

LoopStack is how CommerceKing delivers results. Four pillars in a continuous cycle:

| Pillar | Who Delivers | What |
|--------|-------------|------|
| **Build** | CommerceKing + Evrig | Platform builds, migrations, integrations, custom development |
| **Fill** | Content Cucumber | Product descriptions, blog content, landing pages, marketing copy |
| **Grow** | CommerceKing + CC | SEO, AEO, HubSpot automation, email campaigns, competitive intel |
| **Automate** | RequestDesk | Brand voice AI, content pipelines, publishing workflows, automation |

Every engagement starts with Build and expands from there.

## Voice and Tone

> **Baseline writing rules come from `/brand-brent`.** All rules below inherit from brand-brent (no em dashes, no emojis, no "should", active voice, banned phrase list). Brand-specific adjustments below override or extend the baseline where noted.

### Messaging Principles (CRITICAL)

These principles were established after expert review (Daniel Tanco Perez, Adobe Principal PM, April 2026):

1. **Lead with commerce expertise, not AI methodology.** CommerceKing's differentiator is 16+ years of ecommerce experience and certified platform knowledge. AI is a tool in the toolbox, not the headline.

2. **Never lead with how you build. Lead with what you build.** Clients care about their platform working. The development methodology is secondary. LoopStack matters because of outcomes, not because of the process itself.

3. **No defensive AI messaging.** Never warn about "cheap AI shops," "AI doesn't understand your business," or "you don't have to use AI." These undermine confidence. If you're confident in your approach, you don't need to attack alternatives.

4. **No fear-based selling.** Problem statements are fine. Doom-and-gloom agitation ("every outage costs you revenue, every missed feature sends customers to competitors") reads as manipulative. State the problem, present the solution, move on.

5. **Show expertise through specifics, not claims.** "Adobe Commerce Partner with certified developers" is credible. "We're different from traditional agencies" is a claim anyone can make. Platform names, certifications, years of experience, team bios with real history.

6. **LoopStack should be visible early.** It's the delivery methodology and a real differentiator. Don't bury it in FAQ or deep pages. Surface it on the homepage.

### Never Use
- Em dashes (use periods, commas, or parentheses)
- Emojis (unless explicitly requested)
- "Human-driven, AI-powered" as a leading message (AI is secondary)
- "Cheap AI shops" or comparisons to low-quality competitors
- "You don't have to use AI" (mixed messaging)
- "AI doesn't understand your business" (negative framing)
- "Game-changing," "revolutionary," "next-generation"
- Fear-based agitation paragraphs
- Any phrasing that makes the site feel like it was generated by AI

### Always Use
- Specific platform names (Adobe Commerce, Shopify Plus, BigCommerce)
- Certifications and credentials (Adobe Partner, 5x Magento Master)
- Years of experience (16+)
- Team names when appropriate (Brent, Vijay/Evrig, Isaac)
- Concrete deliverables (not vague promises)
- LoopStack by name when describing the delivery approach

## Site Architecture

**Deployment:** AWS Amplify (auto-deploys on git push to master)
**Repo:** brentwpeterson/commerceking-ai
**Local path:** `/Users/brent/scripts/CB-Workspace/astro-sites/sites/amplify/commerceking-ai`
**Framework:** Astro (static site)
**Local dev port:** 3003 (per astro-sites port table, verify in package.json)

### Key Directories

```
src/
  components/
    sections/       # Homepage sections (Hero, Services, Solutions, FAQ, etc.)
    cards/          # Card components (Service, etc.)
    shared/         # Reusable components (Container, Title, CTA button, etc.)
  i18n/
    en.json         # English UI strings
    es.json         # Spanish UI strings
  layouts/
    Layout.astro    # Main layout
  pages/
    index.astro     # English homepage
    about.astro     # About page
    contact.astro   # Contact
    services/       # Service pages (loopstack, hubspot, ecommerce, etc.)
    es/             # Spanish mirror of all pages
  utils/
    data.ts         # English content data (services, solutions, FAQs)
    data-es.ts      # Spanish content data
    i18n.ts         # Translation helper
    getData.ts      # Data retrieval helpers
```

### i18n Approach

- Navigation, labels, UI strings: JSON i18n files (`en.json`, `es.json`) via `t(lang, key)` function
- Page content (services, solutions, FAQs): TypeScript data files (`data.ts`, `data-es.ts`)
- Spanish pages: Full mirror in `src/pages/es/` with `lang="es"` prop passed to components
- Team bios: Hard-coded in page files (not i18n keys)

### Content Change Workflow

When changing site content:

1. **English first, always.** Make all changes in English files, verify they work, then mirror to Spanish.
2. **i18n strings:** Edit `src/i18n/en.json` for UI text, then mirror to `src/i18n/es.json`
3. **Data content:** Edit `src/utils/data.ts` for services/solutions/FAQ, then mirror to `src/utils/data-es.ts`
4. **Page-level content:** Edit `src/pages/[page].astro`, then mirror to `src/pages/es/[page].astro`
5. **Components:** Most components accept `lang` prop and use `t()` for strings. Changes to component structure affect both languages.
6. **Spanish quality:** Spanish should read as native, not translated. Avoid literal translations. Use natural Mexican/neutral Spanish phrasing.

### Deployment

Push to master in the `commerceking-ai` repo. Amplify auto-builds and deploys.

From the astro-sites monorepo:
```bash
cd sites/amplify/commerceking-ai
git add .
git commit -m "description"
git push origin master
```

## Team

| Name | Role | Notes |
|------|------|-------|
| **Brent Peterson** | CEO, Founder | 5x Magento Master, Adobe Commerce Partner |
| **Isaac Peterson** | COO, Co-founder | Operations, project delivery |
| **Vijay (Evrig Solutions)** | Development Partner | Certified dev team, working with Brent since 2013 |
| **David Decker** | Project Manager | US-based PM |

## Platforms Supported

| Platform | Tier | Notes |
|----------|------|-------|
| Adobe Commerce (Magento) | Primary | Certified partner, deepest expertise |
| Shopify / Shopify Plus | Primary | Custom themes, apps, enterprise |
| BigCommerce | Primary | Headless and traditional |
| WooCommerce | Primary | WordPress-based commerce |
| Shopware | Secondary | European market, B2B strength |
| WordPress | Primary | CMS builds |
| Astro | Primary | Static/SSR sites, high performance |

## Brand Relationships

```
CommerceKing (this brand)
    ├── BUILD: Platform development (CommerceKing + Evrig)
    ├── FILL: Content creation (Content Cucumber)
    ├── GROW: Traffic & revenue (CommerceKing + CC)
    ├── AUTOMATE: Workflows & AI (RequestDesk)
    └── All leads flow into unified HubSpot CRM
```

- CommerceKing is the entry point for platform work
- LoopStack connects all four brands into a single delivery cycle
- Content Cucumber fills what CommerceKing builds
- RequestDesk automates what Content Cucumber creates
- Talk Commerce drives top-of-funnel awareness

## Ideal Customer Profile

### Primary: Mid-Market Ecommerce ($1M-$50M revenue)
- Outgrowing their current platform
- Need migrations, integrations, or custom development
- Want one partner for build + content + growth

### Secondary: Enterprise Ecommerce (Adobe Commerce)
- Complex multi-store, B2B, or marketplace requirements
- Need certified Adobe Commerce developers
- Value the Magento Master pedigree

### Tertiary: CMS/Marketing Sites
- Companies needing fast, optimized websites
- WordPress or Astro builds with AEO optimization
- Often entry point that leads to full LoopStack engagement

## Pricing Model

No published pricing. All engagements start with a free discovery call:
- **Calendly:** https://calendly.com/contentbasis/chat-with-brent (30 min)
- Scope the project, recommend platform, provide transparent proposal

## Punch List

- [ ] Update brand-family SKILL.md to include CommerceKing as 6th brand
- [ ] Create CommerceKing agent in RequestDesk with brand persona
- [ ] Add API key to workspace.env when agent is created
- [ ] Homepage messaging overhaul (see plan in Obsidian)
- [ ] Add LoopStack teaser section to homepage
- [ ] Review and improve Spanish content quality
- [ ] Create case studies / portfolio page
- [ ] Define CommerceKing content terms in RequestDesk
