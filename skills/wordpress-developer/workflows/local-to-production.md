# Local to Production Workflow

## Content Cucumber Deployment Flow

```
Local (contentcucumber.local)
    ↓
Staging (staging.contentcucumber.com)
    ↓
Live (www.contentcucumber.com)
```

---

## Why This Workflow?

**Flywheel WAF Issue:** The Flywheel hosting firewall blocks REST API requests in the Gutenberg editor, returning 403 Forbidden errors. Until resolved:

- Cannot edit pages directly on staging/live
- Must make changes locally, then push

**Status:** Escalated to Flywheel Hosting Operations (Dec 31, 2024)

---

## Local Development

### Environment
- **Tool:** Local by Flywheel
- **Site:** contentcucumber.local
- **WP Admin:** http://contentcucumber.local/wp-admin/

### File Locations
```
Theme:  /Users/brent/LocalSites/contentcucumber/app/public/wp-content/themes/cucumber-gp-child/
Plugin: /Users/brent/LocalSites/contentcucumber/app/public/wp-content/plugins/requestdesk-connector/
```

### Development Steps
1. Make changes to theme/plugin files
2. Test in local WP admin
3. Commit changes to git
4. Push to staging

---

## Deploying to Staging

### Option 1: Local by Flywheel Push

1. Open Local app
2. Right-click site → "Push to Flywheel"
3. Select staging environment
4. Choose what to push:
   - [ ] Database
   - [x] Theme files
   - [x] Plugin files
   - [ ] Uploads

### Option 2: Manual SFTP/SSH

```bash
# SSH into staging
ssh user@staging.contentcucumber.com

# Or use SFTP client (Transmit, FileZilla)
# Upload changed files to:
# /wp-content/themes/cucumber-gp-child/
# /wp-content/plugins/requestdesk-connector/
```

### Option 3: Git Deploy (if configured)

```bash
# On staging server
cd /path/to/wp-content/themes/cucumber-gp-child
git pull origin main
```

---

## Deploying to Live

### Pre-deployment Checklist

- [ ] Changes tested on local
- [ ] Changes tested on staging
- [ ] No console errors
- [ ] Responsive design verified
- [ ] Performance acceptable
- [ ] Backup created (automatic on Flywheel)

### Deploy Steps

1. Open Local app
2. Right-click site → "Push to Flywheel"
3. Select **production** environment
4. Push theme/plugin files only (NOT database unless intentional)

### Post-deployment

1. Clear cache (Flywheel, browser, CDN if applicable)
2. Verify changes on live site
3. Spot check key pages

---

## Rollback Procedure

If something breaks on live:

### Quick Rollback (Flywheel)
1. Log into Flywheel dashboard
2. Go to Backups
3. Restore previous backup

### Git Rollback
```bash
# Find last good commit
git log --oneline

# Revert to previous commit
git checkout abc1234 -- path/to/file.css

# Or revert entire commit
git revert abc1234

# Push to server
```

---

## File Sync Checklist

When pushing changes, verify these match across environments:

### Theme Files
- [ ] style.css
- [ ] functions.php
- [ ] hero-styles.css
- [ ] mega-menu.css
- [ ] Any new template files

### Plugin Files
- [ ] Main plugin file
- [ ] admin/ directory
- [ ] includes/ directory
- [ ] assets/ directory

---

## Common Issues

### CSS not updating
- Clear browser cache (Cmd+Shift+R)
- Clear Flywheel cache
- Check version number in wp_enqueue_style

### Changes not appearing
- Verify files actually uploaded
- Check file permissions (644 for files, 755 for directories)
- Look for PHP errors in debug.log

### Gutenberg 403 errors (live/staging)
- This is the known WAF issue
- Work locally, push changes
- Don't try to edit in Gutenberg on live/staging

---

## Database Sync (When Needed)

**Caution:** Database sync overwrites content. Only do this intentionally.

### Push database to staging
1. Local → Push to Flywheel
2. Check "Database" option
3. This overwrites staging database with local

### Pull database from live
1. Flywheel dashboard → Download backup
2. Import into Local
3. Run search-replace for URLs:
   ```
   www.contentcucumber.com → contentcucumber.local
   ```

---

## Useful Commands

```bash
# Check WordPress version
wp core version

# Clear cache
wp cache flush

# Search-replace URLs after migration
wp search-replace 'https://www.contentcucumber.com' 'http://contentcucumber.local' --dry-run
wp search-replace 'https://www.contentcucumber.com' 'http://contentcucumber.local'

# Export database
wp db export backup.sql

# Import database
wp db import backup.sql
```
