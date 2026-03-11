Claude Session Save - Create Resume Instructions + Preserve Work

# SESSION STATUS SYSTEM

**Context files now include a Session Status header that tracks:**
- **Identity:** Your Claude name (e.g., Claude-Curie)
- **Status:** SAVED | ACTIVE | LATER
- **Last Saved:** Timestamp when saved
- **Last Started:** Timestamp when last started (if resumed)

**This enables:**
- Other Claudes to see if a session is in use (ACTIVE) before claiming it
- `/brent-start` to inventory all sessions across workspaces
- `/claude-resume` to list and resume parked sessions

---

# EMERGENCY MODE (<8% context) - READ THIS FIRST

If a percentage was passed and it is <8%, OR if `--emergency` flag is set, do ONLY this:

1. Run ONE command: `git branch --show-current`
2. **Get YOUR identity from conversation memory.** You know your name. Do NOT read `active-session.json` (shared file, could be another session's data).
3. Write this file from conversation memory (NO other commands):
   - If you know your task slug: `/Users/brent/scripts/CB-Workspace/.claude/branch-context/[task-slug]-[claude-name]-context.md`
   - If you don't know: `/Users/brent/scripts/CB-Workspace/.claude/branch-context/emergency-[claude-name]-context.md`
   - The emergency flag is INSIDE the file (`EMERGENCY CONTEXT SAVE` header), not in the filename.
   - `[claude-name]` = YOUR name from this conversation, lowercase (e.g., `turing`, `earhart`)
4. Output: "Emergency context saved to: [path]" and STOP.

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
3. **One context file per task per Claude.** Filename is task-based, not date-based. Same task = update in place. No file accumulation across days.

---

# MODE DETECTION

Parse arguments: `/claude-save [project] [flags] [X%]`

**Flags:** `--quick`, `--emergency`, `--close`, `--tomorrow`, `--no-todo`

**No-argument resolution:**
When no project argument is provided, resolve identity and workspace in this order:

**Step 1: Use YOUR OWN identity from conversation memory (PRIMARY)**
- You know your Claude name. You picked it (or inherited it) at `/claude-start` or `/brent-start`.
- You know which workspace you're working in from the session.
- **If you know both: use them. Do NOT read `active-session.json`.**

**Step 2: Fall back to `active-session.json` ONLY if you don't know your own identity**
(This should rarely happen. If it does, something went wrong at session start.)
1. Read `active-session.json`:
   ```bash
   SESSION_FILE="/Users/brent/scripts/CB-Workspace/.claude/local/active-session.json"
   ```
2. Extract `name` and `startWorkspace` from the JSON
3. **VERIFY** the name matches your conversation context. If it doesn't match, WARN:
   ```
   ⚠️ active-session.json says [X] but I am Claude-[Y]. Using my own identity.
   ```

**Step 3: If neither works, AUTO-GENERATE a name:**
- Pick a name from the standard list that is NOT already in use:
  - Scientists: Edison, Tesla, Curie, Darwin, Hopper, Turing, Lovelace, Feynman, Hawking
  - Artists: DaVinci, Picasso, Mozart, Beethoven, VanGogh
  - Explorers: Shackleton, Earhart, Armstrong, Cousteau
  - Writers: Hemingway, Austen, Twain, Tolkien
- Check existing names to avoid collisions:
  ```bash
  # Read active names
  NAMES_FILE="/Users/brent/scripts/CB-Workspace/.claude/local/active-claude-names.json"
  EXISTING=$(cat "$NAMES_FILE" 2>/dev/null || echo "[]")
  # Also check today's context files for names in use
  ls /Users/brent/scripts/CB-Workspace/.claude/branch-context/*-$(date +%Y-%m-%d)-*-context.md 2>/dev/null
  ```
- Pick a name not in either list
- Register the name in `active-claude-names.json`
- Write/update `active-session.json` with the new name and detected workspace
- Detect workspace from pwd using the shortcode mapping (same as `/claude-start`)
- Log: `Auto-assigned identity: Claude-[Name] (no /claude-start was run)`
- Continue with the save using the new name

🚨 **WHY THIS ORDER MATTERS:** `active-session.json` is a shared file. If two Claude windows are open, the last one to start overwrites it. Reading it at save time could give you another session's identity, causing you to write to the wrong context file. Your own conversation memory is always authoritative.

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
CONTEXT_FILE   = [task-slug]-[claude-name]-context.md  (e.g., acg-newsletter-37-voltaire-context.md)
SESSION_FILE   = /Users/brent/scripts/CB-Workspace/.claude/local/active-session.json
SESSIONS_REG   = /Users/brent/scripts/CB-Workspace/.claude/local/active-sessions.json
```

## TASK-SLUG GENERATION

The task slug is a short, lowercase, hyphenated name for what you're working on. Generate it from the task description in conversation memory.

**Rules:**
- 2-5 words, lowercase, hyphenated
- Descriptive enough to identify the task at a glance
- Stable across saves (same task = same slug)
- Examples: `acg-newsletter-37`, `tc-wordpress-migration`, `llm-provider-fixes`, `shoptalk-meeting-prep`, `hubspot-crossbeam-outreach`

**On first save:** Generate the slug from the task. Include it in the context file under `## TASK SLUG` so future saves reuse it.

**On subsequent saves:** Read the existing context file for this Claude to get the slug. If the task has changed (Claude is working on something new), generate a new slug and archive the old file.

## FILE LIFECYCLE

```bash
CONTEXT_DIR="/Users/brent/scripts/CB-Workspace/.claude/branch-context"
CLAUDE_NAME="[lowercase-name]"  # e.g., "voltaire"

# Find existing file for this Claude
EXISTING=$(ls "$CONTEXT_DIR"/*-${CLAUDE_NAME}-context.md 2>/dev/null | head -1)

if [ -n "$EXISTING" ]; then
  # Read the task slug from the existing file
  OLD_SLUG=$(grep "Task Slug:" "$EXISTING" | sed 's/.*: //' | tr -d '`* ')

  if [ "$OLD_SLUG" = "$NEW_SLUG" ]; then
    # Same task: UPDATE IN PLACE (overwrite)
    CONTEXT_FILE="$EXISTING"
  else
    # Different task: ARCHIVE old, create new
    mkdir -p "$CONTEXT_DIR/archive"
    mv "$EXISTING" "$CONTEXT_DIR/archive/"
    CONTEXT_FILE="$CONTEXT_DIR/${NEW_SLUG}-${CLAUDE_NAME}-context.md"
  fi
else
  # No existing file: create new
  CONTEXT_FILE="$CONTEXT_DIR/${NEW_SLUG}-${CLAUDE_NAME}-context.md"
fi
```

## MIGRATING OLD DATE-BASED FILES

When saving, also check for and clean up old date-based files for this Claude:
```bash
# Find old format files: [workspace]-YYYY-MM-DD-[name]-context.md
OLD_FORMAT=$(ls "$CONTEXT_DIR"/*-20[0-9][0-9]-[0-9][0-9]-[0-9][0-9]-${CLAUDE_NAME}-context.md 2>/dev/null)
if [ -n "$OLD_FORMAT" ]; then
  mkdir -p "$CONTEXT_DIR/archive"
  for f in $OLD_FORMAT; do
    mv "$f" "$CONTEXT_DIR/archive/"
  done
  echo "Archived $(echo "$OLD_FORMAT" | wc -l | tr -d ' ') old date-based context files"
fi
```

---

# QUICK MODE WORKFLOW (8-15% or --quick)

**Phase 1: Commit work**
- `git status` in project directory
- Stage relevant files (skip .env, credentials)
- Commit: `git commit -m "[description] Co-Authored-By: Claude Opus 4.5 <noreply@anthropic.com>"`

**Phase 2: Write context file**
- Get Claude identity: **Primary source** is `active-session.json` `name` field. Fallback to conversation memory.
  ```bash
  # Read identity from session file (primary source)
  CLAUDE_NAME=$(cat /Users/brent/scripts/CB-Workspace/.claude/local/active-session.json 2>/dev/null | jq -r '.name // empty')
  # If empty, fall back to conversation memory (e.g., "Tesla", "Shackleton")
  ```
- **Check for legacy file without Claude name and RENAME it:**
  ```bash
  # If a file exists without the Claude name, rename it to include the name
  LEGACY=$(ls .claude/branch-context/[workspace]-$(date +%Y-%m-%d)-context.md 2>/dev/null)
  NAMED=".claude/branch-context/[workspace]-$(date +%Y-%m-%d)-[claude-name]-context.md"
  if [ -n "$LEGACY" ] && [ ! -f "$NAMED" ]; then
    # Check if the legacy file belongs to this Claude (grep for Identity)
    if grep -q "Identity.*Claude-[Name]" "$LEGACY" 2>/dev/null || ! grep -q "Identity.*Claude-" "$LEGACY" 2>/dev/null; then
      mv "$LEGACY" "$NAMED"
    fi
  fi
  ```
- Find existing file for this Claude: `ls .claude/branch-context/*-[claude-name]-context.md`
- Update existing (same task) or create new `[task-slug]-[claude-name]-context.md`
- Archive old date-based files if found
- Use quick template (below)

**Phase 3: Show path and exit**
- Output: "Context saved to: [path]"

Quick template:
```markdown
# Resume Instructions for Claude

## SESSION STATUS
**Identity:** Claude-[Name]
**Task Slug:** `[task-slug]`
**Status:** SAVED
**Last Saved:** [YYYY-MM-DD HH:MM]
**Last Started:** [YYYY-MM-DD HH:MM or "New session"]

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
- Get Claude identity: **Primary source** is `active-session.json` `name` field. Fallback to conversation memory.
  ```bash
  # Read identity from session file (primary source)
  CLAUDE_NAME=$(cat /Users/brent/scripts/CB-Workspace/.claude/local/active-session.json 2>/dev/null | jq -r '.name // empty')
  # If empty, fall back to conversation memory (e.g., "Tesla", "Shackleton")
  ```
- **Check for legacy file without Claude name and RENAME it:**
  ```bash
  # If a file exists without the Claude name, rename it to include the name
  LEGACY=$(ls /Users/brent/scripts/CB-Workspace/.claude/branch-context/[workspace]-$(date +%Y-%m-%d)-context.md 2>/dev/null)
  NAMED="/Users/brent/scripts/CB-Workspace/.claude/branch-context/[workspace]-$(date +%Y-%m-%d)-[claude-name]-context.md"
  if [ -n "$LEGACY" ] && [ ! -f "$NAMED" ]; then
    # Check if the legacy file belongs to this Claude (grep for Identity) or has no Identity yet
    if grep -q "Identity.*Claude-[Name]" "$LEGACY" 2>/dev/null || ! grep -q "Identity.*Claude-" "$LEGACY" 2>/dev/null; then
      mv "$LEGACY" "$NAMED"
    fi
  fi
  ```
- Find existing file for this Claude: `ls .claude/branch-context/*-[claude-name]-context.md`
- Update existing (same task) or create new `[task-slug]-[claude-name]-context.md`
- Archive old date-based files if found
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

Display this exact format for easy resume:
```
Context saved: [full path to context file]
Identity: Claude-[Name]
Task: [task-slug]
Code: [first 6 chars of md5 of filename]

To resume: /resume [code]
```

Generate the resume code:
```bash
echo "$(basename "$CONTEXT_FILE")" | md5 | head -c 6
```

Also show:
- Whether MCP memory saved
- Whether progress.log linked

Full template:
```markdown
# Resume Instructions for Claude

## SESSION STATUS
**Identity:** Claude-[Name]
**Task Slug:** `[task-slug]`
**Status:** SAVED
**Last Saved:** [YYYY-MM-DD HH:MM]
**Last Started:** [YYYY-MM-DD HH:MM or "New session"]

## IMMEDIATE SETUP
1. **Directory:** `cd [path]`
2. **Branch:** `git checkout [branch]`
3. **Last Commit:** `[hash] [message]`
4. **Verify:** `git status`

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

## --tomorrow
Save context normally, then move the context file to `tomorrow/` folder. This marks the session for next-day pickup without needing `/brent-finish` to triage it.

After writing the context file:
```bash
TOMORROW_DIR="/Users/brent/scripts/CB-Workspace/.claude/branch-context/tomorrow"
mkdir -p "$TOMORROW_DIR"
mv "$CONTEXT_FILE" "$TOMORROW_DIR/"
echo "Saved to tomorrow/: $(basename $CONTEXT_FILE)"
echo "Will be available via /claude-start at next /brent-start"
```

Display:
```
Context saved: tomorrow/[filename]
  Identity: Claude-[Name]
  Status: SAVED (tomorrow)

To resume tomorrow:
  /brent-start will show this session
  /claude-start [name] to pick it up
```

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
