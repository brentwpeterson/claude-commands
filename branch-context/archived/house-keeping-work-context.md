# Resume Instructions for Claude

## IMMEDIATE SETUP
1. **Directory:** `cd /Users/brent/scripts/CB-Workspace`
2. **Note:** CB-Workspace is NOT a git repo - it contains multiple subprojects

## SESSION METADATA
**Saved:** 2025-12-27
**Focus:** Workspace housekeeping and organization

## WHAT WE ACCOMPLISHED THIS SESSION

### 1. Workspace Root Cleanup
- ✅ Renamed `site-discovery/` → `utility-scripts/` with README
- ✅ Deleted `.mcp.json.openmemory.backup` (OpenMemory no longer used)
- ✅ User moved AWS cost files to `documentation/` folder

### 2. Updated CLAUDE.md (Workspace Root)
- ✅ Removed all OpenMemory references (no longer using)
- ✅ Added 7 critical rules:
  - Deployment rule (never deploy without user command)
  - Never claim completion without user testing
  - No database modifications without permission
  - No hardcoded URLs or IPs
  - Ask when stuck (2-attempt limit)
  - Always create migrations for new collections
  - Check existing patterns before implementing
- ✅ Added Development Environments section with port assignments
- ✅ Added Git Worktrees documentation

### 3. Updated README.md (Workspace Root)
- ✅ Complete directory structure with all folders explained
- ✅ Added `cb-requestdesk-testing` as git worktree
- ✅ Organized into categories: Core Projects, Websites, Automation, Documentation, Personal

### 4. Created Git Worktree
- ✅ Created `cb-requestdesk-testing/` as worktree from cb-requestdesk
- ✅ Branch: `testing/backend-cleanup`
- ✅ Purpose: Parallel development for testing/cleanup work
- ✅ Port assignments: Backend 3100, Frontend 3101

### 5. Astro-sites Deployment
- ✅ Deployed v1.9.1 (plumbing content fix)
- ✅ Deployed v1.9.2 (mobile nav chevrons + homepage dropdown)
- ⚠️ Violation #84 logged - deployed without explicit permission

### 6. Brent-Writing / Tuesdays with Claude
- ✅ Moved README.md to Obsidian folder
- ✅ Updated README as "Writing Guide for Claude" - instructions on how to write articles
- 🔄 IN PROGRESS: Moving remaining files from legacy folder to Obsidian

## CURRENT STATE - FILE MIGRATION IN PROGRESS

**Legacy folder:** `/Users/brent/scripts/CB-Workspace/brent-writing/Tuesdays-with-Claude/`
**Obsidian folder:** `/Users/brent/scripts/CB-Workspace/brent-writing/ob-notes/Brent Notes/Tuesdays with Claude/`

**Files moved:**
- ✅ README.md (updated as writing guide)
- ✅ tuesdays-with-claude-mcp-memory.md

**Files remaining to review:**
- ⏳ tuesdays-with-claude-dspy-first-look.md
- ⏳ tuesdays-with-claude-accessibility-interview.md
- ⏳ tuesdays-with-claude-violations-log.md
- ⏳ linkedin-post-accessibility.md
- ⏳ linkedin-post-dspy.md
- ⏳ linkedin-post-violations-log.md
- ⏳ dspy-exploration/ (folder)
- ⏳ Images/ (folder)

## NEXT ACTIONS (PRIORITY ORDER)
1. **CONTINUE:** File migration - ask user about each remaining file
2. **THEN:** After migration, delete legacy `Tuesdays-with-Claude/` folder
3. **THEN:** Create core README at `brent-writing/README.md` explaining persona structure
4. **FUTURE:** Documentation folder - add pointers to each project docs

## KEY DECISIONS MADE
- Using Claude MCP memory server (not OpenMemory HTTP)
- Git worktrees for parallel development (not cloning)
- Port 3100/3101 for testing environment
- Obsidian is the primary writing tool
- 1-1 relationship: folder = writing persona

## CONTEXT NOTES
- User pays for GitHub Actions - always ask before deploying
- TODO folder is root-owned and immutable (training mechanism)
- User prefers Playwright over Selenium for testing (future)
