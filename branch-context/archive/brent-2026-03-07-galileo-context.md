# Resume Instructions for Claude

## SESSION STATUS
**Identity:** Claude-Galileo
**Status:** ACTIVE
**Last Saved:** 2026-03-07 14:57
**Last Started:** 2026-03-07 19:00

## IMMEDIATE SETUP
1. **Directory:** `cd /Users/brent/scripts/CB-Workspace/brent-workspace`
2. **Branch:** `git checkout main`
3. **Last Commit:** `f251719 Add RD feature series blog post: Brand Persona`

## WORKSPACES TOUCHED
| Shortcode | What was done |
|-----------|---------------|
| brent | TWC W28 finalized, TC WordPress Lightsail migration, /brent-finish |

## WHAT YOU WERE WORKING ON

### TC WordPress Migration to AWS Lightsail (IN PROGRESS)
Migrated Talk Commerce WordPress from Flywheel to AWS Lightsail. Instance is running, DB imported, SSL configured.

**Infrastructure details:**
- Lightsail instance: `wp-talk-commerce` ($7/month, micro_3_0, 1GB RAM, IPv4)
- Static IP: 23.20.52.57
- Domain: tc.requestdesk.ai (A record in Route 53, zone Z06505522E1CLAKKZ2AZ5)
- SSL: Let's Encrypt via certbot, auto-renews, expires 2026-06-05
- Architecture: Apache (host) reverse proxies HTTPS to Docker WP container on 127.0.0.1:8080
- SSH: `ssh -i .claude/local/lightsail-key.pem ubuntu@23.20.52.57`
- Docker compose: `~/wp-talk-commerce/docker-compose.yml`
- DB table prefix: `wp_arl8egadss_`
- WordPress login: `brentwpeterson` / `test1234`
- IAM user for SES SMTP: `ses-smtp-tc-wordpress` (AKIA6FOBYEJLYN7AAHNF)

**What's done:**
1. Lightsail instance created, static IP attached
2. Docker + Docker Compose installed
3. WordPress + MariaDB containers running
4. Database imported (collation fixed: utf8mb4_0900_ai_ci -> utf8mb4_unicode_ci)
5. Password reset, admin login working
6. DNS: tc.requestdesk.ai -> 23.20.52.57
7. SSL: certbot with Apache reverse proxy, HTTP->HTTPS redirect
8. Reverse proxy SSL fix: mu-plugin for X-Forwarded-Proto (fixed redirect loop)
9. msmtp installed with SES SMTP credentials configured
10. TC wp-content put into git repo at wordpress-sites/talk-commerce/

**What's NOT done:**
- Email testing (user needs to test password reset from wp-login)
- Astro site cutover to new API endpoint
- RequestDesk connector plugin verification
- 1-week soak period before removing from Flywheel
- Flywheel plan downgrade

### Also completed this session:
- TWC W28 finalized (cross-refs, brand-brent audit, SCHEDULED Mar 31)
- TWC pipeline complete through March 31
- /brent-finish run (work log updated, context files triaged)

## NEXT ACTIONS
1. **FIRST:** User tests email from tc.requestdesk.ai (password reset)
2. **THEN:** Verify REST API at https://tc.requestdesk.ai/wp-json/wp/v2/posts
3. **THEN:** Update Astro site to point at tc.requestdesk.ai API
4. **THEN:** 1-week soak, then remove TC from Flywheel
5. **THEN:** Downgrade Flywheel to 1-site plan ($25/month for CC)

## CONTEXT NOTES
- msmtp config is inside the container (not persistent across container rebuilds). Need to bake it into a Dockerfile or mount as volume for permanence.
- The mu-plugin for reverse-proxy-ssl.php is also inside the container volume. Same persistence concern.
- TC is headless. Theme files are irrelevant. Only DB + plugins matter.
- wp-infra/ directory created at CB-Workspace root with docker-compose.yml
- Migration plan in Obsidian: Talk Commerce/tc-wordpress-migration-plan.md
- Same setup can host CC later on bigger instance if Flywheel cancelled entirely

## DEFERRED QUESTIONS
1. **Email test:** "Did the password reset email arrive from tc.requestdesk.ai?"
2. **Flywheel timeline:** "When does the Flywheel plan renew? Need to time the downgrade."
