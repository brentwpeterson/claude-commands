# Resume Instructions for Claude

## IMMEDIATE SETUP
1. **Directory:** `cd /Users/brent/scripts/CB-Workspace/brent-workspace`
2. **Branch:** `main`
3. **Last Commit:** `323e384 Add 2026-01-10 session accomplishments to work log`

## SESSION SUMMARY
**Task:** HubSpot Personalization v2 + Email Sequence for Shopify Contacts

## WHAT WE ACCOMPLISHED THIS SESSION

### 1. Personalization v2 - Shopify Workflow Integration (COMPLETE)
- Rewrote all 332 contact personalization paragraphs
- Integrated RequestDesk Shopify value props into each paragraph
- Value props: 60-second blog posts, product-aware AI, embedded buy buttons, Q&A pairs for SEO
- Output: `skunk-works/hubspot-enrichment/data/personalization-v2-all-332-contacts.csv`
- 7 batch files created and combined

### 2. Email Sequence Created (SEQ-SHOPIFY-DEMO-001)
- 5-email sequence for booking demos
- Ran through /brand-brent terms checker
- Removed "actually" (5 occurrences) and "Here's the thing"
- Saved to: `ob-notes/Brent Notes/HubSpot/SEQ-SHOPIFY-DEMO-001.md`

### 3. Subject Line Finalized
- Final subject line for Email 1: `Is your Shopify store visible to AI search?`
- Sentence case (capital I, rest lowercase)
- AEO angle + question format for curiosity

### 4. Blog Posts Added to Backlog (6 items)
Added P3 blog post ideas based on 6 problems we identified:
1. The Time Drain - Why Shopify Store Owners Abandon Their Blogs
2. Your Competitors Are Ranking for Your Product Keywords
3. Why Generic AI Content Fails for E-commerce
4. Blog Posts That Don't Sell - The Missing Buy Button Problem
5. The Abandoned Blog - 3 Posts from 2022 Sitting on Your Nav Bar
6. SEO is Invisible Work - Why Blogging Never Feels Urgent

## KEY FILES CREATED/MODIFIED

**New Files:**
- `skunk-works/hubspot-enrichment/data/personalization-v2-batch1.csv` through `batch7.csv`
- `skunk-works/hubspot-enrichment/data/personalization-v2-all-332-contacts.csv` (combined)
- `ob-notes/Brent Notes/HubSpot/SEQ-SHOPIFY-DEMO-001.md` (email sequence)

**Source CSV:**
- `skunk-works/hubspot-enrichment/data/hubspot-crm-exports-shopify-all-2026-01-10-3.csv`

## NEXT ACTIONS
1. **Import CSV to HubSpot** - Upload `personalization-v2-all-332-contacts.csv` to update contacts
2. **Create HubSpot Sequence** - Build SEQ-SHOPIFY-DEMO-001 in HubSpot using the markdown file
3. **Update remaining subject lines** - Emails 2-5 still have original subjects, may want to refresh
4. **Enroll contacts** - Set up enrollment criteria (Platform=Shopify, personalization_paragraph known)

## DEFERRED QUESTIONS (Ask on /claude-start)
1. **Time tracking:** "How long did you work on HubSpot personalization and email sequence?"
2. **Task status:** "Is the personalization v2 + email sequence work complete?"

## CONTEXT NOTES
- Email sequence uses `{{personalization_paragraph}}` and `{{meeting link}}` tokens
- Cadence: Day 0, 3, 7, 14, 21
- 6 problems identified for future blog content (already in backlog)
- Brand terms checker caught "actually" as weakening qualifier
