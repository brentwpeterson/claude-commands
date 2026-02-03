# LinkedIn Article Promotion Workflow

**Trigger:** When Brent announces "LinkedIn article is published" on Wednesday

---

## Overview

When the LinkedIn Newsletter publishes, create and schedule a 2-week promotion campaign across social platforms.

---

## Source Files

| Content Type | Location |
|--------------|----------|
| LinkedIn Newsletter articles | `Brent Notes/LinkedIn Articles/` |
| Article README (calendar) | `Brent Notes/LinkedIn Articles/README.md` |
| Current article | `Brent Notes/LinkedIn Articles/YYYY-MM-DD-topic-slug.md` |

---

## Vista Social Profile IDs

| Platform | ID | Name |
|----------|-----|------|
| LinkedIn Personal | 22469 | Brent W Peterson |
| X/Twitter | 23232 | Brent W. Peterson |
| Bluesky | 457112 | Brent W Peterson |
| Threads | 399179 | brentwpeterson |
| TikTok | 22468 | Brent W. Peterson |
| Instagram | 43335 | Brent W. Peterson |

---

## Posting Schedule (2 weeks)

| Platform | Total Posts | Days |
|----------|-------------|------|
| X | 5 | 1, 3, 6, 10, 14 |
| Bluesky | 6 | 1, 2, 5, 8, 11, 14 |
| Threads | 2 | 1, 7 |
| LinkedIn | 2 | 7, 14 (reminder posts with subscribe CTA) |

**Total: 15 posts over 14 days**

---

## Timing Rules

- Start at 9:00 AM EST
- Vary times so posts are not at the same time each day
- Suggested times: 9:00, 9:15, 9:30, 10:15, 10:45, 11:00, 11:30, 12:00, 2:00, 2:30 PM EST

---

## Content Strategy

### Pull from Article File
Read the Obsidian article file to extract:
- Key statistics (numbers grab attention)
- Memorable quotes
- Core concepts/frameworks
- Counterintuitive insights

### Post Variation
Each post should highlight a DIFFERENT angle:
1. Lead with a surprising statistic
2. Challenge a common assumption
3. Share a framework or list
4. Ask a provocative question
5. State a bold opinion

### LinkedIn Reminder Posts (Days 7 & 14)
- Summarize key takeaways
- Mention reader response/engagement
- Include subscribe CTA: "Subscribe for weekly ecommerce insights every Wednesday"

---

## Post Format

```
[Hook - surprising stat or bold claim]

[2-3 sentences of context or expansion]

[Key insight or takeaway]

[Article link]
```

**No hashtags on X, Bluesky, Threads** (except LinkedIn if relevant)

---

## API Call Template

```bash
curl -s -X POST "https://vistasocial.com/api/integration/posts?api_key=17f700ac80139410b11b0e2ca31c5e15" \
  -H "Content-Type: application/json" \
  -d '{
    "profile_id": [PROFILE_ID],
    "message": "POST_TEXT\n\nARTICLE_LINK",
    "publish_at": "YYYY-MM-DD HH:MM"
  }'
```

- Use `"publish_at": "now"` for immediate posting
- Use `"publish_at": "2026-01-22 11:00"` for scheduled (EST timezone)

---

## Workflow Steps

### When Brent says "article published":

1. **Get the article link** - Brent provides the LinkedIn pulse URL

2. **Read the Obsidian file** - Pull from `LinkedIn Articles/YYYY-MM-DD-*.md`

3. **Extract 6-8 unique hooks** from the article:
   - Statistics that surprise
   - Counterintuitive claims
   - Framework summaries
   - Bold opinions

4. **Create 15 posts** with different angles

5. **Schedule via Vista Social API**:
   - Day 1: X, Bluesky, Threads (immediate)
   - Days 2-14: Scheduled posts per the cadence above

6. **Confirm to Brent** with summary table of scheduled posts

---

## Example Hooks by Type

**Statistic Lead:**
> "Google processes 99,000 search queries per SECOND. 92% global market share. Yet everyone keeps writing 'Google is dead' articles."

**Challenge Assumption:**
> "70-80% of online shoppers ignore paid ads entirely. They trust earned visibility over bought visibility."

**Framework:**
> "A content supply chain has 4 components: 1. Consistent production 2. Quality control 3. Distribution 4. Measurement"

**Counterintuitive:**
> "Only 12% of URLs cited by AI rank in Google's top 10. Optimizing for Google does not automatically mean AI will cite you."

---

## Writing Rules

- No em dashes (use periods or commas)
- No emojis unless requested
- Short paragraphs (social format)
- End with article link on its own line

---

*Last Updated: 2026-01-21*
