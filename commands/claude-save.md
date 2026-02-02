Claude Session Save - Create Resume Instructions + Preserve Work

# EMERGENCY MODE (<8% context) - READ THIS FIRST

If a percentage was passed and it is <8%, OR if `--emergency` flag is set, do ONLY this:

1. Run ONE command: `git branch --show-current`
2. Write this file from conversation memory (NO other commands):
   - Path: `/Users/brent/scripts/CB-Workspace/.claude/branch-context/[project]-emergency-context.md`
3. Output: "Emergency context saved to: [path]" and STOP.

Emergency template:
```markdown
# EMERGENCY CONTEXT SAVE - [DATE]
## CRITICAL: LOW CONTEXT SAVE
## BRANCH: [from git command]
## DIRECTORY: [from conversation memory]
## WHAT WE WERE DOING: [from memory]
## PENDING TODOS: [from memory]
## KEY FILES MODIFIED: [from memory]
## CRITICAL STATE: [tokens, IDs, errors from memory]
## NEXT STEPS: [what to do on resume]
```

DO NOT commit, DO NOT run MCP, DO NOT validate anything. Just write and stop.

---

# CORE RULES

1. **NEVER ask questions during save.** No time tracking, no task status, no clarification. Save and exit. Defer questions to /claude-start.
2. **NEVER claim completion.** Say "ready for testing" not "complete."
3. **One context file per workspace per day.** Update existing, don't create duplicates.

---

# MODE DETECTION

Parse arguments: `/claude-save <project> [flags] [X%]`

| Context % | Mode | What to do |
|-----------|------|------------|
| <8% | EMERGENCY | See above. Stop reading here. |
| 8-15% or `--quick` | QUICK | Commit + minimal context file + show path |
| >15% (default) | FULL | Commit + full context file + MCP memory + session registry |

Percentage parsing: `9%` -> extract `9` -> QUICK mode. `5%` -> EMERGENCY. No % passed -> FULL.

---

# WORKSPACE SHORTCODES

| Code | Directory |
|------|-----------|
| `rd` | `/Users/brent/scripts/CB-Workspace/requestdesk-app` |
| `rd-test` | `/Users/brent/scripts/CB-Workspace/requestdesk-app-testing` |
| `astro` | `/Users/brent/scripts/CB-Workspace/astro-sites` |
| `shop` | `/Users/brent/scripts/CB-Workspace/cb-shopify` |
| `wpp` | `/Users/brent/scripts/CB-Workspace/requestdesk-wordpress` |
| `wps` | `/Users/brent/scripts/CB-Workspace/wordpress-sites` |
| `mage` | `/Users/brent/scripts/CB-Workspace/cb-magento-integration` |
| `juno` | `/Users/brent/scripts/CB-Workspace/cb-junogo` |
| `job` | `/Users/brent/scripts/CB-Workspace/jobs` |
| `brent` | `/Users/brent/scripts/CB-Workspace/brent-workspace` |
| `bt` | `/Users/brent/scripts/CB-Workspace/brent-timekeeper` |
| `cc` | `/Users/brent/scripts/CB-Workspace/.claude` |
| `doc` | `/Users/brent/scripts/CB-Workspace/documentation` |

---

# PATHS

```
WORKSPACE_ROOT = /Users/brent/scripts/CB-Workspace
CONTEXT_DIR    = /Users/brent/scripts/CB-Workspace/.claude/branch-context/
SESSION_FILE   = /Users/brent/scripts/CB-Workspace/.claude/local/active-session.json
SESSIONS_REG   = /Users/brent/scripts/CB-Workspace/.claude/local/active-sessions.json
```

---

# QUICK MODE WORKFLOW (8-15% or --quick)

**Phase 1: Commit work**
- `git status` in project directory
- Stage relevant files (skip .env, credentials)
- Commit: `git commit -m "[description] Co-Authored-By: Claude Opus 4.5 <noreply@anthropic.com>"`

**Phase 2: Write context file**
- Check for existing today: `ls .claude/branch-context/[workspace]-*$(date +%Y-%m-%d)*.md`
- Update existing or create `[workspace]-[date]-context.md`
- Use quick template (below)

**Phase 3: Show path and exit**
- Output: "Context saved to: [path]"

Quick template:
```markdown
# Resume Instructions for Claude

## IMMEDIATE SETUP
1. **Directory:** `cd [path]`
2. **Branch:** `git checkout [branch]`
3. **Last Commit:** `[hash] [message]`

## WORKING ON
[Brief description from conversation memory]

## PENDING TODOS
[From conversation memory]

## NEXT ACTIONS
1. [Next thing to do]
2. [Follow-up]

## NOTES
[Important context, gotchas]
```

---

# FULL MODE WORKFLOW (>15%)

**Phase 1: Commit work**
- `git status` in project directory
- Stage relevant files (skip .env, credentials)
- Commit development work first

**Phase 2: Check session tracking**
- Read `active-session.json` to see workspaces touched
- If multiple workspaces: note in context file

**Phase 3: Write context file**
- Check for existing today (update, don't duplicate)
- Use full template (below)

**Phase 4: Commit context + link to todo**
- Stage context files: `git add .claude/branch-context/`
- Commit: "Save resume instructions for session restart"
- If todo directory exists, append to progress.log:
  `YYYY-MM-DD HH:MM - SESSION SAVED -> .claude/branch-context/[filename].md`

**Phase 5: MCP Memory (best effort)**
- Use `mcp__memory__create_entities` (NEVER `read_graph`)
- Entity name: `Session-YYYY-MM-DD-[keyword]`, type: `session`
- 3-5 brief observations: branch, work summary, todo status
- If MCP unavailable, skip silently

**Phase 6: Update session registry**
- Read `active-sessions.json`
- Move session from `sessions` to `resumable`
- Set `context_file`, `last_active`, `task_summary`

**Phase 7: Show path and exit**
- Context file path
- Whether MCP memory saved
- Whether progress.log linked

Full template:
```markdown
# Resume Instructions for Claude

## IMMEDIATE SETUP
1. **Directory:** `cd [path]`
2. **Identity:** Claude-[Name]
3. **Branch:** `git checkout [branch]`
4. **Last Commit:** `[hash] [message]`
5. **Verify:** `git status`

## WORKSPACES TOUCHED
| Shortcode | What was done |
|-----------|---------------|
| [code] | [brief description] |

## CURRENT TODO
**Path:** [path or "None"]
**Status:** [current focus]

## WHAT YOU WERE WORKING ON
[Clear description of task in progress]

## CURRENT STATE
- **Files modified:** [list]
- **Tests run:** [results if any]
- **Issues found:** [blockers if any]

## TODO LIST STATE
- Completed: [items] (USER APPROVED: Yes/No)
- In Progress: [items]
- Pending: [items]

## NEXT ACTIONS
1. **FIRST:** [exact next step]
2. **THEN:** [follow-up]
3. **VERIFY:** [how to check]

## CONTEXT NOTES
[Important details, gotchas, background]
```

---

# FLAG ADDONS

## --backlog
After normal save, append P0 entry to `/Users/brent/scripts/CB-Workspace/.claude/backlog/workspace-resume.md`:
```markdown
## [P0] [Task Title] - RESUME PENDING
**Added:** YYYY-MM-DD HH:MM
**Project:** [shortcode]
**Context:** `.claude/branch-context/[file].md`
**Branch:** [branch]
### Current State: [where work stopped]
### To Resume: `/claude-start [project]`
```

## --close
Before normal save: scan staged files for credentials/API keys/hardcoded URLs. Block if critical issues found.
After normal save: update project CLAUDE.md with `## LAST SESSION STATUS` header, add "SESSION CLOSED" to progress.log, verbose commit.

## --no-todo
Skip todo directory detection and progress.log linking.

---

# BRENT-WORKSPACE ADDON (only when project = brent)

After saving context, append accomplishments to WORK-LOG.md:
```
WORK_LOG="/Users/brent/scripts/CB-Workspace/brent-workspace/ob-notes/Brent Notes/Dashboard/Daily/WORK-LOG.md"
```
- Ensure today's date section exists
- Append `**Session HH:MM:** [accomplishments from memory]` under `### Accomplished`
- Add HTML comment marker: `<!-- Session save: YYYY-MM-DD HH:MM -->`
- Add `## DEFERRED QUESTIONS` section to context file for time tracking and task status questions
