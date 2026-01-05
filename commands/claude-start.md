Claude Session Start - Read Resume Instructions and Execute

🚨 **CRITICAL COMMUNICATION RULE**: Never say "You're absolutely right!" or similar repetitive agreement phrases ("Perfect!", "Exactly!", "That's completely right!"). Use brief acknowledgment instead ("Got it.", "I understand.") then proceed with actual response. Violations will be logged.

🚨 **CRITICAL DEVELOPMENT ENVIRONMENT RULE**: This project uses DOCKER containers for development. DO NOT look for local dev servers (npm, python, etc.). ALL development happens in Docker containers. If you can't find the expected Docker containers running, ASK THE USER immediately instead of spending time troubleshooting. The user will guide you to start the correct containers.

**USAGE:**
- `/claude-start <project>` - Read instruction file from save command and resume exactly where left off

**Arguments**:
- `<project>` (required): Project name (used to find context file)

**🗂️ PROJECT-TO-DIRECTORY MAPPING:**
```
| Project Name   | Directory Path                                          |
|----------------|--------------------------------------------------------|
| requestdesk    | /Users/brent/scripts/CB-Workspace/cb-requestdesk       |
| astro-sites    | /Users/brent/scripts/CB-Workspace/astro-sites          |
| shopify        | /Users/brent/scripts/CB-Workspace/cb-shopify           |
| wordpress      | /Users/brent/scripts/CB-Workspace/cb-wordpress         |
| magento        | /Users/brent/scripts/CB-Workspace/cb-magento           |
| junogo         | /Users/brent/scripts/CB-Workspace/cb-junogo            |
| memory-system  | /Users/brent/scripts/CB-Workspace/cb-memory-system     |
| jobs           | /Users/brent/scripts/CB-Workspace/jobs                 |
```

**🚨 CRITICAL: Always use this mapping to resolve project names to full paths!**
- If project name not in mapping, ASK USER for the correct path
- NEVER guess or assume directory locations

**🎯 PURPOSE:**
Read the instruction file created by `/claude-save` or `/claude-save-fast` and follow those exact instructions

**🗂️ CRITICAL PATH DEFINITION:**
```
WORKSPACE_ROOT = /Users/brent/scripts/CB-Workspace
CONTEXT_DIR    = /Users/brent/scripts/CB-Workspace/.claude/branch-context/
CONTEXT_FILE   = /Users/brent/scripts/CB-Workspace/.claude/branch-context/[branch-name]-context.md
```
**⚠️ ALWAYS use absolute paths. The `.claude/` directory is at WORKSPACE ROOT, NOT inside individual project directories.**

**⚡ SIMPLE WORKFLOW:**
1. **Find instruction file:** `/Users/brent/scripts/CB-Workspace/.claude/branch-context/[current-branch]-context.md`
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

**Step 1: Read Work Log for Day Context**
1. **Get today's date** from Step 0 (format: YYYY-MM-DD)
2. **Read WORK-LOG.md:**
   ```
   WORK_LOG_PATH = /Users/brent/scripts/CB-Workspace/brent-workspace/ob-notes/Brent Notes/Dashboard/Daily/WORK-LOG.md
   ```
3. **Parse today's entry** - Look for `## [today's date]` section
4. **Extract timer status:**
   - Start time (if present)
   - End time (if present)
   - Hours worked (if present)
   - Accomplishments listed
5. **Display Day Status:**
   ```
   ⏱️ Day Status: [date]
   - Timer: [Started at X:XX AM | Not started | Completed X.X hrs]
   - Accomplishments: [count] items logged
   ```
6. **If no entry for today:** Display "⏱️ Timer not started today - no WORK-LOG entry for [date]"

**Step 2: Navigate to Project (Using Directory Mapping)**
1. **Resolve project name to directory:** Use the PROJECT-TO-DIRECTORY MAPPING above
2. **Verify directory exists:** `ls [resolved-path]` - if fails, ASK USER
3. **Change to project directory:** `cd [resolved-path]`
4. **Confirm location:** Display "📁 Working in: [resolved-path]"
5. **Get current branch:** `git branch --show-current`

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
1. **Locate context file:** `/Users/brent/scripts/CB-Workspace/.claude/branch-context/[branch-name]-context.md`
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

**Step 5.5: Handle Deferred Questions (if present)**
1. **Check context file for `## DEFERRED QUESTIONS` section**
2. **If found, ASK these questions NOW** (we have fresh context):
   - Time tracking: "How long did you work on [task]?"
   - Task status: "Is [task] complete or continuing?"
3. **Log the answers:**
   - Update active-task.md with time entry
   - Update sprint scorecard if task complete
4. **Then continue to Step 6**

**Why deferred questions exist:** The previous `/claude-save` ran low on context and couldn't afford to ask questions. Now we have fresh context to handle them.

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

## DEFERRED QUESTIONS (Ask on /claude-start)
[Questions that couldn't be asked during save - ASK THESE FIRST]
1. **Time tracking:** "How long did you work on [task name]?"
   - Task: [task name]
   - Date: [date]
2. **Task status:** "Is [task name] complete or continuing?"

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
