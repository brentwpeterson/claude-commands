#!/bin/bash
# File Discipline Hook - PreToolUse(Write)
# Blocks file creation in prohibited locations
# Reads tool input JSON from stdin, checks file_path against allowed list
# Exit 0 = allow, Exit 2 = block

WORKSPACE_ROOT="/Users/brent/scripts/CB-Workspace"

# Read JSON input from stdin
INPUT=$(cat)

# Extract file_path from the tool input
FILE_PATH=$(echo "$INPUT" | python3 -c "
import json, sys
data = json.load(sys.stdin)
# Tool input is in 'input' key
tool_input = data.get('input', {})
print(tool_input.get('file_path', tool_input.get('filePath', '')))
" 2>/dev/null)

if [ -z "$FILE_PATH" ]; then
  # Can't determine path, allow (don't break things)
  exit 0
fi

# Allowed location patterns
ALLOWED=0

# .claude/branch-context/ - Session context files
if [[ "$FILE_PATH" == "$WORKSPACE_ROOT/.claude/branch-context/"* ]]; then
  ALLOWED=1
fi

# .claude/claude-comms/ - Inter-Claude messages
if [[ "$FILE_PATH" == "$WORKSPACE_ROOT/.claude/claude-comms/"* ]]; then
  ALLOWED=1
fi

# .claude/local/ - Temp/scratch files (gitignored)
if [[ "$FILE_PATH" == "$WORKSPACE_ROOT/.claude/local/"* ]]; then
  ALLOWED=1
fi

# .claude/violations/ - Violation logs
if [[ "$FILE_PATH" == "$WORKSPACE_ROOT/.claude/violations/"* ]]; then
  ALLOWED=1
fi

# .claude/learning/ - Learning moments
if [[ "$FILE_PATH" == "$WORKSPACE_ROOT/.claude/learning/"* ]]; then
  ALLOWED=1
fi

# .claude/security-scans/ - Security scan reports
if [[ "$FILE_PATH" == "$WORKSPACE_ROOT/.claude/security-scans/"* ]]; then
  ALLOWED=1
fi

# .claude/hooks/ - Hook scripts (self-management)
if [[ "$FILE_PATH" == "$WORKSPACE_ROOT/.claude/hooks/"* ]]; then
  ALLOWED=1
fi

# .claude/settings files
if [[ "$FILE_PATH" == "$WORKSPACE_ROOT/.claude/settings"* ]]; then
  ALLOWED=1
fi

# Project source directories (code files for active tasks)
# requestdesk-app
if [[ "$FILE_PATH" == "$WORKSPACE_ROOT/requestdesk-app/"* ]]; then
  ALLOWED=1
fi
if [[ "$FILE_PATH" == "$WORKSPACE_ROOT/requestdesk-app-testing/"* ]]; then
  ALLOWED=1
fi

# astro-sites
if [[ "$FILE_PATH" == "$WORKSPACE_ROOT/astro-sites/"* ]]; then
  ALLOWED=1
fi

# cb-shopify
if [[ "$FILE_PATH" == "$WORKSPACE_ROOT/cb-shopify/"* ]]; then
  ALLOWED=1
fi

# requestdesk-wordpress
if [[ "$FILE_PATH" == "$WORKSPACE_ROOT/requestdesk-wordpress/"* ]]; then
  ALLOWED=1
fi

# wordpress-sites
if [[ "$FILE_PATH" == "$WORKSPACE_ROOT/wordpress-sites/"* ]]; then
  ALLOWED=1
fi

# cb-magento-integration
if [[ "$FILE_PATH" == "$WORKSPACE_ROOT/cb-magento-integration/"* ]]; then
  ALLOWED=1
fi

# cb-junogo
if [[ "$FILE_PATH" == "$WORKSPACE_ROOT/cb-junogo/"* ]]; then
  ALLOWED=1
fi

# jobs
if [[ "$FILE_PATH" == "$WORKSPACE_ROOT/jobs/"* ]]; then
  ALLOWED=1
fi

# brent-workspace (Obsidian notes - allowed for content skills)
if [[ "$FILE_PATH" == "$WORKSPACE_ROOT/brent-workspace/"* ]]; then
  ALLOWED=1
fi

# brent-timekeeper
if [[ "$FILE_PATH" == "$WORKSPACE_ROOT/brent-timekeeper/"* ]]; then
  ALLOWED=1
fi

# documentation
if [[ "$FILE_PATH" == "$WORKSPACE_ROOT/documentation/"* ]]; then
  ALLOWED=1
fi

# .claude/commands and .claude/skills (command/skill files)
if [[ "$FILE_PATH" == "$WORKSPACE_ROOT/.claude/commands/"* ]]; then
  ALLOWED=1
fi
if [[ "$FILE_PATH" == "$WORKSPACE_ROOT/.claude/skills/"* ]]; then
  ALLOWED=1
fi

# Block: Root of workspace (no random files)
if [[ "$FILE_PATH" == "$WORKSPACE_ROOT/"* ]] && [[ "$FILE_PATH" != *"/"*"/"* ]] 2>/dev/null; then
  # File directly in workspace root (only one slash after root)
  BASENAME=$(basename "$FILE_PATH")
  # Allow known root files
  if [[ "$BASENAME" == "CLAUDE.md" || "$BASENAME" == ".gitignore" || "$BASENAME" == "README.md" ]]; then
    ALLOWED=1
  else
    ALLOWED=0
  fi
fi

# Block: System directories
if [[ "$FILE_PATH" == "/tmp/"* ]]; then
  ALLOWED=0
fi
if [[ "$FILE_PATH" == "$HOME/Desktop/"* ]]; then
  ALLOWED=0
fi
if [[ "$FILE_PATH" == "$HOME/Downloads/"* ]]; then
  ALLOWED=0
fi

if [ "$ALLOWED" -eq 0 ]; then
  echo "BLOCKED: File location not in allowed list: $FILE_PATH"
  echo "Allowed locations: .claude/branch-context/, .claude/local/, .claude/violations/, project source directories"
  echo "See CLAUDE.md 'FILE DISCIPLINE' section for full list."
  exit 2
fi

exit 0
