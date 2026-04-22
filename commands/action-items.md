# Action Items - View, Add, and Update Non-Dev Tasks

Manage the persistent ACTION-ITEMS.md tracker in Obsidian.

## Usage

```
/action-items                    # Show all active items (numbered)
/action-items add <description>  # Add a new item
/action-items done <number>      # Mark item as completed
/action-items done 3,5,7         # Mark multiple items as completed
/action-items meeting <number>   # Add action items from a Fireflies meeting file
/action-items archive            # Quarterly archive of completed items
/action-items --help             # Show this help
```

## Arguments: $ARGUMENTS

## Constants

```
ACTION_FILE="/Users/brent/scripts/CB-Workspace/brent-workspace/ob-notes/Brent Notes/Dashboard/Daily/ACTION-ITEMS.md"
```

## Instructions for Claude

### --help Handler

If arguments contain `--help` or `-h`, show the USAGE section above and STOP.

---

### Subcommand: (none) - Show Active Items

**Default when no arguments or just `/action-items`.**

1. Read ACTION-ITEMS.md
2. Parse all `- [ ]` items from the `## Active` section
3. Number them sequentially (1, 2, 3...) regardless of which group they're in
4. Display:

```
## Active Action Items

### From: [Source] ([Date])
  1. [Item description]
  2. [Item description]

### From: [Source] ([Date])
  3. [Item description]
  4. [Item description]

Total: [X] active items | [Y] completed this quarter
```

**CRITICAL:** The numbers must be stable and sequential across all groups. These numbers are what the user references with `/action-items done 3`.

---

### Subcommand: `add <description>`

Add a new item to the Active section.

1. Parse the description from arguments (everything after `add`)
2. Determine the source:
   - If description contains `from:` prefix, use that as the source (e.g., `add from:Email to Isaac - Follow up on proposal`)
   - Otherwise, use `Ad-hoc ([today's date])` as the source
3. Read ACTION-ITEMS.md
4. If a group matching the source already exists in Active, append the item there
5. If no matching group, create a new group at the TOP of Active (newest first)
6. Write the item as `- [ ] [description]`
7. Use the Edit tool to add the item. Do NOT rewrite the entire file.
8. Confirm:

```
Added to Active:
  [X]. [description] (under: [source group])

Total active: [N]
```

**Examples:**
```
/action-items add Follow up with Electric Eye on audit
  -> Adds under "Ad-hoc (2026-03-12)"

/action-items add from:Leadership L10 (2026-03-12) - Review EOS accountability chart
  -> Adds under "From: Leadership L10 (2026-03-12)"

/action-items add from:Email - Reply to Guillermo about Slack invite
  -> Adds under "From: Email"
```

---

### Subcommand: `done <number>` or `done <number>,<number>,...`

Mark one or more items as completed.

1. Parse the number(s) from arguments
2. Read ACTION-ITEMS.md
3. Number all `- [ ]` items in Active sequentially (same numbering as the display command)
4. For each number provided:
   - Find the matching item
   - Remove it from the Active section
   - Add it to the Completed section under today's date header with `- [x]` prefix
   - Append the source group name in parentheses for context
5. If today's date header doesn't exist in Completed, create it
6. Use the Edit tool for each change
7. Confirm:

```
Completed:
  - [x] [item 1 description] (moved from: [source])
  - [x] [item 2 description] (moved from: [source])

Active remaining: [N] | Completed today: [M]
```

**Edge cases:**
- If number doesn't exist: `Item #[N] not found. You have [X] active items.`
- If item is already done: skip silently

---

### Subcommand: `meeting <path-or-number>`

Extract Brent's action items from a Fireflies meeting file and add them to Active.

1. **If argument is a number:** Look up the meeting by listing today's files in Fireflies current/:
   ```bash
   ls -t "/Users/brent/My Drive/Sales and Marketing/Fireflies/current/$(date +%Y-%m-%d)"*.md 2>/dev/null
   ```
   Use the number as index (1 = first/newest)

2. **If argument is a path:** Use it directly

3. Read the meeting file
4. Extract the meeting title from the `# ` header
5. Extract the meeting date from `**Date:**` line
6. Find the `**Brent Peterson**` section under `## Action Items`
7. Also check for `**Both**` or `**Team**` sections (include those too)
8. For each action item found, add to Active under a new group: `From: [Meeting Title] ([Date])`
9. Check if items already exist (fuzzy match first 40 chars) to avoid duplicates
10. Confirm:

```
Added [X] action items from: [Meeting Title] ([Date])

  [N]. [item 1]
  [N+1]. [item 2]
  ...

Total active: [Y]
```

If no Brent action items found: `No action items for Brent in [Meeting Title].`

---

### Subcommand: `archive`

Quarterly archive of completed items.

1. Read ACTION-ITEMS.md
2. Extract the entire `## Completed` section
3. Determine the current quarter (Q1=Jan-Mar, Q2=Apr-Jun, Q3=Jul-Sep, Q4=Oct-Dec)
4. Write completed items to archive file:
   ```
   ACTION-ITEMS-[Q]-[YEAR].md
   ```
   in the same directory. If archive file exists, append. If not, create with header.
5. Clear the Completed section in ACTION-ITEMS.md (leave the `## Completed` header)
6. Confirm:

```
Archived [X] completed items to ACTION-ITEMS-Q1-2026.md
Active items unchanged: [Y]
Completed section cleared.
```

---

## Notes

- This file lives in Obsidian so Brent can view it on his phone
- Dev/sprint work goes in the backlog API, NOT here
- This is for: meeting follow-ups, emails, content tasks, calls, event prep
- Items should include enough context to act on (who, what, when)
- The numbered list is the primary interface. Keep numbers stable within a session.
