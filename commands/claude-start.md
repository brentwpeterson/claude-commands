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

**Step 2: Query OpenMemory FIRST (Primary Context Source)**
3. **Check OpenMemory server availability:**
   ```bash
   curl -s http://localhost:8080/health 2>/dev/null
   ```

4. **Query OpenMemory for Context (Primary):**
   - **If server available - Query for recent work:**
     ```bash
     cd /Users/brent/scripts/CB-Workspace/cb-memory-system

     # Query for project-specific recent work
     ./scripts/query-memory.sh "project:[project-name] recent work" 5

     # Query for current branch work
     ./scripts/query-memory.sh "project:[project-name] branch:[branch-name]" 3

     # Query for similar problems/patterns
     ./scripts/query-memory.sh "[current-branch-keywords]" 5
     ```

   - **If OpenMemory has recent context:**
     - **Use memory as primary source** for session restoration
     - **Extract todo information** from memory results
     - **Identify current focus** from recent memories
     - **Skip file-based search** unless needed for verification

   - **If OpenMemory has no relevant context:**
     - Continue to file-based fallback search

   - **If server not available:**
     ```
     ⚠️ OpenMemory server not running - falling back to file-based context
     💡 Start server: cd /Users/brent/scripts/OpenMemory/backend && npm run dev
     ```

**Step 3: File-Based Context Fallback (If Needed)**
5. **IF no OpenMemory context found, locate context file:** `.claude/branch-context/[branch-name]-context.md`
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
11. **Architecture Validation (CB Projects Only):** Validate architecture map is current
   - **Skip for external projects:** cb-shopify, cb-junogo, astro-sites (use Gadget/external docs)
   - **For CB projects:** Check if architecture-map.md needs updating
   - **If outdated:** Recommend running `/update-architecture` to document changes
   - **If current:** Proceed with session resume
12. **Restore TodoWrite:** Set up todos from OpenMemory context or instruction file

**Step 5: Present Status and Wait**
13. **Show resume summary:** Display what was restored and current state
14. **Present OpenMemory insights:** Surface relevant memories and cross-project patterns
15. **Present next actions:** Show priority actions from memory or instruction file
16. **Ask for direction:** "I've restored your session. Which task should I work on first?"

**🎯 KEY PRINCIPLES:**
- **OpenMemory first** - Use intelligent memory as primary context source
- **File-based fallback** - Only use context files when memory has no relevant info
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
1. Work on project: OpenMemory automatically captures context during development
2. Save session: `/claude-save <project>` → Stores to memory + file backup
3. Start session: `/claude-start <project>` → Queries OpenMemory first, file fallback if needed
4. Result: **Perfect resume** with intelligent context from memory system

**✅ SUCCESS CRITERIA:**
- OpenMemory queried first for intelligent context
- Relevant memories retrieved and presented to user
- Setup commands executed from memory or file context
- TodoWrite restored from memory or instruction file
- User presented with memory insights and next actions
- **Zero information loss** with intelligent context bridging

**🚨 CRITICAL: NO AUTOMATIC ACTIONS**
- **READ ONLY**: Follow instructions but don't execute work automatically
- **VERIFY FIRST**: Confirm the expected state matches reality
- **ASK USER**: Always ask which task to work on after restoring session
- **NO IMPROVISATION**: Stick to exactly what's in the instruction file

**📋 COMMUNICATION REMINDER**: Do not use repetitive agreement phrases like "You're absolutely right!" - violations go to the violation log. Use brief acknowledgment then focus on the actual work.

**🐳 DOCKER ENVIRONMENT REMINDER**: Only look for Docker containers (`docker ps`). Do not troubleshoot missing containers - ASK USER immediately for guidance on starting the development environment.
