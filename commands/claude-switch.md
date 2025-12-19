# /claude-switch Command

**Purpose**: Smart branch switching with context preservation, MCP memory storage, security validation, and automatic sync with master.

## Usage
```
/claude-switch <branch-name>
/claude-switch master              # Switch to master for new feature work
```

## Examples
```
/claude-switch feature/api-integration
/claude-switch fix/auth-bug
/claude-switch master
```

## What This Command Does

**🔄 SMART BRANCH SWITCHING WITH CONTEXT & MCP MEMORY**

This command provides intelligent branch switching that:
- **Saves current context to MCP memory** (knowledge graph storage)
- Preserves current branch context to file before switching
- Validates target branch exists (offers to create if not)
- Checks for uncommitted changes and handles appropriately
- Syncs target branch with master if behind
- **Loads target branch context from MCP memory**
- Loads target branch context file after switching
- **Lists available MCP servers for the branch**
- Performs security scan on the target branch

## Detailed Workflow

### Phase 0: MCP Server Validation
0. **Verify MCP Servers Available**
   ```bash
   # Check workspace MCP configuration
   cat /Users/brent/scripts/CB-Workspace/.mcp.json
   ```

   - Display available MCP servers:
     ```
     🔌 MCP SERVERS AVAILABLE:
     ✅ memory - @modelcontextprotocol/server-memory (knowledge graph)
        Storage: /Users/brent/scripts/CB-Workspace/.claude/cb-workspace-memory.json

     MCP servers will be used for context persistence across branch switches.
     ```

### Phase 1: Pre-Switch Validation
1. **Check Current State**
   ```bash
   git status --porcelain
   ```
   - If uncommitted changes exist:
     ```
     ⚠️ UNCOMMITTED CHANGES DETECTED
     
     Modified files:
     - backend/api/users.py
     - frontend/src/components/UserList.jsx
     
     Options:
     [S] Stash changes and switch
     [C] Commit changes first
     [D] Discard changes (dangerous!)
     [A] Abort switch
     
     Choice [S/c/d/a]: _
     ```

2. **Security Scan Current Branch**
   - Quick scan for any security issues to document
   - Add findings to branch context if any exist

3. **Save Current Branch Context (File + MCP Memory)**
   - Use same logic as `/claude-save` command
   - Create/update: `.claude/branch-context/[branch-name]-context.md`
   - Include:
     - Current work status and todo directory path
     - Security findings
     - Any in-progress tasks from TodoWrite
     - Recovery instructions with exact file paths

   - **Store to MCP Memory** (knowledge graph):
     ```
     # Use mcp__memory__create_entities to store session context
     Entity Name: "Session-[DATE]-[BRANCH]-switch-out"
     Entity Type: "branch_context"
     Observations:
       - "Branch: [current-branch]"
       - "Project: [detected-project-name]"
       - "Status: [work-status-summary]"
       - "Todo Directory: [path-to-todo]"
       - "Last Commit: [commit-hash] - [commit-message]"
       - "Uncommitted Changes: [yes/no]"
       - "MCP Servers: memory (knowledge graph)"
       - "Switch Reason: Switching to [target-branch]"
     ```

### Phase 2: Branch Validation & Creation
4. **Check Target Branch**
   ```bash
   git branch -a | grep -E "(^|\s)${branch_name}($|\s)"
   ```
   
   - If branch doesn't exist locally or remotely:
     ```
     ⚠️ BRANCH NOT FOUND: feature/api-integration
     
     Would you like to:
     [C] Create new branch from current HEAD
     [M] Create new branch from master
     [O] Create from origin/master (fetch first)
     [A] Abort switch
     
     Choice [C/m/o/a]: _
     ```

   - If exists only remotely:
     ```
     📡 REMOTE BRANCH FOUND: origin/feature/api-integration
     
     Creating local tracking branch...
     ```

### Phase 3: Execute Switch
5. **Perform Switch**
   ```bash
   # If stashing was chosen:
   git stash push -m "claude-switch: Stashing for branch switch to ${branch_name}"
   
   # Switch to branch:
   git checkout ${branch_name}
   
   # If creating new branch:
   git checkout -b ${branch_name}
   ```

6. **Check Sync with Master**
   ```bash
   git fetch origin master
   BEHIND=$(git rev-list --count HEAD..origin/master)
   ```
   
   - If behind master:
     ```
     📊 BRANCH STATUS: ${BEHIND} commits behind master
     
     Would you like to:
     [M] Merge master into ${branch_name} (recommended)
     [R] Rebase onto master
     [C] Continue without syncing
     [V] View differences first
     
     Choice [M/r/c/v]: _
     ```

### Phase 4: Post-Switch Setup
7. **Load Target Branch Context (MCP Memory + File)**

   - **Query MCP Memory first** for recent context:
     ```
     # Use mcp__memory__search_nodes to find branch context
     Query: "[target-branch-name]" or "project:[project-name]"

     If found, display:
     🧠 MCP MEMORY CONTEXT FOUND:
     - Entity: Session-2025-12-19-feature-api-integration
     - Last saved: [timestamp]
     - Status: [work-status]
     - Key observations loaded
     ```

   - Check for `.claude/branch-context/[branch-name]-context.md`
   - If exists, display summary:
     ```
     📂 BRANCH CONTEXT LOADED: features/api-integration

     Last worked: 2 days ago
     Status: In progress - implementing user endpoints
     Security: ✅ Clean (last scan: 2025-11-01)
     Todo Directory: /todo/current/features/api-integration/

     Recent work:
     - Added user CRUD endpoints
     - Implemented authentication middleware
     - TODO: Add rate limiting
     ```

   - **Display MCP Servers for this branch**:
     ```
     🔌 MCP SERVERS AVAILABLE FOR THIS BRANCH:
     ✅ memory - Knowledge graph storage (active)
        - Use mcp__memory__* tools for context operations
        - Storage: cb-workspace-memory.json

     💡 TIP: Use mcp__memory__search_nodes to find related work
     ```

8. **Update README.md Branch Reference**
   - Find todo directory associated with target branch
   - Update README.md to show current branch name:
   ```bash
   # Get current branch (should be target branch now)
   CURRENT_BRANCH=$(git branch --show-current)

   # Find todo directory for this branch
   TODO_DIR=$(find todo/current -type d -name "*${CURRENT_BRANCH##*/}*" -o -name "*$(echo ${CURRENT_BRANCH} | sed 's|.*/||')*" 2>/dev/null | head -1)

   if [ -n "$TODO_DIR" ] && [ -f "$TODO_DIR/README.md" ]; then
     # Update branch reference in README.md
     sed -i.bak "s/\*\*Branch:\*\* .*/\*\*Branch:\*\* $CURRENT_BRANCH/" "$TODO_DIR/README.md"
     echo "✅ Updated README.md to show current branch: $CURRENT_BRANCH"
   fi
   ```

9. **Security Scan New Branch**
   ```
   🔒 SECURITY SCAN: features/api-integration
   [████████████████████] 100% - Scanning for security issues

   ✅ No critical issues
   ⚠️ 1 warning: Hardcoded localhost URL in config.py:45
   ```

10. **Update TodoWrite**
    - Clear current todos (they belong to previous branch)
    - Load todos from branch context if available
    - Or start fresh if new branch

11. **Apply Stashed Changes (if applicable)**
    ```bash
    # If stash was created:
    git stash pop
    ```
    - Handle any merge conflicts if they occur

### Phase 5: Summary & Next Steps
12. **Present Switch Summary**
    ```
    ✅ SUCCESSFULLY SWITCHED TO: features/api-integration

    📊 Branch Status:
    - Type: Features branch
    - Commits ahead of master: 3
    - Commits behind master: 0 (synced)
    - Last commit: 2 hours ago

    🔒 Security Status: Clean

    🧠 MCP Memory:
    - Context saved from: enhancement/shopify-rag-product-sync
    - Context loaded for: features/api-integration
    - Entity: Session-2025-12-19-feature-api-integration

    🔌 MCP Servers Active:
    - memory (knowledge graph) ✅

    📋 Loaded Context:
    - Todo Directory: /todo/current/features/api-integration/
    - Previous work: Implementing API integration
    - Next steps: Add error handling and retry logic

    Ready to continue work on this branch!
    ```

## Special Cases

### Switching to Master
When switching to master, offer to:
- Pull latest changes from origin/master
- Clean up merged branches
- Show deployment status
- **Offer next steps for new work:**
  ```
  🏠 SWITCHED TO MASTER

  What would you like to do next?
  [N] Start new feature branch (/create-branch)
  [B] Create bugfix branch (/create-bugfix)
  [A] Audit existing branches (/project:audit-branches)
  [S] Stay on master

  Choice [N/b/a/s]: _
  ```

### Switching from Dirty State
If the working directory has changes:
- Intelligently determine if changes belong to current or target branch
- Offer to carry changes over if they're relevant
- Warn about potential conflicts

### Creating New Feature Branch
When creating a new branch:
- Suggest conventional naming (features/, fixes/, infrastructure/, refactor/, debug/)
- Ensure branch starts from latest master
- Initialize branch context file
- Set up initial TodoWrite tasks
- Reference appropriate `/create-branch` or `/create-bugfix` for full documentation setup

## Integration with Other Commands

- **Before `/claude-save`**: Use `/claude-switch` to change branches without full session save
- **After `/claude-start`**: Use if you realize you're on wrong branch
- **With `/claude-complete`**: Complete current branch, then switch to next task
- **With `/create-branch`**: Alternative for existing branches
- **With `/create-bugfix`**: Switch after creating bug fix branches

## Error Handling

**Merge Conflicts During Sync**
```
⚠️ MERGE CONFLICTS DETECTED

Conflicts in:
- backend/api/config.py
- frontend/package.json

Options:
[R] Resolve conflicts interactively
[A] Abort merge and stay on current branch
[S] Skip sync for now

Choice [R/a/s]: _
```

**Network Issues**
```
⚠️ UNABLE TO FETCH FROM ORIGIN

Cannot check if branch is behind master.
Continue with local branch state? [Y/n]: _
```

## Security Considerations

- Never switch branches with exposed API keys or credentials
- Always scan target branch before starting work
- Document any security debt in branch context
- Warn if switching away from branch with security issues

## MCP Memory Integration

### Available MCP Tools
When working with branch context, these MCP tools are available:

| Tool | Purpose |
|------|---------|
| `mcp__memory__create_entities` | Store new session/branch context |
| `mcp__memory__search_nodes` | Find previous work on branch/project |
| `mcp__memory__add_observations` | Add notes to existing context |
| `mcp__memory__read_graph` | View all stored context |

### Entity Naming Convention
- **Session context**: `Session-YYYY-MM-DD-[branch-name]-[action]`
- **Branch context**: `Branch-[project]-[branch-name]`
- **Project context**: `Project-[project-name]-[topic]`

### Example MCP Memory Storage
```javascript
// Stored on switch-out from enhancement/shopify-rag-product-sync
{
  "name": "Session-2025-12-19-shopify-rag-switch-out",
  "entityType": "branch_context",
  "observations": [
    "Branch: enhancement/shopify-rag-product-sync",
    "Project: cb-requestdesk",
    "Status: iter-2 deployed, awaiting production testing",
    "Todo: /todo/current/enhancement/shopify-rag-product-sync/",
    "Last commit: bfa73ecb - Prepare iter-2 deployment",
    "MCP Servers: memory (knowledge graph)",
    "Deployment tags: matrix-v0.33.8-shopify-rag-iter-1, matrix-v0.33.8-shopify-rag-iter-2"
  ]
}
```

### Querying Previous Context
To find context when returning to a branch:
```
mcp__memory__search_nodes with query: "shopify-rag" or "cb-requestdesk"
```

## Success Criteria

✅ Smooth branch switching with zero data loss
✅ Context preserved and restored accurately
✅ **MCP memory stores context for cross-session persistence**
✅ **MCP servers listed and validated**
✅ Security validated on both source and target branches
✅ Master sync handled intelligently
✅ Uncommitted changes handled safely
✅ Clear communication throughout process