Create bugfix branch from ticket: $ARGUMENTS

**Ticket ID:** $ARGUMENTS (format: SOURCE-ID, e.g., REQUESTDESK-BACKEND-9, SUPPORT-123)
**Action:** Create fix branch, fetch ticket details, document bug, set up fix tracking

**Phase 1: Parse Ticket Information**
1. **Extract Ticket Source and ID:**
   - Parse ticket format: `[SOURCE]-[PROJECT]-[ID]` or `[SOURCE]-[ID]`
   - Supported sources:
     - **REQUESTDESK-[PROJECT]-[ID]** - Sentry issues (e.g., REQUESTDESK-BACKEND-9)
     - **SUPPORT-[ID]** - Support system tickets
     - **SENTRY-[ID]** - Direct Sentry reference
     - **TICKET-[ID]** - Generic ticket format
   - Extract components for API calls and documentation
   
   **IMPORTANT: If ticket format is unclear or ambiguous:**
   - **ASK THE USER:** "I see ticket [ID]. Could you clarify the source? Is this from:"
     - Sentry (error monitoring)
     - Support system (customer tickets)
     - GitHub Issues
     - Internal tracking system
     - Other (please specify)
   - **Never assume** - Always ask when format doesn't match known patterns
   - **Examples of ambiguous formats:** 
     - Just a number: "123" 
     - Unknown prefix: "BUG-456"
     - Custom format: "2024-ERROR-789"

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

4. **Create Bug Documentation:**
   - Create folder: `/TODO/current/fixes/[branch-name]/`
   - Generate `BUG-REPORT.md` with:
     ```markdown
     # Bug Report: [TICKET-ID]
     
     ## Source
     - **System:** [Sentry/Support]
     - **Ticket ID:** [FULL-ID]
     - **Date Reported:** [DATE]
     - **Priority:** [HIGH/MEDIUM/LOW]
     - **Affected Users:** [COUNT or LIST]
     
     ## Issue Description
     [Parsed from ticket or manually entered]
     
     ## Error Details (if Sentry)
     - **Environment:** [PRODUCTION/DEVELOPMENT - CRITICAL TO IDENTIFY]
     - **Error Message:** [FROM SENTRY]
     - **Stack Trace:** [ABBREVIATED]
     - **Frequency:** [X occurrences in Y time]
     - **First Seen:** [DATE]
     - **Last Seen:** [DATE]
     
     ## Reproduction Steps
     1. [To be filled during investigation]
     
     ## Root Cause Analysis
     - [ ] Issue identified
     - [ ] Root cause documented
     - [ ] Fix approach determined
     
     ## Fix Implementation
     - [ ] Code changes made
     - [ ] Tests added/updated
     - [ ] Local testing complete
     - [ ] Ready for deployment
     
     ## Verification
     - [ ] Error no longer occurs
     - [ ] Sentry/Support ticket can be closed
     - [ ] No regression issues
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

**Phase 4: Set Up Fix Tracking**
6. **Initialize Fix Workspace:**
   - **CREATE DEBUG LOG:**
     - Create file: `[generated-branch-name]-debug.log` in task folder
     - Initialize with template:
       ```
       ##############################################################################
       # TEST ATTEMPT LOG
       ##############################################################################
       # 1. YYYY-MM-DD HH:MM - [Description of initial bugfix branch creation]
       # 2. YYYY-MM-DD HH:MM - [Description of first investigation/test attempt]
       # 3. YYYY-MM-DD HH:MM - [Description of second modification/test attempt]
       # [Add additional entries as testing progresses]
       ##############################################################################
       ```
   - Create `FIX-PLAN.md` with:
     - Investigation steps
     - Potential solutions
     - Testing checklist
   - If Sentry issue, save relevant logs/traces
   - Set up test scripts in `/backend/tests/fixes/[ticket-id]/`

7. **Update Tracking Systems:**
   - Add entry to `/TODO/fixes-tracker.md`:
     ```markdown
     ## Active Fixes
     - **[TICKET-ID]**: [Description]
       - Branch: `fix/[branch-name]`
       - Started: [DATE]
       - Status: Investigation
       - Assignee: [Developer]
     ```
   - Create GitHub issue if needed
   - Link Sentry issue to branch (if applicable)

**Phase 5: Investigation Setup**
8. **Prepare Debug Environment:**
   - For the example error (partnership tickets):
     - Identify affected endpoint: `/api/tickets`
     - Locate code: `app.routers.tickets.list_tickets`
     - Create debug script to reproduce issue
   - Add debug logging to track issue
   - Document findings in `BUG-REPORT.md`

**Usage Examples:**
- `/project:create-bugfix REQUESTDESK-BACKEND-9`
- `/project:create-bugfix SUPPORT-456`
- `/project:create-bugfix SENTRY-789`

**Automated Actions:**
1. Parse ticket ID and source
2. Create standardized fix branch
3. Generate bug documentation structure
4. Set up investigation workspace
5. Track fix progress in central location

**Post-Fix Workflow:**
- Once fixed, use `/project:deploy-code` for testing
- After verification, use `/claude-complete`
- Update Sentry/Support ticket with resolution
- Archive fix documentation to `/TODO/completed/fixes/`