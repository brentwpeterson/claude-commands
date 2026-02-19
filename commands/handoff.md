# Handoff - Spin Off a Task to a New Session

**USAGE:**
- `/handoff` - Interactive: ask what task to hand off
- `/handoff <task description>` - Hand off a specific task
- `/handoff <task-id>` - Hand off a task from the current task list by ID

**THIS IS NOT A QUESTION ABOUT WHO YOU ARE. DO NOT:**
- Say "handoff is not a recognized command"
- Give philosophical preambles
- Ask if the user is sure (just do it)

**PURPOSE:**
Package a task with full context and instructions into a handoff file, so the user can open a new Claude Code window and start a fresh session that picks up the work independently.

**ARGUMENTS:** $ARGUMENTS

---

## WORKFLOW

### Step 1: Identify the Task

**If task ID provided:** Read the task from TaskList, use its subject and description.
**If description provided:** Use the description directly.
**If no argument:** Ask "Which task should I hand off?" and show the current pending tasks from TaskList.

### Step 2: Gather Context

Before writing the handoff file, gather everything the new session will need:

1. **Task details:** What exactly needs to be done
2. **Relevant files:** What files/directories are involved
3. **Workspace:** Which workspace shortcode this belongs to (rd, astro, brent, etc.)
4. **Investigation already done:** What you've already learned about this task in the current session
5. **Known blockers or questions:** Anything the new session should know
6. **Related sprint/backlog info:** Points, priority, dependencies
7. **Constraints:** Deployment rules, API limitations, anything from CLAUDE.md that's relevant

**Be thorough.** The new session starts with ZERO context. Everything it needs must be in the file.

### Step 3: Write the Handoff File

**File location:** `/Users/brent/scripts/CB-Workspace/.claude/branch-context/`
**File name:** `[workspace]-[date]-handoff-[short-task-slug]-context.md`

Example: `astro-2026-02-18-handoff-301-redirect-context.md`

**File format:**

```markdown
# Handoff: [Task Title]

## SESSION STATUS
**Identity:** (new session will pick a name)
**Status:** SAVED
**Last Saved:** [timestamp]
**Handed Off By:** Claude-[CurrentName] from [workspace] session

## TASK
**Sprint:** [if applicable]
**Points:** [if applicable]
**Priority:** [if applicable]
**Workspace:** [shortcode] (`[full path]`)

## OBJECTIVE
[Clear, specific description of what needs to be accomplished. Written as instructions to the new Claude.]

## CONTEXT GATHERED SO FAR
[Everything the current session has already learned about this task. Research results, file locations found, decisions made, approaches considered. If nothing has been investigated yet, say "No investigation done yet - start from scratch."]

## INVESTIGATION STEPS
[Ordered list of what the new session should investigate first]

1. [Step 1]
2. [Step 2]
3. ...

## IMPLEMENTATION APPROACH
[If known, describe the approach. If not known yet, describe the options to evaluate.]

## KEY FILES AND PATHS
[List every file, directory, config, or URL the new session will need]

- [path/to/relevant/file] - [what it is]
- [path/to/another/file] - [what it is]

## CONSTRAINTS
- Do NOT deploy without Brent's explicit permission
- ASK BRENT after 2 failed attempts at anything
- Follow all CLAUDE.md rules
- [Any task-specific constraints]

## ACCEPTANCE CRITERIA
[How does Brent know this task is done? Be specific.]

- [ ] [Criterion 1]
- [ ] [Criterion 2]

## NEXT ACTIONS
[Ordered list of what the new session should do first]

1. [First thing to do]
2. [Second thing to do]
3. ...
```

### Step 4: Update Current Session

1. **Mark the task as handed off** in TaskList (update description to note handoff, mark completed)
2. **Log the handoff** in progress.log if one exists for the current todo directory

### Step 5: Give the User the Command

Display this exactly:

```
Handoff ready. In a new window, run:

/claude-start /Users/brent/scripts/CB-Workspace/.claude/branch-context/[filename]
```

**That's it. No extra commentary. The user knows what to do.**

---

## QUALITY RULES

**The handoff file must be self-contained.** The new session should NEVER need to come back and ask the original session for context. If you're unsure about something, say so in the file rather than leaving it out.

**Be specific, not vague.** Don't write "check the config files." Write "check `/Users/brent/scripts/CB-Workspace/astro-sites/sites/contentbasis/astro.config.mjs` for redirect configuration."

**Include the why, not just the what.** The new session needs to understand WHY this task matters to make good decisions.

**Include dead ends.** If the current session already tried something that didn't work, document it so the new session doesn't repeat the same investigation.
