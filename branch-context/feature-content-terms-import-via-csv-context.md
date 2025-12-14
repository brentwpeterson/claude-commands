# Resume Instructions for Claude

## IMMEDIATE SETUP
1. **Change directory:** `cd /Users/brent/scripts/CB-Workspace/cb-requestdesk`
2. **Verify branch:** `git checkout feature/content-terms-import-via-csv`
3. **Check processes:** `docker ps` (expect: cbtextapp-backend-1, cbtextapp-frontend-1)

## SESSION METADATA
**Last Commit:** `70bf2bf8 Add CSV import endpoint for content terms`
**Branch:** feature/content-terms-import-via-csv
**Saved:** 2025-12-14

## CURRENT TODO FILE
**Path:** file:/Users/brent/scripts/CB-Workspace/cb-requestdesk/todo/current/feature/content-terms-import-via-csv/README.md
**Status:** Backend endpoint created, needs testing and frontend UI
**Directory Structure:** ✅ Complete (7/7 files)

## WHAT YOU WERE WORKING ON
Building CSV import feature for content terms (terms to avoid). The backend endpoint is complete and ready to test.

**Feature Purpose:** Allow admins to bulk import terms via CSV file upload instead of entering one by one.

## CURRENT STATE
- **Backend endpoint created:** POST /api/content-terms/admin/import-csv
- **Endpoint features:**
  - Accepts CSV file upload (multipart/form-data)
  - Required column: `term`
  - Optional columns: `context`, `tags`
  - Duplicate detection (case-insensitive)
  - Auto-tags as "word" or "phrase" based on spaces
  - Attributes to importing user (submitted_by field)
  - Returns: {imported, skipped, errors, message}
- **File:** backend/app/routers/content_terms.py (lines 1221-1348)

## TODO LIST STATE
- 🔄 IN PROGRESS: Create backend CSV import endpoint (CODE DONE - needs testing)
- ⏳ PENDING: Add CSV parsing with validation (included in endpoint)
- ⏳ PENDING: Create frontend Import CSV button and modal
- ⏳ PENDING: Test import with sample CSV files

## NEXT ACTIONS (PRIORITY ORDER)
1. **FIRST:** Test the backend endpoint locally:
   ```bash
   # Create test CSV
   echo 'term,context,tags
   testword1,Test word,word,test
   test phrase one,Test phrase,phrase,test' > /tmp/test-terms.csv

   # Get token and test
   TOKEN=$(curl -s -X POST "http://localhost:3000/auth/token" \
     -H "Content-Type: application/x-www-form-urlencoded" \
     -d "username=cucumber&password=test1234" | jq -r '.access_token')

   curl -X POST "http://localhost:3000/api/content-terms/admin/import-csv" \
     -H "Authorization: Bearer $TOKEN" \
     -F "file=@/tmp/test-terms.csv"
   ```

2. **THEN:** Create frontend UI (Import CSV button + modal)
   - Add to TermsModerationInterface.tsx
   - File upload input
   - Show CSV format instructions
   - Display import results

3. **VERIFY:** Check stats endpoint shows new terms after import

## DEPLOYMENTS PENDING
- `backend-v0.33.3-unified-terms-dashboard` - Shows all terms (system + user) in dashboard
- `backend-v0.33.3-global-terms-migration` - Bulk import of 139 AI terms

## CONTEXT NOTES
- VERSION file updated to 0.33.7
- Earlier this session: completed email-otp-term-submission feature branch
- Created migration v0.33.6 (bulk import 139 terms) and v0.33.7 (attribution fix)
- Updated moderation dashboard to show ALL terms (removed scope filter)
