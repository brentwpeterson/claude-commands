# Resume Instructions for Claude

## IMMEDIATE SETUP
1. **Change directory:** `cd /Users/brent/scripts/CB-Workspace/cb-requestdesk`
2. **Verify git status:** `git status` (expect: clean working directory after commit)
3. **Check processes:** `docker ps` (expect: 4 containers - frontend:3001, backend:3000, mailhog:8025, redis:6379)
4. **Verify branch:** `git branch --show-current` (should be: master)

## CURRENT TODO FILE
**Path:** `./todo/current/feature/wordpress-image-upload/README.md`
**Status:** Working on WordPress Blog Posts UI debugging - search box and title column issues
**Directory Structure:** ⚠️ Enhanced (10/7 files) - 7 standard files + 3 work artifacts (json files)
**Architecture Map:** ✅ Complete for WordPress image upload (original task)

## WHAT YOU WERE WORKING ON
WordPress Blog Posts UI fixes in cb-requestdesk frontend. Two main issues were being addressed:
1. **Search box not working** - Search input visible but not connected to API calls
2. **Title column showing wrong content** - Displaying excerpt content instead of actual post titles

## CURRENT STATE
- **Last work:** Both search and title fixes implemented but frontend still showing "1-0 of 0 blog posts"
- **Files modified and committed:**
  - `backend/app/routers/knowledge_chunks.py` - Added search parameter with regex search functionality
  - `frontend/src/components/features/BlogPosts/BlogPostsListTanStack.tsx` - Connected search box to API + title extraction from URL slugs + debugging
  - `frontend/src/components/features/BlogPosts/types.ts` - Added title fields and flexible metadata typing
- **CB Flow Impact:** Frontend (BlogPosts component) → DataLayer (BaseResourceProvider) → Router (knowledge_chunks) → Database (MongoDB regex search)
- **Backend Testing:** Search API working (tested: 635 total records, "influencer" returns 65 results)
- **Frontend Issue:** Console shows API returning 635 records but UI displays "1-0 of 0 blog posts"
- **Debug Status:** Added comprehensive logging to identify response processing issue

## TODO LIST STATE (NOT USER APPROVED)
**🚨 CRITICAL RULE**: NEVER mark tasks as completed until user explicitly approves

- ❌ **BLOCKED**: Fix search box - Backend working, frontend API calls successful, but UI shows 0 results (USER APPROVED: No)
- ❌ **BLOCKED**: Fix title column - Implementation done but not visible due to 0 results issue (USER APPROVED: No)
- 🔄 **IN PROGRESS**: Debug frontend response processing - Console shows data exists but UI shows empty state

### Console Evidence of Issue
**API Response (Working):** `🐛 DEBUG: API response: {total: 635, dataLength: 25, firstRecord: {...}}`
**Frontend Display (Broken):** "Showing 1-0 of 0 blog posts"

### Completion Trigger Protocol
**🚫 CLAUDE CAN NEVER DECLARE TASKS COMPLETE - ONLY HUMANS CAN**

**BEFORE asking about completion, Claude MUST:**
1. **Check for Acceptance Criteria**: Does the todo have clear acceptance criteria?
2. **If NO criteria exist**: STOP and ask user: "What are the acceptance criteria for this task?"
3. **If criteria exist**: Verify each criteria point is met
4. **🚨 NEVER DECLARE COMPLETION - ASK FOR USER APPROVAL**:
   - **NEVER SAY**: "Task is complete" or "Implementation finished"
   - **ALWAYS ASK**: "Based on the acceptance criteria, does this appear ready for you to mark as complete?"
   - **WAIT FOR EXPLICIT CONFIRMATION**: User must say "yes", "complete", "done", or "approved"
   - **IF UNCERTAIN**: Ask "Should I mark this as complete?" and wait for response

## NEXT ACTIONS (PRIORITY ORDER)
1. **FIRST:** Ask user to refresh blog posts page and check console for new debug messages:
   - `🐛 DEBUG: Full response object:`
   - `🐛 DEBUG: response.total type:`
   - `🐛 DEBUG: response.data type:`
   - `🐛 DEBUG: Setting total to:`
2. **THEN:** Analyze response object structure to identify why UI shows 0 despite API returning 635
3. **VERIFY:** Fix the response processing issue in frontend state management
4. **TEST:** Confirm both search and title column features work correctly

## VERIFICATION COMMANDS
- Check feature: http://localhost:3001/blog-posts (should show 25 posts, not "1-0 of 0")
- Test search: Type in search box and verify API calls with network tab
- Test title extraction: Verify titles show "How To Do Influencer Marketing On X" not excerpts
- Backend API test: `curl "http://localhost:3000/api/knowledge_chunks?source_type=wordpress&limit=25" -H "Authorization: Bearer [token]"`

## TECHNICAL IMPLEMENTATION DETAILS
**Search Implementation:**
- Frontend: `globalFilter` → `params.filter.search` → BaseResourceProvider → `?search=term`
- Backend: `search` parameter → regex search across content, metadata.excerpt, metadata.wordpress_url, source_file
- Pattern: `{"$regex": search, "$options": "i"}` with `$or` operator

**Title Extraction:**
- WordPress posts have no dedicated title field in metadata
- Extract from `wordpress_url` slug: `"how-to-do-influencer-marketing-on-x"` → `"How To Do Influencer Marketing On X"`
- Fallback chain: URL slug → excerpt first line → content substring → "WordPress Post"

**Response Processing Issue:**
- API correctly returns: `{data: [...25 posts], total: 635}`
- Frontend receives data but `setTotal()` or `setData()` not updating UI state correctly
- Need to debug: response object structure, data types, state setter calls

## CONTEXT NOTES
- Docker containers stable and auto-restart on code changes
- Backend was restarted to apply search functionality changes
- User reported seeing console output but still shows 0 results in UI
- This is a response processing bug, not an API issue
- Original WordPress image upload task in todo directory was completed previously
- Current work is related but different: frontend Blog Posts UI improvements