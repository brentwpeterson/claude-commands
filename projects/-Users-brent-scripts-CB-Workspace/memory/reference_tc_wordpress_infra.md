---
name: Talk Commerce WordPress Infrastructure
description: SSH access, Docker setup, plugin deployment for tc.requestdesk.ai on AWS Lightsail
type: reference
---

## Talk Commerce WordPress (tc.requestdesk.ai)

**Server:** AWS Lightsail instance at `23.20.52.57`
**SSH:** `ssh -i ~/.ssh/lightsail-default.pem ubuntu@23.20.52.57`
**User:** `ubuntu` (not bitnami, not ec2-user)
**Key:** `~/.ssh/lightsail-default.pem`

## Docker Setup

WordPress runs in Docker containers:

| Container | Image | Port | Purpose |
|-----------|-------|------|---------|
| `wp-talk-commerce` | `wp-talk-commerce-talk-commerce` | 127.0.0.1:8080->80 | WordPress |
| `wp-infra-db` | `mariadb:10.11` | 3306 | MariaDB database |
| `newrelic-php-daemon` | `newrelic/php-daemon` | 31339 | New Relic PHP |
| `newrelic-infra` | `newrelic/infrastructure` | - | New Relic infra |

## Volume Mounts

- `/mnt/tc-uploads/uploads` -> `/var/www/html/wp-content/uploads` (S3 or EBS mount for media)
- Docker volume `wp-talk-commerce_tc-wp-content` -> `/var/www/html/wp-content`
- Anonymous volume -> `/var/www/html`

## Plugin Deployment

To deploy RequestDesk connector plugin changes:

```bash
# 1. SCP files to server
scp -i ~/.ssh/lightsail-default.pem LOCAL_FILE ubuntu@23.20.52.57:/tmp/FILENAME

# 2. Copy into Docker container
ssh -i ~/.ssh/lightsail-default.pem ubuntu@23.20.52.57 \
  "docker cp /tmp/FILENAME wp-talk-commerce:/var/www/html/wp-content/plugins/requestdesk-connector/PATH/FILENAME"

# 3. Verify
ssh -i ~/.ssh/lightsail-default.pem ubuntu@23.20.52.57 \
  "docker exec wp-talk-commerce grep 'SOMETHING' /var/www/html/wp-content/plugins/requestdesk-connector/PATH/FILENAME"
```

**Plugin path in container:** `/var/www/html/wp-content/plugins/requestdesk-connector/`

## WordPress API

- **Headless API:** `https://tc.requestdesk.ai/wp-json/requestdesk/v1/headless/`
- **API Key:** stored in `workspace.env` as `TALKCOMMERCE_WORDPRESS_API_KEY`
- **Standard WP REST:** `https://tc.requestdesk.ai/wp-json/wp/v2/`

## SES Email (configured 2026-03-24)

msmtp in Docker container using SES SMTP, talk-commerce.com verified in SES.

## Notes

- WordPress files persist in Docker volume, not on host filesystem directly
- Container restart (`docker restart wp-talk-commerce`) may be needed after PHP changes
- The `wordpress-sites/talk-commerce/` directory on local Mac is a copy of wp-content, NOT a git repo
