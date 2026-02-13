# Resume Instructions for Claude

## SESSION STATUS
**Identity:** Claude-Hawking
**Status:** SAVED
**Last Saved:** 2026-02-08
**Workspace:** cc (Claude Commands)

## WHAT YOU WERE WORKING ON
Research and planning for Claude Code hooks integration across the CB-Workspace command system. User asked how hooks work, whether context-percentage triggers exist, and requested an audit of all commands to find hook opportunities.

## RESEARCH COMPLETE - READY TO IMPLEMENT

### Background
Claude Code hooks are shell commands or LLM prompts that fire at specific lifecycle events. They're configured in settings JSON files and provide deterministic control (always run, unlike prompt instructions).

### Hook Events Available
| Event | When it fires | Matcher examples |
|-------|---------------|-----------------|
| `SessionStart` | Session begins, resumes, or after compaction | `"startup"`, `"resume"`, `"compact"` |
| `UserPromptSubmit` | User submits prompt (before processing) | - |
| `PreToolUse` | Before a tool executes (can block with exit 2) | `"Bash"`, `"Edit"`, `"Write"` |
| `PostToolUse` | After a tool succeeds | Tool name regex |
| `Stop` | Claude finishes responding | - |
| `PreCompact` | Before context compaction | `"manual"`, `"auto"` |
| `SessionEnd` | Session terminates | `"clear"`, `"logout"` |
| `Notification` | Claude needs attention | `"permission_prompt"` |
| `SubagentStart/Stop` | Subagent lifecycle | Agent type |
| `PreCompact` | Before compaction | `"manual"`, `"auto"` |

### Hook Types
- **command** - Shell script, gets JSON on stdin, exit 0 = allow, exit 2 = block
- **prompt** - Single-turn LLM judgment (yes/no)
- **agent** - Multi-turn subagent with tool access

### Configuration Locations
- `~/.claude/settings.json` (global, all projects)
- `.claude/settings.json` (project, shareable)
- `.claude/settings.local.json` (project, local only)

Interactive setup: type `/hooks` in Claude Code CLI.

---

## PROPOSED HOOKS (Priority Order)

### HOOK 1: PreCompact + SessionStart(compact) - Context Loss Prevention
**Priority: HIGH - Solves the original problem (auto-save before context wipe)**

**Part A: PreCompact hook** - Fires before auto-compaction, saves critical state.

```json
"PreCompact": [{
  "hooks": [{
    "type": "command",
    "command": "/Users/brent/scripts/CB-Workspace/.claude/hooks/pre-compact-save.sh"
  }]
}]
```

Script `pre-compact-save.sh` should:
- Read `active-session.json` for current workspace and identity
- Snapshot active todo state
- Write a minimal recovery file to `.claude/local/compact-reinject.md`
- Include: identity, current task, workspace, key context

**Part B: SessionStart(compact) hook** - Fires after compaction, re-injects state.

```json
"SessionStart": [{
  "matcher": "compact",
  "hooks": [{
    "type": "command",
    "command": "cat /Users/brent/scripts/CB-Workspace/.claude/local/compact-reinject.md 2>/dev/null"
  }]
}]
```

**Integration with /claude-save:** Modify `/claude-save` to also generate `compact-reinject.md` every time it runs, so the reinject file is always fresh.

**Key question for Brent:** What goes in the reinject file? Suggestions:
- Claude identity (e.g., "You are Claude-Hawking")
- Current workspace and branch
- Active task summary (1-2 lines)
- Critical CLAUDE.md rules (file discipline, no DB writes, no deploy)
- Keep it SHORT (under 500 words) to preserve context after compaction

---

### HOOK 2: PreToolUse(Write) - File Discipline Enforcement
**Priority: HIGH - Deterministically prevents files in wrong locations**

```json
"PreToolUse": [{
  "matcher": "Write",
  "hooks": [{
    "type": "command",
    "command": "/Users/brent/scripts/CB-Workspace/.claude/hooks/check-file-location.sh"
  }]
}]
```

Script reads tool input JSON from stdin, extracts the `file_path`, and checks against allowed locations:
- `.claude/branch-context/` - Context files
- `.claude/claude-comms/` - Inter-Claude messages
- `.claude/local/` - Temp/scratch (gitignored)
- `.claude/violations/` - Violation logs
- `.claude/learning/` - Learning moments
- `.claude/security-scans/` - Security scans
- Project source directories (when on a feature branch)
- Migration files

Exit 2 (block) if path isn't in allowed list. Stdout message explains why.

---

### HOOK 3: PreToolUse(Bash) - Destructive Command Prevention
**Priority: HIGH - Enforces DB write prohibition and git safety**

```json
"PreToolUse": [{
  "matcher": "Bash",
  "hooks": [{
    "type": "command",
    "command": "/Users/brent/scripts/CB-Workspace/.claude/hooks/check-bash-safety.sh"
  }]
}]
```

Script reads the command from stdin JSON, blocks if it matches:
- `docker exec` with write operations (INSERT, UPDATE, DELETE, mongosh)
- `git push --force` or `git push -f`
- `git reset --hard`
- `rm -rf` outside `.claude/local/`
- `git tag` + `git push` (deployment tags without explicit permission)
- Any command containing hardcoded IPs or localhost URLs being written to files

---

### HOOK 4: Stop - Lightweight Activity Tracking
**Priority: MEDIUM - Breadcrumb trail for session recovery**
**Maps to:** Session tracking, `/claude-save` context freshness

Every time Claude finishes responding, update the session tracking file with a fresh timestamp. This creates a breadcrumb trail so if a session crashes or gets abandoned, we know when the last activity was.

```json
"Stop": [{
  "hooks": [{
    "type": "command",
    "command": "/Users/brent/scripts/CB-Workspace/.claude/hooks/track-activity.sh"
  }]
}]
```

**Script `track-activity.sh` should:**
1. Read `active-session.json`
2. Update `lastActivity` to current timestamp
3. Write back
4. Optionally: if `compact-reinject.md` exists and is older than 30 minutes, regenerate it (keeps reinject file fresh between explicit saves)

**Why this matters:** Currently if a session crashes without `/claude-save`, there's no record of when the last interaction happened. This hook makes recovery easier by always having a fresh timestamp. Also supports `/brent-finish` end-of-day reporting by showing actual last activity time.

**Estimated script:** ~15 lines bash, reads/writes one JSON file.

---

### HOOK 5: PostToolUse(Edit|Write) - Architecture Map Staleness Detection
**Priority: LOW - Nice to have, not urgent**
**Maps to:** `/update-architecture` command

After any file edit or write in CB project source directories, check if the modified file is in a tracked architecture layer (backend routes, models, services, frontend components). If so, append a one-liner to a staleness log.

```json
"PostToolUse": [
  {
    "matcher": "Edit|Write",
    "hooks": [{
      "type": "command",
      "command": "/Users/brent/scripts/CB-Workspace/.claude/hooks/flag-architecture-change.sh"
    }]
  }
]
```

**Script `flag-architecture-change.sh` should:**
1. Read tool input JSON from stdin, extract file path
2. Check if file is in a CB project source directory (requestdesk-app, etc.)
3. Check if file matches architecture-relevant patterns:
   - `backend/app/routers/*.py` (API routes)
   - `backend/app/models/*.py` (data models)
   - `backend/app/services/*.py` (business logic)
   - `frontend/src/components/**` (UI components)
   - `docker-compose*.yml` (infrastructure)
4. If match, append to `.claude/local/architecture-changes.log`:
   ```
   2026-02-08T12:00:00 EDIT requestdesk-app/backend/app/routers/tickets.py
   ```
5. Do NOT run `/update-architecture` automatically (too heavy for a hook)
6. `/claude-save` or `/claude-complete` can check this log and recommend running the update

**Why this matters:** Architecture maps go stale silently. This creates a lightweight audit trail of what changed, so the next session knows which maps need refreshing without running a full scan.

**Estimated script:** ~25 lines bash, pattern matching + append to log.

---

### HOOK 6: SessionEnd - Session Cleanup
**Priority: LOW - Automates what /claude-clean does manually**
**Maps to:** `/claude-clean`, `/claude-complete`, session identity management

When a session ends (user types `/clear`, closes terminal, etc.), clean up session state automatically.

```json
"SessionEnd": [{
  "hooks": [{
    "type": "command",
    "command": "/Users/brent/scripts/CB-Workspace/.claude/hooks/session-cleanup.sh"
  }]
}]
```

**Script `session-cleanup.sh` should:**
1. Read `active-session.json` to get current identity
2. Remove identity from `active-claude-names.json`:
   ```bash
   # Remove "Claude-Hawking" from the active names array
   jq 'del(.[] | select(. == "Claude-Hawking"))' active-claude-names.json > tmp && mv tmp active-claude-names.json
   ```
3. Find the active context file (most recent for the workspace)
4. Update its `## SESSION STATUS` section:
   - Change `**Status:** ACTIVE` to `**Status:** SAVED`
   - Add `**Session Ended:** [timestamp]`
5. Update `active-session.json` with end timestamp
6. Do NOT delete any files (that's `/claude-clean`'s job with user confirmation)

**Why this matters:** Currently if you close a terminal without running `/claude-save`, the context file still shows `Status: ACTIVE` and the identity stays in `active-claude-names.json`. Next session shows a false "session in use" warning. This hook fixes that automatically.

**Estimated script:** ~30 lines bash, JSON manipulation + sed for context file.

**Caveat:** `SessionEnd` may not fire in all exit scenarios (e.g., terminal kill, system crash). So this is best-effort cleanup, not a guarantee. The `/claude-start` command should still handle stale ACTIVE status gracefully.

---

### HOOK 7 (Bonus Idea): UserPromptSubmit - Content Terms Pre-Check
**Priority: LOW - Only if content creation is frequent enough**
**Maps to:** `/check-terms` command

When user submits a prompt that looks like content review (contains keywords like "draft", "post", "article", "blog"), automatically remind Claude of the content rules (no em dashes, no fabrication, no excessive adverbs).

```json
"UserPromptSubmit": [{
  "hooks": [{
    "type": "command",
    "command": "/Users/brent/scripts/CB-Workspace/.claude/hooks/content-terms-reminder.sh"
  }]
}]
```

**Script would:** Check if prompt contains content-related keywords, and if so, output a brief reminder of key writing rules. Light touch, not a full terms check.

**Risk:** Could be noisy on non-content sessions. Might be better as a matcher on specific commands rather than all prompts. Needs discussion.

---

### HOOK 8 (Bonus Idea): PostToolUse(Bash) - Hardcoded URL Detection
**Priority: MEDIUM - Prevents a recurring production issue**
**Maps to:** CLAUDE.md "NO HARDCODED URLs OR IPs" rule

After any Bash command that writes to files (grep for redirect operators `>`, `>>`, or pipe to `tee`), scan the output for hardcoded URLs or IPs.

This might be better handled by expanding Hook 3 (check-bash-safety.sh) to also scan for `localhost`, `127.0.0.1`, `172.x.x.x` patterns in commands that write to files. But a PostToolUse check could catch cases where the command itself looks fine but the output contains hardcoded values.

**Deferred:** Think about whether this overlaps enough with Hook 3 or needs its own script.

---

## IMPLEMENTATION PLAN

### Step 1: Create hooks directory
```bash
mkdir -p /Users/brent/scripts/CB-Workspace/.claude/hooks/
```

### Step 2: Build the three high-priority scripts
- `pre-compact-save.sh` (reads active-session.json, writes compact-reinject.md)
- `check-file-location.sh` (validates Write tool paths against allowed list)
- `check-bash-safety.sh` (blocks dangerous bash commands)

### Step 3: Configure hooks in settings
Add to `.claude/settings.json` (project-level, shareable) or `.claude/settings.local.json` (local only).

### Step 4: Modify /claude-save
Add a step that generates `compact-reinject.md` from the current session state.

### Step 5: Test each hook
- Test PreCompact by running `/compact` manually
- Test Write blocker by trying to create a file in a prohibited location
- Test Bash blocker by trying a blocked command

### Questions for Brent Before Implementation
1. Should hooks go in `.claude/settings.json` (shared, committed) or `.claude/settings.local.json` (local only)?
2. What's the ideal size for the compact-reinject file? (Suggest under 500 words)
3. Should the Bash safety hook warn or hard-block? (Suggest hard-block for DB writes, warn for others)
4. Any commands beyond the ones listed that should be blocked?

## IMPLEMENTATION STATUS

### Built and Configured (2026-02-08)
All three high-priority hooks are LIVE in `.claude/settings.local.json`:

| Hook | Script | Status |
|------|--------|--------|
| PreCompact (save before compaction) | `.claude/hooks/pre-compact-save.sh` | LIVE |
| SessionStart(compact) (reinject after) | Inline `cat compact-reinject.md` | LIVE |
| PreToolUse(Write) (file discipline) | `.claude/hooks/check-file-location.sh` | LIVE |
| PreToolUse(Bash) (bash safety) | `.claude/hooks/check-bash-safety.sh` | LIVE |

### Still TODO
- Modify `/claude-save` to also generate `compact-reinject.md` on every save
- Test PreCompact by running `/compact` manually
- Test Write blocker by attempting a file in prohibited location
- Test Bash blocker by attempting a blocked command
- Consider Hook 4-6 (Stop activity tracking, PostToolUse architecture flag, SessionEnd cleanup)

### Questions Still Open
1. What's the ideal size for compact-reinject.md? (Currently ~500 words with key rules)
2. Should Bash hook warn or hard-block on edge cases? (Currently hard-blocks on all matches)
3. Any additional commands to block beyond DB writes, force push, reset --hard, deploy tags?
