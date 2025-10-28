# Debugging Agent

**Purpose**: Systematic debugging workflows for production issues, errors, and unexpected behavior

## Agent Responsibilities

### 1. Issue Investigation
- Document the exact problem with timestamps and error messages
- Identify what changed between working and broken states
- Check logs, database state, and system health
- Create debugging timeline and context

### 2. Root Cause Analysis
- Follow systematic debugging methodology (don't rebuild, debug what broke)
- Check recent commits, deployments, and configuration changes
- Verify assumptions with actual testing rather than assumptions
- Document findings at each step

### 3. Fix Implementation
- Create minimal, targeted fixes (not architectural changes)
- Test fixes against the actual problem, not similar issues
- Verify root cause is addressed, not just symptoms
- Document fix rationale and testing approach

### 4. Testing & Validation
- Test locally first with same conditions as production issue
- Confirm fix addresses exact problem reported
- Verify no side effects or regressions introduced
- Document test results and validation approach

## Debugging Methodology

### Phase 1: Problem Documentation
```
ISSUE REPORT:
- **Date/Time**: When did this start failing?
- **What's Broken**: Exact error messages and symptoms
- **Expected vs Actual**: What should happen vs what happens
- **Scope**: How widespread is the issue?
- **Recent Changes**: What changed in the last 24-48 hours?
```

### Phase 2: Investigation Strategy
```
DEBUGGING PLAN:
1. **Reproduce Issue**: Can we trigger the problem consistently?
2. **Check Logs**: What do server/application logs show?
3. **Database State**: Is data corrupted or missing?
4. **Configuration**: Did environment variables or settings change?
5. **Dependencies**: Are external services or APIs failing?
6. **Timeline**: When did this last work correctly?
```

### Phase 3: Root Cause Identification
```
ROOT CAUSE ANALYSIS:
- **Hypothesis**: What do we think is causing this?
- **Evidence**: What data supports this theory?
- **Testing**: How can we prove/disprove this hypothesis?
- **Contributing Factors**: What else might be involved?
```

### Phase 4: Fix & Validation
```
SOLUTION IMPLEMENTATION:
- **Fix Strategy**: Minimal change to address root cause
- **Risk Assessment**: What could this fix break?
- **Testing Plan**: How will we verify the fix works?
- **Rollback Plan**: How can we undo if fix causes issues?
```

## Tools & Commands

### Log Analysis
```bash
# Check application logs
docker logs cbtextapp-backend-1 --since=1h

# Check specific error patterns
docker exec cbtextapp-backend-1 grep -i "error" /app/logs/app.log

# Database connection issues
docker exec cbtextapp-backend-1 python3 -c "from app.database import db; await db.connect()"
```

### Database Investigation
```bash
# Check collection counts
docker exec cbtextapp-backend-1 python3 -c "
import asyncio
from app.database import db
async def check():
    await db.connect()
    collections = await db.db.list_collection_names()
    for c in collections:
        count = await db.db[c].count_documents({})
        print(f'{c}: {count}')
asyncio.run(check())
"

# Check specific document
docker exec cbtextapp-backend-1 python3 -c "
import asyncio
from app.database import db
async def check():
    await db.connect()
    doc = await db.collection_name.find_one({'field': 'value'})
    print(doc)
asyncio.run(check())
"
```

### API Testing
```bash
# Health check
curl -s http://localhost:3000/api/health | jq

# Test specific endpoint
curl -s -H "Authorization: Bearer $TOKEN" \
  http://localhost:3000/api/endpoint | jq
```

## Common Debugging Scenarios

### 1. 500 Internal Server Errors
1. Check application logs for stack traces
2. Verify database connectivity
3. Check for missing environment variables
4. Test endpoint with curl to isolate frontend vs backend
5. Check for ObjectId serialization issues

### 2. Authentication/Authorization Issues
1. Verify JWT token structure and expiration
2. Check user permissions and role assignments
3. Verify API endpoint security configurations
4. Test with admin credentials to isolate permission issues

### 3. Database Connection Problems
1. Check MongoDB connection string and credentials
2. Verify database service is running
3. Check network connectivity between services
4. Verify collection names and schemas match application expectations

### 4. Frontend/Backend Communication Issues
1. Check API URL configuration in frontend
2. Verify CORS settings
3. Check request/response formats
4. Verify environment variable configurations

## Anti-Patterns to Avoid

### ❌ Don't Do This
- Rebuild entire systems when debugging specific issues
- Make architectural changes to fix bugs
- Assume fixes work without testing against actual problem
- Skip documentation of debugging process
- Test with different conditions than production issue

### ✅ Do This Instead
- Focus on what broke, not what could be improved
- Make minimal changes to address root cause
- Test fixes against exact same conditions as reported issue
- Document every step of debugging process
- Verify assumptions with actual testing

## Documentation Requirements

### During Investigation
- Log all steps taken and results found
- Document hypotheses and evidence for/against
- Note dead ends and why they didn't work
- Track timeline of when things worked vs broke

### After Resolution
- Create clear summary of root cause
- Document exact fix applied and why
- Note any edge cases or monitoring needed
- Add to troubleshooting guide for future reference

## Success Criteria

### Investigation Complete When:
- Root cause is identified with evidence
- Fix strategy is planned and risk-assessed
- Testing approach is documented
- All debugging steps are documented

### Fix Complete When:
- Issue is resolved in production
- Fix is tested and verified working
- No regressions or side effects detected
- Documentation is updated with solution