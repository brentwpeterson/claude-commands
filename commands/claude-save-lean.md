Claude Session Save - Lean Version (Low Context Usage)

**USAGE:** `/claude-save-lean <keyword>` - Efficient session save with minimal context usage

**🎯 PURPOSE:**
Create essential handoff instructions with 70-80% less context usage than full claude-save

**🚀 STREAMLINED WORKFLOW:**

**Phase 1: Quick Work Preservation**
1. **Single Git Operation:**
   ```bash
   git add . && git commit -m "Session save: $(date '+%Y-%m-%d %H:%M') - [brief description]

   🤖 Generated with Claude Code" && echo "✅ Changes committed"
   ```

**Phase 2: Essential Context Creation**
2. **Single Context File Write:**
   ```bash
   BRANCH=$(git branch --show-current)
   TODO_PATH=$(find . -name "README.md" -path "*/todo/current/*" | head -1)
   cat > .claude/branch-context/${keyword:-$(echo $BRANCH | sed 's/\//-/g')}-context.md << 'EOF'
   # Resume Instructions for Claude

   ## IMMEDIATE SETUP
   1. **Directory:** `cd $(pwd)`
   2. **Branch:** `git checkout $BRANCH`
   3. **Status:** $(git status --porcelain | wc -l) files changed

   ## CURRENT TODO
   **Path:** ${TODO_PATH:-"No todo directory found"}
   **Status:** [Current work focus - FILL MANUALLY]

   ## WHAT YOU WERE WORKING ON
   [Brief description of current task - FILL MANUALLY]

   ## NEXT ACTIONS
   1. **FIRST:** [Next command to run - FILL MANUALLY]
   2. **THEN:** [Follow-up action - FILL MANUALLY]

   ## NOTES
   [Any important context - FILL MANUALLY]
   EOF
   ```

**Phase 3: Quick MCP Integration (Optional)**
3. **Minimal MCP Storage:**
   ```bash
   # Only if MCP available - single test query, no large operations
   echo "🧠 Testing MCP availability..."
   ```

**Phase 4: Display Path**
4. **Show Result:**
   ```bash
   echo "📁 Resume instructions: .claude/branch-context/${keyword:-$(git branch --show-current | sed 's/\//-/g')}-context.md"
   ```

**🎯 KEY DIFFERENCES FROM FULL CLAUDE-SAVE:**

**REMOVED (High Context Usage):**
- ❌ Todo directory validation (multiple ls commands)
- ❌ File counting operations
- ❌ Architecture map validation
- ❌ Multiple file updates with diffs
- ❌ Verbose bash command outputs
- ❌ Branch README.md updating
- ❌ Complex MCP operations

**KEPT (Essential):**
- ✅ Git commit with changes
- ✅ Basic context file creation
- ✅ Current branch/directory capture
- ✅ Simple todo path detection
- ✅ MCP test (minimal)

**📊 ESTIMATED CONTEXT REDUCTION:**
- **Full claude-save**: ~13% context usage
- **claude-save-lean**: ~2-3% context usage
- **Reduction**: 70-80% less context consumed

**📝 MANUAL CONTEXT COMPLETION:**
Since this is lean, you'll need to manually fill in:
- Current work description
- Next actions
- Important notes

**🔄 WHEN TO USE:**
- **claude-save-lean**: For quick saves, frequent checkpoints, context-limited situations
- **claude-save**: For comprehensive handoffs, complex projects, end-of-session saves

**🛠️ IMPLEMENTATION:**

**Step 1: Minimal Git Commit**
```bash
# Single efficient commit
git add . && git commit -m "Session save: $(date '+%Y-%m-%d %H:%M') - [brief]

🤖 Generated with Claude Code"
```

**Step 2: Essential Context Template**
```bash
# Create minimal context file with placeholders
BRANCH=$(git branch --show-current)
KEYWORD=${1:-$(echo $BRANCH | sed 's/\//-/g')}

cat > .claude/branch-context/${KEYWORD}-context.md << EOF
# Resume Instructions for Claude

## IMMEDIATE SETUP
1. **Directory:** \`cd $(pwd)\`
2. **Branch:** \`git checkout $BRANCH\`
3. **Changes:** $(git status --porcelain | wc -l) modified files

## CURRENT TODO
**Path:** $(find . -name "README.md" -path "*/todo/current/*" | head -1 || echo "No todo found")
**Status:** [MANUAL: Current focus]

## WORKING ON
[MANUAL: Brief task description]

## NEXT ACTIONS
1. [MANUAL: Next command]
2. [MANUAL: Follow-up]

## NOTES
[MANUAL: Key context]

Created: $(date)
EOF

echo "📁 Context saved: .claude/branch-context/${KEYWORD}-context.md"
echo "✏️ Fill in [MANUAL] sections for complete handoff"
```

**Step 3: Quick MCP Test (Minimal)**
```bash
# Test MCP with single lightweight query
if command -v mcp >/dev/null 2>&1; then
    echo "🧠 MCP available"
else
    echo "⚠️ MCP not available - file-based only"
fi
```

**🎯 USAGE EXAMPLES:**

```bash
# Quick save with keyword
/claude-save-lean debugging

# Quick save with branch name
/claude-save-lean

# For ongoing work
/claude-save-lean feature-work
```

**📋 POST-SAVE CHECKLIST:**
After running `/claude-save-lean`, manually complete:

1. **[MANUAL: Current focus]** - What you're working on
2. **[MANUAL: Brief task description]** - Current task
3. **[MANUAL: Next command]** - Exact next step
4. **[MANUAL: Follow-up]** - What comes after
5. **[MANUAL: Key context]** - Important notes

**⚡ EFFICIENCY GAINS:**
- **Single git command** instead of multiple operations
- **No verbose ls/find operations**
- **No file counting or validation**
- **No complex MCP operations**
- **Template-based context** instead of dynamic generation
- **Manual completion** instead of automated verbose discovery

**🔄 INTEGRATION WITH CLAUDE-START:**
The `/claude-start` command can read both full and lean context files - format is compatible.