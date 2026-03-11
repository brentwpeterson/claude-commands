deploy-amplify - Deploy a static site to AWS Amplify (auto-deploys on git push)

**USAGE:**
- `/deploy-amplify <site>` - Commit and push changes to trigger Amplify deploy
- `/deploy-amplify --status <site>` - Check recent deploy status
- `/deploy-amplify --help` - Show this help

**SITE ALIASES:**

| Alias | Site | Domain | Repo |
|-------|------|--------|------|
| `magento-masters`, `mm` | magento-masters-com | magento-masters.com | brentwpeterson/magento-masters-com |
| `hirepodcast`, `hp` | hirepodcast-live | hirepodcast.live | brentwpeterson/hirepodcast-live |
| `commerceking`, `ck` | commerceking-ai | commerceking.ai | brentwpeterson/commerceking-ai |

---

## Handle --help

If the argument is `--help` or `-h`, show the usage above and STOP.

## Handle --status

If the first argument is `--status`:
1. Resolve the site name from the second argument using the alias table
2. Navigate to the site directory under `astro-sites/sites/amplify/`
3. Show the last 5 git commits: `git log --oneline -5`
4. Check if there are unpushed commits: `git log --oneline origin/main..HEAD 2>/dev/null || git log --oneline origin/master..HEAD 2>/dev/null`
5. Report status

## Handle deploy

1. Resolve the site name from the argument using the alias table above
2. Navigate to `$WORKSPACE/astro-sites/sites/amplify/<site-directory>`
3. Check for uncommitted changes with `git status`
4. If there are changes:
   - Stage all changes: `git add -A`
   - Ask user for a commit message (suggest one based on changed files)
   - Commit with the message
5. Check for unpushed commits
6. If there are commits to push:
   - Determine the default branch (main or master)
   - Push to origin
   - Report: "Pushed to origin. Amplify will auto-build and deploy."
7. If nothing to push:
   - Report: "No changes to deploy. Site is up to date."

**WORKSPACE:** `/Users/brent/scripts/CB-Workspace`

**IMPORTANT:** This command pushes to the site's own repo (the submodule), NOT the parent astro-sites repo. Amplify is connected to the individual site repos.
