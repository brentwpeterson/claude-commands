# Add Backlog Item

Add an item to the Priority List Google Sheet backlog.

## Usage

```
/add-backlog <item description>
```

## Example

```
/add-backlog Create writing recipe section for templates and processes
```

## Instructions for Claude

### Step 1: Get Current Row Count

```bash
TOKEN=$(gcloud auth application-default print-access-token)

# Get last row with data
curl -s -H "Authorization: Bearer $TOKEN" \
  -H "x-goog-user-project: content-cucumber" \
  "https://sheets.googleapis.com/v4/spreadsheets/1yw2gUt-vHdQgDLHr3HVKf0IkPzLwgsDrnQURhy9vFBo/values/All%20Items%21A:A" | jq '.values | length'
```

### Step 2: Generate Next ID

- Count existing BK items or use next available number
- Format: `BK[N]` (e.g., BK7, BK8)

### Step 3: Add to Google Sheet

```bash
TOKEN=$(gcloud auth application-default print-access-token)

# Replace [ROW] with next row number, [ID] with next BK ID
curl -s -X PUT \
  -H "Authorization: Bearer $TOKEN" \
  -H "x-goog-user-project: content-cucumber" \
  -H "Content-Type: application/json" \
  "https://sheets.googleapis.com/v4/spreadsheets/1yw2gUt-vHdQgDLHr3HVKf0IkPzLwgsDrnQURhy9vFBo/values/All%20Items%21A[ROW]:H[ROW]?valueInputOption=RAW" \
  -d '{"values": [["[ID]", "[ITEM DESCRIPTION]", 3, null, "", "Backlog", "", ""]]}'
```

**IMPORTANT:** Use actual numbers, not strings:
- Priority: `3` not `"3"`
- Points: `2` not `"2"` (or `null` if empty)

**URL Encoding Required:**
- Space → `%20`
- `!` → `%21`

### Step 4: Confirm

Report to user:
```
✅ Added to backlog:
- ID: BK[N]
- Item: [description]
- Row: [row number]
- Sheet: https://docs.google.com/spreadsheets/d/1yw2gUt-vHdQgDLHr3HVKf0IkPzLwgsDrnQURhy9vFBo/edit?gid=651574547#gid=651574547
```

## Sheet Reference

| Field | Value |
|-------|-------|
| Sheet ID | `1yw2gUt-vHdQgDLHr3HVKf0IkPzLwgsDrnQURhy9vFBo` |
| Tab | All Items (gid=651574547) |
| Quota Project | content-cucumber |

## Column Structure

| Col | Field | Backlog Default |
|-----|-------|-----------------|
| A | ID | BK[N] |
| B | Item | [user input] |
| C | Priority | 3 |
| D | Est Points | (empty) |
| E | Frequency | (empty) |
| F | Category | Backlog |
| G | Subcategory | (empty) |
| H | SOP Status | (empty) |

## Notes

- All backlog items default to Priority 3 (P3)
- Category is always "Backlog"
- Items can be re-prioritized later in the sheet
- Local markdown file (`PRIORITY-LIST.md`) is NOT updated - Google Sheet is source of truth
