# /log-debug - Debug Attempt Logging

Log a debug attempt in the current task's debug log file.

## Usage
```
/log-debug [description] [result]
/log-debug --fail [description]
```

**Auto-Numbering**: The command automatically finds the last attempt number in the debug log and increments by 1. No need to track attempt numbers manually!

## Flags

### `--fail`
**Purpose**: Automatically sets result to FAILED and prompts for detailed failure analysis.

**Behavior**:
- Sets result to FAILED automatically
- Auto-calculates next attempt number from debug log
- Emphasizes failure analysis questions
- Requires detailed explanation of what specifically failed
- Prompts for error messages, stack traces, unexpected behavior
- Focuses on lessons learned from the failure

**Usage**: `/log-debug --fail "User invitation test"`

## What This Command Does

**MANDATORY**: When debugging any issue, you MUST log every single attempt in the appropriate debug log file with proper formatting.

**Location**: Current task's debug log file (typically in `/todo/current/[category]/[task-name]/`)

**Auto-Numbering Process**:
1. **Scan debug log** for highest attempt number (e.g., finds "Attempt #41")
2. **Increment by 1** (next attempt becomes #42)
3. **Add entry** with auto-calculated number

**Format Required**:
```
# Attempt #X | YYYY-MM-DD HH:MM | description | RESULT | Brief summary
```

**Then add detailed entry**:
```
##############################################################################
# X. YYYY-MM-DD HH:MM - ATTEMPT #X: Detailed Description
# - WHAT WAS TRIED: Specific action taken
# - RESULT: What happened (SUCCESS/FAILED/PARTIAL)
# - OBSERVATIONS: What was observed in logs/database/behavior
# - WHAT DIDN'T WORK: Specific failures, errors, unexpected behavior
# - WHAT WILL WE DO NEXT: Next planned approach/test
# - HOW IS THIS DIFFERENT: How this differs from previous attempts
# - ASSUMPTIONS MADE: What did we assume would work?
# - ENVIRONMENT FACTORS: What was different about the test environment?
# - DATA STATE: What was the state of relevant data before/after?
# - DEPENDENCIES: What other systems/components were involved?
# - TIMING FACTORS: Did timing/sequence matter?
# - ERROR PATTERNS: Does this match any previous error patterns?
# - CRITICAL ISSUE: Root cause if identified
# - LESSONS LEARNED: Key insights or patterns discovered
# - STATUS: Current status with emoji (🔴/🟡/🟢)
##############################################################################
```

## Examples

**Summary Line** (auto-numbered):
```
# Attempt #15 | 2025-09-14 18:15 | API endpoint test | FAILED | 500 error returned
```

**Detailed Entry**:
```
##############################################################################
# 5. 2025-09-14 18:15 - ATTEMPT #15: API Endpoint Debug Test
# - WHAT WAS TRIED: Added logging to endpoint, tested with curl
# - RESULT: FAILED - 500 Internal Server Error
# - OBSERVATIONS: Logs show "Database connection timeout"
# - WHAT DIDN'T WORK: Connection pool size insufficient, timeout after 30s
# - WHAT WILL WE DO NEXT: Increase connection pool from 10 to 50, test retry logic
# - HOW IS THIS DIFFERENT: Previous attempts focused on query optimization, this targets infrastructure
# - CRITICAL ISSUE: Connection pool exhausted during high load
# - LESSONS LEARNED: Infrastructure limits can mask application-level fixes
# - STATUS: 🔴 DATABASE CONNECTION ISSUE IDENTIFIED
##############################################################################
```

## Flag-Specific Behavior

### When using `--fail` flag:

**Enhanced Failure Analysis Prompts**:
```
##############################################################################
# X. YYYY-MM-DD HH:MM - ATTEMPT #X: [Description] - FAILED
# - WHAT WAS TRIED: Specific action taken
# - RESULT: FAILED - [Brief failure description]
# - WHAT SPECIFICALLY FAILED: Exact error, unexpected behavior, wrong output
# - ERROR MESSAGES: Full error text, stack traces, log entries
# - EXPECTED vs ACTUAL: What should have happened vs what did happen
# - WHAT DIDN'T WORK: Detailed analysis of the failure
# - FAILURE SYMPTOMS: Observable signs that indicated failure
# - WHAT WILL WE DO NEXT: Next planned approach/test
# - HOW IS THIS DIFFERENT: How this differs from previous failed attempts
# - LESSONS LEARNED: Key insights from this specific failure
# - HYPOTHESES: What we think might be causing this
# - STATUS: 🔴 FAILED - [Specific failure category]
##############################################################################
```

**Failure-Focused Questions**:
- What exact error message did we get?
- At what point did the process fail?
- What was the last successful step before failure?
- Are there any error logs or stack traces?
- What did we expect to happen vs what actually happened?
- Does this failure pattern match previous attempts?
- What assumptions did we make that might be wrong?
- What was different about the test environment this time?
- What was the state of relevant data before/after the test?
- What other systems/components were involved in the failure?
- Did timing or sequence of operations matter?
- Does this error match any previous error patterns we've seen?

## CRITICAL REMINDERS

1. **LOG EVERY ATTEMPT** - No exceptions, no shortcuts
2. **UPDATE ATTEMPT NUMBER** - Sequential numbering within the task
3. **DOCUMENT EVERYTHING** - What was tried, what happened, what's next
4. **USE PROPER FORMAT** - Summary line + detailed entry
5. **ADD IMMEDIATELY** after each test/attempt
6. **NO ASSUMPTIONS** - Only log what actually happened
7. **USE --fail FLAG** - For failed attempts requiring detailed analysis

This systematic logging prevents:
- Repeating failed approaches
- Losing track of what was tried
- Missing important debugging context
- Wasting time on circular debugging
- Overlooking critical failure details