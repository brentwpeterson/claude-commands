# Resume Instructions for Claude

## IMMEDIATE SETUP
1. **Directory:** `cd /Users/brent/scripts/CB-Workspace`
2. **Workspace:** CB-Workspace root (multi-project workspace)
3. **Project Focus:** `.claude/` commands directory

## SESSION SUMMARY
**Task:** Created and enhanced `/claude-help` command system

## WHAT WAS ACCOMPLISHED

### 1. Reviewed `/claude-help` Command
- Already existed with categorized command listing
- Supports `/claude-help`, `/claude-help <command>`, `/claude-help --list`, `/claude-help --todo`

### 2. Updated Workspace Shortcodes
Old shortcodes were incorrect/outdated. Updated to:

| Shortcode | Project | Directory |
|-----------|---------|-----------|
| `rd` | RequestDesk | `requestdesk-app` |
| `rd-test` | RequestDesk Testing | `requestdesk-app-testing` |
| `astro` | Astro Sites | `astro-sites` |
| `shop` | Shopify | `cb-shopify` |
| `wpp` | WordPress Plugin | `requestdesk-wordpress` |
| `wps` | WordPress Sites | `wordpress-sites` |
| `mage` | Magento | `cb-magento-integration` |
| `juno` | JunoGO | `cb-junogo` |
| `job` | Jobs | `jobs` |
| `brent` | Brent Workspace | `brent-workspace` |
| `bt` | Brent Timekeeper | `brent-timekeeper` |
| `cc` | Claude Commands | `.claude` |
| `doc` | Documentation | `documentation` |

**Removed:** `ms` (memory-system) - doesn't exist

### 3. Files Updated
- `CLAUDE.md` (workspace root) - shortcode table
- `.claude/commands/claude-save.md` - shortcode mapping
- `.claude/commands/claude-start.md` - shortcode mapping + inline comment
- `.claude/command-readme.md` - added Workspace Shortcodes section
- `.claude/commands/claude-help.md` - added `shortcodes` as a help topic

### 4. Enhanced `/claude-help`
- Added support for `/claude-help shortcodes` to display workspace shortcodes
- Updated unknown command message to mention shortcodes

## NEXT ACTIONS
1. Test `/claude-help shortcodes` to verify it works
2. Consider adding other help topics: `agents`, `skills`, `structure`
3. User may want to commit these changes

## CONTEXT NOTES
- CB-Workspace is NOT a git repo itself - individual projects inside are git repos
- The `.claude/` directory at workspace root contains shared commands
- User prefers more memorable shortcodes (e.g., `astro` instead of `as`)
