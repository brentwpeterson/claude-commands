# Content Audit - SEO/AEO Analysis and Enrichment

Comprehensive content audit for SEO, AEO (Answer Engine Optimization), and schema enrichment.

## Usage

```
/content-audit <url>                    # Full SEO/AEO audit
/content-audit <url> --enrich           # Audit + add schemas/meta tags
/content-audit <url> --schema-only      # Just generate schemas
/content-audit <file-path>              # Audit local Astro/HTML file
```

## Examples

```
/content-audit https://requestdesk.ai/about
/content-audit /integrations/shopify --enrich
/content-audit src/pages/about.astro
/content-audit https://contentcucumber.com --schema-only
```

## Flags

| Flag | Purpose |
|------|---------|
| `--enrich` | After audit, add recommended schemas and meta tags to the page |
| `--schema-only` | Skip audit, just generate appropriate schemas for the page |
| `--fix` | Automatically fix issues found (meta tags, headings, etc.) |

---

## Instructions for Claude

### Phase 1: Resolve Target

**If URL provided:**
1. Fetch the page content using WebFetch
2. Extract HTML structure, meta tags, headings, content

**If file path provided:**
1. Read the local file (Astro, HTML, MDX)
2. Parse frontmatter and content

**If relative path (e.g., `/about`):**
1. Determine project from current directory
2. Map to file: `/about` → `src/pages/about.astro`

### Phase 2: SEO Audit

Run comprehensive SEO analysis:

```
## SEO Audit Results

### Meta Tags
✅ Title: "About RequestDesk - AI Content Platform" (52 chars) - Good length
❌ Meta Description: Missing - CRITICAL
⚠️ OG Image: Present but no alt text

### Headings
✅ Single H1: "About Us"
⚠️ H2 count: 2 (recommend 3-5 for this content length)
❌ Heading hierarchy: H3 appears before H2

### Content
✅ Word count: 847 words (good for about page)
⚠️ Keyword density: "content" appears 23 times (2.7%) - slightly high
✅ Internal links: 5 found
❌ External links: 0 found (add 1-2 authoritative sources)

### Technical
✅ Canonical URL: Set correctly
✅ Mobile viewport: Present
❌ Structured data: No schemas found
⚠️ Image alt tags: 3/5 images have alt text
```

### Phase 3: AEO Analysis

Analyze for Answer Engine Optimization:

```
## AEO Analysis

### Question Coverage
❌ No FAQ section found
⚠️ Content doesn't directly answer common questions
💡 Suggested questions to address:
   - What is RequestDesk?
   - How does RequestDesk work?
   - Who is RequestDesk for?

### Featured Snippet Potential
⚠️ No definition-style paragraphs found
⚠️ No numbered lists for "how to" queries
💡 Add a 40-60 word definition paragraph at the top

### Schema Recommendations
❌ Organization schema: Missing (required for about pages)
❌ FAQPage schema: Missing (would help AEO)
⚠️ BreadcrumbList: Missing
```

### Phase 4: Generate Recommendations

```
## Recommendations (Priority Order)

### Critical
1. Add meta description (150-160 chars)
2. Add Organization schema
3. Fix heading hierarchy

### High
4. Add FAQ section with FAQPage schema
5. Add alt text to remaining images
6. Add 1-2 external authoritative links

### Medium
7. Add BreadcrumbList schema
8. Reduce keyword density slightly
9. Add more H2 sections
```

### Phase 5: Enrich (if --enrich flag)

If `--enrich` flag is provided, modify the file:

**For Astro files:**

1. **Add/update frontmatter:**
```yaml
---
title: "About RequestDesk - AI Content Platform"
description: "Learn about RequestDesk, the AI-powered content platform that helps ecommerce brands create consistent, on-brand content."
ogImage: "/images/og/about.png"
schema:
  type: "Organization"
---
```

2. **Add JSON-LD schemas in `<head>`:**
```html
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "Organization",
  "name": "RequestDesk",
  "url": "https://requestdesk.ai",
  "logo": "https://requestdesk.ai/logo.png",
  "description": "AI-powered content platform for ecommerce brands"
}
</script>
```

3. **Add FAQ section if recommended:**
```astro
<section class="faq">
  <h2>Frequently Asked Questions</h2>
  <!-- FAQ items -->
</section>
```

4. **Add FAQPage schema:**
```html
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "FAQPage",
  "mainEntity": [...]
}
</script>
```

### Phase 6: Report

Generate final report:

```
## Content Audit Complete

**URL:** https://requestdesk.ai/about
**Date:** 2026-01-05

### Scores
| Category | Score | Status |
|----------|-------|--------|
| SEO | 72/100 | ⚠️ Needs Work |
| AEO | 45/100 | ❌ Poor |
| Technical | 85/100 | ✅ Good |
| Overall | 67/100 | ⚠️ Needs Work |

### Changes Made (if --enrich)
- ✅ Added meta description
- ✅ Added Organization schema
- ✅ Added FAQPage schema
- ✅ Fixed heading hierarchy

### Next Steps
1. Review and customize the generated FAQ content
2. Add OG image alt text manually
3. Run /lighthouse for performance check
```

---

## Schema Templates

### Organization (for about/company pages)
```json
{
  "@context": "https://schema.org",
  "@type": "Organization",
  "name": "",
  "url": "",
  "logo": "",
  "description": "",
  "sameAs": []
}
```

### FAQPage
```json
{
  "@context": "https://schema.org",
  "@type": "FAQPage",
  "mainEntity": [{
    "@type": "Question",
    "name": "",
    "acceptedAnswer": {
      "@type": "Answer",
      "text": ""
    }
  }]
}
```

### Article/BlogPosting
```json
{
  "@context": "https://schema.org",
  "@type": "Article",
  "headline": "",
  "author": {"@type": "Person", "name": ""},
  "datePublished": "",
  "dateModified": "",
  "image": ""
}
```

### BreadcrumbList
```json
{
  "@context": "https://schema.org",
  "@type": "BreadcrumbList",
  "itemListElement": [{
    "@type": "ListItem",
    "position": 1,
    "name": "Home",
    "item": ""
  }]
}
```

### Product (for integration pages)
```json
{
  "@context": "https://schema.org",
  "@type": "Product",
  "name": "",
  "description": "",
  "brand": {"@type": "Brand", "name": ""},
  "offers": {"@type": "Offer", "price": "", "priceCurrency": ""}
}
```

### SoftwareApplication
```json
{
  "@context": "https://schema.org",
  "@type": "SoftwareApplication",
  "name": "",
  "operatingSystem": "Web",
  "applicationCategory": "BusinessApplication",
  "offers": {"@type": "Offer", "price": ""}
}
```
