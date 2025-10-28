# /claude-debug

**Purpose**: Launch structured debug session with regression tracking to prevent circular debugging.

**Usage**: `/claude-debug <project> [issue-description]`

**Arguments**:
- `<project>` (required): Project to debug - any Git repository in your workspace (per `.claude/local/workspace.env` configuration)
- `[issue-description]` (optional): Brief description of the issue being debugged

**AUTOMATIC ATTEMPT NUMBERING**: Command automatically detects next attempt number - you don't track it manually.

## Command Behavior

When executed, Claude will:

1. **Clean task directory** - Check for scattered debug files and consolidate them
2. **Find or create debug log** `[branch-name]-debug.log` in current task folder
3. **Automatically determine next attempt number** by reading existing attempts
4. **Add new attempt to summary section** and detailed log
5. **No manual tracking required** - system handles attempt numbering
6. **Maintain ONE organized debug file** - no scattered files allowed

## Implementation Instructions for Claude

### ON COMMAND EXECUTION:

#### Step 1: Clean Directory and Determine Debug Log File Location

**FIRST: Check for scattered debug files in task directory**
```bash
# Look for scattered debug files that should be consolidated
find [project]/todo/current/[category]/[task-name]/ -maxdepth 1 -name "*debug*" -o -name "*test*" -o -name "*attempt*" -o -name "*log*" -o -name "*analysis*" -o -name "*failure*" | grep -v ".log$"
```

**If scattered files found:**
1. **List all files found**: Show user what scattered files exist
2. **Ask for consolidation**: "Found X scattered debug files. Consolidate into main debug log? [Y/n]"
3. **If Yes**: Read each file, extract relevant information, add to debug log with timestamps
4. **Move to archive**: Move consolidated files to `archive/` subdirectory
5. **Report cleanup**: "Consolidated X files into debug log, moved to archive/"

**THEN: Set debug log location**
```bash
# Get current branch name
BRANCH=$(git branch --show-current)
# Convert to safe filename: feature/my-branch → feature-my-branch
SAFE_BRANCH=$(echo $BRANCH | sed 's/\//-/g')
# Debug LOG file location - THE ONLY debug file that should exist
DEBUG_FILE="[project]/todo/current/[category]/[task-name]/${SAFE_BRANCH}-debug.log"
```

**CRITICAL RULES:**
- ✅ **ONE debug log file ONLY** per task/branch
- ❌ **NO scattered debug files** in task directory
- ✅ **Archive folder** for consolidated old files
- ✅ **Clean directory** maintained automatically

#### Step 2: Create or Update Debug Log

**If debug log file EXISTS:**
- Load existing `[branch-name]-debug.log`
- **AUTOMATICALLY find the highest attempt number** in the SUMMARY section
- **AUTOMATICALLY increment by 1** for the new attempt
- Example: If log shows attempts #1-#26, new attempt = #27
- Add to both summary header AND detailed log sections

**If debug log file DOES NOT EXIST:**
- Create new `[branch-name]-debug.log` with this EXACT structure:

```
##############################################################################
# TEST ATTEMPT LOG - [FEATURE/ISSUE NAME]
##############################################################################
# INSTRUCTIONS FOR USE:
# - Each test attempt = one attempt number
# - Format: Attempt #X | Date Time | What tested | Result | What was tried/learned
# - Add new attempts to BOTH summary and detailed log below
# - "FAILED" = didn't work, "SUCCESS" = worked as expected, "PENDING" = ready to test
##############################################################################
# SUMMARY OF ATTEMPTS:
# Attempt #1  | YYYY-MM-DD HH:MM | [what tested] | PENDING | [description of what will be tried]
##############################################################################
# DETAILED LOG ENTRIES:
##############################################################################
```

**CRITICAL REQUIREMENTS:**
1. **ALWAYS update BOTH the summary header AND add detailed entry**
2. **Use sequential attempt numbers** (don't skip numbers)
3. **Include timestamp, what was tested, result, and learning**
4. **Keep summary lines short** (one line per attempt)
5. **Add detailed entries below** with full debugging information

#### Step 3: MANDATORY Pre-Debug Checks

**BEFORE ANY DEBUGGING:**
```markdown
## 🔍 PRE-DEBUG VERIFICATION CHECKLIST

### A. What Was Working Before?
- [ ] List features that were confirmed working
- [ ] Note last known good state/commit
- [ ] Document any recent changes

### B. Current State Check
- [ ] Run smoke tests to establish baseline
- [ ] Verify containers are running
- [ ] Check if issue reproduces consistently

### C. Regression Check
- [ ] Review Section 13.C (Regression Log) for similar issues
- [ ] Check if this was previously fixed
- [ ] Note if this is a regression
```

#### Step 4: Structured Experiment Tracking

**For EVERY test/experiment:**
```markdown
| ID    | Time  | Hypothesis | Action/Change | Env | Result | Evidence | Next Step |
|-------|-------|------------|---------------|-----|--------|----------|-----------|
| E-XXX | HH:MM | [What you think is wrong] | [Exact commands run] | dev | ✅/❌ | [Actual output] | [What to try next] |
```

**CRITICAL RULES:**
- Never repeat an experiment ID
- Always show actual command output
- Mark results as ✅ (worked) or ❌ (failed)
- Include error messages verbatim

#### Step 5: Anti-Circle Pattern

**After EVERY 3 experiments:**
```markdown
## ⚠️ CIRCLE CHECK

**Have we tested this before?** [Check experiment log]
**Are we making progress?** [Compare to initial hypothesis]
**Should we pivot?** [Consider different approach]

If circling detected:
1. STOP current approach
2. Review all experiments
3. Form NEW hypothesis not yet tested
4. Consider asking user for guidance
```

#### Step 6: Regression Tracking

**When issue is FIXED:**
```markdown
## ✅ RESOLUTION LOG

**Root Cause**: [Specific technical cause]
**Fix Applied**: [Exact changes made]
**Verification**: [How we confirmed it works]
**Regression Risk**: [What could break this again]

Add to Section 13.C Regression Log:
| Date | Area | Issue | Fix | Test Added |
```

### COMMAND OUTPUT FORMAT:

```markdown
🔍 DEBUG LOG: [Created/Updated]
📁 Log File: [project]/todo/current/.../[branch-name]-debug.log
🎯 Current Attempt: #X
📊 Previous Attempts: [FAILED/SUCCESS count]
🔄 Last Result: [Brief status]

## Attempt #X Ready
**Testing**: [what will be tested]
**Hypothesis**: [what we think will happen]
**Expected Result**: [SUCCESS/FAILED and why]

## Summary Added To Log:
Attempt #X | YYYY-MM-DD HH:MM | [test case] | PENDING | [description]

Ready to execute attempt? [Y/n/modify]
```

### SPECIAL FLAGS:

- `/claude-debug --continue`: Resume existing session
- `/claude-debug --status`: Show current debug status only
- `/claude-debug --experiments`: List all experiments with results
- `/claude-debug --regression`: Check if this is a known regression
- `/claude-debug --close`: Finalize session with resolution

### INTEGRATION WITH OTHER COMMANDS:

- Automatically called by `/claude-start` if debug session exists
- Links to `/claude-violation-log` for process violations
- Updates `/zsolutely.md` principles during debugging

### EXAMPLE SESSION:

```bash
User: /claude-debug User can't login after email verification

Claude:
🔍 DEBUG LOG: Updated
📁 Log File: [project]/todo/current/feature/existing-user-team-addition/feature-existing-user-team-addition-debug.log
🎯 Current Attempt: #28 (automatically detected)
📊 Previous Attempts: 26 FAILED, 1 SUCCESS
🔄 Last Result: Attempt #27 PENDING - Root cause fix deployed

## Attempt #28 Ready
**Testing**: Login attempt for newuser_1757699240 after email verification
**Hypothesis**: Email verification not updating user login capability
**Expected Result**: SUCCESS - user should be able to login after verification

## Summary Added To Log:
Attempt #28 | 2025-09-14 16:15 | newuser_1757699240 login | PENDING | Test login after email verification fix

Ready to execute attempt #28? [Y/n/modify]
```

**Key Features Shown:**
- ✅ **Automatic attempt numbering** (found #27 in log, created #28)
- ✅ **No manual tracking** required from user
- ✅ **Previous attempts counted** automatically
- ✅ **Clear next attempt prepared** with summary added to log

### SUCCESS CRITERIA:

1. **No repeated experiments** - Each test has unique ID
2. **Clear progression** - Can see what led to solution
3. **Regression prevention** - Issues don't resurface
4. **Time efficiency** - Avoid circular debugging
5. **Knowledge preservation** - Debug learnings persist

### FAILURE PATTERNS TO PREVENT:

❌ Testing the same thing multiple times
❌ Not recording actual outputs
❌ Assuming without verifying
❌ Losing track of what was tested
❌ Forgetting previous fixes

✅ Structured, trackable experiments
✅ Evidence-based conclusions
✅ Clear progression toward solution
✅ Preserved debugging knowledge
✅ Regression awareness

This command ensures debugging sessions are efficient, trackable, and never repeat the same mistakes.