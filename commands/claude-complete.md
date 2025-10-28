Complete branch workflow with comprehensive checklist and finalization

**🎯 PURPOSE:**
Systematically complete a branch by verifying all work is done, merging to master, archiving documentation, and cleaning up - ensuring nothing is forgotten.

**⚡ QUICK USAGE:**
`/claude-complete` - Run full completion checklist for current branch

**Phase 0: Pre-Completion Checklist ✅**
1. **🔒 Final Security Scan:**
   - Run comprehensive security scan one last time
   - Ensure no credentials or sensitive data in commits
   - Generate final security report for branch
   - Block completion if CRITICAL issues found

2. **📋 Completion Checklist (Interactive):**
   ```
   BRANCH COMPLETION CHECKLIST - feature/api-integration
   
   Code Quality:
   ✅ All tests passing? [Y/n]: _
   ✅ Linting/type checking clean? [Y/n]: _
   ✅ Code reviewed/tested? [Y/n]: _
   
   Documentation:
   ✅ README updated? [Y/n]: _
   ✅ API docs updated? [Y/n]: _
   ✅ CHANGELOG entry added? [Y/n]: _
   ✅ Technical docs complete? [Y/n]: _
   
   Testing:
   ✅ Local testing complete? [Y/n]: _
   ✅ Production deployed? [Y/n]: _
   ✅ Production verified? [Y/n]: _
   
   Cleanup:
   ✅ No console.logs/debug code? [Y/n]: _
   ✅ Environment variables documented? [Y/n]: _
   ✅ Migration notes added (if needed)? [Y/n]: _
   
   Continue with completion? [Y/n]: _
   ```

**Phase 1: Branch Analysis & Validation**
3. **Analyze Current Branch:**
   - Detect current branch name and type (feature/fix/enhancement/etc.)
   - Find corresponding task folder in `/todo/current/[branch-type]/`
   - Verify branch is fully merged to master or ready to merge
   - Check for any uncommitted changes

**Phase 2: Merge to Master**
4. **Ensure Branch is Merged:**
   - Check if already merged: `git branch --merged master`
   - If not merged:
     ```bash
     git checkout master
     git pull origin master
     git merge [branch-name] --no-ff -m "merge: Complete [branch-name]"
     git push origin master
     ```
   - Verify merge was successful
   - Handle any merge conflicts if they arise

**Phase 3: Archive Work & Context**
5. **Move Task to Completed:**
   - Move entire branch folder from `/todo/current/[branch-type]/` to `/todo/completed/`
   - Add completion timestamp to folder name: `[branch-name]-completed-[date]`
   - Update final status in task documents
   - Add final testing results and production notes

6. **Archive Branch Context:**
   - Move `.claude/branch-context/[type]-[branch]-context.md` to completed task folder
   - Update context file with completion status and final notes
   - This preserves complete history with the completed work

7. **🔒 Validate Completed Directory Structure:**
   - **CRITICAL**: Ensure `/todo/completed/` contains exactly 4 subdirectories
   - **Required subdirectories**: `feature`, `fix`, `infrastructure`, `refactor`
   - **Validation script**:
     ```bash
     COMPLETED_DIRS=$(ls -1 /todo/completed/ | wc -l)
     EXPECTED_DIRS=4

     if [ "$COMPLETED_DIRS" -ne "$EXPECTED_DIRS" ]; then
       echo "❌ ERROR: Invalid completed directory structure!"
       echo "Expected exactly 4 subdirectories: feature, fix, infrastructure, refactor"
       echo "Found $COMPLETED_DIRS directories:"
       ls -1 /todo/completed/
       echo "Please fix directory structure before completing."
       exit 1
     fi

     echo "✅ Completed directory structure validated (4 subdirectories)"
     ```
   - **Prevents**: Random directories like `hotfix/`, `enhancement/`, `bugfix/`
   - **Ensures**: Clean, organized, predictable structure for team collaboration

**Phase 4: Update User Documentation** 
3. **Comprehensive Documentation Update:**
   - Based on branch type, update appropriate `/docs/` sections:
     - **Features:** User guides, feature documentation, API docs
     - **Fixes:** Update known issues lists, troubleshooting guides, Bug Registry status
     - **Enhancements:** Update existing feature documentation
     - **Bug Fixes:** Mark bug as resolved in `/documentation/docs/technical/bug-fixes/BUG-REGISTRY.md`
   - Include screenshots, examples, or tutorials if needed
   - Update navigation/index files to reflect changes

4. **Finalize Changelog Entry:**
   - Update `/docs/changelog.md` 
   - Mark current build as tested and confirmed
   - Add any additional user-facing details discovered during testing
   - Clean up technical details that users don't need to see
   - Mark build as "✅ Tested and Confirmed"

**Phase 5: Technical Documentation Finalization**
5. **Complete Technical Docs:**
   - Finalize `/technical/` documentation
   - Add performance metrics, monitoring notes
   - Document any production-specific configurations
   - Add maintenance or troubleshooting procedures
   - Update technical architecture docs if needed
   - **For Bug Fixes:** Update Sentry Error Catalog with resolution details and monitoring notes

**Phase 6: Branch & Git Cleanup**
8. **Clean Up Development Branch:**
   - Verify branch is fully merged and deployed to production
   - Confirm all documentation is updated
   - Delete the branch locally: `git branch -d [current-branch]`
   - Delete remote branch: `git push origin --delete [current-branch]`
   - Switch to master branch after cleanup

**Phase 7: Version Management & Tagging**
9. **Create Completion Tag:**
   - Create a git tag for completed work:
     ```bash
     git tag -a "completed-[branch-name]-v[version]" -m "Completed: [description]"
     git push origin --tags
     ```
   - This preserves a permanent record of completion

**Phase 8: Version Planning**
7. **Version Planning:**
   - Check if this completes a version milestone
   - Determine next version number based on current version
   - Update version planning documents in `/TODO/`
   - Note any dependencies this completion unlocks

**Phase 9: Final Documentation Commit**
8. **Documentation Commit:**
   - Create comprehensive commit for documentation updates
   - Message format: "Complete [detected-version]: [branch-name] - all testing confirmed"
   - Commit from master branch (documentation-only changes)
   - Push to master

**Phase 10: Post-Completion Summary & Next Steps**
11. **Generate Completion Report:**
   ```
   ✅ BRANCH COMPLETED: feature/api-integration
   
   📊 COMPLETION SUMMARY:
   - Branch Type: feature
   - Work Duration: 3 days
   - Commits: 24
   - Files Changed: 18
   - Tests Added: 12
   - Security Score: 95/100
   
   📁 ARCHIVED TO:
   - Task: /todo/completed/feature-api-integration-20250904/
   - Context: Moved to task folder
   - Documentation: Updated in /documentation/
   
   🔒 SECURITY FINAL:
   - No critical issues ✅
   - 2 warnings documented for future work
   
   📋 DOCUMENTATION UPDATED:
   - CHANGELOG.md: v0.28.1 entry
   - README.md: New feature section
   - API docs: 3 new endpoints
   - Technical docs: Architecture updated
   
   🏷️ GIT STATUS:
   - Merged to master ✅
   - Branch deleted (local & remote) ✅
   - Tagged: completed-feature-api-integration-v0.28.1
   
   🎯 SUGGESTED NEXT STEPS:
   1. Review backlog in /todo/backlog/
   2. Start new feature with /project:create-branch
   3. Address security warnings in next session
   ```
9. **Completion Summary:**
   - Branch completed: [branch-name]
   - Branch type: [feature/fix/etc.]
   - Documentation updated in: /docs/ and /technical/
   - Task moved to: /TODO/completed/
   - **Bug Fix Specific:** Bug registry updated, Sentry catalog updated, monitoring notes added
   - Next suggested action: Start new branch or continue with backlog

**🛡️ SAFETY FEATURES:**
- Blocks completion if security issues found
- Requires checklist confirmation for all items
- Preserves branch context in completed folder
- Creates git tag for permanent record
- Generates comprehensive completion report

**🔄 INTEGRATION:**
- Works with `/claude-start` for fresh begins after completion
- Updates all documentation touched by `/claude-close`
- Preserves context from `/claude-clean` branch saves
- Security validation from `/claude-commit` framework

**📝 ADDITIONAL COMPLETION TASKS TO CONSIDER:**
- Update team communication channels about completion
- Close related GitHub issues or tickets
- Update project roadmap/kanban board
- Schedule follow-up monitoring for new features
- Document any technical debt incurred
- Update dependency documentation if libraries added
- Notify stakeholders of feature availability

This ensures thorough, systematic branch completion with nothing forgotten!