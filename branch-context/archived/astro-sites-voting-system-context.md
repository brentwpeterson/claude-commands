# Resume Instructions for Claude

## IMMEDIATE SETUP
1. **Change directory:** `cd /Users/brent/scripts/CB-Workspace/astro-sites`
2. **Verify branch:** `git branch --show-current` (should be: master)
3. **Check plan file:** Read `/Users/brent/.claude/plans/effervescent-jingling-rabin.md`

## SESSION METADATA
**Last Commit:** `888125a Add Gartner Commerce integrations and structured data for LLM discovery`
**Project:** astro-sites (requestdesk.ai)
**Saved:** 2026-01-03

## WHAT YOU WERE WORKING ON

**Integration Voting System** - Adding a voting feature so users can upvote which integrations they want built.

### Design Decisions Made (User Approved):
- **Authentication:** Authenticated only (require RequestDesk login)
- **Scope:** Only non-live integrations (radar, planned, in-progress)
- **Display:** Real-time client-side vote counts via API

### Plan File Created:
`/Users/brent/.claude/plans/effervescent-jingling-rabin.md`

Contains full implementation plan for:
1. Backend (cb-requestdesk): Migration, model, router, service
2. Frontend (astro-sites): VoteButton component, API integration

## CURRENT STATE
- Plan mode was active when user requested save
- User had answered all clarifying questions
- Implementation plan was complete and ready for approval
- No code changes made yet (planning phase only)

## COMPLETED THIS SESSION

1. **Deployed structured data update** (`main-site-v1.10.6-structured-data-schema`):
   - IntegrationStructuredData component (FAQPage, SoftwareApplication, Organization)
   - 10 new Gartner Commerce integrations
   - Custom FAQs for commercetools, BigCommerce, Adobe Commerce
   - Restored custom landing pages (Shopify, WordPress, Magento)

2. **Explored codebase for voting system:**
   - Backend patterns (routers, models, migrations, services)
   - Frontend patterns (client-side API calls, environment detection)

## NEXT ACTIONS (PRIORITY ORDER)

1. **Read the plan file:**
   ```bash
   cat /Users/brent/.claude/plans/effervescent-jingling-rabin.md
   ```

2. **Ask user to approve the plan** before implementing

3. **If approved, implement in order:**
   - Backend first (cb-requestdesk): migration → model → router → main.py
   - Frontend second (astro-sites): VoteButton component → [slug].astro

## FILES TO CREATE (From Plan)

### Backend (cb-requestdesk)
- `backend/app/migrations/versions/v0_31_0_create_integration_votes.py`
- `backend/app/models/integration_vote.py`
- `backend/app/routers/integration_votes.py`
- Modify: `backend/app/main.py`

### Frontend (astro-sites)
- `requestdesk-ai/src/components/VoteButton.astro`
- Modify: `requestdesk-ai/src/pages/integrations/[slug].astro`

## API ENDPOINTS (Planned)
- `POST /api/integration-votes` - Cast a vote (auth required)
- `DELETE /api/integration-votes/{slug}` - Remove vote (auth required)
- `GET /api/integration-votes/counts` - Get all counts (public)
- `GET /api/integration-votes/counts/{slug}` - Get single count (public)
- `GET /api/integration-votes/my-votes` - User's votes (auth required)

## CONTEXT NOTES
- JWT stored in localStorage after login
- One vote per user per integration (unique index enforces this)
- Environment detection: localhost:3000 for dev, app.requestdesk.ai for prod
- Non-live = radar, planned, in-progress statuses only
