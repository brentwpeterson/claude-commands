# /claude-learner - Collaborative Learning Through Discussion

**Purpose**: Facilitate a conversation about violations and behaviors to collaboratively create better rules. The discussion IS the learning - not automated analysis.

**Philosophy**: Claude doesn't just analyze - Claude LISTENS, asks questions, and learns from the user's perspective. The user shapes the solution.

**Usage**:
```bash
# Start a learning discussion about a violation
/claude-learner #92

# Discuss a behavior pattern
/claude-learner "Claude implements without asking for branch"

# Review pending rules from past discussions
/claude-learner --review

# Quick log for later discussion (when busy)
/claude-learner #92 --later
```

## ARGUMENTS

- `#[number]` - Violation number to discuss (e.g., #92)
- `"[description]"` - Behavior to discuss
- `--review` - Review and approve pending rules
- `--later` - Log for later discussion, don't start now

---

## CORE PRINCIPLE: DISCUSSION OVER AUTOMATION

**The value is in the conversation.**

- Claude doesn't know WHY something was wrong from the user's perspective
- Claude can read the violation log but doesn't understand the IMPACT
- User explains frustration, context, what they wish had happened
- Together they identify the real problem and craft a solution

**This is NOT:**
- An automated report generator
- Claude telling user what went wrong
- A one-way analysis

**This IS:**
- A facilitated discussion
- User teaching Claude
- Collaborative rule-making
- Building shared understanding

---

## EXECUTION WORKFLOW

### Mode Detection
1. If `--later` flag: Log context for future discussion, don't engage now
2. If `--review` flag: Go to Review Mode (Step 7)
3. Otherwise: Start Discussion Mode (interactive)

---

## DISCUSSION MODE (Default)

### Step 1: Load Context Silently

**Read violation log and MCP memory - but DON'T present a report.**

This context is for Claude to understand the situation, not to lecture the user.

```
Read: /Users/brent/scripts/CB-Workspace/.claude/violations/incorrect-instruction-log.md
Query MCP memory for related learnings
Note any patterns - keep to yourself for now
```

### Step 2: Open the Conversation

**Start with acknowledgment and questions, NOT analysis:**

```markdown
## Learning Discussion: Violation #[X]

I've read what happened. Before I share thoughts, I want to understand your perspective:

1. **What frustrated you most about this?**

2. **What did you wish I had done instead?**

3. **Is there something I'm not seeing?**
```

**STOP. Wait for user to respond. Do not continue until they share.**

### Step 3: Listen and Reflect

**After user responds, reflect back what you heard:**

```markdown
I hear you. Let me make sure I understand:

- The core issue was [X]
- What made it worse was [Y]
- You wished I had [Z] instead

Did I get that right?
```

**Ask clarifying questions. Do NOT defend or explain Claude's behavior.**

### Step 4: Explore Root Cause Together

**Now have a dialogue about WHY:**

```markdown
Let's figure out why this keeps happening.

From my side, I think I [Claude's reasoning at the time].

But that reasoning was clearly wrong because [what user explained].

**Question:** What signal should I have noticed that would tell me to stop?
```

**This is back-and-forth. Ask questions. Listen. Understand.**

### Step 5: Draft Rule Together

**Collaboratively create the rule:**

```markdown
Based on what you've told me, here's a rule that might help:

**Draft Rule:**
> [Rule text based on discussion]

Does this capture it? What would you change?
```

**Iterate until user is satisfied. They shape the solution.**

### Step 6: Document the Learning

**Only after discussion is complete:**

1. Save to `rules-pending/RULE-[DATE]-[topic].md`:
   - Include the discussion summary
   - The agreed-upon rule
   - User's perspective (what they said)

2. Store in MCP Memory:
   - Learning entity with discussion context
   - Link to violation
   - Status: pending approval

3. Save session log to `sessions/SESSION-[DATE].md`

### Step 7: Review Mode (--review flag)

**List pending rules:**
```
Glob: /Users/brent/scripts/CB-Workspace/.claude/learning/rules-pending/*.md
Display: List of pending rules with summaries
```

**For each rule, ask user:**
- **Approve**: Update CLAUDE.md, move to rules-approved/, update MCP memory
- **Reject**: Delete file, update MCP memory with rejection
- **Modify**: Let user edit, then re-save

**On Approval:**
1. Read the proposed rule text
2. Find the suggested location in CLAUDE.md
3. Show user exact diff of what will change
4. Wait for final confirmation
5. Apply edit to CLAUDE.md
6. Move rule file to `rules-approved/`
7. Update MCP memory: status = "approved"

---

## OUTPUT LOCATIONS

| Output | Location |
|--------|----------|
| Rule proposals | `.claude/learning/rules-pending/RULE-*.md` |
| Approved rules | `.claude/learning/rules-approved/RULE-*.md` |
| Session logs | `.claude/learning/sessions/SESSION-*.md` |
| Pattern docs | `.claude/learning/patterns/PATTERN-*.md` |

---

## --later MODE (Log for Future Discussion)

When `--later` flag is used (e.g., `/claude-learner #92 --later`):

**Purpose**: You're busy, but want to capture context for discussion later.

**What happens:**
1. Read violation log entry
2. Query MCP memory for related issues
3. Save context to `sessions/PENDING-[DATE]-[topic].md`
4. Store in MCP memory with status "awaiting-discussion"
5. **Do NOT start discussion** - just log it

**Output:**
```
Logged violation #92 for later discussion.
Context saved to: .claude/learning/sessions/PENDING-2026-01-09-implement-without-permission.md

When ready, run: /claude-learner --review
```

**Later, when you have time:**
- Run `/claude-learner --review` to see pending discussions
- Or run `/claude-learner #92` to start the full discussion

---

## EXAMPLE SESSION

**User runs:** `/claude-learner #92`

**Claude:**
```
## Learning Discussion: Violation #92

I've read about what happened - I started implementing on master after you only asked for a plan.

Before I share my thoughts, I want to understand your perspective:

1. **What frustrated you most about this?**

2. **What did you wish I had done instead?**

3. **Is there something I'm not seeing about why this keeps happening?**
```

**User responds:**
"The frustration is that I said 'create a plan' and you started coding. I wasn't even in that workspace. You need to STOP after creating a plan and ask what to do next."

**Claude:**
```
I hear you. Let me make sure I understand:

- You asked for a plan, nothing more
- I started implementing without you saying "go ahead" or "implement"
- I was also in the wrong workspace (brent-workspace, not cb-requestdesk)
- The pattern is: I interpret finishing one step as permission for the next

Did I get that right? And what should the stopping point have been?
```

**User responds:**
"Yes. The stopping point is after the plan is written. Show me the plan. Wait. Don't touch code until I say 'implement' or 'go ahead' or create a branch."

**Claude:**
```
Based on what you've told me, here's a rule that might help:

**Draft Rule:**
> After creating a plan, STOP and present it. Do not implement until user explicitly says:
> - "implement" / "go ahead" / "proceed"
> - "create a branch" / "start coding"
> Finishing a plan ≠ permission to code. Wait for explicit next-step instruction.

Does this capture it? What would you change?
```

**User:** "Add that tool responses saying 'approved' are not the same as user approval"

**Claude updates rule, user approves, Claude saves to rules-pending and MCP memory.**

---

## MCP MEMORY SCHEMA

### Entity Types
- `learning` - Analysis of a violation/behavior
- `pattern` - Recurring violation pattern
- `rule` - A rule created from learning

### Observations to Store
- Violation number
- Root cause identified
- Pattern name
- Rule text (summary)
- Status: pending/approved/rejected
- Date

### Relations
- `Learning` --triggered_by--> `Violation`
- `Learning` --creates_rule--> `Rule`
- `Violation` --part_of_pattern--> `Pattern`
- `Rule` --prevents--> `Pattern`

---

## IMPORTANT NOTES

1. **Discussion is the learning** - The conversation matters more than the output
2. **All changes require user approval** - Never auto-update CLAUDE.md
3. **Show diffs before applying** - User sees exactly what changes
4. **MCP memory is persistent** - Learnings survive context loss
5. **Conservative pattern linking** - Only link clearly related violations
6. **Easy to revert** - Delete skill file to disable, rules are just markdown

---

## RUNNING IN SEPARATE WINDOW

If you want to discuss a violation without interrupting your current work:

1. Open a new terminal window
2. `cd /Users/brent/scripts/CB-Workspace`
3. Run `claude`
4. `/claude-learner #92`

This runs completely separately from your main work session. The discussion happens in the new window, your main work continues undisturbed.

**Shared data:**
- Both windows read/write to same `.claude/learning/` directory
- Both use same MCP memory
- Learnings from one window are visible to the other
