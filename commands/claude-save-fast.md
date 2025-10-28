Claude Session Fast Save - Context Only Preservation

**USAGE:** `/claude-save-fast <project>` - Save conversation context quickly without git operations

**🎯 PURPOSE:**
Save conversation context for session restart without analyzing/committing development work

**📋 FAST SAVE WORKFLOW:**

**Phase 1: Context Capture Only**
1. **Get Current State:**
   - Get current branch: `git branch --show-current`
   - Get working directory: `pwd`
   - Capture current TodoWrite items with their status

2. **Save Branch Context:**
   - Create/update: `.claude/branch-context/[branch-name]-context.md`
   - Include: conversation summary, key decisions, immediate next steps
   - Include: current TodoWrite status
   - Include: session accomplishments summary

3. **Update CLAUDE.md Header:**
   - Insert at top of CLAUDE.md (project-specific):
     - Current branch and working directory
     - Session accomplishments (brief)
     - Next priority action (single line)
     - Status: ready for restart

**Phase 2: Minimal Commit**
4. **Context-Only Commit:**
   - Stage context files: `git add ../.claude/branch-context/`
   - Stage CLAUDE.md: `git add CLAUDE.md`
   - Commit with: "Save context for session restart - Fast save"

5. **Exit Signal:**
   - Say "CONTEXT SAVED (Fast) - Ready for /clear new"

**⚡ FAST & LIGHTWEIGHT:**
- **Skips**: Git status analysis, file analysis, development work commits
- **Focuses**: Pure conversation context preservation
- **Benefits**: Much lower context usage, quick execution
- **Trade-off**: No automatic work preservation (manual git management needed)

**🔄 EXPECTED WORKFLOW:**
1. `/claude-save-fast <project>`
2. `/clear new`
3. `/claude-start`

**📝 NOTE:**
This saves conversation context but does NOT preserve uncommitted development work.
Use regular `/claude-save` if you need comprehensive work + context preservation.