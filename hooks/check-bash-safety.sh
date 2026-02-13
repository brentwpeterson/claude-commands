#!/bin/bash
# Bash Safety Hook - PreToolUse(Bash)
# Blocks destructive and prohibited commands
# Reads tool input JSON from stdin
# Exit 0 = allow, Exit 2 = block

# Read JSON input from stdin
INPUT=$(cat)

# Extract the command from tool input
COMMAND=$(echo "$INPUT" | python3 -c "
import json, sys
data = json.load(sys.stdin)
tool_input = data.get('input', {})
print(tool_input.get('command', ''))
" 2>/dev/null)

if [ -z "$COMMAND" ]; then
  exit 0
fi

# === DATABASE WRITE PROHIBITION (HARD BLOCK) ===
# Claude NEVER writes to the database. Not with permission, not without.

# Docker exec with database operations
if echo "$COMMAND" | grep -qiE 'docker\s+exec.*mongo'; then
  if echo "$COMMAND" | grep -qiE '(insert|update|delete|drop|remove|replaceOne|updateOne|updateMany|deleteOne|deleteMany|bulkWrite|findOneAndUpdate|findOneAndReplace|findOneAndDelete)'; then
    echo "BLOCKED: Database write operation detected."
    echo "Claude NEVER writes to the database. Create a migration file instead."
    echo "See CLAUDE.md 'CLAUDE NEVER WRITES TO THE DATABASE' section."
    exit 2
  fi
fi

# Direct mongosh/mongo commands with writes
if echo "$COMMAND" | grep -qiE '(mongosh|mongo\s).*\.(insert|update|delete|drop|remove|replaceOne)'; then
  echo "BLOCKED: Database write operation detected."
  echo "Claude NEVER writes to the database. Create a migration file instead."
  exit 2
fi

# Python/migration scripts that modify DB
if echo "$COMMAND" | grep -qiE '(python|python3).*migrat.*--execute'; then
  echo "BLOCKED: Database migration execution detected."
  echo "Claude creates migration FILES but never executes them. User runs migrations."
  exit 2
fi

# === GIT SAFETY (HARD BLOCK) ===

# Force push
if echo "$COMMAND" | grep -qiE 'git\s+push\s+.*(-f|--force)'; then
  echo "BLOCKED: git push --force is prohibited."
  echo "See CLAUDE.md git safety rules."
  exit 2
fi

# Force push to main/master specifically
if echo "$COMMAND" | grep -qiE 'git\s+push\s+.*(-f|--force).*(main|master)'; then
  echo "BLOCKED: Force push to main/master is absolutely prohibited."
  exit 2
fi

# Reset hard
if echo "$COMMAND" | grep -qiE 'git\s+reset\s+--hard'; then
  echo "BLOCKED: git reset --hard is prohibited without explicit user request."
  echo "This discards all local changes permanently."
  exit 2
fi

# Interactive rebase (not supported in non-interactive terminal)
if echo "$COMMAND" | grep -qiE 'git\s+(rebase|add)\s+-i'; then
  echo "BLOCKED: Interactive git commands (-i flag) are not supported."
  echo "They require interactive input which is not available."
  exit 2
fi

# === DEPLOYMENT PROTECTION (HARD BLOCK) ===
# Claude does NOT deploy unless user explicitly runs a deploy command

# Git tag creation + push (deployment tags)
if echo "$COMMAND" | grep -qiE 'git\s+tag.*&&.*git\s+push'; then
  echo "BLOCKED: Deployment tag creation detected."
  echo "Claude does NOT deploy. User must run /deploy-project or explicitly request deployment."
  exit 2
fi

# Deploy scripts
if echo "$COMMAND" | grep -qiE '\./deploy\.sh|deploy\.sh'; then
  echo "BLOCKED: Deploy script execution detected."
  echo "Claude does NOT deploy. User must explicitly run deployment commands."
  exit 2
fi

# === DESTRUCTIVE OPERATIONS (HARD BLOCK) ===

# rm -rf outside allowed directories
if echo "$COMMAND" | grep -qiE 'rm\s+-rf?\s+/'; then
  # Allow rm -rf in .claude/local/ only
  if ! echo "$COMMAND" | grep -qE '\.claude/local/'; then
    echo "BLOCKED: Recursive delete with absolute path detected."
    echo "rm -rf is only allowed in .claude/local/ directory."
    exit 2
  fi
fi

# Checkout/restore that discards changes
if echo "$COMMAND" | grep -qiE 'git\s+(checkout|restore)\s+\.\s*$'; then
  echo "BLOCKED: git checkout/restore . discards all uncommitted changes."
  echo "This is a destructive operation requiring explicit user request."
  exit 2
fi

# Clean -f (removes untracked files)
if echo "$COMMAND" | grep -qiE 'git\s+clean\s+-f'; then
  echo "BLOCKED: git clean -f removes untracked files permanently."
  echo "This is a destructive operation requiring explicit user request."
  exit 2
fi

# Branch force delete
if echo "$COMMAND" | grep -qiE 'git\s+branch\s+-D'; then
  echo "BLOCKED: git branch -D force-deletes a branch."
  echo "Use git branch -d (lowercase) for safe delete, or get explicit user permission for -D."
  exit 2
fi

# All checks passed
exit 0
