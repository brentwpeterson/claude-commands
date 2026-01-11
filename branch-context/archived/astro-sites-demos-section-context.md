# Resume Instructions for Claude

## IMMEDIATE SETUP
1. **Change directory:** `cd /Users/brent/scripts/CB-Workspace/astro-sites/requestdesk-ai`
2. **Verify branch:** `git branch --show-current` (should be: master)
3. **Start dev server:** `npm run dev` (runs on port 3003)

## SESSION METADATA
**Last Commit:** `50b2801 Add demos section with Shopify blog creation demo page`
**Project:** astro-sites/requestdesk-ai
**Saved:** 2026-01-05

## WHAT WE COMPLETED THIS SESSION

### 1. Demos Section Created
- **`/demos/`** - Index page listing all product demos
- **`/demos/shopify-blog-creation`** - Full demo page with comprehensive SEO/GEO/AEO optimization

### 2. Shopify Demo Page Features
- YouTube video embed (https://youtu.be/89Dc14SfdbI)
- VideoObject schema for Google Video carousel
- HowTo schema (6 steps) for featured snippets
- FAQPage schema (5 questions) for answer boxes
- Speakable schema for voice search
- 10 timestamped video chapters (clickable)
- 6 feature cards
- CTAs to contact and main Shopify page

### 3. Updated Shopify Integration Page
- Added video embed in "See It In Action" section
- Added VideoObject schema to structured data
- Link to full demo page with transcript

### 4. Brand Compliance (brand-brent)
- Removed 2 em dashes (—) → replaced with periods
- Kept "AI-Powered" as specifically relevant for product content

## TODO LIST STATE
- ✅ COMPLETED: Create /demos/ section with index page
- ✅ COMPLETED: Create /demos/shopify-blog-creation demo page
- ✅ COMPLETED: Add VideoObject + HowTo + Speakable structured data
- ✅ COMPLETED: Update existing Shopify integration page with video embed
- ⏳ PENDING: Test locally before deployment (user needs to verify)

## NEXT ACTIONS (PRIORITY ORDER)

1. **User should test pages locally:**
   - http://localhost:3003/demos
   - http://localhost:3003/demos/shopify-blog-creation
   - http://localhost:3003/integrations/shopify (scroll to "See It In Action")

2. **If approved, deploy:**
   ```bash
   git tag main-site-v1.X.X-demos-section
   git push origin main-site-v1.X.X-demos-section
   ```

## FILES CREATED THIS SESSION
```
requestdesk-ai/src/pages/demos/index.astro (NEW)
requestdesk-ai/src/pages/demos/shopify-blog-creation.astro (NEW)
requestdesk-ai/src/pages/integrations/shopify.astro (MODIFIED - video embed + schema)
```

## CONTEXT NOTES
- Dev server runs on port 3003
- Video is unlisted on Content Cucumber YouTube account
- Build passes: 76 pages total
- Voting system was confirmed complete at start of session
- Brand-brent persona loaded and content checked for compliance
