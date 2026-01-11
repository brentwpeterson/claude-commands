# Resume Instructions for Claude

## IMMEDIATE SETUP
1. **Directory:** `cd /Users/brent/scripts/CB-Workspace/cb-requestdesk`
2. **Branch:** `feature/github-webhook-integration`
3. **Last Commit:** `98684bee Fix routing conflict and add company_id to shopify blog drafts`

## SESSION METADATA
**Saved:** 2026-01-06
**MCP Entity:** `Session-2026-01-06-posts-company-isolation`

## CURRENT TODO FILE
**Path:** `/Users/brent/scripts/CB-Workspace/cb-requestdesk/todo/current/feature/github-webhook-integration/README.md`
**Status:** Fixing company_id data isolation issues for posts

## WHAT WE WERE WORKING ON

### Original Issue
User reported Agent column doesn't show in posts grid at http://localhost:3001/posts

### Root Cause Chain Discovered

1. **First Bug Fixed:** `get_user_company_id()` was using RelationshipService which returned wrong company (orphaned Chalet Market instead of Content Basis LLC)
   - **Fix:** Added check for `user.company_id` directly before falling back to RelationshipService
   - **File:** `/backend/app/utils/user_context.py`
   - **Result:** Posts now return 214 (correct) instead of 17 (wrong company)

2. **Second Bug Fixed:** Public posts router at `/api/posts/{company_id}` was conflicting with main posts router at `/api/posts/{post_id}`
   - **Fix:** Changed public router prefix from `/posts` to `/public-posts`
   - **File:** `/backend/app/routers/public/posts.py`
   - **Result:** Post redirect after save now works correctly

3. **Third Bug Fixed:** Shopify blog save-draft wasn't setting `company_id` on posts
   - **Fix:** Added company_id extraction from agent (fallback to user) and include in post_doc
   - **File:** `/backend/app/routers/shopify_blog.py`
   - **Result:** New posts from shopify blog wizard will have company_id for filtering

## COMMITS THIS SESSION
1. `f15e0e6e` - Add company_id to posts for data isolation (migration v0.36.2)
2. `b0e9bd09` - Fix get_user_company_id to check user.company_id first
3. `98684bee` - Fix routing conflict and add company_id to shopify blog drafts

## TESTING STATUS
- ✅ Post creation works on master branch
- ✅ Backend routing fixed (public posts at /public-posts)
- ⏳ PENDING: User to test shopify blog post creation with new company_id fix

## NEXT ACTIONS (PRIORITY ORDER)
1. **TEST:** User creates blog post via Chalet Market agent to verify company_id is set
2. **VERIFY:** New post appears in posts grid (should have company_id now)
3. **OPTIONAL CLEANUP:**
   - 17 orphaned posts without company_id (old Chalet Market data)
   - 2 posts created during debugging also lack company_id

## KEY FILES MODIFIED THIS SESSION
| File | Change |
|------|--------|
| `backend/app/utils/user_context.py` | Check user.company_id first before RelationshipService |
| `backend/app/routers/posts.py` | Added company_id filtering and agent_id filter parameter |
| `backend/app/routers/public/posts.py` | Changed prefix to /public-posts |
| `backend/app/routers/shopify_blog.py` | Added company_id to save-draft endpoint |
| `frontend/src/components/posts/PostsList.tsx` | Added Agent column and filter |

## DATABASE REFERENCE
| Company ID | Name | Posts Count |
|------------|------|-------------|
| `685b364ec902ddb30cc9a105` | Content Basis LLC | 214 |
| `6887adb332148b5ce2a8762b` | Content Cucumber | 158 |
| `68006f70238fbabb9cf794aa` | ORPHANED (Chalet Market) | 17 |

## VERIFICATION COMMANDS
```bash
# Get fresh token
curl -s -X POST "http://localhost:3000/auth/token" -H "Content-Type: application/x-www-form-urlencoded" -d "username=cucumber&password=test1234" | jq -r ".access_token" > /tmp/token.txt

# Test posts count (should be 214 for cucumber user)
TOKEN=$(cat /tmp/token.txt)
curl -s "http://localhost:3000/api/posts?limit=1" -H "Authorization: Bearer $TOKEN" | jq '.total'

# Test agent lookup
curl -s "http://localhost:3000/api/agents/6925de2659be7b22ee7b5438" -H "Authorization: Bearer $TOKEN" | jq '{name, company_id}'
```

## CONTEXT NOTES
- Production works correctly - all issues were in feature branch code
- The cucumber user has 3 team_membership relationships, but only one is their primary company
- Chalet Market company was deleted but relationships and posts remain (orphaned data)
- Frontend uses ReferenceField which requires correct company filtering to work
