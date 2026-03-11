# Resume Instructions for Claude

> **WARNING:** There are TWO Hemingway context files. This one is for RD (chat/agent UX).
> The other is astro-2026-03-05-hemingway-context.md (Amplify migration).
> When resuming THIS file, use a NEW Claude name (not Hemingway) to avoid collision.

## SESSION STATUS
**Identity:** Claude-Hemingway
**Status:** ACTIVE
**Last Saved:** 2026-03-04 15:55
**Last Started:** 2026-03-04 16:00

## IMMEDIATE SETUP
1. **Directory:** `cd /Users/brent/scripts/CB-Workspace/requestdesk-app`
2. **Branch:** `git checkout master`
3. **Last Commit:** `9a6cb683 feat: Wire up core/child API key inheritance for LLM providers`
4. **Verify:** `git status`

## WORKSPACES TOUCHED
| Shortcode | What was done |
|-----------|---------------|
| rd | Core/child API key inheritance for LLM providers |

## WHAT YOU WERE WORKING ON
Wiring up core/child API key inheritance so child LLM providers pull their API key from a parent core model. This enables ONE API key per vendor stored on the core model, with children referencing it.

### What was implemented:
1. **`resolve_provider_api_key()` helper** in `llm_service.py` - Resolves child->parent API keys via `core_model_id`
2. **`get_provider_from_db()` in `llm.py`** - All 3 code paths (specific, default, fallback) now resolve through parent
3. **`_get_api_key()` in `llm_service.py`** - Resolves through parent when `find_one` returns a child doc
4. **Removed hardcoded model IDs** from 6 services - Now use `model=None` so the Anthropic client falls back to `self.config.default_model_id` from the DB provider config
5. **Frontend: Models grid** - Shows purple "Core" badge for core models
6. **Frontend: Edit form** - Hides Default Model, Fetch Models, pricing table, and checkboxes for core models. Shows only Display Name, API Type, Endpoint URL, API Key + purple Core Model banner.

### Violations logged this session:
- #133: HARDCODED_MODEL_IDS_IN_SERVICES (6 files with hardcoded claude-3-5-haiku-latest)
- #134: HARDCODED_VALUE_AS_FIX (replaced one hardcoded string with another instead of reading from DB)

### Key discovery:
- `AnthropicClient.generate_completion()` line 81: `model = request.model or self.config.default_model_id` - Already falls back to DB provider config when model is None
- So the fix for hardcoded models was simply: stop passing `model=` and let the client use the DB default

## CURRENT STATE
- **Files modified:** 11 files committed to master
- **Tests run:** Manual - API returns is_core_model in response, Core badge shows on grid
- **Issues found:**
  - User hasn't confirmed Edit form hides fields correctly for core models (needs hard refresh)
  - `testApiKey()` in ModelsEdit.tsx still has hardcoded model names for Anthropic/Gemini test calls (lines 340, 366) - frontend-side hardcoding, not yet fixed

## PRIOR SESSION PENDING ITEMS (from earlier context)
- Test model dropdown in Create wizard (step 4 for text generation)
- Test SEO/AEO skill run on a post
- Verify production deployment (matrix-v0.49.5-llm-test-fix)
- Update production Anthropic default_model_id to claude-haiku-4-5

## TODO LIST STATE
- Completed: resolve_provider_api_key helper, wire into llm.py, wire into llm_service.py, remove hardcoded models, add Core badge to grid, hide fields on core model edit
- Pending: User testing of all changes, test creating a child provider end-to-end

## NEXT ACTIONS
1. **FIRST:** User hard-refresh on Edit Model Provider page to verify core model fields are hidden
2. **THEN:** Test creating a child provider via API and verify it inherits the parent's API key
3. **THEN:** Fix hardcoded model names in `testApiKey()` function in ModelsEdit.tsx (lines 340, 366)
4. **VERIFY:** Make an LLM completion call through a child provider to confirm key resolution works

## CONTEXT NOTES
- The existing 4 providers (OpenAI, Groq, Gemini, Anthropic) are already marked `is_core_model: True` by migration v0_30_5
- `core_model_management.py` has CRUD endpoints for creating core/child models via API
- No frontend UI exists yet for creating child models (only API endpoints)
- The `testApiKey()` function in ModelsEdit.tsx makes direct API calls from the browser with hardcoded models (claude-3-haiku-20240307, gemini-1.5-flash) - these should use the backend test endpoint instead
- User frustrated about hardcoded values (now 9 violations). Always read from DB, never hardcode.
