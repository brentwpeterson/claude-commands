# Resume Instructions for Claude

## SESSION STATUS
**Identity:** Claude-Voltaire
**Status:** ACTIVE
**Last Saved:** 2026-03-09 00:15
**Resumed:** 2026-03-09
**Last Started:** 2026-03-08 13:00

## IMMEDIATE SETUP
1. **Directory:** `cd /Users/brent/scripts/CB-Workspace/requestdesk-app`
2. **Branch:** `git checkout feature/astro-static-blog-publisher`
3. **Last Commit:** `d321cfe0 Fix LLM provider routing: use system default for skills, inherit api_version from core`
4. **Verify:** `git status`

## WORKSPACES TOUCHED
| Shortcode | What was done |
|-----------|---------------|
| rd | LLM provider fixes: skill routing, api_version inheritance, max_completion_tokens, deployed to production |

## CURRENT TODO
**Path:** `todo/current/feature/astro-static-blog-publisher/`
**Status:** LLM provider fixes deployed, awaiting production testing

## WHAT YOU WERE WORKING ON
Fixed LLM provider system issues found during local testing. Three main fixes deployed via `matrix-v0.50.1-llm-provider-fixes`:

1. **get_posts_provider() routing** - Changed to use system default provider (is_default=True) instead of separate is_posts_default flag. This matches how chat and other pages select their provider. Previously two providers had is_posts_default=True causing the skill to route to OpenAI instead of Anthropic.

2. **api_version inheritance for child providers** - Child Anthropic providers now inherit api_version from their core parent, same pattern as API key inheritance. Without this, the child provider had api_version=None, causing "Anthropic provider requires api_version" error and failing to initialize.

3. **max_completion_tokens for OpenAI** - OpenAI client now uses max_completion_tokens instead of max_tokens (required by newer models like gpt-5.4). This was the original 400 Bad Request error body: "Unsupported parameter: 'max_tokens' is not supported with this model."

## CURRENT STATE
- **Deployed:** `matrix-v0.50.1-llm-provider-fixes` pushed to production
- **Production testing needed:** Run Brand Voice skill on a post to confirm it works
- **All local tests passed prior sessions:** Test Connection, Chat, API key display
- **Data issues still exist but may not block:**
  - Provider 69a99edd has mismatched default_model_id (claude-opus-4-6) vs models array (claude-haiku-4-5-20251001)
  - Two providers still have is_posts_default=True (but code no longer uses that flag)

## TODO LIST STATE
- Completed: Test connection fix, chat dropdown filter, default model fix, base_url doubling fix, skill routing fix, api_version inheritance, max_completion_tokens fix, deployment
- In Progress: Production testing of Brand Voice skill
- Pending: Fix provider data mismatch (default_model_id vs models array), set up Amplify for brent.run, test Publish to Astro e2e

## NEXT ACTIONS
1. **FIRST:** Test Brand Voice skill on production (once deploy finishes ~25 min from 2026-03-08 18:45 UTC)
2. **THEN:** Fix provider 69a99edd data mismatch if needed
3. **THEN:** Return to original branch goal: Astro static blog publisher feature

## CONTEXT NOTES
- Pydantic v1 in this project: use `.dict()` not `.model_dump()`
- The `self.providers` dict in LLMService is keyed by provider TYPE. Multiple providers of same type OVERWRITE each other. The last one loaded wins.
- Frontend uses `UniversalChatInterface.tsx` for the chat page (NOT `ChatInterface.tsx`)
- Core providers have `is_core_model=True`, child providers have `core_model_id` pointing to their parent
- `resolve_provider_api_key()` handles API key inheritance: checks own api_key first, then looks up core parent
- Now `api_version` also inherits from core parent using same pattern
