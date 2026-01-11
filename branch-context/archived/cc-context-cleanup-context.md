# Resume Instructions for Claude

## IMMEDIATE SETUP
1. **Change directory:** `cd /Users/brent/scripts/CB-Workspace/.claude/branch-context`
2. **Verify files:** `ls *.md | wc -l` (expect: ~5 active files + 2 guard files + README)

## SESSION METADATA
**Project:** claude-commands (cc)
**Saved:** 2026-01-10
**Task:** Context file cleanup and archival

## WHAT WAS ACCOMPLISHED THIS SESSION

### Major Context File Cleanup
- **Started with:** 80 context files
- **Ended with:** 5 active context files
- **Archived:** 75 files (94% reduction)

### Process Established
1. **Retention Policy Created:**
   - < 7 days: Keep if actively working
   - 7-14 days: Review, extract actionables, archive
   - > 14 days: Archive (work done or abandoned)

2. **Before Archiving, Extract:**
   - Backlog items → RequestDesk backlog API
   - Decisions made → Project CLAUDE.md
   - Learnings/patterns → SOPs or skill files
   - Pending todos → Backlog

3. **Backlog Category Pattern:**
   - Category: `Context`
   - Subcategory: project name (e.g., `wordpress-sites`)
   - Notes: `Resume context: [filename].md`

### Backlog API Usage
- **Production URL:** `https://app.requestdesk.ai/api/backlog`
- **Auth:** `Authorization: Bearer MNRcaklW3XF7UpKX4VrxPV7wo2L7xsWg`
- **Added item:** WordPress Mega Menu with context reference

## REMAINING ACTIVE CONTEXT FILES (5)
| File | Date | Notes |
|------|------|-------|
| `wordpress-sites-cucumber-context.md` | Jan 10 | Backlogged as P1 |
| `bw-hubspot-enrichment-context.md` | Jan 10 | Today's work |
| `bw-hubspot-enrichment-batch-context.md` | Jan 10 | Today's work |
| `brent-claude-help-context.md` | Jan 10 | Today's work |
| `bigcommerce-planning-context.md` | Jan 9 | Planning |

## GUARD FILES (Keep - intentional)
- `main-context.md` (root-owned) - Prevents generic context creation
- `master-context.md` (root-owned) - Prevents generic context creation

## ARCHIVED FOLDER
- Location: `/Users/brent/scripts/CB-Workspace/.claude/branch-context/archived/`
- Contains: 75+ archived context files
- Also: `stagnent-context/` folder with 18 older files

## TODO LIST STATE
- ✅ COMPLETED: Review and categorize all 80 context files
- ✅ COMPLETED: Archive stale/completed context files
- ✅ COMPLETED: Extract actionables from remaining files before archive

## NEXT ACTIONS
1. Consider adding backlog items for remaining 4 context files (if needed)
2. Document retention policy in CLAUDE.md or SOP
3. Consider automating context cleanup with a skill/command

## VERIFICATION COMMANDS
```bash
# Count active files
ls /Users/brent/scripts/CB-Workspace/.claude/branch-context/*.md | wc -l

# Count archived files
ls /Users/brent/scripts/CB-Workspace/.claude/branch-context/archived/*.md | wc -l

# Check backlog items with context references
curl -s "https://app.requestdesk.ai/api/backlog?limit=200" \
  -H "Authorization: Bearer MNRcaklW3XF7UpKX4VrxPV7wo2L7xsWg" | \
  python3 -c "import json,sys; [print(i['title']) for i in json.load(sys.stdin)['items'] if 'context' in (i.get('notes') or '').lower()]"
```
