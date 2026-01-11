# Resume Instructions for Claude

## IMMEDIATE SETUP
1. **Change directory:** `cd /Users/brent/scripts/CB-Workspace/cb-requestdesk`
2. **Verify branch:** `git branch --show-current` (should be: `enhancement/shopify-rag-product-sync`)
3. **Check processes:** `docker ps` (expect: backend + frontend containers running)

## SESSION METADATA
**Last Commit:** `dc0185cf Add author system and dynamic LLM provider for Shopify blog wizard`
**Branch:** `enhancement/shopify-rag-product-sync`
**Saved:** 2025-12-18 ~4:30 PM

## WHAT WAS ACCOMPLISHED THIS SESSION

### 1. Authors Feature - COMPLETE
- Added `authors: List[str]` field to Agent model (AgentBase, AgentCreate, AgentUpdate)
- Added "Content Authors" section in AgentEdit.tsx with ArrayInput
- Added author dropdown in ShopifyBlogWizard.tsx review step (only shows if agent has authors)
- Backend router updates: SaveDraftRequest and PublishBlogRequest accept `author` field
- Backend handles author in save-draft and publish endpoints
- agent_integration_service.py uses `content_data.get('author', 'RequestDesk')` for Shopify

### 2. Dynamic LLM Provider - COMPLETE (CRITICAL FIX)
**Problem:** Shopify blog service was hardcoding `model="claude-3-5-haiku-latest"` and `provider="anthropic"`
- This caused 529 errors when Anthropic was overloaded
- Hardcoded values would break if Anthropic deprecates model names

**Solution:**
- Added `_get_agent_llm_config(agent_id)` helper method in shopify_blog_service.py
- Fetches agent's `model_config` from database
- All 4 LLM calls now use dynamic config:
  - `generate_topics()`
  - `generate_blog()`
  - `generate_product_blog()`
  - `generate_topic_blog()`
- Falls back to LLM service's internal provider if agent has no config

## TODO LIST STATE
- ✅ COMPLETED: Fix Add to Cart name="id" attribute - CONFIRMED WORKING
- ✅ COMPLETED: Add authors list to Agent model and edit form
- ✅ COMPLETED: Add author selection to blog wizard
- ✅ COMPLETED: Pass author to Shopify when publishing
- ⏳ PENDING: Add tags array to post record
- ⏳ PENDING: Format FAQ section (accordion style)
- ⏳ PENDING: Add smart search for products (50 limit)
- ⏳ PENDING: Pull existing Shopify blogs
- ⏳ PENDING: Sync product collections

## KEY FILES MODIFIED
- `backend/app/models/agent.py` - Added authors field to all model classes
- `backend/app/routers/agents.py` - Handle authors in update + response transformations
- `backend/app/routers/shopify_blog.py` - Accept author in save-draft and publish requests
- `backend/app/services/agents/agent_integration_service.py` - Use author from content_data
- `backend/app/services/shopify_blog_service.py` - Dynamic LLM config + author support
- `frontend/src/components/agents/AgentEdit.tsx` - Content Authors ArrayInput section
- `frontend/src/components/agents/ShopifyBlogWizard.tsx` - Author dropdown in review step

## CRITICAL CONTEXT
- **Database:** Using `requestdesk_production` database
- **Shopify products synced:** 289 products with images from chaletmarket.com
- **Collection ID:** `69431fa8b010288967dc4679`
- **LLM Provider:** Now uses agent's configured provider (no more hardcoded Anthropic)

## NEXT ACTIONS
1. **Test blog generation** with new dynamic LLM provider
2. Work through remaining pending todos:
   - Add tags array to post record
   - Format FAQ section (accordion style)
   - Add smart search for products (50 limit)
   - Pull existing Shopify blogs
   - Sync product collections

## VERIFICATION
- Test blog generation at: http://localhost:3001/agents (select agent with Shopify integration)
- Author dropdown should appear in review step if agent has authors configured
- LLM provider should match agent's configured provider in Settings/LLM Providers
