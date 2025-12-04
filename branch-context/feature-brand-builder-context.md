# Resume Instructions for Claude - Feature/Brand-Builder

## IMMEDIATE SETUP
1. **Change directory:** `cd /Users/brent/scripts/CB-Workspace/cb-requestdesk`
2. **Verify branch:** `git branch --show-current` (should be: `feature/brand-builder`)
3. **Check Docker:** `docker ps` (expect: cbtextapp-backend-1, cbtextapp-frontend-1, mailhog running)

## SESSION METADATA
**Last Commit:** `43e88251 Add persona_types field to section_types, remove section_templates`
**MCP Entity:** `cb-requestdesk-brand-builder`
**Saved:** 2025-12-03 14:30

## CURRENT TODO FILE
**Path:** `./todo/current/feature/brand-builder/README.md`
**Status:** Refactoring section_templates → persona_types on section_types
**Directory Structure:** ⚠️ Extended (11 files) - has backup/, data files/ beyond standard 7

---

## WHAT YOU WERE WORKING ON
**Session Focus:** Simplifying architecture by moving persona_types to section_types

### Major Accomplishments This Session:
1. **PersonaCleanup Component Fixed:**
   - Fixed PATCH→PUT method mismatch for Apply button
   - Fixed KeyError for missing 'order' field in response
   - Added "Merge Cluster" functionality with modal for combining redundant sections

2. **Persona Types Architecture Refactoring:**
   - Added `persona_types` array field to section_types model
   - Added `prompt_context`, `question_type`, `follow_up_conditions` fields
   - Created migration v0_33_3 to add fields and drop section_templates
   - Removed section_templates from main.py and database.py
   - **Migration ran successfully:** 20 section_types updated with persona_types: ["brand"]
   - **section_templates collection dropped**

## CURRENT STATE
- **Migration Status:** ✅ Complete - persona_types added to all 20 section_types
- **section_templates:** ✅ Dropped from database
- **Files removed from code:** main.py import + router, database.py collection reference

### 🔴 BLOCKING ISSUE - DECISION NEEDED:
**persona_builder.py still references section_templates in 5 places:**
- Lines 126, 241, 356, 461, 532

**The old persona_builder router expects `template_id` to start a session.**

**Options presented to user:**
- **Option A:** Change API to accept `persona_type` ("brand", "client", "competitor") instead
- **Option B:** Keep `template_id` in API but map internally to `persona_type`
- **Option C:** Remove persona_builder router entirely (may not be actively used)

**USER HAS NOT YET DECIDED** - session was saved before receiving answer

---

## OPEN ISSUES (FROM PREVIOUS SESSIONS)

### 🔴 ISSUE 1: Brand Builder Session-Persona Association
**Status:** ROOT CAUSE FOUND, FIX PENDING
**Problem:** Brand Builder sessions missing persona_id field
**Fix Needed:** Add persona_id to CategoryAnswerRequest model + update session creation

### 🔴 ISSUE 2: Drag-and-Drop to Empty Tiers Bug
**Status:** BUG IDENTIFIED, FIX PENDING
**Location:** `frontend/src/components/section-types/PriorityTierManager.tsx`
**Fix Needed:** Add `useDroppable` hook for empty tier containers

### 🟡 ISSUE 3: Website Import Frontend Auth (Production)
**Status:** Backend working, frontend auth not sending token
**Files:** `WebsiteImport.tsx`, `tokenManagement.ts`

---

## TODO LIST STATE
- ✅ COMPLETED: Add persona_type array field to section_types
- ✅ COMPLETED: Run migration to add persona_types field
- 🔄 IN PROGRESS: Remove section_templates usage from codebase (BLOCKED - needs decision on persona_builder.py)
- ⏳ PENDING: Fix session-persona association
- ⏳ PENDING: Fix drag-and-drop to empty tiers

---

## NEXT ACTIONS (PRIORITY ORDER)
1. **FIRST:** Ask user which option they prefer for persona_builder.py refactoring (A, B, or C)
2. **THEN:** Implement the chosen option OR remove the router
3. **THEN:** Delete `/backend/app/routers/section_templates.py` file
4. **THEN:** Delete `/backend/app/models/section_template.py` file
5. **OPTIONAL:** Continue with other pending issues

## VERIFICATION COMMANDS
```bash
# Get token
TOKEN=$(curl -s -X POST "http://localhost:3000/auth/token" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "username=cucumber&password=test1234" | jq -r '.access_token')

# Test section_types API now returns persona_types
curl -s "http://localhost:3000/api/section_types" -H "Authorization: Bearer $TOKEN" | jq '.[0] | {name, persona_types}'

# Test cleanup page
open "http://localhost:3001/personas/6925b7cc59be7b22ee7b541e/cleanup"
```

## CONTEXT NOTES
- Docker containers hot-reload - no rebuild needed for code changes
- Test credentials: `cucumber` / `test1234`
- 20 section types now have `persona_types: ["brand"]` by default
- The `section_templates` router and model files still exist in code but are no longer registered/used
- PersonaCleanup merge modal is working - combines content with headers and deletes source sections
