# Resume Instructions for Claude

## IMMEDIATE SETUP
1. **Verify HTTP OpenMemory first:** Check `curl -s http://localhost:8080/health` (should return {"ok":true})
2. **If OpenMemory down:** Start with `cd /Users/brent/scripts/OpenMemory/backend && npm run dev &`
3. **Change directory:** `cd /Users/brent/scripts/CB-Workspace`
4. **Verify git status:** `git status` (expect: modified submodules, untracked claude commands)
5. **Check processes:** `docker ps` (expect: 4 containers running)
6. **Verify branch:** `git branch --show-current` (should be: feature/wordpress-image-upload)

## HTTP OPENMEMORY STATUS
**OpenMemory Server:** ✅ Running on http://localhost:8080 with Deep tier (94% recall)
**Memory Scripts Path:** `/Users/brent/scripts/CB-Workspace/cb-memory-system/scripts/`
**Available Operations:** store-memory.sh, query-memory.sh, list-memories.sh

## CURRENT TODO FILE
**Path:** `/Users/brent/scripts/CB-Workspace/cb-requestdesk/todo/current/feature/wordpress-image-upload/README.md`
**Status:** Working on WordPress blog posts pagination/search/title display fixes
**Directory Structure:** ⚠️ Enhanced (10/7 files) - 7 standard + 3 work artifacts
**Architecture Map:** ⚠️ Template (0/X checklist items completed, 52 placeholders remaining)

## WHAT YOU WERE WORKING ON
WordPress Blog Posts UI improvements in cb-requestdesk frontend. Pagination and sorting were FIXED, but two issues remain:
1. **Search box not working** - Global filter not connected to API calls in fetchBlogPosts
2. **Title column showing excerpt** - Need to find correct title field in metadata vs excerpt

## CURRENT STATE
- **Last work:** Session restored from wordpress-pagination-search-context.md
- **Files modified:**
  - `backend/app/routers/knowledge_chunks.py` (pagination + sorting) → CB Flow: Router → Service Layer
  - `frontend/src/components/features/BlogPosts/BlogPostsListTanStack.tsx` (sorting + debugging) → CB Flow: Frontend Components
  - `frontend/src/dataProvider/core/resourceProvider.ts` (skip parameter) → CB Flow: Frontend → DataLayer
- **CB Flow Impact:** Frontend (BlogPosts component) → DataLayer (resourceProvider) → Router (knowledge_chunks) → Service Layer → Model → Collection
- **Tests run:** Manual verification of pagination/sorting at http://localhost:3001/blog-posts
- **Working features:** Pagination shows "1-25 of 635", column sorting works across dataset
- **Issues found:** Search box inactive, titles show excerpts instead of actual titles

## TODO LIST STATE
**🚨 CRITICAL RULE**: NEVER mark tasks as completed until user explicitly approves

- ⏳ PENDING: Fix search box - connect globalFilter state to API calls in fetchBlogPosts
- ⏳ PENDING: Fix title column - find correct title field in metadata vs excerpt
- ⏳ PENDING: Test search and title features together with pagination/sorting

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

**Completion Requirements:**
- **Completed Items**: Only mark as completed if user has said "this is done" or "approved"
- **Context Indicator**: Always note "USER APPROVED: Yes" for completed items
- **Acceptance Criteria**: All todos MUST include clear acceptance criteria before completion
- **Criteria Check**: Read and verify ALL acceptance criteria before asking for approval

## NEXT ACTIONS (PRIORITY ORDER)
1. **FIRST:** Set TodoWrite status - mark search box task as in_progress
2. **THEN:** Examine BlogPostsListTanStack.tsx to understand current globalFilter implementation
3. **THEN:** Check fetchBlogPosts function to see where search parameter should be connected
4. **VERIFY:** Test search functionality manually in browser

## VERIFICATION COMMANDS
- Check feature: http://localhost:3001/blog-posts
- Test search: Try typing in search box and check network requests
- View logs: `docker logs cbtextapp-backend-1 --tail 50`
- Check API: `curl "http://localhost:3000/api/knowledge_chunks?search=test&skip=0&limit=25"`

## CONTEXT NOTES
- Previous pagination/sorting fixes are working correctly
- Search box appears in UI but doesn't trigger API calls
- Title column currently shows 'excerpt' field instead of proper post titles
- All Docker containers are stable and running
- OpenMemory HTTP server available for intelligent context storage
- Todo directory has extra work artifacts (json files) beyond standard 7-file structure