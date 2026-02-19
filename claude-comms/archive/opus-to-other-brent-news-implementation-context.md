# Claude Communication: Brent-News Intelligence System Implementation Context
**Started:** 2026-02-16 morning
**From:** Claude-Opus (implementation session)
**To:** Any active Claude instance

---

## 2026-02-16 Claude-Opus

### What happened

Brent had a plan for a "Brent-News Intelligence System" that was approved in a prior planning session. I implemented all three phases in one session. This touched production code in `requestdesk-app`, so here's what you need to know.

### Why this exists

Brent wants a news intelligence system to stay ahead of ecommerce and AI stories as "the agentic commerce guy." RequestDesk already had a complete feed aggregator (v0.48.0) with RSS/Atom parsing, polling, briefing endpoints, and CSV import. The plan builds on that foundation rather than starting from scratch.

### What was created (new files)

1. **`.claude/local/brent-news-feeds.csv`** - 28 curated RSS feeds (ecommerce, AI, infra, strategy). One-time import file, not committed.
2. **`.claude/commands/brent-news.md`** - Command with subcommands: default (full briefing), quick, deep, sources, starred.
3. **`.claude/skills/brent-news/SKILL.md`** - Domain knowledge for "agentic commerce" relevance scoring, category taxonomy, content angle generation.
4. **`backend/app/migrations/versions/v0_48_3_add_collector_config_to_feed_sources.py`** - Adds `collector_config` dict field and `feed_type` index to feed_sources.
5. **`backend/app/migrations/versions/v0_48_4_add_relevance_scoring_to_feed_items.py`** - Adds scoring fields (relevance_score, content_angles, ai_summary, scored_at, score_model) to feed_items. Seeds RelevanceScorerJob.
6. **`backend/app/services/relevance_scorer_service.py`** - Batch-scores unscored feed items using haiku-class LLM. Model configurable via ConfigManager (`NEWS_SCORER_MODEL`).
7. **`backend/app/services/jobs/relevance_scorer_job.py`** - Scheduled job wrapper for the scorer service (120 min interval).

### What was modified (existing production files)

1. **`backend/app/models/feed_aggregator.py`** - Extended `feed_type` to accept `github`, `hackernews`, `edgar`. Added `collector_config` field to `FeedSourceCreate`.

2. **`backend/app/services/feed_aggregator_service.py`** - Three changes:
   - `create_source()` now stores `collector_config`
   - `_fetch_and_process()` refactored into a dispatcher. Old RSS logic is now `_fetch_and_process_rss()` (same behavior, just renamed). New methods: `_fetch_and_process_github()`, `_fetch_and_process_hackernews()`, `_fetch_and_process_edgar()`, plus `_store_collector_items()` shared pipeline.
   - `get_briefing()` now accepts `min_relevance` param and includes scoring fields in response, sorts by relevance within categories.

3. **`backend/app/routers/feed_aggregator.py`** - CSV import accepts new feed types. Briefing endpoint has `min_relevance` query param. Added `POST /api/feed-aggregator/items/score` endpoint.

4. **`backend/app/services/job_scheduler.py`** - Registered `RelevanceScorerJob` (3 lines added).

### Important: existing RSS behavior is unchanged

The refactor wraps the existing RSS path in a type dispatcher. If `feed_type` is `rss`, `atom`, or `newsletter`, it calls `_fetch_and_process_rss()` which is the original `_fetch_and_process()` code verbatim. No behavioral change for existing feeds.

### What still needs to happen

1. **Migrations need to be run** (v0.48.3 and v0.48.4) by Brent
2. **CSV needs to be imported** via `POST /api/feed-aggregator/sources/import-csv`
3. **Testing** - None of this has been tested yet. Brent needs to verify everything works.
4. **Feed URLs may need validation** - Some RSS URLs in the CSV may have changed or be incorrect. The test endpoint (`POST /sources/test`) can validate them.

### Files at risk

The service file (`feed_aggregator_service.py`) went from 722 lines to ~900+ lines with the new collectors. If something breaks in the existing RSS polling, the dispatcher refactor is the first place to look. The original `_fetch_and_process` was renamed to `_fetch_and_process_rss` and the new `_fetch_and_process` is a thin dispatcher that checks `feed_type`.

**Action Requested:** Be aware of these changes if you work on feed aggregator, briefing, or scheduled jobs. The two migrations must be run before the new features work.
**Reply to:** `/Users/brent/scripts/CB-Workspace/.claude/claude-comms/opus-to-other-brent-news-implementation-context.md`

---
