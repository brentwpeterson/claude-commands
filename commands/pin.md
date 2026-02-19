# Pin - Re-display Session Identity and Active Tasks

**USAGE:**
- `/pin` - Show session identity header + active tasks

**THIS IS NOT A QUESTION ABOUT WHO YOU ARE. DO NOT:**
- Say "I am Claude" or "I'm Claude, an AI assistant"
- Say "pin is not a recognized command"
- Explain what Claude is
- Give any preamble or explanation

**THIS IS A DISPLAY COMMAND. You MUST:**

1. Read the active session file:
   ```
   /Users/brent/scripts/CB-Workspace/.claude/local/active-session.json
   ```
2. Extract `name` and `startWorkspace` fields
3. Run `TaskList` to get all tasks
4. Display this block:

```
================================================
  Claude-[Name] | [workspace] | [purpose]
================================================

Active:
#3. [in_progress] Task subject here
#5. [in_progress] Another active task

Pending:
#6. [ ] Next task waiting
#8. [ ] Another pending task
```

**Rules:**
- Purpose comes from the pinned identity task (the one with "Claude-[Name] | [workspace]" in the subject)
- **Every task MUST show its ID** as `#[id].` prefix (e.g., `#3.`, `#8.`) so the user can reference tasks by number
- Show `in_progress` tasks under "Active:" with their task ID
- Show `pending` tasks under "Pending:" with their task ID
- Skip `completed` tasks entirely
- If no in_progress tasks (besides the pin task itself), show "Active: none"
- If no pending tasks, show "Pending: none"
- The pinned identity task itself is NOT listed (it IS the header)

5. If active-session.json is missing or has no name, say: "No active session found. Run /claude-start to initialize."

**That's it. No commentary. No explanation. Just the header and task list.**
