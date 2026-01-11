# Resume Instructions for Claude

## IMMEDIATE SETUP
1. **Directory:** `cd /Users/brent/scripts/CB-Workspace/cb-requestdesk`
2. **Branch:** `feature/github-webhook-integration`
3. **Last Commit:** `1c846e1d Switch posts to user-based filtering (agent_id) instead of broken company_id`

## SESSION METADATA
**Saved:** 2026-01-07
**MCP Entity:** `Session-2026-01-07-user-based-filtering`

## WHAT WE ACCOMPLISHED THIS SESSION

### 1. Created Recurring Bugs Tracking System
- **Location:** `/Users/brent/scripts/CB-Workspace/requestdesk-app/todo/recurring-bugs/`
- **First Bug Documented:** `company_id-data-isolation.md`
- **Purpose:** Track systemic issues that keep recurring across sessions

### 2. Fixed Posts Filtering (MAJOR FIX)
- **File:** `backend/app/routers/posts.py`
- **Problem:** Posts filtered by `company_id` which was broken (returned 0 posts)
- **Solution:** Now filters by `agent_id IN user's agents` (returns 237 posts)
- **Code Change:**
  ```python
  # OLD (broken):
  query["company_id"] = user_company_id

  # NEW (works):
  user_agents = db.db.agents.find({"created_by": username})
  query["agent_id"] = {"$in": user_agent_ids}
  ```

### 3. Investigated Astro Blog (Partially Complete)
- **URL:** http://localhost:3003/blog
- **Issue 1:** URL changed from `/api/posts/{company_id}` to `/api/public-posts/{company_id}` (earlier session)
- **Issue 2:** Public API filters by agents with `requestdesk_blog_enabled=true`
- **Current State:** User has published a post and UI toggle exists on agent page
- **Next Step:** User enables "Publish to RequestDesk.ai Blog" on agent, then blog should work

## TODO LIST STATE
- ✅ COMPLETED: Create recurring-bugs tracking system
- ✅ COMPLETED: Implement user-based filtering for posts
- ⏳ PENDING: Test posts grid in frontend at http://localhost:3001/posts
- 🔄 IN PROGRESS: Fix Astro blog - user action needed (enable agent toggle)

## KEY FILES MODIFIED THIS SESSION
| File | Change |
|------|--------|
| `backend/app/routers/posts.py` | Changed from company_id to agent-based filtering |
| `todo/recurring-bugs/README.md` | NEW - Recurring bugs tracking template |
| `todo/recurring-bugs/company_id-data-isolation.md` | NEW - company_id bug documentation |

## NEXT ACTIONS (PRIORITY ORDER)
1. **USER ACTION:** Enable "Publish to RequestDesk.ai Blog" toggle on agent at http://localhost:3001/agents/6925de2659be7b22ee7b5438
2. **VERIFY:** Check http://localhost:3003/blog shows the published post
3. **TEST:** Verify posts grid works at http://localhost:3001/posts (should show 237 posts)

## VERIFICATION COMMANDS
```bash
# Test posts API (should return 237 posts for cucumber user)
curl -s -X POST "http://localhost:3000/auth/token" -H "Content-Type: application/x-www-form-urlencoded" -d "username=cucumber&password=test1234" | python3 -c "import sys,json; print(json.load(sys.stdin).get('access_token',''))" > /tmp/token.txt
TOKEN=$(cat /tmp/token.txt)
curl -s "http://localhost:3000/api/posts?limit=1" -H "Authorization: Bearer $TOKEN" | python3 -c "import sys,json; print('Total:', json.load(sys.stdin).get('total'))"

# Test public posts API (after enabling agent toggle)
curl -s "http://localhost:3000/api/public-posts/685b364ec902ddb30cc9a105?limit=1"
```

## CONTEXT NOTES
- Docker containers running: backend (3000), frontend (3001), docs (3003)
- The `requestdesk_blog_enabled` UI toggle exists in `AgentEdit.tsx` line 558
- All 397 posts are currently drafts except 1 that was just published
- company_id filtering is documented as a recurring bug pattern - future fixes should use user-based approach
