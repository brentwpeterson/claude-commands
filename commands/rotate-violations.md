# /rotate-violations

**Purpose**: Monthly rotation of the violations log to archive the previous month and start fresh for the current month.

**Usage**: `/rotate-violations`

**When to Run**: First day of each month, or when the main log file exceeds ~100KB.

## File Locations

**Current Log**: `.claude/violations/incorrect-instruction-log.md`
**Archive Pattern**: `.claude/violations/YY-MM-violations-log.md`

## Instructions for Claude:

When this command is executed:

### 1. Check Current State

```bash
# Check file sizes and current month
ls -la .claude/violations/
```

Review what months are currently in the main log vs already archived.

### 2. Read the Main Log Header

Read `.claude/violations/incorrect-instruction-log.md` to find:
- Current total violation count
- Which months/violations are in the file
- The monthly index section

### 3. Determine What Needs Archiving

Look at the dates of violations in the main log:
- Identify which complete months should be archived
- Keep the CURRENT month's violations in the main log
- Archive all PREVIOUS months' violations

### 4. Create Archive Files

For each month to archive, create a file named `YY-MM-violations-log.md`:

**Header format**:
```markdown
# [Month] [Year] Claude Violations

**MONTH**: [Month] [Year]
**VIOLATION COUNT**: X violations (#[start]-#[end])

---
```

Then copy all violations from that month into the archive file.

### 5. Update the Main Log

After archiving, update `incorrect-instruction-log.md`:

1. **Update the total count** (keep running total)
2. **Update the monthly index** to reference the new archive files:
   ```markdown
   ## 📅 MONTHLY VIOLATION LOGS

   **2026:**
   - **January**: Violations #X-#Y (current month, in this file)

   **2025:**
   - **December**: Violations #A-#B → See `25-12-violations-log.md`
   - **November**: Violations #C-#D → See `25-11-violations-log.md`
   ...
   ```
3. **Remove archived violations** from the main log (keep only current month)
4. **Keep the footer sections** (DEPLOYMENT RULE REMINDERS, ACTION ITEMS, COMMITMENT)

### 6. Verify the Rotation

```bash
# Verify files exist
ls -la .claude/violations/*.md

# Check file sizes are reasonable
wc -l .claude/violations/incorrect-instruction-log.md
```

## Archive File Naming Convention

| Month | Archive Filename |
|-------|-----------------|
| January 2026 | `26-01-violations-log.md` |
| December 2025 | `25-12-violations-log.md` |
| November 2025 | `25-11-violations-log.md` |

## Example Rotation

**Before rotation** (main log has Nov + Dec + Jan):
- `incorrect-instruction-log.md` (150KB, violations #69-#102)

**After rotation** (current month only):
- `incorrect-instruction-log.md` (40KB, violations #87-#102 for January 2026)
- `25-11-violations-log.md` (15KB, violations #69-#74)
- `25-12-violations-log.md` (35KB, violations #75-#86)

## Confirmation

After rotation, report:
- New archive files created
- Violations moved to each archive
- Current month violations remaining in main log
- Updated total count

**DO NOT** lose any violations during rotation. All violations must be preserved either in the main log or an archive file.
