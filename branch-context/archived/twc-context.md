# Resume Instructions for Claude

## IMMEDIATE SETUP
1. **Directory:** `cd /Users/brent/scripts/CB-Workspace/brent-workspace`
2. **Branch:** `main`
3. **Last Commit:** `5ba4ac4` Add Tuesdays with Claude sprint planning article and capture system

## SESSION METADATA
**Project:** brent-workspace (TWC - Tuesdays with Claude)
**MCP Entity:** twc-article-system
**Saved:** 2026-01-11

## WHAT WAS ACCOMPLISHED

### 1. API Authentication Strategy Discussion
- Documented Agent API Key vs JWT Token authentication patterns
- Created `/Users/brent/scripts/CB-Workspace/astro-sites/requestdesk-ai/API-KEY-ROTATION.md`
- Tested scoped permissions - FOUND THEY DON'T EXIST at API key level
- Added "Implement API Key Scopes" to backlog (P2)

### 2. TWC Command System Created
Commands in `/Users/brent/scripts/CB-Workspace/.claude/commands/`:
- `twc-start.md` - Start article capture (with --research flag)
- `twc-finish.md` - Generate article from context
- `twc-note.md` - Add notable insight
- `twc-status.md` - Check active drafts
- `twc-backlog.md` - View article pipeline

### 3. Sprint Planning Article Written
**Article:** `ob-notes/Brent Notes/Tuesdays with Claude/tuesdays-with-claude-sprint-planning-system.md`
- **Status:** READY for Tuesday Jan 14 publication
- **Hook:** "Claude kept forgetting my Google Sheet"
- **Key insight:** External tools evaporate between sessions, internal tools persist
- **Irony section:** Claude built sophisticated planning system but forgot to write docs

**LinkedIn Post:** `ob-notes/Brent Notes/Tuesdays with Claude/social-posts/linkedin-post-sprint-planning-system.md`

### 4. Dashboard README Created
**File:** `ob-notes/Brent Notes/Dashboard/README.md`
- Explains sprint cycle, story points, priority framework
- Fixes "the irony" - system now has documentation

### 5. Article Pipeline Set Up
**Backlog:** `ob-notes/Brent Notes/Tuesdays with Claude/backlog.md`
- Week 3 (Jan 14): Sprint Planning System - READY
- Week 4 (Jan 21): HubSpot MCP for Contact Enrichment - capturing
- Week 5 (Jan 28): Building the TWC Capture System - idea
- Week 6 (Feb 4): API Authentication Patterns - idea

## SPRINT INFO
- **Q1 2026:** 7 two-week sprints (not 26 weeks)
- **Sprint 1:** Jan 6-17, 2026 - COMPLETE
- **Story Points:** 1 (15-30min) → 13 (multi-day, break down)
- **Priorities:** P0 (hard deadline) → P3 (backlog)

## NEXT ACTIONS
1. **Tuesday Jan 14:** Publish sprint planning article
2. **Start Week 4 capture:** `/twc-start HubSpot MCP Enrichment --research`
3. **Context file exists:** `bw-hubspot-enrichment-context.md` has HubSpot work context

## KEY FILES
| File | Purpose |
|------|---------|
| `tuesdays-with-claude-sprint-planning-system.md` | Week 3 article (READY) |
| `linkedin-post-sprint-planning-system.md` | LinkedIn companion |
| `backlog.md` | Article pipeline |
| `Dashboard/README.md` | Planning system docs |

## MCP INTEGRATIONS IN USE
- **Memory:** Session persistence across conversations
- **HubSpot:** CRM operations, contact enrichment
- **Slack:** Team notifications

## CONTEXT NOTES
- User clarified: 26 sprints/YEAR, not 26 weeks in Q1
- Q1 = 7 sprints (13 weeks / 2 weeks each = 6.5, rounded to 7)
- Article was corrected: "Sprint 1 complete. Six more this quarter."
