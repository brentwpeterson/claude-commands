# HubSpot Product Knowledge

Reference guide for HubSpot's product ecosystem. Used when writing content about CC's HubSpot services to ensure accuracy.

---

## The Six Hubs

| Hub | Purpose | CC Service Focus |
|-----|---------|-----------------|
| **Marketing Hub** | Attract and convert leads (email, automation, SEO, social, ads) | YES - Implementation & content |
| **Sales Hub** | Close deals faster (CRM, sequences, quotes, forecasting) | YES - Implementation |
| **Service Hub** | Customer support (tickets, knowledge base, feedback) | Aware, not primary |
| **CMS Hub** | Website management (drag-drop editor, themes, blog) | YES - Build & migration |
| **Operations Hub** | Data sync, automation, reporting | Aware, not primary |
| **Commerce Hub** | Payments, invoices, subscriptions | Aware, not primary |

---

## Tier Differences

| Tier | Price Range | Key Differences |
|------|-------------|-----------------|
| **Free** | $0 | Basic CRM, forms, email (limits), 1 pipeline |
| **Starter** | ~$20/mo per seat | Remove HubSpot branding, more limits raised, basic automation |
| **Professional** | ~$890-1,600/mo | Full automation, sequences, custom reporting, teams, A/B testing |
| **Enterprise** | ~$3,600+/mo | Advanced permissions, custom objects, predictive scoring, sandbox |

**Note:** Pricing changes frequently. Use ranges and "starting at" language, not exact figures. Always direct readers to HubSpot.com for current pricing.

**CC's sweet spot:** Professional tier. Most clients are paying for Pro but only using Starter-level features. That's the gap CC fills.

---

## CMS Hub Deep Dive

CMS Hub is HubSpot's website platform. CC builds and migrates sites here.

### Core Features
- **Drag-and-drop editor** - Visual page builder, no code required for basic edits
- **HubL templating** - HubSpot's template language (Jinja2-like syntax)
- **Themes** - Pre-built or custom themes with modules
- **Modules** - Reusable content blocks (testimonials, CTAs, forms, galleries)
- **Serverless functions** - Backend logic without separate hosting
- **Smart content** - Show different content based on visitor attributes (lifecycle stage, device, country)
- **Blog platform** - Built-in blog with SEO recommendations, topic clusters
- **CDN** - Global content delivery, SSL included, 99.99% uptime SLA
- **Memberships** - Gated content for logged-in users
- **Multi-language** - Built-in translation management

### CMS Hub vs WordPress (honest comparison)

| Feature | HubSpot CMS | WordPress |
|---------|-------------|-----------|
| Hosting | Included, managed | Self-managed or hosted |
| Security | HubSpot handles patches, SSL, WAF | Plugin-dependent, manual updates |
| Speed | CDN included, optimized | Depends on hosting + optimization |
| CRM integration | Native, seamless | Requires plugins, often janky |
| Plugin ecosystem | Smaller marketplace | Massive (60,000+ plugins) |
| Customization | HubL + modules (some limits) | Unlimited (PHP + any framework) |
| Cost | Included in CMS Hub tier | Hosting + plugins + maintenance |
| Content personalization | Built-in smart content | Requires plugins or custom code |
| Blogging | Good, SEO tools built in | Excellent, more flexibility |
| E-commerce | Limited (Commerce Hub) | WooCommerce is very mature |

**CC's honest take:** HubSpot CMS is ideal when CRM integration matters more than unlimited customization. It's not the right fit for every site, and CC will say so.

---

## Sales Hub Pro Deep Dive

Sales Hub Pro is where most clients are underutilizing. CC implements and configures it.

### Key Pro Features
- **Sequences** - Automated email + task cadences for outreach
  - Up to 500 sequence enrollments per user per day (Pro)
  - Email, task, and LinkedIn steps
  - A/B test within sequences
- **Playbooks** - Guided scripts for calls and meetings
  - Discovery call frameworks
  - Demo scripts
  - Objection handling guides
- **Quotes** - Professional proposal generation
  - E-signatures built in
  - Payment collection (Stripe integration)
  - Custom quote templates
- **Pipeline management** - Multiple deal pipelines
  - Custom deal stages
  - Required properties per stage
  - Automation on stage changes
- **Forecasting** - Revenue prediction
  - Manual + AI-powered forecasts
  - Team-level and individual views
  - Weighted pipeline calculations
- **Custom reporting** - Build any report from CRM data
  - Cross-object reporting
  - Attribution reporting
  - Scheduled email delivery

### Common Sales Hub Pro mistakes CC fixes
1. Only one pipeline when multiple are needed (new business vs upsell vs renewal)
2. Sequences with generic templates instead of personalized content
3. No playbooks (reps wing every call)
4. Required properties not set (deals move stages without data)
5. No forecasting discipline (pipeline is a guess)

### 10 Reasons to Upgrade to Sales Hub Pro (Sales Enablement)

Use this list for pitching, landing pages, videos, and conference conversations. Ordered by impact.

1. **Sequences for Automated Outreach** - Enroll leads in personalized, automated email sequences to nurture prospects. Sequences stop automatically once a prospect engages.
2. **Advanced Sales Automation (Workflows)** - Automate routine tasks, internal notifications, and multi-stage sales processes. Reps spend more time selling, less time on admin.
3. **AI-Powered Sales Tools (Breeze Assistant)** - AI drafts emails, creates call summaries, and updates CRM records automatically.
4. **Multiple Deal Pipelines** - Manage different sales processes (new business, renewals, upsells) using separate, customized pipelines.
5. **Sales Analytics and Forecasting** - Predict future revenue with real-time data. Team and individual performance visibility for better strategic decisions.
6. **Custom Reporting and Dashboards** - Build tailored reports to track the metrics that matter. Deep visibility into sales activity across the team.
7. **Conversation Intelligence (Call Recording)** - Record and analyze sales calls for coaching, detail tracking, and performance improvement.
8. **Prospecting Workspace** - Unified workspace for reps to manage daily activities, prioritize leads, and spot buying signals early.
9. **Required Fields and Goal Setting** - Standardize data entry and set trackable goals to drive accountability across the team.
10. **Seamless Tool Integration** - Connects with Salesforce, LinkedIn Sales Navigator, and other tools. Native integration with HubSpot Marketing and Service Hubs for a unified customer view.

### Objection Handling

| Objection | Response |
|-----------|----------|
| "We already have a CRM" | Sales Hub Pro isn't just a CRM. It's automation, AI, and analytics on top of the CRM. Most CRMs stop at contact storage. |
| "It's too expensive" | Companies paying for Pro but using it like Starter are wasting money. The tool pays for itself when sequences and automation are actually configured. |
| "Our team won't adopt it" | That's an implementation problem, not a tool problem. Playbooks, required fields, and the prospecting workspace make adoption natural. CC handles the setup so your team walks into a working system. |
| "We tried HubSpot before" | Most failed HubSpot implementations had zero content in the sequences and no pipeline structure. CC fills the tools with real content from day one. |
| "Can't we just use free/Starter?" | Free and Starter don't have sequences, custom reporting, forecasting, or workflows. Those are the features that actually move revenue. |

### ROI Talking Points
- Average sales rep spends 65% of time on non-selling activities. Sequences and workflows reclaim that time.
- Companies using sales automation see 10-15% higher win rates (HubSpot benchmark data).
- One closed deal from a properly configured sequence can pay for a year of Sales Hub Pro.
- Forecasting accuracy alone justifies the upgrade. You can't manage what you can't predict.

---

## Marketing Hub Pricing

### Starter Promotional Pricing

Save up to 40% off Starter. New customers only. No set end date, may be discontinued at any time.

| Billing | Current Price | Was |
|---------|--------------|-----|
| Annual | $9/mo | $15/mo |
| Monthly | $15/mo | $20/mo |

### Marketing Contacts Model

You only pay for **marketing contacts**, which are contacts you target with marketing emails and ads. Non-marketing contacts are stored in your CRM for free, up to 15 million overall contacts (marketing + non-marketing combined).

**Key rules:**
- Once you select a contact tier, you **cannot downgrade until your contract renews**
- You can change marketing contacts to non-marketing contacts at any time
- Status updates are processed **once a month**

### Contact Tier Pricing (Marketing Hub Starter)

| Marketing Contacts | Cost |
|-------------------|------|
| First 1,000 | $0 (included) |
| 1,000 to 3,000 | $50/mo per 1,000 |
| 4,000 to 5,000 | $45/mo per 1,000 |
| 6,000+ | $40/mo per 1,000 |

**Billing method:** Contacts are billed in minimum quantities of 1,000 at a **blended rate** based on the number of marketing contacts and the rate that applies. It is NOT an overall rate.

**Example:** 4,000 marketing contacts:
- First 1,000: $0
- Next 2,000 (1,001-3,000): 2 x $50 = $100/mo
- Next 1,000 (3,001-4,000): 1 x $45 = $45/mo
- **Total: $145/mo** in contact fees

### Email Send Limits

| Limit | Renewal |
|-------|---------|
| 5x your number of marketing contacts | Monthly |

Example: 1,000 marketing contacts = 5,000 email sends per month.

### Important Notes

- Prices are subject to applicable tax
- Fees may increase with additional purchases and additional marketing contacts
- Contact pricing shown is for **Marketing Hub Starter only**. Pro and Enterprise have different contact pricing (see HubSpot Product and Services Catalog)
- Additional CRM limits and API limits apply (see HubSpot Product and Services Catalog)

---

## Marketing Hub Pro Deep Dive

Marketing Hub Pro powers content distribution and lead nurturing.

### Key Pro Features
- **Marketing automation (workflows)** - If/then branching, delays, multi-channel
  - Lead nurturing sequences
  - Internal notification workflows
  - Data cleanup automation
  - Re-engagement campaigns
- **ABM (Account-Based Marketing)** - Target specific companies
  - Target account lists
  - Company scoring
  - Account overview dashboard
- **SEO & topic clusters** - Content strategy tool
  - Topic cluster visualization
  - SEO recommendations per page
  - Content strategy planning
- **Social media** - Schedule and monitor
  - Multi-platform publishing
  - Social inbox
  - ROI tracking
- **A/B testing** - Test emails, CTAs, landing pages
  - Statistical significance tracking
  - Multivariate testing (Enterprise)
- **Campaign management** - Group assets into campaigns
  - Attribution reporting per campaign
  - Budget tracking
  - Cross-channel analytics
- **Lead scoring** - Custom + predictive
  - Property-based scoring rules
  - Behavioral scoring (page views, email clicks)
  - HubSpot AI predictive score

### The CC angle on Marketing Hub
CC doesn't just set up the tools. CC creates the content that goes into them:
- Workflow emails are written by CC writers, not template placeholders
- Blog content follows topic cluster strategy defined in HubSpot
- Landing pages match the HubSpot theme design system
- Lead nurture sequences have real, valuable content at each stage

---

## HubSpot Ecosystem

### Marketplace
- 1,500+ integrations (native + third-party)
- App Marketplace for tools
- Asset Marketplace for templates and themes

### Key Integrations CC Works With
- **Shopify** - E-commerce sync (CC has a Shopify app)
- **WordPress** - HubSpot WP plugin for forms, CRM, tracking
- **Salesforce** - Bi-directional CRM sync
- **Slack** - Notifications and deal alerts
- **Zoom** - Meeting scheduling integration
- **Google Workspace** - Calendar, email logging
- **Stripe** - Payment processing

### Partner Program
- **Solutions Partners** - Agencies that sell, implement, and service HubSpot
- **App Partners** - Companies that build integrations
- CC is a **Solutions Partner** providing implementation + content services

### API
- RESTful API with comprehensive documentation
- Custom integrations for data sync
- Webhook support for real-time events
- CC builds custom integrations when needed (RequestDesk connector is an example)
