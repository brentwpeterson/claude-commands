# Brand: Content Basis

Marketing services agency. The strategic arm that delivers marketing, web development, advertising, and consulting.

## Brand Identity

| Field | Value |
|---|---|
| **Name** | Content Basis |
| **Domain** | contentbasis.ai |
| **Type** | Agency / Consultancy |
| **Word** | Build |
| **Tagline** | Build your digital foundation. |
| **Parent** | Content Basis is the parent company of Content Cucumber, RequestDesk, and Talk Commerce |

## Positioning

**Sentence:** We build CMS sites, implement AI solutions, and create the integrations and automations that make your digital business run.

**Paragraph:** Content Basis builds the technical foundation for your digital business. We build CMS sites, implement AI solutions, create integrations across platforms like WordPress and ButterCMS, and consult on workflows and automations. We train AI agents to work the way your business works. Whether you need a site built, systems connected, or AI that actually understands your operations, Content Basis handles the build.

## What We Do

- Build CMS sites
- Implement AI solutions
- Consult on AI
- Consult on workflows and automations
- Create integrations (WordPress, ButterCMS, etc.)
- Train AI agents

**Key differentiator:** Platform-agnostic. Vendor-neutral. We build the technical infrastructure that makes everything else work.

## Voice and Tone

> **Baseline writing rules come from `/brand-brent`.** All rules below inherit from brand-brent (no em dashes, no emojis, no vague hooks, active voice, banned phrase list). Brand-specific adjustments below override or extend the baseline where noted.

- Strategic, knowledgeable, solutions-oriented
- Confident authority backed by experience (5x Magento Master, 60K+ projects across the ecosystem)
- Focus on implementation and results, not theory
- Client is the hero, Content Basis is the guide
- Professional but not corporate. Direct but not cold.

### Never Use
- Em dashes (use periods, commas, or parentheses)
- Emojis (unless explicitly requested)
- "Game-changing," "revolutionary," "cutting-edge," "groundbreaking"
- "In the ever-evolving world of"
- "Delve," "synergy," "leverage" (as buzzwords)
- "Unlock your potential"
- Anything that sounds like a sales pitch instead of expert guidance

### Always Use
- First person plural ("we") when representing the agency
- Specific examples and concrete results
- Client-hero language ("your business," "your goals," "your growth")
- Plain language over jargon
- Active voice

## Services (11)

Content Basis owns and delivers these services:

| Shortcode | Service | Category |
|---|---|---|
| `paid-media` | Paid Advertising Management | Advertising |
| `brand-strategy` | Brand Strategy / Identity | Brand & Design |
| `design` | Graphic Design | Brand & Design |
| `cro` | Conversion Rate Optimization | Conversion |
| `competitive-intel` | Competitive Intelligence | Analytics |
| `flywheel` | Content Flywheel Plan | Strategy |
| `marketing-mgmt` | Marketing Management | Management |
| `cms-implementation` | CMS Implementation | Web Development |
| `wp-turnkey` | WordPress Turnkey Site | Web Development |
| `wp-maintenance` | WordPress Maintenance | Web Development |
| `llm-discovery` | Commerce LLM Discovery | Analytics |

**Service definitions** live in `.claude/skills/proposal-creation/service-types.md`.

When a client engagement includes content creation (blog, SEO, email, social, product descriptions), Content Basis subcontracts to Content Cucumber. When it includes video or webinar production, Content Basis subcontracts to Talk Commerce. The client relationship stays with Content Basis.

## Ideal Customer Profile

### Primary: E-Commerce Platform Consulting
- **Revenue:** $10M+ annual
- **Decision maker:** CTO, VP of E-commerce, Director of Digital Commerce
- **Pain:** Platform selection, failed migrations, outgrown current capabilities
- **Deal size:** $10K+ projects, goal is $3K-$10K/month retainers ($36K-$120K annual)
- **Differentiator:** Platform-agnostic. We find the best fit for YOUR business, not push a preferred vendor.

### Secondary: Marketing Management Clients
- **Revenue:** $1M+ annual
- **Pain:** No marketing department, inconsistent execution, no strategy
- **Deal size:** $3K-$10K/month retainer
- **What they get:** Content Basis becomes their outsourced marketing team

### Tertiary: Technology Platforms and SaaS Companies
- **Type:** E-commerce platforms, SaaS serving e-commerce
- **Needs:** Case studies, comparison papers, thought leadership
- **High-value services:** Case studies ($1,500 each), platform comparison papers ($1,500-$4,000)

## E-Commerce Expertise

- 5x Magento Master Recognition
- Platform-agnostic: Adobe Commerce, Shopify Plus, BigCommerce, Salesforce Commerce, and emerging platforms
- Regular speaker at Magento/Adobe Commerce events, eTail moderator
- Vendor-neutral analysis and selection consulting

## Brand Relationships

```
Content Basis (this brand)
    ├── Content Cucumber (content creation arm)
    ├── Talk Commerce (media arm)
    └── RequestDesk (technology platform)
```

- Content Basis is the **client-facing agency** that bundles services from all brands
- Content Cucumber writers are available to all Content Basis engagements
- Talk Commerce media services are available to all Content Basis engagements
- RequestDesk powers the content automation backend
- All leads flow into a unified HubSpot CRM

## API Integration

**Status:** No RequestDesk agent exists yet. Needs to be created.

When the agent is created, add the API key here:

```
Endpoint: https://app.requestdesk.ai/api/agent/content
Method: POST
Auth: Bearer [CONTENT_BASIS_API_KEY]
```

## Punch List

- [ ] Create Content Basis agent in RequestDesk with brand persona
- [ ] Add API key to workspace.env and this skill
- [ ] Create `/brand-contentbasis` command file in `.claude-local/commands/`
- [ ] Define Content Basis content terms (avoid/use lists) in RequestDesk
- [ ] Build out contentbasis.ai service pages for all 11 services
- [ ] Create case study template for Content Basis engagements
- [ ] Define pricing for all 11 services (fill in $X,XXX placeholders)
- [ ] Clarify Content Basis vs Content Cucumber positioning in all client-facing materials
- [ ] Set up Content Basis social media presence (LinkedIn company page)
- [ ] Create Content Basis pitch deck
