# Resume Instructions for Claude

## IMMEDIATE SETUP
1. **Directory:** `cd /Users/brent/scripts/CB-Workspace/requestdesk-app`
2. **Branch:** `git checkout feature/skills-mvp`
3. **Last Commit:** `a426c108 Skills MVP: frontend UI + backend JSON parsing fix`
4. **Verify:** `git status` (should be clean)

## SESSION METADATA
**Backlog Ticket:** 697faa65 (full: 697faa65085b688faeda92f5) - 8pts, in_progress
**Identity:** Claude-Armstrong
**Saved:** 2026-02-01

## WHAT WE WERE WORKING ON

Building the **Skills MVP** for RequestDesk. Skills are reusable content analysis tools that run against posts, produce reports with findings/suggestions, and can apply changes by creating new draft versions.

### Three Initial Skills:
1. **Verify Brand Voice** - Checks content against client's brand persona voice guidelines
2. **Verify Terms** - Checks content against content terms (avoid/use/conditional)
3. **AI Checker** - Runs AI detection analysis using a seeded system prompt

## CURRENT STATE - BACKEND TESTED, FRONTEND BUILT BUT UNTESTED

### Backend (TESTED - ALL PASSING)
All 9 API endpoints tested and working via curl:
- `GET/POST /api/skills` - list/create skills
- `GET/PUT/DELETE /api/skills/{id}` - get/update/delete
- `POST /api/skills/{id}/run` - run skill (produces report)
- `GET /api/skill-reports` - list reports (filterable by post_id, skill_id)
- `GET /api/skill-reports/{id}` - get report
- `POST /api/skill-reports/{id}/apply` - apply suggestions (creates new post version)

Test results:
- Terms skill: score 100, 1 finding (missing recommended term)
- Brand Voice skill: score 45, 4 findings with suggestions
- AI Checker skill: score 45, 5 findings
- Apply suggestions: created post version 2
- Re-apply guard: correctly blocks with "already applied"
- Delete: soft-delete works (204, removed from list)

**Fix applied this session:** Added fallback JSON extraction in `_call_llm_and_parse` (skill_service.py:661-670) to handle LLM responses with preamble text before JSON object.

### Frontend (BUILT - NEEDS USER TESTING)
7 new files created in `frontend/src/components/skills/`:
- `types.ts` - TypeScript interfaces
- `api.ts` - API helper functions (getAuthToken pattern)
- `SkillsList.tsx` - Skills list page with DataTable
- `SkillFormDialog.tsx` - Create/edit modal (Tailwind, no MUI)
- `ReportViewer.tsx` - Report viewer with accept/reject/apply
- `SkillRunner.tsx` - Post sidebar widget (skill selector + run button)
- `index.ts` - Barrel exports

3 existing files modified:
- `routes/index.tsx` - Added Skills resource at /skills
- `AccordionNavigation.tsx` - Added Skills nav item under Content (SparklesIcon)
- `PostsShow.tsx` - Added SkillRunner to post detail sidebar

Frontend compiled with no new errors (webpack compiled successfully).

### Test Data Created (in DB, cucumber user):
- 2 active skills: "Verify Terms", "Verify Brand Voice"
- 1 deleted skill: "AI Checker" (soft-deleted)
- 4 skill reports against post "Big BLog Post" (6973b70df95d3f991e6aaf90)
- Post "Big BLog Post" was updated to version 2 via apply suggestions

## FILES CREATED/MODIFIED THIS SESSION

### New Files:
- `frontend/src/components/skills/types.ts`
- `frontend/src/components/skills/api.ts`
- `frontend/src/components/skills/SkillsList.tsx`
- `frontend/src/components/skills/SkillFormDialog.tsx`
- `frontend/src/components/skills/ReportViewer.tsx`
- `frontend/src/components/skills/SkillRunner.tsx`
- `frontend/src/components/skills/index.ts`

### Modified Files:
- `backend/app/services/skill_service.py` (JSON parsing fallback fix)
- `frontend/src/routes/index.tsx` (Skills resource)
- `frontend/src/components/layout/AccordionNavigation.tsx` (Skills nav item)
- `frontend/src/components/posts/PostsShow.tsx` (SkillRunner widget)

## API ENDPOINTS

| Method | Path | Purpose |
|--------|------|---------|
| GET | `/api/skills` | List skills (user-scoped) |
| POST | `/api/skills` | Create skill |
| GET | `/api/skills/{id}` | Get skill |
| PUT | `/api/skills/{id}` | Update skill |
| DELETE | `/api/skills/{id}` | Delete skill (soft) |
| POST | `/api/skills/{id}/run` | Run skill against a post |
| GET | `/api/skill-reports` | List reports |
| GET | `/api/skill-reports/{id}` | Get report |
| POST | `/api/skill-reports/{id}/apply` | Apply suggestions |

## NEXT ACTIONS (PRIORITY ORDER)

1. **User tests frontend at http://localhost:3001/skills**
   - Create a skill via the UI
   - Verify the list shows correctly
   - Test edit and delete
2. **User tests SkillRunner on a post detail page**
   - Go to a post (e.g., http://localhost:3001/posts/6973b70df95d3f991e6aaf90/show)
   - Should see "Run Skills" in sidebar
   - Select skill, click Run, view report
   - Test accept/reject findings and apply
3. **Polish if needed**
   - Error handling edge cases
   - Loading states
   - Better report visualization

## TODO FILE
**Path:** `todo/current/feature/skills-mvp/`
**Files:** README.md, success-criteria.md, notes.md (3 files, lightweight structure)

## CONTEXT NOTES
- Auth works: cucumber/test1234 (was reported as failing in previous session but works fine)
- The `cucumber` user ID is `680001e183b4ee3baf84b146`
- Content terms for cucumber user only include 1 "use" term ("What caught my attention"). The "avoid" terms belong to a different user_id (`685b364ec902ddb30cc9a104`).
- Personas endpoint is at `/api/personas` (not `/api/brand-personas`)
- Posts use `post_title` and `post_content` fields (not `title`/`content`)
- Frontend uses DataTable component from `ui/DataTable/DataTable.tsx` with TableColumn/TableAction interfaces
- SkillRunner component hides itself if no skills are configured (returns null)
- AI detection prompt is seeded in agent_prompts as system template with tags ["skill", "ai-check", "system"]
