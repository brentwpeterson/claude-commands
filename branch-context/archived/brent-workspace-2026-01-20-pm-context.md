# Resume Instructions for Claude

## IMMEDIATE SETUP
1. **Directory:** `cd /Users/brent/scripts/CB-Workspace/brent-workspace`
2. **Branch:** main
3. **Session:** brent-workspace afternoon session

## SESSION METADATA
**Saved:** 2026-01-20 ~12:10 PM CST
**Started with:** /claude-start brent

## WORKSPACES TOUCHED THIS SESSION
| Shortcode | Workspace | What was done |
|-----------|-----------|---------------|
| `brent` | brent-workspace | HubSpot contact personalization, skill updates, template creation |

## WHAT WE WERE WORKING ON

### HubSpot Contact Personalization (TRE Follow-ups)

**COMPLETED contacts with personalization_paragraph:**

| Contact | Company | Platform | Personalization |
|---------|---------|----------|-----------------|
| Noah McDermott | Alete Nutrition | shopify | Done earlier (needs review - may have duplication issue) |
| Richard Welch | Utu Outdoor Skincare | shopify | Done earlier (needs review - may have duplication issue) |
| Rommel Vega | Holo Footwear | WordPress | WordPress plugin + AEO angle |
| Cindy Leung | Etietech | not-verified | English content + $750 Astro site offer |
| Maddie Fender | Created Co. | shopify | "Created Co. stands out in a market full of YETI and Stanley knockoffs..." |
| Beau Wynja | Color Cord Company | shopify | "The 3-4 hour problem hit home? Color Cord's products deserve content..." |

### Key Learning: Personalization Paragraph Rules

**CRITICAL RULES documented in skill:**
1. personalization_paragraph = CUSTOM HOOK ONLY, not the offer
2. NO greeting (template has {{contact.firstname}},)
3. NO links (template has demo link)
4. NO offer details (template already has those)
5. Don't fake relationships - if you didn't meet them, don't say "Great meeting you"

### Templates Created/Updated

1. **SEQ-WORDPRESS-001.md** - WordPress RD follow-up sequence (new)
2. **SEQ-CC-GENERIC-001.md** - Content Cucumber generic sequence (new)
3. **Shopify-RD-follow-up-012026.md** - Shopify follow-up template for manual sends (new)
   - Location: `ob-notes/Brent Notes/HubSpot/templates/email-templates/`

### HubSpot Skill Updated
**Path:** `/Users/brent/scripts/CB-Workspace/.claude/skills/hubspot-workflow/SKILL.md`

Added:
- Template list (Shopify RD, WordPress RD, CC Generic)
- "Personalization Paragraph Rules" learning moment with good/bad examples
- Examples using Maddie/Created Co. as case study

## ISSUES IDENTIFIED (Need to Fix)

1. **HubSpot Template has wrong topics:** "symptom management tips" should be "Topics tailored to your brand and audience"
2. **HubSpot Template has typo:** "for a your brand" should be "for your brand"
3. **Noah and Richard personalizations** - may need review for duplication (written before we learned the rules)
4. **Obsidian template formatting** - User noted grey background when copying (code block issue)

## TODO LIST STATE
- ✅ Personalize Rommel Vega (Holo Footwear - WordPress)
- ✅ Personalize Cindy Leung (Etietech)
- ✅ Personalize Maddie Fender (Created.co)
- ✅ Personalize Beau Wynja (Color Cord)
- ⏳ PENDING: Review HubSpot deals
- ⏳ PENDING: Review CC site
- ⏳ PENDING: TWC: Get Medium link and post to LinkedIn (TUESDAY - TODAY!)

## NEXT ACTIONS (PRIORITY ORDER)

1. **FIX HubSpot Template:** Update "Shopify RD follow up - 012026" in HubSpot UI:
   - Change topics to "Topics tailored to your brand and audience"
   - Fix typo "for a your brand" → "for your brand"

2. **REVIEW Noah & Richard personalizations** - Check if they duplicate offer details

3. **TWC LinkedIn Post** - This is Tuesday, need to post Medium link

4. **Review HubSpot deals**

5. **Review CC site**

## DEFERRED QUESTIONS (Ask on /claude-start)
1. **Time tracking:** "How long did you work this afternoon session?"
2. **HubSpot template:** "Did you update the template in HubSpot UI with the fixes?"

## HUBSPOT CONTACT IDS (Quick Reference)

| Contact | HubSpot ID | Company |
|---------|------------|---------|
| Noah McDermott | 182444263773 | Alete Nutrition |
| Richard Welch | 182495462307 | Utu Outdoor Skincare |
| Rommel Vega | 182499382593 | Holo Footwear |
| Cindy Leung | 182495272449 | Etietech |
| Maddie Fender | 182357648700 | Created Co. |
| Beau Wynja | 34330613011 | Color Cord Company |
