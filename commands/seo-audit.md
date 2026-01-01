# SEO/AEO Audit Command

Run a comprehensive SEO/AEO validation on any live URL and get platform-specific fix recommendations.

**Usage:** `/seo-audit <url>`

**Examples:**
- `/seo-audit https://requestdesk.ai/`
- `/seo-audit https://requestdesk.ai/about`
- `/seo-audit https://yoursite.com/blog/post-name`

---

## Instructions for Claude

When this command is run, follow this workflow:

### Phase 1: Run Automated Validation

**Execute the structured-data-testing-tool:**
```bash
npx structured-data-testing-tool --url [URL] -p Google -p Twitter -p Facebook -i
```

**Parse the results and categorize:**
- **Passed** - Tests that succeeded
- **Warnings** - Optional improvements recommended
- **Failed** - Required fixes needed

---

### Phase 2: Analyze Results

**Present results in this format:**
```
## SEO/AEO Audit Results

**URL:** [tested URL]
**Platform:** [detected: WordPress/Astro/Unknown]

### Validation Summary
| Category | Pass Rate | Status |
|----------|-----------|--------|
| Twitter  | X%        | ✅/⚠️/❌ |
| Facebook | X%        | ✅/⚠️/❌ |
| Google   | X%        | ✅/⚠️/❌ |

### Failed Tests (Required Fixes)
- [list each failed test]

### Warnings (Recommended Improvements)
- [list each warning]

### Passed Tests
- [list passed tests - can collapse/summarize]
```

---

### Phase 3: Platform Detection

**Detect the platform by checking:**
1. `X-Powered-By` header
2. `generator` meta tag
3. `/wp-json/` API endpoint (WordPress)
4. Known patterns in HTML source

```bash
# Check for WordPress
curl -sI [URL] | grep -i "x-powered-by"
curl -s [URL] | grep -i "wordpress\|wp-content"

# Check for Astro
curl -s [URL] | grep -i "astro"
```

**Platform categories:**
- **WordPress** - WP sites, WooCommerce
- **Astro** - Static Astro sites
- **Shopify** - Shopify stores
- **Custom/Unknown** - Generic recommendations

---

### Phase 4: Generate Fix Recommendations

Based on failed tests and platform, provide specific fixes:

#### WordPress Fixes

**For missing meta tags (og:image:alt, twitter:image:alt, etc.):**
```
## WordPress Fix: [Missing Tag]

**Option 1: Yoast SEO (Recommended)**
1. Go to: WordPress Admin → SEO → Social
2. Navigate to: [specific tab]
3. Update: [specific field]
4. Save changes

**Option 2: RankMath**
1. Go to: WordPress Admin → Rank Math → Titles & Meta
2. Navigate to: [specific section]
3. Update: [specific field]

**Option 3: Database (Advanced)**
If using a custom theme without SEO plugin:
```sql
-- Add to wp_postmeta for specific post
INSERT INTO wp_postmeta (post_id, meta_key, meta_value)
VALUES ([POST_ID], '_yoast_wpseo_opengraph-image-alt', 'Your alt text');

-- Or update site options for global default
UPDATE wp_options SET option_value = 'Your Site Name'
WHERE option_name = 'blogname';
```

**Option 4: Theme functions.php**
```php
// Add missing Open Graph tags
add_action('wp_head', function() {
    if (!has_action('wpseo_head')) { // Only if no SEO plugin
        echo '<meta property="og:site_name" content="' . get_bloginfo('name') . '" />';
        echo '<meta property="og:locale" content="' . get_locale() . '" />';
    }
});
```
```

#### Astro Fixes

**For missing meta tags:**
```
## Astro Fix: [Missing Tag]

**Location:** `src/pages/[page].astro`

**Add to <head>:**
```astro
<meta property="og:image:alt" content="Description of your image" />
<meta property="og:site_name" content="Your Site Name" />
<meta property="og:locale" content="en_US" />
<meta name="twitter:creator" content="@yourhandle" />
<meta name="twitter:image:alt" content="Description of your image" />
```

**Rebuild and deploy:**
```bash
npm run build
# Then deploy via your normal process
```
```

#### Shopify Fixes

**For missing meta tags:**
```
## Shopify Fix: [Missing Tag]

**Option 1: Theme Editor**
1. Go to: Online Store → Themes → Edit Code
2. Find: `theme.liquid` or `header.liquid`
3. Add meta tags in <head> section

**Option 2: Shopify SEO Apps**
- SEO Manager
- Smart SEO
- JSON-LD for SEO

**Option 3: Metafields (for dynamic content)**
1. Settings → Custom data → Metafields
2. Add metafield for og:image:alt
3. Reference in theme: {{ page.metafields.seo.og_image_alt }}
```

---

### Phase 5: Schema/Structured Data Analysis

**Check for JSON-LD schemas:**
```bash
curl -s [URL] | grep -oE '"@type"[[:space:]]*:[[:space:]]*"[^"]*"' | sort | uniq
```

**Recommend schemas based on page type:**

| Page Type | Recommended Schemas |
|-----------|---------------------|
| Homepage | WebSite, Organization, FAQPage |
| Blog Post | Article, FAQPage, BreadcrumbList |
| Product | Product, Offer, AggregateRating |
| About | AboutPage, Organization |
| Contact | ContactPage, LocalBusiness |
| FAQ | FAQPage |
| Service | Service, FAQPage |

**If schemas are missing, provide platform-specific instructions to add them.**

---

### Phase 6: Final Report

```
## Audit Complete

### Summary
- **Pass Rate:** X%
- **Critical Issues:** X
- **Warnings:** X
- **Platform:** [detected]

### Priority Fixes (Do These First)
1. [Most important fix with instructions]
2. [Second priority]
3. [Third priority]

### Optional Improvements
- [List of nice-to-haves]

### Re-Test Command
After making fixes, re-run:
```bash
npx structured-data-testing-tool --url [URL] -p Google -p Twitter -p Facebook
```

### Additional Resources
- Schema Validator: https://validator.schema.org/
- Rich Results Test: https://search.google.com/test/rich-results
- Facebook Debugger: https://developers.facebook.com/tools/debug/
- Twitter Card Validator: https://cards-dev.twitter.com/validator
```

---

## Common Meta Tag Reference

| Tag | Purpose | Required By |
|-----|---------|-------------|
| `og:title` | Page title for social | Facebook, LinkedIn |
| `og:description` | Page description | Facebook, LinkedIn |
| `og:image` | Share image URL | Facebook, LinkedIn |
| `og:image:alt` | Image alt text | Facebook (accessibility) |
| `og:url` | Canonical URL | Facebook |
| `og:type` | Content type (website/article) | Facebook |
| `og:site_name` | Site name | Facebook |
| `og:locale` | Language/region | Facebook |
| `twitter:card` | Card type | Twitter |
| `twitter:site` | Site's Twitter handle | Twitter |
| `twitter:creator` | Author's Twitter handle | Twitter |
| `twitter:title` | Title for Twitter | Twitter |
| `twitter:description` | Description for Twitter | Twitter |
| `twitter:image` | Image for Twitter | Twitter |
| `twitter:image:alt` | Image alt text | Twitter (accessibility) |

### Article-Specific Tags (Required when og:type="article")

| Tag | Purpose | Required By |
|-----|---------|-------------|
| `article:author` | Content author/publisher | LinkedIn, Facebook |
| `article:published_time` | Original publish date (ISO 8601) | LinkedIn, Facebook |
| `article:modified_time` | Last modified date (ISO 8601) | LinkedIn, Facebook |
| `article:section` | Category/section (optional) | Facebook |
| `article:tag` | Keywords/tags (optional) | Facebook |

**Note:** When `og:type="article"`, LinkedIn Post Inspector will flag missing author and dates.

---

## Notes

- Always run validation on the LIVE/deployed URL, not localhost
- Some changes (especially WordPress database) may require cache clearing
- Facebook caches OG data - use their debugger to refresh: https://developers.facebook.com/tools/debug/
- For WordPress, check if an SEO plugin is active before recommending code changes
- 100% pass rate is the goal before considering audit complete
