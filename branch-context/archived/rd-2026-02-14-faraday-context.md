# Resume Instructions for Claude

## SESSION STATUS
**Identity:** Claude-Faraday
**Status:** ACTIVE
**Last Saved:** 2026-02-14 13:10
**Last Started:** 2026-02-14 17:11

## IMMEDIATE SETUP
1. **Directory:** `cd /Users/brent/scripts/CB-Workspace/requestdesk-app`
2. **Branch:** `git checkout feature/feed-aggregator`
3. **Last Commit:** `b039c152 Add global EmbeddingService and wire into vector search paths`
4. **Verify:** `git status`

## WORKSPACES TOUCHED
| Shortcode | What was done |
|-----------|---------------|
| rd | Created global EmbeddingService, wired into crawler + vector search paths, deployed to production |

## CURRENT TODO
**Path:** None (ad-hoc work on feed aggregator embedding support)
**Status:** Deployed, needs production agent chat verification

## WHAT YOU WERE WORKING ON

### Global EmbeddingService (BUILT AND DEPLOYED)

Created a centralized embedding service to replace 6+ duplicated embedding patterns across the codebase.

**Files created/modified:**
1. **`backend/app/services/embedding_service.py`** (NEW) - Singleton OpenAI embedding service using `text-embedding-3-small`, lazy init, looks up API key from `db.llm_providers`
2. **`backend/app/services/website_crawler_service.py`** - Now generates real embeddings at chunk ingestion time instead of storing empty arrays
3. **`backend/app/routers/llm.py`** - Agent chat RAG path uses EmbeddingService instead of Redis+LLM client, fixed hardcoded 384-dim filter to dynamic
4. **`backend/app/services/mongodb_vector_search.py`** - Collection Q&A path uses EmbeddingService instead of Redis+LLM client

**Key decisions:**
- NO Redis+LLM at all. OpenAI `text-embedding-3-small` only. User was emphatic: "remove all references to REDIS!!!"
- NO fallback chain. Single provider.
- Deployed as `matrix-v0.48.2-global-embedding-service`

### Production Test Results
- **Collection Q&A: WORKING** - Simon Willison chunks found with scores 0.6 and 0.5 via `mongodb_vector_search.py` hybrid path
- **Agent Chat: NEEDS RE-TEST** - Failed at 22:56 UTC with "No chunks found by RAG service" but this was likely old code still running (deploy wasn't fully live). The collection Q&A worked 6 minutes later at 23:02 UTC.

### OPEN ISSUE: Agent Chat vs Collection Q&A paths differ
The agent chat in `llm.py` uses an **inline** vector search (lines 1190-1230) that is separate from `mongodb_vector_search.py`. Key differences:
- llm.py only checks `knowledge_base_id` field
- mongodb_vector_search.py checks BOTH `knowledge_base_id` AND `knowledge_collection_id` (line 326-328)
- If chunks use `knowledge_collection_id`, the agent chat would miss them

### Previous Session Context
- **Bug 1 (FIXED earlier):** 5 files not including feed_collection_id in RAG search
- **Bug 2 (FIXED earlier):** DuplicateKeyError on feed sources with same URL
- **UI fix (committed):** Feed collection badge and separation in AgentRAGManager.tsx
- **Feedly OPML:** Results at `.claude/local/feedly-rss-feeds.md` (19 of 36 usable)

## CURRENT STATE
- **Deployed:** `matrix-v0.48.2-global-embedding-service` (production)
- **All code committed and pushed** to `feature/feed-aggregator` and merged to master
- **Production Super Feed collection:** ID `6990fcce53f4b98eec92f322` (90 chunks: iA + Simon Willison)
- **Production agent:** `685b413eb43a0767e8a59fbe` (Brent Personal Live / Brand Brent)
- **Chunks have embeddings:** Confirmed 1536-dim text-embedding-3-small on local, production collection Q&A also returns scored results

## TODO LIST STATE
- Completed: Create embedding_service.py, wire into crawler/llm.py/mongodb_vector_search.py, deploy
- In Progress: Production verification of agent chat
- Pending: Migrate other callers (rag_ingestion.py, wordpress_content_service.py, shopify_content_service.py, etc.)
- Pending: Import Feedly OPML feeds

## NEXT ACTIONS
1. **FIRST:** Re-test agent chat on production. Ask "What does Simon Willison say about AI and junior engineers?" The deploy should be fully live now.
2. **IF STILL BROKEN:** Check production logs: `aws logs filter-log-events --log-group-name "/ecs/cb-app" --filter-pattern "VECTOR-SEARCH" --start-time $(python3 -c "import time; print(int((time.time()-300)*1000))") --limit 20 --output json`
3. **IF AGENT CHAT PATH FAILS:** Refactor llm.py to use `mongodb_vector_search.py` (proven working) instead of inline vector search. The two paths have different field matching logic.
4. **THEN:** Import Feedly OPML feeds after agent chat confirmed working

## CONTEXT NOTES
- Production AWS logs: `aws logs filter-log-events --log-group-name "/ecs/cb-app" --filter-pattern "RAG" --start-time $(python3 -c "import time; print(int((time.time()-600)*1000))") --limit 50 --output json`
- Test script at: `.claude/local/test-agent-query.sh`
- Feed chunks on production have `embedding_model: None` (legacy). Locally they show `text-embedding-3-small`.
- The `mongodb_vector_search.py` hybrid search checks BOTH `knowledge_base_id` AND `knowledge_collection_id`. The inline llm.py search only checks `knowledge_base_id`. This is the most likely cause if agent chat still fails.
