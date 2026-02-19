# Brent News - Intelligence Briefing System

Stay ahead of ecommerce and AI stories as "the agentic commerce guy."

## Usage

```
/brent-news              Full briefing (default)
/brent-news quick        Headlines only
/brent-news deep         Full briefing with content angles
/brent-news sources      List feed sources and status
/brent-news starred      Show starred items
/brent-news --help       Show this help
```

## Instructions for Claude

### --help Handler

If the argument is `--help` or `-h`, show the Usage section above and STOP. Do not execute any API calls.

### Step 1: Determine Subcommand

Parse `$ARGUMENTS` to determine mode:
- Empty or no args: **full** briefing
- `quick`: headlines only
- `deep`: full briefing with content angles
- `sources`: list feed sources
- `starred`: show starred items
- Unknown subcommand: show "Unknown subcommand: [X]. Run /brent-news --help for available commands." and STOP.

### Step 2: Execute Based on Mode

#### Mode: sources

List all feed sources and their status:

```bash
curl -s --max-time 30 "https://app.requestdesk.ai/api/feed-aggregator/sources" \
  -H "Authorization: Bearer MNRcaklW3XF7UpKX4VrxPV7wo2L7xsWg" | jq .
```

Present as a table:

```
| Source | Type | Categories | Last Fetched | Errors |
|--------|------|------------|--------------|--------|
```

Report total sources, enabled count, and any sources with consecutive_failures > 0.

#### Mode: starred

Show starred items:

```bash
curl -s --max-time 30 "https://app.requestdesk.ai/api/feed-aggregator/items?is_starred=true&limit=50" \
  -H "Authorization: Bearer MNRcaklW3XF7UpKX4VrxPV7wo2L7xsWg" | jq .
```

Present starred items grouped by category.

#### Mode: full (default)

Fetch the briefing:

```bash
curl -s --max-time 30 "https://app.requestdesk.ai/api/feed-aggregator/briefing" \
  -H "Authorization: Bearer MNRcaklW3XF7UpKX4VrxPV7wo2L7xsWg" | jq .
```

Present briefing using this format:

```
## News Briefing - [Date]

**[Total] new items across [N] categories**

### [Category Name] ([count] items)

**[Title]** - [Feed Name]
[Excerpt, first 100 chars]
[URL]
[If relevance_score exists: Score: X.XX | Angles: angle1, angle2]

---
```

Group items by category. Within each category, sort by:
1. Items with relevance_score (highest first) if scoring data exists
2. Then by published_at (newest first)

Present high-relevance items (score >= 0.7) first in a "Top Stories" section if scoring data is available.

After presenting, mark all items as briefed:

```bash
curl -s --max-time 30 -X POST "https://app.requestdesk.ai/api/feed-aggregator/briefing/mark-briefed" \
  -H "Authorization: Bearer MNRcaklW3XF7UpKX4VrxPV7wo2L7xsWg" \
  -H "Content-Type: application/json" \
  -d '{"item_ids": ["ITEM_ID_1", "ITEM_ID_2"]}' | jq .
```

#### Mode: quick

Same as full, but only show:
```
- **[Title]** ([Feed Name]) [URL]
```

No excerpts, no scores, no angles. Just headlines. Still mark as briefed.

#### Mode: deep

Same as full, plus for each item:
- If `content_angles` exist, show them prominently
- If `ai_summary` exists, show it instead of excerpt
- If no scoring data, generate content angles inline:
  - "Agentic commerce" angle (how does this relate to AI agents in commerce?)
  - Newsletter angle (would this work for The Agentic Commerce Guy?)
  - LinkedIn angle (is there a take for a LinkedIn post?)

Present with this enhanced format:

```
### [Category Name]

**[Title]** - [Feed Name]
Score: [X.XX] | Published: [date]

Summary: [ai_summary or excerpt]

Content Angles:
- [angle 1]
- [angle 2]

[URL]
```

### Step 3: Briefing Summary

After presenting items (for full, quick, or deep modes), show:

```
---
Briefed [N] items. [M] marked as briefed.
Next poll: items will refresh based on feed poll intervals (60-180 min).
```

## API Reference

| Field | Value |
|-------|-------|
| Briefing | `GET https://app.requestdesk.ai/api/feed-aggregator/briefing` |
| Mark Briefed | `POST https://app.requestdesk.ai/api/feed-aggregator/briefing/mark-briefed` |
| Sources | `GET https://app.requestdesk.ai/api/feed-aggregator/sources` |
| Items | `GET https://app.requestdesk.ai/api/feed-aggregator/items` |
| Auth | `Authorization: Bearer MNRcaklW3XF7UpKX4VrxPV7wo2L7xsWg` |

## Notes

- No emojis in output (per Brent's writing style rules)
- No em dashes in output
- The briefing endpoint returns unbriefed items grouped by category
- Marking as briefed prevents items from showing up in future briefings
- Sources are polled automatically by the FeedAggregatorJob (configurable interval)
- Deep mode content angles are about Brent's positioning as "the agentic commerce guy"
