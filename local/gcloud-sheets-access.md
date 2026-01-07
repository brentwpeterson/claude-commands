# Google Sheets Access via gcloud CLI

**Last Updated:** 2026-01-05
**Tested and Working:** Yes

## Prerequisites

1. gcloud CLI authenticated: `gcloud auth list` should show `brent@contentbasis.io`
2. Application Default Credentials with quota project set

## One-Time Setup (Already Done)

```bash
# Set quota project for Sheets API access
gcloud auth application-default set-quota-project content-cucumber
```

## How to Read a Google Sheet

### Step 1: Get Access Token
```bash
gcloud auth application-default print-access-token
```

### Step 2: Fetch Sheet Data
```bash
# Get the token first (copy it)
TOKEN=$(gcloud auth application-default print-access-token)

# Then use it (paste the actual token, don't use $TOKEN in subshell)
curl -s -H "Authorization: Bearer PASTE_TOKEN_HERE" \
  -H "x-goog-user-project: content-cucumber" \
  "https://sheets.googleapis.com/v4/spreadsheets/SHEET_ID/values/A:Z"
```

**IMPORTANT:** The `$()` subshell syntax often fails in Claude's bash environment.
Always run `gcloud auth application-default print-access-token` first, copy the output,
then paste it directly into the curl command.

## Sheet IDs Reference

| Sheet | ID | Tab Name (gid) |
|-------|-----|----------------|
| Priority List | `1yw2gUt-vHdQgDLHr3HVKf0IkPzLwgsDrnQURhy9vFBo` | All Items (651574547) |
| Free Joke Project | `1JsuBHilQ0506K0yXNWbC1hrXOCX8rka_rdLIhZF5w2U` | |

## Priority List Columns (All Items tab)

| Col | Field |
|-----|-------|
| A | ID |
| B | Item |
| C | Priority (0/1/2/3) |
| D | Est Points |
| E | Frequency |
| F | Category |
| G | Subcategory |
| H | SOP Status |
| I | Property |
| J | Due Date |
| K | Status (dropdown) |

## Status Dropdown Values (Column K)

| Value | Use When |
|-------|----------|
| Not Started | Task not begun |
| In Progress | Actively working on |
| Ongoing | Continuous task (no end) |
| Recurring | Repeats on schedule |
| Complete | Task finished |

## Recurring Items Workflow

When completing a Recurring item:
1. **Mark current row Complete** - keeps history of completed work
2. **Add NEW row** with:
   - Same item details (ID, Item, Priority, Category, etc.)
   - New Due Date based on Frequency:
     - Weekly → +7 days
     - Bi-weekly → +14 days
     - Monthly → +30 days
   - Status = "Not Started"

This creates a paper trail of completed recurring tasks while scheduling the next occurrence.

## Common Errors

### 401 Unauthorized
- Token expired - get a new one with `gcloud auth application-default print-access-token`

### 403 Permission Denied / Quota Project Required
- Run: `gcloud auth application-default set-quota-project content-cucumber`

### Parse error near `(`
- Don't use `$(gcloud ...)` syntax
- Get token separately and paste it directly

## Full Working Example

```bash
# 1. Get token
gcloud auth application-default print-access-token
# Output: ya29.xxxxx...

# 2. Use token directly (paste the actual value)
curl -s -H "Authorization: Bearer ya29.xxxxx..." \
  -H "x-goog-user-project: content-cucumber" \
  "https://sheets.googleapis.com/v4/spreadsheets/1JsuBHilQ0506K0yXNWbC1hrXOCX8rka_rdLIhZF5w2U/values/A:Z" | jq '.'
```

## Writing to Sheets

**CRITICAL:** URL encode the `!` as `%21` when specifying sheet ranges.

```bash
# Example: Write to row 72 of "All Items" tab
curl -s -X PUT \
  -H "Authorization: Bearer TOKEN" \
  -H "x-goog-user-project: content-cucumber" \
  -H "Content-Type: application/json" \
  "https://sheets.googleapis.com/v4/spreadsheets/SHEET_ID/values/All%20Items%21A72:H72?valueInputOption=RAW" \
  -d '{"values": [["BK6", "Item description", "3", "", "", "Backlog", "", ""]]}'
```

**URL Encoding:**
- Space → `%20`
- `!` → `%21` (REQUIRED - do not use literal `!`)

### Priority List Add Example
```bash
TOKEN=$(gcloud auth application-default print-access-token)

curl -s -X PUT \
  -H "Authorization: Bearer $TOKEN" \
  -H "x-goog-user-project: content-cucumber" \
  -H "Content-Type: application/json" \
  "https://sheets.googleapis.com/v4/spreadsheets/1yw2gUt-vHdQgDLHr3HVKf0IkPzLwgsDrnQURhy9vFBo/values/All%20Items%21A[ROW]:H[ROW]?valueInputOption=RAW" \
  -d '{"values": [["ID", "Item", "Priority", "Points", "Frequency", "Category", "Subcategory", "SOP Status"]]}'
```
