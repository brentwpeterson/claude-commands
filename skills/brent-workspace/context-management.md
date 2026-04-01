# Context File Management Rules

**Purpose:** Prevent context file proliferation and orphaned Claude sessions.

---

## The Problem (What Was Happening)

On Jan 20, 2026, we had 3 context files for the same day:
- `brent-workspace-2026-01-20-context.md` (Shackleton, 6:45 AM)
- `brent-workspace-2026-01-20-pm-context.md` (unknown, 8:31 AM)
- `brent-workspace-2026-01-20-evening-context.md` (Darwin, 2:25 PM)

**Root Cause:** Each new Claude window:
1. Picked a fresh name (didn't check for existing sessions)
2. Created a new context file (didn't update existing)
3. Previous session's context was orphaned

---

## Prevention Rules

### Rule 1: Resume Before Create

**On /brent-start or /claude-start:**

1. Check `active-sessions.json` for resumable sessions in this workspace
2. If found, show prompt:
   ```
   Found resumable session for [workspace]:
   - Claude-[Name] | Last active: [time] | Task: [summary]

   Resume this session? (y/n)
   ```
3. If YES: Use same identity, update same context file
4. If NO: Pick new name, create new context file

### Rule 2: One Context File Per Workspace Per Day

**On /claude-save:**

1. Check if context file already exists for this workspace + today
2. If YES: UPDATE the existing file (don't create new)
3. If NO: Create new with format `[workspace]-[date]-context.md`
4. Never add time-based suffixes (-pm, -evening, etc.)

### Rule 3: Clean Shutdown

**On /brent-finish:**

1. Update session status to "closed" in registry
2. Remove name from active-claude-names.json
3. Context file stays for reference but won't show as resumable

**On /claude-save:**

1. Update session status to "saved" in registry
2. Keep name in active-claude-names.json (for resume)
3. Update context_file path and task_summary

### Rule 4: Orphan Detection

**On /brent-start:**

1. Check for sessions with status="active" but heartbeat > 2 hours old
2. These are likely orphaned (browser closed without save)
3. Show warning:
   ```
   Found orphaned session: Claude-[Name] (last active 3 hours ago)
   - Archive and start fresh?
   - Or investigate first?
   ```

---

## Registry Structure

**Database:** `.claude/local/sessions.db` (SQLite with WAL mode)
**Helper script:** `.claude/local/session-db.sh`

```sql
CREATE TABLE sessions (
    name TEXT PRIMARY KEY,        -- Kepler, Cervantes, etc.
    workspace TEXT NOT NULL,      -- brent, astro, rd, etc.
    started TEXT NOT NULL,        -- ISO timestamp
    last_activity TEXT NOT NULL,  -- ISO timestamp
    status TEXT DEFAULT 'active', -- active, saved, closed
    workspaces_touched TEXT,      -- JSON array
    task_summary TEXT
);
```

**Usage from commands:**
```bash
source /Users/brent/scripts/CB-Workspace/.claude/local/session-db.sh
session_db_upsert "Name" "workspace" '["ws1","ws2"]' "task summary"  # Register/update
session_db_get_json "Name"         # Read your own session
session_db_list_active             # List all active sessions
session_db_close "Name"            # Mark as closed (/claude-trash, /brent-finish)
session_db_save "Name"             # Mark as saved (/claude-save)
session_db_heartbeat "Name"        # Touch last_activity
session_db_touch_workspace "Name" "rd"  # Add workspace to touched list
session_db_find_orphans 2          # Find sessions inactive for 2+ hours
```

**DEPRECATED:** `active-session.json` is a shared file that gets overwritten by every session. DO NOT read or write it. Use the SQLite DB instead. Each session has its own row keyed by name, so no session can stomp another.

**Status values:**
- `active` - Currently running (browser window open)
- `saved` - /claude-save ran, ready to resume
- `closed` - /brent-finish ran, work complete

---

## Context File Naming

**Correct:**
- `brent-workspace-2026-01-22-context.md` (workspace + date)
- `rd-api-refactor-context.md` (workspace + feature)

**Wrong:**
- `brent-workspace-2026-01-22-pm-context.md` (time suffix)
- `brent-workspace-2026-01-22-tesla-context.md` (name in filename)

**Exception:** Feature-specific contexts CAN include Claude name if multiple Claudes are working on different features in same workspace:
- `rd-beethoven-agent-upload-context.md` (specific feature, named Claude)

---

## Daily Cleanup (On /brent-start)

1. Check for context files older than `auto_archive_days` (7)
2. Offer to archive: "Found 3 context files older than 7 days. Archive?"
3. Check for orphaned sessions (no heartbeat)
4. Check if max_windows exceeded

---

## Commands That Must Follow These Rules

| Command | What It Must Do |
|---------|-----------------|
| `/brent-start` | Check resumable, show orphans, offer cleanup |
| `/claude-start` | Check resumable for workspace |
| `/claude-save` | Update (not create) context file, update registry |
| `/brent-finish` | Mark session closed, remove from active names |
