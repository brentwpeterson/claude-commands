Resume a saved session by code.

**USAGE:**
- `/resume` - List all saved sessions with codes
- `/resume --list` - Same as above (explicit list mode)
- `/resume <code>` - Resume the session matching that code
- `/resume --help` - Show this help

**Arguments:** `$ARGUMENTS`

## Instructions for Claude

### --help Handler
If arguments contain `--help` or `-h`, show the USAGE section above and STOP.

### Step 1: Build the session index

```bash
CONTEXT_DIR="/Users/brent/scripts/CB-Workspace/.claude/branch-context"

for f in "$CONTEXT_DIR"/*-context.md; do
  [[ "$(basename "$f")" == "main-context.md" || "$(basename "$f")" == "master-context.md" ]] && continue
  HASH=$(echo "$(basename "$f")" | md5 | head -c 6)
  DATE=$(basename "$f" | grep -oE '2026-[0-9]{2}-[0-9]{2}')
  NAME=$(grep "Identity:" "$f" 2>/dev/null | head -1 | sed 's/.*Claude-//' | tr -d '* ')
  TASK=$(grep -A 1 "WHAT YOU WERE WORKING ON" "$f" 2>/dev/null | tail -1 | head -c 70)
  WS=$(basename "$f" | sed 's/-2026.*//')
  echo "$HASH|$DATE|$NAME|$WS|$TASK|$f"
done | sort -t'|' -k2 -r
```

### Step 2: No arguments or --list = list mode

If `$ARGUMENTS` is empty OR equals `--list`, display the index as a table:

```
SAVED SESSIONS

| Code   | Date  | Claude    | Workspace | Working On                          |
|--------|-------|-----------|-----------|-------------------------------------|
| a3f2b1 | 03-09 | Voltaire  | brent     | ACG newsletter #37: OpenAI ChatGPT  |
| ...    | ...   | ...       | ...       | ...                                 |

Resume with: /resume <code>
```

Group by task when the same Claude+task appears across multiple dates. Show only the NEWEST file for each unique Claude+workspace+task combo, with a note like "(also: 03-08, 03-07)" for older saves.

STOP after showing the list.

### Step 3: Code provided = resume mode

If `$ARGUMENTS` matches a code from the index:

1. **Find the matching context file** from the index
2. **Read the context file** in full
3. **Detect if already in a session:**
   ```bash
   # Check if active-session.json exists and has a name
   CURRENT_SESSION=$(cat /Users/brent/scripts/CB-Workspace/.claude/local/active-session.json 2>/dev/null | python3 -c "import json,sys; print(json.load(sys.stdin).get('name',''))" 2>/dev/null)
   ```

#### Mode A: Fresh window (no current session or CURRENT_SESSION is empty)

This is a new Claude instance resuming a saved task.

4. **Pick up the identity** from the file's `Identity:` field
5. **Register the name** using atomic lock directory:
   ```bash
   NAMES_DIR="/Users/brent/scripts/CB-Workspace/.claude/local/names"
   mkdir -p "$NAMES_DIR"
   NAME="Claude-[CLAUDE_NAME_FROM_FILE]"
   if ! mkdir "$NAMES_DIR/$NAME" 2>/dev/null; then
     # Name is taken! Pick a new unique name from: scientists, artists, explorers, writers
     # Try mkdir again with the new name. Repeat until one succeeds.
   fi
   ```
6. **Write `active-session.json`:**
   ```bash
   SESSION_FILE="/Users/brent/scripts/CB-Workspace/.claude/local/active-session.json"
   NOW=$(date -u +"%Y-%m-%dT%H:%M:%S")
   cat > "$SESSION_FILE" << EOF
   {
     "started": "$NOW",
     "name": "[CLAUDE_NAME_FROM_FILE]",
     "startWorkspace": "[WS]",
     "workspacesTouched": ["[WS]"],
     "lastActivity": "$NOW"
   }
   EOF
   ```
7. **Update context file status** to ACTIVE with current timestamp
8. **Create identity pin task:**
   ```
   TaskCreate: "Claude-[Name] | [workspace] | [brief task description]"
   TaskUpdate: status -> in_progress
   ```
9. **Create work tasks** from the NEXT ACTIONS / TODO LIST STATE sections (5-10 tasks, all pending)

#### Mode B: Existing session (CURRENT_SESSION has a name)

This is an already-running Claude loading a saved task into the current window. The user wants to pick up that work without changing their identity.

4. **Keep your current identity.** Do NOT change your name or overwrite `active-session.json`.
5. **Do NOT re-register in names directory** (you're already registered).
6. **Update context file status** to ACTIVE with current timestamp.
   - **Do NOT update the `Identity:` field.** Leave the original identity intact so that if this file is later resumed in a fresh window (Mode A), it gets the correct original name, not yours.
7. **Do NOT create a new identity pin task** (you already have one). Update the existing pin task description to reflect the new work.
8. **Create work tasks** from the NEXT ACTIONS / TODO LIST STATE sections (5-10 tasks, all pending).

#### Display (both modes)

```
================================================
  Claude-[Name] | [workspace] | [task summary]
================================================

Resumed from: [filename]
Directory: [from context file]
Branch: [from context file]

NEXT ACTIONS:
1. [first priority from context]
2. [second priority]
...

Which task should I work on first?
```

### What this command does NOT do

- No MCP memory queries
- No work log stamping (that's /brent-start territory)
- No security scans
- No Docker checks
- No emergency recovery mode
- No date verification speeches

It reads the file, sets up identity, shows you the state, and asks what to work on. That's it.

### Code not found

If the argument doesn't match any code:
```
No session found for code: [input]
Run /resume to see available sessions.
```
