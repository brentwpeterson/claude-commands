# Content Schedule

## CRITICAL: Two Separate Weekly Articles

**Tuesdays with Claude and LinkedIn Newsletter are COMPLETELY DIFFERENT content pieces.**

| Content | Platform | Publish Day | Type |
|---------|----------|-------------|------|
| **Tuesdays with Claude** | Medium | Tuesday | Technical article - AI/Claude adventures |
| **LinkedIn Newsletter** | LinkedIn | Wednesday | Professional insights - industry topics |

These are NOT related. They have different audiences, different tones, and different topics.

---

## Weekly Content Rhythm

| Day | Written Content | Media | Notes |
|-----|-----------------|-------|-------|
| **Monday** | Finish LinkedIn Newsletter | - | Newsletter publishes Wednesday |
| **Tuesday** | Tuesdays with Claude publishes | - | Should be done Friday before |
| **Wednesday** | LinkedIn Newsletter publishes | - | Rock work after publish |
| **Thursday** | Rock work | **Content in Commerce** (bi-weekly, noon) | |
| **Friday** | Write NEXT Tuesday's article | - | Get ahead for next week |
| Flexible | - | Talk Commerce recording | |
| Flexible | - | EO Visionary Voices recording | |

---

## Lead Time Strategy

**Goal:** Never scramble day-of. Always be ahead.

| Content | Ideal Timeline | Deadline |
|---------|----------------|----------|
| Tuesdays with Claude | Write Friday before | Publish Tuesday |
| LinkedIn Newsletter | Write/finish Monday | Publish Wednesday |
| Quarter topics | Plan entire quarter | Have all 13 weeks outlined |

### Why Lead Time Matters

- **Tuesdays with Claude done Friday:** No Monday panic, time for edits
- **LinkedIn Newsletter done Monday:** Publishes Wednesday, buffer for review
- **Quarter planned:** Know what you're writing weeks in advance

---

## Media Properties

See `media-properties.md` for full details.

| Property | Type | Frequency | Brent's Role |
|----------|------|-----------|--------------|
| **Talk Commerce** | Podcast | Weekly | Record only (Susan handles rest) |
| **EO Visionary Voices** | Podcast | Weekly | Record + book guests |
| **Content in Commerce** | LinkedIn Live | Bi-weekly Thu noon | Host + book guests |

---

## Content Series Details

### Tuesdays with Claude
- **Platform:** Medium
- **Frequency:** Weekly (Tuesday publish)
- **Format:** Technical article, interview/conversational style
- **Tone:** Honest, shows real work including failures
- **Length:** 1500-2500 words
- **Save to:** `Tuesdays with Claude/tuesdays-with-claude-[topic].md`
- **Before writing:** Run `/brand-brent` for voice

### LinkedIn Newsletter
- **Platform:** LinkedIn
- **Frequency:** Weekly (Wednesday publish)
- **Format:** Professional insights article
- **Tone:** Thought leadership, industry perspective
- **Length:** 800-1500 words
- **Save to:** `LinkedIn Articles/[topic].md`
- **Before writing:** Run `/brand-brent` for voice

### LinkedIn Posts (Derivative)
- **Frequency:** 2-3 per week (derived from articles)
- **Format:** Plain text (no markdown)
- **Tone:** Professional, practical insights
- **Length:** 150-300 words
- **Hashtags:** At end, relevant to topic
- **Save to:** `Tuesdays with Claude/social-posts/linkedin-post-[topic].md`

---

## Content Creation Process

1. **Load voice:** Run `/brand-brent`
2. **Check ideas:** Review `idea-stash/` for topics
3. **Write draft:** Create in appropriate folder
4. **Check terms:** Use terms checker API
5. **Publish:** Schedule or post directly

---

## Social Post Scheduling (Vista Social)

### Pre-Publish Checklist
1. **ALWAYS run `/brand-brent` terms checker** on ALL new post content
2. Check character limits (X: 280, Bluesky: 300, Threads: 500, LinkedIn: 3000)
3. Put links in first comment, not main post (avoids algorithm suppression)

### Vista Social API
- **Base URL:** `https://vistasocial.com/api/integration`
- **Auth:** Query param `?api_key=xxx`
- **First comment:** Use `comments` array parameter

### Profile IDs
| Platform | Profile | ID |
|----------|---------|-----|
| X | Brent W. Peterson | 23232 |
| Bluesky | Brent W Peterson | 457112 |
| Threads | brentwpeterson | 399179 |
| LinkedIn | Brent W Peterson | 22469 |

### Post Scheduling Example
```bash
curl -X POST "https://vistasocial.com/api/integration/posts?api_key=KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "profile_id": [23232],
    "message": "Post content here",
    "publish_at": "2026-01-16 09:00",
    "comments": ["https://link-in-first-comment.com"]
  }'
```

---

## Metrics (Weekly Scorecard)

| Metric | Target | Where Tracked |
|--------|--------|---------------|
| Tuesdays with Claude | 1/week | WEEKLY-SCORECARD.md |
| LinkedIn Newsletter | 1/week | WEEKLY-SCORECARD.md |
| LinkedIn posts | 2-3/week | WEEKLY-SCORECARD.md |

---

## Content Non-Negotiables

- **Tuesday:** Tuesdays with Claude MUST publish
- **Wednesday:** LinkedIn Newsletter MUST publish
- **Friday:** At least one LinkedIn post for the week
- If behind: Use catch-up time, but don't skip

---

## Idea Capture

When ideas come up during the day:
```
Create file in: idea-stash/[topic].md

# [Idea Title]

**Captured:** [DATE]
**Series:** Tuesdays with Claude / LinkedIn Newsletter / Post / Other
**Status:** idea

## The Idea

[Description]

## Notes

-
```

Ideas are NOT commitments. Review weekly during Monday planning.
