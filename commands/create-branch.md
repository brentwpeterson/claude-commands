Create New Branch with Task Documentation - Automated Development Workflow

**USAGE:** `/create-branch [feature-document-path]` - Create branch with proper documentation structure for any task type

**Arguments:**
- `[feature-document-path]` (required): Path to document in project's `/todo/` directory

**🎯 PURPOSE:**
Create standardized development branch with automated documentation setup based on task category

**📋 BRANCH CREATION WORKFLOW:**

**Phase 1: Analyze Document and Determine Task Type**
1. **Read Task Document:**
   - Find and read the document at: `todo/[path-provided]`
   - Extract task name, type, and requirements
   - Determine appropriate branch category and documentation structure:

   **Supported Task Categories:**
   - **features/** - New functionality, capabilities, or user-facing additions
   - **fixes/** - Bug fixes, issue resolution, error handling
   - **infrastructure/** - Deployment, scaling, DevOps, system setup
   - **refactor/** - Code restructuring, cleanup, optimization
   - **debug/** - Debug sessions, investigation, troubleshooting

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

**Phase 3: Task Documentation Setup**
4. **Create Task Folder Structure:**
   - Create folder: `/todo/current/[category]/[branch-name]/`
   - **COPY CORE README TEMPLATE:** Copy `/todo/README.md` into task folder
   - **CUSTOMIZE README.md** with branch name and category-specific file catalog

5. **Generate Category-Specific Documentation:**

   **For FEATURES (5 files + technical diagram):**
   - **README.md** - Task overview, branch, status (auto-populated)
   - **requirements.md** - What needs to be built, success criteria
   - **technical-diagram.md** - Architecture flow: frontend → datalayer → router → service → model → collection
   - **implementation-plan.md** - Step-by-step build approach, phases
   - **progress.log** - Chronological development progress

   **For INFRASTRUCTURE (5 files):**
   - **README.md** - Task overview, branch, status (auto-populated)
   - **requirements.md** - Infrastructure needs, system requirements
   - **infrastructure-diagram.md** - System architecture, deployment flow
   - **deployment-plan.md** - Deployment strategy, rollout phases
   - **progress.log** - Chronological infrastructure progress

   **For REFACTOR (4 files):**
   - **README.md** - Task overview, branch, status (auto-populated)
   - **refactor-plan.md** - Code analysis, refactoring strategy
   - **code-analysis.md** - Current state analysis, improvement targets
   - **progress.log** - Chronological refactoring progress

   **For DEBUG (4 files):**
   - **README.md** - Task overview, branch, status (auto-populated)
   - **debug-report.md** - Issue analysis, symptoms, investigation
   - **investigation-plan.md** - Debug strategy, tools, approach
   - **progress.log** - Chronological debug attempts and findings

   **For FIXES (4 files):**
   - Use `/create-bugfix` command instead - optimized for bug fix workflow

**Phase 4: Final Setup and Verification**
6. **Initialize progress.log:**
   - Create `progress.log` with initial entry:
```
##############################################################################
# [TASK-TYPE] PROGRESS LOG - [TASK-NAME]
##############################################################################
[current-timestamp] - Branch created: [category]/[branch-name]
[current-timestamp] - Documentation structure set up
[current-timestamp] - Ready to begin [category] work

# Format for future entries:
# [timestamp] - [Action taken] - [Result/Progress]
##############################################################################
```

7. **Verification and Summary:**
   - Confirm all required files created for task category
   - Display task folder location: `/todo/current/[category]/[branch-name]/`
   - Show branch name: `[category]/[branch-name]`
   - List files created with their purposes
   - Ready for development work

**🎯 USAGE EXAMPLES:**
```bash
/create-branch backlog/user-authentication-system.md
/create-branch current/payment-dashboard-redesign.md
/create-branch ideas/api-rate-limiting.md
```

**📁 RESULT STRUCTURES BY CATEGORY:**

**Features:**
```
/todo/current/features/[branch-name]/
├── README.md                # Task overview with branch and status
├── requirements.md          # What needs to be built
├── technical-diagram.md     # Architecture: frontend → router → service → model
├── implementation-plan.md   # Step-by-step build approach
└── progress.log            # Development progress tracking
```

**Infrastructure:**
```
/todo/current/infrastructure/[branch-name]/
├── README.md                # Task overview with branch and status
├── requirements.md          # Infrastructure needs
├── infrastructure-diagram.md # System architecture
├── deployment-plan.md       # Deployment strategy
└── progress.log            # Infrastructure progress
```

**✅ AUTOMATED ACTIONS:**
1. Analyze task document and determine category
2. Create standardized branch from clean master
3. Copy and customize README.md template with category-specific file catalog
4. Generate complete documentation structure for task type
5. Initialize progress tracking
6. Ready for immediate development work

**🔄 BRANCH NAMING CONVENTION:**
- Use kebab-case (hyphens, no spaces)
- Format: `[category]/[descriptive-name]`
- Keep descriptive but concise (max 50 chars)
- Examples: `features/oauth-integration`, `infrastructure/redis-setup`, `refactor/user-service`