# Vista Social API Skill

**Purpose:** Post and schedule content to social media via Vista Social API.

**IMPORTANT:** This is the authoritative reference for Vista Social. Do NOT guess endpoints or parameters.

---

## API Configuration

| Setting | Value |
|---------|-------|
| **Base URL** | `https://vistasocial.com/api/integration` |
| **Auth** | Query param: `?api_key=KEY` |
| **API Key Location** | `source /Users/brent/scripts/CB-Workspace/.claude/local/workspace.env && echo $VISTA_SOCIAL_API_KEY` |

**NEVER use:**
- ~~api.vistasocial.com~~ (does not exist)
- ~~Authorization header~~ (use query param)
- ~~media_urls~~ (wrong parameter)
- ~~media~~ (wrong parameter)

---

## Profile IDs

| Platform | Profile Name | ID |
|----------|--------------|-----|
| X (Twitter) | Brent W. Peterson | 23232 |
| Bluesky | Brent W Peterson | 457112 |
| Threads | brentwpeterson | 399179 |
| LinkedIn | Brent W Peterson | 22469 |

---

## Create Post

**Endpoint:** `POST /posts`

```bash
curl -X POST "https://vistasocial.com/api/integration/posts?api_key=YOUR_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "profile_id": [23232],
    "message": "Your post text here",
    "publish_at": "now",
    "media_url": ["https://url-to-video-or-image.mp4"]
  }'
```

### Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `profile_id` | array | **Yes** | Array of profile IDs to post to |
| `message` | string | Yes* | Post text (*required if no media_url) |
| `publish_at` | string | **Yes** | `now`, `queue_next`, `queue_last`, ISO 8601 date (`2026-01-16 09:30`), or unix timestamp. **Timezone: ETC** |
| `media_url` | array | No | Array of media URLs (images/videos) |
| `comments` | array | No | Up to 10 comments (array of strings) |
| `draft` | boolean | No | Save as draft (`true`/`false`) |
| `like` | boolean | No | Like the post (`true`/`false`) |
| `labels` | array | No | Array of post labels |

---

## Schedule Post (Future)

Same endpoint, use ISO 8601 date for `publish_at`:

```bash
curl -X POST "https://vistasocial.com/api/integration/posts?api_key=YOUR_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "profile_id": [23232],
    "message": "Scheduled post",
    "publish_at": "2026-01-20 09:00",
    "media_url": ["https://url-to-video.mp4"],
    "comments": ["https://link-in-first-comment.com"]
  }'
```

---

## Post with Link in First Comment

To avoid algorithm suppression, put links in the first comment:

```bash
curl -X POST "https://vistasocial.com/api/integration/posts?api_key=YOUR_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "profile_id": [23232, 457112, 399179],
    "message": "Check out my latest article on ecommerce trends!",
    "publish_at": "2026-01-16 09:00",
    "comments": ["https://linkedin.com/pulse/your-article-link"]
  }'
```

---

## Complete Working Example

Post a joke video to X immediately:

```bash
# Get API key
source /Users/brent/scripts/CB-Workspace/.claude/local/workspace.env

# Post with video
curl -X POST "https://vistasocial.com/api/integration/posts?api_key=$VISTA_SOCIAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "profile_id": [23232],
    "message": "Dad joke of the day!\n\n#DadJokes #TalkCommerce",
    "publish_at": "now",
    "media_url": ["https://dc4ifv9abstiv.cloudfront.net/media/example-video.mp4"]
  }'
```

**Success Response:**
```json
{"id":["6968efcc3010840af9e028d9"]}
```

---

## Pre-Post Checklist

1. **Run `/brand-brent` terms checker** on all new content
2. **Check character limits:**
   - X: 280 characters
   - Bluesky: 300 characters
   - Threads: 500 characters
   - LinkedIn: 3000 characters
3. **Put links in `comments` array** (not in message body)
4. **Use `media_url` parameter** for videos/images (NOT `media` or `media_urls`)
5. **Include `publish_at`** - required even for immediate posts (use `"now"`)

---

## Troubleshooting

| Issue | Cause | Fix |
|-------|-------|-----|
| 404 error | Wrong base URL | Use `vistasocial.com/api/integration` |
| Invalid API key | Wrong auth method | Use `?api_key=` query param |
| Video not attaching | Wrong parameter | Use `media_url` (NOT `media` or `media_urls`) |
| Missing publish_at | Required parameter | Add `"publish_at": "now"` for immediate posts |
| HTML error page | Rate limited or server issue | Wait 1-2 minutes and retry |

---

## API Documentation

- **Official docs:** https://apidocs.vistasocial.com/
- **Create Post endpoint:** https://apidocs.vistasocial.com/#c1118d77-2965-4b3b-93c6-0c12acb4e577

**NOTE:** Docs are JS-rendered and cannot be scraped. If parameters change, manually check the docs above.

---

*Last updated: 2026-01-15 - Verified parameters from official docs: `media_url` (not media/media_urls), `publish_at` required*
