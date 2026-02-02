# Resume Instructions for Claude

## IMMEDIATE SETUP
1. **Directory:** `cd /Users/brent/scripts/CB-Workspace/brent-workspace`
2. **Branch:** `main`
3. **Last Commit:** `d192677 S2 Sprint Planning: Created sprint-plan.md with 50 pts committed`

## SESSION METADATA
**Saved:** 2026-01-17
**Workspace:** brent-workspace
**Context:** S2 Sprint Planning Complete

## WHAT WE ACCOMPLISHED

### S2 Sprint Planning Complete
- **Capacity:** 51 pts (8 working days, 20% buffer)
- **Committed:** 50 pts (34 items)
- **Headroom:** 1 pt

### Deployment
- Deployed `matrix-v0.39.4-sprint-planning-fields` to production
- Added 9 new sprint planning fields to backlog model
- Fixed priority 0 validation (was blocked, now allowed)

### Documentation
- Created `S2/sprint-plan.md` with all committed items
- Created `plans/sprint-collection-plan.md` for velocity tracking feature
- Updated `/add-backlog` skill with API gotchas (datetime format)

### API Learnings Documented
- `grooming_date` requires full ISO datetime: `2026-01-17T12:00:00` (not just date)
- Priority 0 is valid (range 0-5)
- Batch grooming format: `#-pts-priority` (e.g., `42-1-0`)

## TODO LIST STATE
- [x] Review P0 story points (25 items)
- [x] Clean up duplicates and obsolete items
- [x] Resolve P0 capacity
- [x] Fix API: Allow priority 0
- [x] Add grooming_date field
- [x] Add is_planned field
- [x] Test API changes locally
- [x] Deploy to production
- [x] Update 6 items to P0 after deploy
- [x] Create S2 sprint-plan.md

## S2 SPRINT READY
All planning complete. Sprint starts January 19, 2026.

**Key Files:**
- Sprint Plan: `ob-notes/Brent Notes/Dashboard/Planning/2026/Q1/S2/sprint-plan.md`
- Sprint Collection Plan: `plans/sprint-collection-plan.md`
- Grooming Doc: `ob-notes/Brent Notes/Dashboard/Planning/2026/Q1/S2/backlog-grooming-2026-01-16.md`

## BACKLOG API REFERENCE
**Production:** `https://app.requestdesk.ai/api/backlog`
**Auth:** `Authorization: Bearer MNRcaklW3XF7UpKX4VrxPV7wo2L7xsWg`

**DateTime Format (CRITICAL):**
```bash
# WRONG: "2026-01-17" → Error
# RIGHT: "2026-01-17T12:00:00" → Works
```

## NEXT ACTIONS
1. **Sprint starts Jan 19** - Begin executing S2 items
2. **Sprint Collection (2 pts)** - Implement velocity tracking (see plan)
3. **Daily standups** - Use backlog API to track progress

## DEFERRED QUESTIONS (Ask on /claude-start)
1. **Time tracking:** "How long did you work on S2 planning today?"
   - Task: S2 Sprint Planning + Backlog Grooming
   - Date: 2026-01-17
