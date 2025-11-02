Create Bugfix Branch from Ticket - Automated Bug Fix Workflow

**USAGE:** `/create-bugfix [ticket-id]` - Create bug fix branch with proper documentation structure

**🎯 PURPOSE:**
Create standardized bug fix branch with automated documentation setup and task tracking

**📋 BUGFIX WORKFLOW:**

**Phase 1: Parse and Validate Ticket Information**
1. **Extract Ticket Source and ID:**
   - Parse ticket format: `[SOURCE]-[PROJECT]-[ID]` or `[SOURCE]-[ID]`
   - Supported sources:
     - **REQUESTDESK-[PROJECT]-[ID]** - Sentry issues (e.g., REQUESTDESK-BACKEND-9)
     - **SUPPORT-[ID]** - Support system tickets
     - **SENTRY-[ID]** - Direct Sentry reference
     - **TICKET-[ID]** - Generic ticket format
   - Extract components for API calls and documentation

   **⚠️ IMPORTANT: If ticket format is unclear or ambiguous:**
   - **ASK THE USER IMMEDIATELY:** "I see ticket [ID]. Could you clarify the source?"
     - Sentry (error monitoring)
     - Support system (customer tickets)
     - GitHub Issues
     - Internal tracking system
     - Other (please specify)
   - **NEVER ASSUME** - Always ask when format doesn't match known patterns
   - **Stop and ask** for ambiguous formats like: "123", "BUG-456", "2024-ERROR-789"

2. **Fetch Ticket Details:**
   - **After confirming source**, proceed with appropriate method:
   - For Sentry tickets:
     - **CRITICAL: Ask about environment:**
       - "Is this Sentry error from production or development environment?"
       - "What's the Sentry environment tag on this error?"
       - This determines priority and testing requirements
     - Connect to Sentry API if available
     - Extract error message, stack trace, affected users
     - Get frequency and first/last seen timestamps
   - For Support tickets:
     - Query support system API/database
     - Get ticket description, reporter, priority
   - For unknown sources:
     - **ASK USER for details:**
       - "Please provide the error message or issue description"
       - "What's the priority level?"
       - "Are there any affected users or systems?"
       - "Is this from production or development?"
   - If API unavailable, prompt for manual details

**Phase 2: Generate Branch and Documentation**
3. **Create Branch Name:**
   - Format: `fix/[source]-[id]-[brief-description]`
   - Examples:
     - `fix/sentry-9-partnership-tickets-query`
     - `fix/support-123-login-timeout`
     - `fix/requestdesk-backend-9-ticket-filter`
   - Keep descriptive but concise (max 50 chars)

4. **Create Bug Fix Documentation Structure:**
   - Create folder: `/todo/current/fixes/[branch-name]/`
   - If `/todo/current/` doesn't exist, create the entire directory structure
   - **Generate Standardized 7-File Documentation Structure** (same as all task types)

**Always Create These 7 Standardized Files:**
   - **README.md** - Task overview, branch, current status
   - **[branch-name]-plan.md** - Bug requirements + acceptance criteria + fix plan + testing strategy + completion checklist
   - **progress.log** - Daily progress tracking and updates
   - **debug.log** - Debug attempts and troubleshooting sessions (using `/debug-attempt` command)
   - **notes.md** - Discoveries, blockers, insights, and additional context
   - **architecture-map.md** - CB technical flow: Frontend → DataLayer → Router → Service Layer → Model → Collection
   - **user-documentation.md** - Public and private user documentation (API docs, guides, patch notes)

**Bug-Specific Template Content for [branch-name]-plan.md:**
```markdown
# Bug Fix Plan: [TICKET-ID]

## Requirements
**Bug Summary:** [Brief description of the bug being fixed]
**Ticket Source:** [Sentry/Support/GitHub/etc.]
**Priority:** [High/Medium/Low]
**Environment:** [Production/Development]

## Acceptance Criteria
- [ ] Bug is reproducible locally
- [ ] Root cause identified and documented
- [ ] Fix implemented and tested
- [ ] Regression tests added
- [ ] Production verification completed
- [ ] No new bugs introduced

## Investigation Strategy
- [ ] Reproduce bug locally
- [ ] Identify root cause in code
- [ ] Research similar past issues
- [ ] Check related components

## Implementation Plan
1. [Step 1 of implementation]
2. [Step 2 of implementation]
3. [Testing approach]
4. [Deployment considerations]

## Testing Strategy
- [ ] Unit tests for fix
- [ ] Integration tests
- [ ] Manual reproduction test
- [ ] Regression testing
- [ ] Production verification plan

## Completion Checklist
- [ ] Bug fixed and tested locally
- [ ] All acceptance criteria met
- [ ] Code reviewed and approved
- [ ] Deployment ready
- [ ] User documentation updated
```

**Phase 3: Branch Creation**
5. **Create Fix Branch:**
   **CRITICAL: Always start from clean master branch**
   
   a. **Check Current Branch Status:**
   - Run `git status` to check for uncommitted changes
   - Run `git branch --show-current` to see current branch
   
   b. **Handle Uncommitted Changes (if any):**
   - If uncommitted changes exist:
     - **ASK USER:** "You have uncommitted changes on branch [current-branch]. How would you like to proceed?"
       1. "Commit changes first" → Guide through commit process
       2. "Stash changes" → Run `git stash push -m "WIP: Stashing before bugfix [ticket-id]"`
       3. "Discard changes" → Only with explicit confirmation
       4. "Abort" → Stop the bugfix creation process
   - **Never lose user's work** - Always preserve or explicitly confirm before discarding
   
   c. **Switch to Master:**
   - If not on master: `git checkout master`
   - Pull latest: `git pull origin master`
   - Verify clean state: `git status` (should show "nothing to commit, working tree clean")
   
   d. **Create New Fix Branch:**
   - Create branch from master: `git checkout -b fix/[generated-name]`
   - Push to remote: `git push -u origin fix/[generated-name]`
   - Confirm branch creation: `git branch --show-current` (should show new branch)

**Phase 4: Complete Documentation Setup**
6. **Initialize progress.log:**
   - Create `progress.log` in task folder with initial entry:
```
##############################################################################
# BUG FIX PROGRESS LOG - [TICKET-ID]
##############################################################################
[current-timestamp] - Bug fix branch created: fix/[branch-name]
[current-timestamp] - Documentation structure set up
[current-timestamp] - Ready to begin investigation

# Format for future entries:
# [timestamp] - [Action taken] - [Result/Finding]
##############################################################################
```

7. **Verification and Summary:**
   - Confirm all 4 files created:
     - ✅ README.md (customized with branch name and bug details)
     - ✅ bug-report.md (populated with ticket information)
     - ✅ fix-plan.md (ready for investigation planning)
     - ✅ progress.log (initialized with setup log)
   - Display task folder location: `/todo/current/fixes/[branch-name]/`
   - Show branch name: `fix/[branch-name]`

**🎯 USAGE EXAMPLES:**
```bash
/create-bugfix REQUESTDESK-BACKEND-9
/create-bugfix SUPPORT-456
/create-bugfix SENTRY-789
```

**✅ AUTOMATED ACTIONS:**
1. Parse ticket ID and validate source
2. Create standardized fix branch from clean master
3. Copy and customize README.md template with bug-specific file catalog
4. Generate complete documentation structure (4 files)
5. Initialize progress tracking
6. Ready for immediate investigation work

**🔄 POST-FIX WORKFLOW:**
1. Work on fix using the documentation structure
2. Update progress.log with investigation findings
3. Test fix using `/project:deploy-code`
4. After verification, use `/claude-complete` to archive
5. Update original Sentry/Support ticket with resolution
6. Task moves to `/todo/completed/fixes/`

**📁 RESULT STRUCTURE:**
```
/todo/current/fixes/[branch-name]/
├── README.md              # Task overview with branch name and status
├── bug-report.md          # Detailed bug analysis and reproduction
├── fix-plan.md            # Investigation strategy and solutions
└── progress.log           # Chronological fix attempts and results
```

**🚨 CRITICAL SUCCESS FACTORS:**
- ✅ Always ask for clarification on ambiguous ticket IDs
- ✅ Start from clean master branch (handle uncommitted changes safely)
- ✅ Copy README.md template and customize with branch name
- ✅ Create all 4 required files with proper templates
- ✅ Initialize progress.log for tracking investigation