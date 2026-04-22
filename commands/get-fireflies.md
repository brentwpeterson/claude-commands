# Get Fireflies - Sync Meeting Recordings

Download new Fireflies meeting summaries, write to Obsidian, update the index, and manage retention.

## Usage

```
/get-fireflies              # Full sync: fetch new, write files, update index
/get-fireflies new          # Only show what's new (no writes)
/get-fireflies actions      # Show open action items across all meetings
/get-fireflies archive      # Run 30-day retention: archive old, delete from Fireflies
/get-fireflies l10          # Pull latest L10 meeting, extract action items, push to Strety
/get-fireflies l10 dry      # Show L10 action items without pushing to Strety
/get-fireflies --help       # Show this help
```

## Arguments: $ARGUMENTS

## Instructions for Claude

### --help Handler

If arguments contain `--help` or `-h`, show the USAGE section above and STOP.

### Constants

```
FIREFLIES_DIR="/Users/brent/My Drive/Sales and Marketing/Fireflies"
CURRENT_DIR="$FIREFLIES_DIR/current"
ARCHIVE_DIR="$FIREFLIES_DIR/archived"
README="$FIREFLIES_DIR/README.md"
```

### Subcommand: `actions`

Scan all meeting files in `current/` for action items assigned to Brent.

```bash
CURRENT_DIR="/Users/brent/My Drive/Sales and Marketing/Fireflies/current"
for f in "$CURRENT_DIR"/*.md; do
  TITLE=$(head -1 "$f" | sed 's/^# //')
  DATE=$(grep "^\\*\\*Date:\\*\\*" "$f" | head -1 | sed 's/.*Date:\*\* //')
  # Extract Brent's action items section
  sed -n '/^\*\*Brent Peterson\*\*/,/^\*\*[A-Z]/p' "$f" | grep "^- "
done
```

**Display as:**

```
## Open Action Items (Brent Peterson)

### [Meeting Title] ([Date])
- [ ] Action item 1
- [ ] Action item 2

### [Meeting Title] ([Date])
- [ ] Action item 1
...

Total: [X] open action items across [Y] meetings
```

Group by meeting, newest first. Include ALL meetings in `current/` (these are <30 days old and presumably still actionable).

STOP after displaying.

---

### Subcommand: `new` (dry run)

Run Step 1 and Step 2 below but DO NOT write files or update the index. Just show what would be synced.

```
NEW MEETINGS (not yet saved):

| Date | Title | Participants | Duration | Fireflies ID |
|------|-------|-------------|----------|--------------|
| ... | ... | ... | ... | ... |

[X] new meetings found. Run /get-fireflies to sync.
```

STOP after displaying.

---

### Subcommand: `archive`

Run Step 5 (retention) only. STOP after completing.

---

### Subcommand: `l10` / `l10 dry`

Pull the most recent L10 meeting from Fireflies, extract action items by person, and push them as todos to Strety under the Leadership team.

**Step L10-1: Find the latest L10 meeting**

```
mcp__fireflies__fireflies_search_transcripts with keyword: "L10", limit: 5
```

Pick the most recent result. If the summary is null (still processing), try `mcp__fireflies__fireflies_get_transcript` and extract the summary from the full transcript JSON.

**Step L10-2: Get the summary and action items**

```
mcp__fireflies__fireflies_get_summary with transcript_id: "[ID]"
```

If summary is null, fall back to the full transcript:
```
mcp__fireflies__fireflies_get_transcript with transcript_id: "[ID]"
```
The transcript JSON has a `summary` field with `action_items` even when `get_summary` returns null. If the transcript is too large for direct output, read it from the saved file and extract the summary with:
```bash
python3 -c "
import json
with open('[saved-file-path]') as f:
    data = json.load(f)
s = data.get('summary', {})
print('ACTION_ITEMS:', s.get('action_items', 'None'))
print('OVERVIEW:', s.get('overview', 'None'))
print('BULLETS:', s.get('shorthand_bullet', 'None'))
"
```

**Step L10-3: Parse action items into structured todos**

From the `action_items` text, extract:
- **Person name** (appears as `**Person Name**` headers)
- **Action items** (bullet points under each person)
- **Timestamps** (in parentheses at end of each item)

Map each action item to a todo with:
- **title**: The action item text (first 80 chars, trim the timestamp)
- **description**: `L10 [YYYY-MM-DD]: [full action item text]`
- **assignee**: Match person name to Strety people (Brent, isaac, susan, david, vijay)
- **due_date**: Default to 7 days from today for urgent items, 14 days for others. Use judgment:
  - Items with explicit deadlines (e.g., "April 15 tax filing") get that date
  - Items with "tomorrow" or "next day" get tomorrow's date
  - Items with "two weeks" get 14 days out
  - Everything else defaults to 7 days out

**Step L10-4: Present for review**

Display the proposed todos in a table:

```
## L10 Action Items -> Strety Todos

Meeting: [Title] ([Date], [Duration] min)
Participants: [names]

| # | Todo | Assignee | Due |
|---|------|----------|-----|
| 1 | [title] | [name] | [date] |
| 2 | [title] | [name] | [date] |
...

Total: [X] todos ([Y] for Brent, [Z] for Isaac, etc.)

Push all to Strety? (y/n/edit)
- **y** - Push all todos as shown
- **n** - Cancel
- **edit** - Let me adjust before pushing
- **[numbers]** - Push only specific items (e.g., "1,3,5,7")
```

**If `l10 dry`:** Show the table and STOP. Do not push.

**Step L10-5: Push to Strety**

After user confirms, push each todo using `mcp__strety__strety_create_todo`:

```
mcp__strety__strety_create_todo with:
  title: "[todo title]"
  description: "[todo description]"
  due_date: "[YYYY-MM-DD]"
  assignee: "[person name]"
  team: "Leadership"
```

**Rate limiting:** Add a 0.5s delay between calls. If rate-limited, note which failed and report at the end.

**Step L10-6: Also save the meeting file (if not already synced)**

Run the standard meeting file write (Step 3 from the main sync) for this L10 meeting if it's not already in the README index. This ensures the meeting notes are saved locally even when using the `l10` subcommand directly.

**Step L10-7: Report**

```
## L10 Sync Complete

Meeting: [Title] ([Date])
Todos pushed to Strety: [X] ([Y] Brent, [Z] Isaac, etc.)
Meeting file: [saved/already existed]

Failed (retry manually):
- [any failures]
```

**Strety API Notes:**
- Strety requires `space_id` and `space_type` in attributes (not relationships) when creating todos
- The Leadership team ID can be found via the `/teams` endpoint (look for `leadership: true`)
- People IDs are resolved by name via `mcp__strety__strety_list_people`
- The MCP tool handles team resolution automatically with the `team` parameter

---

### Default: Full Sync (no arguments or empty)

Execute Steps 1-5 in order.

---

## Step 1: Get Known Meeting IDs

Read the README.md index to build a set of already-indexed Fireflies IDs.

```bash
README="/Users/brent/My Drive/Sales and Marketing/Fireflies/README.md"
# Extract all Fireflies IDs from the index table
grep -oE '01K[A-Z0-9]{22}' "$README" | sort -u
```

Store these as `KNOWN_IDS`.

---

## Step 2: Fetch Meeting List from Fireflies

```
mcp__fireflies__fireflies_list_transcripts with limit: 50
```

Compare each returned meeting's ID against `KNOWN_IDS`. Meetings NOT in KNOWN_IDS are **new**.

**If no new meetings:** Report "All meetings already synced. [X] total in index." and skip to Step 5.

**If new meetings found:** Display summary and proceed.

```
Found [X] new meetings to sync:

| Date | Title | Duration |
|------|-------|----------|
| ... | ... | ... |
```

---

## Step 3: Download Summaries and Write Files

For each new meeting, fetch the summary:

```
mcp__fireflies__fireflies_get_summary with transcript_id: "[ID]"
```

**Rate limit handling:** If you get a rate limit error, note which IDs failed and report them at the end. Do NOT retry in a loop. Just move on and report.

**Write each meeting file immediately after fetching** (do not batch in memory):

**Filename:** `YYYY-MM-DD-[title-kebab-case].md`
- Use the meeting date for the prefix
- Kebab-case the title, max 50 chars
- If duplicate filename exists, append `-2`, `-3`, etc.

**File format:**

```markdown
# [Meeting Title]

**Date:** [YYYY-MM-DD HH:MM]
**Duration:** [X] minutes
**Participants:** [Comma-separated names]
**Fireflies ID:** [ID]
**Downloaded:** [today's date]
**Delete from Fireflies after:** [date + 30 days]

## Summary

[Summary text from Fireflies, reformatted into bullet points if not already]

## Action Items

**[Person Name]**
- [Action item 1]
- [Action item 2]

**[Person Name]**
- [Action item 1]

## Keywords

[Keywords from Fireflies, comma-separated]
```

**Write the file using the Write tool.** Confirm each write.

---

## Step 4: Update README Index

After all files are written, update the README.md index table.

**Read the current README.** Find the index table (starts after `| Date | Title |` header).

**Add new rows** in date-descending order (newest at top, just after the header row). Each new row:

```
| [Date] | [Title] | [Participants] | [Duration] min | Saved | [Fireflies ID] |
```

**Use the Edit tool** to insert rows. Do NOT rewrite the entire file.

---

## Step 5: Retention Check (30-day archival)

Check each file in `current/` for the `Delete from Fireflies after:` date.

```bash
TODAY=$(date +%Y-%m-%d)
CURRENT_DIR="/Users/brent/My Drive/Sales and Marketing/Fireflies/current"

for f in "$CURRENT_DIR"/*.md; do
  DELETE_DATE=$(grep "Delete from Fireflies after:" "$f" | grep -oE '2[0-9]{3}-[0-9]{2}-[0-9]{2}')
  if [[ "$DELETE_DATE" < "$TODAY" || "$DELETE_DATE" == "$TODAY" ]]; then
    echo "READY TO ARCHIVE: $(basename "$f") (delete date: $DELETE_DATE)"
  fi
done
```

**For each file ready to archive:**

1. Show the list to Brent:
   ```
   ## Retention: Ready to Archive

   | File | Meeting Date | Delete Date |
   |------|-------------|-------------|
   | [filename] | [date] | [delete date] |

   These meetings are 30+ days old. Archive them? (y/n)
   ```

2. **If approved:**
   - Move file from `current/` to `archived/`
   - Delete from Fireflies: `mcp__fireflies__fireflies_delete_transcript with transcript_id: "[ID]"`
   - Update README index: change status from `Saved` to `Archived`
   - Rate limit: max 10 deletions per minute. If more than 10, batch and pause.

3. **If declined:** Skip, report "Retention deferred."

---

## Step 6: Final Report

```
## Fireflies Sync Complete

| Metric | Count |
|--------|-------|
| New meetings synced | [X] |
| Rate-limited (retry later) | [Y] |
| Archived (30-day retention) | [Z] |
| Total meetings in index | [W] |

Files written to: /Users/brent/My Drive/Sales and Marketing/Fireflies/current/
Index updated: /Users/brent/My Drive/Sales and Marketing/Fireflies/README.md
```

If any meetings were rate-limited, list their IDs:
```
Rate-limited meetings (retry with /get-fireflies):
- [ID] - [Title]
```
