# ⚠️ WARNING: DO NOT SAVE CONTEXT ON MASTER BRANCH - TEST EDIT

## 🚨 CONTEXT SAVING ERROR DETECTED

If you are seeing this file, it means you are attempting to save context to the **master branch**, which should **NEVER** happen.

### Why This Is Wrong

- **Master branch** is for stable, production-ready code
- **Context files** are temporary, session-specific information
- **Saving context to master** pollutes the repository history with temporary data

### What You Should Do Instead

1. **Create a feature branch** for your work:
   ```bash
   git checkout -b feature/your-task-name
   ```

2. **Or use the create-branch command**:
   ```
   /create-branch project-name path/to/requirements.md
   ```

3. **Save context to the appropriate branch-specific file**:
   - `.claude/branch-context/feature-your-task-name-context.md`
   - `.claude/branch-context/bugfix-issue-name-context.md`
   - etc.

### Action Required

**Please tell me:**
1. What branch should we be working on?
2. What context file should I be using instead?
3. Should I create a new branch with the `/create-branch` command?

### Available Options

- If you need to create a new branch, use: `/create-branch <project-name> <requirements-file>`
- If you have an existing branch, switch to it: `git checkout <branch-name>`
- If you're continuing previous work, tell me which context file to use

**Remember: Master branch = stable code only. All development work happens on feature branches.**