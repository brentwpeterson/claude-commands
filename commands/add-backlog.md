# Add Backlog Item

Add an item to the RequestDesk backlog system.

## Usage

```
/add-backlog <item description>
```

## Example

```
/add-backlog Create writing recipe section for templates and processes
```

## Instructions for Claude

### Step 1: Add to RequestDesk Backlog

Use the same agent API key as brand-brent (`MNRcaklW3XF7UpKX4VrxPV7wo2L7xsWg`):

```bash
curl -s -X POST "https://app.requestdesk.ai/api/backlog" \
  -H "Authorization: Bearer MNRcaklW3XF7UpKX4VrxPV7wo2L7xsWg" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "[ITEM DESCRIPTION]",
    "priority": 3,
    "category": "Backlog",
    "source": "claude"
  }' | jq .
```

**Replace `[ITEM DESCRIPTION]` with the user's backlog item text.**

### Step 2: Confirm

Report to user:
```
Added to backlog:
- ID: [returned id]
- Item: [description]
- Priority: 3 (default)
- Source: claude
- Status: backlog
```

## API Reference

| Field | Value |
|-------|-------|
| Endpoint | `https://app.requestdesk.ai/api/backlog` |
| Method | POST |
| Auth | `Authorization: Bearer {AGENT_API_KEY}` |

## Request Fields

| Field | Type | Default | Description |
|-------|------|---------|-------------|
| title | string | required | The backlog item description |
| priority | int | 3 | Priority 1-5 (1=highest) |
| category | string | "Backlog" | Item category |
| subcategory | string | null | Optional sub-grouping |
| estimated_points | int | null | Optional effort estimate |
| notes | string | null | Optional longer description |
| source | string | "claude" | Origin: claude, ui, import, api |

## Notes

- All items default to Priority 3 and status "backlog"
- Source is set to "claude" when added via this command
- Uses same agent API key as brand-brent command
- Items can be viewed/updated in RequestDesk admin UI
