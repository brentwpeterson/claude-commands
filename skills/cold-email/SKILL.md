# Cold Email Skill

**Skill Description:** Cold email infrastructure, campaign operations, and outreach workflow. Covers Instantly campaigns, email provider setup, DNS/deliverability, lead management, and response handling.

---

## When Claude Should Apply This Skill

Apply automatically when:
- Working with Instantly (campaigns, accounts, leads, analytics)
- Setting up email sending infrastructure (domains, mailboxes, DNS)
- Managing cold email deliverability (SPF, DKIM, DMARC, warmup)
- Drafting or reviewing cold email sequences
- Processing campaign replies and routing responses
- User mentions cold email, outreach, Instantly, or campaign sending

---

## Team Roster

| Name | Company | Role | Email | Responsibility |
|------|---------|------|-------|---------------|
| **Brent Peterson** | CommerceKing | Strategy, Brand, PM | brent@contentbasis.io | Campaign approval, sequence writing, qualified lead handling |
| **Vijay** | Evrig | Leader, Dev Delivery | vijay@evrig.com | Partner since 2013 |
| **Sanjay** | Evrig | Technology, Architecture | sanjay@evrig.com | Technical lead |
| **Rushi** | Evrig | Sales Support | rushi@evrig.com | Lead sourcing, prospect staging, platform detection |
| **David Arago** | CommerceKing | Sales | TBD | Spain/England summer sales |
| **Isaac** | Content Cucumber | Content | - | Email sequence copywriting |

---

## Email Infrastructure

### Active Sending Accounts

| Account | Provider | Warmup Score | Status | Daily Limit |
|---------|----------|-------------|--------|-------------|
| brent@magento-masters.com | AWS WorkMail | 100 | Active | 30 |
| brent@evrigcommerce.com | Google Workspace | 100 | Active | 30 |
| brent@evrighq.com | Google Workspace | 100 | Active | 30 |
| brent@evrigdigital.com | Google Workspace | 100 | Active | 30 |
| brent.p@evrigdigital.com | Google Workspace | 100 | Active | 30 |
| brent@commercebasis.io | Zoho Mail Lite | Warming | Active | 5 |
| brent@commercecucumber.com | Namecheap Private Email | Warming | Active | 5 |

### DNS Setup Checklist (for new domains)

Every sending domain needs all of these in Route53:

1. **MX records** - Point to provider (Zoho: mx.zoho.com, mx2, mx3)
2. **SPF** - TXT record: `v=spf1 include:[provider] ~all`
3. **DKIM** - Provider-specific selector CNAME or TXT
4. **DMARC** - TXT record at `_dmarc.[domain]`: `v=DMARC1; p=none; rua=mailto:...`
5. **Verification** - Provider domain verification TXT/CNAME

### Route53 Hosted Zones

| Domain | Zone ID | Provider | Purpose |
|--------|---------|----------|---------|
| commercebasis.io | Z02367873JEFASCLEK3OQ | Zoho Mail Lite | Cold email sending |
| magento-masters.com | Z01202901YQ40DP2DCHXR | AWS WorkMail | Cold email sending |
| commerceking.us | Z0032409CV7876NZK6PE | Purelymail (blocked) | Not connected to Instantly |
| commerceking.online | Z06304431N3NF98UWSZLH | Purelymail (blocked) | Not connected to Instantly |
| commercecucumber.com | Z02908231SYCW9261QK8Q | Namecheap Private Email | Cold email sending |

### Provider Notes

| Provider | API | Works with Instantly | Cost | Notes |
|----------|-----|---------------------|------|-------|
| **Zoho Mail Lite** | Yes (REST) | Yes (imappro.zoho.com) | $1/mo/user | Preferred for new domains. IMAP must be enabled in settings. App password required. |
| **AWS WorkMail** | Yes (AWS SDK) | Yes | $4/mo/user | Sunsetting in ~1 year. Migrate off. |
| **Namecheap Private Email** | No | Yes | ~$1.50/mo | No API. Manual dashboard work. |
| **Purelymail** | Yes (MCP built) | No (TLS blocked) | $0.50/mo | Cannot connect to Instantly. Support confirmed. |
| **Google Workspace** | Yes | Yes | $7/mo/user | Evrig accounts. Most expensive but most reliable. |

### Adding a New Domain to Instantly (Zoho)

1. Register domain, point nameservers to Route53
2. Create Route53 hosted zone
3. Add domain in Zoho admin (mailadmin.zoho.com)
4. Add verification TXT to Route53
5. Add MX, SPF, DKIM, DMARC to Route53
6. Create mailbox in Zoho admin
7. Enable IMAP: mail.zoho.com > Settings > Mail accounts > IMAP tab > check IMAP Access
8. Generate app password: accounts.zoho.com > Security > App Passwords
9. Add to Instantly via API:
   ```bash
   curl -X POST "https://api.instantly.ai/api/v2/accounts" \
     -H "Authorization: Bearer $INSTANTLY_API_KEY" \
     -d '{"email":"...","provider_code":1,"imap_host":"imappro.zoho.com","imap_port":993,...}'
   ```
10. Enable warmup, set daily limit

---

## Active Campaigns

### USA Magento 2 Campaign
- **ID:** `0a99841e-ec80-495e-90a7-b7a59bfb07b3`
- **Status:** Active
- **Leads:** 643
- **Daily Limit:** 150 (5 accounts x 30)
- **Sequence:** 3 emails (security focus, 5x Magento Master positioning)
- **Sending Accounts:** brent@evrigcommerce.com, brent@magento-masters.com, brent@evrighq.com, brent@evrigdigital.com, brent.p@evrigdigital.com

### Magento - HubSpot Users
- **ID:** `516baecc-3f4e-42b6-8519-41bf2b2ad473`
- **Status:** Paused (not launched)
- **Leads:** 30
- **Sequence:** 3 emails (free HubSpot audit, landing page: contentcucumber.com/hubspot-audit/)
- **Sending Account:** brent@commercecucumber.com

### USA Magento 1 Campaign
- **ID:** `b3fa1114-c9f7-497a-93dd-41433bdef2d6`
- **Status:** Draft

### Shoptalk_Shopify
- **ID:** `540267ee-c2d8-4bc3-9eb8-a8425ca7cbb5`
- **Status:** Draft

---

## Response Handling Workflow

### Response Categories

| Type | Action |
|------|--------|
| **Interested** | Create HubSpot deal, schedule discovery call, notify Brent |
| **Not on Magento** | Forward to Rushi (rushi@evrig.com) to detect their platform. May fit other services. |
| **Unsubscribe** | Remove from campaign. Instantly handles auto if unsubscribe header is on. |
| **Auto-response / OOO** | Ignore. Instantly can auto-handle if `stop_on_auto_reply` is enabled. |
| **Negative / Not interested** | Note and move on. Do not reply. |
| **Wrong person** | Check if they forwarded to the right person. If not, find correct contact. |

### Routing Non-Magento Replies

When someone replies "I don't use Magento":

1. Check their website to detect platform (Wappalyzer or `/detect-platform`)
2. Draft email to Rushi (rushi@evrig.com) with lead details and detected platform
3. If on Shopify, BigCommerce, WooCommerce, or other supported platform, they may be a fit for other CommerceKing services

---

## Analytics

### Working API Endpoint

```bash
# Campaign analytics (all campaigns)
curl -s "https://api.instantly.ai/api/v2/campaigns/analytics" \
  -H "Authorization: Bearer $INSTANTLY_API_KEY"

# Lead-level data with reply counts
curl -s -X POST "https://api.instantly.ai/api/v2/leads/list" \
  -H "Authorization: Bearer $INSTANTLY_API_KEY" \
  -d '{"campaign_id":"...","limit":100}'
```

### Available Metrics

- leads_count, contacted_count, emails_sent_count
- open_count (only if open_tracking enabled)
- reply_count, reply_count_unique
- link_click_count (only if link_tracking enabled)
- bounced_count, unsubscribed_count
- total_opportunities, total_opportunity_value

### Not Available via API

- Unified inbox / reply content (UI only)
- Deliverability reports
- Inbox placement tests

---

## MCP Tools Reference

### Instantly (Cold Email Campaigns)

| Tool | When to Use |
|------|-------------|
| `mcp__instantly__instantly_list_campaigns` | See all campaigns |
| `mcp__instantly__instantly_get_campaign` | Get campaign details |
| `mcp__instantly__instantly_launch_campaign` | Launch (only after Brent approves) |
| `mcp__instantly__instantly_pause_campaign` | Pause a campaign |
| `mcp__instantly__instantly_list_leads` | List leads in a campaign |
| `mcp__instantly__instantly_add_lead` | Add a lead to a campaign |
| `mcp__instantly__instantly_get_lead` | Check lead status |
| `mcp__instantly__instantly_update_lead` | Update lead info |
| `mcp__instantly__instantly_delete_lead` | Remove a lead |
| `mcp__instantly__instantly_list_accounts` | List sending accounts |
| `mcp__instantly__instantly_get_account` | Get account details |

### Purelymail (Domain/Mailbox Management)

MCP server at `mcp-servers/purelymail/` with 17 tools. Not usable with Instantly but still manages commerceking domains.

### Key API Patterns

**Add account to Instantly (Zoho):**
```json
{
  "email": "...",
  "provider_code": 1,
  "imap_host": "imappro.zoho.com",
  "imap_port": 993,
  "smtp_host": "smtppro.zoho.com",
  "smtp_port": 465,
  "warmup_enabled": true,
  "daily_limit": 5
}
```

**Add account to Instantly (WorkMail):**
```json
{
  "email": "...",
  "provider_code": 1,
  "imap_host": "imap.mail.us-east-1.awsapps.com",
  "imap_port": 993,
  "smtp_host": "smtp.mail.us-east-1.awsapps.com",
  "smtp_port": 465
}
```

**Update campaign sending accounts:**
```bash
curl -X PATCH "https://api.instantly.ai/api/v2/campaigns/{id}" \
  -d '{"email_list": ["account1@...", "account2@..."], "daily_limit": 60}'
```

### HubSpot (CRM Pipeline for Qualified Leads)

| Tool | When to Use |
|------|-------------|
| `mcp__hubspot__hubspot-search-objects` | Search contacts, deals, companies |
| `mcp__hubspot__hubspot-batch-create-objects` | Bulk create contacts from prospect lists |
| `mcp__hubspot__hubspot-create-engagement` | Log calls, meetings, notes |
| `mcp__hubspot-extended__hubspot_enroll_in_sequence` | Enroll contacts in outreach sequences |

**Workflow:** Qualified Instantly replies become HubSpot deals. Brent handles discovery meetings.

---

## Shared Vault (Evrig-Cucumber)

**Path:** `/Users/brent/Library/CloudStorage/GoogleDrive-brent@contentbasis.io/Shared drives/Evrig-Cucumber`

| Folder | Contents |
|--------|----------|
| `Cold Email Outbound/` | Sequences, ICP targeting, Instantly campaigns |
| `ICPs & Prospects/` | Ideal customer profiles, prospect lists |

---

## Outreach Workflow

1. Rushi sources contacts and stages in Google Sheets
2. Brent/Isaac approve email sequences
3. Rushi loads leads into Instantly (`instantly_add_lead`)
4. Brent launches campaign (`instantly_launch_campaign`)
5. Rushi monitors replies, Brent handles qualified leads

---

## Integration with Other Skills

| Skill/Command | When to Use |
|---------------|-------------|
| `/detect-platform` | Check what platform a reply lead is using |
| `/hubspot-sales` | When working qualified leads in HubSpot |
| `/brand-brent` | Before writing any outreach content |
| `/hubspot-enrich` | Enrich contact before outreach |

---

## Key Learnings

- Purelymail IMAP does not work with Instantly (TLS handshake fails from Instantly servers). Confirmed by Purelymail support.
- Zoho Mail Lite requires IMAP enabled manually (Settings > Mail accounts > IMAP tab) AND an app password (accounts.zoho.com > Security > App Passwords).
- Zoho Mail Lite uses `imappro.zoho.com` / `smtppro.zoho.com` (NOT imap.zoho.com).
- AWS WorkMail is sunsetting. 1 year to migrate off. Zoho is the replacement.
- Campaign daily_limit is total across all accounts. Account daily_limit is per account. Instantly uses the lower of the two.
- Open tracking is disabled on Magento campaigns (cold email best practice to avoid spam filters).
- The analytics endpoint is `GET /api/v2/campaigns/analytics` (not per-campaign).
- "Not on Magento" replies are leads worth routing to Rushi for platform detection. They may fit other services.

---

*Last Updated: 2026-04-07*
