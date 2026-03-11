# Get Fireflies - Sync Meeting Recordings

Download new Fireflies meeting summaries, write to Obsidian, update the index, and manage retention.

## Usage

```
/get-fireflies              # Full sync: fetch new, write files, update index
/get-fireflies new          # Only show what's new (no writes)
/get-fireflies actions      # Show open action items across all meetings
/get-fireflies archive      # Run 30-day retention: archive old, delete from Fireflies
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
