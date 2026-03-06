# Run Local Dev Server

Start an Astro site dev server on its assigned port. Ports are fixed to match CORS rules and avoid conflicts.

**USAGE:**
- `/run-local` - Detect site from pwd and start on assigned port
- `/run-local <site>` - Start a specific site by name
- `/run-local --help` - Show this help
- `/run-local stop` - Kill all running Astro dev servers
- `/run-local status` - Show which ports are in use

**ARGUMENTS:** $ARGUMENTS

## Site Types

Sites are split by deployment method. Both types run locally the same way (`npm run dev`), but live in different directories.

### Container Sites (sites/container/)

Deployed via ECS/Fargate tag push. CORS-allowlisted ports.

| Port | Site Directory | Domain |
|------|---------------|--------|
| 3003 | container/requestdesk-ai | requestdesk.ai |
| 3004 | container/talk-commerce-com | talk-commerce.com |
| 3005 | container/contentbasis-ai | contentbasis.ai |
| 3008 | container/dreamers-inc | humans.contentcucumber.com |
| 3010 | container/brent-run | brent.run |
| 4322 | container/eovoices-com | eovoices.com |

### Amplify Sites (sites/amplify/)

Auto-deploy on git push to their own repos.

| Port | Site Directory | Domain |
|------|---------------|--------|
| 3007 | amplify/magento-masters-com | magento-masters.com |
| 3011 | amplify/commerceking-ai | commerceking.ai |
| 3012 | amplify/hirepodcast-live | hirepodcast.live |

## Site Name Aliases

Accept any of these as the `<site>` argument:

| Aliases | Resolves To | Type |
|---------|-------------|------|
| `rd`, `requestdesk`, `requestdesk-ai` | container/requestdesk-ai | container |
| `tc`, `talkcommerce`, `talk-commerce-com` | container/talk-commerce-com | container |
| `cb`, `contentbasis`, `contentbasis-ai` | container/contentbasis-ai | container |
| `di`, `dreamers`, `dreamers-inc` | container/dreamers-inc | container |
| `brent`, `brent-run` | container/brent-run | container |
| `eo`, `eovoices`, `eovoices-com` | container/eovoices-com | container |
| `mm`, `magento-masters`, `magento-masters-com` | amplify/magento-masters-com | amplify |
| `ck`, `commerceking`, `commerceking-ai` | amplify/commerceking-ai | amplify |
| `hp`, `hirepodcast`, `hirepodcast-live` | amplify/hirepodcast-live | amplify |

## Execution Steps

### Step 1: Resolve Site

**If no argument (or argument is not `stop`/`status`/`--help`):**

Detect from current working directory:
```bash
CWD=$(pwd)
# Match against astro-sites/sites/container/[dirname] or astro-sites/sites/amplify/[dirname]
SITE_DIR=$(echo "$CWD" | sed -n 's|.*astro-sites/sites/\(.*\)|\1|p' | cut -d/ -f1-2)
```

If CWD is not inside an astro site directory, show the full port table and ask which site to start.

**If argument provided:** Resolve using the alias table above. If no match, show error and the alias table.

### Step 2: Check Port

Before starting, check if the assigned port is already in use:
```bash
lsof -ti:[PORT] 2>/dev/null
```

If port is in use, **automatically kill it and restart** (no prompting):
```bash
lsof -ti:[PORT] | xargs kill -9 2>/dev/null
```
- Show: "Killed existing process on port [PORT]. Restarting..."
- Continue to Step 3.

### Step 3: Start Dev Server

```bash
cd /Users/brent/scripts/CB-Workspace/astro-sites/sites/[SITE_DIR]
npm run dev -- --port [PORT]
```

Run this in the background. Display:
```
Started [domain] on http://localhost:[PORT]
```

### Subcommand: `stop`

Kill all Astro dev servers running on assigned ports:
```bash
for PORT in 3003 3004 3005 3007 3008 3010 3011 3012 4322; do
  lsof -ti:$PORT | xargs kill 2>/dev/null
done
```

Show which ports were killed.

### Subcommand: `status`

Check each assigned port and show what's running:
```bash
for PORT in 3003 3004 3005 3007 3008 3010 3011 3012 4322; do
  PID=$(lsof -ti:$PORT 2>/dev/null)
  if [ -n "$PID" ]; then
    echo "[PORT] [site-name] - RUNNING (PID $PID)"
  else
    echo "[PORT] [site-name] - stopped"
  fi
done
```
