View Docker Container Logs - Development Debugging Tool

**🔍 PURPOSE: QUICK CONTAINER LOG INSPECTION**
View recent logs from frontend and backend containers to debug issues, monitor hot restarts, and catch errors in real-time.

**📋 COMMAND FUNCTIONALITY:**
- Display last X lines from both cbtextapp-frontend-1 and cbtextapp-backend-1 containers
- Default to 20 lines if no number specified
- Show container status alongside logs
- Format output for easy reading and debugging
- Ideal for catching hot restart failures, import errors, and startup issues

**⚡ EXECUTION PATTERN:**

**Basic Usage (20 lines default):**
```bash
# Show last 20 lines from both containers
docker logs cbtextapp-backend-1 --tail 20 2>&1 | head -20
echo "--- BACKEND LOGS (last 20 lines) ---"
docker logs cbtextapp-backend-1 --tail 20
echo ""
echo "--- FRONTEND LOGS (last 20 lines) ---"  
docker logs cbtextapp-frontend-1 --tail 20
echo ""
echo "--- CONTAINER STATUS ---"
docker ps --filter name=cbtextapp --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
```

**With Custom Line Count:**
```bash
# Show last X lines from both containers (replace X with desired number)
LINES=${1:-20}  # Default to 20 if no argument provided
echo "=== DOCKER CONTAINER LOGS (last $LINES lines) ==="
echo ""
echo "--- BACKEND CONTAINER (cbtextapp-backend-1) ---"
docker logs cbtextapp-backend-1 --tail $LINES
echo ""
echo "--- FRONTEND CONTAINER (cbtextapp-frontend-1) ---"  
docker logs cbtextapp-frontend-1 --tail $LINES
echo ""
echo "--- CONTAINER STATUS ---"
docker ps --filter name=cbtextapp --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
```

**🎯 COMMON USE CASES:**

**1. Debug Hot Restart Failures:**
```bash
# Monitor for restart failures after code changes
echo "Checking for hot restart issues..."
docker logs cbtextapp-backend-1 --tail 30 | grep -E "ERROR|ImportError|startup failed|Application startup"
```

**2. Check Import Errors:**
```bash
# Look for Python import issues
echo "Checking for import errors..."
docker logs cbtextapp-backend-1 --tail 50 | grep -E "ImportError|ModuleNotFoundError|cannot import"
```

**3. Monitor Email Configuration:**
```bash
# Check email config on startup
echo "Checking email configuration..."
docker logs cbtextapp-backend-1 --tail 30 | grep -E "Email Configuration|SMTP|EMAIL"
```

**4. Check Database Connections:**
```bash
# Monitor database connection status
echo "Checking database connections..."
docker logs cbtextapp-backend-1 --tail 30 | grep -E "Database|MongoDB|connection"
```

**🚨 ERROR PATTERNS TO WATCH FOR:**

**Migration Import Errors:**
- `ImportError: cannot import name 'Migration'`
- `cannot import name 'BaseMigration'`

**Hot Restart Failures:**  
- `Application startup failed. Exiting.`
- `ERROR: Application could not start`

**Database Issues:**
- `Failed to connect to MongoDB`
- `Database connection error`

**Email Configuration Problems:**
- Still showing old domain: `contentbasis.io` or `contentbasis.ai`
- Still showing old branding: `Content Basis`

**🔧 ADVANCED USAGE:**

**Real-time Log Monitoring:**
```bash
# Follow logs in real-time (useful during development)
echo "Following backend logs in real-time (Ctrl+C to stop)..."
docker logs cbtextapp-backend-1 --follow
```

**Filter for Specific Patterns:**
```bash
# Show only ERROR and WARNING messages
echo "Filtering for errors and warnings..."
docker logs cbtextapp-backend-1 --tail 100 | grep -E "ERROR|WARNING|CRITICAL"
```

**Compare Before/After Changes:**
```bash
# Take snapshot before making changes
echo "=== LOGS BEFORE CHANGES ==="
docker logs cbtextapp-backend-1 --tail 10
echo ""
echo "Make your code changes now, then run again to compare..."
```

**📊 STANDARD OUTPUT FORMAT:**
```
=== DOCKER CONTAINER LOGS (last 20 lines) ===

--- BACKEND CONTAINER (cbtextapp-backend-1) ---
2025-08-26 14:11:34,157 - app.main - INFO - Email Configuration:
2025-08-26 14:11:34,158 - app.main - INFO - SMTP From Email: noreply@contentbasis.ai
INFO:     Application startup complete.

--- FRONTEND CONTAINER (cbtextapp-frontend-1) ---
webpack compiled successfully
webpack 5.88.1 compiled with 0 errors in 2.3s

--- CONTAINER STATUS ---
NAMES                  STATUS       PORTS
cbtextapp-frontend-1   Up 2 hours   0.0.0.0:3001->3001/tcp
cbtextapp-backend-1    Up 2 hours   0.0.0.0:3000->3000/tcp
```

**🎯 INTEGRATION WITH DEVELOPMENT WORKFLOW:**

**Before Making Code Changes:**
1. Run `/view-docker-logs` to see current state
2. Make code changes
3. Run `/view-docker-logs` again to see hot restart results
4. Check for errors or configuration changes

**During Migration Development:**
1. Create migration file
2. Run `/view-docker-logs` to check for import errors
3. Fix any issues
4. Run migration manager
5. Run `/view-docker-logs` to verify success

**When Debugging Issues:**
1. Run `/view-docker-logs` to see recent activity
2. Look for error patterns
3. Check container status
4. Use advanced filtering for specific issues

**⚠️ IMPORTANT NOTES:**

- Logs are ephemeral - container restart clears log history
- Use `--tail` to limit output and avoid overwhelming the terminal
- `docker logs` without `--tail` shows ALL logs since container start
- Containers auto-restart on code changes (hot reload)
- Backend logs are more verbose than frontend logs
- Check container status if logs seem empty (container might be restarting)

**🔗 RELATED COMMANDS:**
- `/debug-deployment` - For production deployment debugging
- `/debug-production` - For production environment issues
- `/claude-start` - Session context recovery (can use logs for validation)

This command is essential for development debugging and should be used frequently when developing, especially when making code changes that trigger hot restarts.