# Resume Instructions for Claude

## SESSION STATUS
**Identity:** Claude-Hemingway
**Status:** ACTIVE
**Last Saved:** 2026-03-03 14:01
**Last Started:** 2026-03-04 05:17

## IMMEDIATE SETUP
1. **Directory:** `cd /Users/brent/scripts/CB-Workspace/astro-sites/sites/commerceking-ai`
2. **Branch:** master (astro-sites parent repo)
3. **Note:** commerceking-ai is not yet a git submodule. It's an untracked directory in astro-sites/sites/.

## WORKSPACES TOUCHED
| Shortcode | What was done |
|-----------|---------------|
| cc | CommerceKing infrastructure: Route53, email DNS, Astro site scaffolding |

## WHAT YOU WERE WORKING ON
Setting up infrastructure for the new CommerceKing (commerceking.ai) brand. AI-first ecommerce and CMS development services. March 22 splash launch target.

### Completed
1. **Route53 hosted zone** created: Zone ID `Z07501573GE23MVI7316H`
   - NS records: ns-203.awsdns-25.com, ns-638.awsdns-15.net, ns-1897.awsdns-45.co.uk, ns-1101.awsdns-09.org
   - Brent updated registrar with NS records
2. **Email DNS fully configured** for Google Workspace:
   - MX records (5 Google servers)
   - SPF: `v=spf1 include:_spf.google.com ~all`
   - DMARC: `v=DMARC1; p=quarantine; rua=mailto:dmarc@commerceking.ai; pct=100`
   - Google site verification TXT record added
   - DKIM 2048-bit TXT record added at `google._domainkey.commerceking.ai`
   - Brent clicked "Start authentication" in Google Admin
3. **Astro site scaffolded** from Astroship template:
   - Cloned to `astro-sites/sites/commerceking-ai/`
   - All Astroship content stripped and replaced with CommerceKing content
   - Site builds clean (8 pages, 3.3s)
   - Dev server confirmed working on port 3006

### Remaining Image Punch List
These Astroship images still need replacing:
| # | File | What it is | Action |
|---|------|-----------|--------|
| 1 | `public/favicon.svg` | Astro rocket logo | Replace with CommerceKing favicon |
| 2 | `public/opengraph.jpg` | Astroship homepage screenshot | Replace with CommerceKing OG image |
| 3 | `src/assets/hero.png` | Astronaut cartoon | Replace with CommerceKing hero image |
| 4 | `src/assets/hero-alt.png` | Alternate astronaut | Delete |
| 5 | `src/assets/hero-source.svg` | Source SVG of astronaut | Delete |
| 6 | `src/content/blog/welcome-to-commerceking.md` | Unsplash stock photo URL | Replace |
| 7 | `src/content/blog/kitchensink.mdx` | Lorem ipsum demo post | Delete |

### Other Remaining Items
- **Contact form:** Still uses Web3Forms API (4 references in `contactform.astro`). Needs decision on form handler (HubSpot forms, or own API key).
- **Landing page DNS (task #6):** Need to know hosting target before adding A/CNAME records.
- **Git submodule:** commerceking-ai needs to be set up as its own repo and added as a submodule to astro-sites.
- **Nginx config:** Need to add commerceking.ai routing to `deploy/nginx.conf` in astro-sites.
- **Comms reply (task #7):** Reply to Hemingway comms file with status update.

## TODO LIST STATE
- Completed: Domain registration confirmed, Route53 hosted zone created, email DNS configured (MX/SPF/DKIM/DMARC), Astro site scaffolded
- Pending: Image replacements, contact form handler, landing page DNS, git submodule setup, nginx config, comms reply

## NEXT ACTIONS
1. **FIRST:** Delete leftover Astroship images (#4, #5, #7 from punch list)
2. **THEN:** Brent provides replacement images for hero, favicon, OG image
3. **THEN:** Decide on contact form handler (HubSpot vs Web3Forms vs custom)
4. **THEN:** Set up commerceking-ai as its own git repo/submodule
5. **THEN:** Add commerceking.ai to nginx.conf and deploy infrastructure
6. **THEN:** Configure landing page DNS in Route53

## CONTEXT NOTES
- Brand plan document: `/Users/brent/scripts/CB-Workspace/brent-workspace/ob-notes/Brent Notes/Sales and Marketing/Company Websites/Content Cucumber/New Feature Plans/brand-merge-and-dev-services-launch.md`
- Comms file: `/Users/brent/scripts/CB-Workspace/.claude/claude-comms/hemingway-to-other-commerceking-route53-setup.md`
- CommerceKing is part of a broader brand reorganization (Content Basis merging into Content Cucumber, CK for dev services)
- March 22 splash launch, Shoptalk Spring March 24-26
- Brent's "After 5 years, I'm back in ecommerce" personal angle
- Vijay is the key development partner for this offering
