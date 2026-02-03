# Vista Social API Skill

**Purpose:** Post and schedule content to social media via Vista Social API.

**IMPORTANT:** This is the authoritative reference for Vista Social. Do NOT guess endpoints or parameters.

---

## API Configuration

| Setting | Value |
|---------|-------|
| **Base URL** | `https://vistasocial.com/api/integration` |
| **Auth** | Query param: `?api_key=KEY` |
| **API Key Location** | `eval $(grep VISTA_SOCIAL_API_KEY /Users/brent/scripts/CB-Workspace/.claude/local/workspace.env) && echo $VISTA_SOCIAL_API_KEY` |

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
| LinkedIn | 🏃 Brent W Peterson | 22469 |
| Instagram | Brent W. Peterson | 43335 |
| TikTok | Brent W. Peterson | 22468 |
| Reddit | brentwpeterson | 411053 |

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
| `publish_at` | string | **Yes** | `now`, `queue_next`, `queue_available`, `queue_last`, ISO 8601 date with timezone offset (`2026-01-16T09:30:00-05:00`), or unix timestamp. **If using a date, MUST include timezone offset. See Timezone section below.** |
| `media_url` | array | No | Array of media URLs (images/videos) |
| `comments` | array | No | Up to 10 comments (array of strings) |
| `draft` | boolean | No | Save as draft (`true`/`false`) |
| `like` | boolean | No | Like the post (`true`/`false`) |
| `labels` | array | No | Array of post labels |

---

## Timezone Handling (CRITICAL)

**Vista Social interprets `publish_at` as UTC if no timezone offset is provided.**

**ALWAYS include the timezone offset in ISO 8601 format:**
- EST: `-05:00`
- CST: `-06:00`
- HST: `-10:00`

**To get the correct offset from the system:**
```bash
# Get current UTC offset
date "+%z"   # Returns e.g. -1000 for HST, -0600 for CST

# Format for ISO 8601 (insert colon): -1000 becomes -10:00
TZ_OFFSET=$(date "+%z" | sed 's/\(..\)$/:\1/')
```

**Brent's audience is US-based. Target posting time: 7:00-9:00 AM EST (-05:00).**

**NEVER submit `publish_at` without a timezone offset. NEVER.**

## Queue Options

Vista Social has a publishing queue per profile. Queue slots are configured in the Vista Social UI under **Publishing Queues**. Each profile has its own queue with time slots and can be filtered by **queue labels**.

| Option | Behavior |
|--------|----------|
| `queue_next` | Front of the queue. Next available slot. |
| `queue_available` | Finds the next OPEN slot (skips slots that already have a post). **PREFERRED for campaigns.** |
| `queue_last` | End of the queue. Last available slot. |

**`queue_available` is the best option for campaigns.** It respects the queue schedule you've set up in Vista Social (posting times, days) and finds open slots automatically. No need to calculate times or worry about timezone offsets.

**Queue labels:** The "based on" dropdown in the UI filters which queue label to place the post in. The API `labels` parameter may interact with this. Test before relying on it for label-specific queuing.

```bash
# Add to next open queue slot (recommended for campaigns)
curl -s -X POST "https://vistasocial.com/api/integration/posts?api_key=YOUR_KEY" \
  -H "Content-Type: application/json" \
  -d '{"profile_id": [457112], "message": "Your post", "publish_at": "queue_available"}'
```

**When to use queue vs specific date:**
- **`queue_available`**: Campaign posts where you want Vista Social to handle timing. Respects your queue schedule.
- **Specific date**: One-off posts that must go out at an exact time (event announcements, time-sensitive content).
- **`now`**: Immediate posting.

---

## Schedule Post (Future)

Same endpoint, use ISO 8601 date WITH timezone offset for `publish_at`:

```bash
curl -X POST "https://vistasocial.com/api/integration/posts?api_key=YOUR_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "profile_id": [23232],
    "message": "Scheduled post",
    "publish_at": "2026-01-20T09:00:00-05:00",
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

## Posting with Local Images (Claude CLI)

Vista Social requires publicly accessible URLs for images. To post local images from Claude CLI, use the RequestDesk file upload endpoint.

### Step 1: Upload Image to S3

```bash
curl -s -X POST "https://app.requestdesk.ai/api/files/upload" \
  -H "Authorization: Bearer AGENT_API_KEY" \
  -F "file=@/path/to/your/image.jpg" \
  -F "file_category=social_media" \
  -F "description=Brief description"
```

**Response:**
```json
{
  "status": "success",
  "file_id": "fc2ec4ea-ff9c-43f8-abed-5d0f8f0ff2ff",
  "url": "https://cb-content-storage.s3.us-east-1.amazonaws.com/social-media/2026/01/fc2ec4ea-ff9c-43f8-abed-5d0f8f0ff2ff.jpg",
  "file_category": "social_media",
  "original_filename": "image.jpg",
  "file_size": 3131571,
  "content_type": "image/jpeg",
  "document_type": "image"
}
```

### Step 2: Post to Vista Social with S3 URL

Use the `url` from Step 1 in the `media_url` parameter:

```bash
eval $(grep VISTA_SOCIAL_API_KEY /Users/brent/scripts/CB-Workspace/.claude/local/workspace.env)

curl -s -X POST "https://vistasocial.com/api/integration/posts?api_key=$VISTA_SOCIAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "profile_id": [23232],
    "message": "Your post text here",
    "publish_at": "now",
    "media_url": ["https://cb-content-storage.s3.us-east-1.amazonaws.com/social-media/2026/01/YOUR-FILE-ID.jpg"],
    "comments": ["https://optional-link-in-first-comment.com"]
  }'
```

### Complete Example: MiMS Fundraising Post

Full workflow posting a local photo to X with a fundraising link:

```bash
# Step 1: Upload local image
curl -s -X POST "https://app.requestdesk.ai/api/files/upload" \
  -H "Authorization: Bearer wO1lEF5NC3BuCtQSHB5JSFXxTWfw5iwdyTruIEA0Quc" \
  -F "file=@/Users/brent/Desktop/IMG_0024.JPG" \
  -F "file_category=social_media" \
  -F "description=MiMS fundraising Finn Hawaii"

# Response includes: "url": "https://cb-content-storage.s3.us-east-1.amazonaws.com/social-media/2026/01/fc2ec4ea-ff9c-43f8-abed-5d0f8f0ff2ff.jpg"

# Step 2: Post to X with image and link in comment
eval $(grep VISTA_SOCIAL_API_KEY /Users/brent/scripts/CB-Workspace/.claude/local/workspace.env)

curl -s -X POST "https://vistasocial.com/api/integration/posts?api_key=$VISTA_SOCIAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "profile_id": [23232],
    "message": "Sunset runs with Finn in Hawaii. Running has given me so much. That is why I am raising money for @MileInMyShoes. They help people in recovery discover they can do hard things, one mile at a time.",
    "publish_at": "now",
    "media_url": ["https://cb-content-storage.s3.us-east-1.amazonaws.com/social-media/2026/01/fc2ec4ea-ff9c-43f8-abed-5d0f8f0ff2ff.jpg"],
    "comments": ["https://secure.givelively.org/donate/mile-in-my-shoes/2026-grandma-s-fundracing-team-for-mile-in-my-shoes/brent-peterson-2"]
  }'
```

### File Upload API Reference

| Setting | Value |
|---------|-------|
| **Endpoint** | `POST https://app.requestdesk.ai/api/files/upload` |
| **Auth** | `Authorization: Bearer AGENT_API_KEY` |
| **Agent API Key** | Use brand-brent agent key (same as /api/backlog) |
| **Content-Type** | `multipart/form-data` |

**Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `file` | File | Yes | Image file (jpg, jpeg, png, gif, webp) |
| `file_category` | string | No | `social_media`, `post_image`, `document`, `general` |
| `description` | string | No | Brief description for reference |
| `reference_id` | string | No | Optional ID to link to (campaign_id, etc.) |

**Supported formats:** jpg, jpeg, png, gif, webp (max 10MB for images)

---

## Complete Working Example

Post a joke video to X immediately:

```bash
# Get API key
eval $(grep VISTA_SOCIAL_API_KEY /Users/brent/scripts/CB-Workspace/.claude/local/workspace.env)

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

## Success Log

### 2026-01-23: LinkedIn Post - Shopify Partner Cuts

**Post ID:** `69728076346c3e373feb04c3`
**Profile:** LinkedIn (22469)
**Image:** Uploaded to S3 via `/api/files/upload`

**Workflow:**
1. Drafted post in `/brent-workspace/ob-notes/Brent Notes/LinkedIn Content/Social Posts/2026-01-23-shopify-partner-cuts.md`
2. Ran `/check-terms` - caught 3 violations (significant, align, capture)
3. Fixed violations + added personal spin
4. Uploaded image to S3: `https://cb-content-storage.s3.us-east-1.amazonaws.com/social-media/2026/01/8dcb2ae6-04d2-4aea-beef-f4bdc9977a55.png`
5. Posted via Vista Social API
6. Confirmed live on LinkedIn

**Key learnings:**
- Use `eval $(grep VISTA_SOCIAL_API_KEY ...)` not `source` for API key
- Always run `/check-terms` before posting
- Image must be uploaded to S3 first (Vista Social needs public URL)
- Draft folder: `LinkedIn Content/Social Posts/YYYY-MM-DD-topic.md`
- Assets folder: `LinkedIn Content/Assets/`

---

*Last updated: 2026-02-01 - CRITICAL: Fixed timezone documentation. publish_at MUST include timezone offset (e.g., -05:00). Without it, Vista Social treats time as UTC. Added Timezone Handling section.*
