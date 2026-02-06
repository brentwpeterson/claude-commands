Claude Later - Park Session for Long-term Resume

Move a session to the `later/` directory for resuming days or weeks from now.

## Usage

```
/claude-later              # Park current session
/claude-later <name>       # Park a specific Claude's session (e.g., /claude-later tesla)
```

## Session Lifecycle

| Status | Directory | How to Get Here | How to Leave |
|--------|-----------|-----------------|--------------|
| ACTIVE | `branch-context/` | `/claude-start` | Working session |
| SAVED | `branch-context/` | `/claude-save` | `/claude-start` |
| **LATER** | `branch-context/later/` | `/claude-later` | `/claude-resume` |
| CLOSED | (deleted) | `/claude-trash` or `/brent-finish` | - |

## Instructions for Claude

### Step 1: Identify the Session to Park

**If no argument provided:** Park the current session (your own context file)

**If name argument provided (e.g., `tesla`):**
1. Find the context file: `ls -t /Users/brent/scripts/CB-Workspace/.claude/branch-context/*-[name]-context.md`
2. If not found, check later/: `ls -t /Users/brent/scripts/CB-Workspace/.claude/branch-context/later/*-[name]-context.md`
3. If still not found: Error "No context file found for Claude-[Name]"

### Step 2: Create later/ Directory if Needed

```bash
mkdir -p /Users/brent/scripts/CB-Workspace/.claude/branch-context/later
```

### Step 3: Update Context File Status

Before moving, update the `## SESSION STATUS` section:
- Change `**Status:** SAVED` or `**Status:** ACTIVE` → `**Status:** LATER`
- Add `**Parked:** [YYYY-MM-DD HH:MM]` timestamp

Use the Edit tool to make these changes.

### Step 4: Move Context File to later/

```bash
CONTEXT_DIR="/Users/brent/scripts/CB-Workspace/.claude/branch-context"
FILENAME="[context-file-name]"

mv "$CONTEXT_DIR/$FILENAME" "$CONTEXT_DIR/later/$FILENAME"
```

### Step 5: Remove from Active Names

```bash
NAMES_FILE="/Users/brent/scripts/CB-Workspace/.claude/local/active-claude-names.json"
# Remove the Claude name from the active list
# Use jq: cat "$NAMES_FILE" | jq 'map(select(. != "Claude-[Name]"))' > "$NAMES_FILE"
```

### Step 6: Confirm to User

```
📦 Session parked for later:

🤖 Identity: Claude-[Name]
📁 Moved to: .claude/branch-context/later/[filename]
📋 Status: LATER

To resume this session later:
  /claude-resume

This session is now safe from daily cleanup (/brent-finish won't delete it).
```

## When to Use

- **End of sprint:** Parking work that won't continue until next sprint
- **Blocked:** Waiting on external dependency (API, approval, etc.)
- **Context switch:** Starting different work but want to preserve this for later
- **Long pause:** Won't return to this work for days or weeks

## Notes

- Files in `later/` are NOT deleted by `/brent-finish`
- Use `/claude-resume` to list and resume parked sessions
- Sessions in `later/` don't count against the active names limit
