Claude Fast Save - Ultra-Minimal Resume Instructions

**USAGE:** `/claude-save-fast <project>` - Create bare minimum resume instructions in seconds

**🎯 PURPOSE:**
Ultra-fast context save - JUST save current state, NO questions, NO analysis

**⚡ INSTANT SAVE WORKFLOW:**

**Step 1:** Get current state (pwd, git branch, current todos)
**Step 1b:** Quick README branch verification:
```bash
CURRENT_BRANCH=$(git branch --show-current)
if [ -f "todo/current/*/README.md" ]; then
  README_FILE=$(find todo/current -name "README.md" 2>/dev/null | head -1)
  if [ -n "$README_FILE" ] && ! grep -q "**Branch:** $CURRENT_BRANCH" "$README_FILE"; then
    sed -i.bak "s/\*\*Branch:\*\* .*/\*\*Branch:\*\* $CURRENT_BRANCH/" "$README_FILE"
    echo "✅ Updated README.md branch reference"
  fi
fi
```
**Step 2:** Write `.claude/branch-context/[branch-name]-context.md` with:
```markdown
# Resume: [branch-name]

## SETUP
cd [directory] && git checkout [branch]

## CURRENT WORK
[Current todos and status]

## NEXT ACTION
[What to do next]
```

**Step 3:** Display saved file path - DONE

**🚀 FEATURES:**
- NO questions asked
- NO analysis or verification
- INSTANT save in seconds
- Simple 3-section template

**📝 USAGE:**
Save context fast when running out of space - shows file path when done