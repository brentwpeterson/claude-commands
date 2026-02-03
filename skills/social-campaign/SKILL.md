# Social Campaign Planner - Plan, Draft, Review, and Schedule Multi-Platform Campaigns

**Skill Description:** Plan and execute social media drip campaigns across LinkedIn, X, Bluesky, and Threads with complexity-based scoping and full Vista Social scheduling.

## CRITICAL RESOURCES

| Resource | Location |
|----------|----------|
| **Vista Social Skill** | `.claude/skills/brent-workspace/vista-social.md` |
| **Create Social Command** | `.claude/commands/create-social.md` |
| **Brand Persona API** | `POST https://app.requestdesk.ai/api/agent/content` |
| **Campaign Home** | `ob-notes/Brent Notes/Sales and Marketing/campaigns/` |
| **Active Campaigns Dashboard** | `ob-notes/Brent Notes/Sales and Marketing/ACTIVE-CAMPAIGNS.md` |
| **Blog Post API** | `POST https://app.requestdesk.ai/api/astro-proxy/blog-posts` (see `/rd-blog`) |
| **Brand Voice (Brent)** | No em dashes, no emojis unless asked, periods and commas only |

---

## Campaign Complexity Levels

**FIRST QUESTION: Ask Brent which level this campaign is.**

### Level 1: Awareness (Simplest)

Informational content. No hard CTA. Goal is visibility and thought leadership.

| Parameter | Value |
|-----------|-------|
| Posts | 4-10 |
| Duration | 1-2 weeks (other platforms), up to 5 weeks (LinkedIn at 1/week) |
| Platforms | All 4 (LinkedIn, X, Bluesky, Threads) |
| CTA | Soft (questions, "follow for more") or none |
| Assets needed | None (text only) or 1 simple image |
| Anchor content | Optional blog post (thought leadership deep dive) |
| Tracking | Vista Social metrics only |
| Example | "Planning poker with AI agents" thought leadership series |

**LinkedIn campaign posts:** 1 per week (Monday or Friday depending on campaign tone)
**Other platforms (X, Bluesky, Threads):** Every 2-3 days

### Level 2: Engagement

Drive conversation and build audience. Moderate CTAs. Links to anchor content.

| Parameter | Value |
|-----------|-------|
| Posts | 8-15 |
| Duration | 2-3 weeks (other platforms), longer on LinkedIn at 1/week |
| Platforms | All 4 |
| CTA | Medium (link to article, "DM me", reply prompts) |
| Assets needed | 1-3 images or screenshots |
| Anchor content | Blog post or article (recommended) |
| Tracking | Vista Social metrics + link clicks |
| Example | Product launch series with demo links |

**LinkedIn campaign posts:** 1 per week (Monday or Friday depending on campaign tone)
**Other platforms (X, Bluesky, Threads):** Every 2-3 days

### Level 3: Lead Generation

Drive traffic to a specific destination. Clear CTAs with tracking.

| Parameter | Value |
|-----------|-------|
| Posts | 8-12 |
| Duration | 3-4 weeks (other platforms), longer on LinkedIn at 1/week |
| Platforms | All 4 |
| CTA | Hard (link to landing page, book a call, download) |
| Assets needed | 3-5 images, possibly video |
| Anchor content | Landing page or gated content (required) |
| Tracking | Vista Social + UTM parameters + HubSpot |
| Example | White paper download campaign |

**LinkedIn campaign posts:** 1-2 per week (Monday + Friday for conversion push)
**Other platforms (X, Bluesky, Threads):** Every 2-3 days

### Level 4: Full Funnel

Multi-stage campaign with awareness, engagement, and conversion phases. Coordinated with email, ads, or events.

| Parameter | Value |
|-----------|-------|
| Posts | 12-20 |
| Duration | 4-6 weeks (other platforms), longer on LinkedIn at 1-2/week |
| Platforms | All 4 + possible Instagram/TikTok |
| CTA | Progressive (soft early, hard later) |
| Assets needed | 5-10 images, video, possibly carousel |
| Anchor content | Landing page + email sequence (required) |
| Tracking | Full funnel: Vista Social + UTM + HubSpot + ads platform |
| Email integration | Yes (HubSpot sequences or workflows) |
| Example | Event promotion with early bird, speakers, countdown |

**LinkedIn campaign posts:** 1-2 per week (Monday + Friday)
**Other platforms (X, Bluesky, Threads):** Daily or every other day during push phases

---

## Brent's LinkedIn Content Calendar

**Brent posts DAILY on LinkedIn. 7 days a week. Each day has a theme.**

| Day | Theme | Campaign Eligible? |
|-----|-------|-------------------|
| **Monday** | Open (no fixed theme) | **YES - primary campaign slot** |
| **Tuesday** | Tuesdays with Claude (TWC) | No (reserved) |
| **Wednesday** | Newsletter | No (reserved) |
| **Thursday** | Entrepreneurial / EO content | No (reserved) |
| **Friday** | Fun / lighthearted | **YES - if campaign tone fits** |
| **Saturday** | Exercise / running / fitness | No (reserved) |
| **Sunday** | Funday (casual, personal) | No (reserved) |

**Campaign posts go on MONDAY.** That's the open slot. Friday is available if the campaign has a fun/lighthearted angle for that post.

### Campaign Post Scheduling

LinkedIn gets ONE campaign post per week. Ask Brent which day during discovery.

| Day | Fit |
|-----|-----|
| **Monday** | Open slot. Default campaign day. |
| **Friday** | Fun/lighthearted campaigns. Good for creative or personality-driven topics. |

**Rules:**
- Never displace Tue/Wed/Thu/Sat/Sun themes
- If a campaign needs 2 LinkedIn posts/week, use Monday + Friday. Ask Brent first.
- Campaign duration on LinkedIn = number of posts (1 per week)

### Other Platforms (X, Bluesky, Threads)

X, Bluesky, and Threads do NOT have daily theme constraints. They run on a faster cadence than LinkedIn.

| Cadence | When to use |
|---------|-------------|
| Every 2-3 days | Standard. Covers a 5-post campaign in ~2 weeks. |
| Every other day | Aggressive. Good for time-sensitive campaigns. |
| Daily | Launch pushes or event countdowns only. |

Posts on other platforms can go out on the same day as the LinkedIn post OR be spread independently. Confirm with Brent during discovery.

**Best posting time:** 7-9 AM EST across all platforms

---

## Workflow

### Phase 1: Discovery (MUST complete before writing anything)

Ask Brent these questions in order. Do not skip any.

1. **"What's the topic or idea for this campaign?"**
2. **"What complexity level? (1=Awareness, 2=Engagement, 3=Lead Gen, 4=Full Funnel)"**
3. **"Is there anchor content (blog post, article, landing page) for this campaign, or do we need to create it?"**
   - If creating: write the anchor content FIRST (Phase 2.5), then shape social posts around it
   - If existing: get the URL, shape social posts to drive to it
   - If none: campaign runs as standalone social (Level 1 only)
4. **"Who is the audience?"** (vibe coders, ecommerce brands, agency owners, etc.)
5. **"How many posts do you want?"** (suggest range based on complexity level)
6. **"What cadence PER PLATFORM?"** (each platform can be different)
   - LinkedIn: which day? (Monday is open, Friday/Sunday if tone fits). Always 1/week.
   - X: daily? every other day? (X can handle volume)
   - Bluesky: how many times per week? (3-4x is common)
   - Threads: how many times per week? (2x is common)
   - **The campaign duration is fixed** (e.g., 2 weeks). Faster platforms need more content to fill slots.
7. **"Which platforms?"** (default: all 4, but confirm)
8. **"Any specific dates to hit?"** (event dates, launch dates, etc.)
9. **"Do you have or need images/video?"**

Write answers to the campaign file immediately as agreed.

### Phase 2: Campaign Arc

Design the narrative arc based on complexity level.

**Level 1 arc (Awareness):**
- Hook (grab attention, state the problem)
- Concept (introduce the idea)
- Detail (show how it works)
- Takeaway (broader lesson, follow CTA)

**Level 2 arc (Engagement):**
- Hook + tease
- Problem deep-dive
- Solution introduction
- Proof/example
- Discussion prompt
- Link to content

**Level 3 arc (Lead Gen):**
- Problem awareness (2-3 posts)
- Solution tease (2-3 posts)
- Social proof / case study (2-3 posts)
- Direct CTA with landing page (2-3 posts)

**Level 4 arc (Full Funnel):**
- Awareness phase (week 1-2)
- Consideration phase (week 2-3)
- Conversion phase (week 3-4)
- Urgency / countdown (final week)

Present the arc to Brent for approval before writing posts.

### Phase 2.5: Anchor Content (if applicable)

If the campaign has anchor content to create (blog post, article, landing page):

1. **Write the anchor content FIRST** before any social posts
2. For blog posts: use `/rd-blog` to draft in Brent's voice on RequestDesk
3. For landing pages: coordinate with the relevant project team
4. Get Brent's approval on the anchor content
5. **Run terms checker** on all content before publishing
6. **Push to RequestDesk as DRAFT** (never publish directly)
7. **Record anchor content details in campaign file:**
   ```
   | Field | Value |
   |-------|-------|
   | Blog Post | [Title](URL) |
   | Blog Status | Draft / Published |
   | RequestDesk Post ID | post-XXXX |
   | Edit URL | https://app.requestdesk.ai/blog-posts/ID/edit |
   ```
8. Extract key quotes, stats, and talking points for social posts
9. Social posts should tease, excerpt, and drive to the anchor. Not duplicate it.

**Skip this phase** if the campaign is standalone social (no anchor content) or links to existing content.

### Phase 3: Write LinkedIn Versions First

LinkedIn is the primary platform (3,000 char limit, most room for content).

- Write all posts in the LinkedIn format first
- Apply brand voice (no em dashes, no emojis, Brent's tone)
- Load brand persona from API: `POST https://app.requestdesk.ai/api/agent/content`
- Each post gets a clear purpose in the arc
- Show all LinkedIn drafts to Brent for review

### Phase 4: Create Platform-Tailored Versions

After LinkedIn drafts are approved, create tailored versions. NOT copy-paste.

| Platform | Char Limit | Tone | Format |
|----------|-----------|------|--------|
| **LinkedIn** | 3,000 | Professional, thought leadership | Full-length, line breaks, optional hashtags |
| **X/Twitter** | 280 | Punchy, hot takes | Single post or thread (3-5 tweets) for longer content |
| **Bluesky** | 300 | Dev-native, casual | Lowercase OK, group chat energy, skip corporate CTAs |
| **Threads** | 500 | Conversational, personality | Between LinkedIn and Bluesky formality |

**Rules for tailoring:**
- X and Bluesky versions are NOT just truncated LinkedIn posts
- Each platform version should feel native to that platform
- Threads for posts 3+ (persona/demo type content) should work as X threads
- Bluesky can be more casual/lowercase
- Links always go in first comment (Vista Social `comments` parameter), not message body
- **CHARACTER COUNT VALIDATION (MANDATORY):** After writing each platform version, count the characters. If over the limit, rewrite shorter. Do NOT submit to Vista Social without validating.
  - **Bluesky: 300 characters MAX.** This is the tightest limit. Write Bluesky posts LAST and keep them SHORT. If a Bluesky post is over 300 chars, cut it down before moving on. Count newlines as 1 char each.
  - **X: 280 characters MAX** per tweet (threads: 280 per tweet).
  - **Threads: 500 characters MAX.**
  - **LinkedIn: 3,000 characters MAX.**

### Phase 4.5: Create Additional Content for Faster Platforms

If faster platforms (X daily, Bluesky 3-4x/week) need more posts than the core set to fill the campaign duration, create additional content:

| Type | Purpose | Typical Count |
|------|---------|---------------|
| **Quote pulls** | Short excerpts from the blog/anchor content | 2-4 |
| **Hot takes** | One-liners, polls, engagement bait, spicy opinions | 2-3 |
| **Rephrased angles** | Same core idea, different framing or angle | 1-2 |

**Rules for additional content:**
- Quote pulls are platform-specific (X gets punchy 280-char excerpts, Bluesky gets casual rewrites)
- Hot takes can include polls on X (great for engagement)
- All additional content links to the blog in first comment
- These don't need all 4 platform versions. Write only for the platforms that need them.
- Map each piece to a specific day/slot in the schedule

**Calculate content needed:**
```
Core posts: [N]
X slots (daily weekdays x 2 weeks): 10 - N = [additional X posts needed]
Bluesky slots (3-4x/week x 2 weeks): 6-8 - N = [additional BS posts needed]
Threads slots (2x/week x 2 weeks): 4 - N (usually covered by core posts)
LinkedIn slots (1x/week x campaign weeks): usually covered by core posts
```

### Phase 5: Review with Brent

Present all posts organized by post number. **MUST include character count and pass/fail for each platform version.**

```
## Post 1: [Title]

**LinkedIn:** (245/3000)
[full text]

**X:** (267/280)
[full text]

**Bluesky:** (289/300) ✅
[full text]

**Threads:** (412/500)
[full text]
```

**Character count rules:**
- Show `(count/limit)` after every platform name
- If ANY post exceeds its platform limit, mark it with a FAIL indicator and rewrite it before presenting
- **Bluesky (300) and X (280) are the tightest.** Double-check these. Count every character including newlines and spaces.
- Do NOT present posts to Brent with over-limit content. Fix first.

Ask: "Any changes? When you're ready, tell me to schedule."

Handle edits. Re-present after changes. Do NOT schedule until explicit confirmation.

### Phase 6: Schedule via Vista Social

After Brent confirms:

1. Calculate schedule dates based on agreed cadence and start date
2. **TIMEZONE (CRITICAL - DO NOT SKIP):**
   - Get the system timezone: `date "+%z"` (returns e.g. `-1000` for HST)
   - Target posting window: **7:00-9:00 AM EST (`-05:00`)**
   - ALL `publish_at` values MUST use ISO 8601 with timezone offset: `2026-02-01T08:23:00-05:00`
   - **NEVER submit `publish_at` without a timezone offset.** Without it, Vista Social treats the time as UTC.
3. **RANDOMIZE POSTING TIMES (CRITICAL - DO NOT SKIP):**
   - Each post gets a unique random time within the 7:00-9:00 AM EST window
   - Randomize the hour (7 or 8) and the minute (00-59)
   - Posts on the same day across different platforms should NOT be at the same time. Stagger by at least 10 minutes.
   - Example script to generate random EST times:
   ```bash
   # Generate random time between 7:00-8:59 AM EST
   HOUR=$((7 + RANDOM % 2))
   MINUTE=$((RANDOM % 60))
   printf "%02d:%02d:00-05:00" $HOUR $MINUTE
   ```
   - **WHY:** Posting all at the same time looks automated and can trigger platform spam filters.
4. **Choose scheduling method (ask Brent which approach to use):**
   - **Specific date:** ISO 8601 with timezone offset (e.g., `2026-02-01T08:23:00-05:00`). Full control over exact timing. Randomize times within the 7-9 AM EST window.
   - **`queue_available`:** Let Vista Social place posts in the next open queue slot. Respects the profile's publishing queue schedule (configured in Vista Social UI under Publishing Queues). No timezone math needed. When using this, submit posts in campaign arc order so the queue places them sequentially.
   - **`queue_next`:** Front of the queue.
   - **`queue_last`:** End of the queue.
5. **Build a scheduling script** that handles all posts across all platforms
6. For each post, for each platform:
   - Call Vista Social API with correct profile_id
   - Use `publish_at` with chosen method (specific date with timezone offset, or queue option)
   - Put anchor content links in `comments` array (first comment)
   - Capture the returned Vista Social post ID
6. **Record every post ID and date** in the campaign file
7. Present per-platform schedule tables:

```
### LinkedIn (Sundays)
| Date | Post | Vista Social ID |
|------|------|----------------|
| Sun Feb 1 | Post 1 - Hook | 697eb71900b1231a30a8c3aa |

### X (Daily Weekdays)
| Date | Post | Vista Social ID |
|------|------|----------------|
| Mon Feb 2 | Post 1 - Hook | 697eb71d2272fa8ee1238b75 |
```

7. Also create a **week-at-a-glance grid** showing all platforms side by side:

```
### Week 1
| Day | X | Bluesky | Threads | LinkedIn |
|-----|---|---------|---------|----------|
| Mon | Post 1 | Post 1 | Post 1 | |
| Tue | Quote A | | | |
```

### Phase 7: Save Campaign to Sales and Marketing

**Campaign folder location:**
```
ob-notes/Brent Notes/Sales and Marketing/campaigns/YYYY-MM-[topic]/
```

**Create a campaign folder with these files:**

1. **`campaign.md`** - The master file containing:
   - Overview (type, status, dates, duration, total posts)
   - Anchor content details (blog URL, post ID, edit URL, status)
   - Audience and platform cadences
   - Goals and success metrics
   - Full schedule with Vista Social post IDs per platform
   - Week-at-a-glance grid
   - Content inventory (core posts + additional content)
   - Platform-specific notes
   - Results tracking tables (with Vista Social IDs for cross-reference)
   - Notes and context

2. **`posts.md`** - All post content:
   - Every core post with all platform versions
   - All additional content (quote pulls, hot takes, rephrased)
   - Blog link instructions per post
   - Schedule summary at the bottom

3. **Update `ACTIVE-CAMPAIGNS.md`** dashboard:
   - Add campaign to "Upcoming" or "Currently Active" section
   - Link to the campaign folder

**Why this structure matters:** Future sessions can review campaign performance by reading the campaign file. Vista Social IDs enable pulling metrics. The week-at-a-glance grid makes it easy to see what went out when. The blog post details connect the anchor content to the social distribution.

---

## Platform Profile IDs (Quick Reference)

| Platform | ID |
|----------|-----|
| LinkedIn | 22469 |
| X/Twitter | 23232 |
| Bluesky | 457112 |
| Threads | 399179 |
| Instagram | 43335 |
| TikTok | 22468 |

---

## Character Limits

| Platform | Limit |
|----------|-------|
| LinkedIn | 3,000 |
| X/Twitter | 280 (thread tweets also 280 each) |
| Bluesky | 300 |
| Threads | 500 |

---

## Scheduling Best Practices

- Best posting window: **7:00-9:00 AM EST** across all platforms
- **RANDOMIZE** each post's time within that window. Never use the same time for all posts.
- Stagger posts on the same day across platforms by at least 10 minutes
- Space posts 2-3 days apart minimum for algorithm reach
- Morning posts outperform afternoon on all platforms
- Brent's audience is US-based (EST/CST primary)
- **TIMEZONE IS MANDATORY** in `publish_at`. See Phase 6 and Vista Social skill for format.

---

## Campaign File Template (campaign.md)

```markdown
# Campaign: [Topic]

## Overview
| Field | Value |
|-------|-------|
| **Type** | Content / Direct Sales / Partner / Event |
| **Status** | Planning / Scheduled / Active / Complete |
| **Started** | YYYY-MM-DD |
| **Ends** | YYYY-MM-DD |
| **Duration** | X weeks |
| **Owner** | Brent |
| **Complexity** | Level [1-4] |
| **Total Posts** | [count across all platforms] |

## Anchor Content
| Field | Value |
|-------|-------|
| **Blog Post** | [Title](URL) |
| **Blog Status** | Draft / Published |
| **RequestDesk Post ID** | post-XXXX |
| **Edit URL** | https://app.requestdesk.ai/blog-posts/ID/edit |

## Audience
**Who:** [description]
**Platforms:**
| Platform | Profile ID | Cadence | Total Posts |
|----------|-----------|---------|------------|
| X | 23232 | [daily/every other day] | [count] |
| Bluesky | 457112 | [Nx/week] | [count] |
| Threads | 399179 | [Nx/week] | [count] |
| LinkedIn | 22469 | 1x/week ([day]) | [count] |

## Goal
**Primary:** [what we want to achieve]
| Metric | Target |
|--------|--------|
| [metric] | [target] |

## Full Schedule with Vista Social Post IDs
All times: 8:00 AM EST

### [Platform] ([cadence])
| Date | Post | Vista Social ID |
|------|------|----------------|
| [date] | [post name] | [vista-social-id] |

[repeat for each platform]

## Week-at-a-Glance
### Week 1 ([dates])
| Day | X | Bluesky | Threads | LinkedIn |
|-----|---|---------|---------|----------|

### Week 2 ([dates])
| Day | X | Bluesky | Threads | LinkedIn |
|-----|---|---------|---------|----------|

## Content Inventory
### Core Posts
| # | Arc | Theme | Blog Connection |
|---|-----|-------|-----------------|

### Additional Content
| Piece | Platforms | Type |
|-------|----------|------|

## Results Tracking
### Blog Traffic
| Week | Page Views | Unique Visitors | Avg Time |
### [Platform]
| Post | Date | Impressions | Likes | Comments/Replies | Reposts | Vista ID |
```

## Posts File Template (posts.md)

```markdown
# [Campaign Name] - All Posts
**Blog URL:** [anchor content URL]
**Blog link in first comment on Posts [X-Y] and all additional content.**

## CORE POSTS
### Post 1: [Title]
**Arc:** [purpose in the campaign]
**Blog link:** [none / first comment text]
**LinkedIn:** [full text]
**X:** [full text]
**Bluesky:** [full text]
**Threads:** [full text]

[repeat for each core post]

## ADDITIONAL CONTENT
### Quote Pull A ([Platform]: [Day])
**[Platform]:** [text]

### Hot Take A ([Platform]: [Day])
**[Platform]:** [text]

## SCHEDULE SUMMARY
[week-at-a-glance grid]
```

---

## When Claude Should Apply This Skill

Apply this skill automatically when:
- User mentions "drip campaign", "social campaign", or "content series"
- User wants to plan multiple related social posts
- User says "I want to talk about X on social" and it needs more than 1 post
- User mentions promoting an idea across platforms
- User references planning poker campaign or similar multi-post efforts

Do NOT apply this skill for:
- Single social posts (use `/create-social` instead)
- Newsletter or article content (different skills)
- Email campaigns (use HubSpot skills)

---

## Integration with Commands

- `/plan-social` - Explicit command to start a social campaign
- `/create-social` - Used internally for scheduling individual posts
- `/brand-brent` - Voice guidelines loaded automatically
- `/check-terms` - Run on all content before scheduling

---

## Version History

| Date | Change | By |
|------|--------|-----|
| 2026-01-31 | Initial creation | Brent + Claude-Austen (S3 Planning) |
| 2026-01-31 | Added anchor content framework, per-platform cadence, Phase 2.5 | Brent + Claude-Tolkien |
| 2026-01-31 | Added Phase 4.5 (additional content for faster platforms), rewrote Phase 6 (scheduling with post ID recording), rewrote Phase 7 (save to campaigns/ folder with campaign.md + posts.md), updated campaign file template, added posts file template, updated critical resources | Brent + Claude-Tolkien |
| 2026-02-01 | **BUG FIX:** Added mandatory timezone offset in `publish_at` (posts were going out as UTC). Added randomized posting times within 7-9 AM EST window. Added mandatory character count validation in Phase 4 and Phase 5 (Bluesky posts were exceeding 300 char limit). | Brent + Claude-Beethoven |
