# Landing Page Registry

**Purpose:** Track ALL site pages, layout usage, migration status, and enforce visual variety.

**Rule:** No section:variant combo should appear on more than 4 pages. When it hits the cap, the next page MUST use a different variant. As the site grows past 20 JSON pages, revisit the cap.

**Last updated:** 2026-03-12

## Full Site Inventory

### JSON Landing Pages (live on `page-landing-json.php`)

| # | Page | Slug | Archetype | Status |
|---|---|---|---|---|
| 1 | Agency White Label | agency-white-label | Partner | Live |
| 2 | Conference Video | conference-video | Campaign | Live |
| 3 | Growth Marketing | growth-marketing | Service | Live |
| 4 | Free HubSpot Audit | hubspot-audit | Service | Live |
| 5 | HubSpot Loop Marketing | hubspot-loop-marketing | Service | Live |
| 6 | Conference Interview | conference-interview | Campaign | Draft (needs HubSpot form + WP page) |
| 7 | Conference PR Agencies | conference-pr | Partner | Draft (needs HubSpot form + WP page) |
| 8 | 90-Day Revenue Engine Webinar | revenue-engine-webinar | Campaign | Draft (needs HubSpot form + WP page + header image) |
| 9 | We Write Case Studies | we-write-case-studies | Campaign | Draft (needs WP page + HubSpot form ID) |

### Homepage (separate renderer: `homepage-json-renderer.php`)

| # | Page | Slug | Notes |
|---|---|---|---|
| 6 | HOME | / (front-page.php) | Uses homepage.json, hero-terminal, partner-carousel. Not migrating. |

### Block Editor Pages: MIGRATE TO JSON

These are the v1 imports. All use Gutenberg blocks with `wp:cover` hero sections. Most follow identical patterns (hero > content blocks). They need to be replaced with JSON landing pages using varied archetypes and variants.

**Batch 1: Service Pages (all ~17K chars, identical `hero--teal` pattern)**
These 8 pages are nearly identical layouts. They were bulk-created from a template.

| # | Page | Slug | Content size | Priority | Suggested archetype |
|---|---|---|---|---|---|
| 7 | SEO Content | seo-content | 17,859 | High | Service |
| 8 | Blog Writing | blog-writing | 17,820 | High | Service |
| 9 | Email Marketing | email-marketing | 17,642 | Medium | Service |
| 10 | Website Copy | website-copy | 17,632 | Medium | Service |
| 11 | Social Media Content | social-media-content | 17,595 | Medium | Service |
| 12 | Product Descriptions | product-descriptions | 17,579 | Medium | Service |
| 13 | AEO Optimization | aeo-optimization | 17,548 | High | Product |
| 14 | Category Pages | category-pages | 17,536 | Low | Service |

**Batch 2: Service Pages (smaller, `hero--navy` pattern)**
Older, shorter pages. Different hero color but same structure.

| # | Page | Slug | Content size | Priority | Suggested archetype |
|---|---|---|---|---|---|
| 15 | Content Creation | content-creation | 6,104 | Medium | Service |
| 16 | Content in Commerce | content-in-commerce | 6,148 | Low | Authority |
| 17 | Marketing Management | marketing-management | 6,161 | Medium | Service |

**Batch 3: Specialty Pages (unique layouts)**
Each has a distinct purpose and may need a custom archetype.

| # | Page | Slug | Content size | Priority | Suggested archetype |
|---|---|---|---|---|---|
| 18 | Services (hub) | services | 13,806 | High | Product (hub page) |
| 19 | Shopify Content | shopify-content-services | 11,321 | Medium | Partner |
| 20 | Commerce LLM Discovery | commerce-llm-discovery | 17,848 | High | Product |
| 21 | Welcome ContentBasis | contentbasis | 14,109 | Low | Partner |

**Batch 4: GenerateBlocks Pages (custom layouts)**
Built with GenerateBlocks, more complex. May need new section types.

| # | Page | Slug | Content size | Priority | Suggested archetype |
|---|---|---|---|---|---|
| 22 | About Us | about-us | 19,045 | Medium | Authority |
| 23 | Case Studies | casestudies | 28,594 | High | Authority |
| 24 | Content Flywheel Plan | content-flywheel-plan | 26,225 | High | Product |
| 25 | AI-Ready Workshop | ai-ready-plan | 17,750 | Medium | Campaign |
| 26 | Classic On-Demand | classic | 23,117 | Low | Service |
| 27 | Contact Us | contact | 23,933 | Low | (keep as-is, form page) |

### Keep As-Is (no migration needed)

| # | Page | Slug | Reason |
|---|---|---|---|
| 28 | Blog | blog | WP blog index, no custom layout |
| 29 | Our Writers | our-writers | Custom PHP template, dynamic author data |
| 30 | Privacy Policy | privacy-policy | Legal text, no design needed |
| 31 | Terms of Service | terms-of-service | Legal text, no design needed |
| 32 | Credits | credits | Reference page |
| 33 | Affiliates | affiliates | Minimal stub |
| 34 | The Content Cookbook | the-content-cookbook | Empty stub |

**Total pages to migrate: 21**
**Total JSON pages when done: 26** (5 current + 21 migrated)

## Migration Variant Plan

With 26 pages, we need at least 7 variants per overused section to stay under cap of 4. Here's the minimum variant inventory needed:

| Section | Variants needed | Currently implemented | Gap |
|---|---|---|---|
| challenges | 7 | 2 (default, alternating) | 5 more needed |
| bundles | 7 | 1 (default) | 6 more needed |
| outcomes | 7 | 1 (default) | 6 more needed |
| hero | 7 | 1 (default, + video-bg exists) | 5 more needed |
| credibility | 7 | 1 (default) | 6 more needed |

**We don't need all variants on day 1.** Build them as pages are migrated:
- Migrate batch of 4 pages > hit cap > build next variant > migrate next batch of 4

## Variant Assignment Matrix

When migrating, assign variants to ensure no combo exceeds the cap. This matrix tracks assignments.

### challenges variants

| Variant | Pages (max 4) | Slots remaining |
|---|---|---|
| `default` | agency-white-label, conference-video, growth-marketing, hubspot-audit, hubspot-loop-marketing | OVER (5/4) - need to move 1 |
| `alternating` | revenue-engine-webinar, we-write-case-studies | 2 |
| `icon-cards` | (not yet implemented) | 4 |
| `compact` | (not yet implemented) | 4 |
| `(need more)` | | |

### hero variants

| Variant | Pages (max 4) | Slots remaining |
|---|---|---|
| `default` | agency-white-label, conference-video, growth-marketing, hubspot-audit, hubspot-loop-marketing, revenue-engine-webinar | OVER (6/4) - need to move 2 |
| `centered` | (not yet implemented) | 4 |
| `video-bg` | (PHP exists, 0 assigned) | 4 |
| `(need more)` | | |

### bundles variants

| Variant | Pages (max 4) | Slots remaining |
|---|---|---|
| `default` | agency-white-label, conference-video, growth-marketing, hubspot-audit, hubspot-loop-marketing | OVER (5/4) |
| `comparison` | (not yet implemented) | 4 |
| `stacked` | (not yet implemented) | 4 |

### outcomes variants

| Variant | Pages (max 4) | Slots remaining |
|---|---|---|
| `default` | agency-white-label, conference-video, growth-marketing, hubspot-audit, hubspot-loop-marketing | OVER (5/4) |
| `metrics` | (not yet implemented) | 4 |
| `checklist` | (not yet implemented) | 4 |

### services variants

| Variant | Pages (max 4) | Slots remaining |
|---|---|---|
| `default` | agency-white-label | 3 |
| `horizontal` | (not yet implemented) | 4 |
| `grid-2` | (not yet implemented) | 4 |

### how-it-works variants

| Variant | Pages (max 4) | Slots remaining |
|---|---|---|
| `default` | agency-white-label, hubspot-audit, revenue-engine-webinar | 1 |
| `timeline` | (not yet implemented) | 4 |
| `cards` | (not yet implemented) | 4 |

### shift variants

| Variant | Pages (max 4) | Slots remaining |
|---|---|---|
| `default` | conference-video, growth-marketing, hubspot-loop-marketing, revenue-engine-webinar | AT CAP (4/4) |
| `side-by-side` | (not yet implemented) | 4 |

### credibility variants

| Variant | Pages (max 4) | Slots remaining |
|---|---|---|
| `default` | agency-white-label, conference-video, growth-marketing, hubspot-loop-marketing, revenue-engine-webinar | OVER (5/4) |
| `stats-bar` | (not yet implemented) | 4 |

## Exempt Sections

These sections are intentionally consistent across pages and don't count toward variety:
- `proof-bar` - brand consistency element
- `faq` - accordion pattern is expected and functional
- `bottom-cta` - CTA + form is conversion-focused, consistency helps

## Feedback Log

Record user feedback on specific pages here. Future sessions MUST read this before creating or modifying pages.

| Date | Page | Feedback |
|---|---|---|
| 2026-02-24 | agency-white-label | challenges:default is overused. "Fresh once, looked great 2nd time, felt old 3rd time, repulsive 4th time." The numbered 2x2 card grid needs variants. |
| 2026-02-24 | (site-wide) | All v1 block editor pages need to be replaced with JSON landing pages. 17 service pages are nearly identical Gutenberg layouts. The entire site feels repetitive. |

## How to Update This Registry

1. After creating or modifying a landing page, update the Usage Tally and Variant Assignment Matrix
2. After user gives feedback, add it to the Feedback Log
3. When a variant is implemented (PHP + CSS exists), mark it in the matrix
4. When a page is migrated from block editor to JSON, move it from "MIGRATE" to the JSON Landing Pages table
5. Re-count section:variant usage after every migration batch
