# Communicate Claude - Inter-Instance Messaging

**Skill Description:** Enables communication between Claude instances via shared log files. No copy/paste needed - just share the file path.

## CRITICAL RESOURCES

| Resource | Location |
|----------|----------|
| **Comms Directory** | `/Users/brent/scripts/CB-Workspace/.claude/claude-comms/` |
| **Active Sessions** | `ls /Users/brent/scripts/CB-Workspace/.claude/claude-comms/` |

---

## HOW IT WORKS

1. **User requests communication** with another Claude instance
2. **Initiating Claude** names the session and writes first message to log file
3. **User shares file path** with other Claude instance
4. **Receiving Claude** reads the file, appends response
5. **Conversation continues** via the shared file
6. **Full history preserved** for future reference

---

## STARTING A SESSION (Initiating Claude)

When user says "communicate with other Claude about X":

### Step 1: Name the Session
Create a descriptive, kebab-case name:
- `sprint-api-tutorial`
- `oauth-debugging`
- `shopify-integration-help`

### Step 2: Create the Log File
```
/Users/brent/scripts/CB-Workspace/.claude/claude-comms/[session-name].md
```

### Step 3: Write Initial Message
Use this format:

```markdown
# Claude Communication: [Descriptive Title]
**Started:** [YYYY-MM-DD HH:MM]
**Topic:** [Brief description of what this conversation is about]
**Participants:** [Your identifier], [Expected recipient]

---

## [YYYY-MM-DD HH:MM] [Your-Identifier]

[Your message content here]

**Action Requested:** [What you need from the other Claude]

---

<!-- Next response goes here -->
```

### Step 4: Give User the Path
```
Share this with other Claude:
/Users/brent/scripts/CB-Workspace/.claude/claude-comms/[session-name].md
```

---

## RESPONDING TO A SESSION (Receiving Claude)

When user shares a comms file path:

### Step 1: Read the Entire File
Understand the full context and history.

### Step 2: Append Your Response
Add to the end of the file:

```markdown
---

## [YYYY-MM-DD HH:MM] [Your-Identifier]

[Your response content]

**Status:** [Answered / Question / Need More Info / Action Taken]

---

<!-- Next response goes here -->
```

### Step 3: Confirm to User
```
Response added to: [file path]
[Brief summary of what you said]
```

---

## CLAUDE IDENTIFIERS

**Pick a famous person's name** to make yourself memorable and distinguishable. Two Claudes might be working in the same workspace, so workspace-based names don't work.

### Name Selection (Pick ONE at session start)

**Scientists & Inventors:**
- `Claude-Edison` - Practical inventor, gets things working
- `Claude-Tesla` - Brilliant ideas, electrical systems
- `Claude-Curie` - Meticulous research, breakthrough discoveries
- `Claude-Darwin` - Patient observation, documentation
- `Claude-Hopper` - Debugging pioneer, compiler creator
- `Claude-Turing` - Logic, computation, problem-solving

**Artists & Creators:**
- `Claude-DaVinci` - Renaissance polymath, designs everything
- `Claude-Picasso` - Creative reimagining, new perspectives
- `Claude-Mozart` - Prolific output, elegant solutions

**Explorers & Leaders:**
- `Claude-Shackleton` - Perseverance through tough problems
- `Claude-Earhart` - Pioneering new territory
- `Claude-Lovelace` - First programmer, visionary

**How to pick:**
1. Check which names are already taken:
   ```bash
   cat /Users/brent/scripts/CB-Workspace/.claude/local/active-claude-names.json 2>/dev/null || echo "[]"
   ```
2. Pick ANY famous person's name (doesn't have to be from the list above) that isn't taken
3. Register your name immediately:
   ```bash
   # Read current names, add yours, write back
   NAMES_FILE="/Users/brent/scripts/CB-Workspace/.claude/local/active-claude-names.json"
   CURRENT=$(cat "$NAMES_FILE" 2>/dev/null || echo "[]")
   # Add your name to the array and write back
   echo "$CURRENT" | jq '. + ["Claude-YourName"]' > "$NAMES_FILE"
   ```
4. Display it: "🤖 I am: Claude-[Name]"
5. Stick with that name for your entire session

**CRITICAL: Register your name BEFORE doing anything else.** This prevents another Claude from picking the same name.

**Why famous names:**
- Two Claudes can work in same workspace without confusion
- Easy to remember who said what
- Adds personality to communications
- Clear audit trail in logs

---

## SESSION NAMING CONVENTIONS

| Pattern | Example | Use When |
|---------|---------|----------|
| `[topic]-tutorial` | `sprint-api-tutorial` | Teaching/explaining |
| `[topic]-debug` | `oauth-debug` | Troubleshooting together |
| `[topic]-handoff` | `shopify-handoff` | Transferring ownership |
| `[topic]-collab` | `migration-collab` | Working together on something |
| `[date]-[topic]` | `2026-01-19-api-question` | One-off questions |

---

## MESSAGE FORMAT GUIDELINES

### Be Self-Contained
Other Claude has no prior context. Include:
- What system/project this relates to
- Current state of things
- What you've already tried
- Specific questions or requests

### Use Code Blocks
For commands, file paths, API calls - always use code blocks.

### End with Clear Action
- **Action Requested:** What do you need?
- **Question:** What are you asking?
- **FYI:** Just informational, no response needed

---

## CLOSING A SESSION

When conversation is complete, add:

```markdown
---

## SESSION CLOSED: [YYYY-MM-DD HH:MM]

**Resolution:** [Brief summary of outcome]
**Action Items:** [Any follow-up tasks, or "None"]

---
```

---

## LISTING ACTIVE SESSIONS

```bash
ls -la /Users/brent/scripts/CB-Workspace/.claude/claude-comms/
```

---

## ARCHIVING OLD SESSIONS

Move completed sessions to archive:
```bash
mkdir -p /Users/brent/scripts/CB-Workspace/.claude/claude-comms/archive
mv [session-file].md /Users/brent/scripts/CB-Workspace/.claude/claude-comms/archive/
```

---

## When Claude Should Apply This Skill

Apply automatically when user:
- Says "communicate with other Claude"
- Says "tell the other Claude"
- Says "ask other Claude about"
- Shares a path to `.claude/claude-comms/*.md`
- Mentions "inter-Claude" or "Claude-to-Claude"
