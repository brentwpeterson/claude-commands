Claude Resume - Resume Parked Sessions

List and resume sessions that were parked with `/claude-later`.

## Usage

```
/claude-resume              # List all parked sessions
/claude-resume <number>     # Resume session by number (e.g., /claude-resume 1)
/claude-resume <number> explain  # Show details before resuming (e.g., /claude-resume 1 explain)
```

## Instructions for Claude

### Step 1: List Parked Sessions

```bash
LATER_DIR="/Users/brent/scripts/CB-Workspace/.claude/branch-context/later"

# List all context files in later/
ls -lt "$LATER_DIR"/*.md 2>/dev/null
```

**If no files found:**
```
📦 No parked sessions found.

Sessions are parked with /claude-later and stored in:
  .claude/branch-context/later/

To park a session: /claude-later
```
Then STOP.

### Step 2: Build Session List

For each file found, extract:
- **Identity:** From `**Identity:** Claude-[Name]` line
- **Workspace:** From filename (e.g., `brent-2026-02-05-tesla-context.md` → `brent`)
- **Last Saved:** From `**Last Saved:**` line
- **Parked:** From `**Parked:**` line (if present)
- **Topic:** First line of `## WHAT YOU WERE WORKING ON` section (truncated to 50 chars)

### Step 3: Display Numbered List

```
📦 Parked Sessions (branch-context/later/)

| # | Identity | Workspace | Parked | Topic |
|---|----------|-----------|--------|-------|
| 1 | Claude-Tesla | rd | Feb 3 | Case study wizard implementation... |
| 2 | Claude-Hopper | astro | Jan 28 | Blog redesign with new components... |
| 3 | Claude-Darwin | shop | Jan 25 | Shopify sync error handling... |

Commands:
  <number>           Resume that session (e.g., "1")
  <number> explain   Show full context (e.g., "1 explain")
  q                  Quit
```

### Step 4: Handle User Input

**If argument is just a number (e.g., `1`):** Go to Step 6 (Resume)

**If argument is `<number> explain` (e.g., `1 explain`):** Go to Step 5 (Explain)

**If no argument:** Display list and wait for user input

### Step 5: Explain Mode

When user types `<number> explain`:

1. Read the full context file for that session
2. Display:

```
📋 Session Details: Claude-[Name]

## SESSION STATUS
[Show full status section]

## WHAT YOU WERE WORKING ON
[Show full section]

## NEXT ACTIONS
[Show full section]

---
Resume this session? (y/n)
```

If user says yes: Continue to Step 6
If user says no: Return to list

### Step 6: Resume Session

1. **Move file back to branch-context/**
```bash
LATER_DIR="/Users/brent/scripts/CB-Workspace/.claude/branch-context/later"
CONTEXT_DIR="/Users/brent/scripts/CB-Workspace/.claude/branch-context"
FILENAME="[selected-filename]"

mv "$LATER_DIR/$FILENAME" "$CONTEXT_DIR/$FILENAME"
```

2. **Update status in file**
Use Edit tool:
- Change `**Status:** LATER` → `**Status:** ACTIVE`
- Update `**Last Started:** [YYYY-MM-DD HH:MM]`

3. **Register name in active-claude-names.json**
```bash
NAMES_FILE="/Users/brent/scripts/CB-Workspace/.claude/local/active-claude-names.json"
CURRENT=$(cat "$NAMES_FILE" 2>/dev/null || echo "[]")
echo "$CURRENT" | jq '. + ["Claude-[Name]"] | unique' > "$NAMES_FILE"
```

4. **Inherit the identity**
You are now Claude-[Name] from the context file.

5. **Confirm and load context**
```
🔄 Session resumed:

🤖 Identity: Claude-[Name] (inherited)
📁 Moved from: later/[filename] → branch-context/[filename]
📋 Status: ACTIVE

Loading context...
```

6. **Read and follow the context file** (same as `/claude-start`)

### Step 7: Present Status and Wait

After loading context, present the session summary and ask:

```
I've restored your session. Which task should I work on first?
```

## Notes

- Parked sessions preserve full context across days/weeks
- Identity is inherited from the context file
- Use this for long-running work that gets interrupted
- Sessions in `later/` survive `/brent-finish` cleanup
