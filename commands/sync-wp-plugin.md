# Sync WP Plugin Command

Sync RequestDesk WordPress plugin between Local by Flywheel and the canonical git repo.

**USAGE:**
- `/sync-wp-plugin` - Sync from LocalWP to canonical repo (default, capture work in git)
- `/sync-wp-plugin --to-local` - Sync from canonical repo to LocalWP (push git to testing)
- `/sync-wp-plugin --diff` - Show differences without syncing

## Directory Mapping

| Location | Path | Purpose |
|----------|------|---------|
| **LocalWP** | `/Users/brent/LocalSites/contentcucumber/app/public/wp-content/plugins/requestdesk-connector/` | Live testing |
| **Canonical** | `/Users/brent/scripts/CB-Workspace/requestdesk-wordpress/` | Git source of truth |

## Execution Steps

**Step 1: Show Current State**
```bash
echo "=== Checking file differences ==="
diff -rq /Users/brent/LocalSites/contentcucumber/app/public/wp-content/plugins/requestdesk-connector/ \
         /Users/brent/scripts/CB-Workspace/requestdesk-wordpress/ 2>/dev/null \
  | grep -v ".DS_Store" | grep -v "debug.log" | grep -v ".git" | grep -v "plugin-releases" | grep -v "todo" | grep -v ".claude" | grep -v "CLAUDE.md" | grep -v "CHANGELOG.md"
```

**Step 2: If `--diff` flag, stop here and show summary**

**Step 3: Determine direction**
- Default (no flags): LocalWP → Canonical (capture work)
- `--to-local` flag: Canonical → LocalWP (deploy for testing)

**Step 4: Execute Sync (dry-run first)**

For LocalWP → Canonical:
```bash
# Dry run first
rsync -avn --exclude='.git' --exclude='.DS_Store' --exclude='debug.log' \
  --exclude='plugin-releases' --exclude='todo' --exclude='.claude' \
  --exclude='CLAUDE.md' --exclude='CHANGELOG.md' --exclude='INSTALLATION-GUIDE.md' \
  /Users/brent/LocalSites/contentcucumber/app/public/wp-content/plugins/requestdesk-connector/ \
  /Users/brent/scripts/CB-Workspace/requestdesk-wordpress/

# If user approves
rsync -av --exclude='.git' --exclude='.DS_Store' --exclude='debug.log' \
  --exclude='plugin-releases' --exclude='todo' --exclude='.claude' \
  --exclude='CLAUDE.md' --exclude='CHANGELOG.md' --exclude='INSTALLATION-GUIDE.md' \
  /Users/brent/LocalSites/contentcucumber/app/public/wp-content/plugins/requestdesk-connector/ \
  /Users/brent/scripts/CB-Workspace/requestdesk-wordpress/
```

For Canonical → LocalWP:
```bash
# Dry run first
rsync -avn --exclude='.git' --exclude='.DS_Store' --exclude='debug.log' \
  --exclude='plugin-releases' --exclude='todo' --exclude='.claude' \
  --exclude='CLAUDE.md' --exclude='CHANGELOG.md' --exclude='INSTALLATION-GUIDE.md' \
  /Users/brent/scripts/CB-Workspace/requestdesk-wordpress/ \
  /Users/brent/LocalSites/contentcucumber/app/public/wp-content/plugins/requestdesk-connector/

# If user approves
rsync -av --exclude='.git' --exclude='.DS_Store' --exclude='debug.log' \
  --exclude='plugin-releases' --exclude='todo' --exclude='.claude' \
  --exclude='CLAUDE.md' --exclude='CHANGELOG.md' --exclude='INSTALLATION-GUIDE.md' \
  /Users/brent/scripts/CB-Workspace/requestdesk-wordpress/ \
  /Users/brent/LocalSites/contentcucumber/app/public/wp-content/plugins/requestdesk-connector/
```

**Step 5: If LocalWP → Canonical, offer to commit**
```bash
cd /Users/brent/scripts/CB-Workspace/requestdesk-wordpress
git status --short
# Ask user if they want to commit the synced changes
```

## Files Never Synced

| File | Location | Why |
|------|----------|-----|
| `.git/` | Canonical only | Version control |
| `plugin-releases/` | Canonical only | Release zips |
| `todo/` | Canonical only | Task tracking |
| `.claude/` | Canonical only | Claude context |
| `CLAUDE.md` | Canonical only | Claude instructions |
| `CHANGELOG.md` | Canonical only | Release notes |
| `debug.log` | LocalWP only | PHP debug |

## Why This Command Exists

The correct workflow per `requestdesk-wordpress/CLAUDE.md`:
1. Edit in canonical repo
2. Sync TO LocalWP for testing
3. Test in browser
4. Commit in canonical repo

But often work happens directly in LocalWP (via WP admin, quick fixes, etc.).
This command captures that work back into git.

## Related Commands
- `/claude-save wpp` - Save session for wordpress plugin work
- `/sync-wp-plugin --diff` - Check for drift before saving
