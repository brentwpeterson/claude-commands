# Resume Instructions for Claude

## SESSION STATUS
**Identity:** Claude-Darwin
**Status:** ACTIVE
**Last Saved:** 2026-02-17 17:15
**Last Started:** 2026-02-17 23:00

## IMMEDIATE SETUP
1. **Directory:** `cd /Users/brent/scripts/CB-Workspace/automated-testing`
2. **Branch:** No git repo (workspace root)
3. **Verify:** `ls automations/linkedin/` (user moved files here from wrong location)

## WORKSPACES TOUCHED
| Shortcode | What was done |
|-----------|---------------|
| (automated-testing) | Built LinkedIn connection management automation |

## WHAT YOU WERE WORKING ON
LinkedIn Connection Management Automation. Two-phase system for pruning connections near the 30K limit.

**Phase 1:** User runs LinkedIn search with filters, gives search URL to scrape-search.ts, script paginates and collects profiles into CSV, user reviews, then remove-connections.ts automates removal (dry-run by default).

**Phase 2:** Long-running bulk scrape of all ~30K connections for scoring/enrichment. Multi-day process with rate limiting.

## CURRENT STATE
- **All files written and TypeScript compiles clean** (verified with `npx tsc --noEmit`)
- **npm install completed** (24 packages: csv-parse, csv-stringify, playwright, ts-node, typescript)
- **Playwright chromium NOT yet installed** (`npx playwright install chromium` needs to run)
- **CRITICAL: Files were created at wrong path initially** (`/CB-Workspace/automations/`) and user said the correct location is `/CB-Workspace/automated-testing/automations/linkedin/`
- **The move command (`mv`) failed because bash was blocked**
- **User needs to manually move the directory:**
  ```bash
  mv /Users/brent/scripts/CB-Workspace/automations /Users/brent/scripts/CB-Workspace/automated-testing/automations
  ```

## FILES CREATED
All in `automations/linkedin/`:

| File | Purpose |
|------|---------|
| `package.json` | Dependencies: csv-parse, csv-stringify, playwright |
| `tsconfig.json` | TS config with ES2022, DOM, DOM.Iterable |
| `.gitignore` | Ignores data/*.csv, storageState, node_modules |
| `data/.gitkeep` | Preserves empty data directory |
| `types.ts` | Interfaces: RawConnection, EnrichedData, ScoreBreakdown, Connection, SearchResult, RemovalRecord |
| `config.ts` | Scoring weights, industry keywords, title tiers, rate limits, file paths |
| `utils.ts` | CSV I/O, daily rate tracking, random delays, logging, arg parsing |
| `linkedin-auth.ts` | Manual login flow, storageState save/verify |
| `scrape-search.ts` | **Phase 1:** Takes LinkedIn search URL, paginates, collects profiles into CSV |
| `remove-connections.ts` | **Phase 1:** Automated removal with dry-run default, batch limits, audit log |
| `import-connections.ts` | **Phase 2:** Parse LinkedIn CSV export |
| `score-connections.ts` | **Phase 2:** Weighted scoring algorithm |
| `enrich-profiles.ts` | **Phase 2:** Playwright profile data collection |
| `README.md` | Usage docs for both phases |

## KEY DESIGN DECISIONS
- Phase 1 workflow changed mid-session: originally CSV import + scoring, user clarified they want search URL scraping instead
- scrape-search.ts is the main Phase 1 entry point (not import-connections.ts)
- remove-connections.ts now reads from search-results.csv (not scored.csv)
- Dry-run by default for removals, --confirm flag required
- Headed browser only (no headless) for all Playwright automation
- Rate limits: 25 removals/session, 75/day, 5-15s delays
- CSV as data format for easy manual review in Sheets/Excel

## NEXT ACTIONS
1. **FIRST:** Move directory to correct location:
   ```bash
   mv /Users/brent/scripts/CB-Workspace/automations /Users/brent/scripts/CB-Workspace/automated-testing/automations
   ```
2. **THEN:** Install dependencies in new location:
   ```bash
   cd /Users/brent/scripts/CB-Workspace/automated-testing/automations/linkedin
   npm install
   npx playwright install chromium
   ```
3. **THEN:** Authenticate with LinkedIn:
   ```bash
   npx ts-node linkedin-auth.ts
   ```
4. **THEN:** User runs a LinkedIn search, copies URL
5. **THEN:** Scrape and remove:
   ```bash
   npx ts-node scrape-search.ts "SEARCH_URL"
   npx ts-node remove-connections.ts          # dry run
   npx ts-node remove-connections.ts --confirm # live
   ```

## CONTEXT NOTES
- Bash tool was completely blocked during this session (every command returned exit code 1 with no output after the initial npm install and tsc check succeeded). This prevented the directory move and Playwright chromium install.
- The original plan was from a planning session (transcript at /Users/brent/.claude/projects/-Users-brent-scripts-CB-Workspace/afd83e44-c09b-4124-8a3b-023dc00e2f7a.jsonl)
- User has ~29,900 LinkedIn connections (30K limit) and 32,000 followers
- LinkedIn archive does NOT provide useful follower data for this use case. Connections CSV is the right source for Phase 2.
- Phase 2 will take multiple days due to rate limiting (~30K connections at 3-8s each + daily caps of 150)
- `/claude-save` was updated this session to auto-generate names when no /claude-start was run (Step 3 in Mode Detection section)
