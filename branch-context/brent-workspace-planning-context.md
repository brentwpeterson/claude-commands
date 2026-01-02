# Resume Instructions for Claude

## IMMEDIATE SETUP
1. **Working directory:** `/Users/brent/scripts/CB-Workspace/brent-workspace`
2. **Run:** `/brent-start` to load daily operating system

## SESSION METADATA
**Last Commit:** `5e9a729 End of day - 2026-01-01 (Holiday)`
**Saved:** January 1, 2026

## MONDAY JAN 6 - FIRST THING

### URGENT: HubSpot Calendar
- [ ] Update HubSpot meeting scheduler to Hawaiian time

### Domain Consolidation (ContentBasis → ContentCucumber)

**Nameserver Migration:**
1. [ ] Update nameservers for contentcucumber.com at registrar → Route53
   - ns-1834.awsdns-37.co.uk
   - ns-432.awsdns-54.com
   - ns-1344.awsdns-40.org
   - ns-611.awsdns-12.net

2. [ ] Add `get.contentcucumber.com` in HubSpot (Settings → Domains & URLs)

3. [ ] Update landing page URLs from `landing.contentbasis.io` to `get.contentcucumber.com`

4. [ ] Update Route53 for contentbasis.io → S3 buckets
   - S3 endpoint: contentbasis.io.s3-website-us-east-1.amazonaws.com
   - Redirects to: contentcucumber.com/contentbasis

5. [ ] Test: visit contentbasis.io → should land on contentcucumber.com/contentbasis

## INFRASTRUCTURE READY (Created Jan 1)

| Asset | Status | Details |
|-------|--------|---------|
| S3 bucket: contentbasis.io | Ready | Redirects to contentcucumber.com/contentbasis |
| S3 bucket: www.contentbasis.io | Ready | Redirects to contentcucumber.com/contentbasis |
| Route53 hosted zone | Ready | Zone ID: Z0666747DC6UHMKN8YRO |
| get.contentcucumber.com | Ready | Points to HubSpot: 39487190.group40.sites.hubspot.net |
| /contentbasis page | Live | https://www.contentcucumber.com/contentbasis/ |

## PARTNER OUTREACH

**Mia Murphy (Tontine.ai):**
- HubSpot contact updated with personalization_paragraph
- Email sequence template: SEQ-PARTNER-001
- Ready to enroll in sequence after HubSpot templates created

**Email Template Location:** `brent-workspace/templates/email-sequences/SEQ-PARTNER-001.md`

## Q1 PAID ADS

**Plan:** LinkedIn first, then Meta
- Budget: $1-3k/mo
- Goal: Demo requests for Content Cucumber
- Landing page: get.contentcucumber.com/content-flywheel-plan (after migration)

## KEY FILES
- **MASTER-COMMITMENTS.md:** Monday tasks + Q1 brain dump
- **WORK-LOG.md:** Time tracking
- **SEQ-PARTNER-001.md:** Partner email sequence template

## COMMANDS AVAILABLE
- `/brent-start` - Daily operating system with time tracking
- `/brent-finish` - Day closeout with todo review
