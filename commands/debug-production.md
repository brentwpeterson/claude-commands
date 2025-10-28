Debug Production Issue: $ARGUMENTS

**Issue Description:** $ARGUMENTS (describe the production issue or endpoint to debug)
**Action:** Interactive real-time production debugging with AWS CloudWatch integration

**🚨 CRITICAL SAFETY RULES - READ BEFORE PROCEEDING**
1. **VERSION MANAGEMENT:**
   - **NEVER increment VERSION file for debug logging or code-only fixes**
   - **ONLY increment VERSION when creating database migrations**
   - Use current VERSION for git tags unless migration is created

2. **DATABASE CHANGES:**
   - **MANDATORY local testing for any migration or schema change**
   - **NEVER deploy database changes to production without local testing first**
   - Run `docker exec cbtextapp-backend-1 python -m app.migrations.migration_manager --run` locally
   - Verify migration works and doesn't break existing functionality

3. **DEPLOYMENT SAFETY:**
   - Always test fixes locally before production deployment
   - Database changes require explicit user confirmation after local testing
   - Use proper git tag versioning (don't increment unnecessarily)

**🔍 INTERACTIVE DEBUG SESSION STARTING**

**Phase 1: Issue Analysis & Environment Setup**
1. **📋 Analyze Issue Description:**
   - Show identified components that may be affected
   - Display which log groups will be monitored
   - Ask user: "Does this analysis look correct? Any specific endpoints or user scenarios to focus on?"

2. **🔧 ECS Task Health Assessment (CRITICAL FIRST STEP):**
   - **ALWAYS check ECS task status FIRST before assuming services are running:**
   ```bash
   # Check current service status and task health
   aws ecs describe-services --cluster cb-app-cluster --services cb-app-service
   aws ecs list-tasks --cluster cb-app-cluster --service-name cb-app-service
   aws ecs describe-tasks --cluster cb-app-cluster --tasks $(aws ecs list-tasks --cluster cb-app-cluster --service-name cb-app-service --query 'taskArns[]' --output text | head -3)
   ```
   - **Analyze task status with clear interpretation:**
     - ✅ `RUNNING` = Service is healthy
     - ⚠️ `PENDING` = Service is starting (normal during deployment)  
     - 🔴 `STOPPED` = Service failed - GET STOP REASON IMMEDIATELY
     - 🔄 `PROVISIONING` = Container is being provisioned
   - **For STOPPED tasks, get failure details:**
   ```bash
   # Get stop reasons for failed tasks
   aws ecs describe-tasks --cluster cb-app-cluster --tasks [TASK-ARN] --query 'tasks[].{StopReason:stopCode,StopDescription:stoppedReason,ExitCode:containers[].exitCode,LastStatus:lastStatus}'
   ```
   - **Critical status interpretation:**
     - "Task failed container health checks" = App startup failure
     - "Essential container in task exited" = Application crash
     - "CannotPullContainerError" = Docker image issue
     - "ResourcesNotAvailable" = Infrastructure issue
   - **Display clear status summary:**
     - "🚨 CRITICAL: 3 tasks failed with [SPECIFIC_REASON]"
     - "⚠️ WARNING: Service is restarting due to [SPECIFIC_CAUSE]"  
     - "✅ HEALTHY: All tasks running normally"
   - Ask user: "ECS analysis complete. Status: [CLEAR_STATUS]. Should we investigate the [SPECIFIC_ISSUE] or proceed differently?"

3. **🔧 Prepare Debug Environment:**
   - Check AWS CLI access: `aws sts get-caller-identity`
   - **Verified Service Architecture:**
     - **Cluster:** `cb-app-cluster`
     - **Backend API:** `cb-app-service` 
     - **Frontend:** `cb-app-frontend-service`
     - **Redis/Celery:** `cb-app-redis-service`
     - **Documentation:** `cb-app-documentation-service`
   - **Log Configuration:**
     - **Log Group:** `/ecs/cb-app` (shared by all services)
     - **Stream Pattern:** `ecs/cb-app/[task-id]`
     - **Dynamic Task ID:** `aws ecs list-tasks --cluster cb-app-cluster --service-name [SERVICE] --query 'taskArns[0]' --output text | cut -d'/' -f3`
   - **Get deployment timeline with failure correlation:**
   ```bash
   # Show recent deployments and when failures started
   aws ecs describe-services --cluster cb-app-cluster --services cb-app-service --query 'services[].deployments[?status==`PRIMARY`].{Status:status,CreatedAt:createdAt,TaskDefinition:taskDefinition}'
   ```
   - Ask user: "Environment ready. ECS shows [SPECIFIC_STATUS]. Should we proceed with [APPROPRIATE_ACTION] based on this status?"

**Phase 2: Interactive Debug Setup** 
3. **🔬 Add Debug Logging (Interactive):**
   - Show current code for the problematic endpoint
   - Ask user: "I found the endpoint code. Should I add comprehensive debug logging now?"
   - If yes: Add detailed logging with progress updates:
     ```python
     logger.error("=== DEBUG: endpoint_name called ===")
     logger.error(f"Request data: {request_data}")
     logger.error(f"Current user: {current_user}")
     logger.error(f"Processing step: {step_description}")
     ```
   - Show exactly what logging was added
   - Ask user: "Debug logging added. Ready to deploy?"

4. **🚀 Interactive Deployment:**
   - **CRITICAL VERSION RULES:**
     - **NEVER increment VERSION file for debug logging or code-only changes**
     - **ONLY increment VERSION if creating new database migrations**
     - Show current VERSION and use SAME version for git tag (unless migration created)
   - Ask user: "Deploying version X.Y.Z with debug logging. Confirm deployment?"
   - **Do NOT update VERSION file** unless migration was created
   - Commit with clear debug message
   - Create deployment tag using CURRENT VERSION and push
   - Show deployment progress: "⏳ Deployment started... ETA: ~20 minutes"
   - Ask user: "Deployment initiated. While we wait, would you like me to explain what we're monitoring for?"

**Phase 3: Interactive Real-Time Monitoring**
5. **📡 Comprehensive Log Analysis (ENHANCED):**
   - **ALWAYS check ECS task status BEFORE log monitoring:**
   ```bash
   # Re-verify current task health before log analysis
   aws ecs describe-services --cluster cb-app-cluster --services cb-app-service --query 'services[].{DesiredCount:desiredCount,RunningCount:runningCount,PendingCount:pendingCount}'
   ```
   - **Get current running task ID dynamically:**
   ```bash
   # Get current task ID for log analysis
   CURRENT_TASK=$(aws ecs list-tasks --cluster cb-app-cluster --service-name cb-app-service --query 'taskArns[0]' --output text | cut -d'/' -f3)
   echo "Current task: $CURRENT_TASK"
   ```
   - **Get comprehensive failure analysis:**
   ```bash
   # Get detailed stop reasons for failed tasks (last 10 tasks)
   aws ecs list-tasks --cluster cb-app-cluster --service-name cb-app-service --desired-status STOPPED --max-results 10
   aws ecs describe-tasks --cluster cb-app-cluster --tasks [STOPPED-TASK-ARNS] --query 'tasks[].[taskArn,stopCode,stoppedReason,containers[].{exitCode:exitCode,reason:reason}]'
   
   # Get the most recent logs using dynamic task ID
   aws logs get-log-events --log-group-name "/ecs/cb-app" --log-stream-name "ecs/cb-app/$CURRENT_TASK" --start-time $(python3 -c "import time; print(int((time.time() - 3600) * 1000))") --limit 50
   ```
   - **Enhanced keyword filtering:**
   ```bash
   # Search for specific issues in logs (works for all services)
   aws logs filter-log-events --log-group-name "/ecs/cb-app" --start-time $(python3 -c "import time; print(int((time.time() - 1800) * 1000))") --filter-pattern "ERROR|CRITICAL|TypeError|ImportError|500"
   
   # Search for specific functionality (e.g., authentication, database, API calls)
   aws logs filter-log-events --log-group-name "/ecs/cb-app" --start-time $(python3 -c "import time; print(int((time.time() - 1800) * 1000))") --filter-pattern "google|auth|database"
   ```
   - **Display clear failure analysis:**
     - "🚨 TASK FAILURE: [EXACT_ERROR] causing containers to exit with code [EXIT_CODE]"
     - "🔍 LOG ANALYSIS: Found [COUNT] instances of [SPECIFIC_ERROR] in last 30 minutes"
     - "⚠️ HEALTH CHECK: Tasks failing health checks due to [SPECIFIC_REASON]"
   - Ask user: "Log analysis complete. Root cause: [SPECIFIC_DIAGNOSIS]. Should we fix [SPECIFIC_ISSUE] or investigate further?"

6. **📊 Service Health vs. Log Reality Check:**
   - **NEVER assume service is healthy without checking both:**
     1. ECS task status (are containers actually running?)
     2. Application logs (are there startup errors?)
     3. Health check results (is the app responding?)
   - **Critical questions to answer:**
     - "Are tasks ACTUALLY running or in restart loop?"
     - "If running, are they responding to health checks?"
     - "Are there application errors causing degraded service?"
   - **Status reporting format:**
     - "✅ SERVICE HEALTHY: X/X tasks running, health checks passing, no errors in logs"
     - "🔄 SERVICE RECOVERING: X/X tasks restarting due to [REASON], ETA for stability: [TIME]"
     - "🚨 SERVICE FAILED: 0/X tasks running, all failing with [SPECIFIC_ERROR]"
   - Ask user: "Service reality check: [ACCURATE_STATUS]. Based on this, should we [APPROPRIATE_ACTION]?"

6. **🎭 Interactive Test Scenario Execution:**
   - Ask user: "Please describe the exact steps to reproduce the issue, then execute them."
   - Show live log stream with real-time commentary:
     - "📥 I see an incoming request..."
     - "🔍 Processing authentication..."
     - "⚠️ Error detected at step X..."
     - "📊 Captured error details..."
   - Immediately analyze captured logs and explain what's happening
   - Ask user: "I've captured the error. Would you like me to analyze it now or try reproducing it again?"

**Phase 4: Interactive Advanced Analysis**
7. **🕵️ Deep Log Analysis with Failure Context (ENHANCED):**
   - **CRITICAL: Always provide deployment context with errors:**
   ```bash
   # Get deployment timeline to correlate with failures
   aws ecs describe-services --cluster cb-app-cluster --services cb-app-service --query 'services[].deployments[].[status,createdAt,taskDefinition,updatedAt]'
   
   # Find when errors started relative to deployments
   aws logs filter-log-events --log-group-name "/ecs/cb-app" --start-time $(date -d '2 hours ago' +%s)000 --filter-pattern "ERROR|CRITICAL|FAILED|TypeError|ImportError" --query 'events[].[timestamp,message]' --output table
   ```
   - **Failure timeline analysis:**
     - "📅 DEPLOYMENT TIMELINE: Last deployment at [TIME], errors started [TIME_RELATION]"
     - "🔍 ERROR CORRELATION: [COUNT] errors began [X] minutes after deployment" 
     - "⚠️ PATTERN DETECTED: All failures related to [SPECIFIC_MODULE/FUNCTION]"
   - **Enhanced error context:**
   ```bash
   # Get full error context (before/after lines)
   aws logs get-log-events --log-group-name "/ecs/cb-app" --log-stream-name "[LATEST-STREAM]" --start-time [ERROR_TIMESTAMP-300]000 --end-time [ERROR_TIMESTAMP+300]000
   ```
   - **Smart failure categorization:**
     - "🚨 STARTUP FAILURE: Container exits immediately with [ERROR]"
     - "⚠️ RUNTIME FAILURE: App starts but crashes on [SPECIFIC_OPERATION]" 
     - "🔄 INTERMITTENT FAILURE: Service works but fails [PERCENTAGE]% of requests"
   - Ask user: "Deep analysis complete. This is a [FAILURE_CATEGORY] caused by [ROOT_CAUSE]. Should we fix [SPECIFIC_ISSUE] or need more investigation?"

8. **💾 Interactive Database Investigation:**
   - Ask user: "I suspect a database issue. Let me check the data state."
   - Show investigation with explanations:
     ```bash
     # 🔍 Checking database state...
     docker exec -it cbtextapp-backend-1 python -c "..."
     ```
   - Explain results: "The database shows X, which means Y..."
   - Ask user: "Database analysis complete. The issue appears to be Z. Should I proceed with the fix?"

9. **🩺 Interactive Service Health Checks:**
   - Show health check results with interpretation:
     ```bash
     # ✅ Checking service health...
     # 🔍 Verifying database connections...
     # 🔐 Checking authentication flows...
     ```
   - Provide status summary: "All services are healthy/Service X has issues..."
   - Ask user: "Health check complete. Ready to implement the fix?"

**Phase 5: Interactive Issue Resolution**
10. **🎯 Root Cause Identification (Collaborative):**
    - Present analysis summary: "Based on our investigation, I've identified the root cause as X because Y."
    - Show comparison: "Local works because A, but production fails because B."
    - Ask user: "Does this root cause analysis make sense? Any additional context to consider?"
    - Present evidence: "Here's the specific difference I found..."

11. **🔧 Interactive Fix Implementation:**
    - Present proposed fix: "I recommend fixing this by doing X. Here's the code change needed..."
    - Show exact changes before implementing
    - Ask user: "Does this fix look correct? Should I implement it?"
    - If approved: Implement fix with progress updates
    - Show completed changes and ask: "Fix implemented. Ready to test locally first?"

12. **🧪 MANDATORY LOCAL TESTING (Database Changes):**
    - **CRITICAL: If fix includes database migrations or schema changes:**
      - **STOP! MUST test locally first before any production deployment**
      - Run migration locally: `docker exec cbtextapp-backend-1 python -m app.migrations.migration_manager --run`
      - Test the fix thoroughly in local environment
      - Verify migration doesn't break existing functionality
      - Ask user: "Local migration tested successfully. Confirmed safe to deploy?"
    - **For code-only changes:** Standard local testing recommended but not mandatory

13. **🚀 Interactive Deploy and Verify:**
    - **VERSION MANAGEMENT:**
      - **Database changes:** Increment VERSION file and use new version for tag
      - **Code-only changes:** Use CURRENT VERSION (no increment)
    - Local testing: "Let me test this fix locally first... ✅ Local test passed!"
    - Ask user: "Local test successful. Ready to deploy to production?"
    - Deploy with progress updates: "⏳ Deploying fix version X.Y.Z..."
    - Monitor deployment: "📡 Monitoring logs during deployment..."
    - Verification test: "🧪 Testing fix with original reproduction steps..."
    - Success confirmation: "✅ Fix verified! Issue resolved."
    - Ask user: "Fix successful! Should I clean up the debug logging now?"

**Phase 6: Interactive Cleanup & Documentation**
13. **🧹 Interactive Debug Cleanup:**
    - Show current debug logging: "Here's the debug logging I added earlier..."
    - Ask user: "Should I remove all debug logging or keep some for future monitoring?"
    - If cleanup requested: Remove debug logging with progress updates
    - Show cleaned code: "Debug logging removed. Here's the clean version..."
    - Ask user: "Cleanup complete. Deploy clean version now?"

14. **📚 Interactive Documentation:**
    - Present issue summary: "Here's what we found and fixed..."
    - Show documentation draft: "I'll document this for future reference..."
    - Ask user: "Does this documentation capture everything important?"
    - Create/update troubleshooting docs
    - Ask user: "Documentation complete. Anything else to add about preventive measures?"

**🎉 DEBUG SESSION SUMMARY**
- **Issue:** [Original problem description]
- **Root Cause:** [What we discovered]
- **Fix Applied:** [Solution implemented]
- **Time to Resolution:** [Duration]
- **Lessons Learned:** [Key insights]

**💬 Interactive Prompts Throughout:**
- "What do you see happening on your end?"
- "Does this match what you expected?"
- "Should we investigate this path further?"
- "Are you ready for the next step?"
- "How does this fix look to you?"
- "Any concerns before we deploy?"

**Common Debug Patterns:**
- **API 500 Errors:** Focus on request data validation and database operations
- **Authentication Issues:** Check JWT tokens, user permissions, and session state  
- **Database Errors:** Verify data consistency, indexes, and connection health
- **Performance Issues:** Monitor request timing and resource usage
- **Frontend Errors:** Check API responses and browser console logs

**🚫 IMPORTANT: STOP SAYING "TASKS ARE RUNNING" WITHOUT VERIFICATION**
- **NEVER assume tasks are healthy just because ECS shows "desired count"**
- **ALWAYS check task status: RUNNING vs STOPPED vs PENDING vs PROVISIONING**
- **ALWAYS get stop reasons for failed tasks before diagnosing issues**
- **Common misleading scenarios:**
  - "Service has 3 tasks" - but all 3 are STOPPED and restarting in loop
  - "Deployment successful" - but new tasks fail health checks immediately
  - "Containers are running" - but exiting after 30 seconds due to code errors
- **Required verification steps:**
  1. Check actual task status: `aws ecs describe-tasks`
  2. Get stop reasons for failed tasks: check `stopCode` and `stoppedReason`
  3. Verify health check status: confirm tasks pass load balancer health checks
  4. Check recent logs: confirm no startup errors or crashes

**🚫 IMPORTANT: IT'S NEVER CORS**
- **CORS is NOT the issue** - Our production environment has proper CORS configuration
- **Don't waste time on CORS debugging** - Focus on actual application logic errors
- **If someone suggests CORS:** Politely redirect to real debugging (authentication, data validation, database issues)
- **CORS works fine** - The 500 errors are always application code issues, not browser/CORS problems

**Emergency Procedures:**
- **Rollback:** Use previous deployment tag to quickly revert
- **Hotfix:** Use `hotfix-v*` tag pattern for urgent fixes
- **Service Restart:** Contact DevOps for container restart if needed

**Usage Examples:**
- `/debug-production "content-terms POST endpoint returning 500 error"`
- `/debug-production "user authentication failing on login"`
- `/debug-production "payment processing timeout issues"`
- `/debug-production "dashboard loading slowly for all users"`

**Required Tools:**
- AWS CLI configured with appropriate permissions
- Docker access for local database queries
- Git access for code changes and deployments
- Access to production application for testing