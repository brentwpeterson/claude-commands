# Resume Instructions for Claude

## SESSION STATUS
**Identity:** Claude-Faraday
**Status:** SAVED
**Last Saved:** 2026-02-15 14:30
**Last Started:** 2026-02-15 14:00

## IMMEDIATE SETUP
1. **Directory:** `cd /Users/brent/scripts/CB-Workspace/requestdesk-app`
2. **Branch:** `git checkout feature/feed-aggregator`
3. **Last Commit:** `5985db1a Phase 0: Add search() convenience method to MongoDBVectorSearchService`
4. **Verify:** `git status`

## WORKSPACES TOUCHED
| Shortcode | What was done |
|-----------|---------------|
| rd | RAG/Vector Search centralization: Phase 0 done, Phases 1-5 planned |

## CURRENT TODO
**Path:** N/A (inline task list in Claude session)
**Status:** Phase 0 committed, Phase 1 implementation next

## WHAT YOU WERE WORKING ON

### RAG/Vector Search Centralization (IN PROGRESS)

**Goal:** One search service (MongoDBVectorSearchService), one embedding model (OpenAI text-embedding-3-small 1536d), zero Redis. User directive: "remove all references to REDIS!!!"

**Plan:** 6 phases approved by user. Phase 0 committed. About to start Phase 1 when user called /claude-save.

### Phase 0: DONE (committed as 5985db1a)
- Added `search()` convenience wrapper to `MongoDBVectorSearchService`
  - Defaults to `text-embedding-3-small` so consumers never specify model
  - Added `additional_filters` param for scoped searches (archived tickets, company_id)
  - Added `_apply_additional_filters()` post-filter with dot-notation support
- Removed old 384d/768d vector index configs from `self.vector_indexes`
- Kept `_cosine_similarity()` as the canonical implementation

### Phase 1: NEXT - Migrate internal authenticated endpoints
**Was about to start implementing when save was called.**

Files to modify:
- `routers/vector_search.py` - Replace `get_redis_llm_client()` + inline `cosine_similarity_manual()` + 384d hardcode with `get_mongodb_vector_service().search()`
- `routers/rag.py` - Replace `get_rag_vector_service()` with `get_mongodb_vector_service()` for health/context/stats/regenerate-embeddings
- `routers/shopify_sync.py` - Replace `get_rag_vector_service().retrieve_context_vector()` at line 254-262 with `get_mongodb_vector_service().search()`
- `routers/rag_management.py` - Replace `get_rag_vector_service()` at line 54 and `get_redis_llm_client()` at line 175 with MongoDBVectorSearchService methods

### Phase 2: PENDING - Migrate public endpoints
Files to modify:
- `routers/public/agent_content.py` - Replace Redis + per-collection loop
- `routers/public/astro_proxy.py` - Replace Redis + 384d hardcode
- `routers/public/typingmind_proxy.py` - Replace Redis + 384d hardcode
- `routers/public/rag_api.py` - Fix ingest embedding + field bug

### Phase 3: PENDING - Migrate archived ticket search
- `routers/archived_ticket_search.py` - Replace Redis, use `additional_filters`

### Phase 4: PENDING - Delete dead services
- **DELETE** `services/redis_llm_client.py`
- **DELETE** `services/rag_vector_service.py`
- **SIMPLIFY** `services/rag_service.py` (remove Redis fallback)
- **CLEAN** `services/rag_ingestion.py` (replace Redis with EmbeddingService)

### Phase 5: OPTIONAL - llm.py cleanup
- Replace inline search with `search()` call

### User Requirements Added During Session
1. Old 384d/768d chunks: **delete them in a migration update** (not just leave invisible)
2. **Smoke test after each phase** to verify endpoints work

### All Files Read and Understood
I have read ALL consumer files in full:
- `mongodb_vector_search.py` (618 lines, modified in Phase 0)
- `redis_llm_client.py` (192 lines, will be deleted)
- `rag_vector_service.py` (548 lines, will be deleted)
- `embedding_service.py` (119 lines, the correct singleton)
- `rag_service.py` (422 lines, will be simplified)
- `rag_ingestion.py` (400 lines, needs Redis removal)
- `vector_search.py` (159 lines, needs rewrite)
- `rag.py` (262 lines, needs rewrite)
- `shopify_sync.py` (268 lines, has RAGVectorService call at line 254)
- `rag_management.py` (801 lines, has Redis references)
- `agent_content.py` (937 lines, has Redis + 384/768 hardcode)
- `astro_proxy.py` (1070 lines, has Redis + 384 hardcode)
- `typingmind_proxy.py` (780 lines, has Redis + 384 hardcode)
- `rag_api.py` (528 lines, has `_get_embedding` helper with Redis-first)
- `archived_ticket_search.py` (583 lines, has Redis + 384/768 hardcode)

### Key Patterns Found Across All Consumer Files
- Each file has its own inline `cosine_similarity_manual()` function (to be deleted)
- Each imports `get_redis_llm_client` from `redis_llm_client` (to be replaced)
- Many hardcode `len(embedding) != 384` or `len(embedding) not in [384, 768]` (to be removed)
- `rag_api.py` search endpoint already uses `get_mongodb_vector_service()` correctly
- `rag_api.py` has a bug: reads `similarity_score` but service returns `similarity`

### search() Method Signature (for reference)
```python
async def search(
    self,
    query: str,
    max_results: int = 5,
    collection_ids: Optional[List[str]] = None,
    source_types: Optional[List[str]] = None,
    similarity_threshold: float = 0.4,
    additional_filters: Optional[Dict[str, Any]] = None,
) -> Dict[str, Any]:
```
Returns: `{"chunks": [...], "total_found": int, "search_type": str, ...}`
Each chunk: `{"id": str, "content": str, "similarity": float, "embedding_model": str, "source_type": str, "source_file": str, "source_section": str, "metadata": dict}`

### MongoDBVectorSearchService also has:
- `get_health_status()` - returns health/stats dict (used by rag.py, rag_management.py)
- `get_embedding_model_stats()` - returns model statistics
- `vector_search()` - lower-level method (search() wraps this)
- Singleton: `get_mongodb_vector_service()`

### Previous Session Context (Critical)
- Created global EmbeddingService at `backend/app/services/embedding_service.py`
- Fixed Collection Q&A to use EmbeddingService directly (commit 37a704b5)
- llm.py line 1183 already uses `get_embedding_service()` correctly (reference pattern)
- Local MongoDB does NOT support `$vectorSearch` (requires Atlas). All local search uses hybrid/manual cosine similarity.

## CURRENT STATE
- **Branch:** `feature/feed-aggregator` (all committed)
- **Phase 0 committed:** `5985db1a`
- **NOT deployed:** Everything is local only
- **No uncommitted changes**
- **Full plan transcript:** `/Users/brent/.claude/projects/-Users-brent-scripts-CB-Workspace/ad26129a-cb42-4981-9615-ab7eac9c33f0.jsonl`

## TODO LIST STATE
- Completed: Phase 0 (add search() method)
- Pending: Phase 1 (internal endpoints)
- Pending: Phase 2 (public endpoints)
- Pending: Phase 3 (archived ticket search)
- Pending: Phase 4 (delete dead services)
- Pending: Phase 5 (optional llm.py cleanup)
- Pending: Migration to delete old 384d/768d chunks

## NEXT ACTIONS
1. **FIRST:** Implement Phase 1 - rewrite `vector_search.py`, `rag.py`, `shopify_sync.py`, `rag_management.py`
2. **SMOKE TEST:** After Phase 1, curl each migrated endpoint to verify
3. **THEN:** Phase 2 - public endpoints
4. **SMOKE TEST:** After Phase 2
5. **THEN:** Phase 3, 4, 5 with smoke tests
6. **FINALLY:** Create migration to delete old 384d/768d chunks

## CONTEXT NOTES
- User was emphatic about removing Redis: "remove all references to REDIS!!!"
- The `search()` method on MongoDBVectorSearchService is the universal entry point going forward
- `EmbeddingService` singleton at `get_embedding_service()` is the only embedding path
- The `vector_search()` method does native $vectorSearch + hybrid fallback automatically
- `search()` wraps `vector_search()` with OpenAI model locked in + additional_filters support
- Test collection: "RAG Debug Test" (ID: `6992050dbcdf243ec8d0e313`)
- Test credentials: `brentwpeterson / test1234`
- rag_management.py has complex model upgrade/rollback logic referencing old 384d/768d models - will need significant rewrite to reference 1536d OpenAI model instead
- The `rag_management.py` download-model endpoint talks to Redis+LLM service directly - this entire endpoint becomes obsolete (OpenAI models don't need downloading)
