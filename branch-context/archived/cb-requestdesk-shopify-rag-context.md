# Resume Instructions for Claude

## IMMEDIATE SETUP
1. **Directory:** `cd /Users/brent/scripts/CB-Workspace/cb-requestdesk`
2. **Branch:** `git checkout enhancement/shopify-rag-product-sync`
3. **Verify Docker:** `docker ps | grep cbtextapp`
4. **Last Commit:** `8be2b68b Persist knowledge base selection for Shopify integration page`

## SESSION METADATA
**Last Commit:** `8be2b68b Persist knowledge base selection for Shopify integration page`
**MCP Entity:** `Session-2025-12-19-shopify-rag-sync`
**Saved:** 2025-12-19

## WHAT WAS COMPLETED THIS SESSION

### 1. Fixed Shopify RAG Sync for Collections and Blog Articles
**File:** `backend/app/services/agents/agent_integration_service.py`

**5 bugs fixed:**
| Line | Bug | Fix |
|------|-----|-----|
| 882 | `data_key = "data"` | Changed to `data_key = "collections"` |
| 913 | `blogs_result.get('data', [])` | Changed to `blogs_result.get('blogs', [])` |
| 926 | `articles_result.get('data', [])` | Changed to `articles_result.get('articles', [])` |
| 937 | Missing `body` field for article content | Added `article.get('body')` as first option |
| 1076 | `len(products)` reference error | Changed to `len(documents)` |

**Root Cause:** Gadget API returns data in keys matching content type (e.g., 'collections', 'blogs', 'articles') rather than generic 'data' key.

**Test Results:**
- Collections: 46 fetched, 8 chunks created (collections with content)
- Blog Articles: 92 fetched, 92 chunks created
- Products: Already working (289 synced previously)

### 2. Persist Knowledge Base Selection
**File:** `frontend/src/components/integrations/ShopifyIntegrationPage.tsx`

**Added:**
- `loadDefaultCollection()` - Loads saved collection when agent selected
- `saveDefaultCollection()` - Saves selection to backend when changed
- Updated useEffect to call load on agent select
- Updated dropdown onChange to auto-save

**Uses existing backend endpoints:**
- `GET /api/agents/{agent_id}/shopify/default-collection`
- `POST /api/agents/{agent_id}/shopify/default-collection`

## CURRENT STATUS
- ✅ All Shopify RAG sync working: Products, Collections, Blog Articles
- ✅ Knowledge base selection now persists per-agent
- ✅ User is testing frontend now

## PRODUCTION STATUS
- ✅ 289 products synced from Shopify store
- ✅ 92 blog articles synced to RAG
- ✅ 8 collections synced to RAG
- ✅ All Gadget public endpoints working

## COMMITS THIS SESSION
1. `ff17b91d Fix Shopify RAG sync for Collections and Blog Articles`
2. `8be2b68b Persist knowledge base selection for Shopify integration page`

## BRANCH STATUS
- Branch is 7 commits ahead of origin
- Ready to push when user approves

## NEXT ACTIONS
1. Wait for user testing confirmation
2. User may have more Shopify integration improvements
3. Push branch when ready

## VERIFICATION COMMANDS
- Frontend: http://localhost:3001/integrations/shopify
- Backend health: `curl http://localhost:3000/api/health`
- Docker: `docker ps | grep cbtextapp`

## CONTEXT NOTES
- Gadget API keys use lowercase `x-api-key` header
- Database is `requestdesk_production` (not `cbtextapp`)
- Knowledge chunks stored with source_type: `shopify_collection`, `shopify_blog`, `shopify`
