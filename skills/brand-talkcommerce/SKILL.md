# Brand: Talk Commerce

Media property and production service. The voice of the ecosystem. Podcasts, video, webinars, and media production.

## Brand Identity

| Field | Value |
|---|---|
| **Name** | Talk Commerce |
| **Domain** | talkcommerce.com |
| **Type** | Media Property / Production Service |
| **Tagline** | Helping bridge the divide between agency, developer and merchant |
| **Primary Color** | #E84E36 (orange-red) |
| **Contact** | brent@talkcommerce.com |

## Positioning

Talk Commerce is the media brand. It started as a podcast and has grown into a full media service that produces content for the ecosystem and for clients.

Two roles:
1. **Media property** - Talk Commerce podcast, Running Commerce podcast, Content in Commerce LinkedIn Live. Builds authority and drives top-of-funnel awareness for all brands.
2. **Production service** - Video production, webinar production, and media services available to Content Basis clients and direct clients.

**Key differentiator:** Authentic conversations and professional production from people who actually work in commerce. Not a production house that learns your industry. A media brand that lives in your industry.

## Voice and Tone

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
- [ ] Update talkcommerce.com with production services pages (video, webinar)
- [ ] Create Running Commerce as a formal sub-brand or section on the site
- [ ] Define podcast guest outreach workflow
- [ ] Create webinar production workflow template
- [ ] Set up Talk Commerce LinkedIn company page (vs personal)
- [ ] Create media kit for podcast sponsorship and guest outreach
- [ ] Document the podcast-to-lead conversion pipeline
