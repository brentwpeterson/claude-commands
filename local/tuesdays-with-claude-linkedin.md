# Tuesdays with Claude - LinkedIn Post Process

## Schedule
**Every Tuesday** - Post to LinkedIn promoting the week's article

## Assets

### Thumbnail Image (1:1 for LinkedIn)
```
https://dc4ifv9abstiv.cloudfront.net/media/1ea8acf0-263f-11ee-8a13-97d069d939b8/695c212e3902c1f1a6ff6b47.png?v=1767645488227
```

### Vista Social Profile
- **LinkedIn (Brent):** 22469

## Article Location
```
/Users/brent/scripts/CB-Workspace/brent-workspace/ob-notes/Brent Notes/Tuesdays with Claude/
```

## Posting via Vista Social

### API Call Template
```bash
source /Users/brent/scripts/CB-Workspace/.claude/local/workspace.env

curl -s -X POST "https://vistasocial.com/api/integration/posts?api_key=$VISTA_SOCIAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "profile_id": [22469],
    "message": "[POST TEXT HERE]\n\n[ARTICLE LINK]\n\n#TuesdaysWithClaude #ClaudeCode #AI",
    "media_url": ["https://dc4ifv9abstiv.cloudfront.net/media/1ea8acf0-263f-11ee-8a13-97d069d939b8/695c212e3902c1f1a6ff6b47.png?v=1767645488227"],
    "publish_at": "now"
  }'
```

### Post Format
```
[Hook - 1-2 sentences from article that grab attention]

[Brief context - what happened/what was built]

[Key takeaway or lesson]

New Tuesdays with Claude: [Article Title]

[SUBSTACK LINK]

#TuesdaysWithClaude #ClaudeCode #AI
```

## Monday Prep Checklist
- [ ] Article written and ready in Obsidian
- [ ] Article published to Substack (get link)
- [ ] LinkedIn post drafted
- [ ] Post scheduled via Vista Social for Tuesday morning

## Notes
- Image is 1:1 aspect ratio (optimal for LinkedIn)
- Use `publish_at: "now"` for immediate or `"2026-01-07 09:00"` for scheduled (EST timezone)
- Article link needed before posting - usually Substack URL
