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
