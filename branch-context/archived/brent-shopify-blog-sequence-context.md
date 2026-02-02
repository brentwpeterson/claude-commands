# Resume Instructions for Claude

## IMMEDIATE SETUP
1. **Directory:** `cd /Users/brent/scripts/CB-Workspace/brent-workspace/skunk-works/blog-discovery/data`
2. **Branch:** main
3. **Saved:** 2026-01-12

## WHAT YOU WERE WORKING ON
Shopify Blog Email Sequence - getting it ready to deploy TODAY.

**CRITICAL ISSUE IDENTIFIED:** The `blog_status_line` value for "active" segment contacts contains time-bound language: "I saw you posted recently on your blog" - this is NOT evergreen and will be wrong if sequence runs later or colleague enrolls someone.

## CURRENT STATE

### HubSpot Data (COMPLETED)
- 322 contacts imported with `blog_segment` and `blog_status_line` properties
- Properties created: `blog_segment` (dropdown), `blog_status_line` (text)
- All batches imported successfully

### Segment Distribution
| Segment | Count |
|---------|-------|
| active | 83 |
| dormant_1yr | 83 |
| has_blog_unknown_activity | 80 |
| no_blog | 37 |
| dormant_3mo | 22 |
| dormant_6mo | 17 |

### Email Template (UPDATED BUT NEEDS FIX)
**File:** `/Users/brent/scripts/CB-Workspace/brent-workspace/ob-notes/Brent Notes/HubSpot/SEQ-SHOPIFY-DEMO-001.md`

Email 1 uses: `{{contact.blog_status_line | "Your Shopify store has a blog built in."}}`

Body was rewritten to flow from ANY opener (active, dormant, no blog).

## BLOCKING ISSUE - FIX REQUIRED

**83 "active" segment contacts have time-bound `blog_status_line`:**
- Current: "I saw you posted recently on your blog - how long did that take you?"
- Problem: "recently" is time-bound, won't be accurate later

**MUST UPDATE these 83 contacts in HubSpot with evergreen value.**

Proposed fix options (USER NEEDS TO CHOOSE):
1. "I noticed your blog at [domain] - how long does each post take you to write?"
2. "You're actively blogging - how long does each post take you?"
3. Something else user provides

## FILES MODIFIED THIS SESSION
- `/Users/brent/scripts/CB-Workspace/brent-workspace/ob-notes/Brent Notes/HubSpot/SEQ-SHOPIFY-DEMO-001.md` - Rewrote all 5 emails
- HubSpot: Created properties, imported 322 contacts

## DATA FILES
All in `/Users/brent/scripts/CB-Workspace/brent-workspace/skunk-works/blog-discovery/data/`:
- `shopify-blog-segment-final-v4.csv` - Final 322 contacts
- `hubspot-import-blog-segment-2026-01-11.csv` - Import file used
- `shopify-excluded-contacts.csv` - 8 excluded
- `enterprise-contacts.csv` - Topps
- `not-shopify-contacts.csv` - HireAHelper
- `hubspot-batch-1.json` through `hubspot-batch-4.json` - Batch files

## NEXT ACTIONS (PRIORITY ORDER)
1. **FIRST:** Get user's preferred evergreen text for "active" segment
2. **THEN:** Update 83 "active" contacts in HubSpot with new `blog_status_line`
3. **THEN:** Sequence is ready to deploy

## DEFERRED QUESTIONS (Ask on /claude-start)
1. **Time tracking:** "How long did you work on the Shopify blog sequence task?"
   - Task: HubSpot import + email template updates
   - Date: 2026-01-12
2. **Active segment text:** "What evergreen text do you want for the 83 active blogger contacts?"
