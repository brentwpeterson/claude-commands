Complete Todo - Document achievements and move to completed folder

**USAGE:** `/finish-todo <todo-folder-path>` - Complete a todo by documenting achievements and moving it to completed

**🎯 PURPOSE:**
Archive completed todo with proper documentation of technical achievements, lessons learned, and user documentation.

**📋 INSTRUCTIONS:**

1. **VALIDATE TODO PATH:**
   - Confirm the path exists and is in a `todo/current/` directory
   - Extract project name (cb-requestdesk, cb-shopify, etc.) from path
   - Extract category (feature, bugfix, infrastructure, etc.) and folder name
   - If path invalid, show error and ask for correction

2. **READ EXISTING TODO CONTENT:**
   - Read the main plan/requirements file to understand original goals
   - Check for progress logs, notes, debug logs to understand what was done
   - Look for completion criteria that were defined
   - Summarize the original objectives for context

3. **GATHER COMPLETION DOCUMENTATION:**
   Use the AskUserQuestion tool to collect:
   - **Technical Summary**: What was built/changed (files modified, architecture decisions, new features implemented)
   - **Lessons Learned**: Development insights, challenges faced, solutions found, what would be done differently next time
   - **Frontend User Documentation**: Any user-facing documentation needed for Astro sites or other frontend components

4. **HANDLE ASSOCIATED GIT BRANCH:**
   Use the AskUserQuestion tool to determine branch completion:
   - **Identify Branch**: Extract branch name from todo README.md or derive from folder name pattern
   - **Current Branch Status**: Check if branch exists and current git status
   - **Branch Completion Options**: Ask user what to do with the associated branch:
     - "Merge to main and delete branch" - Complete integration and cleanup
     - "Keep branch for future work" - Leave branch intact for continued development
     - "Delete branch without merging" - Discard branch (experimental work)
     - "No associated branch" - Todo was not branch-based work
   - **Execute Branch Action**: Perform the selected branch operation with appropriate git commands

5. **CREATE COMPLETION DOCUMENTATION:**
   Write documentation to permanent locations in /documentation/cb-requestdesk/:
   - `technical-docs/[task-name]-completion-YYYY-MM-DD.md` - Technical summary and achievements
   - `technical-docs/[task-name]-lessons-learned-YYYY-MM-DD.md` - Development insights and future improvements
   - `user-docs/[task-name]-user-guide-YYYY-MM-DD.md` - Frontend user documentation (if applicable)
   - Add completion entry to todo folder: `completion-date.txt` with timestamp

6. **MOVE TODO FOLDER:**
   - Calculate source: `todo/current/[category]/[folder-name]`
   - Calculate destination: `todo/completed/[category]/[folder-name]`
   - Create destination directory structure if needed: `mkdir -p todo/completed/[category]`
   - Move entire folder: `mv [source] [destination]`
   - Verify move was successful by checking destination exists and source is gone

7. **CONFIRM COMPLETION:**
   - Show new todo location: "✅ Todo moved to: [destination-path]"
   - List documentation created: "📄 Technical docs: /documentation/cb-requestdesk/technical-docs/[files]"
   - List user documentation: "📄 User docs: /documentation/cb-requestdesk/user-docs/[files]"
   - Confirm branch action: "🌿 Git branch: [action taken - merged/kept/deleted]"
   - Confirm all files preserved: "📁 All original files preserved in completed location"

**🔄 WORKFLOW EXAMPLE:**
```
User: /finish-todo /Users/brent/.../todo/current/feature/astro-business-site-plan
Claude: [Reads existing content] → [Prompts for documentation] → [Asks about branch handling] → [Creates docs in /documentation/] → [Handles git branch] → [Moves todo folder] → [Confirms success]
Result:
- Technical docs: /documentation/cb-requestdesk/technical-docs/astro-business-site-plan-completion-2025-11-11.md
- User docs: /documentation/cb-requestdesk/user-docs/astro-business-site-plan-user-guide-2025-11-11.md
- Git branch: feature/astro-business-site-plan merged to main and deleted
- Todo archived: /todo/completed/feature/astro-business-site-plan/
```

**⚠️ IMPORTANT:**
- Create documentation in /documentation/cb-requestdesk/ BEFORE moving todo folder
- Write technical docs to technical-docs/ and user docs to user-docs/
- Handle git branch completion BEFORE moving todo folder
- Move ENTIRE todo folder including all logs, debug files, etc.
- Preserve exact folder structure in todo/completed/ location
- Use bash commands for file operations (mkdir -p, mv)
- Always verify operations completed successfully

**🌿 GIT BRANCH HANDLING:**
- Check if current branch matches the todo (extract from README.md or derive from folder name)
- Ask user preference for branch completion - don't assume they want to merge
- For merge operations: ensure clean working directory and up-to-date main branch
- For deletion: verify branch is fully integrated or user confirms intentional deletion
- Always confirm git operations completed successfully before proceeding