# Resume Instructions for Claude

## IMMEDIATE SETUP
1. **Change directory:** `cd /Users/brent/scripts/CB-Workspace/cb-requestdesk`
2. **Verify git status:** `git status` (expect: clean working tree)
3. **Check processes:** `docker ps` (expect: cbtextapp-backend-1, cbtextapp-frontend-1 running)
4. **Verify branch:** `git branch --show-current` (should be: feature/brand-builder)

## CURRENT TODO FILE
**Path:** file:todo/current/feature/brand-builder/README.md
**Status:** Working on CSV export debugging - deployed debug version, testing needed
**Directory Structure:** ⚠️ Incomplete (8 core files + extras: backup/, data files/, README.md.bak)
**Architecture Map:** CB internal project - ✅ Complete architecture documentation

## WHAT YOU WERE WORKING ON
**🐛 CSV Export Debugging:** Brand Builder CSV export finds 20 sections + 20 section_types successfully but generates empty CSV files (0 rows). Added comprehensive debug logging to identify the exact failure point in the CSV generation loop.

**ISSUE CONTEXT:**
- CSV export endpoint: `/persona-builder/csv/export/{persona_id}`
- Problem: Data retrieval successful, CSV generation fails
- Evidence: Backend logs show "Found 20 sections" and "Found 20 section_types"
- Result: Empty CSV file downloaded despite data being found
- Debug approach: Added detailed logging throughout CSV generation process

## CURRENT STATE
- **Last command executed:** `git push origin matrix-v0.33.0-csv-export-debug` (deployment tag)
- **Files modified:**
  - `backend/app/routers/persona_builder.py` - Added comprehensive CSV debug logging (lines 1517-1567)
  - `todo/current/feature/brand-builder/debug.log` - Updated with Attempt #2 details
  - Minor frontend persona display improvements
- **CB Flow Impact:** Router layer (persona_builder.py) → CSV export endpoint logging enhanced
- **Tests run:** Deployment successful, production debug version live
- **Issues found:** CSV export bug confirmed - needs debug log analysis

## TODO LIST STATE
**🚨 CRITICAL RULE**: NEVER mark tasks as completed until user explicitly approves

- ✅ COMPLETED: Commit CSV export debug changes before deployment (USER APPROVED: Yes)
- ✅ COMPLETED: Deploy CSV export debug version to production (USER APPROVED: Yes)
- 🔄 IN PROGRESS: Test CSV export with debug logging to identify failure point
- ⏳ PENDING: Fix identified CSV export issue

## COMPLETION APPROVAL STATUS

### Current Task Acceptance Criteria
**Test CSV export with debug logging to identify failure point:**
- [ ] Download CSV export from production Brand Builder
- [ ] Analyze backend debug logs for CSV generation process
- [ ] Identify exact point where CSV generation fails
- [ ] Document specific failure cause (section processing, lookup, row creation, or writing)

**BEFORE asking about completion, Claude MUST:**
1. Verify each criteria point is met
2. **NEVER DECLARE COMPLETION - ASK FOR USER APPROVAL**
3. **ALWAYS ASK**: "Based on the acceptance criteria, does this appear ready for you to mark as complete?"
4. **WAIT FOR EXPLICIT CONFIRMATION**: User must say "yes", "complete", "done", or "approved"

## NEXT ACTIONS (PRIORITY ORDER)
1. **FIRST:** Test CSV export in production and check debug logs
   - Access production Brand Builder
   - Download persona CSV export
   - Check backend logs for detailed debug output from new logging
2. **THEN:** Analyze debug output to identify exact failure point
   - Look for: "Export debug: Starting CSV generation loop"
   - Track: Section processing, section_type lookups, CSV row creation
   - Identify: Where the process breaks down
3. **VERIFY:** Confirm specific root cause before proceeding to fix

## VERIFICATION COMMANDS
- Test CSV export: Access production Brand Builder → Export persona as CSV
- View debug logs: Check backend container logs during export attempt
- Check deployment: `curl -H "Authorization: Bearer $TOKEN" "https://app.requestdesk.ai/api/health"`

## DEPLOYMENT STATUS
**✅ DEPLOYED:** `matrix-v0.33.0-csv-export-debug`
- **Deployment Method:** Matrix deployment (~25 minutes)
- **GitHub Actions:** [deployment completed successfully]
- **Version:** 0.33.0 (unchanged - debug version only)
- **Debug Features Live:** Comprehensive CSV export logging now active in production

## DEBUG LOGGING DETAILS
**Added to backend/app/routers/persona_builder.py (lines 1517-1567):**
- Loop start tracking with section count
- Individual section processing (ID, section_type_id, lookup success)
- Section_type lookup failures with available keys diagnostic
- CSV row creation and content logging
- CSV buffer writing process tracking
- Final row count verification

**Expected Debug Output Pattern:**
```
Export debug: Starting CSV generation loop with X sections
Export debug: Processing section 1/X, ID: [section_id]
Export debug: Section 1 section_type_id: [type_id]
Export debug: Section 1 found section_type: true/false
Export debug: Section 1 created CSV row: {row_content}
Export debug: Section 1 added to csv_data, total rows: 1
...
Export debug: After processing loop, csv_data has X rows
Export debug: Writing X rows to CSV buffer
```

## CONTEXT NOTES
- **Debug Attempt #2** logged in debug.log with systematic approach
- **Production testing required** - debug logs will reveal exact CSV failure point
- **Issue is NOT data retrieval** - sections and section_types are found successfully
- **Focus on CSV generation loop** - something in the processing/writing breaks down
- **Once root cause identified** - can apply targeted fix to resolve empty CSV issue

## CRITICAL DEBUG AREAS TO CHECK
1. **Section_type lookup dictionary** - Are ObjectId conversions working properly?
2. **CSV row creation** - Are all required fields being populated?
3. **CSV buffer writing** - Is the writing process completing successfully?
4. **Data validation** - Are there validation failures preventing row addition?