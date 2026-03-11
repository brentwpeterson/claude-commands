# Resume Instructions for Claude

## SESSION STATUS
**Identity:** Claude-Curie
**Status:** ACTIVE
**Last Saved:** 2026-03-08 08:05
**Last Started:** 2026-03-08 13:00

## IMMEDIATE SETUP
1. **Directory:** `cd /Users/brent/scripts/CB-Workspace/requestdesk-app`
2. **Branch:** `git checkout feature/astro-static-blog-publisher`
3. **Last Commit:** `113d6564 Fix LLM provider UI: test connection with key inheritance, filter chat dropdown, default model selection`
4. **Verify:** `git status`

## WORKSPACES TOUCHED
| Shortcode | What was done |
|-----------|---------------|
| rd | LLM provider fixes: test connection, chat dropdown, default model, brand voice debugging |

## CURRENT TODO
**Path:** `todo/current/feature/astro-static-blog-publisher/`
**Status:** LLM provider fixes in progress, brand voice skill 400 error still open

## WHAT YOU WERE WORKING ON
Fixing LLM provider system issues found during local testing:

1. **Test Connection on child providers** - FIXED. Created new `POST /api/llm/test-provider/{provider_id}` endpoint that resolves API key via core model inheritance. Frontend now calls this instead of trying to send the (empty) API key from the browser.

2. **Chat dropdown defaulting to wrong model** - FIXED. Filtered out core providers and image/embedding providers from `UniversalChatInterface.tsx`. Fixed default model selection to use `default_model_id` field instead of models array (they were out of sync).

3. **Brand Voice skill 400 Bad Request from OpenAI** - IN PROGRESS. The "Verify Brand Voice" skill on posts fails with 400 from `https://api.openai.com/v1/chat/completions`. Added error body logging to `llm_service.py` OpenAI client to capture the actual error. Need to run the skill again to see what OpenAI is rejecting.

## CURRENT STATE
- **Committed:** All UI fixes committed (113d6564)
- **Docker:** Backend and frontend containers running, hot-reloading
- **Tests passed by user:**
  - Test Connection on child Anthropic provider (claude-opus-4-6) - PASS
  - Test Connection on core Anthropic provider - PASS (pre-existing)
  - Test Connection on OpenAI child provider (gpt-5.4) - PASS (via curl)
  - API Key display "Inherited from core provider" - PASS
  - API Key masked on core provider - PASS
  - Chat with Anthropic claude-opus-4-6 - PASS
  - Chat with OpenAI gpt-5.4 (base_url fix) - PASS (via curl, 200 OK)
- **Brand Voice skill** - FAILS with 400 Bad Request from OpenAI

## BUG: Brand Voice Skill 400 Error
- **Symptom:** "Skill failed: Client error '400 Bad Request' for url 'https://api.openai.com/v1/chat/completions'"
- **Code path:** skill_service.py `_call_llm_and_parse()` -> `get_posts_provider()` -> OpenAI client
- **Root cause investigation:**
  - TWO providers have `is_posts_default=True`: the Anthropic child (claude-opus-4-6) AND OpenAI Gpt 5.4
  - `get_posts_provider()` returns the first match, which may be OpenAI
  - The 400 error body was not being logged. Added logging at llm_service.py line 306.
  - Possible causes: invalid model name `gpt-5.4`, or request format issue
  - **Need to re-run the skill to capture the error body now that logging is added**
- **Data issue:** Provider 69a99edd has `default_model_id: claude-opus-4-6` but its models array has `claude-haiku-4-5-20251001`. These are out of sync.

## TODO LIST STATE
- Completed: Test connection fix, chat dropdown filter, default model fix, base_url doubling fix
- In Progress: Brand voice skill 400 error (logging added, needs re-test)
- Pending: Run migrations on production, deploy, set up Amplify for brent.run, test Publish to Astro e2e

## NEXT ACTIONS
1. **FIRST:** Re-run Verify Brand Voice skill on a post to capture the 400 error body from OpenAI logs
2. **THEN:** Fix the 400 error (likely invalid model name or duplicate is_posts_default)
3. **THEN:** Consider whether only ONE provider should have is_posts_default=True
4. **THEN:** Test all skills work end-to-end locally
5. **THEN:** Deploy and run migrations on production

## CONTEXT NOTES
- Pydantic v1 in this project: use `.dict()` not `.model_dump()`
- The `self.providers` dict in LLMService is keyed by provider TYPE (e.g., OPENAI). Multiple providers of same type OVERWRITE each other. The last one loaded wins. This is a design limitation.
- Frontend uses `UniversalChatInterface.tsx` for the chat page (NOT `ChatInterface.tsx`)
- The `LLMProviderResponse` returns `id` (not `_id`) - fixed this in ModelsShow.tsx
- Core providers have `is_core_model=True`, child providers have `core_model_id` pointing to their parent
- `resolve_provider_api_key()` handles the inheritance: checks own api_key first, then looks up core parent
