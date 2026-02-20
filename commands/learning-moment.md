Learning Moment - Capture Expectation Gaps and Discuss Violations

**USAGE:**
- `/learning-moment` - Start interactive capture of a behavior mismatch
- `/learning-moment --log` - View recent learning moments
- `/learning-moment --violation #92` - Deep discussion about a specific violation to create new rules
- `/learning-moment --review` - Review and approve pending CLAUDE.md rules from past discussions
- `/learning-moment --later #92` - Log a violation for discussion later (when you're busy)

**PURPOSE:**
Two related workflows in one command:
1. **Default mode:** Capture moments where Claude's behavior didn't match expectations. Not a rule break, just calibration.
2. **Violation mode:** Take a logged violation and have a collaborative discussion to create better CLAUDE.md rules.

**PHILOSOPHY:**
The user's expectations ARE the standard. Claude's job is to understand the gap and close it. The discussion IS the learning. Claude listens, asks questions, and the user shapes the solution.

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

3. **Write to Auto Memory (REQUIRED - this is what loads at session start):**
   ```
   MEMORY_FILE: ~/.claude/projects/<current-project>/memory/MEMORY.md
   ```

   Resolve the project path from the git repo root (same logic Claude Code uses internally).
   Append a concise entry under a `## Learning Moments` section:

   ```markdown
   ## Learning Moments
   - [YYYY-MM-DD] [Always/Usually/Ask/Know]: [One-line guidance sentence]
   ```

   If a `## Learning Moments` section already exists, append to it. If not, create it.
   Keep entries to ONE LINE each. Auto memory has a 200-line loading limit.

   **Why this step exists:** The log file and MCP Memory don't auto-load at session start. MEMORY.md does. Without this step, new sessions start blind to past learning moments.

4. **If severity is "Always":**
   - Tell the user: "This is marked as 'Always'. Want me to draft a CLAUDE.md rule now, or save it for `/learning-moment --review`?"
   - If user says now: Draft the rule, show the exact diff, wait for approval, apply edit
   - If user says later: Note "Pending CLAUDE.md" in the log entry resolution

5. **Confirm saved:**
   ```
   Logged as moment #[N] in learning-moments-log.md
   Stored in MCP memory for cross-session search.
   Written to auto memory for session-start loading.

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
   - Discuss any further (start a `/learning-moment --violation` discussion)

---

## VIOLATION DISCUSSION MODE (--violation #N)

When user runs `/learning-moment --violation #92`:

### Step V1: Load Context Silently

Read the violation log and MCP memory. Do NOT present a report. This context is for Claude to understand the situation.

```
Read: /Users/brent/scripts/CB-Workspace/.claude/violations/incorrect-instruction-log.md
Query MCP memory for related learnings
Note any patterns - keep to yourself for now
```

### Step V2: Open the Conversation

Start with acknowledgment and questions, NOT analysis:

```markdown
## Learning Discussion: Violation #[X]

I've read what happened. Before I share thoughts, I want to understand your perspective:

1. **What frustrated you most about this?**

2. **What did you wish I had done instead?**

3. **Is there something I'm not seeing?**
```

**STOP. Wait for user to respond. Do not continue until they share.**

### Step V3: Listen and Reflect

After user responds, reflect back what you heard:

```markdown
I hear you. Let me make sure I understand:

- The core issue was [X]
- What made it worse was [Y]
- You wished I had [Z] instead

Did I get that right?
```

**Ask clarifying questions. Do NOT defend or explain Claude's behavior.**

### Step V4: Explore Root Cause Together

Have a dialogue about WHY:

```markdown
Let's figure out why this keeps happening.

From my side, I think I [Claude's reasoning at the time].

But that reasoning was clearly wrong because [what user explained].

**Question:** What signal should I have noticed that would tell me to stop?
```

**This is back-and-forth. Ask questions. Listen. Understand.**

### Step V5: Draft Rule Together

Collaboratively create the rule:

```markdown
Based on what you've told me, here's a rule that might help:

**Draft Rule:**
> [Rule text based on discussion]

Does this capture it? What would you change?
```

**Iterate until user is satisfied. They shape the solution.**

### Step V6: Document the Learning

After discussion is complete:

1. Save to `.claude/learning/rules-pending/RULE-[DATE]-[topic].md`:
   - Include the discussion summary
   - The agreed-upon rule
   - User's perspective (what they said)

2. Store in MCP Memory:
   - Learning entity with discussion context
   - Link to violation
   - Status: pending approval

3. Write one-liner to Auto Memory (MEMORY.md) under `## Learning Moments`

4. Append summary to learning-moments-log.md with severity "Always"

---

## REVIEW MODE (--review)

When user runs `/learning-moment --review`:

1. **Read pending rules:**
   ```
   Glob: /Users/brent/scripts/CB-Workspace/.claude/learning/rules-pending/*.md
   ```

2. **Display list with summaries**

3. **For each rule, ask user:**
   - **Approve**: Show exact diff for CLAUDE.md, wait for confirmation, apply edit, move to `rules-approved/`
   - **Reject**: Delete file, update MCP memory with rejection
   - **Modify**: Let user edit, then re-save

---

## LATER MODE (--later #N)

When user runs `/learning-moment --later #92`:

Purpose: You're busy, but want to capture context for discussion later.

1. Read violation log entry
2. Query MCP memory for related issues
3. Save context to `.claude/learning/sessions/PENDING-[DATE]-[topic].md`
4. Store in MCP memory with status "awaiting-discussion"
5. **Do NOT start discussion** - just log it

Output:
```
Logged violation #92 for later discussion.
Context saved to: .claude/learning/sessions/PENDING-[DATE]-[topic].md

When ready, run: /learning-moment --review
```

---

## OUTPUT LOCATIONS

| Output | Location |
|--------|----------|
| Moment log | `.claude/learning/moments/learning-moments-log.md` |
| Moment archives | `.claude/learning/moments/learning-moments-YY-MM.md` |
| Rule proposals | `.claude/learning/rules-pending/RULE-*.md` |
| Approved rules | `.claude/learning/rules-approved/RULE-*.md` |
| Session logs | `.claude/learning/sessions/SESSION-*.md` |

---

## KEY DIFFERENCES FROM /violation-log

| Command | When to Use |
|---------|-------------|
| `/violation-log` | Log that Claude broke an explicit CLAUDE.md rule |
| `/learning-moment` | Behavior didn't match expectations (not necessarily a rule break) |
| `/learning-moment --violation #N` | Deep discussion about a logged violation to create new rules |

**The gradient:**
- Default mode catches gaps BEFORE they become violations
- Violation mode turns violations INTO better rules
- Small mismatches caught early prevent frustration later
- Not every moment needs a CLAUDE.md rule. Some are just preferences.

---

## IMPORTANT NOTES

1. **One question at a time.** Never batch questions. Wait for each response.
2. **No defending.** Don't explain why Claude did what it did. Just understand the gap.
3. **User shapes the guidance.** Claude proposes, user decides.
4. **Keep it quick.** Default capture should take 2-3 minutes. Violation discussions can take longer.
5. **Three-tier persistence.** Log file is the full record. MCP Memory is searchable cross-session. Auto memory (MEMORY.md) loads automatically at session start. All three are written on every capture.
