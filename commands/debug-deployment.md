Debug Deployment Failure: $ARGUMENTS

**Issue Description:** $ARGUMENTS (describe deployment issues - new version not starting, tasks failing, etc.)
**Action:** Interactive deployment failure analysis with version tracking and task failure diagnosis

**🚨 CRITICAL DEPLOYMENT REALITY CHECK**
**The Reality:** Health checks and load balancers are PROTECTING YOU from broken deployments
- ✅ **Health checks working** = They detect when new code has problems and prevent it from going live
- ❌ **New deployment failed** = Your new code has bugs that prevent proper startup
- 🔄 **Load balancer failover** = Keeps old working version running while new version fails
- 🛡️ **This is the system working correctly** = Bad code doesn't reach users

**🎯 PRIMARY OBJECTIVE: Find what's wrong with your new code so you can fix it and deploy successfully**

**Phase 0: GitHub Actions Deployment Check**
1. **🔍 GitHub Actions Status (Without gh CLI):**
   ```bash
   # Check recent tags pushed
   git log --oneline --decorate --graph -10 | grep tag:
   
   # Get last deployment tag details
   LAST_TAG=$(git describe --tags --abbrev=0)
   echo "Last deployed tag: $LAST_TAG"
   git show $LAST_TAG --stat
   
   # Compare with remote
   git ls-remote --tags origin | tail -5
   ```
   
   **Manual GitHub Actions Check:**
   - Open: https://github.com/[your-repo]/actions
   - Look for workflow run matching your tag
   - Check for:
     - ❌ Red X = Build/push failed
     - ⏳ Yellow circle = Still running
     - ✅ Green check = Successfully pushed to ECR
   
   **If GitHub Actions Failed:**
   - Build errors = Fix code/Dockerfile
   - ECR push failed = Check AWS credentials
   - Task definition error = Check JSON files

**Phase 1: Deployment Version Reality Check**
1. **📋 Current Deployment Status Analysis:**
   ```bash
   # Get the full deployment picture
   aws ecs describe-services --cluster cb-app-cluster --services cb-app-service --query 'services[0].{
     CurrentTaskDef:taskDefinition,
     DesiredCount:desiredCount,
     RunningCount:runningCount,
     PendingCount:pendingCount,
     Deployments:deployments[*].{
       Status:status,
       TaskDefinition:taskDefinition,
       CreatedAt:createdAt,
       UpdatedAt:updatedAt,
       RunningCount:runningCount,
       PendingCount:pendingCount,
       FailedTasks:failedTasks
     }
   }'
   ```
   
   **Critical Status Interpretation:**
   - **PendingCount > 0** = New deployment is trying to start
   - **Multiple deployments** = New version has code problems, health checks protecting you  
   - **FailedTasks > 0** = New version has bugs preventing proper startup
   - **PRIMARY vs ACTIVE deployments** = Health system keeping good version live

   - Show clear status: "🛡️ HEALTH SYSTEM WORKING: [NEW_VERSION] has code problems, health checks correctly preventing deployment. [OLD_VERSION] still serving traffic safely."
   - Ask user: "Health system protected you from [FAILURE_COUNT] broken deployments. Ready to debug the code issues in [NEW_VERSION]?"

2. **🔍 Task Version Comparison:**
   ```bash
   # Get all current tasks and their versions
   aws ecs list-tasks --cluster cb-app-cluster --service-name cb-app-service
   
   # Detailed task analysis with versions
   aws ecs describe-tasks --cluster cb-app-cluster --tasks $(aws ecs list-tasks --cluster cb-app-cluster --service-name cb-app-service --query 'taskArns[]' --output text) --query 'tasks[*].{
     TaskId:taskArn,
     TaskDefRevision:taskDefinitionArn,
     Status:lastStatus,
     DesiredStatus:desiredStatus,
     CreatedAt:createdAt,
     StartedAt:startedAt,
     StoppedAt:stoppedAt,
     StopCode:stopCode,
     StoppedReason:stoppedReason,
     HealthStatus:healthStatus
   }'
   ```
   
   **Version Reality Check:**
   - Identify which task definition revision should be running (latest)
   - Identify which task definition revision is actually running (often older)
   - Show timeline: "New version [REVISION] created [TIME] ago, but [OLD_REVISION] still handling traffic"
   - Ask user: "Version analysis: [NEW_VERSION] has been failing for [DURATION]. Ready to investigate the failure cause?"

**Phase 2: Deployment Failure Root Cause Analysis**
3. **🚨 Failed Task Investigation:**
   ```bash
   # Get failed/stopped tasks from recent deployment attempts
   aws ecs list-tasks --cluster cb-app-cluster --service-name cb-app-service --desired-status STOPPED --max-results 10
   
   # Get detailed failure reasons for recent failed tasks
   aws ecs describe-tasks --cluster cb-app-cluster --tasks $(aws ecs list-tasks --cluster cb-app-cluster --service-name cb-app-service --desired-status STOPPED --max-results 5 --query 'taskArns[]' --output text) --query 'tasks[*].{
     TaskArn:taskArn,
     TaskDefinition:taskDefinitionArn,
     StopCode:stopCode,
     StoppedReason:stoppedReason,
     ExitCode:containers[0].exitCode,
     ContainerReason:containers[0].reason,
     LastStatus:lastStatus,
     CreatedAt:createdAt,
     StartedAt:startedAt,
     StoppedAt:stoppedAt
   }'
   ```
   
   **Code Problem Classification:**
   - **Task failed ELB health checks** = Code has bugs preventing `/api/health` from responding (MOST COMMON)
   - **Essential container exited** = Code has syntax errors, import errors, or crashes during startup  
   - **TaskFailedToStart** = Container image or environment issues
   - **CannotPullContainerError** = Docker image not found or permissions
   - **OutOfMemory** = Code uses more resources than allocated
   
   - Display clear diagnosis: "🔍 CODE PROBLEM: [FAILURE_PATTERN] - Your new code has [SPECIFIC_ERROR] preventing proper startup"
   - Ask user: "Code analysis complete. [NEW_VERSION] has [SPECIFIC_PROBLEM]. Ready to examine the startup logs to fix the code?"

4. **📋 Startup Log Analysis for Failed Tasks:**
   ```bash
   # Get the most recent failed task logs
   FAILED_TASK=$(aws ecs list-tasks --cluster cb-app-cluster --service-name cb-app-service --desired-status STOPPED --max-results 1 --query 'taskArns[0]' --output text | cut -d'/' -f3)
   
   # Get startup logs from failed task
   aws logs get-log-events --log-group-name "/ecs/cb-app" --log-stream-name "ecs/cb-app/$FAILED_TASK" --limit 100
   
   # Search for common startup failures
   aws logs filter-log-events --log-group-name "/ecs/cb-app" --start-time $(python3 -c "import time; print(int((time.time() - 3600) * 1000))") --filter-pattern "ModuleNotFoundError|ImportError|TypeError|CRITICAL|FATAL|container exit"
   ```
   
   **Code Bug Patterns:**
   - **Import/Module errors** = Syntax errors, missing dependencies, wrong imports
   - **TypeError/AttributeError** = Code logic errors, variable issues
   - **Database connection failures** = Code trying to access wrong database or missing config  
   - **Port binding errors** = Code configuration problems
   - **Uncaught exceptions** = Code crashes during startup preventing health endpoint from working
   
   - Show specific error: "🐛 CODE BUG FOUND: [SPECIFIC_ERROR] in your new code preventing proper startup"
   - Ask user: "Found the bug! [SPECIFIC_ISSUE] in [NEW_VERSION]. Ready to fix this code problem?"

**Phase 3: Deployment Timeline and Impact Analysis**
5. **⏰ Deployment Timeline Analysis:**
   ```bash
   # Get deployment history and timing
   aws ecs describe-services --cluster cb-app-cluster --services cb-app-service --query 'services[0].deployments[*].{
     Status:status,
     TaskDefinition:taskDefinition,
     CreatedAt:createdAt,
     UpdatedAt:updatedAt,
     RunningCount:runningCount,
     PendingCount:pendingCount,
     FailedTasks:failedTasks
   }' --output table
   
   # Check current git tag vs running version
   echo "Git tag deployed: $(git describe --tags --abbrev=0)"
   echo "Task definition running: $(aws ecs describe-services --cluster cb-app-cluster --services cb-app-service --query 'services[0].taskDefinition' --output text | cut -d':' -f6)"
   ```
   
   **Timeline Questions to Answer:**
   - How long has the new deployment been failing?
   - What version did we think we deployed vs what's actually running?
   - Is the failure consistent or intermittent?
   - Are there any successful tasks from the new version?
   
   - Present timeline: "📅 DEPLOYMENT TIMELINE: [NEW_VERSION] attempted [TIME] ago, failed [COUNT] times, [OLD_VERSION] still serving traffic"
   - Ask user: "Timeline shows [DURATION] of deployment failures. Should we implement the fix or rollback to known working version?"

**Phase 4: Fix Implementation Strategy**
6. **🔧 Deployment Fix Categories:**

   **A. Code/Dependency Issues (Most Common):**
   - Import errors, missing packages, syntax errors
   - Fix: Code changes, requirements.txt updates, Dockerfile fixes
   
   **B. Configuration Issues:**
   - Environment variables, secrets, database connections
   - Fix: ECS task definition updates, parameter store changes
   
   **C. Resource Issues:**
   - Memory limits, CPU constraints, disk space
   - Fix: ECS task definition resource adjustments
   
   **D. Infrastructure Issues:**
   - Container registry problems, network issues, IAM permissions
   - Fix: Infrastructure configuration changes
   
   - Categorize issue: "🎯 ISSUE CATEGORY: [CATEGORY] - requires [FIX_TYPE]"
   - Ask user: "Based on [SPECIFIC_ERROR], this is a [CATEGORY] issue. Should I implement [SPECIFIC_FIX]?"

7. **🚀 Fix Implementation and Verification:**
   - Present specific fix for identified issue
   - Show code/configuration changes needed
   - Ask user: "Fix ready: [SPECIFIC_CHANGES]. Approve implementation?"
   - Implement fix with progress updates
   - Deploy new version and monitor task startup
   - Verify new tasks reach RUNNING status
   - Confirm new version is actually serving traffic
   - Ask user: "Fix deployed. New version [REVISION] is now running successfully. Should we clean up failed task logs?"

**Phase 5: Deployment Success Verification**
8. **✅ Deployment Reality Verification:**
   ```bash
   # Verify the fix actually worked
   aws ecs describe-services --cluster cb-app-cluster --services cb-app-service --query 'services[0].{
     RunningCount:runningCount,
     PendingCount:pendingCount,
     ActiveDeployment:deployments[?status==`PRIMARY`].{
       Status:status,
       TaskDefinition:taskDefinition,
       RunningCount:runningCount,
       FailedTasks:failedTasks
     }
   }'
   
   # Confirm new tasks are actually running (not just pending)
   aws ecs describe-tasks --cluster cb-app-cluster --tasks $(aws ecs list-tasks --cluster cb-app-cluster --service-name cb-app-service --query 'taskArns[]' --output text) --query 'tasks[*].{TaskDef:taskDefinitionArn,Status:lastStatus,Health:healthStatus}'
   ```
   
   **Success Criteria:**
   - ✅ **PendingCount: 0** = No tasks stuck starting
   - ✅ **FailedTasks: 0** = No recent task failures  
   - ✅ **All tasks RUNNING** = New version successfully started
   - ✅ **Single PRIMARY deployment** = No old version fallback
   
   - Confirm success: "✅ DEPLOYMENT SUCCESS: [NEW_VERSION] running successfully, [OLD_VERSION] retired"
   - Ask user: "Deployment verified successful. Should I document this failure pattern for future prevention?"

**✅ CRITICAL: UNDERSTAND WHAT SIGNALS MEAN**
- **Health checks "failing"** = Your new code has bugs, system protecting you
- **Application "working"** = Old good version still serving traffic safely  
- **ECS service "healthy"** = Health system working correctly, keeping bad code from users
- **Trust:** Task definition versions, task status, startup logs to find your code bugs

**Common Deployment Failure Patterns & Specific Fixes:**

1. **ModuleNotFoundError: No module named 'app.dependencies.auth'**
   - **Cause:** Import path changed in code
   - **Fix:** Update imports to correct path (e.g., `from ..utils.security import`)
   - **Deploy:** Fix locally, commit, tag, push

2. **Task failed ELB health checks**
   - **Cause:** `/api/health` endpoint not responding within timeout
   - **Common Issues:**
     - Database connection hanging
     - Import errors preventing app startup
     - Port mismatch (app on wrong port)
   - **Fix:** Check startup logs for specific error, fix code issue

3. **pymongo.errors.ServerSelectionTimeoutError**
   - **Cause:** Can't connect to MongoDB
   - **Fix:** Check MONGODB_URI in task definition, verify network/security groups
   - **Quick Fix:** Restart tasks to retry connection

4. **AttributeError: 'NoneType' object has no attribute 'X'**
   - **Cause:** Code expecting data that doesn't exist
   - **Fix:** Add null checks, initialize variables properly
   - **Example:** `if user and user.role:` instead of `if user.role:`

5. **SIGTERM (Essential container exited)**
   - **Cause:** App crashed during startup
   - **Common Issues:**
     - Syntax errors in Python files
     - Missing required environment variables
     - Database migration needed but not run
   - **Fix:** Check CloudWatch logs for stack trace

6. **CannotPullContainerError: Error response from daemon**
   - **Cause:** Docker image not in ECR
   - **Fix:** Check GitHub Actions build succeeded, manually push if needed:
     ```bash
     docker build -t [ecr-uri]:latest backend/
     docker push [ecr-uri]:latest
     ```

7. **ResourceInitializationError: unable to pull secrets or registry auth**
   - **Cause:** IAM permissions issue
   - **Fix:** Check ECS task execution role has ECR and Secrets Manager access

8. **OutOfMemoryError: Container killed due to memory usage**
   - **Cause:** App using more RAM than allocated
   - **Fix:** Increase memory in task definition:
     ```json
     "memory": "1024",  // Increase from 512
     "memoryReservation": "512"
     ```

**Automated Debugging Script:**
Create this as `/tmp/debug-deployment.sh` for quick diagnosis:
```bash
#!/bin/bash
echo "🔍 ECS Deployment Debugger"
echo "=========================="

# Get current deployment status
echo -e "\n📊 Deployment Status:"
aws ecs describe-services --cluster cb-app-cluster --services cb-app-service \
  --query 'services[0].{Status:status,Running:runningCount,Pending:pendingCount,Desired:desiredCount}' \
  --output table

# Check for multiple deployments (sign of failure)
DEPLOYMENT_COUNT=$(aws ecs describe-services --cluster cb-app-cluster --services cb-app-service \
  --query 'length(services[0].deployments)' --output text)

if [ "$DEPLOYMENT_COUNT" -gt "1" ]; then
    echo -e "\n⚠️  WARNING: Multiple deployments detected - new version failing!"
    aws ecs describe-services --cluster cb-app-cluster --services cb-app-service \
      --query 'services[0].deployments[*].{Status:status,TaskDef:taskDefinition,Running:runningCount}' \
      --output table
fi

# Get recent failed tasks
echo -e "\n❌ Recent Failed Tasks:"
aws ecs list-tasks --cluster cb-app-cluster --service-name cb-app-service \
  --desired-status STOPPED --max-results 3 --query 'taskArns[]' --output text | \
  xargs -I {} aws ecs describe-tasks --cluster cb-app-cluster --tasks {} \
  --query 'tasks[0].{StopCode:stopCode,StoppedReason:stoppedReason}' --output text

# Get last error logs
echo -e "\n📋 Last Error Logs:"
FAILED_TASK=$(aws ecs list-tasks --cluster cb-app-cluster --service-name cb-app-service \
  --desired-status STOPPED --max-results 1 --query 'taskArns[0]' --output text | cut -d'/' -f3)

if [ ! -z "$FAILED_TASK" ]; then
    aws logs get-log-events --log-group-name "/ecs/cb-app" \
      --log-stream-name "ecs/cb-app/$FAILED_TASK" \
      --limit 20 --query 'events[*].message' --output text | grep -E "ERROR|CRITICAL|Exception|Error:|Failed"
fi

echo -e "\n✅ Recommended Actions:"
echo "1. If multiple deployments: Health checks are protecting you from bad code"
echo "2. Check error logs above for specific code issues"
echo "3. Fix code locally, test, then redeploy"
echo "4. Or rollback: git tag app-v[PREVIOUS]-rollback && git push origin app-v[PREVIOUS]-rollback"
```

Run with: `bash /tmp/debug-deployment.sh`

**Emergency Procedures:**
- **Quick Rollback:** Deploy previous working git tag immediately
- **Force Service Update:** Restart service with known working task definition
- **Rollback Command:** `git tag app-v[PREVIOUS-VERSION]-rollback && git push origin app-v[PREVIOUS-VERSION]-rollback`

**Usage Examples:**
- `/debug-deployment "New version deployed 2 hours ago but still getting old API responses"`
- `/debug-deployment "ECS shows healthy but I know my code changes aren't live"`  
- `/debug-deployment "Deployment says successful but tasks keep failing"`
- `/debug-deployment "Load balancer healthy but new features not working"`

**Quick Deployment Verification Checklist:**
```bash
# 1. Check deployment status
aws ecs describe-services --cluster cb-app-cluster --services cb-app-service \
  --query 'services[0].deployments | length(@)' --output text
# Expected: 1 (single deployment = success)

# 2. Verify running task count
aws ecs describe-services --cluster cb-app-cluster --services cb-app-service \
  --query 'services[0].{Running:runningCount,Desired:desiredCount}' --output text
# Expected: Same numbers (e.g., 2 2)

# 3. Check task definition version
aws ecs describe-services --cluster cb-app-cluster --services cb-app-service \
  --query 'services[0].taskDefinition' --output text | cut -d':' -f7
# Expected: Matches your deployment version

# 4. Test health endpoint
curl -s -o /dev/null -w "%{http_code}" https://app.contentbasis.io/api/health
# Expected: 200

# 5. Verify new feature/fix
curl https://app.contentbasis.io/api/current_version
# Expected: Your new version number
```

**Success Metrics:**
- **Time to Identify:** How quickly we determine real deployment status
- **Time to Root Cause:** How quickly we find why new version is failing
- **Time to Resolution:** How quickly we get new version actually running
- **Deployment Confidence:** Certainty that new code is actually live