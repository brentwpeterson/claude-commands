# Smart Compact - Context Preservation + Conversation Compact

**USAGE:**
- `/smart-compact` - Preserve important context then compact conversation

**🚨 PURPOSE:**
Intelligently preserve current session's important contextual information by adding to the existing branch context file, then run compact while preserving only references to that context.

**📋 SMART-COMPACT WORKFLOW:**

**Phase 1: Context Preservation (Additive)**
1. **Get Current Branch:**
   - Get branch: `git branch --show-current`
   - Convert to context file name: `fix/save-as-draft-button` → `fix-save-as-draft-button-context.md`
   - Target file: `.claude/branch-context/fix-save-as-draft-button-context.md`

2. **Gather Current Session Context:**
   - Current implementation decisions made this session
   - Code patterns established
   - Key file changes and their purposes
   - Any TODOs or next steps identified
   - Problem-solving approaches used
   - Error patterns and solutions discovered

3. **ADD to Branch Context File (Create if Missing):**
   - **IF FILE EXISTS**: **APPEND** new session information, **NEVER REPLACE** existing content
   - **IF FILE MISSING**: **CREATE** new file with current session context
   - **ALWAYS PRESERVE** all previous context when file exists
   - **ENHANCE** with current session's insights
   - Format as new session entry with timestamp

**Phase 2: Context File Update Format**
```markdown
## Smart Compact Session - [YYYY-MM-DD HH:MM] UTC

### Current Session Context
**Implementation Decisions:**
- [Key decisions made this session]

**Code Patterns Established:**
- [Patterns we've used/established]

**Key File Changes:**
- [Important files modified and why]

**TODOs/Next Steps:**
- [Any pending work or next actions]

**Problem-Solving Insights:**
- [Error patterns, solutions, debugging approaches]

**Current Status:**
- [Where we left off]

---
```

**Phase 3: Compact with Context References**
4. **Run Compact:**
   - Execute `/compact` command
   - Preserve references to the branch context file
   - Maintain link to `.claude/branch-context/[branch-name]-context.md`

**🎯 SMART-COMPACT BENEFITS:**
- **Preserves implementation decisions** for future sessions
- **Maintains code patterns** and approaches
- **Tracks file changes** and their rationale
- **Saves debugging insights** and error solutions
- **Reduces context switching** cost in future sessions
- **Builds institutional knowledge** over time

**🔄 INTEGRATION WITH EXISTING SYSTEM:**
- **Uses same branch context files** as `/claude-close`
- **Additive approach** - never destroys existing context
- **Compatible with `/claude-start`** context recovery
- **Preserves debugging history** and session progress

**⚡ WHEN TO USE:**
- Before running out of context in long debugging sessions
- When switching between complex features
- After making important implementation decisions
- When discovering key patterns or solutions
- Before stepping away from complex work

**🎯 SUCCESS INDICATORS:**
- Branch context file updated with current session insights
- All important decisions and patterns preserved
- Conversation compacted but context accessible
- Future sessions can quickly recover implementation context
- No loss of debugging insights or problem-solving approaches

This command bridges the gap between losing context due to conversation limits and preserving the intellectual work done in complex sessions.