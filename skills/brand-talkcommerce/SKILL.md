# Brand: Talk Commerce

Media property and production service. The voice of the ecosystem. Podcasts, video, webinars, and media production.

## Brand Identity

| Field | Value |
|---|---|
| **Name** | Talk Commerce |
| **Domain** | talk-commerce.com |
| **Type** | Media Property |
| **Word** | Connect |
| **Tagline** | Connect commerce. |
| **Primary Color** | #0033FF (electric blue) - primary accent |
| **Structural Colors** | #000000 (black) + #FFFFFF (white) - base palette |
| **Neutral Slates** | #334155, #1E293B |
| **Secondary Palette** | #FF6568, #FCBB00, #F99C00, #F05100 (used for podcast episode tags, not as brand accents) |
| **Font** | Outfit (sans-serif) |
| **Source** | Verified from talk-commerce.com compiled CSS (2026-04-17) |
| **Contact** | brent@talk-commerce.com |

## Positioning

**Sentence:** Talk Commerce connects the commerce community through podcasts, live event coverage, and commerce news.

**Paragraph:** Talk Commerce connects the commerce community through conversation. A weekly podcast brings real insights from founders, developers, agency leaders, and merchants. Running Commerce does the same for the specialty running and athletic space. Live reporting from events like eTail and Shoptalk puts you on the floor when you can't be there. E-commerce and marketing news keeps you current on what matters in commerce. Every episode and every story bridges the gap between the people building, selling, and running online businesses.

## What It Does

- Weekly podcast (Talk Commerce)
- Running Commerce podcast (specialty running/athletic industry)
- At-event reporting
- E-commerce news
- Marketing news for commerce

**Key differentiator:** Authentic conversations from people who actually work in commerce. Not a production house that learns your industry. A media brand that lives in your industry.

## Voice and Tone

> **Baseline writing rules come from `/brand-brent`.** All rules below inherit from brand-brent (no em dashes, no emojis, no vague hooks, active voice, banned phrase list). Brand-specific adjustments below override or extend the baseline where noted.

- Conversational, insightful, industry-focused
- Interview-style. Let guests shine.
- Authentic over polished. Real conversations over scripted content.
- Curious and engaged. Ask the question nobody else asks.
- Informed opinion backed by experience, not hot takes for engagement.

### Never Use
- Em dashes (use periods, commas, or parentheses)
- Emojis (unless explicitly requested)
- Clickbait titles or sensationalism
- "Game-changing," "revolutionary"
- Corporate speak or press release language
- Anything that sounds like a commercial for one of the other brands

### Always Use
- Guest's name and company (give them the spotlight)
- Specific, concrete references (not "some companies" but name them)
- Questions that drive real conversation
- Natural transitions, not scripted segues

## Press Releases

Talk Commerce publishes PR-sourced content as a `[Press Release]` category on the blog. Two formats exist depending on what the source material supports. Both formats share file location, filename convention, frontmatter, and publishing flow. They differ only in body structure and tone.

### Pick a Format First

**Reprint Format** — use when the source is a formal press release with dateline, named spokespeople, and a clear corporate announcement structure (e.g., Constructor/MIA, Rezolve/brainpowa).
- The vendor wrote it in PR style already
- Has dateline like `CITY, STATE — DATE`
- Has at least one verbatim executive quote
- Has an "About [Company]" section
- Has a structural narrative (the company announced X, here's how it works, quote, more details)

**Editorial Coverage Format** — use when the source is a pitch, study summary, or email from a PR firm without formal PR structure (e.g., Gourmet Gift Baskets retention study, BERA Brand Equity Report).
- The source is a pitch email or blog link, not a distributed press release
- No dateline, no verbatim quotes, no "About" section in the source
- Content is stat-heavy and works better as analysis than as reprint
- You want to frame the material for a commerce operator audience

When in doubt, editorial. Reprint demands PR-grade source material; editorial works with anything that has data and a point of view.

## Reprint Format

### When to Use
- A commerce-related vendor sends a formal press release (partnership, product launch, funding, etc.)
- An industry report is accompanied by a proper PR-formatted release
- Source includes dateline, quotes, and About block
- Not a fit: TC announcing its own products or services. Use a standard announcement format for those.

### File Location
**Google Drive (NOT Obsidian):**
```
/Users/brent/My Drive/Sales and Marketing/Company Websites/Talk Commerce/Blog/
```
A folder-level README at that path documents the publishing flow and API.

### Filename
- Format: `YYYY-MM-DD-[Topic with spaces].md`
- Date is the **publish date** on talk-commerce.com (not the vendor's announcement date)
- ISO prefix keeps files sortable chronologically in the folder
- Topic portion matches the vendor's announcement subject in natural reading order, spaces allowed
- Example: `2026-04-17-Rezolve Ai Launches brainpowa Commerce-Tuned Models in Microsoft Foundry.md`
- Older files in the folder predate this convention and lack the date prefix. New files always use it.

### Required Frontmatter
```yaml
---
title: "Full headline (can include ™, ®, other brand marks)"
excerpt: "1-2 sentence summary. Used for list pages and meta description."
tags: [comma-separated, relevant, keywords, 5-10 tags]
categories: [Press Release]
---
```
Optional extra fields (only when needed): `focus_keyphrase`, `seo_title`, `seo_description`, `status`.

### Body Structure
1. **Bold dek/subhead** at top (the vendor's subhead, not the headline)
2. **Dateline** `CITY[, CITY], Month DD, YYYY. ` opens the lede paragraph
3. **Body sections** with H2 headings, matching the vendor's structure
4. **Both executive quotes verbatim** (CEO + partner spokesperson, if present)
5. **Numbered or bulleted model/product list** when applicable
6. **`## About [Company]`** section at end, with link to vendor site
7. **Skip:** Media Contact block, Forward-Looking Statements, trademark legalese footer

### Voice Cleanup (Apply to body, NOT quotes)
- Replace em dashes with periods, commas, or parentheses
- No emojis
- Keep vendor's product names, ™/® marks, and capitalization choices intact
- **Quotes are sacred.** Never edit an executive quote even if it violates brand-brent voice rules (e.g., contains "should" or em dashes).

### Publishing
```
/publish-blog tc "<filename>"
```
- Destination: talk-commerce.com/blog
- API: WordPress headless (`/wp-json/requestdesk/v1/headless/posts`)
- Auth: X-RequestDesk-API-Key header
- Publishes as DRAFT. Human editor reviews and publishes in WP admin.

### Cross-Post Considerations
- LinkedIn article (TC company page)
- Talk Commerce newsletter

## Editorial Coverage Format

Use when the source is a PR pitch, study summary, report excerpt, or research blog post rather than a formal distributed press release. Frame the material as analysis for commerce operators instead of reprinting it. Matches the Gourmet Gift Baskets retention study and BERA Brand Equity Report posts.

### When to Use
- A PR firm sends a pitch email or study summary without traditional PR structure
- An industry report or research piece is published and we want to cover it
- Source has stats and a point of view but no dateline, verbatim quotes, or About block
- You want to frame the material for a commerce operator audience rather than reprint it
- Not a fit: source is a fully-structured press release (use Reprint Format instead)

### File Location, Filename, Frontmatter, Publishing
Same as Reprint Format:
- Folder: `~/My Drive/Sales and Marketing/Company Websites/Talk Commerce/Blog/`
- Filename: `YYYY-MM-DD-[Topic with spaces].md`
- Frontmatter: `title`, `excerpt`, `tags`, `categories: [Press Release]`
- Publishing: `/publish-blog tc "<filename>"`

### Body Structure
1. **Italic dek** at top (one sentence, sharpens the hook, names the stakes). This replaces the bold subhead used in reprint format.
2. **Lede paragraph** - frames the story and states the reason it matters to commerce operators. No dateline.
3. **Three H2 sections** typically:
   - **What the data shows** (facts, specific numbers, named companies)
   - **Why it matters / Why the trend is happening** (mechanism, nuance)
   - **What this means for commerce** (analytical takeaway)
4. **Closing paragraph** - pointer to the source with a link, any caveats (e.g., "claims are the vendor's own, independent benchmarks don't exist yet")

### Rules
- **No fabrication.** Only use stats, quotes, or claims present in the source material. If a number isn't in the source, don't invent one.
- **Cite the source** with a real link somewhere in the piece (usually the closing paragraph).
- **Preserve verbatim quotes** if the source includes any. Quotes are sacred even in editorial format.
- **No "should"** per brand-brent voice rules.
- **Named specifics beat vague claims.** "Retention searches jumped 5x from 2021 to 2025" not "retention has grown significantly."
- **Flag when claims are the vendor's own** vs independently verified, if that distinction matters.

### Headline Style
- Punchy, no colon
- Captures the angle (your angle, not the vendor's subject line)
- Example: `Commerce Gets Its Own Foundational Model Inside Microsoft Foundry` (angle: category-level signal, not "Rezolve Launches X")
- Example: `Retention Searches Jumped 5x While Buyers Pulled Back on Gift Budgets` (angle: the two-trend tension, not "Gourmet Gift Baskets Study Finds X")

## Media Properties

### Talk Commerce Podcast
- **Format:** Interview-style conversations with commerce industry leaders
- **Audience:** E-commerce professionals, agency owners, tech leaders
- **Platforms:** Apple Podcasts, Spotify, YouTube
- **Cadence:** Weekly
- **Goal:** Build authority, drive awareness for all brands

### Running Commerce (NEW 2026)
- **Format:** Interview-style conversations with specialty running business owners
- **Audience:** Running retailers, race organizers, coaches, running brands
- **Goal:** Problem discovery in the running vertical, build niche audience

### Content in Commerce (LinkedIn Live)
- **Format:** Bi-weekly live discussions on commerce content strategy
- **Audience:** E-commerce brands, marketing leaders, agency owners
- **Goal:** Engagement, community building, promote CC + RD

## Services (2)

Talk Commerce owns and delivers these production services:

| Shortcode | Service | Category |
|---|---|---|
| `video` | Video Production | Production |
| `webinar` | Webinar Production | Production |

**Service definitions** live in `.claude/skills/proposal-creation/service-types.md`.

### Video Production
Professional on-site video. Interviews, brand stories, product demos, thought leadership. Broadcast-quality equipment owned and operated.

### Webinar Production
End-to-end webinar production. Strategy, scripting, promotion, live production, recording, and content repurposing. Available as 3-packs, 6-month packages, or per-webinar.

## Ideal Customer Profile

### Primary: Content Basis Clients (Internal)
- Content Basis engagements that include media/production
- Talk Commerce produces, Content Basis manages the client relationship

### Secondary: Direct Media Clients
- Companies wanting professional video or webinar production
- E-commerce brands wanting thought leadership content
- Event organizers needing professional coverage

### Tertiary: Podcast Guests as Leads
- Talk Commerce podcast guests often become clients of Content Cucumber or Content Basis
- The podcast is a top-of-funnel engine for the entire ecosystem

## Podcast Platforms

| Platform | URL |
|---|---|
| Apple Podcasts | https://podcasts.apple.com/us/podcast/talk-commerce/id1535380484 |
| Spotify | https://open.spotify.com/show/47icMu3IO1hhGXtS9IWDcC |
| YouTube | https://www.youtube.com/@taborapodcast |

## Social

| Platform | Handle |
|---|---|
| Twitter/X | @taboraio |
| LinkedIn | talk-commerce |
| YouTube | @taborapodcast |

## Brand Relationships

```
Talk Commerce (this brand)
    ├── Produces media for Content Basis clients
    ├── Drives awareness for Content Cucumber
    ├── Podcast guests become leads for all brands
    └── Uses RequestDesk for content management
```

- Talk Commerce builds authority at the top of the funnel
- Podcast guests often convert to Content Cucumber or Content Basis clients
- Video and webinar services are available through Content Basis engagements
- All leads flow into the unified HubSpot CRM

## API Integration

**Status:** No RequestDesk agent exists yet. Needs to be created.

When the agent is created, add the API key here:

```
Endpoint: https://app.requestdesk.ai/api/agent/content
Method: POST
Auth: Bearer [TALK_COMMERCE_API_KEY]
```

## Equipment (owned)

| Type | Equipment | Purpose |
|---|---|---|
| **Primary Camera** | Canon EOS R Series | 4K video, cinema-quality image |
| **Second Camera** | iPhone (4K) | B-roll, alternate angles |
| **Primary Audio** | Rode Wireless Go II | Lapel mics for interviewer + subject |
| **Backup Audio** | Rode Shotgun Mic | Ambient/backup capture |

## Punch List

- [ ] Create Talk Commerce agent in RequestDesk with brand persona
- [ ] Add API key to workspace.env and this skill
- [ ] Create `/brand-talkcommerce` command file in `.claude-local/commands/`
- [ ] Define Talk Commerce content terms (avoid/use lists) in RequestDesk
- [ ] Update talk-commerce.com with production services pages (video, webinar)
- [ ] Create Running Commerce as a formal sub-brand or section on the site
- [ ] Define podcast guest outreach workflow
- [ ] Create webinar production workflow template
- [ ] Set up Talk Commerce LinkedIn company page (vs personal)
- [ ] Create media kit for podcast sponsorship and guest outreach
- [ ] Document the podcast-to-lead conversion pipeline
