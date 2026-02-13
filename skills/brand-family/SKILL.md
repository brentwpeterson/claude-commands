# Brand Family - Unified Brand Ecosystem

## Overview

Five brands working together to deliver full-service marketing, content, media, technology, and thought leadership. Each brand has a distinct role. Together they cover 26 services across 10 categories.

---

## The Five Brands

### 1. Content Basis (Parent Company / Agency)
**Domain:** contentbasis.ai
**Type:** Full-service marketing agency
**Tagline:** "AI Enabled Content Platform with Humans in the Loop"
**Services:** 11 (advertising, brand, design, CRO, analytics, strategy, management, web development)
**Skill:** `.claude/skills/brand-contentbasis/SKILL.md`

Content Basis is the client-facing agency. When a client needs a marketing department, they hire Content Basis. CB coordinates all other brands under one relationship.

### 2. Content Cucumber (Content Creation)
**Domain:** contentcucumber.com
**Type:** Human-first content creation agency (40+ writers)
**Stats:** 60K+ projects, 55M+ words, 4.9/5 rating
**Services:** 10 (blog, SEO, copy, email, social, AEO, product descriptions, category pages, commerce bundle, sales enablement)
**Skill:** `.claude/skills/content-cucumber/SKILL.md`

Content Cucumber creates content. Human writers who learn your brand voice.

### 3. RequestDesk (Technology Platform)
**Domain:** requestdesk.ai / app.requestdesk.ai
**Type:** SaaS platform + professional services
**Tagline:** "AI-Powered Content Management and Request Processing Platform"
**Services:** 3 (custom integrations, MCP servers, marketing automation)
**Skill:** `.claude/skills/brand-requestdesk/` (needs full skill build)

RequestDesk is the technology. Powers content management, brand voice, AI agents, and automation.

### 4. Talk Commerce (Media)
**Domain:** talkcommerce.com
**Type:** Media property + production service
**Tagline:** "Helping bridge the divide between agency, developer and merchant"
**Services:** 2 (video production, webinar production)
**Skill:** `.claude/skills/brand-talkcommerce/SKILL.md`

Talk Commerce is the voice. Podcasts, video, webinars, and media production.

### 5. Brent Peterson (Personal Brand)
**LinkedIn:** https://www.linkedin.com/in/brentwpeterson/
**Type:** Thought leadership, speaking, consulting
**Services:** None directly (commerce consulting goes through Content Basis)
**Skill:** `.claude/skills/brand-brent/SKILL.md`

Brent is the founder and face. 5x Magento Master, 33 marathons, conference speaker, podcast host.

---

## Service-to-Brand Mapping (26 services)

### Content Cucumber (10 services)

| Shortcode | Service | Category |
|---|---|---|
| `blog` | Blog Writing | Content Creation |
| `seo` | SEO Content | Content Creation |
| `website-copy` | Website Copy | Content Creation |
| `email` | Email Marketing | Content Creation |
| `social` | Social Media Content | Content Creation |
| `aeo` | AEO Optimization | Content Creation |
| `product-desc` | Product Descriptions | Commerce |
| `category-pages` | Category Pages | Commerce |
| `content-commerce` | Content in Commerce (bundle) | Commerce |
| `sales-content` | Sales Enablement Content | Content Creation |

### Content Basis (11 services)

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

### RequestDesk (3 services)

| Shortcode | Service | Category |
|---|---|---|
| `custom-integration` | Custom Integrations | Technology |
| `mcp-creation` | MCP Server Creation | Technology |
| `marketing-auto` | Marketing Automation | Automation |

### Talk Commerce (2 services)

| Shortcode | Service | Category |
|---|---|---|
| `video` | Video Production | Production |
| `webinar` | Webinar Production | Production |

---

## Brand Relationships

```
                   Brent Peterson
                  (Founder / Face)
                        |
            +-----------+-----------+
            |           |           |
     Talk Commerce  Content Basis  (Personal Brand)
     (Media/Voice)  (Agency Hub)   (Thought Leadership)
            |           |
            |     +-----+-----+
            |     |           |
            | Content     RequestDesk
            | Cucumber    (Platform)
            | (Writers)
            |
     All brands feed leads into unified HubSpot CRM
```

### How Services Flow

When Content Basis lands a client that needs the full stack:
- **Content creation** is fulfilled by Content Cucumber writers
- **Media production** is fulfilled by Talk Commerce
- **Automation and integrations** are fulfilled by RequestDesk
- **Strategy, management, design, ads, CRO** are handled directly by Content Basis
- **The client has one relationship** with Content Basis

---

## When to Use Which Brand

| Scenario | Brand | Reason |
|---|---|---|
| Client needs blog posts written | Content Cucumber | Content creation |
| Client needs marketing strategy | Content Basis | Agency services |
| Client needs a marketing department | Content Basis | Marketing management |
| Client needs paid ad management | Content Basis | Advertising |
| Client needs a website built | Content Basis | Web development |
| Client needs video production | Talk Commerce | Media production |
| Client needs webinars | Talk Commerce | Media production |
| Client needs systems connected | RequestDesk | Technology |
| Client needs MCP servers | RequestDesk | Technology |
| Client needs marketing automation | RequestDesk | Automation |
| Podcast guest outreach | Talk Commerce | Media property |
| Selling the SaaS platform | RequestDesk | Product |
| Speaking at conferences | Brent / Talk Commerce | Thought leadership |
| Technical documentation | RequestDesk | Product content |
| Case studies | Content Basis | Agency proof |
| Social media (industry insights) | Talk Commerce or Brent | Media voice |
| Social media (product updates) | RequestDesk | Product voice |
| LinkedIn thought leadership | Brent | Personal brand |
| Newsletter content | Brent | "The Agentic Commerce Guy" |

---

## Cross-Brand Rules

1. **Always link between brands** where relevant
2. **Core values apply to all:** AI + Human, quality, e-commerce focus, humans always in the loop
3. **Clear handoffs** when leads move between brands
4. **Unified CRM** (single HubSpot instance for all brands)
5. **No brand confusion** - be explicit about which entity is being discussed
6. **Content Basis is the client-facing agency** - when bundling services, the relationship lives here
7. **No em dashes across any brand** - periods, commas, or parentheses only

---

## Individual Brand Skills

| Brand | Skill | Command | API Key |
|---|---|---|---|
| Content Cucumber | `.claude/skills/content-cucumber/SKILL.md` | `/brand-cucumber` | `spF-vAD3...` |
| Content Basis | `.claude/skills/brand-contentbasis/SKILL.md` | `/brand-contentbasis` (needs creation) | Needs creation |
| RequestDesk | Needs full skill build | `/brand-requestdesk` | `ZNgUN47Q...` |
| Talk Commerce | `.claude/skills/brand-talkcommerce/SKILL.md` | `/brand-talkcommerce` (needs creation) | Needs creation |
| Brent | `.claude/skills/brand-brent/SKILL.md` | `/brand-brent` | `MNRcaklW...` |

---

## Brand Obsidian Docs

Human-readable brand bibles for each brand:
- `brent-workspace/ob-notes/Brent Notes/Sales and Marketing/brands/content-cucumber.md`
- `brent-workspace/ob-notes/Brent Notes/Sales and Marketing/brands/content-basis.md`
- `brent-workspace/ob-notes/Brent Notes/Sales and Marketing/brands/requestdesk.md`
- `brent-workspace/ob-notes/Brent Notes/Sales and Marketing/brands/talk-commerce.md`
- `brent-workspace/ob-notes/Brent Notes/Sales and Marketing/brands/brent-peterson.md`

---

## Master Punch List

### Phase 1: Complete (local skills and Obsidian docs)
- [x] Brand skills for all 5 brands
- [x] Obsidian brand bibles for all 5 brands
- [x] Service-to-brand mapping (26 services across 4 brands)

### Phase 2: Create missing RequestDesk agents (Brent to do)
- [ ] Create Content Basis agent in RequestDesk
- [ ] Create Talk Commerce agent in RequestDesk
- [ ] Add API keys to workspace.env

### Phase 3: Upgrade commands (after Phase 2)
- [ ] Create `/brand-contentbasis` command
- [ ] Create `/brand-talkcommerce` command
- [ ] Upgrade `/brand-cucumber` to match `/brand-brent` quality
- [ ] Upgrade `/brand-requestdesk` to match `/brand-brent` quality
- [ ] Build full RequestDesk brand skill (`.claude/skills/brand-requestdesk/SKILL.md`)

### Phase 4: Fill in pricing
- [ ] Define pricing grids for all 26 services
- [ ] Fill $X,XXX placeholders in service-types.md

### Phase 5: External
- [ ] Build service pages on contentbasis.ai (11 services)
- [ ] Build service pages on contentcucumber.com (10 services)
- [ ] Add production services to talkcommerce.com
- [ ] Add professional services to requestdesk.ai
- [ ] Pitch decks for each brand
- [ ] Taglines for Content Cucumber and Talk Commerce
