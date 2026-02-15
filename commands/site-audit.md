# Site Audit - Full-Site SEO/AEO/AIO Analysis for Astro Sites

Comprehensive site-level audit that catches everything WordPress plugins (Yoast, RankMath) do automatically but Astro does not.

## Usage

```
/site-audit <site>                  # Quick audit (source files only)
/site-audit <site> --complete       # Full audit with Lighthouse + live checks
/site-audit all                     # Quick audit all sites (summary scorecard)
/site-audit all --complete          # Full audit all sites
```

## Sites

| Shortcode | Site | Domain |
|-----------|------|--------|
| `rd` | requestdesk-ai | requestdesk.ai |
| `tc` | talkcommerce-com | talkcommerce.com |
| `cb-ai` | contentbasis-ai | contentbasis.ai |
| `cb-io` | contentbasis-io | contentbasis.io |
| `brent` | brent-run | brent.run |
| `eo` | eovoices-com | eovoices.com |
| `dreamers` | dreamers-inc | humans.contentcucumber.com |
| `mage` | magento-masters-com | magentomasters.com |

## Examples

```
/site-audit rd                     # Quick audit requestdesk-ai
/site-audit tc --complete          # Full audit talkcommerce with Lighthouse
/site-audit all                    # Scorecard across all sites
```

## Flags

| Flag | Purpose |
|------|---------|
| (none) | Quick mode (default). Source file scan only. Fast, no network. |
| `--complete` | Full mode. Adds Lighthouse, live URL checks, OG image validation. |
| `--fix` | After audit, offer to fix critical issues automatically. |

---

## --help Handler

**When `--help` or `-h` is passed as an argument, show this and STOP:**

```
site-audit - Full-site SEO/AEO/AIO analysis for Astro sites

Usage:
  /site-audit <site>              Quick audit (source files only, no network)
  /site-audit <site> --complete   Full audit with Lighthouse + live URL checks
  /site-audit <site> --fix        Audit then auto-fix critical issues
  /site-audit all                 Quick audit all sites (comparison scorecard)
  /site-audit all --complete      Full audit all sites with live checks

Sites:
  rd        requestdesk-ai          requestdesk.ai
  tc        talkcommerce-com        talkcommerce.com
  cb-ai     contentbasis-ai         contentbasis.ai
  cb-io     contentbasis-io         contentbasis.io
  brent     brent-run               brent.run
  eo        eovoices-com            eovoices.com
  dreamers  dreamers-inc            humans.contentcucumber.com
  mage      magento-masters-com     magentomasters.com

Flags:
  (none)      Quick mode. Source file scan only. Fast, no network.
  --complete  Full mode. Adds Lighthouse, live URL checks, OG image validation.
  --fix       After audit, offer to auto-fix critical issues.

Scoring:
  SEO (35%) + AEO (25%) + AIO (20%) + Technical (20%) = Overall /100
  Grades: A (90+), B (80-89), C (70-79), D (60-69), F (<60)

Quick mode checks:
  - Infrastructure (sitemap, robots.txt, llms.txt, OG image, SEO architecture)
  - Per-page (title, description, OG tags, Twitter cards, schema, headings, alt text)
  - AEO (FAQ sections, snippet readiness, question headings)
  - AIO (llms.txt quality, schema richness, semantic HTML, AI crawler rules)
  - Cross-page consistency (title patterns, OG images, schema coverage)

Complete mode adds:
  - Lighthouse scores (performance, accessibility, best practices, SEO)
  - Live meta tag verification (rendered HTML vs source)
  - OG image accessibility and dimensions
  - Sitemap validation (all pages present, no dead URLs)

Examples:
  /site-audit tc                  Quick audit Talk Commerce
  /site-audit rd --complete       Full audit RequestDesk with Lighthouse
  /site-audit all                 Scorecard across all 8 sites
  /site-audit tc --fix            Audit TC then auto-fix critical issues
```

---

## Instructions for Claude

### Step 0: Resolve Target

```bash
SITES_DIR="/Users/brent/scripts/CB-Workspace/astro-sites/sites"
```

**Shortcode mapping:**
| Shortcode | Directory |
|-----------|-----------|
| `rd` | `$SITES_DIR/requestdesk-ai` |
| `tc` | `$SITES_DIR/talkcommerce-com` |
| `cb-ai` | `$SITES_DIR/contentbasis-ai` |
| `cb-io` | `$SITES_DIR/contentbasis-io` |
| `brent` | `$SITES_DIR/brent-run` |
| `eo` | `$SITES_DIR/eovoices-com` |
| `dreamers` | `$SITES_DIR/dreamers-inc` |
| `mage` | `$SITES_DIR/magento-masters-com` |

**Domain mapping (for --complete live checks):**
| Shortcode | Domain |
|-----------|--------|
| `rd` | `https://requestdesk.ai` |
| `tc` | `https://talkcommerce.com` |
| `cb-ai` | `https://contentbasis.ai` |
| `cb-io` | `https://contentbasis.io` |
| `brent` | `https://brent.run` |
| `eo` | `https://eovoices.com` |
| `dreamers` | `https://humans.contentcucumber.com` |
| `mage` | `https://magentomasters.com` |

If `all` is passed, loop through all sites. Generate a summary scorecard at the end.

---

## QUICK MODE (Default)

Source file scan only. No network calls. Fast.

### Phase 1: Infrastructure Check

Check for site-level files that should exist:

**1a. astro.config.mjs - Sitemap integration**
```bash
# Read astro.config.mjs
# Check for: import sitemap, sitemap() in integrations array
```
- Pass: sitemap integration present with configuration
- Warn: sitemap present but no custom config (no priorities, no filter)
- Fail: no sitemap integration at all

**1b. robots.txt**
```bash
# Check: $SITE_DIR/public/robots.txt
```
- Pass: exists, references Sitemap URL, allows crawling
- Warn: exists but missing Sitemap reference
- Fail: does not exist

**1c. llms.txt (AIO)**
```bash
# Check: $SITE_DIR/public/llms.txt
```
- Pass: exists with meaningful content (site description, navigation, architecture)
- Warn: exists but minimal content
- Fail: does not exist

**1d. OG Default Image**
```bash
# Check: $SITE_DIR/public/ for social card images
# Pattern: *social-card*, *social-preview*, *og-image*
```
- Pass: default social card image exists
- Warn: image exists but naming is inconsistent with other sites
- Fail: no default social card image found

**1e. Layout/SEO Architecture**

Detect which pattern the site uses:

| Pattern | Quality | What to look for |
|---------|---------|------------------|
| Centralized SEO component | Best | `SEO.astro` or similar in components, used by Layout |
| Layout with inline meta | OK | Layout.astro handles meta but no reusable SEO component |
| No layout, inline per page | Poor | Each page builds its own `<head>` from scratch |

```bash
# Check for SEO component
find $SITE_DIR/src -name "SEO.astro" -o -name "seo.astro" -o -name "Meta.astro" -o -name "Head.astro"

# Check for Layout
find $SITE_DIR/src/layouts -name "*.astro"

# Check for Schema component
find $SITE_DIR/src -name "Schema.astro" -o -name "StructuredData.astro" -o -name "*Schema*.astro"
```

Report the architecture pattern found.

### Phase 2: Page-by-Page Scan

Scan every `.astro` file in `src/pages/`:

```bash
# Get all page files
find $SITE_DIR/src/pages -name "*.astro" -type f
# Also check .mdx files
find $SITE_DIR/src/pages -name "*.mdx" -type f
```

**For each page, check:**

**2a. Title**
- Scan for: `<title>`, frontmatter `title:`, Layout prop `title=`
- Pass: title present, 30-60 chars
- Warn: title too short (<30) or too long (>60)
- Fail: no title found

**2b. Meta Description**
- Scan for: `<meta name="description"`, frontmatter `description:`, Layout prop `description=`
- Pass: present, 50-160 chars
- Warn: too short (<50) or too long (>160)
- Fail: missing entirely

**2c. Canonical URL**
- Scan for: `<link rel="canonical"`, `Astro.url`, auto-generated by SEO component
- Pass: present
- Fail: missing

**2d. OG Tags (minimum set)**
- `og:title` - required
- `og:description` - required
- `og:image` - required
- `og:type` - required (website or article)
- `og:url` - required
- Pass: all 5 present
- Warn: 3-4 present
- Fail: <3 present

**2e. Twitter Card Tags**
- `twitter:card` - required
- `twitter:title` - required
- `twitter:description` - required
- `twitter:image` - recommended
- Pass: all present
- Warn: card + title present but missing others
- Fail: no twitter tags

**2f. Structured Data (JSON-LD)**
- Scan for: `<script type="application/ld+json">`, structured data components
- Check what types are present: Organization, WebPage, BreadcrumbList, Article, FAQPage, SoftwareApplication, Product
- Pass: at least 1 relevant schema present
- Warn: schema present but missing recommended types for page type
- Fail: no structured data at all

**Page type expectations:**

| Page Type | Required Schema | Recommended Schema |
|-----------|----------------|--------------------|
| Homepage | Organization, WebSite | SoftwareApplication, FAQPage |
| About | Organization, AboutPage | BreadcrumbList |
| Blog post | Article/BlogPosting | BreadcrumbList, Author |
| Blog index | CollectionPage | BreadcrumbList |
| Integration/Product | SoftwareApplication or Product | FAQPage, BreadcrumbList |
| Pricing | Product/Offer | FAQPage |
| Contact | ContactPage | Organization, BreadcrumbList |
| Legal (privacy/terms) | WebPage | BreadcrumbList |

**2g. Heading Structure**
- Scan for: `<h1>`, `<h2>`, `<h3>` etc.
- Pass: exactly 1 H1, logical hierarchy (no skipping levels)
- Warn: multiple H1s, or skipped heading levels
- Fail: no H1 found

**2h. Image Alt Text**
- Scan for: `<img` tags, Astro `<Image>` components
- Count images with and without alt text
- Pass: all images have alt text
- Warn: some missing
- Fail: most missing

**2i. Internal Links**
- Count links to other pages on the same site
- Warn: page has 0 internal links (orphan page)

### Phase 3: AEO Analysis

For each page, check Answer Engine Optimization readiness:

**3a. FAQ Coverage**
- Scan for: FAQ sections, question-formatted headings, `<details>`/`<summary>` elements
- Scan for: FAQPage schema
- Pass: FAQ section with matching FAQPage schema
- Warn: FAQ content exists but no schema
- Fail: no FAQ content on pages that should have it (product, about, pricing, how-it-works)

**3b. Featured Snippet Readiness**
- Check for definition paragraphs (40-60 words answering "What is X?")
- Check for numbered/bulleted lists under "How to" style headings
- Check for comparison tables
- Report: snippet-ready content found or not

**3c. Question-Based Headings**
- Count headings phrased as questions ("What is...?", "How does...?", "Why...?")
- These perform better for voice search and AI answer extraction
- Report count and percentage of headings

### Phase 4: AIO Analysis (AI Optimization)

Check readiness for AI model consumption:

**4a. llms.txt Quality Score**
- If exists: score on completeness (site description, architecture, navigation links, content types)
- Recommended sections: Summary, Architecture, Navigation, Content Types, API (if applicable)

**4b. Schema Richness**
- Count total unique schema types across the site
- Check for `@graph` patterns (interconnected entities vs isolated schemas)
- Higher interconnection = better AI understanding

**4c. Content Structure**
- Are pages semantically structured (article, section, nav, main, aside)?
- Or just div soup?
- Semantic HTML helps AI models understand content hierarchy

**4d. robots.txt AI Crawler Rules**
- Check for rules targeting AI crawlers: GPTBot, Claude-Web, Anthropic, Google-Extended, CCBot
- Report: allowed, blocked, or not addressed

### Phase 5: Cross-Page Consistency

**5a. Title Pattern**
- Extract all titles. Check for consistent pattern (e.g., "Page Name | Brand" or "Page Name - Brand")
- Flag inconsistent patterns

**5b. OG Image Consistency**
- List all OG images used across pages
- Flag pages using different image dimensions or formats
- Flag pages falling back to default vs having custom images

**5c. Schema Coverage Map**
- Table showing which schemas appear on which pages
- Highlight gaps (e.g., blog posts without Article schema)

**5d. Meta Description Coverage**
- Percentage of pages with meta descriptions
- List pages missing descriptions

### Phase 6: Generate Report

```
## Site Audit: [SITE NAME]
**Date:** [YYYY-MM-DD]
**Mode:** Quick (source scan)
**Pages Scanned:** [X]

### Infrastructure Scorecard

| Check | Status | Notes |
|-------|--------|-------|
| Sitemap Integration | Pass/Warn/Fail | [detail] |
| robots.txt | Pass/Warn/Fail | [detail] |
| llms.txt | Pass/Warn/Fail | [detail] |
| Default OG Image | Pass/Warn/Fail | [detail] |
| SEO Architecture | Best/OK/Poor | [pattern name] |

### Page Scorecard

| Page | Title | Desc | OG | Twitter | Schema | H1 | Alt | Score |
|------|-------|------|----|---------|--------|----|-----|-------|
| / | Pass | Pass | 5/5 | 4/4 | 3 types | Pass | 8/10 | 95 |
| /about | Pass | Fail | 3/5 | 0/4 | 1 type | Pass | 2/5 | 52 |
| ... | | | | | | | | |

### AEO Scorecard

| Page | FAQ | Snippet Ready | Q-Headings | Score |
|------|-----|---------------|------------|-------|
| / | Pass | Yes | 2 | 90 |
| /about | Fail | No | 0 | 30 |

### AIO Scorecard

| Check | Status | Score |
|-------|--------|-------|
| llms.txt | [quality] | [X]/100 |
| Schema Richness | [X] unique types | [X]/100 |
| Semantic HTML | [assessment] | [X]/100 |
| AI Crawler Rules | [allowed/blocked/unset] | [X]/100 |

### Cross-Site Consistency

| Check | Status |
|-------|--------|
| Title Pattern | [consistent/inconsistent] |
| OG Images | [X]/[Y] pages have custom images |
| Schema Coverage | [X]% of pages have structured data |
| Meta Descriptions | [X]% of pages have descriptions |

### Overall Scores

| Category | Score | Grade |
|----------|-------|-------|
| SEO | [X]/100 | [A-F] |
| AEO | [X]/100 | [A-F] |
| AIO | [X]/100 | [A-F] |
| Technical | [X]/100 | [A-F] |
| **Overall** | **[X]/100** | **[A-F]** |

### Critical Issues (Fix First)
1. [Issue] - [Page] - [How to fix]
2. ...

### Recommended Improvements
1. [Improvement] - [Impact: High/Med/Low]
2. ...
```

---

## COMPLETE MODE (--complete)

Everything in Quick mode PLUS the following phases. These require network access.

### Phase 7: Lighthouse Scores (--complete only)

Run Lighthouse against key pages of the live site.

**Select pages to audit (max 5 for performance):**
1. Homepage
2. A content page (about/how-it-works)
3. A blog post (if blog exists)
4. A dynamic/integration page (if exists)
5. A conversion page (pricing/contact)

**For each page:**
```bash
# Run Lighthouse CI via npx (headless Chrome)
npx lighthouse "[URL]" \
  --output=json \
  --output-path=/tmp/lighthouse-[page].json \
  --chrome-flags="--headless --no-sandbox" \
  --only-categories=performance,accessibility,best-practices,seo \
  --quiet
```

**If Lighthouse CLI not available:**
```bash
# Fallback: use PageSpeed Insights API (free, no install)
curl -s "https://www.googleapis.com/pagespeedonline/v5/runPagespeedTest?url=[URL]&strategy=mobile&category=PERFORMANCE&category=ACCESSIBILITY&category=BEST_PRACTICES&category=SEO"
```

**Extract and display:**

```
### Lighthouse Scores

| Page | Performance | Accessibility | Best Practices | SEO |
|------|-------------|---------------|----------------|-----|
| / | [X] | [X] | [X] | [X] |
| /about | [X] | [X] | [X] | [X] |
| /blog/[post] | [X] | [X] | [X] | [X] |

**Key Issues from Lighthouse:**
- [Issue 1]: [affected pages]
- [Issue 2]: [affected pages]
```

**Scoring rules:**
- 90-100: Green (Pass)
- 50-89: Orange (Warn)
- 0-49: Red (Fail)

### Phase 8: Live Meta Verification (--complete only)

Fetch key pages from the live domain and verify deployed HTML matches source expectations:

```bash
# Fetch live page
curl -s -L "[DOMAIN]/[path]" | head -200
```

**Check:**
- Title tag renders correctly (not showing Astro template syntax)
- Meta description renders (not empty or showing `{variable}`)
- OG image URL is accessible (HEAD request returns 200)
- Canonical URL points to correct domain (not localhost, not staging)
- No `noindex` accidentally set on production pages

**Report discrepancies:**
```
### Live vs Source Discrepancies

| Page | Issue | Source Says | Live Shows |
|------|-------|------------|------------|
| /about | Meta desc | "Learn about..." | (empty) |
| /pricing | OG image | /social-card.png | 404 |
```

### Phase 9: OG Image Validation (--complete only)

For each unique OG image referenced across the site:

```bash
# Check image is accessible
curl -s -o /dev/null -w "%{http_code}" "[IMAGE_URL]"

# Check image dimensions (if downloadable)
# Recommended: 1200x630 for OG images
```

**Check:**
- Image URL returns 200
- Image is reasonable size (not 5MB, not 1KB)
- Dimensions are OG-friendly (ideally 1200x630 or 2:1 ratio)

### Phase 10: Sitemap Validation (--complete only)

```bash
# Fetch live sitemap
curl -s "[DOMAIN]/sitemap.xml"
```

**Check:**
- Sitemap is accessible
- All pages in src/pages/ appear in sitemap
- No dead URLs in sitemap (spot check 5 random URLs)
- Sitemap references correct domain
- lastmod dates are reasonable

### Phase 11: Complete Mode Report Additions

Add to the Quick mode report:

```
### Lighthouse Scores

| Page | Perf | A11y | BP | SEO | Overall |
|------|------|------|----|-----|---------|
| / | [X] | [X] | [X] | [X] | [avg] |
| /about | [X] | [X] | [X] | [X] | [avg] |

### Live Verification

| Check | Status |
|-------|--------|
| Meta tags rendering | [X]/[Y] pages verified |
| OG images accessible | [X]/[Y] images return 200 |
| Canonical URLs correct | [X]/[Y] pages correct |
| No accidental noindex | Pass/Fail |

### Sitemap Health

| Check | Status |
|-------|--------|
| Sitemap accessible | Yes/No |
| Pages in sitemap | [X]/[Y] found |
| Dead URLs | [X] found |
| Domain correct | Yes/No |
```

---

## ALL SITES MODE

When `all` is passed, run Quick (or Complete) audit on every site and produce a comparison scorecard:

```
## All Sites Audit Summary
**Date:** [YYYY-MM-DD]
**Mode:** [Quick/Complete]

### Site Comparison

| Site | SEO | AEO | AIO | Tech | Overall | Grade |
|------|-----|-----|-----|------|---------|-------|
| requestdesk-ai | 82 | 65 | 40 | 90 | 69 | C+ |
| talkcommerce-com | 88 | 70 | 75 | 85 | 80 | B |
| contentbasis-ai | 35 | 10 | 0 | 50 | 24 | F |
| brent-run | 60 | 20 | 0 | 70 | 38 | D |
| ... | | | | | | |

### Infrastructure Comparison

| Site | Sitemap | robots.txt | llms.txt | SEO Component | OG Image |
|------|---------|------------|----------|---------------|----------|
| requestdesk-ai | Custom | Yes | No | None (inline) | Yes |
| talkcommerce-com | Basic | ? | Yes | SEO.astro | Yes |
| contentbasis-ai | None | No | No | None | ? |

### Top 5 Issues Across All Sites
1. [X] sites missing llms.txt
2. [X] sites missing sitemap integration
3. [X] total pages missing meta descriptions
4. [X] total pages missing structured data
5. [X] sites using inline meta instead of reusable components

### Recommendations (Priority Order)
1. **Create shared SEO component** in astro-sites/shared/ - all sites benefit
2. **Add llms.txt** to all sites - AI optimization baseline
3. **Add sitemap** to sites missing it - [list sites]
4. **[Other recommendations]**
```

---

## SCORING METHODOLOGY

### Per-Page Score (0-100)

| Check | Weight | Scoring |
|-------|--------|---------|
| Title | 10 | 10=present+good length, 5=present+bad length, 0=missing |
| Meta Description | 15 | 15=present+good length, 8=present+bad length, 0=missing |
| OG Tags | 10 | 2 per tag (5 required tags) |
| Twitter Tags | 5 | 1.25 per tag (4 tags) |
| Structured Data | 15 | 15=rich schema, 8=basic schema, 0=none |
| Heading Structure | 10 | 10=perfect hierarchy, 5=minor issues, 0=no H1 |
| Image Alt Text | 10 | Percentage of images with alt * 10 |
| Canonical | 5 | 5=present, 0=missing |
| Internal Links | 5 | 5=has links, 0=orphan page |
| AEO (FAQ/Snippets) | 15 | 15=FAQ+schema+snippets, 8=partial, 0=none |

### Site Score

**SEO Score:** Average of all page SEO checks (title, desc, OG, twitter, canonical, headings, alt, links)
**AEO Score:** Average of all page AEO checks (FAQ, snippets, Q-headings)
**AIO Score:** llms.txt (40%) + schema richness (30%) + semantic HTML (20%) + AI crawler rules (10%)
**Technical Score:** sitemap (25%) + robots.txt (25%) + SEO architecture (25%) + Lighthouse avg SEO score if --complete (25%)

**Overall:** SEO (35%) + AEO (25%) + AIO (20%) + Technical (20%)

### Grade Scale

| Score | Grade |
|-------|-------|
| 90-100 | A |
| 80-89 | B |
| 70-79 | C |
| 60-69 | D |
| 0-59 | F |

Use +/- modifiers (e.g., B+ for 85-89, B- for 80-82).

---

## --fix FLAG

When `--fix` is passed along with a single site audit:

**Auto-fixable issues (will fix automatically):**
- Add missing `robots.txt` with standard template
- Add missing `llms.txt` with site-specific content
- Add missing meta descriptions to pages (AI-generated from content)
- Add missing canonical URLs
- Add missing basic structured data (WebPage, BreadcrumbList)

**Manual-fix issues (will create a todo list):**
- Missing SEO component architecture (requires refactor)
- Missing OG images (need design)
- Content quality issues (FAQ sections, snippet optimization)
- Heading hierarchy fixes (may affect design)

**Fix report:**
```
### Auto-Fixed
- Added robots.txt with sitemap reference
- Added meta descriptions to 5 pages
- Added BreadcrumbList schema to 8 pages

### Manual Fixes Needed
- [ ] Create shared SEO component (see recommendation)
- [ ] Design OG images for: /about, /pricing
- [ ] Add FAQ section to: /how-it-works, /pricing
```
