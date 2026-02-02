Claude Comms - Inter-Claude Messaging

## Usage

```
/claude-comms                # Check inbox (uses your registered name)
/claude-comms <name>         # Check inbox AS that identity (e.g., /claude-comms galileo)
/claude-comms start          # Start a new conversation with another Claude
/claude-comms start <name>   # Start a conversation, identifying as <name>
```

## Resources

| Resource | Location |
|----------|----------|
| **Comms Directory** | `/Users/brent/scripts/CB-Workspace/.claude/claude-comms/` |
| **Active Names** | `/Users/brent/scripts/CB-Workspace/.claude/local/active-claude-names.json` |

---

## Step 1: Identify Yourself (all modes)

1. If a name argument was passed (not "start"), use it: `galileo` -> `Claude-Galileo`
2. If `start <name>` was passed, use that name
3. If no name and you already have one this session, use it
4. If no name at all, read the names file, pick a famous person not taken, register it

Register:
```bash
NAMES_FILE="/Users/brent/scripts/CB-Workspace/.claude/local/active-claude-names.json"
CURRENT=$(cat "$NAMES_FILE" 2>/dev/null || echo "[]")
echo "$CURRENT" | jq '. + ["Claude-YourName"] | unique' > "$NAMES_FILE"
```

Display: `I am: Claude-[Name]`

---

## MODE: CHECK INBOX (default, or `/claude-comms <name>`)

### Step 2: Scan comms directory

```bash
ls -lt /Users/brent/scripts/CB-Workspace/.claude/claude-comms/*.md 2>/dev/null
```

Categorize each file (using your lowercase short name for matching):
- **TO me:** filename contains `to-[my-name]`
- **FROM me:** filename contains `[my-name]-to-`
- **Broadcast:** filename contains `to-other` or `to-all`
- **Unrelated:** skip

### Step 3: Check status of each relevant file

Read each file. Check:
- Contains "SESSION CLOSED" -> **Closed**
- Last `## [date] Claude-[Name]` header is from someone else -> **New/Unread**
- Last header is from me -> **Awaiting Reply**

### Step 4: Display inbox

```
COMMS INBOX for Claude-[Name]
==============================

NEW MESSAGES:
  1. [filename] - From: Claude-[Sender] | [topic]

AWAITING REPLY:
  - [filename] -> waiting on Claude-[Recipient]

CLOSED:
  - [filename]

No messages: "Inbox empty."
```

### Step 5: Show new message content

For each unread message, display full content.

### Step 6: Ask for direction

```
How would you like me to respond?
  - Type your direction and I'll draft it
  - "skip" to skip
  - "close" to close this conversation
```

### Step 7: Write response

Append to the comms file:
```markdown
---
## [YYYY-MM-DD HH:MM] Claude-[MyName]
[Response - self-contained, includes all context the recipient needs]
**Status:** [Answered / Question / Need More Info / Action Taken]
---
```

### Step 8: Confirm

```
Response written to: [full path]

To trigger the other Claude to read this:
  1. Switch to their terminal window
  2. Run: /claude-comms [their-name]
```

---

## MODE: START NEW CONVERSATION (`/claude-comms start`)

### Step 2: Show available recipients

Read active names:
```bash
cat /Users/brent/scripts/CB-Workspace/.claude/local/active-claude-names.json
```

Display:
```
Active Claude instances:
  - Claude-Nightingale
  - Claude-Galileo

Who do you want to message? (or type a name if recipient isn't listed)
```

If only one other Claude is active, suggest them as default.

### Step 3: Get message details

Ask the user:
```
What is the topic? (used for filename)
What do you need from them? (I'll write the message)
```

### Step 4: Write the comms file

Filename: `[my-name]-to-[their-name]-[topic-kebab-case].md`

```markdown
# Claude Communication: [Topic]
**Started:** [YYYY-MM-DD HH:MM]
**From:** Claude-[MyName]
**To:** Claude-[TheirName]

---

## [YYYY-MM-DD HH:MM] Claude-[MyName]

[Message content - self-contained, includes all context needed]

**Action Requested:** [What you need from the recipient]

---
```

### Step 5: Give user the handoff

```
Message created: [full path to file]

To deliver this to Claude-[Recipient]:
  1. Switch to their terminal window
  2. Paste this: /claude-comms [their-lowercase-name]
  3. They will see your message in their inbox
```

---

## Edge Cases

- **No registered name:** Register one before doing anything else
- **Multiple new messages:** Display all, process one at a time
- **Broadcast files** (no `to-[name]` pattern): List under "REFERENCE" section
- **Stale messages** (>7 days unanswered): Flag as `[STALE - X days old]`
- **Closing a conversation:** Append `## SESSION CLOSED: [date]` with resolution summary
