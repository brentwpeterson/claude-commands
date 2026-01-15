# Paid Ads Campaign Management

**Skill Description:** Comprehensive paid advertising management across Google Ads, LinkedIn Ads, and Meta Ads. Handles campaign creation, ad copy, audits, and reporting for multiple clients.

## Usage

```
/paid-ads <description of what you need>
```

## Examples

```
/paid-ads create a google search campaign for RequestDesk targeting content managers
/paid-ads write linkedin ad copy for RequestDesk focusing on AI content automation
/paid-ads add new client Acme Corp, B2B SaaS, $5k monthly budget
/paid-ads audit my meta campaigns for ChaletMarket
/paid-ads generate a monthly report for all clients
/paid-ads what's the budget split recommendation for RequestDesk
/paid-ads list all my clients
```

## What Claude Can Do

| Request Type | What Claude Does |
|--------------|------------------|
| Create campaign | Generates full campaign structure (settings, targeting, ad groups, copy) |
| Write ad copy | Platform-specific copy with correct character limits |
| Add client | Creates client profile with targeting, voice, goals |
| Audit campaign | Reviews setup, provides optimization recommendations |
| Generate report | Creates performance report template or analyzes provided data |
| Budget advice | Allocation recommendations across platforms/campaigns |
| List clients | Shows all configured clients and their status |

## Platform Support

| Platform | Campaign Types |
|----------|---------------|
| **Google Ads** | Search, Display, Performance Max, YouTube |
| **LinkedIn Ads** | Sponsored Content, Message Ads, Text Ads, Dynamic Ads |
| **Meta Ads** | Feed, Stories, Reels, Audience Network |

---

## Client Management

### Client Data Location
`/Users/brent/scripts/CB-Workspace/.claude/local/paid-ads-clients.json`

### Client Profile Structure
```json
{
  "client_id": "requestdesk",
  "name": "RequestDesk",
  "industry": "SaaS / AI Content",
  "website": "https://requestdesk.ai",
  "target_audience": {
    "job_titles": ["Marketing Manager", "Content Director", "E-commerce Manager"],
    "company_size": "10-500 employees",
    "industries": ["E-commerce", "Retail", "DTC Brands"]
  },
  "brand_voice": "Professional, direct, practical",
  "competitors": ["Jasper", "Copy.ai", "Writer"],
  "budget_monthly": null,
  "active_platforms": ["google", "linkedin"],
  "campaigns": []
}
```

---

## Subcommand Details

### `/paid-ads new-campaign [client] [platform]`

**Purpose:** Generate complete campaign structure ready for manual input or API upload.

**Prompts Claude to ask:**
1. Which client?
2. Which platform? (google/linkedin/meta)
3. Campaign objective? (awareness, traffic, leads, sales)
4. Budget? (daily/monthly)
5. Target audience specifics?
6. Landing page URL?

**Output includes:**
- Campaign settings (name, objective, budget, schedule)
- Ad group structure
- Targeting recommendations
- Keyword suggestions (for search)
- Audience definitions
- Ad copy variations (see ad-copy)

**Output Format:**
```
## Campaign: [Name]
**Platform:** Google Ads
**Objective:** Lead Generation
**Daily Budget:** $50
**Schedule:** Ongoing

### Ad Groups
1. [Ad Group Name]
   - Keywords: [list]
   - Match types: [broad/phrase/exact]

### Targeting
- Locations: [list]
- Demographics: [specs]
- Audiences: [list]

### Ads
[Generated ad copy - 3-5 variations]

### Tracking
- Conversion actions needed: [list]
- UTM parameters: [provided]
```

---

### `/paid-ads ad-copy [client] [platform]`

**Purpose:** Generate platform-specific ad copy variations.

**Google Ads (Responsive Search):**
- 15 headlines (30 chars max each)
- 4 descriptions (90 chars max each)
- Display URL paths

**LinkedIn Ads (Sponsored Content):**
- Introductory text (150 chars for mobile visibility)
- Headline (70 chars recommended)
- CTA button selection

**Meta Ads:**
- Primary text (125 chars visible)
- Headline (40 chars)
- Description (30 chars)
- CTA button selection

**Rules:**
- Match client brand voice
- Include value proposition
- Test emotional vs logical appeals
- Include numbers/stats where possible
- Avoid: "Click here", generic CTAs
- Platform-specific best practices

---

### `/paid-ads audit [client] [platform]`

**Purpose:** Review campaign setup and provide optimization recommendations.

**Audit Checklist:**
- [ ] Conversion tracking properly configured
- [ ] Budget pacing (over/under spending)
- [ ] Keyword match type balance
- [ ] Negative keywords in place
- [ ] Ad relevance scores
- [ ] Landing page alignment
- [ ] Audience overlap issues
- [ ] Bid strategy appropriate for goal
- [ ] Ad rotation settings
- [ ] Extensions configured (Google)

**Output:** Prioritized recommendations with expected impact.

---

### `/paid-ads report [client] [platform] [period]`

**Purpose:** Generate report template or analyze provided data.

**Metrics by Platform:**

| Google Ads | LinkedIn Ads | Meta Ads |
|------------|--------------|----------|
| Impressions | Impressions | Reach |
| Clicks | Clicks | Link Clicks |
| CTR | CTR | CTR |
| CPC | CPC | CPC |
| Conversions | Leads | Results |
| Conv. Rate | Lead Rate | Conv. Rate |
| Cost/Conv | Cost/Lead | Cost/Result |
| ROAS | - | ROAS |
| Quality Score | Relevance Score | Quality Ranking |

**Report Sections:**
1. Executive Summary (3-5 bullets)
2. Key Metrics vs Goals
3. Top Performers (campaigns/ads/keywords)
4. Underperformers (with recommendations)
5. Budget Analysis
6. Next Period Recommendations

---

### `/paid-ads budget [client]`

**Purpose:** Budget allocation recommendations across platforms/campaigns.

**Factors considered:**
- Historical performance by platform
- Industry benchmarks
- Funnel stage (awareness vs conversion)
- Seasonality
- Competitive landscape

**Output:**
- Recommended split by platform
- Campaign-level allocation
- Scaling recommendations
- Warning thresholds

---

### `/paid-ads client-add`

**Purpose:** Add new client profile to the system.

**Required information:**
- Client name
- Industry
- Website
- Target audience
- Budget range
- Primary goals
- Active/planned platforms

**Saves to:** `.claude/local/paid-ads-clients.json`

---

### `/paid-ads client-list`

**Purpose:** Show all configured clients.

**Output:**
```
## Paid Ads Clients

| Client | Industry | Platforms | Monthly Budget |
|--------|----------|-----------|----------------|
| RequestDesk | SaaS | Google, LinkedIn | TBD |
| Client B | Retail | Google, Meta | $5,000 |
| Client C | B2B | LinkedIn | $3,000 |
```

---

## Character Limits Reference

### Google Ads (Responsive Search)
| Element | Limit |
|---------|-------|
| Headline | 30 chars |
| Description | 90 chars |
| Path 1 | 15 chars |
| Path 2 | 15 chars |

### LinkedIn Ads
| Element | Limit |
|---------|-------|
| Intro text | 600 chars (150 visible mobile) |
| Headline | 200 chars (70 recommended) |
| Description | 300 chars |

### Meta Ads
| Element | Limit |
|---------|-------|
| Primary text | 125 chars visible (more truncated) |
| Headline | 40 chars |
| Description | 30 chars |
| Link description | 30 chars |

---

## API Integration (Future)

When API access is configured, add credentials to:
`/Users/brent/scripts/CB-Workspace/.claude/local/workspace.env`

```bash
# Google Ads
GOOGLE_ADS_DEVELOPER_TOKEN=""
GOOGLE_ADS_CLIENT_ID=""
GOOGLE_ADS_CLIENT_SECRET=""
GOOGLE_ADS_REFRESH_TOKEN=""
GOOGLE_ADS_CUSTOMER_ID=""

# LinkedIn Ads
LINKEDIN_ADS_ACCESS_TOKEN=""
LINKEDIN_ADS_ACCOUNT_ID=""

# Meta Ads
META_ADS_ACCESS_TOKEN=""
META_ADS_ACCOUNT_ID=""
META_ADS_APP_ID=""
META_ADS_APP_SECRET=""
```

**API Capabilities When Ready:**
- Direct campaign creation
- Automated reporting
- Real-time performance data
- Bid adjustments
- Budget pacing alerts

---

## Best Practices Embedded

### Google Ads
- Minimum 8-10 headlines per RSA
- Include keyword in at least 3 headlines
- Pin sparingly (reduces optimization)
- Use all available ad extensions
- Separate brand vs non-brand campaigns

### LinkedIn Ads
- Lead Gen Forms outperform landing pages
- Job title targeting > Job function
- Exclude recent converters
- Test single image vs carousel
- Keep intro text punchy for mobile

### Meta Ads
- Creative fatigue happens fast (refresh weekly)
- Advantage+ audiences often outperform detailed targeting
- Video outperforms static (usually)
- Consolidate ad sets to exit learning phase faster
- Use cost caps carefully

---

## Notes

- All campaign specs are generated for manual input until APIs configured
- Client data stored locally (not synced)
- Brand voice from client profile applied to all ad copy
- Always confirm budget before generating campaigns
- Track campaign IDs after manual creation for future reference
