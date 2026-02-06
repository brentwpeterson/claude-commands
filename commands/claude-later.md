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

### Step 3: Update Context File Status and Inject Resume Summary

Before moving, update the context file with TWO changes:

**A. Inject a QUICK RESUME block at the very top of the file (line 1, before everything else):**

This block gives any future Claude an instant understanding of what this parked session is about.

```markdown
> **PARKED SESSION: [1-line description of what was being worked on]**
> **Workspace:** [shortcode] | **Branch:** [branch-name] | **Parked:** [YYYY-MM-DD]
> **Why parked:** [brief reason - end of day, blocked, context switch, etc.]
> **To resume:** Read the full context below, then ask user what to work on first.
```

Build this from conversation memory:
- The 1-line description should be the most important thing in progress (e.g., "Session management system overhaul + TWC #21 article")
- The "why parked" comes from the conversation context (user said why, or infer from timing)

**B. Update the `## SESSION STATUS` section:**
- Change `**Status:** SAVED` or `**Status:** ACTIVE` → `**Status:** LATER`
- Add `**Parked:** [YYYY-MM-DD HH:MM]` timestamp

Use the Edit tool to make both changes.

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

### Step 6: Confirm and Guide Next Steps

Display the confirmation, then tell the user exactly what to do next based on context.

```
📦 Session parked:

🤖 Identity: Claude-[Name]
📁 Moved to: .claude/branch-context/later/[filename]
📋 Status: LATER
```

**Then determine next steps based on the situation:**

**If this is the ONLY active session (no other context files in branch-context/):**
```
This was your only active session. Next steps:

  /brent-finish     Close out the day (log time, capture accomplishments, cleanup)
  /claude-start X   Start fresh work on a different project
```

**If there ARE other active sessions in branch-context/:**
```
You still have active sessions:
  - [list other context files by Claude name and workspace]

Next steps:
  /claude-start <name>   Switch to one of those sessions
  /brent-finish          Close out the day (will trash remaining active sessions)
```

**If user explicitly said they're done for the day:**
```
Ready to close out? Run:
  /brent-finish
```

### Step 7: Do NOT Continue Working

After parking, this session's work is done. Do not start new work, do not offer to help with other tasks. The user should run another command to continue.

## When to Use

- **End of sprint:** Parking work that won't continue until next sprint
- **Blocked:** Waiting on external dependency (API, approval, etc.)
- **Context switch:** Starting different work but want to preserve this for later
- **Long pause:** Won't return to this work for days or weeks

## How This Fits the Daily Workflow

```
/brent-start          Opens the day (time tracking, planning)
/claude-start X       Resume or start a work session
  ... work ...
/claude-later         Park work you won't finish today (optional)
/brent-finish         Closes the day (logs time, trashes active contexts, preserves later/)
```

- `/brent-finish` DELETES all context files in `branch-context/` (active sessions)
- `/brent-finish` PRESERVES files in `branch-context/later/` (parked sessions)
- Use `/claude-later` BEFORE `/brent-finish` if you want to keep a session for days or weeks
- Use `/claude-resume` to list and resume parked sessions on a future day

## Notes

- Files in `later/` survive `/brent-finish` cleanup
- Use `/claude-resume` to list and resume parked sessions
- Sessions in `later/` don't count against the active names limit
