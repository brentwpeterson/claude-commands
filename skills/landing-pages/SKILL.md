# Landing Page System - Skill Reference

**Skill Description:** Complete reference for the JSON-driven landing page system on contentcucumber.com. Covers all section types, data shapes, visual rhythm rules, and file locations.

## When Claude Should Apply This Skill

- User mentions "landing page", "landing pages", "JSON landing", "section types"
- User wants to create, modify, or audit a landing page
- User asks about available sections or layout options
- User runs `/landing` command

## Key Files

| File | Who reads it | Purpose |
|---|---|---|
| `.claude/skills/landing-pages/SKILL.md` | Claude | Section types, data shapes, variant system |
| `.claude/skills/landing-pages/registry.md` | Claude | Usage counts, variant caps, migration tracking |
| `brent-workspace/ob-notes/Brent Notes/Sales and Marketing/Company Websites/Content Cucumber/Page Inventory.md` | Brent (Obsidian) | Human-readable version: full site inventory, variant tracking, migration priority, WP admin edit links |

**Keep Obsidian and registry in sync.** When a page is migrated or a variant is used, update both.

## Architecture Overview

Landing pages are built from JSON files. Each page has a `.json` file in the theme's `landing-data/` directory. The PHP template (`page-landing-json.php`) loops through the `sections` array and renders each section type using a switch statement. No page builder. No Gutenberg blocks. Just JSON + PHP + CSS.

**Template:** `themes/cucumber-gp-child/page-landing-json.php`
**Homepage renderer:** `themes/cucumber-gp-child/template-parts/homepage-json-renderer.php`
**JSON directory:** `themes/cucumber-gp-child/landing-data/`
**CSS:** `themes/cucumber-gp-child/style.css` (all section CSS exists)
**Theme path:** `/Users/brent/LocalSites/contentcucumber/app/public/wp-content/themes/cucumber-gp-child/`

## Variant System

**Every section supports a `variant` key in the JSON.** When omitted, it defaults to `"default"`. When set, the PHP template adds a CSS modifier class (e.g., `cc-landing__challenges--alternating`) that changes the visual layout without changing the content structure.

```json
{
    "type": "challenges",
    "variant": "alternating",
    "data": { ... }
}
```

### Why Variants Exist

The same section type rendered the same way on every page makes the site feel repetitive. The numbered card grid (challenges:default) appeared on 5 of 5 landing pages. It was fresh once, looked great twice, felt stale by the third time, and became repulsive by the fourth. Variants give the same content type a different visual presentation.

### Usage Cap Rule

**No section:variant combo should appear on more than 4 pages.** When it hits the cap, the next page MUST use a different variant. The registry tracks counts.

**Registry file:** `.claude/skills/landing-pages/registry.md`

**BEFORE creating or modifying a landing page, ALWAYS:**
1. Read the registry
2. Check which section:variant combos are at or over cap
3. Choose variants that aren't overused
4. After making changes, UPDATE the registry with new counts

### Implemented Variants

| Section | Variant | CSS class | Status |
|---|---|---|---|
| challenges | `default` | (base) | 5 pages, OVER CAP |
| challenges | `alternating` | `cc-landing__challenges--alternating` | Implemented, available |
| All others | `default` | (base) | See registry for counts |

New variants need: PHP markup in the case block + CSS in style.css. The variant system is built to support any section type, but only challenges has alternates implemented so far. Build more as needed.

## Existing Landing Pages

| JSON file | URL slug | Section count | Unique sections |
|---|---|---|---|
| `agency-white-label.json` | `/agency-white-label/` | 11 | services, ecosystem |
| `conference-video.json` | `/conference-video/` | 11 | video-embed (x2) |
| `growth-marketing.json` | `/growth-marketing/` | 9 | shift |
| `hubspot-audit.json` | `/hubspot-audit/` | 9 | video-embed |
| `hubspot-loop-marketing.json` | `/hubspot-loop-marketing/` | 10 | shift, ecosystem |
| `homepage.json` | `/` (front page) | 9 | hero-terminal, services-grid, partner-carousel, case-study, comparison-table, latest-posts |

**Note:** Homepage uses `homepage-json-renderer.php`, not `page-landing-json.php`. Some section types are only in one renderer. Phase 2 work will unify them.

## Section Types Reference

### Available in `page-landing-json.php` (landing pages)

#### `hero`
Full-width hero with headline, paragraphs, and either an image or HubSpot form.
**Background:** Dark gradient (#1a1a2e)
```json
{
    "type": "hero",
    "data": {
        "eyebrow": "Short label above title (optional)",
        "title": "Main headline (supports <br>, <em>, <strong>)",
        "paragraphs": ["Paragraph 1", "Paragraph 2"],
        "image": "relative-path-in-landing-data/image.webp (optional)",
        "image_alt": "Alt text (optional, used with image)",
        "content_image": "Full URL for inline image (optional)",
        "content_image_alt": "Alt text (optional)",
        "video_bg": "relative-path/video.mp4 (optional, video background)",
        "video_bg_poster": "relative-path/poster.webp (optional, video poster)",
        "platforms_label": "Label for platform logos (optional)",
        "platforms": "HTML string of platform names (optional)"
    }
}
```
**Form config:** Hero displays HubSpot form when `form.form_id` exists at top-level JSON and no `image` is set.

#### `proof-bar`
Horizontal row of stats/logos. Dark background.
**Background:** Dark (#1a1a2e)
```json
{
    "type": "proof-bar",
    "data": [
        { "number": "40+", "label": "Human Writers" },
        { "logo": "https://example.com/logo.png", "label": "Partner Name" }
    ]
}
```
**Note:** `data` is an array, not an object. Each item has either `number` OR `logo`, plus `label`.

#### `challenges`
Card grid showing pain points. Numbered cards with stagger animation.
**Background:** White (#ffffff)
```json
{
    "type": "challenges",
    "data": {
        "title": "Section title",
        "subtitle": "Section subtitle",
        "items": [
            {
                "number": "01",
                "title": "Card title",
                "text": "Card description",
                "image": "relative-path/image.webp (optional)"
            }
        ]
    }
}
```

#### `services` / `services-grid`
Icon card grid for service offerings. Uses `$service_icons` array. Both type names work (fallthrough alias).
**Background:** Light gray (#f9fafb)
```json
{
    "type": "services",
    "data": {
        "title": "Section title",
        "subtitle": "Section subtitle",
        "items": [
            {
                "icon": "pen",
                "title": "Service name",
                "text": "Service description",
                "link": "/optional-url/",
                "link_text": "Learn more (optional, defaults to 'Learn more')"
            }
        ]
    }
}
```
**Available icons:** `pen`, `megaphone`, `video`, `chart`, `globe`, `shield`, `zap`

#### `how-it-works`
Numbered steps with connecting visual line. Dark background.
**Background:** Dark (#1a1a2e)
```json
{
    "type": "how-it-works",
    "data": {
        "title": "Section title",
        "subtitle": "Section subtitle",
        "steps": [
            {
                "number": "01",
                "title": "Step title",
                "text": "Step description"
            }
        ]
    }
}
```

#### `shift`
Two-column: narrative left, old-way vs new-way comparison cards right.
**Background:** Light gray (#f9fafb)
```json
{
    "type": "shift",
    "data": {
        "eyebrow": "Optional label",
        "title": "Section title (supports HTML)",
        "paragraphs": ["Narrative paragraph 1", "Paragraph 2"],
        "old_way": {
            "heading": "The Old Way",
            "items": ["Problem 1", "Problem 2"]
        },
        "new_way": {
            "heading": "The New Way",
            "items": ["Solution 1", "Solution 2"]
        }
    }
}
```

#### `bundles`
Pricing/service tier cards. One can be featured with a badge.
**Background:** White (#ffffff)
```json
{
    "type": "bundles",
    "data": {
        "title": "Section title",
        "subtitle": "Section subtitle",
        "items": [
            {
                "name": "Bundle name",
                "target": "Who it's for",
                "outcome": "Expected outcome",
                "measures": "What we measure",
                "price": "$X/mo (optional)",
                "featured": true,
                "badge": "Most Popular (optional, shown on featured)",
                "stages": "Loop stages (optional)",
                "outcomes": [
                    "Bullet point 1 (supports <a> tags)",
                    "Bullet point 2"
                ]
            }
        ]
    }
}
```

#### `outcomes`
Icon cards showing results/benefits. Uses `$icons` array (not `$service_icons`).
**Background:** Light gray (#f9fafb)
```json
{
    "type": "outcomes",
    "data": {
        "title": "Section title",
        "subtitle": "Section subtitle",
        "items": [
            {
                "icon": "users",
                "title": "Outcome title",
                "text": "Outcome description"
            }
        ]
    }
}
```
**Available icons:** `users`, `chart`, `search`, `growth`, `settings`

#### `credibility`
Two-column: narrative text left, stat cards right. Dark background.
**Background:** Dark gradient
```json
{
    "type": "credibility",
    "data": {
        "eyebrow": "Optional label",
        "title": "Section title",
        "paragraphs": ["Paragraph 1", "Paragraph 2"],
        "stats": [
            { "number": "30+", "label": "Years in Ecommerce" }
        ]
    }
}
```

#### `video-embed`
YouTube video embed with optional side content. Two-column layout.
**Background:** White (#ffffff)
```json
{
    "type": "video-embed",
    "data": {
        "youtube_id": "dQw4w9WgXcQ",
        "title": "Video title",
        "aspect": "9x16 or 16x9 (default: 9x16)",
        "caption": "Optional caption below video",
        "label": "Optional label above heading",
        "heading": "Optional heading (supports HTML)",
        "paragraphs": ["Optional side text"],
        "points": ["Optional bullet point 1", "Point 2"]
    }
}
```

#### `faq`
Accordion FAQ list using `<details>` elements.
**Background:** White (#ffffff)
```json
{
    "type": "faq",
    "data": {
        "title": "Section title",
        "items": [
            {
                "question": "The question?",
                "answer": "The answer."
            }
        ]
    }
}
```

#### `ecosystem`
Brand card grid with optional cross-CTAs. Shows related brands.
**Background:** Light gray (#f9fafb)
```json
{
    "type": "ecosystem",
    "data": {
        "title": "Section title",
        "subtitle": "Section subtitle",
        "brands": [
            {
                "name": "Brand Name",
                "role": "Brand role",
                "description": "What it does",
                "current": true,
                "url": "https://example.com (optional, not shown if current)",
                "link_text": "CTA text (optional)"
            }
        ],
        "cross_ctas": [
            { "text": "CTA label", "url": "https://example.com" }
        ]
    }
}
```

#### `bottom-cta`
Final call-to-action with optional HubSpot form.
**Background:** Green gradient
```json
{
    "type": "bottom-cta",
    "data": {
        "title": "CTA headline",
        "text": "CTA description"
    }
}
```
**Form config:** Displays HubSpot form when `form.form_id` exists at top-level JSON.

### Available ONLY in `homepage-json-renderer.php` (not yet in landing pages)

These will be added to `page-landing-json.php` in Phase 2:

| Type | What it does | Complexity to port |
|---|---|---|
| `hero-terminal` | Rotating headline + terminal animation | High (homepage-specific) |
| `partner-carousel` | Logo carousel from cc_partner CPT | Medium (needs WP_Query + JS) |
| `case-study` | Two-column: text + stats + chart image | Low (self-contained) |
| `latest-posts` | Recent blog posts grid via WP_Query | Low (self-contained) |
| `comparison-table` | Wraps `[requestdesk_comparison_table]` shortcode | Trivial |

## Top-Level JSON Structure

Every landing page JSON has this shape:

```json
{
    "seo": {
        "meta_description": "Page meta description",
        "og_description": "Open Graph description",
        "og_image": "Optional OG image URL"
    },
    "form": {
        "header": "Form card header",
        "subtitle": "Form card subtitle",
        "trust_text": "Trust line below form",
        "portal_id": "HubSpot portal ID",
        "form_id": "HubSpot form ID",
        "region": "na1"
    },
    "thankyou": {
        "title": "Thank you heading",
        "text": "Thank you message",
        "link_anchor": "Optional anchor",
        "link_text": "Optional link text"
    },
    "sections": [
        { "type": "hero", "data": { ... } },
        { "type": "proof-bar", "data": [ ... ] }
    ]
}
```

**Sections can also have an `anchor` property** for scroll-to links:
```json
{ "type": "bundles", "anchor": "pricing", "data": { ... } }
```

## Visual Rhythm Rules

**Never stack two sections with the same background color.**

| Background | Color | Section types |
|---|---|---|
| Dark | #1a1a2e | hero, proof-bar, how-it-works, credibility |
| White | #ffffff | challenges, bundles, video-embed, faq |
| Light gray | #f9fafb | services, shift, outcomes, ecosystem |
| Green gradient | linear-gradient | bottom-cta |

**Consistent bookends:**
- Opening: `hero` > `proof-bar` (always)
- Closing: `faq` > `bottom-cta` (always, ecosystem can go before faq)

**Middle section arrangement:** Alternate backgrounds. Example good rhythm:
- challenges (white) > services (gray) > how-it-works (dark) > bundles (white) > outcomes (gray)

**Example bad rhythm (stacked whites):**
- challenges (white) > bundles (white) > faq (white) -- three whites in a row

## Creating a New Landing Page

1. Create `landing-data/{slug}.json` with the top-level structure
2. Arrange sections in the `sections` array
3. Check visual rhythm (no stacked same-background sections)
4. Create a WordPress page with slug matching the filename
5. Set the page template to "Landing Page - JSON"
6. Test at `contentcucumber.local/{slug}/`

## WordPress Setup

Each landing page needs a WordPress page:
- **Slug** must match the JSON filename (e.g., `agency-white-label` slug = `agency-white-label.json`)
- **Page template** must be set to "Landing Page - JSON"
- The JSON file drives all content. The WP page is just a URL container.
