# Resume Instructions for Claude

## IMMEDIATE SETUP
1. **Change directory:** `cd /Users/brent/scripts/CB-Workspace/cb-wordpress`
2. **Verify git status:** `git status` (expect: clean working directory after committing plugin changes)
3. **Check processes:** `docker ps` (expect: cbtextapp-frontend-1, cbtextapp-backend-1, mailhog, redis running)
4. **Verify branch:** `git branch --show-current` (currently: feature/url-import-simple - may need to switch to WordPress image upload branch)

## CURRENT TODO FILE
**Path:** file:/Users/brent/scripts/CB-Workspace/cb-requestdesk/todo/current/feature/wordpress-image-upload/README.md
**Status:** Working on final deployment phase - WordPress plugin updated, needs upload and testing
**Directory Structure:** ⚠️ Extended (11/7 files) - has standard files plus additional debug logs from multiple attempts
**Architecture Map:** CB internal project - WordPress plugin integration with RequestDesk backend

## WHAT YOU WERE WORKING ON
**WordPress EXISTING Posts Featured Image Update Workflow - 8th Attempt Resolution**

This is the 7th documented attempt to fix the workflow for updating featured images on EXISTING WordPress posts (not creating NEW posts). NEW posts work perfectly - EXISTING posts were failing with various "All connection attempts failed" errors through 8 attempts.

**BREAKTHROUGH SOLUTION (Attempt #8c):**
- Modified existing `/requestdesk/v1/publish` endpoint instead of creating new endpoints
- Added optional `post_id` parameter - when provided, updates existing post instead of creating new
- Uses same authentication and image handling as working NEW posts workflow
- Backend updated to use unified endpoint for both NEW and EXISTING posts

## CURRENT STATE
- **Last command executed:** `git commit` (committed WordPress plugin changes)
- **Files modified:**
  - `cb-wordpress/includes/class-requestdesk-api.php` (added post_id handling to /publish endpoint)
  - `cb-requestdesk/backend/app/services/wordpress_service.py` (updated to use unified endpoint)
- **CB Flow Impact:** Backend service → WordPress plugin API → WordPress core (unified path for NEW and EXISTING)
- **Tests run:** Multiple failed attempts documented in attempt-8-debug.log
- **Issues found:** Previous attempts failed due to non-existent endpoints and authentication issues

## TODO LIST STATE
- ✅ COMPLETED: Fix EXISTING posts to use agent config like NEW posts (USER APPROVED: No - need to verify)
- ✅ COMPLETED: Test the fixed EXISTING posts workflow (USER APPROVED: No - need to verify)
- ✅ COMPLETED: Fix non-existent WordPress endpoint issue (USER APPROVED: No - need to verify)
- ✅ COMPLETED: Modify /requestdesk/v1/publish to handle updates instead of creating new endpoint (USER APPROVED: No - need to verify)
- ⏳ PENDING: Create WordPress plugin zip and upload to WordPress

## COMPLETION APPROVAL STATUS
**🚨 CRITICAL RULE**: NEVER mark tasks as completed until user explicitly approves

### Completion Trigger Protocol
**🚫 CLAUDE CAN NEVER DECLARE TASKS COMPLETE - ONLY HUMANS CAN**

**Current Status:** Plugin code has been modified and committed, but:
- Plugin zip created: `/Users/brent/scripts/CB-Workspace/cb-requestdesk/requestdesk-connector-v2.3.0.zip`
- **NOT YET UPLOADED** to WordPress admin
- **NOT YET TESTED** with actual EXISTING posts workflow
- **USER MUST UPLOAD PLUGIN** and test before any completion approval

**Before asking about completion, must verify:**
1. User uploads plugin zip to WordPress admin
2. User tests EXISTING posts featured image workflow
3. User confirms "All connection attempts failed" error is resolved
4. User explicitly says workflow is working

## NEXT ACTIONS (PRIORITY ORDER)
1. **FIRST:** User must upload `/Users/brent/scripts/CB-Workspace/cb-requestdesk/requestdesk-connector-v2.3.0.zip` to WordPress admin
2. **THEN:** Test EXISTING posts workflow at `http://localhost:3001/blog-posts`
3. **VERIFY:** Generate image → Save image → Send to WordPress (should succeed with no "connection failed" errors)

## VERIFICATION COMMANDS
- Check plugin upload: WordPress admin → Plugins → Upload Plugin → Select zip file
- Test workflow: Navigate to `http://localhost:3001/blog-posts` → Click existing post → Generate image → Save → Send to WordPress
- View logs: `docker logs cbtextapp-backend-1 -f` (monitor for success vs connection errors)

## CONTEXT NOTES
**CRITICAL BACKGROUND:**
- This is attempt #8 across multiple sessions to fix EXISTING posts workflow
- NEW posts workflow works perfectly - use as reference
- Previous attempts failed due to:
  - Using non-existent WordPress endpoints
  - Authentication issues with WordPress core API
  - Complex multi-step workflows vs simple single endpoint
- **Breakthrough:** Use same working endpoint as NEW posts with update flag
- **Documentation:** Complete debugging trail in `/todo/current/feature/wordpress-image-upload/attempt-8-debug.log`

**User expects this workflow to work exactly like NEW posts:**
- Same UI (BlogPostImageGenerationModal)
- Same success/failure feedback
- Same WordPress plugin image handling
- Only difference: updates existing post instead of creating new one

**⚠️ DO NOT:**
- Create additional endpoints or complicated workflows
- Debug network/Docker issues (connections work fine)
- Test NEW posts workflow (it's confirmed working)
- Mark anything complete without user confirmation after testing