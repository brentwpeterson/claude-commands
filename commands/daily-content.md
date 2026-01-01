# Daily Content Planning - Brent's Writing Dashboard

Review and update your content TODO list for daily planning.

## Usage

```
/daily-content
```

## Instructions for Claude

When this command is run:

### Step 1: Read the TODO File

```bash
cat /Users/brent/scripts/CB-Workspace/brent-workspace/ob-notes/Brent\ Notes/Dashboard/CONTENT-TODO.md
```

### Step 2: Check Recent Activity

Look for any recent work in the writing folders:

```bash
# Check for recently modified content files
find /Users/brent/scripts/CB-Workspace/brent-workspace/ob-notes/Brent\ Notes -name "*.md" -mtime -7 -type f | head -20
```

### Step 3: Present Daily Dashboard

Format the output as:

```
## 📅 Daily Content Dashboard

**Date:** [Today's date]
**Last TODO Update:** [From file]

---

### 🔥 TODAY'S PRIORITIES

[List HIGH PRIORITY items from TODO]

1. **[Task]** - [Series] - [Status]
2. **[Task]** - [Series] - [Status]

---

### 📊 This Week's Progress

- Tuesdays with Claude: [status]
- LinkedIn Posts: [count this week]
- Ideas captured: [any new in idea-stash]

---

### 📝 Recent Activity (Last 7 Days)

[List recently modified files]

---

### 💡 What would you like to work on?

Options:
1. Work on highest priority item
2. Add new content task
3. Mark something complete
4. Review ideas backlog
5. Start fresh content piece
```

### Step 4: Handle User Response

**If user says "1" or wants to work on priority:**
- Load `/brand-brent` persona first
- Navigate to the relevant folder
- Start working on the task

**If user says "2" or wants to add a task:**
Ask for:
- Task description
- Series (Tuesdays with Claude / LinkedIn / Other)
- Priority (High / Medium / Backlog)
- Due date (optional)

Then update the CONTENT-TODO.md file.

**If user says "3" or wants to mark complete:**
- Show current HIGH PRIORITY tasks
- Ask which to mark complete
- Move to COMPLETED section with today's date
- Update weekly stats

**If user says "4" or wants to review backlog:**
- Show all items from IDEAS section
- Ask if any should be promoted to HIGH/MEDIUM

**If user says "5" or wants fresh content:**
- Ask what type (article, LinkedIn post, idea capture)
- Load `/brand-brent`
- Create new file in appropriate folder

### Step 5: Update TODO File

After any changes, update the CONTENT-TODO.md file:
- Update "Last Updated" date
- Update "Last Reviewed" date
- Modify appropriate sections
- Keep formatting consistent

## File Locations

| Content Type | Location |
|-------------|----------|
| TODO List | `brent-workspace/ob-notes/Brent Notes/Dashboard/CONTENT-TODO.md` |
| Tuesdays with Claude | `brent-workspace/ob-notes/Brent Notes/Tuesdays with Claude/` |
| LinkedIn Articles | `brent-workspace/ob-notes/Brent Notes/LinkedIn Articles/` |
| LinkedIn Posts | `brent-workspace/ob-notes/Brent Notes/Tuesdays with Claude/social-posts/` |
| Ideas | `brent-workspace/ob-notes/Brent Notes/idea-stash/` |
| Saved Prompts | `brent-workspace/ob-notes/Brent Notes/Saved Prompts/` |

## When to Use

- **Start of writing session** - Review what's on deck
- **After completing content** - Mark items complete, add new ones
- **When capturing ideas** - Add to backlog
- **Weekly review** - Check progress against goals

## Integration with Other Commands

- **After `/daily-content`** → Often followed by `/brand-brent` to load persona
- **When writing articles** → Use `Saved Prompts/` for templates
- **For Tuesdays with Claude** → Check `Tuesdays with Claude/README.md` for format guide
