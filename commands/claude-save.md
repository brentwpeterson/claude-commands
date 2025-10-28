Claude Session Save - Context + Work Preservation

**USAGE:** `/claude-save <project>` - Save context AND commit development work for session restart

**🎯 PURPOSE:**
Save conversation context + preserve all development work, then prepare for `/clear new` + `/claude-start` workflow

**📋 COMPLETE SAVE WORKFLOW:**

**Phase 1: Work Preservation**
1. **Check Development Status:**
   - Run `git status` to identify all modified/untracked files
   - Analyze changes to understand what work has been completed
   - Ensure no sensitive files (.env, keys, etc.) are included

2. **Commit Development Work:**
   - Stage all relevant development files: `git add [relevant-files]`
   - Create descriptive commit message based on changes
   - Format: `git commit -m "[Description of work completed] 🤖 Generated with Claude Code"`
   - **IMPORTANT**: Commit actual development work FIRST before context

**Phase 2: Context Capture**
3. **Save Branch Context:**
   - Get current branch: `git branch --show-current`
   - Get working directory: `pwd`
   - Create/update: `.claude/branch-context/[branch-name]-context.md`
   - Include: conversation summary, key decisions, immediate next steps
   - **Capture current todos**: Include any active TodoWrite items with their status

4. **Update CLAUDE.md Header:**
   - Insert at top of CLAUDE.md (project-specific):
     - Current branch and working directory
     - Session accomplishments (brief)
     - Next priority action (single line)
     - Status: ready for restart

**Phase 3: Context Commit**
5. **Context Commit:**
   - Stage context files: `git add ../.claude/` (workspace-level branch context)
   - Stage CLAUDE.md: `git add CLAUDE.md` (project-level)
   - Commit with: "Save context for session restart"

6. **Exit Signal:**
   - Say "WORK & CONTEXT SAVED - Ready for /clear new"

**🔄 TWO-COMMIT STRATEGY:**
1. **First commit**: Development work with descriptive message
2. **Second commit**: Context files for session recovery
3. **Result**: Clean git history + preserved context + no lost work

**⚡ COMPREHENSIVE BUT EFFICIENT:**
- Preserves all development work (prevents data loss)
- Saves conversation context for seamless restart
- Two focused commits for clean git history
- Ready for immediate `/clear new` + `/claude-start`

**🔄 EXPECTED WORKFLOW:**
1. `/claude-save <project>`
2. `/clear new`
3. `/claude-start`