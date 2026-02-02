# Resume Instructions for Claude

## IMMEDIATE SETUP
1. **Directory:** `cd /Users/brent/scripts/CB-Workspace/brent-workspace`
2. **Identity:** Claude-Tolkien
3. **Branch:** main (not a git repo, Obsidian notes workspace)
4. **Last Activity:** 2026-01-31 ~16:23 HST

## WORKSPACES TOUCHED THIS SESSION
**Started in:** rd (requestdesk)
**Current:** brent (brent-workspace)
**All workspaces:** brent, cc (.claude skills/commands)

## SESSION METADATA
**MCP Entity:** Session-2026-01-31-planning-poker-campaign
**Saved:** 2026-01-31 16:23

## WHAT WE WERE DOING

### Planning Poker Social Campaign - SCHEDULED (27 posts live in Vista Social)

Built and scheduled a complete 2-week social campaign across 4 platforms promoting the blog post "Playing Planning Poker with Claude" on RequestDesk.

**Campaign Summary:**
- 27 total posts scheduled via Vista Social API
- LinkedIn: 5 posts (Sundays, Feb 1 - Mar 1)
- X: 10 posts (daily weekdays, Feb 2 - Feb 13)
- Bluesky: 8 posts (3-4x/week, Feb 2 - Feb 13)
- Threads: 4 posts (2x/week Mon+Thu, Feb 2 - Feb 12)
- All posts at 8:00 AM EST
- All Vista Social post IDs recorded in campaign.md

**Blog Post (Anchor Content):**
- Title: "Playing Planning Poker with Claude"
- Status: Draft on RequestDesk (MUST be published before Mon Feb 2)
- Post ID: post-5350d48d-1769910365
- MongoDB ID: 697eb05db2c2573326161643
- Edit URL: https://app.requestdesk.ai/blog-posts/697eb05db2c2573326161643/edit
- Live URL (after publish): https://requestdesk.ai/blog/playing-planning-poker-with-claude
- 1,549 words, passed terms checker

### /plan-social Skill - UPDATED

Major updates to `.claude/skills/social-campaign/SKILL.md`:
- Added anchor content framework to all 4 complexity levels
- Added per-platform cadence (X daily, Bluesky 3-4x/week, Threads 2x/week, LinkedIn 1x/week)
- Added Phase 2.5 (Anchor Content) with blog detail recording
- Added Phase 4.5 (Additional Content for Faster Platforms) with content multiplication
- Rewrote Phase 6 (Schedule) with Vista Social post ID recording and per-platform tables
- Rewrote Phase 7 (Save) with campaign folder structure (campaign.md + posts.md)
- Updated critical resources, campaign file template, added posts file template
- Version history updated with all changes

### S3 Sprint Planning - DONE (from earlier session by Claude-Austen)
All 12 steps complete. Sprint ready for Monday Feb 2.

## KEY FILES MODIFIED THIS SESSION (Claude-Tolkien)

**Campaign files (new folder: Sales and Marketing/campaigns/2026-02-planning-poker/):**
- `campaign.md` - Master campaign file with all 27 Vista Social post IDs, schedule tables, week-at-a-glance, results tracking
- `posts.md` - All 27 post drafts with platform-specific versions (5 core + quote pulls, hot takes, rephrased angles)
- `original-draft.md` - Archived original campaign draft (moved from LinkedIn Content folder)

**Blog draft:**
- `Company Websites/RequestDesk/Blog Draft Review/2026-01-31-planning-poker-with-ai-agents.md` - Local copy
- Also pushed to RequestDesk API as draft

**Dashboard:**
- `Sales and Marketing/ACTIVE-CAMPAIGNS.md` - Added Planning Poker to Upcoming section with link

**Skill:**
- `.claude/skills/social-campaign/SKILL.md` - Major updates (anchor content, per-platform cadence, phases 2.5/4.5/6/7 rewrite)

**Scheduling script (ran successfully, all 27 posts scheduled):**
- Script was in scratchpad, executed via bash, all posts returned IDs

## CRITICAL: BLOG MUST BE PUBLISHED BEFORE MON FEB 2

LinkedIn Post 1 goes out Sun Feb 1 (no blog link, just tension builder).
First post with blog link: X Quote Pull A on Tue Feb 3.
Brent MUST publish the blog from RequestDesk admin before then.

## VISTA SOCIAL POST IDs (for reference)

**LinkedIn:** 697eb71900b1231a30a8c3aa, 697eb7192272fa8ee1238b17, 697eb71ad376569aa6e3f6eb, 697eb71c2272fa8ee1238b4d, 697eb71cb701a7cc3584570d
**X (10):** 697eb71d2272fa8ee1238b75, 697eb71eb701a7cc35845722, 697eb71f81468d3db82d6aa7, 697eb71fd376569aa6e3f705, 697eb720f9eb51181e4b64d1, 697eb72181468d3db82d6ac6, 697eb72181468d3db82d6ad8, 697eb72200b1231a30a8c3df, 697eb72200b1231a30a8c3f0, 697eb72381468d3db82d6ae9
**Bluesky (8):** 697eb725b701a7cc35845759, 697eb725b701a7cc35845769, 697eb726b701a7cc35845777, 697eb72700b1231a30a8c433, 697eb72700b1231a30a8c447, 697eb728d376569aa6e3f728, 697eb72981468d3db82d6b00, 697eb72a00b1231a30a8c46e
**Threads (4):** 697eb72b81468d3db82d6b15, 697eb72cd376569aa6e3f743, 697eb72db701a7cc358457af, 697eb72ed376569aa6e3f757

## NEXT ACTIONS (if resuming this work)
1. **Publish the blog post** - Brent must do this from https://app.requestdesk.ai/blog-posts/697eb05db2c2573326161643/edit before Mon Feb 2
2. **Update ACTIVE-CAMPAIGNS.md** - Move Planning Poker from "Upcoming" to "Currently Active" once campaign starts Feb 1
3. **Monitor campaign performance** - Fill in results tracking tables in campaign.md as data comes in
4. **Test /plan-social on next campaign** - Use the updated skill framework to plan MM26FL Follow-up or another campaign

## DEFERRED QUESTIONS (Ask on /claude-start)
1. **Time tracking:** "How long did you work on the planning poker campaign today?"
   - Task: Social campaign planning, blog writing, 27 posts scheduled
   - Date: 2026-01-31
2. **Task status:** "Is the planning poker campaign work complete or continuing?"

## CONTEXT NOTES
- Campaign was originally in `LinkedIn Content/Social Posts/` folder, moved to `Sales and Marketing/campaigns/`
- LinkedIn posts are on Sundays for this campaign (Funday theme fits planning poker topic)
- Brent's LinkedIn calendar: Mon=Open, Tue=TWC, Wed=Newsletter, Thu=Entrepreneurial, Fri=Fun, Sat=Exercise, Sun=Funday
- The planning poker skill itself is a backlog item for S4 (not built yet, blog is honest about this)
- Blog draft passed terms checker (no em dashes, no banned words)
- All social posts use "first comment" for blog links (Vista Social comments parameter), not message body
