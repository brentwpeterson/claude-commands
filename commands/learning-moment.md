Learning Moment - Capture Expectation Gaps Interactively

**USAGE:**
- `/learning-moment` - Start interactive capture of a behavior mismatch
- `/learning-moment --log` - View recent learning moments

**PURPOSE:**
Capture moments where Claude's behavior didn't match what the user expected. This is NOT a violation (use `/violation-log` for rule breaks). This is for calibration: understanding the gap between what Claude did and what the user wanted.

**PHILOSOPHY:**
The user's expectations ARE the standard. Claude's job is to understand the gap and close it. Every learning moment is an opportunity to get closer to how the user thinks.

---

## EXECUTION WORKFLOW

### Mode Detection
1. If `--log` flag: Go to **Review Mode**
2. Otherwise: Start **Capture Mode** (interactive)

---

## CAPTURE MODE (Default)

### Step 1: Acknowledge and Ask

**Present a brief opener, then ask the FIRST question only. Wait for response before continuing.**

```
## Learning Moment

Something I did didn't match what you expected. Let me understand.

**What happened?** Describe what I did that surprised you or wasn't what you wanted.
```

**STOP. Wait for user response. Do not ask multiple questions at once.**

### Step 2: Understand the Expectation

After user describes what happened, ask:

```
Got it. **What did you expect me to do instead?**
```

**STOP. Wait for user response.**

### Step 3: Understand the Why

After user describes their expectation, ask:

```
**Why does that matter to you?** (Pick whichever fits, or tell me in your own words)
- It wasted time
- It created extra work to undo
- It broke my trust in the output
- It's a preference for how I want things done
- Other reason
```

**STOP. Wait for user response.**

### Step 4: Gauge Severity

After user explains why it matters, ask:

```
**How should I handle this going forward?**
- **Always** - This should be a hard rule. Never do it the wrong way.
- **Usually** - Default to the expected behavior, but exceptions exist.
- **Ask first** - When this situation comes up, ask me before deciding.
- **Just know** - Be aware of my preference. No strict rule needed.
```

**STOP. Wait for user response.**

### Step 5: Reflect Back and Confirm

Summarize concisely:

```
Here's what I'm taking away:

**Situation:** [What triggered this]
**What I did:** [Claude's behavior]
**What you wanted:** [Expected behavior]
**Why it matters:** [User's reason]
**Going forward:** [Always/Usually/Ask first/Just know]

**Draft guidance:**
> [One clear sentence capturing the rule/preference]

Does this capture it? Want to change anything?
```

**STOP. Wait for user confirmation or edits.**

### Step 6: Save the Learning Moment

**After user confirms, do ALL of the following:**

**Step 6a: Check for monthly rotation FIRST**
```
MOMENTS_DIR: /Users/brent/scripts/CB-Workspace/.claude/learning/moments/
CURRENT_LOG: learning-moments-log.md
ARCHIVE_FORMAT: learning-moments-YY-MM.md (e.g., learning-moments-26-01.md)
```

1. Get current month (YYYY-MM)
2. Read the current log file. Check the date of the FIRST entry.
3. If the first entry is from a PREVIOUS month:
   - Rename current log to `learning-moments-YY-MM.md` (using the month of the entries)
   - Create fresh `learning-moments-log.md` with header and `**Total Moments:** 0`
   - Reset counter
4. If same month, continue without rotation.

**Step 6b: Append to the log file (REQUIRED - this is the single source of truth):**
   ```
   LOG_FILE: /Users/brent/scripts/CB-Workspace/.claude/learning/moments/learning-moments-log.md
   ```

   **Read the log file.** Find the `**Total Moments:** N` line and increment N.
   Then append a new entry before the final `---`:

   ```markdown
   ## [YYYY-MM-DD] - [Short Title] (#[N])

   **Severity:** [Always/Usually/Ask first/Just know]
   **Trigger:** [One sentence: what happened that triggered this]
   **Expected:** [One sentence: what user wanted instead]
   **Resolution:** [One sentence: what was done about it, or "Logged as preference"]

   ---
   ```

2. **Store in MCP Memory:**
   ```
   Entity: "LearningMoment-[YYYY-MM-DD]-[short-slug]"
   Type: "learning-moment"
   Observations:
   - "Situation: [brief description]"
   - "Expected: [what user wanted]"
   - "Guidance: [the rule/preference]"
   - "Severity: [Always/Usually/Ask first/Just know]"
   ```

3. **If severity is "Always":**
   - Tell the user: "This is marked as 'Always'. Want me to draft a CLAUDE.md rule now, or save it for `/claude-learner --review`?"
   - If user says now: Draft the rule, show the exact diff, wait for approval, apply edit
   - If user says later: Note "Pending CLAUDE.md" in the log entry resolution

4. **Confirm saved:**
   ```
   Logged as moment #[N] in learning-moments-log.md
   Stored in memory for future sessions.

   [If Always: "Ready for CLAUDE.md update when you approve."]
   [If other: "I'll keep this in mind going forward."]
   ```

**NOTE:** Individual MOMENT-*.md files are NOT created. The log file IS the record. One file, one place to check.

---

## REVIEW MODE (--log flag)

When user runs `/learning-moment --log`:

1. **Read the log file:**
   ```
   /Users/brent/scripts/CB-Workspace/.claude/learning/moments/learning-moments-log.md
   ```

2. **Display summary table from the log entries:**
   ```
   ## Learning Moments ([N] total)

   | # | Date | Topic | Severity |
   |---|------|-------|----------|
   | 1 | 2026-02-02 | Commands need --help | Always |
   ...
   ```

3. **Ask if user wants to:**
   - Promote any to CLAUDE.md rules
   - Delete any that are no longer relevant
   - Discuss any further (hand off to `/claude-learner`)

---

## KEY DIFFERENCES FROM OTHER COMMANDS

| Command | When to Use |
|---------|-------------|
| `/violation-log` | Claude broke an explicit rule in CLAUDE.md |
| `/claude-learner` | Deep discussion about a violation, create new rules |
| `/learning-moment` | Claude's behavior didn't match expectations (not a rule break) |

**The gradient:**
- `/learning-moment` catches gaps BEFORE they become violations
- Small mismatches, caught early, prevent frustration later
- Not every moment needs a CLAUDE.md rule. Some are just preferences.

---

## IMPORTANT NOTES

1. **One question at a time.** Never batch questions. Wait for each response.
2. **No defending.** Don't explain why Claude did what it did. Just understand the gap.
3. **User shapes the guidance.** Claude proposes, user decides.
4. **Keep it quick.** This should take 2-3 minutes, not 15. It's a capture tool, not therapy.
5. **MCP memory ensures persistence.** Even if the file is forgotten, the learning lives in memory.
