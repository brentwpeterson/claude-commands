Create new branch from feature document: $ARGUMENTS

**Usage**: `/create-branch <project> <feature-document-path>`

**Arguments**:
- `<project>` (required): Project to create branch for - any Git repository in your workspace (discovered via `.claude/local/workspace.env` configuration)
- `<feature-document-path>` (required): Path to document in project's /todo/ directory

**Action:** Create branch, update task status, set up development

**Phase 1: Analyze Feature Document**
1. **Read Feature Document:**
   - Find and read the document at: `[project]/todo/$ARGUMENTS`
   - Extract feature/task name, type, and requirements
   - Determine appropriate branch category:
     - **feature/** - New functionality, capabilities, or user-facing additions
     - **fix/** - Bug fixes, issue resolution
     - **hotfix/** - Urgent production fixes that can't wait
     - **enhancement/** - Improvements to existing features
     - **refactor/** - Code restructuring, cleanup, optimization
     - **docs/** - Documentation updates only
     - **test/** - Adding tests, test improvements
     - **chore/** - Maintenance, dependencies, tooling
     - **security/** - Security fixes, vulnerability patches
     - **performance/** - Speed/efficiency improvements

2. **Generate Branch Name:**
   - Create clean branch name from document title/content
   - Format: `[category]/[descriptive-name]`
   - Examples:
     - `feature/mvp-writers-program`
     - `fix/login-timeout-issue`
     - `enhancement/user-dashboard`
     - `hotfix/payment-processing`

**Phase 2: Branch Creation**
3. **Create Development Branch:**
   **CRITICAL: Always start from clean master branch**
   
   a. **Check Current Branch Status:**
   - Run `git status` to check for uncommitted changes
   - Run `git branch --show-current` to see current branch
   
   b. **Handle Uncommitted Changes (if any):**
   - If uncommitted changes exist:
     - **ASK USER:** "You have uncommitted changes on branch [current-branch]. How would you like to proceed?"
       1. "Commit changes first" → Guide through commit process
       2. "Stash changes" → Run `git stash push -m "WIP: Stashing before feature [feature-name]"`
       3. "Discard changes" → Only with explicit confirmation
       4. "Abort" → Stop the branch creation process
   - **Never lose user's work** - Always preserve or explicitly confirm before discarding
   
   c. **Switch to Master:**
   - If not on master: `git checkout master`
   - Pull latest: `git pull origin master`
   - Verify clean state: `git status` (should show "nothing to commit, working tree clean")
   
   d. **Create New Branch:**
   - Create branch from master: `git checkout -b [generated-branch-name]`
   - Push to remote: `git push -u origin [generated-branch-name]`
   - Confirm branch creation: `git branch --show-current` (should show new branch)

**Phase 3: Task Management Setup**
4. **Update Task Status:**
   - Move document from `/TODO/backlog/` or `/TODO/` to `/TODO/current/[category]/`
   - Create folder structure: `/TODO/current/[category]/[branch-name]/`
   - Move task document into the new folder
   - Update task status to "IN PROGRESS - Branch Created"
   - Add branch name and start date to task document

5. **Create Development Plan:**
   - Analyze feature requirements from document
   - **ADD BRANCH NAME TO README.md:**
     - Add at the top of the README.md file:
       ```markdown
       **Branch:** [generated-branch-name]
       **Status:** IN PROGRESS
       **Created:** [current-date]
       **Last Resumed:** [current-date]
       ```
   - **CREATE DEBUG LOG:**
     - Create file: `[generated-branch-name]-debug.log` in task folder
     - Initialize with template:
       ```
       ##############################################################################
       # TEST ATTEMPT LOG
       ##############################################################################
       # 1. YYYY-MM-DD HH:MM - [Description of initial branch creation]
       # 2. YYYY-MM-DD HH:MM - [Description of first modification/test attempt]
       # 3. YYYY-MM-DD HH:MM - [Description of second modification/test attempt]
       # [Add additional entries as testing progresses]
       ##############################################################################
       ```
   - Create implementation checklist in task folder
   - Add files like:
     - `implementation-plan.md`
     - `testing-checklist.md`
     - `requirements.md` (copied from original doc)

**Phase 4: Documentation Setup**
6. **Prepare Documentation Structure:**
   - If feature/enhancement: create placeholder in `/docs/` for user documentation
   - Create placeholder in `/technical/` for technical documentation
   - Add entry to changelog template (unreleased section)

**Phase 5: Development Environment**
7. **Development Ready:**
   - Confirm branch is active and tracking remote
   - Show summary of:
     - Branch created: [branch-name]
     - Category: [category]
     - Task moved to: `/TODO/current/[category]/[branch-name]/`
     - Ready for development

**Usage Examples:**
- `/project:create-branch backlog/user-authentication-system.md`
- `/project:create-branch current/payment-bug-investigation.md`
- `/project:create-branch ideas/dashboard-redesign.md`

**Branch Naming Convention:**
- Use kebab-case (hyphens, no spaces)
- Keep descriptive but concise
- Match the main feature/fix being addressed
- Examples: `feature/oauth-integration`, `fix/mobile-layout`, `hotfix/security-patch`