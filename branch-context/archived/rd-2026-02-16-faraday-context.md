# EMERGENCY CONTEXT SAVE - 2026-02-16
## CRITICAL: LOW CONTEXT SAVE
## BRANCH: feature/feed-aggregator
## DIRECTORY: /Users/brent/scripts/CB-Workspace/requestdesk-app
## Identity: Claude-Faraday

## WHAT WE WERE DOING:
RAG/Vector Search Centralization - Multi-phase project to replace ALL Redis LLM client references and inline cosine_similarity with centralized MongoDBVectorSearchService.search() and EmbeddingService.

## COMPLETED PHASES:
- **Phase 0**: DONE & DEPLOYED - Added search() convenience method to MongoDBVectorSearchService (commit 5985db1a)
- **Phase 1**: DONE & DEPLOYED & PRODUCTION TESTED - Migrated vector_search.py, rag.py, shopify_sync.py, rag_management.py (commit 8329599a, tag backend-v0.48.2-rag-phase1-centralize)
- **Phase 2**: EDITS COMPLETE, NOT YET COMMITTED OR DEPLOYED

## PHASE 2 STATUS - EDITS DONE, NEEDS COMMIT + DEPLOY:
All 4 public endpoint files edited, Redis references removed, verified clean:

1. **agent_content.py** - Removed get_redis_llm_client import, cosine_similarity_manual function, 384/768d hardcode. Replaced /agent/knowledge search block with vector_service.search(). Cleaned up old audit trail comments.
2. **astro_proxy.py** - Replaced handle_knowledge_base() Redis+cosine_similarity+384d block with vector_service.search().
3. **typingmind_proxy.py** - Replaced /typingmind/proxy/knowledge-base Redis+cosine_similarity_manual+384d block with vector_service.search().
4. **rag_api.py** - Replaced _get_embedding() helper (Redis fallback chain) with EmbeddingService. Fixed /search endpoint: changed vector_search() to search(), fixed similarity_score->similarity field mapping bug.

## KEY FILES MODIFIED (UNCOMMITTED):
- backend/app/routers/public/agent_content.py
- backend/app/routers/public/astro_proxy.py
- backend/app/routers/public/typingmind_proxy.py
- backend/app/routers/public/rag_api.py

## LOCAL SMOKE TEST RESULTS:
- Backend health: healthy (200)
- TypingMind proxy health: healthy (200)
- Astro proxy info: healthy (200)
- Knowledge search endpoints: could not test directly because local test agents don't have rag_enabled=True, but endpoints load without import errors

## PENDING TODOS:
- Task #6: Phase 2 - EDITS DONE, needs commit + deploy + production test
- Task #7: Phase 3 - Migrate archived_ticket_search.py
- Task #8: Phase 4 - Delete dead services (redis_llm_client.py, rag_vector_service.py)
- Task #9: Phase 5 - Optional llm.py cleanup
- Task #10: Migration to delete old 384d/768d chunks
- Task #11: Better error feedback on /ask endpoint

## NEXT STEPS:
1. **COMMIT Phase 2 changes**: `git add backend/app/routers/public/agent_content.py backend/app/routers/public/astro_proxy.py backend/app/routers/public/typingmind_proxy.py backend/app/routers/public/rag_api.py`
2. **DEPLOY**: Use /deploy-project - should be backend-only tag (no frontend changes)
3. **PRODUCTION TEST**: User tests with RSS feed import + agent chat query (same as Phase 1 test with CNBC feed)
4. After production confirmed: Start Phase 3 (archived_ticket_search.py)

## CRITICAL CONTEXT:
- search() method signature: `search(query, max_results=5, collection_ids=None, source_types=None, similarity_threshold=0.4, additional_filters=None)`
- Returns: {"chunks": [...], "total_found": int} where each chunk has {id, content, similarity, embedding_model, source_type, source_file, source_section, metadata}
- get_mongodb_vector_service() is the singleton
- get_embedding_service() returns EmbeddingService with generate_embedding(text) -> EmbeddingResult(embedding, model)
- User workflow: implement -> local test -> deploy -> production smoke test -> next phase
- User was emphatic: test PRODUCTION not localhost. Give user feed URLs to test, don't curl locally.
- Phase 1 production test: CNBC feed https://www.cnbc.com/id/100727362/device/rss/rss.html, question "What was Japan's fourth quarter GDP growth rate?" -> correct answer 0.1%
