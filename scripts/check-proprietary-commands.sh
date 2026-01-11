#!/bin/bash
# =============================================================================
# CHECK PROPRIETARY COMMANDS
# =============================================================================
# Scans commands/ directory for proprietary content that should be in .claude-local
#
# Usage:
#   ./scripts/check-proprietary-commands.sh           # Normal check
#   ./scripts/check-proprietary-commands.sh --strict  # Fail on warnings too
#   ./scripts/check-proprietary-commands.sh --fix     # Show fix commands
#
# Exit codes:
#   0 = Clean (no proprietary content found)
#   1 = Critical (API keys/secrets found)
#   2 = Warning (business-specific content found, --strict mode only)
# =============================================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="$(dirname "$SCRIPT_DIR")"
CMD_DIR="$CLAUDE_DIR/commands"
LOCAL_CMD_DIR="/Users/brent/scripts/CB-Workspace/.claude-local/commands"

STRICT_MODE=false
FIX_MODE=false
CRITICAL_COUNT=0
WARNING_COUNT=0

# Parse arguments
for arg in "$@"; do
  case $arg in
    --strict)
      STRICT_MODE=true
      ;;
    --fix)
      FIX_MODE=true
      ;;
  esac
done

echo "=============================================="
echo "  PROPRIETARY COMMAND CHECK"
echo "  $(date '+%Y-%m-%d %H:%M:%S')"
echo "=============================================="
echo ""

# Patterns that indicate proprietary content
# CRITICAL: Actual secrets/API keys
CRITICAL_PATTERNS=(
  "Bearer [A-Za-z0-9]{20,}"
  "app\.requestdesk\.ai/api"
  "MNRcaklW"
  "API_KEY.*=.*[A-Za-z0-9]{20,}"
)

# WARNING: Business-specific content
# Note: Workspace mapping tables (like in claude-save/start) are OK
# These patterns catch actual business logic, not references
WARNING_PATTERNS=(
  "Content Cucumber"
  "Tuesdays with Claude"
  "contentcucumber\.com"
  "Brent Peterson"
)

# Files that are allowed to have workspace references (mapping tables)
ALLOWED_WORKSPACE_REFS=(
  "claude-save.md"
  "claude-start.md"
  "claude-complete.md"
  "claude-switch.md"
)

echo "Scanning commands directory for proprietary content..."
echo ""

for file in "$CMD_DIR"/*.md; do
  filename=$(basename "$file")

  # Skip if it's a symlink (already properly set up)
  if [ -L "$file" ]; then
    continue
  fi

  # Check for CRITICAL patterns (secrets)
  for pattern in "${CRITICAL_PATTERNS[@]}"; do
    if grep -qE "$pattern" "$file" 2>/dev/null; then
      echo "🔴 CRITICAL: $filename"
      echo "   Contains actual API keys or secrets!"
      echo "   Pattern matched: $pattern"
      if [ "$FIX_MODE" = true ]; then
        echo "   FIX: mv commands/$filename $LOCAL_CMD_DIR/ && ln -s ../../.claude-local/commands/$filename commands/$filename"
      fi
      CRITICAL_COUNT=$((CRITICAL_COUNT + 1))
      echo ""
      break
    fi
  done

  # Check for WARNING patterns (business-specific)
  for pattern in "${WARNING_PATTERNS[@]}"; do
    if grep -qE "$pattern" "$file" 2>/dev/null; then
      echo "🟡 WARNING: $filename"
      echo "   Contains business-specific content"
      echo "   Pattern matched: $pattern"
      if [ "$FIX_MODE" = true ]; then
        echo "   FIX: mv commands/$filename $LOCAL_CMD_DIR/ && ln -s ../../.claude-local/commands/$filename commands/$filename"
      fi
      WARNING_COUNT=$((WARNING_COUNT + 1))
      echo ""
      break
    fi
  done
done

echo "=============================================="
echo "  RESULTS"
echo "=============================================="

if [ $CRITICAL_COUNT -gt 0 ]; then
  echo "🔴 CRITICAL ISSUES: $CRITICAL_COUNT"
  echo "   Commands with secrets MUST be moved to .claude-local"
fi

if [ $WARNING_COUNT -gt 0 ]; then
  echo "🟡 WARNINGS: $WARNING_COUNT"
  echo "   Commands with business-specific content should be reviewed"
fi

if [ $CRITICAL_COUNT -eq 0 ] && [ $WARNING_COUNT -eq 0 ]; then
  echo "✅ All commands are clean!"
  echo "   No proprietary content found in non-symlinked commands"
fi

echo ""

# Exit codes
if [ $CRITICAL_COUNT -gt 0 ]; then
  echo "❌ BLOCKED: Cannot commit with secrets in commands/"
  exit 1
fi

if [ "$STRICT_MODE" = true ] && [ $WARNING_COUNT -gt 0 ]; then
  echo "❌ BLOCKED (strict mode): Business-specific content found"
  exit 2
fi

echo "✅ Check passed"
exit 0
