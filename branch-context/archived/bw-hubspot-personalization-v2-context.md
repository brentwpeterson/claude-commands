# Resume Instructions for Claude

## IMMEDIATE SETUP
1. **Directory:** `cd /Users/brent/scripts/CB-Workspace/brent-workspace`
2. **Branch:** `main`
3. **Load brand persona:** Run `/brand-brent` before generating content

## SESSION SUMMARY
**Task:** HubSpot Contact Personalization v2 - Add RequestDesk Value Prop Bridge

## WHAT WE ACCOMPLISHED THIS SESSION

### HubSpot Tier Assignment - COMPLETE
- Assigned `relationship_tier` to all 332 PRIMARY Shopify contacts
- Tier distribution: 1 Tier1, 2 Tier2, ~107 Tier3, ~122 Tier4, ~100 Tier5
- Algorithm: Tier1=manual, Tier2=50+ notes, Tier3=10-49, Tier4=1-9, Tier5=0
- Updated Alexandra Fine (Dame Products) to Tier 3 (met at Shoptalk)

### Backlog Items Added
1. **P2:** Personalization v2: Add RequestDesk value prop bridge to contact paragraphs
   - ID: `69631a438ec76c1a0ce3650e`
2. **P3:** Personalization v3: Scrape contact websites for last blog post date
   - ID: `69631a378ec76c1a0ce3650d`

## PENDING WORK - PERSONALIZATION V2

### The Problem
Current personalization paragraphs describe customer challenges but DON'T connect to RequestDesk solution.

### The New Formula (Three-Part Structure)
1. **Their world** - what they sell, their unique challenge (KEEP existing)
2. **RequestDesk bridge** - how we solve it (ADD this)
3. **Evidence** - content staleness proof (FUTURE - website scrape)

### RequestDesk Value Props to Weave In
- Optimize content workflows / faster publishing
- Enforce brand consistency across all product content
- Identify underperforming product pages before they hurt revenue

### Example Transformation
**Before:**
> "Dame's product content has to work harder than most categories. Sexual wellness requires empowering without alienating."

**After:**
> "Dame's product content has to work harder than most categories. Sexual wellness requires empowering without alienating. **RequestDesk helps you maintain that voice consistently across your catalog while cutting the time from draft to publish in half.**"

## NEXT ACTIONS
1. **FIRST:** Decide batch approach - 25-50 at a time or all 300+?
2. **THEN:** Decide scope - All contacts with personalization? Only PRIMARY? Only certain tiers?
3. **OPTION:** Do 5-10 samples first for user review before bulk update
4. **EXECUTE:** Query contacts, regenerate paragraphs with RequestDesk bridge, batch update

## REFERENCE FILES
- Export CSV: `/Users/brent/scripts/CB-Workspace/brent-workspace/skunk-works/hubspot-enrichment/data/hubspot-crm-exports-shopify-all-2026-01-10-2.csv`
- Contact IDs: `/tmp/hubspot_ids.py` (PRIMARY_IDS and NON_PRIMARY_IDS)

## DEFERRED QUESTIONS (Ask on /claude-start)
1. **Personalization scope:** "Which contacts should get the v2 personalization? All with existing paragraphs, only PRIMARY, or specific tiers?"
2. **Batch approach:** "Do 5-10 samples first for review, or proceed with full batch?"

## CONTEXT NOTES
- HubSpot MCP tools used for batch operations (max 100 per batch)
- `relationship_tier` property is enumeration 1-5
- `personalization_paragraph` is text field
- `primary_company_contact` identifies which contacts receive emails
