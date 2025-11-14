Create New Branch with Task Documentation - Automated Development Workflow

**USAGE:**
- `/create-branch [feature-document-path]` - Create branch with proper documentation structure for any task type
- `/create-branch --plan [task-name] [category]` - **PLANNING MODE**: Create todo structure only (no branch creation)

**Arguments:**
- `[feature-document-path]` (required): Path to document in project's `/todo/` directory
- `--plan` (optional): Planning mode flag - creates todo documentation structure only
- `[task-name]` (required with --plan): Name of the task for planning
- `[category]` (required with --plan): Task category (feature/fix/infrastructure/refactor/debug)

**🎯 PURPOSE:**
Create standardized development branch with automated documentation setup based on task category, OR create planning documentation structure for pre-planning tasks

**📋 WORKFLOW MODES:**

## 🗂️ **PLANNING MODE WORKFLOW** (`--plan` flag)

**When to Use Planning Mode:**
- Pre-planning tasks before implementation
- Creating documentation structure for future work
- Organizing requirements and acceptance criteria
- Planning complex features that need detailed analysis

**Planning Mode Process:**

**Phase P1: Task Structure Selection**
1. **Prompt User for Structure Type:**
   ```
   Choose todo structure for [task-name]:
   1. 📁 **Standard 7-File Structure** (Comprehensive - recommended for complex tasks)
   2. 📄 **Lightweight 4-File Structure** (Simple - for straightforward tasks)
   3. 🔧 **Bug Fix 4-File Structure** (Bug-specific workflow)

   Enter choice (1/2/3):
   ```

2. **Structure Descriptions:**
   - **Standard 7-File**: Complete documentation with architecture mapping, debug logs, user docs
   - **Lightweight 4-File**: Planning-focused with README, planning, progress, debug
   - **Bug Fix 4-File**: Bug-specific with README, report, fix, test

**Phase P2: Create Planning Directory**
3. **Create Todo Directory Structure:**
   - Create folder: `/todo/current/[category]/[task-name]/`
   - If `/todo/current/` doesn't exist, create the entire directory structure
   - If task directory already exists, ask user how to proceed:
     - "Overwrite existing files"
     - "Merge with existing files"
     - "Abort and choose different task name"

**Phase P3: Generate Selected File Structure**
4. **Create Files Based on User Selection:**

   **Standard 7-File Structure:**
   - `README.md` - Task overview with guidelines references
   - `[task-name]-plan.md` - Requirements + acceptance criteria + implementation + testing + completion checklist
   - `progress.log` - Daily progress tracking template
   - `debug.log` - Debug attempts structure template
   - `notes.md` - Discoveries and insights template
   - `architecture-map.md` - CB technical flow template
   - `user-documentation.md` - Public/private documentation template

   **Lightweight 4-File Structure:**
   - `README.md` - Task summary + links to guidelines
   - `[task-name]-planning.md` - Purpose, scope, API touchpoints, UI states, risks, "done when" checklist
   - `[task-name]-progress.md` - Notes + Test & Release Checklist
   - `[task-name]-debug.md` - Quick triage guide and command snippets

   **Bug Fix 4-File Structure:**
   - `README.md` - Bug summary + links to guidelines
   - `[task-name]-report.md` - Problem description, reproduction steps
   - `[task-name]-fix.md` - Root cause, changes made, risks
   - `[task-name]-test.md` - Verification steps, regression checks

**Phase P4: Initialize Templates**
5. **Populate Files with Planning Templates:**
   - All files get appropriate templates based on structure choice
   - Include mandatory guidelines references in README.md
   - Set up proper headers and workflow instructions
   - Mark as "PLANNING PHASE" in progress tracking

**🎯 PLANNING TEMPLATES BY STRUCTURE TYPE:**

### Standard 7-File Structure Templates:

**README.md Template:**
```markdown
# [Task Name] - TODO Task (PLANNING PHASE)

**Branch:** [Not created yet - planning phase]
**Status:** PLANNING
**Created:** [current-date]
**Category:** [category]

**IMPORTANT**: When ready to implement, run `/create-branch todo/current/[category]/[task-name]/README.md`
which will create the actual git branch and update this README with the real branch name.

## 📚 **REQUIRED READING FOR CLAUDE**
**Before working on this task, READ THESE GUIDELINES:**
- `../../../todo-workflow-guidelines.md` - Session management and workflow rules
- `../../../technical-implementation-guidelines.md` - CB development standards and templates

**Critical reminder**: If you don't know what todo you're working on, ASK IMMEDIATELY.

## 🎯 **TASK OVERVIEW**
[Brief description of what this task accomplishes - TO BE FILLED DURING PLANNING]

## 📋 **PLANNING STATUS**
- [ ] Requirements documented in [task-name]-plan.md
- [ ] Acceptance criteria defined
- [ ] Implementation approach outlined
- [ ] Testing strategy planned
- [ ] Ready for branch creation

## 📁 **FILES IN THIS TODO**
- [x] README.md - This file (task overview and status)
- [ ] [task-name]-plan.md - Requirements + acceptance criteria + implementation + testing + completion checklist
- [ ] progress.log - Daily progress tracking and updates
- [ ] debug.log - Debug attempts and troubleshooting sessions
- [ ] notes.md - Discoveries, blockers, insights
- [ ] architecture-map.md - CB technical flow mapping
- [ ] user-documentation.md - Public and private user documentation

## 🔄 **NEXT STEPS**
1. Fill out [task-name]-plan.md with detailed requirements
2. Define acceptance criteria
3. Plan implementation approach
4. When ready: /create-branch todo/current/[category]/[task-name]/README.md
```

### Lightweight 4-File Structure Templates:

**README.md Template:**
```markdown
# [Task Name] - TODO Task (PLANNING PHASE)

**Branch:** [Not created yet - planning phase]
**Status:** PLANNING
**Created:** [current-date]
**Category:** [category]

**IMPORTANT**: When ready to implement, run `/create-branch todo/current/[category]/[task-name]/README.md`
which will create the actual git branch and update this README with the real branch name.

## 📚 **REQUIRED READING FOR CLAUDE**
- `../../../todo-workflow-guidelines.md` - Session management and workflow rules
- `../../../technical-implementation-guidelines.md` - CB development standards

## 🎯 **TASK OVERVIEW**
[Brief description - TO BE FILLED DURING PLANNING]

## 📁 **FILES IN THIS TODO**
- [x] README.md - This file (task summary + links)
- [ ] [task-name]-planning.md - Purpose, scope, API touchpoints, UI states, risks, "done when" checklist
- [ ] [task-name]-progress.md - Notes + Test & Release Checklist
- [ ] [task-name]-debug.md - Quick triage guide and command snippets

## 🔄 **NEXT STEPS**
1. Complete [task-name]-planning.md
2. When ready: /create-branch todo/current/[category]/[task-name]/README.md
```

**[task-name]-planning.md Template:**
```markdown
# [Task Name] - Planning Document

## Why
[1–2 sentences explaining purpose]

## Scope
**In Scope:**
- [Feature/change 1]
- [Feature/change 2]

**Out of Scope:**
- [What we're NOT doing]
- [Future enhancements]

## API/Contracts
**Endpoints or Props:**
- [API endpoint or component prop]
- [Expected inputs/outputs]

## UI States
- **Loading**: [How loading state appears]
- **Empty**: [Empty state behavior]
- **Error**: [Error handling approach]
- **Success**: [Success state display]

## Risks/Assumptions
- [Risk 1 and mitigation]
- [Risk 2 and mitigation]
- [Assumption 1]
- [Assumption 2]

## Done When
- [ ] [Acceptance criteria 1]
- [ ] [Acceptance criteria 2]
- [ ] [Acceptance criteria 3]
```

### Bug Fix 4-File Structure Templates:

**README.md Template:**
```markdown
# [Bug ID] - [Bug Title] (PLANNING PHASE)

**Branch:** [Not created yet - planning phase]
**Status:** PLANNING
**Created:** [current-date]
**Category:** fix

**IMPORTANT**: When ready to implement, run `/create-branch todo/current/fix/[bug-id]/README.md`
which will create the actual git branch and update this README with the real branch name.

## 📚 **REQUIRED READING FOR CLAUDE**
- `../../../todo-workflow-guidelines.md` - Session management and workflow rules
- `../../../technical-implementation-guidelines.md` - CB development standards

## 🐛 **BUG OVERVIEW**
[Brief description of the bug - TO BE FILLED DURING PLANNING]

## 📁 **FILES IN THIS TODO**
- [x] README.md - This file (bug summary + links)
- [ ] [bug-id]-report.md - Problem description, reproduction steps
- [ ] [bug-id]-fix.md - Root cause, changes made, risks
- [ ] [bug-id]-test.md - Verification steps, regression checks

## 🔄 **NEXT STEPS**
1. Document bug details in [bug-id]-report.md
2. When ready: /create-branch todo/current/fix/[bug-id]/README.md
```

**Phase P5: File Creation & Integration**
6. **Create ALL Required Files for Selected Structure:**

   **Create Files Based on Structure Choice:**
   - **Standard 7-File**: Create all 7 files with planning templates
   - **Lightweight 4-File**: Create 4 files with planning templates
   - **Bug Fix 4-File**: Create 4 files with bug-specific templates

   **File Count by Structure:**
   - Standard 7-File Structure: 7 files exactly
   - Lightweight 4-File Structure: 4 files exactly
   - Bug Fix 4-File Structure: 4 files exactly

**Phase P6: Planning Complete**
7. **Output Planning Summary:**
   ```
   📁 Planning structure created: /todo/current/[category]/[task-name]/
   📝 Structure: [Standard 7-File|Lightweight 4-File|Bug Fix 4-File]
   ✅ Files created: [ACTUAL-COUNT] files

   📚 Next steps:
   - Fill out planning documents
   - Define acceptance criteria
   - Complete planning phase checklist in README.md
   - When ready: /create-branch todo/current/[category]/[task-name]/README.md

   🔍 VALIDATION INTEGRATION:
   - /claude-save will validate 7-file structure: "✅ Complete (7/7 files)" or "⚠️ Incomplete (X/7 files)"
   - /claude-start will verify todo directory has exactly 7 files using `ls -1 [todo-path] | wc -l`
   - These commands expect standard 7-file structure (README.md, [task]-plan.md, progress.log, debug.log, notes.md, architecture-map.md, user-documentation.md)

   📝 NOTE: If you chose lightweight or bug-fix structure, convert to standard 7-file before implementation
   ```

**🎯 COMPLETE TEMPLATES FOR ALL FILE TYPES:**

### Standard 7-File Additional Templates:

**[task-name]-plan.md Template:**
```markdown
# [Task Name] - Implementation Plan

## 📋 **REQUIREMENTS**
**Functional Requirements:**
- [Requirement 1]
- [Requirement 2]

**Non-Functional Requirements:**
- [Performance requirement]
- [Security requirement]

## ✅ **ACCEPTANCE CRITERIA**
**CRITICAL: Every todo MUST have acceptance criteria**
- [ ] [Specific measurable outcome 1]
- [ ] [Specific measurable outcome 2]
- [ ] [Specific measurable outcome 3]

## 🔧 **IMPLEMENTATION PLAN**
**Phase 1: [Phase name]**
- [ ] [Step 1]
- [ ] [Step 2]

**Phase 2: [Phase name]**
- [ ] [Step 1]
- [ ] [Step 2]

## 🧪 **TESTING STRATEGY**
**Test locally before deployment:**
- [ ] Unit tests for core functionality
- [ ] Integration tests for API endpoints
- [ ] Manual testing of user workflows
- [ ] Error handling verification

## ✅ **COMPLETION CHECKLIST**
- [ ] All acceptance criteria met
- [ ] Code reviewed and tested
- [ ] Documentation updated
- [ ] User approval received
- [ ] Ready for deployment
```

**progress.log Template:**
```
##############################################################################
# PLANNING PROGRESS LOG - [TASK-NAME]
##############################################################################
[current-timestamp] - Planning phase started
[current-timestamp] - Todo structure created ([7|4] files)
[current-timestamp] - Ready for requirements gathering

# PLANNING PHASE TRACKING:
# [timestamp] - [Planning activity] - [Progress/Notes]

# IMPLEMENTATION PHASE TRACKING (Future):
# [timestamp] - [Development activity] - [Result/Progress]
##############################################################################
```

**debug.log Template:**
```
##############################################################################
# DEBUG LOG - [TASK-NAME] (PLANNING PHASE)
##############################################################################
# INSTRUCTIONS FOR USE:
# - Use /debug-attempt [try-number] command to add structured entries
# - Each debug attempt = one attempt number
# - Format: Attempt #X | Date Time | What tested | Result | What was tried/learned
##############################################################################
# SUMMARY OF ATTEMPTS:
# (Debug attempts will be added here by /debug-attempt command during implementation)
##############################################################################
# PLANNING PHASE DEBUG NOTES:
[current-timestamp] - Planning phase - No debug attempts yet
##############################################################################
```

**notes.md Template:**
```markdown
# [Task Name] - Notes & Insights

## 🔍 **PLANNING PHASE NOTES**

### Initial Analysis
- [Key insight 1]
- [Key insight 2]

### Potential Blockers
- [Potential blocker 1 and mitigation]
- [Potential blocker 2 and mitigation]

### Implementation Decisions
- [Decision 1 and rationale]
- [Decision 2 and rationale]

## 💡 **IMPLEMENTATION NOTES** (Future)
[Notes will be added during implementation]

## 🚧 **BLOCKERS & RESOLUTIONS** (Future)
[Blockers will be documented here during implementation]
```

**architecture-map.md Template:**
```markdown
# [Task Name] - CB Architecture Flow Map

## 🏗️ **CB TECHNICAL LAYERS**

### Frontend Layer
**Components Modified/Created:**
- [ ] [Component 1] - [Purpose]
- [ ] [Component 2] - [Purpose]

### DataLayer
**API Integration:**
- [ ] [DataProvider function] - [API call]
- [ ] [Service call] - [Backend endpoint]

### Router Layer (FastAPI)
**Endpoints:**
- [ ] [HTTP Method] /api/[endpoint] - [Purpose]
- [ ] [HTTP Method] /api/[endpoint] - [Purpose]

### Service Layer
**Business Logic:**
- [ ] [Service class].[method] - [Business rule]
- [ ] [Service class].[method] - [Business rule]

### Model Layer
**Data Models:**
- [ ] [Model class] - [Data structure]
- [ ] [Schema class] - [Validation rules]

### Collection Layer (Database)
**Database Operations:**
- [ ] [Collection name] - [CRUD operations]
- [ ] [Migration] - [Schema changes]

## 🔄 **DATA FLOW**
```
User Action → Frontend Component → DataLayer API Call → Router Endpoint → Service Method → Model Validation → Database Collection
```

## 📝 **IMPLEMENTATION NOTES**
[Architecture decisions and technical considerations will be added during implementation]
```

**user-documentation.md Template:**
```markdown
# [Task Name] - User Documentation

## 📚 **PUBLIC DOCUMENTATION**

### User Guide
**Feature Overview:**
[Description of feature for end users]

**How to Use:**
1. [Step 1]
2. [Step 2]
3. [Step 3]

### API Documentation (if applicable)
**Endpoints:**
- `[METHOD] /api/[endpoint]` - [Description]
  - Parameters: [parameters]
  - Response: [response format]

## 🔒 **INTERNAL DOCUMENTATION**

### Developer Notes
**Implementation Details:**
[Technical details for developers]

**Configuration:**
[Configuration settings and environment variables]

### Troubleshooting
**Common Issues:**
- [Issue 1] - [Solution]
- [Issue 2] - [Solution]

## 📋 **DOCUMENTATION CHECKLIST**
- [ ] User guide written
- [ ] API docs updated (if applicable)
- [ ] Installation instructions provided
- [ ] Examples included
- [ ] Internal documentation complete
```

## 🔨 **IMPLEMENTATION MODE WORKFLOW** (normal usage)

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
   **CRITICAL: Populate README.md with ACTUAL branch name, not placeholders**
   **ALL CATEGORIES use the same standardized structure (7 files):**

   **Always Create These 7 Files:**
   - **README.md** - Task overview, branch, current status, references to guidelines
   - **[branch-name]-plan.md** - Requirements + acceptance criteria + implementation plan + testing plan + completion checklist
   - **progress.log** - Daily progress tracking and updates
   - **debug.log** - Debug attempts and troubleshooting sessions (using `/debug-attempt` command)
   - **notes.md** - Discoveries, blockers, insights, and additional context
   - **architecture-map.md** - CB technical flow: Frontend → DataLayer → Router → Service Layer → Model → Collection
   - **user-documentation.md** - Public and private user documentation (API docs, guides, installation, examples, internal docs)

   **README.md Template Must Include Actual Branch Name and Guidelines References:**
   ```markdown
   # [Task Name from Document]

   **Branch:** [actual-branch-name]
   **Status:** IN PROGRESS
   **Created:** [current-date]
   **Category:** [category]

   ## 📚 **REQUIRED READING FOR CLAUDE**
   **Before working on this task, READ THESE GUIDELINES:**
   - `../../../todo-workflow-guidelines.md` - Session management and workflow rules
   - `../../../technical-implementation-guidelines.md` - CB development standards and templates

   **Critical reminder**: If you don't know what todo you're working on, ASK IMMEDIATELY.
   ```

   **CRITICAL INSTRUCTION**: Replace `[actual-branch-name]` with the real git branch name created (e.g., `feature/user-authentication` NOT placeholder text)

   **File Templates Based on Category:**
   - **Features**: Focus on user-facing functionality and feature requirements
   - **Infrastructure**: Focus on system architecture and deployment considerations
   - **Refactor**: Focus on code improvement and optimization
   - **Debug**: Focus on issue investigation and problem resolution
   - **Fixes**: Focus on bug resolution and testing validation

**Phase 4: File Template Creation**
6. **Initialize All 7 Files with Templates:**

   **CRITICAL: Update README.md Branch Information**
   - If README.md already exists (from planning mode), **UPDATE the branch line**:
     - Change from: `**Branch:** [Not created yet - planning phase]`
     - Change to: `**Branch:** [actual-branch-name]` (e.g., `feature/user-authentication`)
     - Update status from `PLANNING` to `IN PROGRESS`
   - If creating new README.md, populate with actual branch name from start

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
   - **Copy comprehensive template**: Copy `/todo/architecture-map-template.md` to task directory
   - **Customize for task**: Replace all `[TASK-NAME]` and `[bracketed placeholders]` with actual values
   - **Complete checklist**: Fill out all sections and check completion items
   - **Validate completeness**: Must pass architecture map validation in `/claude-save`

   **CRITICAL**: Architecture map must be completed during implementation, not left as template

7. **Verification and Summary:**
   - Confirm all 7 standardized files created
   - **VERIFY README.md shows actual branch name** (not placeholder)
   - Display task folder location: `/todo/current/[category]/[branch-name]/`
   - Show branch name: `[category]/[branch-name]`
   - List the 7 files created with their purposes
   - Ready for development work

   **EXAMPLE README.md Verification:**
   ```markdown
   **Branch:** feature/user-authentication  ✅ CORRECT
   **Branch:** [actual-branch-name]         ❌ WRONG - still placeholder
   ```

**🎯 USAGE EXAMPLES:**

### Planning Mode Examples:
```bash
# Create planning structure for a new feature
/create-branch --plan user-authentication feature

# Create planning structure for a bug fix
/create-branch --plan login-timeout-issue fix

# Create planning structure for infrastructure work
/create-branch --plan redis-migration infrastructure
```

### Implementation Mode Examples:
```bash
# Create branch from existing todo document
/create-branch backlog/user-authentication-system.md

# Create branch from planning structure
/create-branch todo/current/feature/user-authentication/README.md

# Create branch from completed planning
/create-branch current/payment-dashboard-redesign.md
```

## 📁 **STANDARDIZED 7-FILE STRUCTURE - COMPREHENSIVE GUIDE**

**🎯 TODO + CONTEXT = SESSION RECOVERY**
- **Context file**: Session state and resume instructions
- **Todo file**: Task requirements and progress
- **Both required**: For complete session handoff between Claude instances

### 📋 **Required Files (Always Create These 7)**

**ALL task categories use the same standardized structure:**

#### 1. **README.md** - Task Overview & Current Status
**Purpose**: Central hub for task information and current status
**Why needed**:
- Provides immediate context for any Claude session
- Links to critical guidelines that MUST be read
- Shows current progress and next steps
- **Critical reminder**: If you don't know what todo you're working on, ASK IMMEDIATELY

#### 2. **[branch-name]-plan.md** - Complete Implementation Plan
**Purpose**: Requirements + acceptance criteria + implementation + testing + completion checklist
**Why needed**:
- **CRITICAL**: Every todo MUST have acceptance criteria before completion
- Provides detailed roadmap for implementation
- Ensures nothing is missed during development
- Required for TodoWrite completion approval protocol

#### 3. **progress.log** - Daily Progress Tracking and Updates
**Purpose**: Chronological timeline with timestamps for session tracking
**Why needed**:
- Tracks progress across multiple Claude sessions
- Provides context for what was tried and what worked
- Essential for debugging when things go wrong
- Shows development velocity and time estimates

#### 4. **debug.log** - Debug Attempts and Troubleshooting Sessions
**Purpose**: Structured debug attempts using `/debug-attempt` command
**Why needed**:
- Prevents repeating failed approaches
- Documents systematic problem-solving process
- Critical for complex debugging sessions
- Helps identify patterns in failures

#### 5. **notes.md** - Discoveries, Blockers, Insights
**Purpose**: Discoveries, blockers, insights, and additional context
**Why needed**:
- Captures important insights that might be forgotten
- Documents blockers and their solutions
- Preserves architectural decisions and rationale
- Prevents losing valuable context between sessions

#### 6. **architecture-map.md** - CB Technical Flow Mapping
**Purpose**: CB technical flow: Frontend → DataLayer → Router → Service Layer → Model → Collection
**Why needed**:
- **CRITICAL**: Maps changes across CB's technical layers
- Required by `/claude-save` - save is blocked if outdated
- Updated by `/update-architecture` command during development
- Ensures complete technical context for session handoffs
- Prevents "archaeological digs" to understand what was modified

#### 7. **user-documentation.md** - Public and Private User Documentation
**Purpose**: Public and private user documentation (API docs, guides, installation, examples, internal docs)
**Why needed**:
- Plans user-facing documentation from the start
- Ensures features are documented as they're built
- Separates public vs internal documentation needs
- Required for complete feature delivery

### 🔄 **HOW THE 7 FILES WORK TOGETHER**

**Session Handoff Process:**
1. **README.md** - Quick context and current status
2. **[branch-name]-plan.md** - Detailed requirements and acceptance criteria
3. **progress.log** - What's been done and timeline
4. **debug.log** - What problems were encountered and solved
5. **notes.md** - Important insights and decisions
6. **architecture-map.md** - Technical changes across CB layers
7. **user-documentation.md** - Documentation planning and content

**Critical Integration Points:**
- **TodoWrite + Acceptance Criteria**: All todos must reference acceptance criteria from plan.md
- **Debug Attempts**: Use `/debug-attempt` to maintain structured debug.log
- **Architecture Updates**: Run `/update-architecture` to keep architecture-map.md current
- **Save Validation**: `/claude-save` validates all 7 files exist and architecture is current

### 🚨 **CRITICAL COMPLETION REQUIREMENTS**

**NEVER mark tasks as completed without explicit user approval**

**BEFORE Claude can declare ANY task complete, Claude MUST:**
1. **Check for Acceptance Criteria FIRST**: Does the plan.md include acceptance criteria?
2. **If NO criteria exist**: STOP and ask user: "What are the acceptance criteria for this task?"
3. **If criteria exist**: Verify ALL criteria are met
4. **Request User Approval**: "Task appears complete per all acceptance criteria. Do you approve marking this as done?"
5. **Wait for Explicit Confirmation**: User must say "yes", "approved", "done", or "complete"

### 📏 **FILE SIZE GUIDELINES FOR CLAUDE CODE PERFORMANCE**

**Optimal File Sizes:**
- **200-500 lines**: ⚡ Instant - Full comprehension, perfect refactoring
- **500-1000 lines**: ✅ Excellent - Complete context, reliable changes
- **1000+ lines**: ⚠️ Challenging - Works in sections, may miss connections

**Why Large Files Are Problematic:**
1. Can't see full context when making changes
2. May timeout on large refactoring operations
3. Loses track of related functions spread across thousands of lines
4. Cannot effectively suggest architectural improvements

### 💾 **SAVE COMMAND INTEGRATION**

**TODO PATH MUST BE INCLUDED IN ALL SAVE COMMANDS:**

#### /claude-save Integration
```markdown
## CURRENT TODO FILE
Path: file:/Users/brent/scripts/CB-Workspace/[project]/todo/current/[category]/[task-name]/README.md
Status: [Working on step X of Y - specific current focus]
```

#### /claude-save-fast Integration
```markdown
## TODO
Path: file:/Users/brent/scripts/CB-Workspace/[project]/todo/current/[category]/[task-name]/README.md
```

**⚠️ CRITICAL**: If todo path doesn't exist, save commands must STOP and ask user to clarify.

## 📋 **TODO TASK CATEGORIES**

```
todo/current/
├── feature/                 # New functionality development
├── fix/                     # Bug fixes and issue resolution
├── infrastructure/          # Infrastructure and deployment work
├── refactor/                # Code refactoring and cleanup
└── debug/                   # Debug sessions and troubleshooting
```

### 🎯 **SUMMARY FOR CLAUDE**

**EVERY SESSION NEEDS:**
1. **Know current todo** - If you don't know, ASK immediately
2. **Todo file path** - Must be included in save commands
3. **Context file** - Session state and resume instructions
4. **Both together** - Complete handoff for next Claude session

**NEVER GUESS - ALWAYS ASK!**

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
6. **POPULATE README.md with ACTUAL git branch name** (not placeholders)
7. Ready for immediate development work with complete documentation framework

**🌿 BRANCH NAME REQUIREMENTS:**
- README.md MUST show real branch name: `**Branch:** feature/user-authentication`
- NEVER leave placeholders: `**Branch:** [actual-branch-name]` ❌
- Update planning mode READMEs when transitioning to implementation
- Verify branch name is correctly populated in final step

**🔄 BRANCH NAMING CONVENTION:**
- Use kebab-case (hyphens, no spaces)
- Format: `[category]/[descriptive-name]`
- Keep descriptive but concise (max 50 chars)
- Examples: `features/oauth-integration`, `infrastructure/redis-setup`, `refactor/user-service`