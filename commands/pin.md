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
4. Display in this compact format:

```
  N tasks (X done, Y in progress, Z open)
  ◼ Claude-[Name] | [workspace] - [purpose]
  ✔ Completed task subject
  ▶ In-progress task subject
  ◻ Pending task subject
  ◻ Another pending task
```

**Rules:**
- **First line:** Task summary count: `N tasks (X done, Y in progress, Z open)`
- **Second line:** Session identity with `◼` prefix. Purpose comes from the pinned identity task (the one with "Claude-[Name] | [workspace]" in the subject). Use a dash separator, not pipe, between workspace and purpose.
- **Task lines** use these markers:
  - `✔` for completed tasks
  - `▶` for in_progress tasks
  - `◻` for pending tasks
- List tasks in order: in_progress first, then pending, then completed
- The pinned identity task itself is NOT listed (it IS the header line)
- If no tasks exist, show only the identity line and "No tasks"
- No task IDs, no section headers, no separators. Just the compact list.

5. Check for an active todo directory. Look for the most recent directory in:
   ```
   /Users/brent/scripts/CB-Workspace/todo/current/
   ```
   If one exists, read its `README.md` and append a single line:
   ```
   📁 [branch-name] - [status from README]
   ```
   If no todo directory exists, omit this line entirely.

6. **If NO identity task exists in TaskList** (no task with "Claude-[Name] | [workspace]" pattern):
   - Read `active-session.json` for the `name` field
   - If a name exists, automatically create the identity task: `TaskCreate` with subject `Claude-[Name] | [workspace] - [current work purpose]`
   - Infer the purpose from conversation context (what the user is working on)
   - Register the name: `mkdir -p .claude/local/names/Claude-[Name]`
   - Then display the pin output as normal
   - **DO NOT ask the user if you should create it. Just do it. /pin IS the trigger.**

7. If `active-session.json` is missing or has no name:
   - Pick a name (scientist, explorer, artist - not already in `.claude/local/names/`)
   - Register it: `mkdir -p .claude/local/names/Claude-[Name]`
   - Write `active-session.json` with the name, workspace, and timestamp
   - Create the identity task
   - Display the pin output
   - **DO NOT ask. Just do it.**

8. If active-session.json exists but truly cannot be created (permissions error, etc.), say: "No active session found. Run /claude-start to initialize."

**That's it. No commentary. No explanation. Just the compact block.**
