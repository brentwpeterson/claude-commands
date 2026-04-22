Claude Trash - Close Window and Clean Up

Quick cleanup when closing a Claude window. Archives context and comms, removes your name from the registry.

## Usage

```
/claude-trash              # Clean up using your registered name
/claude-trash <name>       # Clean up as specific identity (e.g., /claude-trash galileo)
```

---

## Instructions

### Step 0: Pre-flight Check - Unresolved Items

Before trashing, scan your current session for open work:

1. **Check context file for this session** (if it exists):
   - Look for `## NEXT ACTIONS` - are there pending items?
   - Look for `## TODO LIST STATE` - are there in-progress or pending items?
   - Look for `## WHAT YOU WERE WORKING ON` - is there unfinished work described?

2. **Check open comms with other Claudes:**
   - Scan `/.claude/claude-comms/` for files with your name (`*${MY_NAME}*`)
   - If any are NOT closed (no `SESSION CLOSED` marker), check: did the other Claude get everything they need?
   - If another Claude requested a handoff or open items dump, make sure you replied before closing
   - If you have unreplied comms, write your response BEFORE archiving

3. **Check conversation memory:**
   - Were there any unanswered questions from the user?
   - Were there open tasks you didn't finish?
   - Were there items the user asked about but you didn't address?

3. **If unresolved items found, present them:**
   ```
   ⚠️ Before closing, I found unresolved items in this session:

   - [item 1 description]
   - [item 2 description]
   - [item 3 description]

   Options:
   1. `/claude-later` - Park this session to resume later (preserves everything)
   2. Continue with `/claude-trash` - Archive and discard (items will be lost)

   What would you prefer?
   ```

4. **Ask about adding items to ACTION-ITEMS.md (MANDATORY):**
   Regardless of whether unresolved items were found, always ask:
   ```
   Any open tasks to add to your Action Items list before closing?
   (These go to ACTION-ITEMS.md in your Obsidian Daily folder)

   1. Yes - let me tell you what to add
   2. No - nothing to track
   ```
   If yes: use the same logic as `/action-items add` to append items to:
   `brent-workspace/ob-notes/Brent Notes/Dashboard/Daily/ACTION-ITEMS.md`
   Group them under the appropriate source (session work, meeting, ad-hoc).
   Then proceed with trash cleanup.

4. **If no unresolved items:** Proceed to Step 1.

5. **If user confirms trash:** Continue. If user picks later: run `/claude-later` instead and stop.

---

### Step 1: Identify yourself

1. If name argument passed: use it (e.g., `galileo` -> `Claude-Galileo`)
2. If no argument: use your name from this session
3. If no name at all: read `active-claude-names.json` and ask user which one to clean up

Store lowercase short name for matching (e.g., "galileo").

### Step 2: Archive context files for this session

```bash
CONTEXT_DIR="/Users/brent/scripts/CB-Workspace/.claude/branch-context"
ARCHIVE_DIR="$CONTEXT_DIR/archived"
TODAY=$(date +%Y-%m-%d)
```

Move today's context files that belong to this workspace/session to archived:
- Check which workspace you were working in from conversation memory
- Move matching context files: `mv "$CONTEXT_DIR/[workspace]-*$TODAY*.md" "$ARCHIVE_DIR/"`

If unsure which files are yours, list them and ask user to confirm.

### Step 3: Archive comms files involving this identity

```bash
COMMS_DIR="/Users/brent/scripts/CB-Workspace/.claude/claude-comms"
COMMS_ARCHIVE="$COMMS_DIR/archive"
MY_NAME="[lowercase-short-name]"

mkdir -p "$COMMS_ARCHIVE"

# Archive comms TO or FROM me
for f in "$COMMS_DIR"/*${MY_NAME}*.md; do
  [ -f "$f" ] || continue
  mv "$f" "$COMMS_ARCHIVE/"
  echo "Archived: $(basename "$f")"
done
```

### Step 4: Remove name from registries

```bash
NAMES_DIR="/Users/brent/scripts/CB-Workspace/.claude/local/names"
MY_FULL_NAME="Claude-[Name]"
MY_SHORT_NAME="[Name]"

# Release the atomic name lock
rm -rf "$NAMES_DIR/$MY_FULL_NAME"

# Close session in SQLite DB (safe - only touches your own row)
source /Users/brent/scripts/CB-Workspace/.claude/local/session-db.sh
session_db_close "$MY_SHORT_NAME"
```

- Remove lock directory from `names/` (this frees the name for reuse)
- Close session in the SQLite DB (marks status as 'closed')
- **DO NOT read or write `active-session.json` - it is deprecated**

### Step 5: Report and exit

```
Claude-[Name] cleaned up:
  - Context archived: [X] files
  - Comms archived: [Y] files
  - Name removed from registry
  - Session removed from registry

Window safe to close.
```
