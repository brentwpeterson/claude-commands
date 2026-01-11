# Resume Instructions for Claude

## IMMEDIATE SETUP
1. **Change directory:** `cd /Users/brent/scripts/CB-Workspace/cb-requestdesk`
2. **Verify branch:** `git checkout feature/github-webhook-integration`
3. **Verify containers:** `docker ps` (expect: backend, frontend, mailhog running)

## SESSION METADATA
**Last Commit:** `6abfccc5 Add system prompt templates for centralized prompt management`
**Branch:** `feature/github-webhook-integration`
**Saved:** 2026-01-07
**Deployment Tags:**
- `matrix-v0.35.0-requestdesk-blog-system-prompts` (cb-requestdesk)
- `main-site-v1.11.0-blog-integration` (astro-sites)

## WHAT WAS COMPLETED THIS SESSION

### 1. System Prompt Templates Feature - DEPLOYED ✅
Added system-wide default prompts visible to all users across all agents.

**Files Modified:**
- `backend/app/models/agent_prompt.py` - Made agent_id/user_id optional, added is_system_template field
- `backend/app/routers/agent_prompts.py` - Query now includes system templates with $or
- `backend/app/migrations/versions/v0_36_3_add_system_prompt_templates.py` - Index + default GEO/AIO/AEO template

**How it works:**
- System templates have `agent_id=null`, `user_id=null`, `is_system_template=true`
- GET `/api/agents/{agent_id}/prompts` returns user prompts + system templates
- Default template: "GEO/AIO/AEO Optimized Blog Post (HTML)" - blog writing prompt

### 2. RequestDesk Blog Integration - DEPLOYED ✅ (from previous session)
- Agent Content Creation → RequestDesk Blog option
- RequestDeskBlogWizard.tsx component
- Public posts API for Astro blog
- `publish_to_requestdesk_blog` field on posts

## DEPLOYMENT STATUS
Both projects deployed to production:
- **cb-requestdesk:** `matrix-v0.35.0-requestdesk-blog-system-prompts`
- **astro-sites:** `main-site-v1.11.0-blog-integration`

Check GitHub Actions for deployment progress:
- https://github.com/brentwpeterson/requestdesk-app/actions
- https://github.com/brentwpeterson/astro-sites/actions

## TODO LIST STATE
- ✅ COMPLETED: RequestDesk Blog integration (USER TESTED)
- ✅ COMPLETED: System prompt templates feature (USER TESTED)
- ✅ COMPLETED: Deployment to production

## NEXT ACTIONS
1. **Monitor deployments:** Check GitHub Actions for completion
2. **Production testing:** Verify system prompts appear in production
3. **Consider:** Run `/claude-complete` to archive the todo after production verification

## CONTEXT NOTES
- Branch is 13 commits ahead of origin (feature branch not pushed after merge)
- Migration v0.36.3 needs to run on production (will run automatically on deploy)
- System template ID in local: `695efd4f96ccd6cfbe45b417`
