# Resume Instructions for Claude

## SESSION STATUS
**Identity:** Claude-Galileo
**Status:** SAVED
**Last Saved:** 2026-03-08 19:45
**Last Started:** 2026-03-07 19:00

## IMMEDIATE SETUP
1. **Directory:** `cd /Users/brent/scripts/CB-Workspace/brent-workspace`
2. **Branch:** `git checkout main`
3. **Last Commit:** `871a76f Add TRANSISTOR_API_KEY to ECS task definition` (astro-sites)

## WORKSPACES TOUCHED
| Shortcode | What was done |
|-----------|---------------|
| brent | Work log updates, session management |
| astro | Switched TC WordPress URL to Lightsail, deployed |

## WHAT YOU WERE WORKING ON

### TC WordPress Migration to AWS Lightsail (IN PROGRESS - S3 PHASE)

**Infrastructure details:**
- Lightsail instance: `wp-talk-commerce` ($7/month, micro_3_0, 1GB RAM, IPv4)
- Static IP: 23.20.52.57
- Domain: tc.requestdesk.ai (A record in Route 53, zone Z06505522E1CLAKKZ2AZ5)
- SSL: Let's Encrypt via certbot, auto-renews
- Architecture: Apache (host) reverse proxies HTTPS to Docker WP container on 127.0.0.1:8080
- SSH: `ssh -i .claude/local/lightsail-key.pem ubuntu@23.20.52.57`
- Docker compose: `~/wp-talk-commerce/docker-compose.yml`
- DB table prefix: `wp_arl8egadss_`
- WordPress login: `brentwpeterson` / `test1234`
- IAM user for SES SMTP: `ses-smtp-tc-wordpress` (AKIA6FOBYEJLYN7AAHNF)

**What's done (this session):**
1. Fixed email: msmtprc permissions changed from 600 to 644 so www-data can read it
2. Fixed msmtp.log permissions (666) so www-data can write
3. Installed all 43 plugins from Flywheel (copied via tarball)
4. Upgraded WordPress 6.7.4 -> 6.9.1 (docker image `wordpress:6-php8.2-apache`)
5. Activated all plugins (feedzy-rss-feeds disabled - crashes on 6.9.1)
6. Added 1GB swap file (persists via /etc/fstab) - prevented OOM
7. Capped Apache workers at 3 (MaxRequestWorkers 3) - saves ~200MB RAM
8. Switched Astro site: Dockerfile + supervisord.conf now point to tc.requestdesk.ai
9. Updated GitHub secret TALKCOMMERCE_WORDPRESS_API_KEY to headless key: lHHAlJ5LUIEzgRfaUpwApie7O68LkWvo
10. Added TRANSISTOR_API_KEY to GitHub secrets + deploy workflow (was missing, crashed container)
11. Deployed astro-sites tag: sites-v2026.03.08-tc-lightsail-cutover-2 (SUCCESS)
12. Uploaded 6.9GB uploads to container
13. Created S3 bucket: tc-wordpress-uploads (public read)
14. Created CloudFront distribution: E2E9DGLCE8HFP7 (d1r8ejawhm7f47.cloudfront.net)
15. Created IAM user: tc-wordpress-s3 (AKIA6FOBYEJL2IEXWN3H)
16. Installed s3fs on Lightsail, mounted bucket at /mnt/tc-uploads
17. Added s3fs to fstab for auto-mount on reboot
18. Updated docker-compose.yml to bind-mount /mnt/tc-uploads/uploads -> /var/www/html/wp-content/uploads
19. Added .htaccess rewrite: /wp-content/uploads/* -> CloudFront 301 redirect
20. S3 sync from local was in progress (aws s3 sync) - 7400+ files, ~2.5GB of 6.8GB done
21. Updated upload_url_path in DB to https://d1r8ejawhm7f47.cloudfront.net/uploads

**What's NOT done:**
- S3 sync may not be complete - CHECK: `aws s3 ls s3://tc-wordpress-uploads/uploads/ --recursive --summarize | tail -2`
- Container NOT yet recreated with S3 mount (docker-compose updated but not restarted)
- Need to recreate container: `cd ~/wp-talk-commerce && docker compose up -d talk-commerce`
- After recreate: re-apply msmtp config + Apache worker limits (not persistent)
- Photon/Jetpack CDN returns 400 on images behind 301 redirect - may need to disable Photon
- Image URL chain: posts use i0.wp.com -> tc.requestdesk.ai -> 301 -> CloudFront. Photon can't follow 301s.
- Need to either: (a) disable Jetpack Photon, or (b) search-replace image URLs in DB to use CloudFront directly
- Persist msmtp config and Apache tuning across container rebuilds (Dockerfile or volume mount)
- Test password reset email (user confirmed it works)
- 1-week soak period before removing TC from Flywheel
- Flywheel plan downgrade timing

## NEXT ACTIONS (PRIORITY ORDER)
1. **FIRST:** Check if S3 sync completed. If not, wait or re-run.
2. **THEN:** Recreate WP container with S3 mount: `cd ~/wp-talk-commerce && docker compose up -d talk-commerce`
3. **THEN:** Re-apply msmtp + Apache tuning after container recreate
4. **THEN:** Fix image loading. Options:
   - Disable Jetpack Photon module (headless site doesn't need it)
   - Or search-replace DB URLs from i0.wp.com/tc.requestdesk.ai/wp-content/uploads/ to d1r8ejawhm7f47.cloudfront.net/uploads/
5. **THEN:** Verify images load on live talk-commerce.com site
6. **THEN:** Create a proper Dockerfile for the WP container that bakes in msmtp + Apache config
7. **THEN:** Start 1-week soak period, plan Flywheel downgrade

## CONTEXT NOTES
- msmtp config is inside the container (not persistent across container rebuilds). Need to bake into Dockerfile or mount as volume.
- The mu-plugin for reverse-proxy-ssl.php is on the wp-content volume (persistent).
- TC is headless. Theme files are irrelevant. Only DB + plugins + uploads matter.
- wp-infra/ directory created at CB-Workspace root with docker-compose.yml
- Migration plan in Obsidian: Talk Commerce/tc-wordpress-migration-plan.md
- Same setup can host CC later on bigger instance if Flywheel cancelled entirely
- The old Flywheel site (wp.talk-commerce.com) is still running as fallback
- Image URLs in DB still reference gpsites.co (original host) - WordPress/Jetpack rewrites them at runtime
- CloudFront distribution may still be deploying (takes 5-10 min from creation)

## DEFERRED QUESTIONS
1. **Flywheel timeline:** "When does the Flywheel plan renew? Need to time the downgrade."
2. **Image strategy:** "Do you want to disable Jetpack Photon entirely since we have CloudFront?"
