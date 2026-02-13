# Claude Help - Command Reference System

Display help for Claude commands, skills, and agents. All lists are dynamic (scanned at runtime).

## Usage

```
/claude-help                     # Overview with counts and subcommand guide
/claude-help list-commands       # All slash commands with descriptions
/claude-help list-skills         # All skill backends with descriptions
/claude-help list-agents         # Active/saved/parked Claude sessions
/claude-help <command>           # Detailed help for a specific command
/claude-help shortcodes          # Workspace shortcodes table
```

## Examples

```
/claude-help list-commands
/claude-help list-skills
/claude-help list-agents
/claude-help deploy-project
/claude-help shortcodes
```

---

## --help Handler

If arguments contain `--help` or `-h`, display the Usage section above and STOP.

---

## Instructions for Claude

### Constants

```
WORKSPACE_ROOT = /Users/brent/scripts/CB-Workspace
SHARED_COMMANDS = /Users/brent/scripts/CB-Workspace/.claude/commands
LOCAL_COMMANDS = /Users/brent/scripts/CB-Workspace/.claude-local/commands
SKILLS_DIR = /Users/brent/scripts/CB-Workspace/.claude/skills
CONTEXT_DIR = /Users/brent/scripts/CB-Workspace/.claude/branch-context
LATER_DIR = /Users/brent/scripts/CB-Workspace/.claude/branch-context/later
NAMES_FILE = /Users/brent/scripts/CB-Workspace/.claude/local/active-claude-names.json
```

---

### Subcommand: `list-commands`

**Dynamically scan both command directories and display all commands with descriptions.**

**Steps:**
1. Scan `SHARED_COMMANDS/*.md` and `LOCAL_COMMANDS/*.md`
2. For each file: extract filename (minus `.md`) as command name, first line (minus `# `) as description
3. Skip broken symlinks (note them at bottom)
4. Identify which commands are shared, local-only, or both
5. Categorize and display

**How to scan:**
```bash
# Shared commands (skip broken symlinks)
for f in /Users/brent/scripts/CB-Workspace/.claude/commands/*.md; do
  [ -f "$f" ] || continue  # skip broken symlinks
  name=$(basename "$f" .md)
  desc=$(head -1 "$f" | sed 's/^# //')
  echo "$name|$desc"
done

# Local commands
for f in /Users/brent/scripts/CB-Workspace/.claude-local/commands/*.md; do
  [ -f "$f" ] || continue
  name=$(basename "$f" .md)
  desc=$(head -1 "$f" | sed 's/^# //')
  echo "$name|$desc"
done

# Find broken symlinks
find /Users/brent/scripts/CB-Workspace/.claude/commands/ -maxdepth 1 -type l ! -exec test -e {} \; -print
```

**Categories (assign by prefix/keyword):**

| Category | Commands matching |
|----------|-----------------|
| Session Management | `claude-save`, `claude-start`, `claude-switch`, `claude-clean`, `claude-commit`, `claude-complete`, `claude-resume`, `claude-later`, `claude-trash`, `claude-debug`, `claude-comms`, `claude-learner`, `claude-help` |
| Task & Branch | `start-work`, `create-bugfix`, `create-branch`, `finish-todo`, `plan-feature`, `update-architecture`, `sprint` |
| Content & Writing | `rd-blog`, `twc-*`, `daily-content`, `newsletter-planner`, `content-audit`, `check-terms`, `cucumber`, `brent-writing`, `agentic-reader` |
| Communication | `respond-email`, `respond-comment`, `send-email` |
| Social & Marketing | `create-social`, `social-post`, `plan-social`, `linkedin` |
| Brand Personas | `brand-*` |
| Auditing & Analysis | `a11y-audit`, `audit-*`, `analyze-*`, `lighthouse`, `ai-detect`, `sentry-report` |
| HubSpot & CRM | `hubspot-enrich`, `detect-platform` |
| Deployment & Ops | `deploy-*`, `sync-*`, `rotate-violations`, `violation-log` |
| Design | `frontend-design`, `canva` |
| Personal / Daily | `brent-start`, `brent-finish`, `brent-task` |

**Display format:**

```
## Commands (XX total: XX shared, XX local-only)

### Session Management
  /claude-save           Session context save for handoff
  /claude-start          Resume from saved session
  ...

### Content & Writing
  /rd-blog               Create blog posts with Brent's voice
  /twc-start             Start article for Tuesdays with Claude
  /cucumber          [L] Content Cucumber Unified Command
  ...

### Local-Only Commands (in .claude-local/ but not .claude/)
  /cucumber          [L] Content Cucumber Unified Command
  /deploy-main-site  [L] GitHub Actions Automated Deployment
  ...
```

**Rules:**
- Left-pad command names to 24 chars, then description
- Truncate descriptions at 55 chars if needed
- Mark local-only commands with `[L]`
- Show deprecated commands at bottom with strikethrough or note
- Report broken symlinks at bottom: "Broken symlink: cucumber-writer.md (target missing)"

---

### Subcommand: `list-skills`

**Dynamically scan skill directories and display all skills with descriptions.**

**Steps:**
1. List all directories in `SKILLS_DIR/`
2. For each, read first line of `SKILL.md` (minus `# `) as description
3. Check if a corresponding command exists (same name or known mapping)
4. Display as table

**How to scan:**
```bash
for dir in /Users/brent/scripts/CB-Workspace/.claude/skills/*/; do
  name=$(basename "$dir")
  if [ -f "$dir/SKILL.md" ]; then
    desc=$(head -1 "$dir/SKILL.md" | sed 's/^# //')
  else
    desc="(no SKILL.md)"
  fi
  echo "$name|$desc"
done
```

**Known skill-to-command mappings** (when names differ):

| Skill directory | Command |
|----------------|---------|
| `canva-design` | `/canva` |
| `communicate-claude` | `/claude-comms` |
| `content-cucumber` | `/cucumber` |
| `brent-workspace` | `/brent-start` |
| `sprint-management` | `/sprint` |
| `social-campaign` | `/plan-social` |
| `gmail-responses` | `/respond-email` |
| `new-work-standards` | `/start-work` |
| `project-todo-init` | (internal, no command) |
| `skill-creation` | (reference, no command) |
| `rd-astro-blog` | `/rd-blog` (Astro variant) |

For unmapped skills: check if `SKILLS_DIR/<name>` matches a command in either command directory.

**Display format:**

```
## Skills (XX total)

| Skill | Description | Command |
|-------|-------------|---------|
| agentic-reader | Content Audience Evaluation | /agentic-reader |
| astro-sites | Astro Sites Skill | - |
| aws-infra | AWS Infrastructure Deployment | - |
| brand-family | Unified Brand Ecosystem | /brand-* |
| canva-design | AI-Driven Design Creation | /canva |
| communicate-claude | Inter-Instance Messaging | /claude-comms |
| content-cucumber | Full Brand Skill | /cucumber |
| ...

Skills without commands are backend-only (used internally by other skills or commands).
```

---

### Subcommand: `list-agents`

**Show all Claude agent sessions: active, saved, and parked.**

**Steps:**
1. Read `NAMES_FILE` for registered names
2. Scan `CONTEXT_DIR/*-context.md` for session files
3. Scan `LATER_DIR/*-context.md` for parked sessions
4. For each file extract: Identity (from `**Identity:**`), Status (from `**Status:**`), Last Saved (from `**Last Saved:**`), workspace (filename prefix before first date)

**How to scan:**
```bash
# Active/saved sessions
for f in /Users/brent/scripts/CB-Workspace/.claude/branch-context/*-context.md; do
  name=$(basename "$f")
  ident=$(grep -m1 '^\*\*Identity:\*\*' "$f" 2>/dev/null | sed 's/\*\*Identity:\*\* //')
  stat=$(grep -m1 '^\*\*Status:\*\*' "$f" 2>/dev/null | sed 's/\*\*Status:\*\* //')
  saved=$(grep -m1 '^\*\*Last Saved:\*\*' "$f" 2>/dev/null | sed 's/\*\*Last Saved:\*\* //')
  echo "$name|$ident|$stat|$saved"
done

# Parked sessions
for f in /Users/brent/scripts/CB-Workspace/.claude/branch-context/later/*-context.md; do
  [ -f "$f" ] || continue
  name=$(basename "$f")
  ident=$(grep -m1 '^\*\*Identity:\*\*' "$f" 2>/dev/null | sed 's/\*\*Identity:\*\* //')
  stat=$(grep -m1 '^\*\*Status:\*\*' "$f" 2>/dev/null | sed 's/\*\*Last Saved:\*\* //')
  echo "$name|$ident|PARKED|$stat"
done

# Registered names
cat /Users/brent/scripts/CB-Workspace/.claude/local/active-claude-names.json
```

**Display format:**

```
## Claude Agents

### Active Sessions
| Agent | Workspace | Last Saved |
|-------|-----------|------------|
| Claude-Darwin | cc | 2026-02-06 |
| Claude-Curie | brent | 2026-02-06 |

### Saved Sessions (ready to resume with /claude-start <name>)
| Agent | Workspace | Last Saved |
|-------|-----------|------------|
| Claude-Feynman | contentcucumber | 2026-02-05 |
| Claude-Shackleton | wordpress-ext | 2026-02-05 |

### Parked Sessions (resume with /claude-start <name>)
| Agent | Workspace | File |
|-------|-----------|------|
| Claude-Lovelace | brent | brent-2026-02-06-lovelace-context.md |

### Legacy Sessions (no agent identity)
| File | Workspace |
|------|-----------|
| brent-2026-02-03-context.md | brent |
| rd-2026-02-03-context.md | rd |

Registered names: Claude-Curie, Claude-Darwin, Claude-Feynman, Claude-Tesla
```

**Rules:**
- Group by status: ACTIVE, SAVED, PARKED (from later/), legacy (no identity)
- Extract workspace from filename: everything before the first date pattern (`YYYY-MM-DD`)
- Show registered names from JSON at bottom
- Include resume instructions

---

### Subcommand: `<command-name>` (specific command help)

**Show detailed help for a specific command.**

**Steps:**
1. Check `SHARED_COMMANDS/<command>.md` exists (and is not a broken symlink)
2. If not, check `LOCAL_COMMANDS/<command>.md`
3. If not found, show "not found" with fuzzy suggestions
4. Read the command file
5. Extract and display structured summary

**Display format:**
```
## /<command-name>

**Purpose:** [First line, minus # prefix]
**Location:** [Shared (.claude/commands/) | Local (.claude-local/commands/) | Both]

**Usage:**
  [Extract content under ## Usage or **USAGE:** heading]

**Examples:**
  [Extract content under ## Examples heading]

**Skill Backend:** [Yes (.claude/skills/<name>/SKILL.md) | No]
```

**If command not found:**
```
Command '/<name>' not found.

Similar:
  /<match-1>    [description]
  /<match-2>    [description]

Run /claude-help list-commands to see all commands.
```

Find similar by: shared prefix, or command name contains the search term as substring.

---

### Subcommand: `shortcodes`

Display workspace shortcodes from CLAUDE.md:

```
## Workspace Shortcodes

Used with session commands (/claude-save, /claude-start, etc.)

| Shortcode | Project | Directory |
|-----------|---------|-----------|
| rd | RequestDesk | requestdesk-app |
| rd-test | RequestDesk Testing | requestdesk-app-testing |
| astro | Astro Sites | astro-sites |
| shop | Shopify | cb-shopify |
| wpp | WordPress Plugin | requestdesk-wordpress |
| wps | WordPress Sites | wordpress-sites |
| mage | Magento | cb-magento-integration |
| juno | JunoGO | cb-junogo |
| job | Jobs | jobs |
| brent | Brent Workspace | brent-workspace |
| bt | Brent Timekeeper | brent-timekeeper |
| cc | Claude Commands | .claude |
| doc | Documentation | documentation |
```

---

### No arguments (`/claude-help`)

Show overview with live counts. Run the scans from each subcommand but only count results.

**Display format:**
```
## Claude Help

  /claude-help list-commands    All slash commands (XX total)
  /claude-help list-skills      Skill backends (XX total)
  /claude-help list-agents      Claude sessions (XX active, XX saved, XX parked)
  /claude-help <command>        Detailed help for a specific command
  /claude-help shortcodes       Workspace shortcode reference

Quick counts:
  Shared commands:  XX (.claude/commands/)
  Local commands:   XX (.claude-local/commands/)
  Local-only:       XX (not symlinked to shared)
  Skill backends:   XX (.claude/skills/)
  Broken symlinks:  XX (need cleanup)
```

---

## Notes

- All lists are generated dynamically by scanning the filesystem
- No hardcoded command lists. Always reflects current state.
- Shared commands: `.claude/commands/` (committed to repo)
- Local commands: `.claude-local/commands/` (gitignored, personal)
- Skills: `.claude/skills/*/SKILL.md` (committed to repo)
- Agent sessions: `.claude/branch-context/*-context.md`
