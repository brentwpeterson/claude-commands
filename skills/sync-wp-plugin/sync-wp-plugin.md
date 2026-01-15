# Sync WP Plugin - Local by Flywheel ↔ Canonical Repo

Sync RequestDesk WordPress plugin between Local by Flywheel and the canonical git repo.

**USAGE:**
- `/sync-wp-plugin` - Sync from LocalWP → canonical repo (default)
- `/sync-wp-plugin --to-local` - Sync from canonical repo → LocalWP
- `/sync-wp-plugin --diff` - Show differences without syncing

## Directory Mapping

| Location | Path | Purpose |
|----------|------|---------|
| **LocalWP (testing)** | `/Users/brent/LocalSites/contentcucumber/app/public/wp-content/plugins/requestdesk-connector/` | Live testing |
| **Canonical (git)** | `/Users/brent/scripts/CB-Workspace/requestdesk-wordpress/` | Source of truth |

## Default Behavior: LocalWP → Canonical

When you work in Local by Flywheel and want to capture changes in git:

```bash
# Show what would be synced
rsync -avn --exclude='.git' --exclude='.DS_Store' --exclude='debug.log' \
  --exclude='plugin-releases' --exclude='todo' --exclude='.claude' \
  --exclude='CLAUDE.md' --exclude='CHANGELOG.md' --exclude='INSTALLATION-GUIDE.md' \
  /Users/brent/LocalSites/contentcucumber/app/public/wp-content/plugins/requestdesk-connector/ \
  /Users/brent/scripts/CB-Workspace/requestdesk-wordpress/

# If user approves, execute the sync
rsync -av --exclude='.git' --exclude='.DS_Store' --exclude='debug.log' \
  --exclude='plugin-releases' --exclude='todo' --exclude='.claude' \
  --exclude='CLAUDE.md' --exclude='CHANGELOG.md' --exclude='INSTALLATION-GUIDE.md' \
  /Users/brent/LocalSites/contentcucumber/app/public/wp-content/plugins/requestdesk-connector/ \
  /Users/brent/scripts/CB-Workspace/requestdesk-wordpress/
```

## Reverse: Canonical → LocalWP

When you want to push git changes to Local for testing:

```bash
# Show what would be synced
rsync -avn --exclude='.git' --exclude='.DS_Store' --exclude='debug.log' \
  --exclude='plugin-releases' --exclude='todo' --exclude='.claude' \
  --exclude='CLAUDE.md' --exclude='CHANGELOG.md' --exclude='INSTALLATION-GUIDE.md' \
  /Users/brent/scripts/CB-Workspace/requestdesk-wordpress/ \
  /Users/brent/LocalSites/contentcucumber/app/public/wp-content/plugins/requestdesk-connector/

# If user approves, execute the sync
rsync -av --exclude='.git' --exclude='.DS_Store' --exclude='debug.log' \
  --exclude='plugin-releases' --exclude='todo' --exclude='.claude' \
  --exclude='CLAUDE.md' --exclude='CHANGELOG.md' --exclude='INSTALLATION-GUIDE.md' \
  /Users/brent/scripts/CB-Workspace/requestdesk-wordpress/ \
  /Users/brent/LocalSites/contentcucumber/app/public/wp-content/plugins/requestdesk-connector/
```

## Execution Steps

1. **Show current state:**
   ```bash
   echo "=== LocalWP last modified ==="
   ls -la /Users/brent/LocalSites/contentcucumber/app/public/wp-content/plugins/requestdesk-connector/*.php | head -3

   echo "=== Canonical last modified ==="
   ls -la /Users/brent/scripts/CB-Workspace/requestdesk-wordpress/*.php | head -3
   ```

2. **Run diff to show changes:**
   ```bash
   diff -rq /Users/brent/LocalSites/contentcucumber/app/public/wp-content/plugins/requestdesk-connector/ \
            /Users/brent/scripts/CB-Workspace/requestdesk-wordpress/ 2>/dev/null \
     | grep -v ".DS_Store" | grep -v "debug.log" | grep -v ".git" | grep -v "plugin-releases" | grep -v "todo"
   ```

3. **Ask user for direction:**
   - "LocalWP → Canonical (capture work in git)"
   - "Canonical → LocalWP (deploy git to testing)"
   - "Just show diff, don't sync"

4. **Execute chosen sync (dry-run first)**

5. **If LocalWP → Canonical, prompt:**
   - Show git status in canonical repo
   - Ask if user wants to commit the changes
   - If yes, create commit with summary of changes

## Files NEVER Synced

These files exist only in their respective locations:

| File | Lives In | Purpose |
|------|----------|---------|
| `.git/` | Canonical only | Version control |
| `plugin-releases/` | Canonical only | Release zips |
| `todo/` | Canonical only | Task tracking |
| `.claude/` | Canonical only | Claude context |
| `CLAUDE.md` | Canonical only | Claude instructions |
| `CHANGELOG.md` | Canonical only | Release notes |
| `debug.log` | LocalWP only | PHP debug log |
| `.DS_Store` | Neither | macOS junk |

## Recommended Workflow

**Correct flow (per CLAUDE.md):**
1. Edit in canonical repo (`CB-Workspace/requestdesk-wordpress/`)
2. Run `/sync-wp-plugin --to-local` to push to LocalWP
3. Test in browser at `http://contentcucumber.local/wp-admin/`
4. Commit in canonical repo

**Recovery flow (when you edited in LocalWP):**
1. Run `/sync-wp-plugin` to capture changes in git
2. Review and commit the changes
3. Resume correct workflow

## Integration with /claude-save

When running `/claude-save` in wordpress-sites (wps), the save command should:
1. Check if plugin files were modified in LocalWP
2. Prompt to run `/sync-wp-plugin` if drift detected
3. Include sync status in session context
