# Resume Instructions for Claude

## IMMEDIATE SETUP
1. **Change directory:** `cd /Users/brent/scripts/CB-Workspace/cb-requestdesk`
2. **Verify branch:** `git branch --show-current` (should be: feature/content-terms-import-via-csv)
3. **Check docker:** `docker ps` (expect: backend + frontend containers)
4. **Verify git status:** `git status` (should be clean)

## SESSION METADATA
**Last Commit:** `1cd4ee2b Update VERSION to 0.33.8`
**Deployed Tag:** `app-v0.33.8-astro-proxy`
**MCP Entity:** `cb-requestdesk-content-terms-csv`
**Saved:** 2025-12-15

## CURRENT TODO FILE
**Path:** file:/Users/brent/scripts/CB-Workspace/cb-requestdesk/todo/current/feature/content-terms-import-via-csv/README.md
**Status:** Feature complete - Generic Astro Proxy endpoint deployed
**Directory Structure:** 9 files (7 standard + 2 extra)

## WHAT WAS COMPLETED THIS SESSION

### Generic Astro Proxy Endpoint - DEPLOYED TO PRODUCTION
Created `/api/astro-proxy/{resource}` endpoint that allows any Astro site to access agent-scoped data:

**New File:** `backend/app/routers/public/astro_proxy.py`

**Features:**
- Agent API key authentication via `Authorization: Bearer <key>` header
- 500 req/min rate limit per agent (vs 60 for public endpoints)
- Agent context extraction for company/user-scoped data access

**Supported Resources:**
| Resource | Description | Params |
|----------|-------------|--------|
| `content-terms` | Content terms for agent's company | `limit`, `page`, `term_type`, `tags` |
| `knowledge-base` | RAG query against agent's collections | `query`, `max_results` |
| `blog-posts` | Blog posts for agent's company | `limit`, `page`, `status` |
| `personas` | Personas assigned to the agent | - |

**Deployment:**
- Tag: `app-v0.33.8-astro-proxy`
- Version: 0.33.8
- Status: Live in production

**Test Command:**
```bash
curl -s "https://app.requestdesk.ai/api/astro-proxy/content-terms?limit=3" \
  -H "Authorization: Bearer ZNgUN47QKeykN8voMmRbuyRT1G3edDxo" | jq '.'
```

**Info Endpoint:**
```bash
curl -s "https://app.requestdesk.ai/api/astro-proxy" | jq '.'
```

## CURRENT STATE
- **Astro site (requestdesk.ai):** Still uses public endpoint (static nginx site can't use agent keys server-side)
- **Proxy endpoint:** Ready for future Astro SSR sites or nginx proxy configurations
- **All files committed and pushed**

## PREVIOUS SESSION WORK (Also Complete)
- ✅ Backend: Added optional agent key auth to `/api/public/content-terms`
- ✅ Backend: Tiered rate limits (60 req/min public → 500 req/min authenticated)
- ✅ Backend: Deployed with tag `matrix-v0.33.7-agent-key-auth`
- ✅ Astro: Rolled back to static nginx (SSR didn't work with multi-site deployment)
- ✅ Astro: Site working at https://requestdesk.ai/over-used-ai-terms

## TODO LIST STATE (COMPLETED)
- ✅ COMPLETED: Create generic Astro proxy endpoint with agent-scoped data
- ✅ COMPLETED: Implement content-terms resource handler
- ✅ COMPLETED: Test proxy with RequestDesk agent key
- ✅ COMPLETED: Fix proxy info endpoint example URL
- ✅ COMPLETED: Deploy backend to production with astro-proxy router

## CONTEXT NOTES

### Why RequestDesk.ai Uses Public Endpoint
The requestdesk.ai site is deployed as static files via nginx (multi-site deployment). It cannot:
- Add agent keys server-side (no Node.js runtime)
- Securely hide API keys (would be exposed in browser)

The public endpoint (60 req/min per IP) is appropriate for this use case.

### Future Use Cases for Astro Proxy
1. **SSR Astro Sites** - Can add agent key server-side
2. **Nginx Proxy Config** - Can inject agent key at nginx layer
3. **Other Astro Sites** - Each site gets its own agent key for scoped data

### RequestDesk Agent Key Reference
- **Agent ID:** `68dc1d940b0b937958668ed0`
- **Agent Name:** RequestDesk
- **API Key:** `ZNgUN47QKeykN8voMmRbuyRT1G3edDxo`

## VERIFICATION COMMANDS
- Check proxy info: `curl -s "https://app.requestdesk.ai/api/astro-proxy" | jq '.'`
- Test with auth: `curl -s "https://app.requestdesk.ai/api/astro-proxy/content-terms?limit=3" -H "Authorization: Bearer ZNgUN47QKeykN8voMmRbuyRT1G3edDxo" | jq '.'`
- Check public terms: `curl -s "https://app.requestdesk.ai/api/public/content-terms?limit=3" | jq '.'`
- Site status: `curl -sL -o /dev/null -w "%{http_code}" "https://requestdesk.ai/over-used-ai-terms"`

## NEXT ACTIONS (IF RESUMING)
1. **Feature branch may be ready to merge** - Consider PR to main
2. **Optional enhancements:**
   - Add more resource handlers (e.g., categories, FAQs)
   - Add caching layer for frequently accessed data
   - Add nginx proxy configuration example for agent key injection
