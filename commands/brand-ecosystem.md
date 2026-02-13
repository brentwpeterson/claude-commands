# Brand Ecosystem - Load Complete Brand Architecture

Load the global brand ecosystem to understand how all ContentBasis brands relate, their roles, and positioning.

## Usage

```
/brand-ecosystem
```

## Instructions for Claude

When this command is run, present the full brand architecture:

### Brand Architecture

**ContentBasis** is the parent company. Four brands operate underneath it, each owning a stage of the content-to-commerce lifecycle.

| Brand | Role | One-Liner |
|-------|------|-----------|
| **ContentBasis** | **Build** | Build your store. Implementation, development, technical framework. |
| **Content Cucumber** | **Create** | Create your content. Content creation and strategy. |
| **RequestDesk** | **Push** | Push your content live. Content pipeline, branding engine, publishing. |
| **Talk Commerce** | **Broadcast** | Media arm. Podcast, interviews, industry broadcasting. |

### Content-to-Commerce Lifecycle

```
BUILD (ContentBasis) -> CREATE (Content Cucumber) -> PUSH (RequestDesk) -> BROADCAST (Talk Commerce)
```

1. **ContentBasis** builds the store, sets up integrations (Shopify, Magento, HubSpot, WordPress), handles the technical foundation
2. **Content Cucumber** creates the content (blog posts, product descriptions, landing pages, marketing copy)
3. **RequestDesk** pipelines that content to production, manages branding, handles multi-platform publishing
4. **Talk Commerce** amplifies through podcast and media coverage

### Brand Positioning Details

**ContentBasis (Parent)**
- Focus: Implementation and development
- Audience: Business owners and technical decision-makers who need e-commerce built
- Tone: Technical authority, trusted partner
- Website: contentbasis.ai
- Tagline direction: "The framework around your content"

**Content Cucumber**
- Focus: Content creation and strategy
- Audience: Businesses that need content produced at scale
- Tone: Approachable, creative, expert
- Website: contentcucumber.com
- Has its own brand persona (load with `/brand-cucumber`)

**RequestDesk**
- Focus: Content pipeline and branding engine
- Audience: Content managers, marketing teams who need to get content live
- Tone: Mentor/guide, clever but professional
- Website: requestdesk.ai (SaaS product)
- Has its own brand persona (load with `/brand-requestdesk`)

**Talk Commerce**
- Focus: Media, podcast, industry broadcasting
- Audience: E-commerce community, industry professionals
- Tone: Conversational, interview-driven, community-focused
- Website: talkcommerce.com
- Format: Podcast with guests

### Cross-Brand Rules

1. **Each brand has its own voice.** Don't mix Content Cucumber's casual tone with ContentBasis's technical authority.
2. **ContentBasis landing pages** should reference the ecosystem. Show how all brands work together.
3. **Product-specific content** should use that product's brand skill (`/brand-cucumber`, `/brand-requestdesk`).
4. **Platform integration pages** (like /hubspot, /shopify) live under ContentBasis since it's the "build" brand.
5. **When writing for Brent personally,** use `/brand-brent`. Brent is the person behind all four brands.

### When to Use Which Brand

| Content Type | Brand |
|-------------|-------|
| Store setup, integration, development | ContentBasis |
| Blog posts, product descriptions, copywriting | Content Cucumber |
| Publishing workflow, content pipeline, branding tools | RequestDesk |
| Podcast episodes, interview content, industry commentary | Talk Commerce |
| Landing pages for platform integrations (HubSpot, Shopify) | ContentBasis |
| SaaS product features and docs | RequestDesk |
| Personal thought leadership | Brent (`/brand-brent`) |

---

After presenting, ask:
```
Brand ecosystem loaded. Which brand are you working with today?
```

## What This Enables

With the ecosystem loaded, Claude can:
- Correctly position content under the right brand
- Write landing pages that reference the full lifecycle
- Avoid mixing brand voices across properties
- Understand cross-brand relationships for integration pages
- Route content creation to the right brand persona
