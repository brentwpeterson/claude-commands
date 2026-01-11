# Resume Instructions for Claude

## IMMEDIATE SETUP
1. **Change directory:** `cd /Users/brent/scripts/CB-Workspace/cb-requestdesk`
2. **Verify git status:** `git status` (expect: clean working tree)
3. **Check processes:** `docker ps` (expect: backend, frontend, redis, mailhog containers running)
4. **Verify branch:** `git branch --show-current` (should be: feature/brand-builder)

## CURRENT TODO FILE
**Path:** file:/Users/brent/scripts/CB-Workspace/cb-requestdesk/todo/current/feature/brand-builder/README.md
**Status:** Working on CSV export debugging - Attempt #1 ready
**Directory Structure:** ⚠️ Extended (9/7 files) - includes backup and data files folders
**Architecture Map:** CB internal project - debugging phase

## WHAT YOU WERE WORKING ON
**CSV Export Bug**: Persona export function finds 20 sections and 20 section_types but generates empty CSV file. User can see 20 sections in web UI at `http://localhost:3001/personas/6925b7cc59be7b22ee7b541e/show` but export downloads empty CSV with only headers.

**Root Cause Identified**: CSV generation loop bug - data exists but not being processed into CSV rows.

## CURRENT STATE
- **Last command executed:** Added debug logging to persona_builder.py export function
- **Files modified:**
  - `backend/app/routers/persona_builder.py` (added debug logging to CSV generation)
  - `todo/current/feature/brand-builder/debug.log` (structured debugging session started)
- **CB Flow Impact:** Export endpoint → section lookup → CSV generation (broken here)
- **Tests run:** Export logs show "Found 20 sections" and "Found 20 section_types"
- **Issues found:** CSV generation loop not creating rows despite having all required data

## TODO LIST STATE
- 🔄 IN PROGRESS: Fix CSV generation - has 20 sections and 20 section_types but creates empty CSV

## COMPLETION APPROVAL STATUS
**🚨 CRITICAL RULE**: NEVER mark tasks as completed until user explicitly approves

### Completion Trigger Protocol
**🚫 CLAUDE CAN NEVER DECLARE TASKS COMPLETE - ONLY HUMANS CAN**

**Completion Requirements:**
- Export must generate CSV with 20 rows (one per section)
- CSV must be importable to create new persona
- User must test export/import roundtrip functionality
- User must explicitly say "this is done" or "approved"

## NEXT ACTIONS (PRIORITY ORDER)
1. **FIRST:** Add debug logging inside CSV generation loop in persona_builder.py (around line 1517)
2. **THEN:** Restart backend container: `docker restart cbtextapp-backend-1`
3. **VERIFY:** Test export again and check logs: `docker logs cbtextapp-backend-1 | grep "CSV debug"`

## DEBUG SESSION STATUS
**Current Attempt:** #1 | 2025-11-25 19:47 | CSV export loop debug | PENDING
**Debug Log:** `todo/current/feature/brand-builder/debug.log`
**Hypothesis:** Bug in CSV generation loop after section_types lookup
**Evidence:** Export finds 20 sections + 20 section_types but CSV is empty

## VERIFICATION COMMANDS
- Check feature: Visit `http://localhost:3001/personas/6925b7cc59be7b22ee7b541e/show` and click export
- Test endpoint: Export should generate CSV with 20 data rows
- View logs: `docker logs cbtextapp-backend-1 | grep "Export debug"`

## CONTEXT NOTES
- User has been very patient with this debugging session
- Export worked before, something broke in the CSV generation logic
- All the data exists (confirmed by web UI showing 20 sections)
- Focus on CSV generation loop - that's where the 20 sections are getting lost
- DO NOT suggest importing data or complex workarounds - fix the export bug