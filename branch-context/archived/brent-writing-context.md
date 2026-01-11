# Resume Instructions for Claude

## IMMEDIATE SETUP
1. **Change directory:** `cd /Users/brent/scripts/CB-Workspace/brent-writing`
2. **Verify branch:** `git branch --show-current` (should be: feature/dspy-first-impressions)
3. **Check article:** `ls "ob-notes/Brent Notes/LinkedIn Articles/"`

## SESSION METADATA
**Last Commit:** `6bb3af1 Update RequestDesk LinkedIn article with verified stats and promotional assets`
**Saved:** 2024-12-24

## WHAT WE COMPLETED THIS SESSION (2024-12-24)

### LinkedIn Article Ready for Publishing
**File:** `ob-notes/Brent Notes/LinkedIn Articles/your-brand-sounds-different-everywhere.md`
**Topic:** RequestDesk launch - brand voice consistency problem
**Status:** READY TO PUBLISH - article complete with promotional assets

### Key Edits Made:
1. **Rewrote intro** - Christmas Eve timing, authentic Content Cucumber story about AI making writers feel less valuable, pendulum swinging back to humans
2. **Fixed all statistics** - Verified every stat with real sources:
   - 52% reduced engagement (eMarketer)
   - 60% doubt authenticity (eMarketer)
   - 73% UK worry about AI content (YouGov)
   - 23% higher revenue (Inc/Lucidpress)
   - 68% report 10-20% growth (G2/Lucidpress)
   - 95% have guidelines, 25% use them (Inc/Lucidpress)
   - 23% more engagement on consistent social posts (Sprout Social)
3. **Removed unsourced claim** - 35% trust score stat had no clean source
4. **Added inline hyperlinks** - All stats now clickable in Obsidian
5. **Added 7 screenshot placeholders** - For RequestDesk dashboard reports
6. **Generated promotional assets** - Meta title, description, LinkedIn post, newsletter intro

### Terms System Update:
- Added "The Problem Nobody Talks About" to avoided terms via API (confirmed added)

### Screenshot Placeholders Added:
1. Brand Voice Score - 92%
2. Messaging Alignment - 74%
3. Terminology Compliance - 58%
4. Audience Targeting Accuracy - 88%
5. Tone & Sentiment Analysis - 71%
6. Style Guide Adherence - 62%
7. Competitor SWOT Analysis

### ALT Text Ready:
All 7 screenshots have ALT text prepared for accessibility.

## ARTICLE STATUS: READY TO PUBLISH

**Next steps for Brent:**
1. Open article in Obsidian for final review
2. Copy article content to LinkedIn
3. Replace `[ADD SCREENSHOT: ...]` placeholders with actual images
4. Post LinkedIn promotional post (in Promotional Assets section)
5. Add article link in comments
6. Use newsletter intro for weekly email

## KEY API ENDPOINTS

```bash
# Brand Persona
POST https://app.requestdesk.ai/api/agent/content
Auth: Bearer WOfNoONZNyPOEja1-ClY2-3e6_J-aK28PtUWr4DLRyg

# Check Content Terms
POST https://app.requestdesk.ai/api/typingmind/proxy/terms-checker
Body: { "text": "...", "include_global": true }

# Add Content Terms
POST https://app.requestdesk.ai/api/typingmind/proxy/content-terms
Body: { "term": "...", "term_type": "avoid|use|conditional", "context": "..." }
```

## SKILLS CREATED (Previous Session)

### /brent-writing Skill
**File:** `/Users/brent/scripts/CB-Workspace/.claude-local/commands/brent-writing.md`

Complete content creation wizard with:
- Brand Persona Loading
- Content Type Selection (Tuesdays with Claude, LinkedIn Articles)
- What/So What Framework for LinkedIn
- Save-First Workflow
- Post-Approval Assets Generation
- Content Terms API Integration
- Problem Logging
- Pattern Review Sessions

### /brand-brent Command
**File:** `/Users/brent/scripts/CB-Workspace/.claude-local/commands/brand-brent.md`

## CONTEXT NOTES
- brent-writing is a separate git repo at `/Users/brent/scripts/CB-Workspace/brent-writing`
- Command files are in `/Users/brent/scripts/CB-Workspace/.claude-local/commands/`
- Article is about RequestDesk launch - brand voice consistency for e-commerce
- All stats verified with real sources and hyperlinked
