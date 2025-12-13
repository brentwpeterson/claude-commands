# AEO/GEO Page Enrichment Command

Enrich Astro pages with Answer Engine Optimization (AEO) and Generative Engine Optimization (GEO) ready schemas, Q&A pairs, and comprehensive meta tags.

**Usage:** `/aeo-enrich <page-path>`

**Example:** `/aeo-enrich requestdesk-ai/src/pages/about.astro`

---

## Instructions for Claude

When this command is run, follow this comprehensive workflow:

### Phase 1: Page Analysis

1. **Read the target page** specified in the argument
2. **Identify page type** by analyzing content:
   - **Article/Blog**: Educational content, how-tos, guides
   - **About/Company**: Organization info, team, mission
   - **Product/Service**: Features, pricing, offerings
   - **FAQ**: Question-answer format content
   - **Legal**: Privacy, terms, policies
   - **Landing**: Hero, CTAs, feature highlights
   - **Tool/App**: Interactive functionality

3. **Extract key information**:
   - Main topic/subject
   - Primary keywords
   - Target audience
   - Content sections
   - Existing meta tags
   - Existing schema markup

4. **Present analysis to user**:
   ```
   ## Page Analysis: [page-name]

   **Page Type:** [detected type]
   **Main Topic:** [topic]
   **Target Audience:** [audience]
   **Current SEO Status:**
   - Title: [exists/missing] - [value if exists]
   - Description: [exists/missing] - [value if exists]
   - Open Graph: [complete/partial/missing]
   - Schema: [types found or "none"]
   ```

---

### Phase 2: Schema Recommendations

Based on page type, recommend appropriate schemas from this matrix:

| Page Type | Primary Schemas | Secondary Schemas |
|-----------|----------------|-------------------|
| Article/Blog | Article, FAQPage | BreadcrumbList, Author |
| About/Company | Organization, FAQPage | ContactPoint, Person |
| Product/Service | Product, FAQPage, HowTo | Offer, AggregateRating |
| FAQ | FAQPage | WebPage |
| Legal | WebPage | Organization |
| Landing | WebPage, Organization | FAQPage, Product |
| Tool/App | SoftwareApplication, FAQPage | HowTo, WebPage |

**Present recommendations:**
```
## Recommended Schemas

1. **[Schema Type]** - [why it's appropriate]
2. **[Schema Type]** - [why it's appropriate]
...

Shall I proceed with these schemas? (yes/modify/skip)
```

---

### Phase 3: Q&A Generation (Hybrid)

1. **Analyze page content** and generate 5-8 relevant Q&A pairs
2. **Format for user review**:

```
## Suggested Q&A Pairs for FAQPage Schema

These Q&As are optimized for AI search engines (Perplexity, ChatGPT, Google SGE):

### Q1: [Question that users/AI might ask]
**A:** [Concise, authoritative answer - 2-3 sentences max]
✅ Keep | ✏️ Edit | ❌ Remove

### Q2: [Question]
**A:** [Answer]
✅ Keep | ✏️ Edit | ❌ Remove

...

**Add custom Q&A?** (yes/no)
```

3. **Q&A Best Practices** (apply these):
   - Questions should match natural language queries
   - Answers should be direct and factual (AI-citation friendly)
   - Include the main keyword in Q&A naturally
   - Cover "what", "how", "why", "when" question types
   - Keep answers under 300 characters for featured snippets

---

### Phase 4: Meta Tag Optimization

Generate/update comprehensive meta tags:

```astro
<!-- Primary Meta Tags -->
<title>[Optimized title - 50-60 chars]</title>
<meta name="description" content="[Compelling description - 150-160 chars]" />
<meta name="keywords" content="[relevant, keywords, here]" />

<!-- Open Graph / Facebook -->
<meta property="og:type" content="[website/article]" />
<meta property="og:url" content="[full URL]" />
<meta property="og:title" content="[title]" />
<meta property="og:description" content="[description]" />
<meta property="og:image" content="[image URL]" />

<!-- Twitter -->
<meta property="twitter:card" content="summary_large_image" />
<meta property="twitter:url" content="[full URL]" />
<meta property="twitter:title" content="[title]" />
<meta property="twitter:description" content="[description]" />
<meta property="twitter:image" content="[image URL]" />

<!-- AEO-Specific -->
<meta name="robots" content="index, follow, max-snippet:-1, max-image-preview:large" />
<link rel="canonical" href="[canonical URL]" />
```

**Present for approval:**
```
## Meta Tag Updates

**Title:** [new title]
  - Previous: [old or "none"]
  - Change: [what changed and why]

**Description:** [new description]
  - Previous: [old or "none"]
  - AEO optimization: [how it's optimized for AI]

**Open Graph:** [complete/added/updated]
**Twitter Cards:** [complete/added/updated]

Proceed with these meta tags? (yes/modify)
```

---

### Phase 5: Schema Generation

Generate JSON-LD schemas based on approved selections:

**Organization Schema** (for company pages):
```json
{
  "@context": "https://schema.org",
  "@type": "Organization",
  "name": "Content Basis, LLC",
  "url": "https://requestdesk.ai",
  "logo": "https://requestdesk.ai/logo.png",
  "description": "[company description]",
  "sameAs": ["[social links]"]
}
```

**FAQPage Schema** (for Q&A content):
```json
{
  "@context": "https://schema.org",
  "@type": "FAQPage",
  "mainEntity": [
    {
      "@type": "Question",
      "name": "[question]",
      "acceptedAnswer": {
        "@type": "Answer",
        "text": "[answer]"
      }
    }
  ]
}
```

**Article Schema** (for content pages):
```json
{
  "@context": "https://schema.org",
  "@type": "Article",
  "headline": "[title]",
  "description": "[description]",
  "author": {
    "@type": "Organization",
    "name": "Content Basis, LLC"
  },
  "publisher": {
    "@type": "Organization",
    "name": "RequestDesk.ai",
    "logo": {
      "@type": "ImageObject",
      "url": "https://requestdesk.ai/logo.png"
    }
  },
  "datePublished": "[date]",
  "dateModified": "[date]"
}
```

**WebPage Schema** (universal):
```json
{
  "@context": "https://schema.org",
  "@type": "WebPage",
  "name": "[page title]",
  "description": "[description]",
  "url": "[canonical URL]",
  "isPartOf": {
    "@type": "WebSite",
    "name": "RequestDesk.ai",
    "url": "https://requestdesk.ai"
  }
}
```

---

### Phase 6: Implementation

1. **Show the complete changes** as a diff preview
2. **Ask for final approval**
3. **Apply changes** to the page:
   - Add/update meta tags in `<head>`
   - Add JSON-LD schema script(s) in `<head>`
   - Merge with existing schemas (don't duplicate)

**Implementation format:**
```astro
<head>
  <!-- Existing head content -->

  <!-- AEO Meta Tags -->
  [meta tags here]

  <!-- Structured Data -->
  <script type="application/ld+json">
  [combined schema JSON]
  </script>
</head>
```

---

### Phase 7: Validation & Report

After implementation, provide:

```
## AEO/GEO Enrichment Complete

**Page:** [page path]
**Schemas Added:** [list]
**Q&A Pairs:** [count]
**Meta Tags Updated:** [list]

### Validation Checklist
- [ ] Schema valid (test at schema.org/validator)
- [ ] Meta tags complete
- [ ] Open Graph ready for social sharing
- [ ] FAQ optimized for featured snippets

### Testing URLs
- Schema Validator: https://validator.schema.org/
- Rich Results Test: https://search.google.com/test/rich-results
- Open Graph Debugger: https://developers.facebook.com/tools/debug/

### Next Steps
1. Test locally and verify rendering
2. Deploy and submit to Google Search Console
3. Monitor rich results in Search Console
```

---

## AEO/GEO Best Practices Applied

This command implements these optimization strategies:

### For AI Search Engines (Perplexity, ChatGPT, Bing Chat)
- **Structured Q&A**: Direct question-answer format that AI can cite
- **Factual statements**: Clear, quotable sentences
- **Entity clarity**: Explicit organization/author attribution
- **Concise answers**: Under 300 chars for easy extraction

### For Google SGE & Traditional Search
- **Rich snippets**: FAQ schema for expandable results
- **Featured snippets**: Q&A format optimized for position zero
- **Knowledge panel**: Organization schema for brand queries
- **Breadcrumbs**: Clear site hierarchy

### For Social & Sharing
- **Open Graph**: Optimized for Facebook/LinkedIn sharing
- **Twitter Cards**: Large image cards for engagement
- **Canonical URLs**: Prevent duplicate content issues

---

## Arguments

- `<page-path>` (required): Relative path to the .astro page file
  - Example: `requestdesk-ai/src/pages/about.astro`
  - Example: `contentbasis-io/src/pages/services.astro`

---

## Notes

- Always ask for user approval before making changes
- Preserve existing valid schemas (merge, don't replace)
- Use RequestDesk.ai branding for Organization schema
- Parent company is Content Basis, LLC
- Default canonical domain: https://requestdesk.ai
