# /claude-switch Command

**Purpose**: Smart branch switching with context preservation, security validation, and automatic sync with master.

## Usage
```
/claude-switch <branch-name>
```

## Examples
```
/claude-switch feature/api-integration
/claude-switch fix/auth-bug
/claude-switch master
```

## What This Command Does

**🔄 SMART BRANCH SWITCHING WITH CONTEXT**

This command provides intelligent branch switching that:
- Preserves current branch context before switching
- Validates target branch exists (offers to create if not)
- Checks for uncommitted changes and handles appropriately
- Syncs target branch with master if behind
- Loads target branch context after switching
- Performs security scan on the target branch

## Detailed Workflow

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

3. **Save Current Branch Context**
   - Use same logic as `/claude-save` command
   - Create/update: `.claude/branch-context/[branch-name]-context.md`
   - Include:
     - Current work status and todo directory path
     - Security findings
     - Any in-progress tasks from TodoWrite
     - Recovery instructions with exact file paths

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
7. **Load Target Branch Context**
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

8. **Security Scan New Branch**
   ```
   🔒 SECURITY SCAN: features/api-integration
   [████████████████████] 100% - Scanning for security issues

   ✅ No critical issues
   ⚠️ 1 warning: Hardcoded localhost URL in config.py:45
   ```

9. **Update TodoWrite**
   - Clear current todos (they belong to previous branch)
   - Load todos from branch context if available
   - Or start fresh if new branch

10. **Apply Stashed Changes (if applicable)**
    ```bash
    # If stash was created:
    git stash pop
    ```
    - Handle any merge conflicts if they occur

### Phase 5: Summary & Next Steps
11. **Present Switch Summary**
    ```
    ✅ SUCCESSFULLY SWITCHED TO: features/api-integration

    📊 Branch Status:
    - Type: Features branch
    - Commits ahead of master: 3
    - Commits behind master: 0 (synced)
    - Last commit: 2 hours ago

    🔒 Security Status: Clean

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

## Success Criteria

✅ Smooth branch switching with zero data loss
✅ Context preserved and restored accurately  
✅ Security validated on both source and target branches
✅ Master sync handled intelligently
✅ Uncommitted changes handled safely
✅ Clear communication throughout process