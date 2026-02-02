Claude Trash - Close Window and Clean Up

Quick cleanup when closing a Claude window. Archives context and comms, removes your name from the registry.

## Usage

```
/claude-trash              # Clean up using your registered name
/claude-trash <name>       # Clean up as specific identity (e.g., /claude-trash galileo)
```

---

## Instructions

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
NAMES_FILE="/Users/brent/scripts/CB-Workspace/.claude/local/active-claude-names.json"
SESSIONS_FILE="/Users/brent/scripts/CB-Workspace/.claude/local/active-sessions.json"
MY_FULL_NAME="Claude-[Name]"
```

- Remove from `active-claude-names.json`: filter out your name
- Remove from `active-sessions.json`: filter your entry from both `sessions[]` and `resumable[]`

### Step 5: Report and exit

```
Claude-[Name] cleaned up:
  - Context archived: [X] files
  - Comms archived: [Y] files
  - Name removed from registry
  - Session removed from registry

Window safe to close.
```
