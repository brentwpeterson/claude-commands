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
   - If `/todo/current/` doesn't exist, create the entire directory structure

5. **Generate Standardized 7-File Documentation Structure:**
   **ALL CATEGORIES use the same standardized structure (7 files):**

   **Always Create These 7 Files:**
   - **README.md** - Task overview, branch, current status, references to guidelines
   - **[branch-name]-plan.md** - Requirements + acceptance criteria + implementation plan + testing plan + completion checklist
   - **progress.log** - Daily progress tracking and updates
   - **debug.log** - Debug attempts and troubleshooting sessions (using `/debug-attempt` command)
   - **notes.md** - Discoveries, blockers, insights, and additional context
   - **architecture-map.md** - CB technical flow: Frontend → DataLayer → Router → Service Layer → Model → Collection
   - **user-documentation.md** - Public and private user documentation (API docs, guides, installation, examples, internal docs)

   **README.md Template Must Include Guidelines References:**
   ```markdown
   ## 📚 **REQUIRED READING FOR CLAUDE**
   **Before working on this task, READ THESE GUIDELINES:**
   - `../../../todo-workflow-guidelines.md` - Session management and workflow rules
   - `../../../technical-implementation-guidelines.md` - CB development standards and templates

   **Critical reminder**: If you don't know what todo you're working on, ASK IMMEDIATELY.
   ```

   **File Templates Based on Category:**
   - **Features**: Focus on user-facing functionality and feature requirements
   - **Infrastructure**: Focus on system architecture and deployment considerations
   - **Refactor**: Focus on code improvement and optimization
   - **Debug**: Focus on issue investigation and problem resolution
   - **Fixes**: Focus on bug resolution and testing validation

**Phase 4: File Template Creation**
6. **Initialize All 7 Files with Templates:**

   **progress.log Template:**
   ```
   ##############################################################################
   # [TASK-TYPE] PROGRESS LOG - [TASK-NAME]
   ##############################################################################
   [current-timestamp] - Branch created: [category]/[branch-name]
   [current-timestamp] - Documentation structure set up (7 files)
   [current-timestamp] - Ready to begin [category] work

   # Format for future entries:
   # [timestamp] - [Action taken] - [Result/Progress]
   ##############################################################################
   ```

   **debug.log Template:**
   ```
   ##############################################################################
   # DEBUG LOG - [TASK-NAME]
   ##############################################################################
   # INSTRUCTIONS FOR USE:
   # - Use /debug-attempt [try-number] command to add structured entries
   # - Each debug attempt = one attempt number
   # - Format: Attempt #X | Date Time | What tested | Result | What was tried/learned
   ##############################################################################
   # SUMMARY OF ATTEMPTS:
   # (Debug attempts will be added here by /debug-attempt command)
   ##############################################################################
   ```

   **architecture-map.md Template:**
   ```
   # Architecture Map - [TASK-NAME]

   ## CB Technical Flow
   Frontend → DataLayer → Router → Service Layer → Model → Collection

   ## Component Locations
   - **Frontend**: [Component paths]
   - **DataLayer**: [Data layer files]
   - **Router**: [API router files]
   - **Service Layer**: [Service files]
   - **Model**: [Model definitions]
   - **Collection**: [Database collections]

   ## Layer Interactions
   [Describe how components communicate]
   ```

7. **Verification and Summary:**
   - Confirm all 7 standardized files created
   - Display task folder location: `/todo/current/[category]/[branch-name]/`
   - Show branch name: `[category]/[branch-name]`
   - List the 7 files created with their purposes
   - Ready for development work

**🎯 USAGE EXAMPLES:**
```bash
/create-branch backlog/user-authentication-system.md
/create-branch current/payment-dashboard-redesign.md
/create-branch ideas/api-rate-limiting.md
```

**📁 STANDARDIZED RESULT STRUCTURE:**

**ALL CATEGORIES use the same 7-file structure:**
```
/todo/current/[category]/[branch-name]/
├── README.md                 # 📋 Task overview and current status
├── [branch-name]-plan.md     # 📝 Requirements + acceptance criteria + implementation + testing + completion checklist
├── progress.log              # 📊 Daily progress tracking and updates
├── debug.log                 # 🐛 Debug attempts and troubleshooting sessions
├── notes.md                  # 💡 Discoveries, blockers, insights
├── architecture-map.md       # 🏗️ CB technical flow: Frontend → DataLayer → Router → Service Layer → Model → Collection
└── user-documentation.md     # 📚 Public and private user documentation
```

**Examples:**
- `/todo/current/feature/user-authentication/`
- `/todo/current/infrastructure/redis-deployment/`
- `/todo/current/refactor/user-service-cleanup/`
- `/todo/current/debug/login-timeout-issue/`
- `/todo/current/fix/payment-processing-bug/`

**✅ AUTOMATED ACTIONS:**
1. Analyze task document and determine category
2. Create standardized branch from clean master
3. Create `/todo/current/[category]/[branch-name]/` directory structure (creates full path if needed)
4. Generate standardized 7-file documentation structure for ALL task types
5. Initialize all files with appropriate templates (progress.log, debug.log, architecture-map.md, etc.)
6. Ready for immediate development work with complete documentation framework

**🔄 BRANCH NAMING CONVENTION:**
- Use kebab-case (hyphens, no spaces)
- Format: `[category]/[descriptive-name]`
- Keep descriptive but concise (max 50 chars)
- Examples: `features/oauth-integration`, `infrastructure/redis-setup`, `refactor/user-service`