# Vista Social API Reference

## IMPORTANT: Correct Parameter Names

| Correct | WRONG |
|---------|-------|
| `media_url` | ~~media_urls~~ |
| `publish_at` | ~~publish~~ |

**Tested and confirmed working 2026-01-05** - Video posts to X and Bluesky successful.

---

## Authentication

All requests require the `api_key` as a query parameter:

```
https://vistasocial.com/api/integration/posts?api_key=YOUR_API_KEY
```

API key location: `/Users/brent/scripts/CB-Workspace/.claude/local/workspace.env`

---

## Endpoints

### Get Profiles
```bash
curl -s "https://vistasocial.com/api/integration/profiles?api_key=API_KEY"
```

### Create Post
```bash
curl -s -X POST "https://vistasocial.com/api/integration/posts?api_key=API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"profile_id": [ID], "message": "TEXT", "publish": "now"}'
```

---

## Brent's Profile IDs

| Network | Profile ID | Name |
|---------|------------|------|
| LinkedIn | 22469 | Brent W Peterson |
| X (Twitter) | 23232 | Brent W. Peterson |
| Bluesky | 457112 | Brent W Peterson |
| TikTok | 22468 | Brent W. Peterson |
| Instagram | 43335 | Brent W. Peterson |
| Threads | 399179 | brentwpeterson |
| Reddit | 411053 | brentwpeterson |

### Other Key Profiles

| Network | Profile ID | Name |
|---------|------------|------|
| Bluesky | 466569 | Talk Commerce Weekly Podcast |
| LinkedIn | 22472 | Talk Commerce |
| LinkedIn | 69418 | ContentBasis LLC |
| LinkedIn | 531390 | Content Cucumber |

---

## Post Parameters

| Parameter | Description | Required |
|-----------|-------------|----------|
| `message` | Post message. Required if media_url not specified. | Conditional |
| `profile_id` | Array of profile IDs where post will be scheduled. | Yes |
| `publish_at` | When to publish (see options below). **EST timezone.** | Yes |
| `media_url` | Array of media URLs (images/videos). | No |
| `draft` | Save post as draft. Boolean (true/false). | No |
| `comments` | Up to 10 comments. Array of strings. | No |
| `like` | Auto-like the post. Boolean (true/false). | No |
| `labels` | Array of post labels. | No |

### publish_at Options

| Value | Description |
|-------|-------------|
| `now` | Publish immediately |
| `queue_next` | Add to front of queue |
| `queue_last` | Add to end of queue |
| `2025-02-08 09:30` | ISO 8601 date (**EST timezone**) |
| `1707396600` | Unix timestamp |

---

## Platform-Specific Parameters

### Facebook
| Parameter | Values |
|-----------|--------|
| `facebook_publish_as` | `REELS`, `STORY`, `VIDEO`, `IMAGE` |

### Instagram
| Parameter | Values |
|-----------|--------|
| `instagram_publish_as` | `REELS`, `STORY`, `FEED` |
| `instagram_collaborators` | Array of usernames (public profiles only) |

### Snapchat
| Parameter | Values |
|-----------|--------|
| `snapchat_publish_as` | `STORY`, `SAVED_STORY`, `SPOTLIGHT` |

### Pinterest
| Parameter | Description |
|-----------|-------------|
| `pinterest_board_name` | Name of the Pinterest board |
| `pinterest_section_name` | Name of the Pinterest board section |

### Reddit
| Parameter | Description |
|-----------|-------------|
| `subreddit_name` | Name of subreddit |

### YouTube
| Parameter | Description |
|-----------|-------------|
| `youtube_title` | Video title |
| `youtube_category` | Video category |
| `tags` | Array of video tags |

---

## Examples

### Post with Image to LinkedIn
```bash
curl -s -X POST "https://vistasocial.com/api/integration/posts?api_key=API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "profile_id": [22469],
    "message": "Check out this image!",
    "media_url": ["https://example.com/image.png"],
    "publish_at": "now"
  }'
```

### Post with Video to X
```bash
curl -s -X POST "https://vistasocial.com/api/integration/posts?api_key=API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "profile_id": [23232],
    "message": "Watch this video!",
    "media_url": ["https://example.com/video.mp4"],
    "publish_at": "now"
  }'
```

### Schedule Post for Later
```bash
curl -s -X POST "https://vistasocial.com/api/integration/posts?api_key=API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "profile_id": [22469],
    "message": "Scheduled post",
    "publish_at": "2026-01-10 09:00"
  }'
```

### Post to Multiple Profiles
```bash
curl -s -X POST "https://vistasocial.com/api/integration/posts?api_key=API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "profile_id": [22469, 23232, 457112],
    "message": "Cross-posting to LinkedIn, X, and Bluesky!",
    "publish_at": "now"
  }'
```

### Instagram Reel
```bash
curl -s -X POST "https://vistasocial.com/api/integration/posts?api_key=API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "profile_id": [43335],
    "message": "New reel!",
    "media_url": ["https://example.com/video.mp4"],
    "instagram_publish_as": "REELS",
    "publish_at": "now"
  }'
```

---

## Response

Successful post returns array of post IDs:
```json
{
  "id": ["695c24113902c1f1a6ffcbdd"]
}
```

Error response:
```json
{
  "error": "Error message here"
}
```

---

## Asset Tracking

Media URLs are tracked in: `.claude/local/vista-social-assets.csv`

Format: `date,series,title,description,media_url,posted_to,notes`
