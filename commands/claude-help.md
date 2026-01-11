# Claude Help - Command Reference System

Display help for Claude commands, skills, and agents.

## Usage

```
/claude-help                     # List all commands by category
/claude-help <command>           # Detailed help for specific command
/claude-help --list              # Quick list of all command names
/claude-help --todo              # Show TODO commands to create/update
```

## Examples

```
/claude-help
/claude-help deploy-project
/claude-help claude-save
/claude-help --list
/claude-help --todo
```

---

## Instructions for Claude

When this command is run, read the command reference and display appropriate help.

### Step 1: Read Command Reference

```bash
cat /Users/brent/scripts/CB-Workspace/.claude/command-readme.md
```

### Step 2: Parse Arguments and Display

**If no arguments (`/claude-help`):**

Display categorized command list with brief descriptions:

```
## Claude Commands

### Session Management
  /claude-save      Save session context for handoff
  /claude-start     Resume from saved session
  /claude-switch    Switch branches with context preservation
  /claude-clean     Save work, switch to master fresh
  /claude-commit    Commit with security validation
  /claude-complete  Complete branch, merge, archive
  /claude-debug     Structured debugging with tracking

### Branch & Task Management
  /create-branch    Create branch with todo structure
  /create-bugfix    Create bugfix branch from ticket
  /finish-todo      Archive completed todo
  /plan-feature     Interactive feature planning
  /update-architecture  Update architecture docs
  /violation-log    Log Claude violations

### Auditing & Analysis
  /a11y-audit       Accessibility audit (WCAG 2.1 AA)
  /analyze-refactor-candidates  Find files needing refactor
  /audit-branches   Review git branches
  /audit-codebase   Dead code analysis
  /check-terms      Check content terms
  /lighthouse       Performance audit

### Deployment
  /deploy-project   Deploy any project (requestdesk, astro-sites)

### Personal (Local)
  /brent-start, /brent-finish, /brent-task, /daily-content

### Brand (Local)
  /brand-brent, /brand-cucumber, /brand-requestdesk, /cucumber-writer

---
Use `/claude-help <command>` for detailed help on any command.
```

**If `--list` flag:**

Display just command names in compact format:

```
Session:     claude-save, claude-start, claude-switch, claude-clean,
             claude-commit, claude-complete, claude-debug

Branch/Task: create-branch, create-bugfix, finish-todo, plan-feature,
             update-architecture, violation-log

Audit:       a11y-audit, analyze-refactor-candidates, audit-branches,
             audit-codebase, check-terms, lighthouse

Deploy:      deploy-project

Personal:    brent-start, brent-finish, brent-task, daily-content

Brand:       brand-brent, brand-cucumber, brand-requestdesk,
             cucumber-writer, brent-writing
```

**If `--todo` flag:**

Show commands that need to be created or updated:

```
## TODO: Commands to Create

| Command | Purpose |
|---------|---------|
| /claude-help | ✅ Created |
| /content-audit | SEO/AEO audit with --enrich flag |

## TODO: Commands to Update

| Command | Update Needed |
|---------|---------------|
| /claude-save | Add --close flag |
| /claude-debug | Absorb log-debug, add deployment debugging |
| /claude-start | Add security features |
```

**If specific command (`/claude-help deploy-project`):**

Read the actual command file and display full details:

```bash
cat /Users/brent/scripts/CB-Workspace/.claude/commands/<command>.md
```

Then summarize in structured format:

```
## /deploy-project

**Purpose:** Deploy any project using tag-based system with iteration support.

**Usage:**
  /deploy-project [project-name]
  /deploy-project --mark-tested [iter-N]
  /deploy-project --final

**Arguments:**
  project-name    Project to deploy (requestdesk, astro-sites, etc.)

**Flags:**
  --mark-tested   Mark iteration as production tested
  --final         Final deployment after all iterations tested

**Examples:**
  /deploy-project requestdesk
  /deploy-project astro-sites
  /deploy-project --mark-tested iter-1
  /deploy-project --final

**Location:** Public (.claude/commands/)
```

### Step 3: Handle Special Topics

**If `shortcodes` argument:**

Display workspace shortcodes from command-readme.md:

```
## Workspace Shortcodes

Used with session commands (`/claude-save`, `/claude-start`, etc.)

| Shortcode | Project | Directory |
|-----------|---------|-----------|
| rd        | RequestDesk | requestdesk-app |
| rd-test   | RequestDesk Testing | requestdesk-app-testing |
| astro     | Astro Sites | astro-sites |
| shop      | Shopify | cb-shopify |
| wpp       | WordPress Plugin | requestdesk-wordpress |
| wps       | WordPress Sites | wordpress-sites |
| mage      | Magento | cb-magento-integration |
| juno      | JunoGO | cb-junogo |
| job       | Jobs | jobs |
| brent     | Brent Workspace | brent-workspace |
| bt        | Brent Timekeeper | brent-timekeeper |
| cc        | Claude Commands | .claude |
| doc       | Documentation | documentation |

**Examples:**
  /claude-save rd           # Save RequestDesk session
  /claude-start astro       # Start Astro Sites session
  /claude-save shop --quick # Quick save Shopify session
```

### Step 4: Handle Unknown Commands

If user asks for help on a command that doesn't exist:

```
Command '/unknown-command' not found.

Did you mean one of these?
  /claude-commit
  /claude-complete

Use `/claude-help --list` to see all available commands.
Use `/claude-help shortcodes` to see workspace shortcodes.
```

---

## Notes

- Command reference is maintained in `/Users/brent/scripts/CB-Workspace/.claude/command-readme.md`
- Local commands are in `.claude-local/commands/` and symlinked
- All public commands have corresponding skills
