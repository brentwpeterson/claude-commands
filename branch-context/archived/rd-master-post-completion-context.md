# Resume Instructions for Claude

## IMMEDIATE SETUP
1. **Change directory:** `cd /Users/brent/scripts/CB-Workspace/requestdesk-app`
2. **Verify branch:** `git branch --show-current` (should be: master)
3. **Check services:** Backend on :3000, Frontend on :3001 (Docker hot-reload)

## SESSION METADATA
**Last Commit:** `a7979ba4` Add WordPress parity: post scheduling, TanStack posts list
**Branch:** master (feature branch completed & deleted)
**Saved:** 2026-01-13

## WHAT WAS COMPLETED THIS SESSION

### Branch Completed: feature/shopify-seo-aeo-evaluation
Via `/claude-complete` - fully archived and branch deleted.

### Features Delivered:

**1. LLM Discoverability Feature (Alpha)**
- SEO, AEO, AIO scoring for Shopify content
- Content type breakdown (products, collections, blog articles)
- Alpha banner with "View Roadmap" link to requestdesk.ai/roadmap/ecommerce/
- Backend API with Claude Haiku evaluation

**2. Backlog System Enhancements (v0.37.6 Migration)**
- Parent-child relationships: `parent_id`, `is_parent`, `is_child`
- Time tracking: `time_spent_minutes`, `started_at`, `completed_at`
- Organization: `tags[]`, `blocked_by[]`, `sprint`, `assignee_id`
- External integration: `external_id`, `reference_url`
- 6 new database indexes created
- Router serialization fix deployed & verified

**3. Commands Updated**
- `/add-backlog` - Updated with all new fields and smart tagging
- `/sprint` - NEW command for sprint management
- `backlog-api-access.md` - Complete field reference

### Deployments Verified:
- `matrix-v0.35.0-llm-discoverability-backlog` - Main feature + migration
- `matrix-v0.35.0-backlog-router-fix` - Router serialization fix (tested working)

### Archived To:
`/todo/completed/feature/shopify-seo-aeo-evaluation-completed-20260113/`
- 12 files including context files
- README updated with completion summary
- Progress.log updated with implementation history

## CURRENT STATE
- Branch: master (clean, up to date)
- No uncommitted changes
- All deployments verified working
- Backlog API tested: tags, sprint, external_id all working

## KEY FILES FROM THIS SESSION
**Backend:**
- `backend/app/models/backlog_item.py` - All new fields
- `backend/app/migrations/versions/v0_37_6_add_backlog_enhancements.py`
- `backend/app/routers/public/backlog.py` - Serialization fix
- `backend/app/services/llm_discoverability_service.py` - New service

**Frontend:**
- `frontend/src/components/integrations/ShopifySEOEvaluationTab.tsx` - Alpha banner

**Commands:**
- `.claude-local/commands/add-backlog.md` - Updated
- `.claude-local/commands/sprint.md` - NEW
- `.claude/local/backlog-api-access.md` - Updated

## BACKLOG API TEST COMMAND
```bash
AGENT_KEY="MNRcaklW3XF7UpKX4VrxPV7wo2L7xsWg"
curl -s -X PATCH "https://app.requestdesk.ai/api/backlog/69606aea857e4c7f23d95d2b" \
  -H "Authorization: Bearer ${AGENT_KEY}" \
  -H "Content-Type: application/json" \
  -d '{"tags": ["test"], "sprint": "Q1-2026"}' | jq '.tags, .sprint'
```

## NEXT ACTIONS
1. Start new feature work with `/create-branch`
2. Or check backlog: `curl -s "https://app.requestdesk.ai/api/backlog" -H "Authorization: Bearer MNRcaklW3XF7UpKX4VrxPV7wo2L7xsWg" | jq '.total'`
3. Try new `/sprint` command to view sprint items

## CONTEXT NOTES
- Backlog has 107+ items in production
- LLM Discoverability uses Claude Haiku for evaluation
- Alpha banner links to https://requestdesk.ai/roadmap/ecommerce/
