Name Conflict Resolution - Resolve duplicate name claims between Claude sessions

## Usage

```
/name-conflict              Resolve a name conflict for the current session
/name-conflict --help       Show this help
```

**When to use:** The user tells you another Claude session is using the same name as you, or you detect a name collision during /resume or /claude-start.

---

## --help Handler

If arguments contain `--help` or `-h`, show the USAGE section above and STOP.

---

## How It Works

**Rule: The oldest registration wins. The newer session must rename.**

The name registration system uses atomic lock directories at:
```
/Users/brent/scripts/CB-Workspace/.claude/local/names/Claude-<Name>/
```

Each directory may contain a `claimed` file with a timestamp. The directory creation time (via `stat`) is the authoritative proof of ownership.

---

## Step 1: Identify Your Current Name

```bash
# Get your name from conversation memory (primary source)
MY_NAME="YOUR_NAME_FROM_MEMORY"
# If unknown, query the session DB:
source /Users/brent/scripts/CB-Workspace/.claude/local/session-db.sh
session_db_list_active
# DO NOT read active-session.json (deprecated, shared file)
```

If no name found, tell user: "I don't have a registered name. Nothing to conflict." and STOP.

## Step 2: Check Your Registration Proof

```bash
NAMES_DIR="/Users/brent/scripts/CB-Workspace/.claude/local/names"
MY_DIR="$NAMES_DIR/Claude-$MY_NAME"

# Get directory creation time (this is your proof)
MY_TIMESTAMP=$(stat -f "%Sm" -t "%Y-%m-%d %H:%M:%S" "$MY_DIR" 2>/dev/null)
```

If your name directory doesn't exist, you have NO proof. You lose automatically. Skip to Step 4.

## Step 3: Compare Timestamps

Display your proof:
```
NAME CONFLICT RESOLUTION

My name: Claude-[Name]
My registration: [timestamp from stat]
My claimed file: [contents of claimed file, or "none"]
```

Now check: **Is there a context file from an OLDER session using this same name?**

```bash
CONTEXT_DIR="/Users/brent/scripts/CB-Workspace/.claude/branch-context"

# Search for context files with this name
grep -l "Identity.*Claude-$MY_NAME" "$CONTEXT_DIR"/*-context.md 2>/dev/null
```

For each matching context file, check its dates:
```bash
# Get the file's Last Saved / Last Started date
grep -E "(Last Saved|Last Started|Created):" "$CONTEXT_FILE" | head -1
```

**Decision logic:**
- If YOUR name directory was created BEFORE any other session's context file references this name: **YOU WIN.** Tell the user: "I'm the original Claude-[Name]. The other session should run /name-conflict." STOP.
- If another session's context file shows this name BEFORE your registration timestamp: **YOU LOSE.** Proceed to Step 4.
- If timestamps are ambiguous or you can't prove you were first: **YOU LOSE.** The safe default is to rename. Proceed to Step 4.

Display the comparison:
```
CONFLICT CHECK:
  My registration: 2026-03-11 08:47:16
  Other claim:     [context file] registered 2026-03-11 07:30:03
  VERDICT:         Other session was first. I must rename.
```

## Step 4: Pick a New Unique Name

Choose from: scientists, mathematicians, explorers, writers, philosophers, artists. The name must NOT already exist in the names directory.

```bash
# List taken names
ls "$NAMES_DIR"

# Try to register new name (atomic)
NEW_NAME="Claude-[NewName]"
if mkdir "$NAMES_DIR/$NEW_NAME" 2>/dev/null; then
  date -u > "$NAMES_DIR/$NEW_NAME/claimed"
  echo "Registered: $NEW_NAME"
fi
```

Keep trying until one succeeds.

## Step 5: Remove Old Registration

```bash
rm -rf "$NAMES_DIR/Claude-$MY_NAME"
```

Only remove if YOU created it. If you're not sure (e.g., Mode B resume where the original session created it), leave it alone and just register the new one.

## Step 6: Update All References

1. **Session DB**: Update your row with the new name
2. **Pin task**: Update task subject with new name
3. **Context file**: If you have an active context file with your old name, update the Identity field to your new name

```bash
# Update session DB (delete old row, create new)
source /Users/brent/scripts/CB-Workspace/.claude/local/session-db.sh
session_db_delete "$MY_NAME"
session_db_upsert "[NewName]" "[WORKSPACE]" '[TOUCHED]' "[TASK]"
# DO NOT write to active-session.json (deprecated)
```

Display the result:
```
RENAMED:
  Old: Claude-[OldName]
  New: Claude-[NewName]
  Reason: Name conflict - other session had older registration

  Old registration removed: yes/no
  New registration created: yes
  Session file updated: yes
  Pin task updated: yes
```

## Step 7: Log Violation

This command ALWAYS logs a violation. A name conflict means someone didn't check properly during registration.

**Add to violation log** at `.claude/violations/incorrect-instruction-log.md`:

```markdown
## [DATE] - NAME_CONFLICT_RESOLUTION (VIOLATION #X)

**VIOLATION**: Name conflict detected. Two sessions claimed the same name.
**DATE**: [timestamp]
**SEVERITY**: MEDIUM

**WHAT HAPPENED**:
- [Which name was duplicated]
- [Who was first (with timestamp proof)]
- [Who had to rename (with timestamp proof)]
- [How the conflict occurred (Mode B resume? Parallel /claude-start? Failed to check names dir?)]

**CORRECT BEHAVIOR SHOULD HAVE BEEN**:
1. Check names directory BEFORE registering
2. If name exists, pick a different one immediately
3. Mode B resumes should NEVER re-register or change names

**RESOLUTION**: [OldName] renamed to [NewName]
```

Increment the violation counter at the top of the file.

## Step 8: Write to Memory

Add a one-line entry to the Violations section in MEMORY.md:
```
- [YYYY-MM-DD] NAME_CONFLICT: [OldName] renamed to [NewName] - [brief reason, e.g. "Mode B resume overwrote Curie's name"]
```

## Step 9: Confirm

```
Name conflict resolved. I am now Claude-[NewName].
```

Use your new name for the rest of the session.
