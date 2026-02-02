# Resume Instructions for Claude

## IMMEDIATE SETUP
1. **Directory:** `cd /Users/brent/scripts/CB-Workspace/brent-workspace`
2. **Branch:** main
3. **Saved:** 2026-01-12

## WHAT YOU WERE WORKING ON
Shopify Blog Email Sequence - finalizing templates for deployment.

## KEY FILES
- **Email Sequence Template:** `/Users/brent/scripts/CB-Workspace/brent-workspace/ob-notes/Brent Notes/HubSpot/SEQ-SHOPIFY-DEMO-001.md`
- **Master Plan Document:** `/Users/brent/scripts/CB-Workspace/brent-workspace/skunk-works/blog-discovery/SHOPIFY-EMAIL-SEQUENCE-PLAN.md`

## HUBSPOT TOKENS CREATED
| Token | Purpose |
|-------|---------|
| `blog_segment` | Dropdown: active, dormant_3mo, dormant_6mo, dormant_1yr, has_blog_unknown_activity, no_blog |
| `blog_status_line` | Opener line about their blog activity |
| `personalization_paragraph` | Company-specific paragraph with RequestDesk value prop |

## COMPLETED THIS SESSION
- [x] Fixed 83 "active" contacts - updated blog_status_line to "You're actively blogging - how long does each post take you?"
- [x] Verified personalization_paragraph exists in HubSpot (all 322 contacts have data)
- [x] Updated Email 1 template with both tokens
- [x] Changed subject line to "Is your Shopify store visible to AI search?"
- [x] Removed filler phrases ("Quick follow-up")
- [x] Fixed CTAs (removed "If that sounds interesting:", "Or book...")
- [x] Updated "60 seconds" to "3 minutes" (matches demo video)
- [x] Ran brand-brent terms checker - passed, no violations
- [x] Documented EMAIL COPY RULES in plan

## EMAIL COPY RULES (Documented in Plan)
| Rule | Bad | Fix |
|------|-----|-----|
| Don't give them a reason to say no | "If that sounds interesting:" | "15 minutes. I'll show you how it works." |
| No filler phrases | "Quick follow-up." | Delete it |
| No cliché subject lines | "Quick question about..." | Curiosity, relevance, specificity |
| No claims without data | "60 seconds" (was wrong) | "3 minutes" (matches demo) |
| Evergreen language only | "I saw you posted recently" | "You're actively blogging" |
| No "or" between CTAs | "Watch video OR book call" | "Watch video. Book call." |

## CURRENT EMAIL 1 STRUCTURE
```
Subject: Is your Shopify store visible to AI search?

{{contact.blog_status_line | "Your Shopify store has a blog built in."}}

{{contact.personalization_paragraph | "fallback text"}}

First 20 stores that book a demo get 13 free blog posts on your store. No cost, no obligation.

{{meeting link}}

– Brent
```

## PENDING TODOS
- [ ] Test with sample contact - preview email in HubSpot
- [ ] Send first 10, review for readability
- [ ] Fix issues found during review for LONG TERM (update source data)

## NEXT ACTIONS
1. **FIRST:** Preview Email 1 in HubSpot with a real contact to verify tokens render correctly
2. **THEN:** Send first 10 emails
3. **REVIEW:** Check each for readability - when something doesn't match, fix the SOURCE DATA

## DATA FILE LOCATIONS
- Personalization paragraphs: `skunk-works/hubspot-enrichment/data/personalization-v3-all-332-contacts.csv`
- Blog segment data: `skunk-works/blog-discovery/data/shopify-blog-segment-final-v4.csv`

## DEFERRED QUESTIONS (Ask on /claude-start)
1. **Time tracking:** "How long did you work on the Shopify email sequence today?"
   - Task: Email template finalization, HubSpot contact updates, copy rules documentation
   - Date: 2026-01-12
