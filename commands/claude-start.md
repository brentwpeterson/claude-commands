Claude Session Start - Read Resume Instructions and Execute

🚨 **CRITICAL COMMUNICATION RULE**: Never say "You're absolutely right!" or similar repetitive agreement phrases ("Perfect!", "Exactly!", "That's completely right!"). Use brief acknowledgment instead ("Got it.", "I understand.") then proceed with actual response. Violations will be logged.

🚨 **CRITICAL DEVELOPMENT ENVIRONMENT RULE**: This project uses DOCKER containers for development. DO NOT look for local dev servers (npm, python, etc.). ALL development happens in Docker containers. If you can't find the expected Docker containers running, ASK THE USER immediately instead of spending time troubleshooting. The user will guide you to start the correct containers.

**USAGE:**
- `/claude-start <project>` - Read instruction file from save command and resume exactly where left off

**Arguments**:
- `<project>` (required): Project name (used to find context file)

**🎯 PURPOSE:**
Read the instruction file created by `/claude-save` or `/claude-save-fast` and follow those exact instructions

**⚡ SIMPLE WORKFLOW:**
1. **Find instruction file:** `.claude/branch-context/[current-branch]-context.md`
2. **Read instructions:** Load the handoff document
3. **Follow instructions:** Execute exactly what the previous Claude documented
4. **Ask for direction:** Present status and wait for user guidance

**📋 EXECUTION STEPS:**

**Step 1: Navigate to Project**
1. **Change to project directory:** `cd [project]`
2. **Get current branch:** `git branch --show-current`

**Step 2: Query Official MCP Memory Server FIRST (Primary Context Source)**
3. **Check Official MCP Memory Server availability:**
   Try to use `mcp__memory__read_graph` tool to test connectivity

4. **Query Official MCP Memory Server for Context (Primary):**
   - **If MCP available - Query for recent work:**
     ```
     # Query for project-specific session data
     Use mcp__memory__search_nodes with: "project [project-name] session"

     # Query for current branch work
     Use mcp__memory__search_nodes with: "[project-name] [branch-name]"

     # Query for similar patterns across projects
     Use mcp__memory__search_nodes with: "[current-branch-keywords]"
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

**Step 3: File-Based Context Fallback (If Needed)**
5. **IF no MCP context found, locate context file:** `.claude/branch-context/[branch-name]-context.md`
6. **Read instruction file:** Load the handoff document if it exists
7. **Parse instructions:** Extract setup steps, current state, todos, next actions
8. **Todo directory inventory check:** Look for todo directory structure:
   ```bash
   # Expected 7 files exactly:
   # 1. README.md  2. [branch-name]-plan.md  3. progress.log
   # 4. debug.log  5. notes.md  6. architecture-map.md  7. user-documentation.md
   ```

**Step 4: Execute Setup Instructions**
9. **Follow setup from context source:** Execute commands from OpenMemory or file-based instructions
10. **Verify expected state:** Confirm git status, processes, etc. match expectations
   - **Docker containers check:** Use `docker ps` to verify containers are running
   - **If containers not found:** ASK USER immediately - do not troubleshoot Docker issues
11. **Verify README.md Branch Reference:** If todo directory found, check README.md shows correct branch
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
12. **Architecture Validation (CB Projects Only):** Validate architecture map is current
   - **Skip for external projects:** cb-shopify, cb-junogo, astro-sites (use Gadget/external docs)
   - **For CB projects:** Check if architecture-map.md needs updating
   - **If outdated:** Recommend running `/update-architecture` to document changes
   - **If current:** Proceed with session resume
13. **Restore TodoWrite:** Set up todos from MCP memory context or instruction file

**Step 5: Present Status and Wait**
14. **Show resume summary:** Display what was restored and current state
15. **Present MCP memory insights:** Surface relevant session entities and cross-project patterns
16. **Present next actions:** Show priority actions from memory or instruction file
17. **Ask for direction:** "I've restored your session. Which task should I work on first?"

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
