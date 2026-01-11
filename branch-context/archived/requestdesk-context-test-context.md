# Resume Instructions for Claude

## IMMEDIATE SETUP
1. **Directory:** `cd /Users/brent/scripts/CB-Workspace/cb-requestdesk`
2. **Branch:** `feature/github-webhook-integration`
3. **Last Commit:** `2dbeb004 Update progress log for session save`

## SESSION METADATA
**Saved:** 2026-01-06
**Purpose:** Context usage test session

## WHAT WE WERE DOING
Investigating why /claude-save uses ~13% context on session restore.

## KEY FINDINGS
- MCP tools: 27.1k tokens (13.6%) - HubSpot tools are HUGE
- Skills/commands: ~60k+ tokens loaded
- Memory files: 2.4k tokens
- The claude-save.md skill alone is 5.5k tokens

## THE PROBLEM
The 13% context on restore comes from:
1. Auto-compact summary being injected (the long summary text)
2. CLAUDE.md files being read (~2.4k+ tokens each)
3. Context file being read
4. Progress log being read
5. Analysis script being read

## TODO LIST STATE
- ✅ COMPLETED: Add agent_id filter to posts list endpoint
- ✅ COMPLETED: Add Agent column to posts table in frontend
- 🔄 IN PROGRESS: Create migration v0.36.2 to clean orphaned posts
- ⏳ PENDING: Test the filtering works correctly

## MIGRATION CREATED
File: `/Users/brent/scripts/CB-Workspace/cb-requestdesk/backend/app/migrations/versions/v0_36_2_cleanup_orphaned_posts.py`
Status: Created but not yet run

## NEXT ACTIONS
1. Run migration: `docker exec cbtextapp-backend-1 python -m app.migrations.migration_manager --run`
2. Test posts filtering at http://localhost:3001/posts
