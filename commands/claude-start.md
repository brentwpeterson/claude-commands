Claude Session Start - Read Resume Instructions and Execute

🚨 **CRITICAL COMMUNICATION RULE**: Never say "You're absolutely right!" or similar repetitive agreement phrases ("Perfect!", "Exactly!", "That's completely right!"). Use brief acknowledgment instead ("Got it.", "I understand.") then proceed with actual response. Violations will be logged.

🚨 **CRITICAL DEVELOPMENT ENVIRONMENT RULE**: This project uses DOCKER containers for development. DO NOT look for local dev servers (npm, python, etc.). ALL development happens in Docker containers. If you can't find the expected Docker containers running, ASK THE USER immediately instead of spending time troubleshooting. The user will guide you to start the correct containers.

**USAGE:**
- `/claude-start` - Fresh session: detect workspace from `pwd`, pick a name, register, present status
- `/claude-start <project>` - Resume from saved context file for a project shortcode
- `/claude-start <claude-name>` - Resume by Claude name (e.g., `/claude-start curie`)
- `/claude-start <full-path>` - Resume from specific context file path

**Arguments**:
- `<project>` (optional): Project name, Claude name, or full path to context file. If omitted, starts a fresh session in the current workspace.

**NAME-BASED LOOKUP:**
If argument looks like a Claude name (not a shortcode or path):
1. Search for context files matching `*-[name]-context.md` (e.g., `*-curie-context.md`)
2. If found, use that file directly
3. Inherit the identity from the file
4. **FALLBACK:** If filename search finds nothing, grep inside context files for the identity:
   ```bash
   # Sort by modification time (newest first) to pick the most recent match
   grep -rl "Identity.*Claude-[Name]" /Users/brent/scripts/CB-Workspace/.claude/branch-context/*.md 2>/dev/null | xargs ls -t 2>/dev/null | head -1
   # Also check later/ directory
   grep -rl "Identity.*Claude-[Name]" /Users/brent/scripts/CB-Workspace/.claude/branch-context/later/*.md 2>/dev/null | xargs ls -t 2>/dev/null | head -1
   ```
   If found, use that file (the Claude name is inside the file but not in the filename - legacy format).
   If multiple matches, the newest file (by modification time) is used.

   **AUTO-RENAME:** When a file is found via fallback grep, rename it to include the Claude name so future lookups work by filename:
   ```bash
   # Extract workspace and date from old filename, construct new name
   OLD_FILE="[found file path]"
   NEW_FILE=$(echo "$OLD_FILE" | sed 's/-context\.md$/-[claude-name]-context.md/')
   # Only rename if the new name doesn't already exist
   if [ ! -f "$NEW_FILE" ]; then
     mv "$OLD_FILE" "$NEW_FILE"
     echo "📝 Renamed context file to include Claude name: $(basename $NEW_FILE)"
   fi
   ```

**🗂️ WORKSPACE SHORTCODES & DIRECTORY MAPPING:**

| Shortcode | Full Name | Directory Path |
|-----------|-----------|----------------|
| `rd` | requestdesk | `/Users/brent/scripts/CB-Workspace/requestdesk-app` |
| `rd-test` | requestdesk-testing | `/Users/brent/scripts/CB-Workspace/requestdesk-app-testing` |
| `astro` | astro-sites | `/Users/brent/scripts/CB-Workspace/astro-sites` |
| `shop` | shopify | `/Users/brent/scripts/CB-Workspace/cb-shopify` |
| `wpp` | wordpress-plugin | `/Users/brent/scripts/CB-Workspace/requestdesk-wordpress` |
| `wps` | wordpress-sites | `/Users/brent/scripts/CB-Workspace/wordpress-sites` |
| `mage` | magento | `/Users/brent/scripts/CB-Workspace/cb-magento-integration` |
| `juno` | junogo | `/Users/brent/scripts/CB-Workspace/cb-junogo` |
| `job` | jobs | `/Users/brent/scripts/CB-Workspace/jobs` |
| `brent` | brent-workspace | `/Users/brent/scripts/CB-Workspace/brent-workspace` |
| `bt` | brent-timekeeper | `/Users/brent/scripts/CB-Workspace/brent-timekeeper` |
| `cc` | claude-commands | `/Users/brent/scripts/CB-Workspace/.claude` |
| `doc` | documentation | `/Users/brent/scripts/CB-Workspace/documentation` |

**SESSION TRACKING FILE:** `/Users/brent/scripts/CB-Workspace/.claude/local/active-session.json`

**🔍 WORKSPACE DETECTION FROM PWD (No-Argument Mode):**

When `/claude-start` is called with NO arguments, detect the workspace from the current working directory:

```bash
CWD=$(pwd)
# Reverse lookup: match CWD against shortcode directory mapping
case "$CWD" in
  /Users/brent/scripts/CB-Workspace/requestdesk-app-testing*) SHORTCODE="rd-test" ;;
  /Users/brent/scripts/CB-Workspace/requestdesk-app*) SHORTCODE="rd" ;;
  /Users/brent/scripts/CB-Workspace/astro-sites*) SHORTCODE="astro" ;;
  /Users/brent/scripts/CB-Workspace/cb-shopify*) SHORTCODE="shop" ;;
  /Users/brent/scripts/CB-Workspace/requestdesk-wordpress*) SHORTCODE="wpp" ;;
  /Users/brent/scripts/CB-Workspace/wordpress-sites*) SHORTCODE="wps" ;;
  /Users/brent/scripts/CB-Workspace/cb-magento-integration*) SHORTCODE="mage" ;;
  /Users/brent/scripts/CB-Workspace/cb-junogo*) SHORTCODE="juno" ;;
  /Users/brent/scripts/CB-Workspace/jobs*) SHORTCODE="job" ;;
  /Users/brent/scripts/CB-Workspace/brent-workspace*) SHORTCODE="brent" ;;
  /Users/brent/scripts/CB-Workspace/brent-timekeeper*) SHORTCODE="bt" ;;
  /Users/brent/scripts/CB-Workspace/.claude*) SHORTCODE="cc" ;;
  /Users/brent/scripts/CB-Workspace/documentation*) SHORTCODE="doc" ;;
  /Users/brent/scripts/CB-Workspace) SHORTCODE="" ;;  # At workspace root, ask user
  *) SHORTCODE="" ;;  # Not in a known workspace, ask user
esac
```

- If `SHORTCODE` is found: use it as the workspace for the fresh session
- If `SHORTCODE` is empty (at workspace root or unknown directory): ask user "Which workspace are you working in?" and list available shortcodes
- **Note:** Match `requestdesk-app-testing` BEFORE `requestdesk-app` to avoid false match (or use exact match logic)

**🚨 CRITICAL: Always use this mapping to resolve project names to full paths!**
- If project name not in mapping, ASK USER for the correct path
- NEVER guess or assume directory locations

**🎯 PURPOSE:**
Read the instruction file created by `/claude-save` or `/claude-save-fast` and follow those exact instructions

**🗂️ CRITICAL PATH DEFINITION:**
```
WORKSPACE_ROOT = /Users/brent/scripts/CB-Workspace
CONTEXT_DIR    = /Users/brent/scripts/CB-Workspace/.claude/branch-context/
CONTEXT_FILE   = /Users/brent/scripts/CB-Workspace/.claude/branch-context/[task-slug]-[claude-name]-context.md
LEGACY_FORMAT  = /Users/brent/scripts/CB-Workspace/.claude/branch-context/[workspace]-[date]-[claude-name]-context.md
```
**⚠️ ALWAYS use absolute paths. The `.claude/` directory is at WORKSPACE ROOT, NOT inside individual project directories.**

**NOTE:** For resuming saved sessions by code, use `/resume` instead. `/claude-start` is for fresh sessions or name-based resume.

**📁 CONTEXT FILE RESOLUTION:**
Context files use task-based filenames (e.g., `acg-newsletter-37-voltaire-context.md`). Legacy date-based filenames are still supported.

**Resolution order:**

**1. If argument is a full file path:** Use it directly.

**2. If argument looks like a Claude name (e.g., `curie`, `tesla`):**
```bash
# Search for context file by Claude name in filename (task-based or date-based)
ls -t /Users/brent/scripts/CB-Workspace/.claude/branch-context/*-[name]-context.md 2>/dev/null | head -1
# Also check later/ directory
ls -t /Users/brent/scripts/CB-Workspace/.claude/branch-context/later/*-[name]-context.md 2>/dev/null | head -1
```
If found, use that file and inherit the identity. Works with both task-based (`acg-newsletter-37-voltaire-context.md`) and legacy date-based (`brent-2026-03-09-voltaire-context.md`) filenames.

**FALLBACK - If filename search finds nothing, search inside file contents:**
```bash
# Search for Identity header inside context files (handles legacy filenames)
# Sort by modification time (newest first) to pick the most recent match
grep -rl "Identity.*Claude-[Name]" /Users/brent/scripts/CB-Workspace/.claude/branch-context/*.md 2>/dev/null | xargs ls -t 2>/dev/null | head -1
# Also check later/ directory
grep -rl "Identity.*Claude-[Name]" /Users/brent/scripts/CB-Workspace/.claude/branch-context/later/*.md 2>/dev/null | xargs ls -t 2>/dev/null | head -1
```
If found via content search, use that file. If multiple matches, the newest file (by modification time) is used.

**AUTO-RENAME on fallback find:** When a file is found via content grep, rename it to include the Claude name so future lookups work by filename:
```bash
OLD_FILE="[found file path]"
NEW_FILE=$(echo "$OLD_FILE" | sed 's/-context\.md$/-[claude-name]-context.md/')
if [ ! -f "$NEW_FILE" ]; then
  mv "$OLD_FILE" "$NEW_FILE"
  echo "📝 Renamed context file to include Claude name: $(basename $NEW_FILE)"
fi
```

**3. If argument is a workspace shortcode (e.g., `brent`, `rd`):**
- List all matching files: `ls -t .claude/branch-context/[workspace]-$(date +%Y-%m-%d)-*-context.md`
- If ONE file found: use it automatically
- If MULTIPLE files found: show the list and ask user which to load
- If NONE found for today: fall back to `ls -t .claude/branch-context/[workspace]-*-context.md | head -5` and ask user
- Legacy files without Claude name (e.g., `brent-2026-02-05-context.md`) still work if matched

**How to detect argument type:**
- No argument → fresh session (use workspace detection from pwd)
- Contains `/` → file path
- Matches shortcode list (rd, brent, etc.) → workspace shortcode
- Otherwise → Claude name (try name-based lookup first)

---

**🆕 NO-ARGUMENT FLOW (Fresh Session):**

When `/claude-start` is called with NO arguments:

1. **Detect workspace from pwd** using the "Workspace Detection from pwd" reverse lookup above
2. **Pick a new Claude name** (do NOT try to resume an existing session)
3. **Validate name is unique AND claim it atomically:**
   ```bash
   NAMES_DIR="/Users/brent/scripts/CB-Workspace/.claude/local/names"
   mkdir -p "$NAMES_DIR"
   CHOSEN_NAME="Claude-[Name]"
   if ! mkdir "$NAMES_DIR/$CHOSEN_NAME" 2>/dev/null; then
     # Name is TAKEN! Pick another and retry mkdir. Repeat until one succeeds.
   fi
   date -u > "$NAMES_DIR/$CHOSEN_NAME/claimed"
   ```
   `mkdir` is atomic on macOS. If it fails, the name is taken. Keep picking until one succeeds.
5. **Create blank context file** so the session is immediately trackable:
   ```bash
   CONTEXT_DIR="/Users/brent/scripts/CB-Workspace/.claude/branch-context"
   SHORTCODE="[resolved-shortcode]"  # or "workspace" if at root
   DATE=$(date "+%Y-%m-%d")
   CLAUDE_NAME="[chosen-name]"  # lowercase, e.g., "shackleton"
   CONTEXT_FILE="$CONTEXT_DIR/${SHORTCODE}-${DATE}-${CLAUDE_NAME}-context.md"

   cat > "$CONTEXT_FILE" << EOF
   # Resume Instructions for Claude

   ## SESSION STATUS
   **Identity:** Claude-[Name]
   **Status:** ACTIVE
   **Last Saved:** (not yet saved)
   **Last Started:** $(date "+%Y-%m-%d %H:%M")

   ## IMMEDIATE SETUP
   1. **Directory:** \`$(pwd)\`
   2. **Branch:** (to be determined)

   ## WHAT YOU WERE WORKING ON
   Fresh session. Awaiting direction from user.

   ## NEXT ACTIONS (PRIORITY ORDER)
   1. Wait for user direction
   EOF
   ```
   This ensures every registered name has a corresponding context file from the start.
6. **Write `active-session.json`** with `name` field included
7. **Register in `active-sessions.json`** registry
8. **Skip context file loading** (this is a fresh session, no context to resume)
9. **Run Step 0 (date verification)** and **Step 1 (work log)** and **Step 2 (navigate)**
10. **Skip Steps 3-5** (no MCP context to load, no context file, no setup instructions)
11. **Go to Step 6** (present status, ask for direction)

**Display for fresh session:**
```
================================================
  Claude-[Name] | [SHORTCODE] | [purpose/direction]
================================================

📅 Today is: [YYYY-MM-DD] ([Day of week])
🚀 Fresh session started: [SHORTCODE] ([full-project-name])

⏱️ Day Status: [from work log]

📁 Working in: [SHORTCODE] ([path])
🌿 Branch: [current branch]

Ready for direction. What should I work on?
```

**SESSION PIN:** The `Claude-[Name] | [workspace] | [purpose]` header is pinned for the session. Display it:
- At session start (here)
- After returning from any long tool output that pushes it off screen
- When the user asks "who are you" or "what session is this"
- The purpose starts as "Fresh session" and updates when the user gives direction (e.g., "Sprint fix", "Content work", "eTail prep")

**For resumed sessions:** The pin format is the same. Pull the purpose from the context file's description or task summary.

---

**⚡ SIMPLE WORKFLOW:**
1. **Find instruction file:** Resolve using the context file resolution rules above
2. **Read instructions:** Load the handoff document
3. **Check for emergency flag:** If file contains "EMERGENCY CONTEXT SAVE", trigger deep recovery
4. **Follow instructions:** Execute exactly what the previous Claude documented
5. **Ask for direction:** Present status and wait for user guidance

**🚨 EMERGENCY CONTEXT RECOVERY MODE:**
When the context file contains "EMERGENCY CONTEXT SAVE" or "LOW CONTEXT SAVE", the previous session ran out of context and saved minimal information. **YOU MUST gather context from ALL available sources:**

1. **Announce Emergency Mode:**
   ```
   ⚠️ EMERGENCY CONTEXT DETECTED - Running deep context recovery...
   ```

2. **Query MCP Memory EXTENSIVELY (multiple searches):**
   ```
   # Search by project name
   mcp__memory__search_nodes: "cb-[project-name] session"

   # Search by branch name
   mcp__memory__search_nodes: "[branch-name]"

   # Search by recent sessions
   mcp__memory__search_nodes: "Session-2025 [project-name]"

   # Search for todos/pending work
   mcp__memory__search_nodes: "[project-name] todo pending"

   # Search for feature keywords from emergency file
   mcp__memory__search_nodes: "[keywords from WHAT WE WERE DOING section]"
   ```

3. **Read ALL related context files:**
   ```bash
   # List all context files for this project
   ls -la /Users/brent/scripts/CB-Workspace/.claude/branch-context/*[project-name]*.md

   # Read each one to gather full history
   ```

4. **Check for todo directories:**
   ```bash
   # Look for todo structure in project
   find [project-path]/todo -name "*.md" -type f 2>/dev/null

   # Read plan files if they exist
   cat [project-path]/todo/current/**/README.md
   cat [project-path]/todo/current/**/*-plan.md
   ```

5. **Cross-reference and merge:**
   - Combine information from ALL sources
   - MCP memory takes precedence for todo status
   - File-based context fills in details
   - Present COMPLETE picture to user

6. **Warn user about potential gaps:**
   ```
   ⚠️ Emergency recovery complete. Please verify this todo list is accurate:
   [merged todo list from all sources]

   If anything is missing, please correct me.
   ```

**📋 EXECUTION STEPS:**

**Step 0: Date Verification (MANDATORY FIRST STEP)**
1. **Run date command to get ACTUAL current date:**
   ```bash
   date "+%Y-%m-%d %A"
   ```
2. **Display and confirm:**
   ```
   📅 Today is: [YYYY-MM-DD] ([Day of week])
   📆 Current Year: [YYYY]
   ```
3. **CRITICAL: Use this date for ALL operations in this session**
   - API calls (Vista Social, etc.)
   - File dates
   - Log entries
   - Any date-based queries

**Why this exists:** Claude's training data can cause year confusion. This step ensures correct dates.

**Step 0.5: Session Status Check & Identity (MANDATORY)**

**Purpose:** Check if session is already in use, inherit identity from context file, track workspaces.

**1. Check Session Status in Context File:**

After locating the context file (Step 0), read the `## SESSION STATUS` section:
```bash
grep -A 4 "## SESSION STATUS" [context-file]
```

**Parse the status:**
- **Status: ACTIVE** → ⚠️ Warn user: "This session appears to be in use by another window. Continue anyway? (y/n)"
- **Status: SAVED** → Safe to resume
- **Status: LATER** → This is a parked session being resumed
- **No status section** → Legacy file, proceed normally

**2. Inherit Identity from Context File:**

If the context file has `**Identity:** Claude-[Name]`:
```bash
INHERITED_NAME=$(grep "^\*\*Identity:\*\*" [context-file] | sed 's/.*Claude-//' | tr -d ' ')
```

**If identity found:** Use it (e.g., if file says `Claude-Curie`, you become Claude-Curie)
**If no identity found:** Pick a new name (see examples below)

**Name examples (if picking new):**
- Scientists: Edison, Tesla, Curie, Darwin, Hopper, Turing, Lovelace, Feynman, Hawking
- Artists: DaVinci, Picasso, Mozart, Beethoven, VanGogh
- Explorers: Shackleton, Earhart, Armstrong, Cousteau
- Writers: Hemingway, Austen, Twain, Tolkien

**3. Register Name (whether inherited or new) using ATOMIC lock directory:**
```bash
NAMES_DIR="/Users/brent/scripts/CB-Workspace/.claude/local/names"
mkdir -p "$NAMES_DIR"
NAME="Claude-[Name]"
if ! mkdir "$NAMES_DIR/$NAME" 2>/dev/null; then
  # Name is TAKEN by another window! Pick a different name.
  # Try mkdir again with the new name. Repeat until one succeeds.
  # NEVER overwrite or remove another session's lock directory.
fi
# Write a timestamp so we know when this name was claimed
date -u > "$NAMES_DIR/$NAME/claimed"
```
**WHY:** The old JSON file approach had race conditions. Multiple Claudes would read the same file, pick the same "available" name, and overwrite each other. `mkdir` is atomic on macOS - it fails immediately if the directory exists, guaranteeing uniqueness.

**DO NOT use `active-claude-names.json` for registration.** It is deprecated. The names/ directory is the source of truth.

**4. Update Context File Status to ACTIVE:**

Use the Edit tool to update the context file:
- Change `**Status:** SAVED` → `**Status:** ACTIVE`
- Update `**Last Started:** [YYYY-MM-DD HH:MM]` with current timestamp

**5. Display Identity:**
```
🤖 I am: Claude-[Name] (inherited from context file)
```
or
```
🤖 I am: Claude-[Name] (new identity)
```

**6. Initialize session tracking file:**
```bash
SESSION_FILE="/Users/brent/scripts/CB-Workspace/.claude/local/active-session.json"
SHORTCODE="[resolved-shortcode]"
CLAUDE_NAME="[resolved-claude-name]"  # e.g., "Earhart", "Tesla" - from inherited or newly picked name
NOW=$(date -u +"%Y-%m-%dT%H:%M:%S")

cat > "$SESSION_FILE" << EOF
{
  "started": "$NOW",
  "name": "$CLAUDE_NAME",
  "startWorkspace": "$SHORTCODE",
  "workspacesTouched": ["$SHORTCODE"],
  "lastActivity": "$NOW"
}
EOF
```
**CRITICAL:** The `name` field MUST be written in ALL cases (fresh session, resume, inherited). This is what `/claude-save` reads when called without arguments.

**7. Display session initialized:**
```
🚀 Session started: [SHORTCODE] ([full-project-name])
📁 Tracking workspaces in: .claude/local/active-session.json
```

**Why this exists:** Enables identity inheritance across sessions, prevents session collisions, and tracks workspaces touched.

**8. Pin identity task (MANDATORY):**

Create an `in_progress` task that pins the Claude identity and session purpose to the task list. This stays visible for the entire session.

```
TaskCreate:
  subject: "Claude-[Name] | [workspace] - [brief purpose]"
  description: "Identity: Claude-[Name]. Workspace: [shortcode]. [1-line summary of what this session is working on]."
  activeForm: "[Brief description of current work]"

TaskUpdate:
  taskId: [the new task ID]
  status: in_progress
```

**Examples:**
- `Claude-Darwin | automated-testing - LinkedIn connection automation`
- `Claude-Faraday | rd - RAG/Vector Search centralization`
- `Claude-Curie | brent - Shoptalk bio + sprint token fix`

For fresh sessions where purpose is unknown yet, use:
- `Claude-[Name] | [workspace] - Awaiting direction`

Update the task description later when the work focus becomes clear.

**9. Load top work todos as tasks (MANDATORY):**

After creating the identity pin task, create **5-10 real work tasks** from the context file's TODO/NEXT ACTIONS/SPRINT ITEMS sections. These are the actual things to work on this session.

```
For each top work item from the context file:
  TaskCreate:
    subject: "[Brief task description]"
    description: "[Details from context file]"
    activeForm: "[Working on X]"
```

**Rules:**
- Pull from context file sections: `## NEXT ACTIONS`, `## SPRINT ITEMS`, `## TODO LIST STATE`, or similar
- Create 5-10 tasks (not more, not less unless fewer exist)
- Keep subjects short and actionable
- Do NOT mark any as in_progress yet (all start as `pending`)
- The identity pin (task #1) is the ONLY `in_progress` task at startup
- User will tell you which task to start

**For fresh sessions (no context file):** Skip this step. Ask user for direction first, then create tasks.

**Why this exists:** `/pin` displays the identity header + top todos. If no tasks are loaded, `/pin` shows nothing useful. Every resumed session must have real work visible in the task list from the start.

**Step 1: Read Work Log & Stamp Session Start**
1. **Get today's date** from Step 0 (format: YYYY-MM-DD)
2. **Read WORK-LOG.md:**
   ```
   WORK_LOG_PATH = /Users/brent/scripts/CB-Workspace/brent-workspace/ob-notes/Brent Notes/Dashboard/Daily/WORK-LOG.md
   ```
3. **If no entry for today:** Create today's section at the TOP of the log (after the header):
   ```markdown
   ## [YYYY-MM-DD]

   **Sprint:** S[N] | **Day:** [X]

   ### Sessions
   | Time | Claude | Workspace | Purpose |
   |------|--------|-----------|---------|
   | [HH:MM] | Claude-[Name] | [shortcode] | [Fresh session / Resumed: purpose] |

   ### Work Items
   | Time | Item | Type | Sprint Item? | Hrs |
   |------|------|------|-------------|-----|

   ### Daily Tally
   - **Hours worked:** TBD
   - **Sprint points moved:** 0 (planned) + 0 (unplanned)
   - **Admin hours:** 0
   ```
4. **If today's entry already exists:** Append a new row to the `### Sessions` table:
   ```
   | [HH:MM] | Claude-[Name] | [shortcode] | [Fresh session / Resumed: purpose] |
   ```
5. **Display Day Status:**
   ```
   ⏱️ Day Status: [date]
   - Sessions today: [count]
   - Work items logged: [count]
   ```

**Step 1.5: Write Contextual Work Items to Log (Resumed Sessions Only)**

When resuming from a context file (not a fresh session), add the key work items from the context to the Work Items table. This keeps the daily log as the central record.

1. **Parse context file** for `## WHAT YOU WERE WORKING ON` and `## NEXT ACTIONS` sections
2. **For each significant item**, add a row to the Work Items table:
   ```
   | [HH:MM] | [Item description from context] | sprint | [Sprint item ref if known] | - |
   ```
3. **Type tags:** `sprint` (maps to a backlog item), `unplanned` (real work not in sprint), `admin` (inbox, meetings, routine)
4. **Do NOT add items yet** - just prepare them. Hours get filled in as work happens or at /brent-finish.
5. **Display:**
   ```
   📋 Loaded [N] work items from context into today's log
   ```

**Why /claude-start and not /claude-save:** /claude-save should stay lean (just save context for resume). The daily log is populated when work starts, not when it ends. This prevents bloat in /claude-save and ensures the log is the single source of truth.

**Step 2: Navigate to Project (Using Directory Mapping)**
1. **Resolve project name to directory:** Use the WORKSPACE SHORTCODES mapping above
2. **Verify directory exists:** `ls [resolved-path]` - if fails, ASK USER
3. **Change to project directory:** `cd [resolved-path]`
4. **Confirm location:** Display "📁 Working in: [SHORTCODE] ([resolved-path])"
5. **Get current branch:** `git branch --show-current`

**🔄 WORKSPACE CHANGE TRACKING (During Session):**
When you `cd` to a DIFFERENT workspace during the session:
```bash
SESSION_FILE="/Users/brent/scripts/CB-Workspace/.claude/local/active-session.json"
NEW_SHORTCODE="[new-workspace-shortcode]"
NOW=$(date -u +"%Y-%m-%dT%H:%M:%S")

# Add to workspacesTouched if not already present
# Update lastActivity timestamp
# Use jq or manual JSON update
```
Display: "📁 Added workspace: [SHORTCODE] to session tracking"

**Step 2.5: Security Validation (Automatic)**

**Purpose**: Ensure project state is valid and secure before resuming work.

1. **Root Directory Validation:**
   ```bash
   # Verify we're in the CB-Workspace
   if [[ "$(pwd)" != /Users/brent/scripts/CB-Workspace/* ]]; then
     echo "⚠️ WARNING: Not in CB-Workspace directory"
     echo "Current: $(pwd)"
     echo "Expected: /Users/brent/scripts/CB-Workspace/[project]"
     # ASK USER before proceeding
   fi
   ```

2. **Debug Log Check:**
   - Check if active todo directory has scattered debug files
   - If found, notify user: "Found X scattered debug files. Run `/claude-debug` to consolidate."
   - Do NOT auto-consolidate - just report

3. **Security Status Check:**
   - Look for `.security-status` file in project root (created by `/claude-save --close`)
   - If previous session flagged security issues, display them
   - Quick scan for potential secrets in uncommitted files:
     ```bash
     git diff --name-only | xargs grep -l -E "(API_KEY|SECRET|TOKEN|PASSWORD)" 2>/dev/null
     ```
   - If found, warn user before proceeding

4. **Git State Validation:**
   ```bash
   # Check for uncommitted changes
   if [ -n "$(git status --porcelain)" ]; then
     echo "⚠️ Uncommitted changes detected:"
     git status --short
   fi

   # Check if branch is behind remote
   git fetch origin --quiet
   BEHIND=$(git rev-list HEAD..origin/$(git branch --show-current) --count 2>/dev/null)
   if [ "$BEHIND" -gt 0 ]; then
     echo "⚠️ Branch is $BEHIND commits behind remote"
   fi
   ```

**Step 3: Query Official MCP Memory Server FIRST (Primary Context Source)**
1. **Check Official MCP Memory Server availability:**
   Try to use `mcp__memory__search_nodes` with a simple test query to verify connectivity
   **⚠️ NEVER use `mcp__memory__read_graph` - it returns massive token dumps (~14k+) that fill context**

2. **Query Official MCP Memory Server for Context (Primary):**
   - **If MCP available - Query for recent work using TARGETED searches:**
     ```
     # Query for project-specific session data
     Use mcp__memory__search_nodes with: "Session project-name recent"

     # Query for specific session by date
     Use mcp__memory__search_nodes with: "Session-2025-11-17 project-name"

     # Query for current branch work
     Use mcp__memory__search_nodes with: "project-name branch-name"

     # Query for similar patterns across projects
     Use mcp__memory__search_nodes with: "current-task-keywords"
     ```

   - **If MCP has recent context:**
     - **Use knowledge graph as primary source** for session restoration
     - **Extract todo information** from session entities
     - **Identify current focus** from recent session observations
     - **Skip file-based search** unless needed for verification

   - **If MCP has no relevant context:**
     - Continue to file-based fallback search

   - **If MCP not available:**
     ```
     ⚠️ Official MCP Memory Server not available - falling back to file-based context
     💡 MCP should be configured in .mcp.json with @modelcontextprotocol/server-memory
     ```

**Step 4: File-Based Context & Emergency Detection**
1. **Locate context file:** Use the Context File Resolution rules from above. Files now use format `[workspace]-[date]-[claude-name]-context.md`. Legacy files without Claude name are still supported.
2. **Read instruction file:** Load the handoff document if it exists
3. **🚨 CHECK FOR EMERGENCY FLAG:**
   - If file contains "EMERGENCY CONTEXT SAVE" or "LOW CONTEXT SAVE":
     - **STOP normal flow** and execute **EMERGENCY CONTEXT RECOVERY MODE** (see above)
     - Query MCP memory extensively with multiple searches
     - Read ALL related context files for the project
     - Check todo directories
     - Merge all sources before continuing
   - If NOT an emergency file, continue normal flow
4. **Parse instructions:** Extract setup steps, current state, todos, next actions
5. **Todo directory inventory check:** Look for todo directory structure:
   ```bash
   # Expected 7 files exactly:
   # 1. README.md  2. [branch-name]-plan.md  3. progress.log
   # 4. debug.log  5. notes.md  6. architecture-map.md  7. user-documentation.md
   ```

**Step 5: Execute Setup Instructions**
1. **Follow setup from context source:** Execute commands from OpenMemory or file-based instructions
2. **Verify expected state:** Confirm git status, processes, etc. match expectations
   - **Docker containers check:** Use `docker ps` to verify containers are running
   - **If containers not found:** ASK USER immediately - do not troubleshoot Docker issues
3. **Verify README.md Branch Reference:** If todo directory found, check README.md shows correct branch
   ```bash
   # Get current branch
   CURRENT_BRANCH=$(git branch --show-current)

   # Check if README.md shows correct branch
   if [ -f "todo/current/[category]/[task]/README.md" ]; then
     if ! grep -q "**Branch:** $CURRENT_BRANCH" "todo/current/[category]/[task]/README.md"; then
       echo "⚠️ README.md shows incorrect branch name - needs update"
       # Update the branch line in README.md
       sed -i.bak "s/\*\*Branch:\*\* .*/\*\*Branch:\*\* $CURRENT_BRANCH/" "todo/current/[category]/[task]/README.md"
       echo "✅ Updated README.md to show current branch: $CURRENT_BRANCH"
     fi
   fi
   ```
4. **Architecture Validation (CB Projects Only):** Validate architecture map is current
   - **Skip for external projects:** cb-shopify, cb-junogo, astro-sites (use Gadget/external docs)
   - **For CB projects:** Check if architecture-map.md needs updating
   - **If outdated:** Recommend running `/update-architecture` to document changes
   - **If current:** Proceed with session resume
5. **Restore TodoWrite:** Set up todos from MCP memory context or instruction file

**Step 5.5: Skip Deferred Questions (Handled by /brent-start)**
1. **If context file has `## DEFERRED QUESTIONS` section - DO NOT ASK THEM**
2. **Deferred questions are handled by `/brent-start`**, not `/claude-start`
3. `/claude-start` is for resuming technical work only - no time tracking or daily planning questions
4. **Continue directly to Step 6**

**Why this separation exists:** `/claude-start` = resume work. `/brent-start` = daily planning + time tracking. Don't mix them.

**Step 6: Present Status and Wait**
1. **Show resume summary:** Display what was restored and current state
2. **Present MCP memory insights:** Surface relevant session entities and cross-project patterns
3. **Present next actions:** Show priority actions from memory or instruction file
4. **Ask for direction:** "I've restored your session. Which task should I work on first?"

**🎯 KEY PRINCIPLES:**
- **Official MCP first** - Use knowledge graph memory as primary context source
- **File-based fallback** - Only use context files when MCP has no relevant info
- **Follow context exactly** - Don't improvise, use documented instructions
- **Ask user for guidance** after restoring the session

**📄 INSTRUCTION FILE FORMAT:**
The context file contains everything needed to resume:
```markdown
# Resume Instructions for Claude

## IMMEDIATE SETUP
[Exact commands to run]

## WHAT YOU WERE WORKING ON
[Task description]

## CURRENT STATE
[File states, processes, last command]

## TODO LIST STATE
[TodoWrite items with status]

## DEFERRED QUESTIONS (Handled by /brent-start, NOT /claude-start)
[Questions saved for daily planning - SKIP these in /claude-start]
1. **Time tracking:** "How long did you work on [task name]?"
2. **Task status:** "Is [task name] complete or continuing?"
NOTE: These are for /brent-start daily workflow, not session resume.

## NEXT ACTIONS (PRIORITY ORDER)
[Exact next steps]

## VERIFICATION COMMANDS
[How to check everything works]
```

**🔄 EXPECTED WORKFLOW:**
1. Work on project: Official MCP memory server automatically captures context during development
2. Save session: `/claude-save <project>` → Stores to MCP memory + file backup
3. Start session: `/claude-start <project>` → Queries MCP memory first, file fallback if needed
4. Result: **Perfect resume** with knowledge graph context from official MCP

**✅ SUCCESS CRITERIA:**
- Official MCP Memory Server queried first for intelligent context
- Relevant session entities retrieved and presented to user
- Setup commands executed from MCP memory or file context
- TodoWrite restored from MCP memory or instruction file
- User presented with knowledge graph insights and next actions
- **Zero information loss** with multi-window safe context bridging

**🚨 CRITICAL: NO AUTOMATIC ACTIONS**
- **READ ONLY**: Follow instructions but don't execute work automatically
- **VERIFY FIRST**: Confirm the expected state matches reality
- **ASK USER**: Always ask which task to work on after restoring session
- **NO IMPROVISATION**: Stick to exactly what's in the instruction file

**📋 COMMUNICATION REMINDER**: Do not use repetitive agreement phrases like "You're absolutely right!" - violations go to the violation log. Use brief acknowledgment then focus on the actual work.

**🐳 DOCKER ENVIRONMENT REMINDER**: Only look for Docker containers (`docker ps`). Do not troubleshoot missing containers - ASK USER immediately for guidance on starting the development environment.

**🧠 OFFICIAL MCP MEMORY SERVER BEST PRACTICES:**
- **✅ USE**: `mcp__memory__search_nodes` for targeted queries - efficient and focused
- **❌ AVOID**: `mcp__memory__read_graph` - returns massive token dumps (~14k+) that fill context quickly
- **Targeted Search Examples**:
  - "Session-2025-11-17-keyword" (specific session)
  - "project-name recent" (recent work on project)
  - "authentication issues" (topic-based search)
  - "branch-name debugging" (branch-specific work)
- **Context Efficiency**: Targeted searches return clean, relevant results vs full graph dump
- **Multi-Window Safe**: Knowledge graph approach prevents SQLite locking issues
- **Benefits**: Cross-session continuity, pattern discovery, intelligent context bridging

---

**Step 7: Display Active Windows & Context Files (FINAL STEP - MANDATORY)**

After all setup is complete, display the current active windows AND context files so the user can verify names, catch duplicates, and see who has saved state.

```bash
NAMES_DIR="/Users/brent/scripts/CB-Workspace/.claude/local/names"
CONTEXT_DIR="/Users/brent/scripts/CB-Workspace/.claude/branch-context"

echo "== ACTIVE WINDOWS =="
ls -1 "$NAMES_DIR" 2>/dev/null | grep "^Claude-"

echo ""
echo "== CONTEXT FILES =="
ls -lt "$CONTEXT_DIR"/*.md 2>/dev/null | grep -v "main-context\|master-context\|README"
```

**Display format:**
```
== ACTIVE WINDOWS ==
  1. Claude-[Name] (controller)
  2. Claude-[Name]
  3. Claude-[Name]
  ...
Total: [N] names registered

== CONTEXT FILES ==
  [date] [filename] (Claude-[Name])
  [date] [filename] (Claude-[Name])
  ...
Total: [N] context files

WARNINGS:
- [Name] has NO context file (never saved)
- [Name] appears [X] times in names registry (duplicate!)
- Context file [file] has no matching registered name (orphan)
```

**Cross-reference names vs files:** Compare the names registry against context files. Flag:
1. **Registered names with no context file** - that session hasn't saved yet
2. **Duplicate names** - two windows picked the same name
3. **Context files with no matching registered name** - orphan file, session may have closed

**Tip line:** "If you see duplicates or orphans, rename with /pin or archive the orphan."

**Why this exists:** With multiple windows open, duplicate Claude names cause confusion in comms, context files, and session tracking. Showing both the roster AND context files at every session start gives the user a complete picture of session state. This was added after Violation #130 where the controller session archived active context files.
