# Resume Instructions for Claude

## IMMEDIATE SETUP
1. **Change directory:** `cd /Users/brent/scripts/CB-Workspace/cb-requestdesk`
2. **Verify branch:** `git branch --show-current` (should be: `feature/github-webhook-integration`)
3. **Check containers:** `docker ps` (expect: cbtextapp-backend-1, cbtextapp-frontend-1 running)

## SESSION METADATA
**Last Commit:** `ea096e8b Add agent_id filter and Agent column to posts list`
**MCP Entity:** `requestdesk-github-webhook`
**Saved:** 2026-01-06

## CURRENT TODO FILE
**Path:** file:/Users/brent/scripts/CB-Workspace/cb-requestdesk/todo/current/feature/github-webhook-integration/README.md
**Status:** Posts agent filtering complete, migration v0.36.2 in progress
**Directory Structure:** ✅ Complete (7+ files)

## WHAT WAS ACCOMPLISHED THIS SESSION

### Posts Agent Filtering (COMPLETE)
1. **Backend** (`posts.py`):
   - Added `agent_id: Optional[str]` query parameter to list_posts
   - Posts now filter by agent_id when provided

2. **Frontend** (`PostsList.tsx`):
   - Added Agent dropdown filter (always visible, ReferenceInput)
   - Added Agent column in table with ReferenceField linking to agent show page

### Data Analysis Completed
- Total posts: 391
- Valid posts (with existing agents): 390
- Invalid posts (to delete): 1
  - "Test Blog Post from Wizard" has `agent_id: "test123"` (not valid ObjectId)

## IN PROGRESS: Migration v0.36.2

**Purpose:** Clean up posts with invalid or orphaned agent_ids

**What it will do:**
1. Delete posts where agent_id is not a valid ObjectId format
2. Delete posts where agent_id points to a non-existent agent

**Affected:** Only 1 post - "Test Blog Post from Wizard" with agent_id "test123"

**Template file created:** `/Users/brent/scripts/CB-Workspace/cb-requestdesk/tmp/analyze-posts.js` (for analysis)

## TODO LIST STATE
- ✅ COMPLETED: Add agent_id filter to posts list endpoint
- ✅ COMPLETED: Add Agent column to posts table in frontend
- 🔄 IN PROGRESS: Create migration v0.36.2 to clean orphaned posts
- ⏳ PENDING: Test the filtering works correctly
- ⏳ PENDING: Enable requestdesk_blog_enabled on a RequestDesk agent
- ⏳ PENDING: Phases 1-6 - GitHub webhook integration

## NEXT ACTIONS (PRIORITY ORDER)
1. **CREATE migration v0.36.2:**
   ```
   /Users/brent/scripts/CB-Workspace/cb-requestdesk/backend/app/migrations/versions/v0_36_2_cleanup_orphaned_posts.py
   ```
   - Follow pattern from v0_36_1
   - Delete posts with invalid agent_id format (not valid ObjectId)
   - Delete posts with orphaned agent_id (agent doesn't exist)

2. **RUN migration:**
   ```bash
   docker exec cbtextapp-backend-1 python -m app.migrations.migration_manager --run
   ```

3. **TEST posts filtering:**
   - Visit http://localhost:3001/posts
   - Verify Agent column shows agent names
   - Verify Agent filter dropdown works

4. **CONTINUE with requestdesk_blog_enabled:**
   - Enable blog on a RequestDesk agent
   - Test public posts API returns those posts

## VERIFICATION COMMANDS
- Check posts count: `mongosh "mongodb://localhost:27017/requestdesk_production" --eval "db.posts.countDocuments()"`
- Check invalid posts: Use `/Users/brent/scripts/CB-Workspace/cb-requestdesk/tmp/analyze-posts.js`
- View posts UI: http://localhost:3001/posts
- Test API: `curl http://localhost:3000/api/posts/685b364ec902ddb30cc9a105`

## KEY FILES MODIFIED THIS SESSION
| File | Change |
|------|--------|
| `backend/app/routers/posts.py` | Added agent_id filter parameter |
| `frontend/src/components/posts/PostsList.tsx` | Added Agent column + filter |
| `tmp/analyze-posts.js` | Script to analyze posts for cleanup |

## CONTEXT NOTES
- **Company IDs:**
  - Content Cucumber: `6887adb332148b5ce2a8762b`
  - Content Basis LLC: `685b364ec902ddb30cc9a105`
- **RequestDesk agents exist** but have 0 published posts (all 158 are drafts)
- **Posts are NOT isolated by company** - this is a larger data isolation issue for later
- **Migration template:** Use v0_36_1 as reference for structure
