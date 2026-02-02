# Resume Instructions for Claude

## IMMEDIATE SETUP
1. **Change directory:** `cd /Users/brent/scripts/CB-Workspace/brent-workspace`
2. **Verify git status:** `git status` (expect: clean, on main)
3. **Verify branch:** `git branch --show-current` (should be: main)

## WORKSPACES TOUCHED THIS SESSION
**Started in:** bw (brent-workspace)
**Current workspace:** bw (brent-workspace)
**All workspaces:** bw only

## SESSION METADATA
**Last Commit:** `8054c4d Add HubSpot segmentation strategy and bounced contact analysis`
**Saved:** 2026-01-10 (during session)

## WHAT YOU WERE WORKING ON

### HubSpot Contact Enrichment - Personalization Paragraphs

**User Request:** Find non-customer contacts at Shopify/Shopify-Plus companies and enrich their `personalization_paragraph` property.

**Approach (MCP limitation workaround):**
1. Search companies with `company_platform` = shopify or shopify-plus
2. Get contact associations for each company
3. Batch read contacts to check if personalization_paragraph is null
4. Generate personalized paragraphs based on role, company, platform
5. Batch update contacts

**Progress:**
- Processed 10 of 100+ Shopify companies
- Found 14 contacts needing enrichment
- Successfully updated all 14 contacts with personalization_paragraph

## CONTACTS ENRICHED THIS SESSION

| Contact ID | Name | Company | Platform |
|------------|------|---------|----------|
| 33081979706 | Beau | Pinthouse | shopify |
| 33475888199 | Doug | Pinthouse | shopify |
| 33480364189 | Zac | Pinthouse | shopify |
| 33477041939 | Todd | Pinthouse | shopify |
| 50469112568 | Romain | Pinthouse | shopify |
| 34330613040 | Maya | HeyBamboo | shopify |
| 34330613038 | Natasha | HeyBamboo | shopify |
| 34330613036 | Hana | HeyBamboo | shopify |
| 37161429027 | Kelley | Klaris Beauty | shopify |
| 34330613041 | Nikki | Klaris Beauty | shopify |
| 34330613039 | Niki | Klaris Beauty | shopify |
| 34330613037 | Taylor | Klaris Beauty | shopify |
| 34596185704 | Beth | Klaris Beauty | shopify |
| 35387107824 | Chase | Klaris Beauty | shopify |

## ALSO ACCOMPLISHED THIS SESSION

1. **Created bounced contacts analysis:**
   - `hubspot-bounced-with-notes-manual-review.md` - 100 contacts with notes (review before delete)
   - `hubspot-bounced-no-notes-deletion-candidates.md` - 200+ contacts safe to delete

2. **Updated 3 companies with missing platform:**
   - Pinthouse → shopify
   - HeyBamboo → shopify
   - Klaris → shopify

3. **Created segmentation strategy doc:**
   - `hubspot-segmentation-strategy.md` - Full brainstorm on contact segmentation

## NEXT ACTIONS (PRIORITY ORDER)

1. **Continue personalization enrichment:**
   - Get next batch of Shopify company associations (after the first 10)
   - Batch read contacts, check for null personalization_paragraph
   - Generate and update

2. **HubSpot MCP Commands to Continue:**
   ```
   # Get more companies (use 'after' cursor for pagination)
   hubspot-search-objects: companies with company_platform IN [shopify, shopify-plus]

   # For each company, get contacts:
   hubspot-list-associations: company → contacts

   # Check contacts:
   hubspot-batch-read-objects: contacts with properties [email, firstname, lastname, personalization_paragraph]

   # Update:
   hubspot-batch-update-objects: contacts with personalization_paragraph
   ```

## KEY TECHNICAL NOTES

- **HubSpot Hub ID:** 39487190
- **Owner ID:** 378618219
- **MCP Limitation:** Cannot do association-based filtering in search - must use multi-step approach
- **hs_marketable_status is READ-ONLY:** Cannot change via API, must use HubSpot UI or Workflows

## TODO LIST STATE
- ✅ COMPLETED: Get contacts associated with Shopify companies (non-customers)
- ✅ COMPLETED: Check which contacts need personalization_paragraph
- 🔄 IN PROGRESS: Generate personalization paragraphs for each contact (14/many done)
- ⏳ PENDING: Batch update contacts with personalization_paragraph (continue pagination)

## DEFERRED QUESTIONS (Ask on /claude-start)
1. **Continue enrichment?** "Should I continue enriching more Shopify company contacts, or move to a different task?"
