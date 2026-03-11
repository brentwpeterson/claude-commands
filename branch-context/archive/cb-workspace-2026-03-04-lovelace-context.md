# Resume Instructions for Claude

## SESSION STATUS
**Identity:** Claude-Lovelace
**Status:** ACTIVE
**Last Saved:** 2026-03-04 06:30
**Last Started:** 2026-03-06 06:23

## IMMEDIATE SETUP
1. **Directory:** `/Users/brent/scripts/CB-Workspace`
2. **Branch:** N/A (CB-Workspace root is not a git repo)
3. **No commits this session** (work was SOP file + research, no code changes)

## WORKSPACES TOUCHED
| Shortcode | What was done |
|-----------|---------------|
| cc | Created tiered-enrichment-sop.md in .claude/skills/hubspot-sales/ |
| brent | Read Pipeline Call 1-3 notes and existing email sequences |

## CURRENT TODO
**Path:** None
**Status:** No todo directory created

## WHAT YOU WERE WORKING ON

**Building a HubSpot email sequence for 50 Crossbeam overlap contacts.**

### Context
- 50 contacts were enriched in a previous session (Steps 1-4: contact fetch, Wappalyzer, blog audit, personalization paragraph)
- These are Crossbeam overlaps with **HubSpot** (the partner)
- The contacts use **HubSpot Marketing Hub / Landing Pages**
- Earlier this session, we created the **Tiered Enrichment SOP** at `.claude/skills/hubspot-sales/tiered-enrichment-sop.md`

### Pipeline Call Context (CRITICAL for sequence writing)
Read all 3 Pipeline Generation calls with Guillermo Arenas (HubSpot):
- **Call 1 (Feb 12):** Q1 goal = 5 shared deals. Funnel: 40 conversations > 10 discovery > 5 deals. Lead with your services, bring HubSpot in as the platform.
- **Call 2 (Feb 20):** ICP confirmed = E-commerce stores $1M+ revenue. Position as full-service growth marketing (not just content). AIO not just SEO. Package outcomes not services. "Context over content." Software bundles: Marketing Hub Pro, Content Hub Pro, Data Hub.
- **Call 3 (Feb 27):** Loop Marketing landing page under review. Free Loop Marketing audit is the offer/CTA. Guillermo sending 4,500 high-intent company list. Target: 40 qualified meetings. A/B test emails and landing page. Next meeting: March 12.

### Questions Asked (Unanswered)
Three questions were posed to Brent right before save:
1. **Is the Loop Marketing landing page live?** (If so, CTA drives there for free audit)
2. **Are the 50 Crossbeam contacts part of the 4,500 list or separate?**
3. **Is the free Loop Marketing audit still the CTA, or has it evolved?**

## CURRENT STATE
- **File created:** `.claude/skills/hubspot-sales/tiered-enrichment-sop.md` (15KB, verified)
- **Existing sequences reviewed:** SEQ-SHOPIFY-DEMO-001, SEQ-CC-GENERIC-001, SEQ-PARTNER-001
- **Sequence location:** `brent-workspace/ob-notes/Brent Notes/Sales and Marketing/HubSpot/Email Templates/email-sequences/`
- **HubSpot API limitation:** No `automation.sequences.read` scope, so sequences must be built in HubSpot UI. We write the copy in Obsidian, Brent sets up in HubSpot.
- **Naming convention:** `SEQ-[TYPE]-[NUMBER].md`

## NEXT ACTIONS
1. **FIRST:** Get answers to the 3 questions above (CTA, landing page status, list overlap)
2. **THEN:** Draft the sequence as `SEQ-CROSSBEAM-HUBSPOT-001.md` in the email-sequences folder
3. **Structure:** 5 emails, Day 0/3/7/14/21 cadence (matching existing pattern)
4. **Angle:** E-commerce brands using HubSpot Marketing Hub. Content Cucumber as growth marketing partner. Free Loop Marketing audit as CTA (pending confirmation).
5. **After draft:** Spot-check 3-5 personalization_paragraphs from the 50 contacts to verify quality
6. **Final:** Brent builds sequence in HubSpot UI using the copy, enrolls the 50 contacts

## CONTEXT NOTES
- Claude name registry was messy (duplicates). Lovelace replaced one of the Turing entries.
- The active-claude-names.json may have been modified externally and has duplicates. Check on resume.
- Brent got frustrated early in session because I was rehashing segmentation work that was already done. Don't re-ask about platform segmentation. The 50 contacts are already enriched and ready.
- Brent's style: no em dashes, no emojis, conversational, specific. Follow personalization-rules.md.
