# Brent Start - Daily Operating System

Start your day with a full view: rocks, tasks, content, and integrations.

## Usage

```
/brent-start
```

## Instructions for Claude

### Step 1: Confirm Today's Date

**ALWAYS ASK FIRST:**

```
What's today's date? (e.g., "December 31" or "12/31")
```

Wait for user response before proceeding. Store this as `TODAY_DATE` for the session.

---

### Step 2: Set Working Directory

```
📁 Working Directory: /Users/brent/scripts/CB-Workspace/brent-workspace
```

All file operations should be relative to this directory.

**Key Paths:**
| Purpose | Path |
|---------|------|
| Obsidian Vault | `ob-notes/Brent Notes/` |
| Dashboard | `ob-notes/Brent Notes/Dashboard/` |
| Content TODO | `ob-notes/Brent Notes/Dashboard/CONTENT-TODO.md` |
| Quarterly Rocks | `ob-notes/Brent Notes/Dashboard/QUARTERLY-ROCKS.md` |
| Weekly Scorecard | `ob-notes/Brent Notes/Dashboard/WEEKLY-SCORECARD.md` |
| Q1 Planning | `ob-notes/Brent Notes/Dashboard/Q1-2026-PLANNING.md` |
| Tuesdays with Claude | `ob-notes/Brent Notes/Tuesdays with Claude/` |
| LinkedIn Articles | `ob-notes/Brent Notes/LinkedIn Articles/` |
| Ideas | `ob-notes/Brent Notes/idea-stash/` |
| Saved Prompts | `ob-notes/Brent Notes/Saved Prompts/` |

---

### Step 3: Read Essential Files

Read these files to understand current state:

```bash
# 1. Quarterly Rocks - your 90-day priorities
cat "/Users/brent/scripts/CB-Workspace/brent-workspace/ob-notes/Brent Notes/Dashboard/QUARTERLY-ROCKS.md"

# 2. Weekly Scorecard - this week's numbers
cat "/Users/brent/scripts/CB-Workspace/brent-workspace/ob-notes/Brent Notes/Dashboard/WEEKLY-SCORECARD.md"

# 3. Content TODO - content-specific tasks
cat "/Users/brent/scripts/CB-Workspace/brent-workspace/ob-notes/Brent Notes/Dashboard/CONTENT-TODO.md"

# 4. Integration Setup - check what's connected
cat "/Users/brent/scripts/CB-Workspace/brent-workspace/ob-notes/Brent Notes/Dashboard/INTEGRATION-SETUP.md"

# 5. Q1 Planning - quarter planning and priorities
cat "/Users/brent/scripts/CB-Workspace/brent-workspace/ob-notes/Brent Notes/Dashboard/Q1-2026-PLANNING.md"
```

---

### Step 4: Check Recent Activity

```bash
# Files modified in last 7 days
find /Users/brent/scripts/CB-Workspace/brent-workspace/ob-notes/Brent\ Notes -name "*.md" -mtime -7 -type f 2>/dev/null | grep -v ".obsidian" | head -15
```

---

### Step 5: Present Daily Dashboard

Format output as:

```
## 🎯 Brent's Daily Operating System

**Date:** [TODAY_DATE from Step 1]
**Quarter:** Q1 2025 | Week [X] of 13

---

### 🪨 ROCK FOCUS

[From QUARTERLY-ROCKS.md - show top 3 rocks with status]

| Rock | Progress | This Week's Action |
|------|----------|-------------------|
| 1. [Rock name] | [X]% | [Action needed] |
| 2. [Rock name] | [X]% | [Action needed] |
| 3. [Rock name] | [X]% | [Action needed] |

**Which rock are you moving today?**

---

### 🔌 INTEGRATIONS STATUS

[From INTEGRATION-SETUP.md]

| Tool | Status | Data Available |
|------|--------|----------------|
| HubSpot | 🔴/🟢 | [If connected: X tasks due, $X pipeline] |
| Fireflies | 🔴/🟢 | [If connected: X meetings this week] |
| Instantly | 🔴/🟢 | [If connected: X emails, X replies] |

*(If not connected, show: "Run 'let's set up integrations' to connect")*

---

### 📊 WEEKLY SCORECARD

[From WEEKLY-SCORECARD.md]

| Metric | Target | Actual | Status |
|--------|--------|--------|--------|
| Articles | 1 | [X] | 🔴/🟢 |
| LinkedIn | 2-3 | [X] | 🔴/🟢 |
| [Sales metric] | [X] | [X] | 🔴/🟢 |

---

### ✍️ CONTENT DUE

Based on [day of week]:
- [ ] Tuesday = Tuesdays with Claude article
- [ ] Wed/Thu = LinkedIn post

---

### 📝 RECENT ACTIVITY (7 days)

[List from Step 4]

---

### ⚡ QUICK ACTIONS

1. **Work on a rock** - Pick a rock to move forward
2. **Clear HubSpot tasks** - (when connected)
3. **Write content** - Article or LinkedIn post
4. **Capture idea** - Quick note to idea-stash
5. **Update scorecard** - Log this week's numbers
6. **Set up integrations** - Connect HubSpot/Fireflies/Instantly

What's your #1 priority today?
```

---

### Step 6: Handle User Choice

**Choice 1 - Work on a rock:**
1. Show the quarterly rocks list
2. Ask which rock to focus on
3. Identify next action for that rock
4. If content-related: Run `/brand-brent` to load persona
5. Begin work

**Choice 2 - Clear HubSpot tasks:**
1. Check if HubSpot is connected (INTEGRATION-SETUP.md)
2. If connected: Pull tasks via API, show list
3. If not connected: "HubSpot not set up yet. Want to connect it now?"

**Choice 3 - Write content:**
Ask: Article, LinkedIn post, or idea capture?
1. Run `/brand-brent` to load persona
2. Navigate to appropriate folder
3. Begin writing

**Choice 4 - Capture idea:**
Ask: "What's the idea?"
Create new file in `idea-stash/` with format:
```
# [Idea Title]

**Captured:** [TODAY_DATE]
**Series:** [if known]
**Status:** idea

## The Idea

[User's description]

## Notes

-
```

**Choice 5 - Update scorecard:**
1. Read current WEEKLY-SCORECARD.md
2. Ask for updates: "What numbers do you have?"
3. Update the file with new values
4. Show progress vs targets

**Choice 6 - Set up integrations:**
1. Read INTEGRATION-SETUP.md
2. Show which integrations are pending
3. Walk through setup one at a time
4. Start with easiest (Fireflies) or most valuable (HubSpot)

---

### Step 7: Update TODO File

After ANY changes:

1. Update "Last Reviewed" to TODAY_DATE
2. Update "Last Updated" if content changed
3. Keep table formatting intact
4. Commit changes if significant:
   ```bash
   cd /Users/brent/scripts/CB-Workspace/brent-workspace
   git add -A
   git commit -m "Update content TODO - [TODAY_DATE]"
   ```

---

## Day-of-Week Reminders

| Day | Reminder |
|-----|----------|
| Monday | Plan the week's content |
| Tuesday | Tuesdays with Claude article due |
| Wednesday | LinkedIn post day |
| Thursday | LinkedIn post day |
| Friday | Wrap up, capture weekend ideas |

---

## Content Series Quick Reference

### Tuesdays with Claude
- Weekly technical article about building with Claude Code
- Honest, shows real work including failures
- Interview/conversational format
- Save to: `Tuesdays with Claude/tuesdays-with-claude-[topic].md`

### LinkedIn Posts
- Professional, practical insights
- No markdown (plain text only)
- Hashtags at end
- Save to: `Tuesdays with Claude/social-posts/linkedin-post-[topic].md`

### LinkedIn Articles
- Longer form professional content
- Can include more depth than posts
- Save to: `LinkedIn Articles/[topic].md`

---

## Integration

- **Always load persona:** Run `/brand-brent` before writing content
- **Check terms:** Use terms checker API before publishing
- **Git commits:** Commit after significant writing sessions
