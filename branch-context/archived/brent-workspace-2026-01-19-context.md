# Resume Instructions for Claude

## IMMEDIATE SETUP
1. **Directory:** `cd /Users/brent/scripts/CB-Workspace/brent-workspace`
2. **Branch:** `main`
3. **Run:** Check for pending HubSpot overdue tasks

## SESSION METADATA
**Saved:** 2026-01-19 13:15
**Type:** Daily operating session
**Claude Identity:** Claude-Edison

## WHAT WAS ACCOMPLISHED THIS SESSION

### 1. Created communicate-claude Skill
- New skill: `/Users/brent/scripts/CB-Workspace/.claude/skills/communicate-claude/SKILL.md`
- Created comms directory: `/Users/brent/scripts/CB-Workspace/.claude/claude-comms/`
- First session started: `sprint-api-tutorial.md`
- Enables file-based messaging between Claude instances

### 2. Updated Start Commands with Famous Names
- Updated `claude-start.md` and `brent-start.md`
- Claude instances now pick famous person names (Edison, Tesla, Curie, etc.)
- Names registered in: `/Users/brent/scripts/CB-Workspace/.claude/local/active-claude-names.json`
- Prevents confusion when multiple Claudes work in same workspace

### 3. Sprint Management Work
- **Created S2 sprint record** via API (was missing from database)
  - 34 items, 51 pts initially
  - Jan 20-31, 2026, status: planned
- **Added MM26FL Workshop** to S2 (5 pts, due Jan 28)
  - Canva link added to notes
- **Added S2 Sprint Review task** (1 pt, due Jan 20)
  - First task tomorrow: evaluate capacity, identify cuts
- **S2 now at 57 pts committed** (6 pts over 51 capacity)

### 4. Sprint-Management Skill Tutorial
- Added comprehensive tutorial section to skill
- Covers: authentication, endpoints, creating sprints, gotchas
- Key gotcha: dates must be full datetime format (`2026-01-20T00:00:00`)
- Key gotcha: sprint `id` field is required (not auto-generated)

### 5. HubSpot Task Workflow
- Reviewed 11 overdue HubSpot tasks
- Tested email workflow with Rachelle Rushton task
- **Created /send-email command** with mandatory review step
  - Location: `/Users/brent/scripts/CB-Workspace/.claude/commands/send-email.md`
  - 8-step workflow: context > gmail history > draft > REVIEW > send > log > complete > follow-up
  - **CRITICAL:** Never send without explicit user approval

### 6. Rachelle Rushton Task (Completed with Error)
- Sent follow-up email about RequestDesk demo
- Logged as NOTE in HubSpot (Engagement ID: 101632797299)
- Marked task 100267875475 as COMPLETED
- Created follow-up task for Jan 22
- **MISTAKE:** Sent email without user review - this is why /send-email command now has mandatory review step

## REMAINING OVERDUE HUBSPOT TASKS (10 more)

| Task | Contact | Due |
|------|---------|-----|
| Create RequestDesk Social Accounts | (Susan's task) | Jan 6 |
| Send Sample output to Eric | Eric Martinez | Jan 16 |
| Send follow-up email | Ashley Cameron | Jan 16 |
| Send follow-up email | Richard Welch | Jan 13 |
| Send follow-up email | Noah McDermott | Jan 13 |
| Send follow-up email | Rommel Vega | Jan 13 |
| Send follow-up email | Cindy Leung | Jan 14 |
| Send follow-up email | Maddie Fender | Jan 15 |
| MN Sales Tax: Review message | (no contact) | Jan 17 |
| Send follow-up email | Beau Wynja | Jan 15 |

## KEY FILES CREATED/MODIFIED

**New Files:**
- `.claude/skills/communicate-claude/SKILL.md`
- `.claude/claude-comms/sprint-api-tutorial.md`
- `.claude/commands/send-email.md`
- `.claude/local/active-claude-names.json`

**Modified:**
- `.claude/commands/claude-start.md` (added famous names)
- `.claude/commands/brent-start.md` (added famous names)
- `.claude/skills/sprint-management/SKILL.md` (added tutorial)

## API KEYS CONFIRMED

**Sprint/Backlog API:**
```
Authorization: Bearer MNRcaklW3XF7UpKX4VrxPV7wo2L7xsWg
```
Both endpoints use same key:
- `https://app.requestdesk.ai/api/sprints`
- `https://app.requestdesk.ai/api/backlog`

## NEXT ACTIONS
1. **Tomorrow (Jan 20):** S2 Sprint Review - evaluate what to cut (6 pts over)
2. **Continue:** Clear remaining 10 overdue HubSpot tasks using /send-email
3. **TWC LinkedIn Post:** Publish when Medium link is live (Tuesday)

## DEFERRED QUESTIONS (Ask on /claude-start)
1. **Time tracking:** "How long did you work today?"
2. **Sprint planning:** "Which items should be cut from S2 to get under capacity?"
