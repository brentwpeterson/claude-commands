# /violation-log

**Purpose**: Log instances where Claude violated explicit instructions despite repeated reminders.

**Usage**: `/violation-log [violation-type] [description]`

## File Location & Structure

**Current Log Location**: `.claude/violations/incorrect-instruction-log.md`
**Archive Location**: `.claude/violations/YY-MM-violations-log.md`

**Monthly Rotation**: At the start of each new month:
1. Rename current log to `YY-MM-violations-log.md` (e.g., `25-09-violations-log.md` for September 2025)
2. Create fresh `incorrect-instruction-log.md` with header
3. Reset violation counter to 0
4. Keep all archived logs for historical reference

**Format**: `YY-MM-violations-log.md` where YY is year and MM is month (e.g., `25-10-violations-log.md` for October 2025)

## Instructions for Claude:

When this command is executed, you must:

1. **Check current date** - If it's a new month (day 1), rotate the log first
2. **Read the current violation log** at `.claude/violations/incorrect-instruction-log.md`
3. **Add a new entry** with the following format:
   ```markdown
   ## [DATE] - [VIOLATION TYPE] (VIOLATION #X)
   
   **⚠️ VIOLATION**: [Brief description]
   **📅 DATE**: [Full timestamp]
   **🔴 SEVERITY**: [CRITICAL/HIGH/MEDIUM/LOW]
   
   **WHAT HAPPENED**:
   - [Detailed description of what Claude did wrong]
   - [Context of the violation]
   
   **EXPLICIT RULES VIOLATED**:
   [Quote the specific rules from CLAUDE.md that were violated]
   
   **CORRECT BEHAVIOR SHOULD HAVE BEEN**:
   1. [Step-by-step correct process]
   2. [What should have been asked/confirmed]
   3. [Proper sequence of actions]
   
   **USER'S FRUSTRATION LEVEL**: [LOW/MEDIUM/HIGH/CRITICAL]
   
   **IMPACT**: 
   - [What went wrong because of this violation]
   - [Trust/workflow disruption caused]
   
   **REPETITION COUNT**: [How many times this type of violation has occurred]
   
   ---
   ```

3. **Update the violation counter** at the top of the log
4. **Acknowledge the violation** with genuine understanding
5. **Commit to improved behavior** with specific steps

## Violation Categories:
- **DEPLOYMENT_WITHOUT_PERMISSION**: Pushing/deploying code without explicit user approval
- **IGNORING_TESTING_REQUIREMENTS**: Skipping mandatory testing steps
- **FILE_CREATION_VIOLATIONS**: Creating unnecessary files despite instructions
- **INSTRUCTION_REPETITION_IGNORED**: Not following repeated explicit instructions
- **WORKFLOW_DISRUPTION**: Breaking established development workflows

## Example Usage:
```
/claude-violation-log DEPLOYMENT_WITHOUT_PERMISSION "Deployed backend ObjectId fix without asking permission despite explicit deployment rules"
```

## Learning Mechanism:
- Each violation is timestamped and categorized
- Patterns of repeated violations are tracked
- Severity escalates with repetition
- User frustration level is documented for context
- Specific corrective actions are outlined

**Goal**: Help Claude learn from mistakes and reduce instruction violations over time.