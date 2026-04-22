# Email Accounts Index

Master index of all email accounts across providers, organized by Workspace org and provider.

Last updated: 2026-04-10

---

## Google Workspace: Content Cucumber (contentcucumber.com)

**GAM Config:** default (already configured)
**Customer ID:** C02luy2gv
**Admin:** brent@contentbasis.io
**Cost:** Standard US pricing (~$7/user/mo)

### Domains

| Domain | Type | Verified |
|--------|------|----------|
| contentcucumber.com | Primary | Yes |
| contentbasis.io | Secondary | Yes |
| gotcontent.io | Secondary | Yes |
| talk-commerce.com | Alias | Yes |
| contentbasis.ai | Alias | Yes |
| requestdesk.ai | Alias | Yes |
| brent.run | Alias | Yes |
| commerceking.ai | Alias | Yes |

### Users (23 total)

| Email | Status | Purpose |
|-------|--------|---------|
| brent@contentbasis.io | Active | Primary Brent account |
| isaac@contentcucumber.com | Active | Content lead |
| vijay@contentcucumber.com | Active | Evrig partner |
| susan@contentbasis.io | Active | |
| info@contentcucumber.com | Active | General inbox |
| ashley.hanson@contentcucumber.com | Active | |
| ashley.hemsath@contentcucumber.com | Active | |
| audry.fryer@contentcucumber.com | Active | |
| caitlin@contentcucumber.com | Active | |
| chris@contentcucumber.com | Active | |
| connor@contentcucumber.com | Active | |
| david@contentcucumber.com | Active | |
| dylan@contentcucumber.com | Active | |
| hannah@contentcucumber.com | Active | |
| julian@contentcucumber.com | Active | |
| juno@contentcucumber.com | Active | |
| leigh@contentcucumber.com | Active | |
| ryder@contentcucumber.com | Active | |
| sam@contentcucumber.com | Active | |
| sara@contentcucumber.com | Active | |
| sarah.spencer@contentcucumber.com | Active | |
| sarah@contentcucumber.com | Active | |
| tjvasquez@contentcucumber.com | Active | |

---

## Google Workspace: Evrig Orgs (Vijay's, India pricing ~$2/user/mo)

**GAM Config:** TBD (need admin access from Vijay)
**Status:** Pending access
**Passwords:** `.claude/local/evrig-email.env` (gitignored)

### evrighq.com (3 accounts)

| # | Account | Type | Warmup | Instantly Score |
|---|---------|------|--------|----------------|
| 1 | vijay@evrighq.com | Master | Yes | 100 |
| 2 | brent@evrighq.com | Secondary | Yes | 100 |
| 3 | vijay.golani@evrighq.com | Secondary | Yes | 100 |

### evrigdigital.com (3 accounts)

| # | Account | Type | Warmup | Instantly Score |
|---|---------|------|--------|----------------|
| 4 | vijay@evrigdigital.com | Master | Yes | 100 |
| 5 | brent@evrigdigital.com | Secondary | Yes | 100 |
| 6 | brent.p@evrigdigital.com | Secondary | Yes | 100 |

### evrigcommerce.com (3 accounts)

| # | Account | Type | Warmup | Instantly Score |
|---|---------|------|--------|----------------|
| 7 | vijay@evrigcommerce.com | Master | Yes | 100 |
| 8 | brent@evrigcommerce.com | Secondary | Yes | 100 |
| 9 | vijay.golani@evrigcommerce.com | Secondary | Yes | 98 |

### evrigsolutions.com (4 accounts)

| # | Account | Type | Warmup | Instantly Score |
|---|---------|------|--------|----------------|
| 10 | vijay@evrigsolutions.com | Master | Yes | 100 |
| 11 | vijay.golani@evrigsolutions.com | Secondary | Started | - |
| 12 | sanjay@evrigsolutions.com | Secondary | Started | - |
| 13 | brent@evrigsolutions.com | Secondary | Started | - |

### To Do (after Vijay grants access)

- [ ] Get admin access on each Workspace org
- [ ] Create GAM project/config for each org
- [ ] Add evrigsolutions accounts to Instantly (3 not yet connected)
- [ ] Determine if more domains needed

---

## Zoho Mail Lite (commercebasis.io)

**Admin:** mailadmin.zoho.com
**Cost:** $1/user/mo (yearly)
**API:** Yes (REST, https://www.zoho.com/mail/help/api/)

| Account | IMAP | Instantly | Warmup Score |
|---------|------|----------|-------------|
| brent@commercebasis.io | imappro.zoho.com:993 | Connected | Warming |

### Zoho Credentials

- IMAP/SMTP app password required (accounts.zoho.com > Security > App Passwords)
- IMAP must be enabled manually (mail.zoho.com > Settings > Mail accounts > IMAP tab)
- Servers: imappro.zoho.com (IMAP), smtppro.zoho.com (SMTP)

---

## AWS WorkMail (magento-masters.com)

**Org ID:** m-b86edfd1311947e5a4a9be99093e47d8
**Alias:** commercecucumber
**Cost:** $4/user/mo (SUNSETTING - migrate within 1 year)

| Account | Status | Instantly | Warmup Score |
|---------|--------|----------|-------------|
| brent@magento-masters.com | Enabled | Connected | 100 |

### WorkMail DNS (Route53 zone Z01202901YQ40DP2DCHXR)

- MX, SPF, DKIM, DMARC all verified
- IMAP: imap.mail.us-east-1.awsapps.com:993
- SMTP: smtp.mail.us-east-1.awsapps.com:465

---

## Namecheap Private Email (commercecucumber.com)

**Cost:** ~$1.50/mo
**API:** None (manual dashboard only)

| Account | Instantly | Warmup Score |
|---------|----------|-------------|
| brent@commercecucumber.com | Connected | Warming |

### DNS (Route53 zone Z02908231SYCW9261QK8Q)

- MX: mx1/mx2.privateemail.com
- SPF, DKIM configured
- DMARC: Still needed

---

## Purelymail (commerceking domains)

**Cost:** $0.50/mo/mailbox
**API:** Yes (MCP server at mcp-servers/purelymail/)
**Status:** BLOCKED - Cannot connect to Instantly (TLS handshake fails)

| Account | Status | Instantly |
|---------|--------|----------|
| brent@commerceking.us | Active | NOT connected |
| brent@commerceking.online | Active | NOT connected |

These domains need to be moved to a working provider (Zoho or Vijay's Workspace).

---

## GAM Quick Reference

```bash
# List all users
gam print users fields primaryEmail,suspended

# List all domains
gam print domains

# Create a user
gam create user email@domain.com firstname First lastname Last password 'P@ssw0rd'

# Add a domain
gam create domain domainname.com

# Delete a user
gam delete user email@domain.com

# Update user password
gam update user email@domain.com password 'NewP@ss'

# Switch between Workspace orgs (once configured)
gam select project_name
```

### Multi-Org Setup (when Vijay grants access)

```bash
# Create new GAM project for Vijay's org
gam create project
# Follow OAuth flow with Vijay's admin account
# Each org gets its own section in gam.cfg
```

---

## Instantly Account Summary

| Account | Provider | Score | Daily Limit | Campaign |
|---------|----------|-------|-------------|----------|
| brent@evrigcommerce.com | Google Workspace | 100 | 30 | Magento 2 |
| brent@evrighq.com | Google Workspace | 100 | 30 | Magento 2 |
| brent@evrigdigital.com | Google Workspace | 100 | 30 | Magento 2 |
| brent.p@evrigdigital.com | Google Workspace | 100 | 30 | Magento 2 |
| brent@magento-masters.com | AWS WorkMail | 100 | 30 | Magento 2 |
| brent@commercebasis.io | Zoho Mail | Warming | 5 | None yet |
| brent@commercecucumber.com | Namecheap | Warming | 5 | HubSpot Users (paused) |
| vijay.golani@evrigcommerce.com | Google Workspace | 98 | 5 | - |
| vijay.golani@evrighq.com | Google Workspace | 100 | 5 | - |
| vijay@evrigcommerce.com | Google Workspace | 100 | 5 | - |
| vijay@evrigdigital.com | Google Workspace | 100 | 5 | - |
| vijay@evrighq.com | Google Workspace | 100 | 5 | - |
| vijay@evrigsolutions.com | Google Workspace | 100 | 5 | - |
