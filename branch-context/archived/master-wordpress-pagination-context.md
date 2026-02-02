# Resume Instructions for Claude

## IMMEDIATE SETUP
1. **Change directory:** `cd /Users/brent/scripts/CB-Workspace/cb-requestdesk`
2. **Verify git status:** `git status` (expect: clean working directory on master)
3. **Check processes:** `docker ps` (expect: cbtextapp-backend-1, cbtextapp-frontend-1 running)
4. **Verify branch:** `git branch --show-current` (should be: master)

## CURRENT TODO FILE
**Path:** file:/Users/brent/scripts/CB-Workspace/cb-requestdesk/todo/current/feature/wordpress-image-upload/README.md
**Status:** Working on blog posts pagination debugging - pagination buttons not working
**Directory Structure:** ⚠️ Enhanced (10/7 files) - includes debug files and JSON artifacts from investigation
**Architecture Map:** CB internal project - architecture-map.md exists and contains task details

## WHAT YOU WERE WORKING ON
**Blog Posts Pagination Fix** - User reported "pagenation no worky" after implementing server-side pagination. Featured images are now working ("featured image is working?!?!?!?!?!") but pagination Previous/Next buttons are not functioning. Also need to fix missing WordPress link icons in blog posts table.

## CURRENT STATE
- **Last command executed:** Added console debugging to blog posts pagination buttons and fetchBlogPosts function
- **Files modified:**
  - `frontend/src/components/features/BlogPosts/BlogPostsListTanStack.tsx` (pagination debugging + featured image fixes)
  - `frontend/src/components/features/BlogPosts/types.ts` (standardized featured_image_url field)
  - `backend/app/services/wordpress_content_service.py` (cleaned redundant field storage)
- **CB Flow Impact:** Frontend BlogPosts → DataProvider → Router (knowledge_chunks) → WordPressContentService → KnowledgeChunks Collection
- **Tests run:**
  - ✅ Featured images confirmed working by user
  - ❌ Pagination buttons not working (user confirmed "nononononononono Great! The pagination is working now. is notworking????")
  - ❌ WordPress link icons missing in WordPress column
- **Issues found:** Pagination Previous/Next buttons don't trigger page changes, WordPress URLs exist in data but icons not displaying

## TODO LIST STATE
- 🔄 IN PROGRESS: Fix pagination - it's not working (USER APPROVED: No)
- ⏳ PENDING: Debug why pagination Previous/Next buttons don't work (USER APPROVED: No)
- ⏳ PENDING: Fix missing WordPress link icons in blog posts table (USER APPROVED: No)

## COMPLETION APPROVAL STATUS
**🚨 CRITICAL RULE**: NEVER mark tasks as completed until user explicitly approves

### Completion Trigger Protocol
**Current status: DEBUGGING PAGINATION - NOT COMPLETE**

**BEFORE asking about completion, Claude MUST:**
1. **Check for Acceptance Criteria**: User wants working pagination with Previous/Next buttons that actually change pages
2. **Verify each criteria point**:
   - [ ] Previous/Next buttons trigger page changes
   - [ ] Console debugging shows fetchBlogPosts being called with correct page numbers
   - [ ] API actually returns different data sets for different pages
   - [ ] Page counter updates correctly ("Page X of Y")
   - [ ] WordPress link icons display correctly in WordPress column
3. **🚨 NEVER DECLARE COMPLETION - ASK FOR USER APPROVAL**
4. **WAIT FOR EXPLICIT CONFIRMATION**: User must test and confirm "pagination works" or "buttons work now"

## NEXT ACTIONS (PRIORITY ORDER)
1. **FIRST:** Open browser console and test pagination buttons to see debug output
2. **THEN:** Check console logs when clicking Next/Previous: `console.log('Next clicked, going to page:', currentPage + 1)`
3. **VERIFY:** If button clicks are logged, check if `fetchBlogPosts` is called with correct page numbers
4. **DEBUG:** If fetchBlogPosts is called but no new data loads, investigate dataProvider.getList parameters
5. **FIX:** WordPress link icons - check console for WordPressLink debug logs
6. **TEST:** Verify both features work before asking for user approval

## VERIFICATION COMMANDS
- Test pagination: Open `http://localhost:3001` → Blog Posts → Open browser console → Click Next/Previous
- Check WordPress URLs in API: `curl -H "Authorization: Bearer TOKEN" "http://localhost:3000/api/knowledge_chunks?limit=1&source_type=wordpress" | jq '.[0].metadata.wordpress_url'`
- View frontend logs: Browser console when using blog posts page

## CONTEXT NOTES
**Critical Discovery**: Featured images are now working correctly after standardizing on `featured_image_url` field across WordPress plugin, RequestDesk backend, and frontend. The pagination issue is likely in the React component state management or the dataProvider not properly sending page parameters to the backend API.

**Debugging Added**: Console logs in BlogPostsListTanStack.tsx show:
- Button click events
- fetchBlogPosts function calls with page parameters
- API parameters being sent
- API response data
- WordPress link component debug info

**WordPress Plugin Status**: Updated to v2.2.9 with cleaned featured image fields, but user may still need to install this version for full cleanup.

**Architecture Impact**: Changes span Frontend (React components) → DataProvider (blog-posts maps to knowledge_chunks) → Backend API (knowledge_chunks endpoint) - need to trace where pagination parameters are lost.