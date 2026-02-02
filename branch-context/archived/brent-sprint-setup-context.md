# Resume Instructions for Claude

## IMMEDIATE SETUP
1. **Directory:** `cd /Users/brent/scripts/CB-Workspace/brent-workspace`
2. **Branch:** `main`
3. **Last Commit:** `f66590e Session save: S2 planning complete`

## SESSION METADATA
**Saved:** 2026-01-17 22:50
**Sprint:** S2 (Jan 20-31, 2026)

## WORKSPACES TOUCHED THIS SESSION
**Started in:** brent (brent-workspace)
**Current workspace:** brent (brent-workspace)
**All workspaces:** brent, rd

| Shortcode | Workspace | What was done |
|-----------|-----------|---------------|
| `brent` | brent-workspace | S2 sprint setup, skill-creation skill |
| `rd` | requestdesk-app | Added sprint_id field to backlog model (IN PROGRESS) |

## WHAT WAS COMPLETED THIS SESSION

### 1. Created `skill-creation` skill
- **Location:** `.claude/skills/skill-creation/`
- **Files:** SKILL.md, command-template.md, skill-template.md, decision-examples.md
- **Purpose:** Guide Claude on when to create skills vs commands
- **Triggers:** "skill check", "make it a skill", "should this be a skill?"

### 2. Updated `sprint-management` skill
- **Added:** SPRINT SCHEDULE RULES section
- **Key rule:** Sprints run Mon-Fri only, never start on weekends
- **2nd Friday:** Retro + Planning day
- **Example dates:** S1=Jan 6-17, S2=Jan 20-31, S3=Feb 3-14

### 3. Created S2 Sprint in API
- **Sprint ID:** S2
- **ObjectId:** `696c41676fd57e40b5a1be74`
- **Dates:** Jan 20-31, 2026 (Mon-Fri)
- **Capacity:** 51 pts, Committed: 50 pts, 34 items
- **Status:** planned

### 4. Linked Backlog Items to S2
- **35 items** updated with `sprint: "S2"` (should be ObjectId)
- User requested proper ObjectId linking instead of string

## IN PROGRESS - BACKLOG MODEL UPDATE (rd workspace)

**Task:** Add `sprint_id` field and rename `sprint` to `sprint_name`

**Files Modified in rd:**
- `backend/app/models/backlog_item.py`
  - Added `sprint_id: Optional[str]` field (ObjectId reference)
  - Renamed `sprint` → `sprint_name` (human readable)
  - Updated in: BacklogItemBase, BacklogItemUpdate, BacklogItemResponse

**Still Needed:**
1. Create migration `v0_40_2_add_sprint_id_field.py`
2. Add index on `sprint_id`
3. Populate `sprint_id` from S2 ObjectId for existing items
4. Update backlog router to handle both fields

## TODO LIST STATE
- ✅ COMPLETED: Update sprint skill with Mon-Fri schedule rule
- ✅ COMPLETED: Create S2 in sprint API
- ✅ COMPLETED: Link backlog items to S2 (string version)
- 🔄 IN PROGRESS: Add sprint_id field to backlog model
- ⏳ PENDING: Create migration v0_40_2 for sprint_id field
- ⏳ PENDING: Populate sprint_id from S2 ObjectId

## KEY DATA

**Sprint API:**
- Base: `https://app.requestdesk.ai/api/sprints`
- Auth: `Authorization: Bearer wO1lEF5NC3BuCtQSHB5JSFXxTWfw5iwdyTruIEA0Quc`

**Backlog API:**
- Base: `https://app.requestdesk.ai/api/backlog`
- Auth: `Authorization: Bearer MNRcaklW3XF7UpKX4VrxPV7wo2L7xsWg`

**S2 Sprint ObjectId:** `696c41676fd57e40b5a1be74`

## NEXT ACTIONS (PRIORITY ORDER)
1. **FIRST:** Switch to rd workspace, create migration v0_40_2
2. **THEN:** Add index on sprint_id field
3. **THEN:** Update existing S2 items with proper ObjectId in sprint_id field
4. **VERIFY:** Query backlog items by sprint_id returns correct results

## DEFERRED QUESTIONS (Ask on /claude-start)
1. **Time tracking:** "How long did you work on S2 setup and sprint_id migration?"
   - Task: S2 sprint creation + backlog model update
   - Date: 2026-01-17
