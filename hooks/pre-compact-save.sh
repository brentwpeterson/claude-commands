#!/bin/bash
# Pre-Compact Save Hook
# Fires before context compaction to preserve critical session state
# Output goes to compact-reinject.md for reload after compaction

WORKSPACE_ROOT="/Users/brent/scripts/CB-Workspace"
DB_PATH="$WORKSPACE_ROOT/.claude/local/sessions.db"
REINJECT_FILE="$WORKSPACE_ROOT/.claude/local/compact-reinject.md"
CONTEXT_DIR="$WORKSPACE_ROOT/.claude/branch-context"

# Read session info from SQLite DB (replaces active-session.json)
# Try to find the session by checking the names directory for who we might be
WORKSPACE="unknown"
TOUCHED="unknown"
IDENTITY="unknown"

# Check all active sessions and try to match by recent activity
if [ -f "$DB_PATH" ]; then
  # Get the most recently active session
  LATEST=$(sqlite3 "$DB_PATH" "SELECT name, workspace, workspaces_touched FROM sessions WHERE status = 'active' ORDER BY last_activity DESC LIMIT 1;" 2>/dev/null)
  if [ -n "$LATEST" ]; then
    WORKSPACE=$(echo "$LATEST" | cut -d'|' -f2)
    TOUCHED=$(echo "$LATEST" | cut -d'|' -f3)
    IDENTITY="Claude-$(echo "$LATEST" | cut -d'|' -f1)"
  fi
fi

# Find the most recent context file
CONTEXT_FILE=$(ls -t "$CONTEXT_DIR"/*-context.md 2>/dev/null | head -1)

# Extract identity from context file if not found in DB
if [ "$IDENTITY" = "unknown" ] && [ -n "$CONTEXT_FILE" ] && [ -f "$CONTEXT_FILE" ]; then
  IDENTITY=$(grep '^\*\*Identity:\*\*' "$CONTEXT_FILE" | sed 's/.*\*\*Identity:\*\* //' | head -1)
fi

# Extract current task from context file
CURRENT_TASK=""
if [ -n "$CONTEXT_FILE" ] && [ -f "$CONTEXT_FILE" ]; then
  CURRENT_TASK=$(sed -n '/## WHAT YOU WERE WORKING ON/,/^##/p' "$CONTEXT_FILE" | grep -v '^##' | head -3)
fi

# Build reinject file
cat > "$REINJECT_FILE" << EOF
# Context Recovery After Compaction

**Identity:** $IDENTITY
**Workspace:** $WORKSPACE
**Workspaces Touched:** $TOUCHED
**Context File:** $(basename "$CONTEXT_FILE" 2>/dev/null)

## Session DB
Sessions are stored in SQLite at: .claude/local/sessions.db
Query your session: source .claude/local/session-db.sh && session_db_get_json "YOUR_NAME"
DO NOT read active-session.json (deprecated, shared file that overwrites between sessions).

## Critical Rules (from CLAUDE.md)
- NEVER write to the database. Not with permission, not without. NEVER.
- NEVER deploy unless the user runs a deploy command.
- NEVER claim completion. Say "ready for testing" instead.
- NEVER hardcode URLs or IPs. Use relative URLs or ConfigManager.
- NEVER create files outside allowed locations (.claude/branch-context/, .claude/local/, project source dirs).
- 2-attempt limit when stuck, then ASK for guidance.
- No em dashes in Brent's content. Use periods or commas instead.
- No fabricated content. No fake quotes, data, or benchmarks.
- Sprint tickets live in the Backlog API, not markdown files.

## Current Task
$CURRENT_TASK

## Session File
Read full session context from: $CONTEXT_FILE
EOF

exit 0
