# Proprietary Command Policy

## Overview

The `.claude` repository is designed to be shareable/public. Proprietary commands containing:
- API keys or secrets
- Business-specific logic (Content Cucumber, RequestDesk)
- Personal workflow details (Brent Peterson, Tuesdays with Claude)

**MUST** live in `.claude-local` (separate private repo) and be symlinked into `.claude/commands/`.

## Architecture

```
CB-Workspace/
├── .claude/                    # PUBLIC - Shareable command templates
│   └── commands/
│       ├── claude-start.md     # Generic workflow command
│       ├── brand-brent.md      # → SYMLINK to .claude-local
│       └── add-backlog.md      # → SYMLINK to .claude-local
│
└── .claude-local/              # PRIVATE - Business-specific commands
    └── commands/
        ├── brand-brent.md      # Actual proprietary file
        └── add-backlog.md      # Contains API keys
```

## Automated Checks

### Pre-Commit Hook
Automatically runs on every commit to `.claude` repo:
- Scans all `commands/*.md` files that are NOT symlinks
- Blocks commit if API keys/secrets detected (CRITICAL)
- Warns if business-specific content detected (WARNING)

### Manual Check
```bash
cd /Users/brent/scripts/CB-Workspace/.claude
./scripts/check-proprietary-commands.sh           # Normal check
./scripts/check-proprietary-commands.sh --strict  # Fail on warnings
./scripts/check-proprietary-commands.sh --fix     # Show fix commands
```

## Weekly Audit Process

**When:** Every Monday (or first work day of week)
**Who:** Run during `/brent-start` or first Claude session

### Steps:

1. **Run the audit:**
   ```bash
   cd /Users/brent/scripts/CB-Workspace/.claude
   ./scripts/check-proprietary-commands.sh --strict
   ```

2. **If issues found:**
   ```bash
   # Get fix commands
   ./scripts/check-proprietary-commands.sh --fix

   # For each flagged file:
   mv commands/[filename].md /Users/brent/scripts/CB-Workspace/.claude-local/commands/
   ln -s ../../.claude-local/commands/[filename].md commands/[filename].md

   # Update .gitignore
   echo "commands/[filename].md" >> .gitignore
   ```

3. **Verify symlinks work:**
   ```bash
   # All proprietary commands should be symlinks
   ls -la commands/ | grep "^l"
   ```

4. **Commit .claude-local changes:**
   ```bash
   cd /Users/brent/scripts/CB-Workspace/.claude-local
   git add -A
   git commit -m "Add proprietary commands"
   git push
   ```

## Proprietary Indicators

### CRITICAL (Blocks Commit)
- `Bearer [token]` - API authentication tokens
- `app.requestdesk.ai/api` - Production API endpoints
- `MNRcaklW` - Known API key prefix
- `API_KEY=` with long alphanumeric value

### WARNING (Review Required)
- `Content Cucumber` - Business brand
- `Tuesdays with Claude` - Personal brand content
- `contentcucumber.com` - Business domain
- `Brent Peterson` - Personal name in business context

## Current Proprietary Commands

As of 2026-01-11, these commands are properly symlinked:

| Command | Type | Reason |
|---------|------|--------|
| `brand-brent.md` | Brand | Personal brand persona |
| `brand-cucumber.md` | Brand | Business brand persona |
| `brand-requestdesk.md` | Brand | Product brand persona |
| `brent-start.md` | Workflow | Personal daily workflow |
| `brent-finish.md` | Workflow | Personal daily workflow |
| `brent-task.md` | Workflow | Personal task tracking |
| `daily-content.md` | Workflow | Personal content planning |
| `add-backlog.md` | API | Contains API key |
| `check-terms.md` | API | Contains API key |
| `content-audit.md` | Business | CC-specific logic |
| `newsletter-planner.md` | Workflow | Personal paths |
| `cucumber-writer.md` | Business | CC-specific logic |
| `twc-*.md` | Content | Tuesdays with Claude series |

## Troubleshooting

### Commit blocked but I need this command public
The command likely needs to be refactored to:
1. Remove hardcoded secrets → Use environment variables
2. Remove business-specific logic → Make generic with config
3. Remove personal references → Use placeholders

### Symlink broken
```bash
# Check symlink target
ls -la commands/[filename].md

# Recreate if broken
rm commands/[filename].md
ln -s ../../.claude-local/commands/[filename].md commands/[filename].md
```

### .claude-local not set up
```bash
mkdir -p /Users/brent/scripts/CB-Workspace/.claude-local/commands
cd /Users/brent/scripts/CB-Workspace/.claude-local
git init
echo "# Claude Local Commands" > README.md
git add -A
git commit -m "Initial commit"
```
