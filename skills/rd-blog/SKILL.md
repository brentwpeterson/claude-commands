# RequestDesk Blog - Create Blog Posts from Terminal

**Skill Description:** Create and publish blog posts to requestdesk.ai/blog directly from the terminal using Claude.

## Quick Reference

| Item | Value |
|------|-------|
| **API Endpoint** | `https://app.requestdesk.ai/api/astro-proxy/blog-posts` |
| **Auth** | `Authorization: Bearer ZNgUN47QKeykN8voMmRbuyRT1G3edDxo` |
| **Agent ID** | `68dc1d940b0b937958668ed0` |
| **Blog URL** | `https://requestdesk.ai/blog/` |

---

## Usage

### Basic Usage

```
/rd-blog <title>
```

Claude will prompt for content interactively.

### With Arguments

```
/rd-blog "My Blog Post Title" --tags ai,automation --status draft
```

### Respond to Pitch Mode

```
/rd-blog --pitch <paste the pitch text here>
```

Use this when someone pitches you a service and you want to write a blog post positioning RequestDesk as already doing this (and doing it better).

### Technology Update Mode

```
/rd-blog --tech-update <brief description of the feature>
```

Use this to announce new technical features, capabilities, or improvements we've built. Great for:
- New integrations or platform capabilities
- Technical achievements worth sharing
- Architecture improvements that benefit users
- Features that demonstrate our technical depth

**Tone:** Excited but practical. Show what we built, why it matters, and how it helps users. Avoid hype, focus on real benefits.

### With Social Promotion

```
/rd-blog "My Blog Post Title" --social
/rd-blog --pitch <pitch text> --social
```

When `--social` is included, Claude will:
1. Create the blog post (Obsidian draft)
2. Generate platform-specific social posts for:
   - LinkedIn (22469)
   - X/Twitter (23232)
   - Bluesky (457112)
   - Threads (399179)
   - **Skip Instagram** (not ideal for blog promotion)
3. Include social posts in the Obsidian draft for review
4. After user approval, schedule via Vista Social API

Social posts are tailored per platform:
- LinkedIn: Professional, longer format, thought leadership angle
- X: Punchy, under 280 chars, hook-focused
- Bluesky: Conversational, similar to X but slightly longer
- Threads: List-style or quick takes work well

---

## Respond to Pitch Workflow

**Purpose:** Turn competitor/market pitches into blog content that positions RequestDesk.

**IMPORTANT:** The pitch is just a trigger. We DO NOT copy their content. We:
1. Identify the pain point/opportunity they're addressing
2. Write our OWN content in Brent's voice addressing the same opportunity
3. Load `/brand-brent` guidelines before writing
4. Run terms checker before publishing

### When to Use

- Someone pitches you a service on LinkedIn
- You see a competitor offering something you also do
- A prospect asks "do you do X?" and you want content around it

### Step 1: Analyze the Pitch

Claude should identify:

1. **Core service being pitched** - What are they actually offering?
2. **Pain point they're addressing** - What problem does this solve?
3. **Target audience** - Who is this for?

### Step 2: Categorize Against Our Services

Check if this maps to existing RequestDesk/sister company capabilities:

| Service Category | Company | Existing Page |
|-----------------|---------|---------------|
| AI Automation & Workflows | RequestDesk | /workflow-automations |
| AI Interfaces & Chat | RequestDesk | /ai-interfaces |
| AEO/GEO Optimization | RequestDesk | /aeo-geo-optimization |
| Human Content & QA | Content Cucumber | (external) |
| Custom AI Development | ContentBasis | (external) |
| E-commerce Integrations | RequestDesk | /integrations |

### Step 3: Determine Action

Ask user to confirm one of these paths:

**Option A: We Do This**
- Create blog post using the pitch's pain points as the hook
- Position our three-company solution as more complete
- Use "Obsidian Draft" workflow for review

**Option B: We Do This, But No Landing Page**
- Create blog post (same as Option A)
- Add backlog item for service landing page
- Tags: `landing-page`, `service`, relevant category

**Option C: We Don't Do This (Yet)**
- Discuss whether we should
- If yes: add to backlog as potential new service
- If no: skip or write a "why we don't do X" post

**Option D: We Don't Do This (And Shouldn't)**
- No action needed
- Optionally explain why this isn't in our wheelhouse

### Step 4: Create Content

**CRITICAL: DO NOT COPY THE PITCH**

The pitch is only a *trigger* to identify the market opportunity. We write our own content in Brent's voice.

**Before writing, load Brent's brand persona:**
```bash
curl -s -X POST "https://app.requestdesk.ai/api/agent/content" \
  -H "Authorization: Bearer MNRcaklW3XF7UpKX4VrxPV7wo2L7xsWg" \
  -H "Content-Type: application/json"
```

**What to extract from the pitch (concepts only):**
- The pain point they're addressing
- The target audience
- The general solution category

**What to write fresh in Brent's voice:**
- Our own hook addressing the same pain point
- Our perspective on why this matters
- How our solution is different/better
- Real talk, not marketing speak

**Content structure:**
1. **Open with the pain point** - Same problem, YOUR words
2. **Acknowledge the market shift** - This is real, it's happening
3. **Pivot to our differentiator** - "The problem isn't outsourcing. It's outsourcing to the wrong people."
4. **Show the full stack** - Content Cucumber (content) + RequestDesk (platform) + ContentBasis (development)
5. **Soft CTA** - "Outsource to people who understand content. That's us."

**CRITICAL: Never suggest "build in-house" or "don't outsource"**
Our entire business model is people outsourcing to us:
- Content Cucumber = outsourced content/editing
- ContentBasis = outsourced AI/dev work
- RequestDesk = platform they use (also outsourcing their workflow tooling)

**Voice checklist (Brent's style):**
- No em dashes (use periods or commas)
- No emojis
- Direct, practical tone
- Honest about limitations
- Light self-deprecating humor where appropriate
- Avoid AI buzzwords: "leverage", "game-changer", "deep dive", "actually"

**Before publishing, run terms checker:**
```bash
curl -X POST "https://app.requestdesk.ai/api/typingmind/proxy/terms-checker" \
  -H "Authorization: Bearer MNRcaklW3XF7UpKX4VrxPV7wo2L7xsWg" \
  -H "Content-Type: application/json" \
  -d '{"text": "[DRAFT CONTENT]", "include_global": true}'
```

### Step 5: Add Backlog Item (If Needed)

If a landing page is missing, add to backlog:

```bash
curl -s -X POST "https://app.requestdesk.ai/api/backlog" \
  -H "Authorization: Bearer MNRcaklW3XF7UpKX4VrxPV7wo2L7xsWg" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Create landing page: [SERVICE NAME]",
    "priority": 3,
    "category": "Content",
    "subcategory": "Landing Pages",
    "source": "claude",
    "tags": ["landing-page", "service", "astro-sites"],
    "notes": "Triggered by pitch response. Blog post created: [URL]",
    "reference_url": "[BLOG POST URL]"
  }'
```

### Example Conversation Flow

```
User: /rd-blog --pitch "We help agencies add AI automation using n8n and Zapier..."

Claude: I see this pitch is about AI automation for agencies. Let me categorize:

**Pain point identified:** Agencies need to add AI automation to stay competitive
**Target audience:** Digital agencies
**Service category:** AI Automation & Workflows

**We do this:** Yes
**Landing page exists:** Yes (/workflow-automations)

This maps to what we already offer through RequestDesk + ContentBasis.

How would you like to proceed?
1. Create blog post on this topic (Obsidian draft first)
2. Skip - we already have content on this
3. Just add a backlog item for follow-up

User: 1

Claude: Loading Brent's brand persona...
[Fetches brand guidelines]

Now I'll write a fresh post in your voice addressing this same opportunity.
I'll use the pain point (agencies feeling the AI shift) but write our own
take on it - not copy their pitch.

[Creates Obsidian draft in Brent's voice]
```

---

## Technology Update Workflow

**Purpose:** Announce new technical features and capabilities we've built.

### When to Use

- We shipped a new feature worth talking about
- We improved our architecture in a meaningful way
- We integrated something new (platform, API, technology)
- We solved a technical problem in an interesting way

### Content Structure

1. **Open with the problem/opportunity** - What challenge did we face or what opportunity did we see?
2. **Show what we built** - Explain the solution in practical terms
3. **Demonstrate the benefit** - How does this help users? Real examples.
4. **Technical depth (optional)** - For readers who want to understand the how
5. **What's next** - Brief mention of related improvements coming

### Tone Guidelines

- Excited but not hypey
- Technical but accessible
- Show, don't just tell
- Include real examples or screenshots if possible
- Honest about limitations or trade-offs

### Example Topics

- "We added JSON-LD structured data to all blog posts"
- "Our new Shopify sync pulls products in real-time"
- "How we built our SSR blog architecture"
- "New AI-powered content suggestions"

---

## Obsidian Draft Review Workflow

**Preferred workflow:** Create drafts in Obsidian for review before publishing to RequestDesk.

### Obsidian Draft Location

```
/Users/brent/scripts/CB-Workspace/brent-workspace/ob-notes/Brent Notes/Company Websites/RequestDesk/Blog Draft Review/
```

### Draft File Template

Create markdown files with this structure:

```markdown
# Post Title Here

**Status:** Draft
**Created:** YYYY-MM-DD
**Tags:** tag1, tag2, tag3
**Categories:** category1, category2
**Focus Keyphrase:** main keyword phrase

---

## Excerpt

Short summary for previews (1-2 sentences).

---

## Content

Main post content in markdown format...

---

## SEO

**SEO Title:** Title for search engines (under 60 chars)
**SEO Description:** Meta description (under 160 chars)

---

## Review Notes

- [ ] Review checklist item 1
- [ ] Review checklist item 2

## Social Posts (if --social flag used)

### LinkedIn (22469)
[LinkedIn version of the post - professional, longer]

### X/Twitter (23232)
[X version - punchy, under 280 chars]

### Bluesky (457112)
[Bluesky version - conversational]

### Threads (399179)
[Threads version - lists work well]
```

### Workflow Steps

1. **Create Obsidian Draft** - Save markdown file to Blog Draft Review folder
2. **User Reviews in Obsidian** - Make edits, check formatting, approve content
3. **Push to RequestDesk** - Convert markdown to HTML and publish via API
4. **Archive or Delete** - Move Obsidian file to completed folder or delete

---

## Direct Publish Workflow

When this skill is invoked, Claude should:

### Step 1: Gather Post Information

Ask the user for (if not provided):
1. **Title** (required) - The blog post title
2. **Content** (required) - The HTML content of the post
3. **Excerpt** (optional) - Short summary for previews
4. **Tags** (optional) - Comma-separated list
5. **Categories** (optional) - Comma-separated list
6. **Status** (optional) - `publish` (default), `draft`, or `pending`

### Step 2: Format Content

- If user provides markdown, convert to HTML
- Wrap paragraphs in `<p>` tags
- Use proper HTML headings (`<h2>`, `<h3>`, etc.)
- Format lists as `<ul>/<ol>` with `<li>` items

### Step 3: Create the Post (ALWAYS as draft)

Execute curl command with `"status": "draft"`:

```bash
curl -X POST "https://app.requestdesk.ai/api/astro-proxy/blog-posts" \
  -H "Authorization: Bearer ZNgUN47QKeykN8voMmRbuyRT1G3edDxo" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Post Title",
    "content": "<p>HTML content here</p>",
    "excerpt": "Short summary",
    "tags": ["tag1", "tag2"],
    "categories": ["category1"],
    "status": "draft"
  }'
```

**IMPORTANT:** Always use `"status": "draft"`. Never use `"status": "publish"`.

### Step 4: Confirm Success

Display:
- Draft URL: `https://app.requestdesk.ai/blog-posts/{id}/edit` (for editing)
- Post ID for reference
- Word count
- Remind user: "Draft created. Visit RequestDesk admin to review and publish when ready."

---

## API Reference

### POST /api/astro-proxy/blog-posts

**Headers:**
```
Authorization: Bearer ZNgUN47QKeykN8voMmRbuyRT1G3edDxo
Content-Type: application/json
```

**Request Body:**
```json
{
  "title": "string (required)",
  "content": "string (required) - HTML content",
  "excerpt": "string (optional)",
  "slug": "string (optional) - auto-generated from title if not provided",
  "status": "string (optional) - publish|draft|pending, default: publish",
  "tags": ["array", "of", "strings"],
  "categories": ["array", "of", "strings"],
  "featured_image": "string (optional) - URL to image",
  "seo_title": "string (optional)",
  "seo_description": "string (optional)",
  "focus_keyphrase": "string (optional)"
}
```

**Response (201 Created):**
```json
{
  "success": true,
  "message": "Blog post created successfully",
  "data": {
    "post": {
      "id": "mongodb_id",
      "postId": "post-abc123-1234567890",
      "title": "Post Title",
      "slug": "post-title",
      "status": "publish",
      "excerpt": "",
      "word_count": 150,
      "created_at": "2026-01-20T12:00:00",
      "url": "https://requestdesk.ai/blog/post-title"
    }
  }
}
```

---

## Image Upload

Upload images to use as featured images in blog posts.

### POST /api/astro-proxy/upload-image

**Headers:**
```
Authorization: Bearer ZNgUN47QKeykN8voMmRbuyRT1G3edDxo
Content-Type: multipart/form-data
```

**Request:**
- `image`: File upload (jpg, jpeg, png, gif, webp)
- Max size: 10MB

**Example:**
```bash
curl -X POST "https://app.requestdesk.ai/api/astro-proxy/upload-image" \
  -H "Authorization: Bearer ZNgUN47QKeykN8voMmRbuyRT1G3edDxo" \
  -F "image=@/path/to/image.png"
```

**Response:**
```json
{
  "success": true,
  "url": "https://cb-content-storage.s3.us-east-1.amazonaws.com/blog-images/.../image.png",
  "s3_key": "blog-images/agent-id/uuid.png",
  "filename": "image.png",
  "content_type": "image/png",
  "file_size": 123456
}
```

### Workflow with Image

1. **Upload image first:**
   ```bash
   IMAGE_URL=$(curl -s -X POST "https://app.requestdesk.ai/api/astro-proxy/upload-image" \
     -H "Authorization: Bearer ZNgUN47QKeykN8voMmRbuyRT1G3edDxo" \
     -F "image=@/path/to/image.png" | jq -r '.url')
   ```

2. **Create post with image:**
   ```bash
   curl -X POST "https://app.requestdesk.ai/api/astro-proxy/blog-posts" \
     -H "Authorization: Bearer ZNgUN47QKeykN8voMmRbuyRT1G3edDxo" \
     -H "Content-Type: application/json" \
     -d "{
       \"title\": \"Post with Image\",
       \"content\": \"<p>Content here</p>\",
       \"featured_image\": \"$IMAGE_URL\"
     }"
   ```

---

## Content Guidelines

### HTML Formatting

Posts should use proper HTML:

```html
<h2>Section Heading</h2>
<p>Paragraph content goes here. Keep paragraphs focused.</p>

<h3>Subsection</h3>
<p>More content with <strong>bold</strong> and <em>italic</em> text.</p>

<ul>
  <li>Bullet point one</li>
  <li>Bullet point two</li>
</ul>

<ol>
  <li>Numbered item one</li>
  <li>Numbered item two</li>
</ol>

<blockquote>
  <p>A quote or callout.</p>
</blockquote>

<pre><code>Code block content</code></pre>
```

### Writing Style (Brent's Voice)

When writing for Brent's blog:
- No em dashes. Use periods or commas instead.
- No emojis unless explicitly requested.
- Include "AI would object" elements (snarky asides, bold opinions).
- Avoid overused AI phrases: "actually", "leverage", "game-changer", "deep dive".

---

## Examples

### Create a Draft Post (Standard Workflow)

```bash
curl -X POST "https://app.requestdesk.ai/api/astro-proxy/blog-posts" \
  -H "Authorization: Bearer ZNgUN47QKeykN8voMmRbuyRT1G3edDxo" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Why AI Content Still Needs Human Editors",
    "content": "<h2>The Problem</h2><p>AI can write. But can it think?</p>",
    "excerpt": "A look at why human oversight matters in AI content.",
    "tags": ["ai", "content", "editing"],
    "status": "draft"
  }'
```

**Note:** Claude should ALWAYS use `"status": "draft"`. Human editor publishes from RequestDesk admin.

---

## Troubleshooting

### 403 Forbidden
- Agent doesn't have `requestdesk_blog_enabled` flag set
- Solution: Enable in agent settings at https://app.requestdesk.ai/agents/68dc1d940b0b937958668ed0/show

### 401 Unauthorized
- Invalid or missing API key
- Solution: Check the Authorization header

### Post Not Appearing on Blog
- Check post status is `publish` (not `draft`)
- Verify agent has `requestdesk_blog_enabled=True`
- Check post has `publish_to_requestdesk_blog=True` (automatic via this API)

---

## When Claude Should Apply This Skill

Apply this skill automatically when user:
- Says `/rd-blog` or mentions creating a blog post
- Asks to publish content to the RequestDesk blog
- Wants to add a post to requestdesk.ai/blog
- Mentions writing for the company blog
- **Uses `--pitch` argument** - Triggers "Respond to Pitch" workflow
- **Shares a pitch/offer they received** - Ask if they want to use the pitch workflow
- **Uses `--tech-update` argument** - Triggers "Technology Update" workflow for announcing new features
- **Uses `--social` argument** - Includes social media posts in Obsidian draft for review, then schedules via Vista Social after approval

### Default Behavior

**Always create Obsidian draft first, then push to RequestDesk as DRAFT (never publish).**

Claude should NEVER publish directly. The workflow is:
1. Create Obsidian draft for initial review
2. After user approval, push to RequestDesk with `"status": "draft"`
3. Human editor does final review in RequestDesk admin
4. Human editor clicks publish when ready

**Claude's role ends at draft.** Final publish is always done by a human.

Options to present:
1. **Obsidian Draft Only** - Create markdown in Blog Draft Review folder
2. **Obsidian + RequestDesk Draft (Recommended)** - Create Obsidian draft, then push to RequestDesk as draft for final editing

### Pitch Response Behavior

When user provides a pitch (via `--pitch` or by sharing pitch text):
1. Analyze and categorize the pitch
2. Check against existing services/landing pages
3. Ask user which action path to take
4. Create content and/or backlog items as needed

---

## Social Promotion Workflow (--social flag)

When `--social` is used, the Obsidian draft includes a **Social Posts** section with platform-specific copy.

### Platforms (skip Instagram for blog posts)

| Platform | Profile ID | Character Limit | Style |
|----------|------------|-----------------|-------|
| LinkedIn | 22469 | 3000 | Professional, thought leadership |
| X/Twitter | 23232 | 280 | Punchy hook, thread-friendly |
| Bluesky | 457112 | 300 | Conversational |
| Threads | 399179 | 500 | Lists, quick takes |

### Why Skip Instagram?

- Blog posts don't perform well on Instagram
- Requires image/video content
- Better suited for visual content, not article promotion

### Workflow After Approval

Once user approves the draft in Obsidian:

1. **Push to RequestDesk as draft** via `/rd-blog` API (status: draft)
2. **Human editor reviews and publishes** in RequestDesk admin
3. **After human publishes**, schedule social posts via Vista Social with blog URL in first comment:

**IMPORTANT:** Social posts should only go out AFTER the blog post is live. Claude creates the social copy in the Obsidian draft, but scheduling happens after human publishes the blog.

```bash
eval $(grep VISTA_SOCIAL_API_KEY /Users/brent/scripts/CB-Workspace/.claude/local/workspace.env)

curl -s -X POST "https://vistasocial.com/api/integration/posts?api_key=$VISTA_SOCIAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "profile_id": [22469, 23232, 457112, 399179],
    "message": "Social post text here",
    "publish_at": "now",
    "comments": ["https://requestdesk.ai/blog/post-slug"]
  }'
```

### Social Post Best Practices

- **Put blog link in first comment** (avoids algorithm suppression)
- **Stagger posting** if preferred (use `publish_at` with different times)
- **Run terms checker** on social copy too
- **Customize per platform** rather than cross-posting identical text

---

## Related

- **rd-astro-blog skill** - SSR architecture documentation for displaying posts
- **Vista Social skill** - `/Users/brent/scripts/CB-Workspace/.claude/skills/brent-workspace/vista-social.md`
- **Agent Settings** - https://app.requestdesk.ai/agents/68dc1d940b0b937958668ed0/show
- **Blog Index** - https://requestdesk.ai/blog/
- **Backlog API** - `/Users/brent/scripts/CB-Workspace/.claude/local/backlog-api-access.md`
- **Add Backlog Command** - `/add-backlog` for quick backlog items

## Company Positioning (CRITICAL for blog content)

**Our mission is to have people OUTSOURCE to us, not build in-house.**

Never write content that suggests people should build their own systems. We want them to use ours.

| Company | What They Outsource To Us | Message |
|---------|---------------------------|---------|
| **Content Cucumber** | Content creation, editing, QA | "Outsource your content to real writers and editors" |
| **ContentBasis** | AI automations, CMS development, custom integrations | "Outsource your AI and development work to specialists" |
| **RequestDesk** | Workflow automation tools | "Use our platform to automate your content workflows" |

### Correct Messaging

- "Don't build your own content team. Use Content Cucumber."
- "Don't hire developers to build AI automations. ContentBasis does that."
- "Don't cobble together Zapier workflows. RequestDesk has it built in."

### Incorrect Messaging (NEVER USE)

- "Build your content supply chain in-house"
- "You should think twice before outsourcing"
- "No one else can understand your content well enough"
- Anything that implies DIY is better than using our services

### The Real Distinction

The problem isn't outsourcing. It's outsourcing to the WRONG people:

| Wrong Choice | Right Choice |
|--------------|--------------|
| Generic automation consultant | ContentBasis (content-focused development) |
| Random freelance writers | Content Cucumber (specialized content team) |
| Cobbled-together Zapier/n8n | RequestDesk (purpose-built platform) |

---

## Service Landing Pages Reference

| Service | URL | Status |
|---------|-----|--------|
| Workflow Automations | /workflow-automations | Live |
| AI Interfaces | /ai-interfaces | Live |
| AEO/GEO Optimization | /aeo-geo-optimization | Live |
| Integrations | /integrations | Live |
| How It Works | /how-it-works | Live |
| Pricing | /pricing | Live |
