# AWS Infrastructure - Astro Sites Deployment

**Skill Description:** Guide for deploying new Astro sites to the CB-Workspace AWS infrastructure (ECS, ALB, Route53, ACM).

## CRITICAL RESOURCES

| Resource | Value | Purpose |
|----------|-------|---------|
| **ALB Name** | `cb-app-alb` | Application Load Balancer |
| **ALB DNS** | `cb-app-alb-1479878363.us-east-1.elb.amazonaws.com` | Target for Route53 |
| **ALB ARN** | `arn:aws:elasticloadbalancing:us-east-1:973753295447:loadbalancer/app/cb-app-alb/cc08a8f3fc6288e3` | For listener rules |
| **Region** | `us-east-1` | All resources |
| **Port** | `3003` | nginx listens on this port inside container |

## ARCHITECTURE OVERVIEW

```
┌─────────────────────────────────────────────────────────────────┐
│                         Route53                                  │
│  brent.run → ALB    requestdesk.ai → ALB    etc.                │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                    ALB (cb-app-alb)                              │
│  - HTTPS:443 listener with ACM certs                            │
│  - Routes all traffic to ECS target group                       │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                    ECS (astro-sites)                             │
│  ┌────────────────────────────────────────────────────────────┐ │
│  │  nginx (port 3003)                                         │ │
│  │  - Host-based routing via server blocks                    │ │
│  │  - Each site has its own server block                      │ │
│  │  - Static files served from /usr/share/nginx/html/[site]   │ │
│  └────────────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────────┘
```

**Key Insight:** ALB routes ALL traffic to the same ECS task. nginx handles domain-based routing internally via `server_name` directives.

---

## ADDING A NEW SITE - COMPLETE CHECKLIST

### Step 1: Verify Domain in Route53

```bash
# Check if hosted zone exists
aws route53 list-hosted-zones --query "HostedZones[?contains(Name, 'DOMAIN.TLD')].{Name:Name,Id:Id}" --output table

# If missing, create hosted zone
aws route53 create-hosted-zone --name DOMAIN.TLD --caller-reference $(date +%s)
```

### Step 2: Create ACM Certificate

```bash
# Request certificate (must be in us-east-1 for ALB)
aws acm request-certificate \
  --domain-name DOMAIN.TLD \
  --subject-alternative-names "*.DOMAIN.TLD" \
  --validation-method DNS \
  --region us-east-1

# Get the certificate ARN from output, then get validation records
aws acm describe-certificate \
  --certificate-arn ARN_FROM_ABOVE \
  --query "Certificate.DomainValidationOptions" \
  --output table

# Add the CNAME validation records to Route53
# (ACM will show you the Name and Value for the CNAME record)
```

**Wait for certificate to be issued** (usually 5-30 minutes after adding DNS validation).

### Step 3: Add Certificate to ALB Listener

```bash
# Get the HTTPS listener ARN
aws elbv2 describe-listeners \
  --load-balancer-arn arn:aws:elasticloadbalancing:us-east-1:973753295447:loadbalancer/app/cb-app-alb/cc08a8f3fc6288e3 \
  --query "Listeners[?Port==\`443\`].ListenerArn" \
  --output text

# Add the new certificate to the listener
aws elbv2 add-listener-certificates \
  --listener-arn LISTENER_ARN \
  --certificates CertificateArn=NEW_CERT_ARN
```

### Step 4: Create Route53 A Record

```bash
# Get the hosted zone ID
aws route53 list-hosted-zones --query "HostedZones[?Name=='DOMAIN.TLD.'].Id" --output text

# Create A record pointing to ALB (use alias)
aws route53 change-resource-record-sets \
  --hosted-zone-id ZONE_ID \
  --change-batch '{
    "Changes": [{
      "Action": "CREATE",
      "ResourceRecordSet": {
        "Name": "DOMAIN.TLD",
        "Type": "A",
        "AliasTarget": {
          "HostedZoneId": "Z35SXDOTRQ7X7K",
          "DNSName": "cb-app-alb-1479878363.us-east-1.elb.amazonaws.com",
          "EvaluateTargetHealth": false
        }
      }
    }]
  }'

# Also create www subdomain
aws route53 change-resource-record-sets \
  --hosted-zone-id ZONE_ID \
  --change-batch '{
    "Changes": [{
      "Action": "CREATE",
      "ResourceRecordSet": {
        "Name": "www.DOMAIN.TLD",
        "Type": "A",
        "AliasTarget": {
          "HostedZoneId": "Z35SXDOTRQ7X7K",
          "DNSName": "cb-app-alb-1479878363.us-east-1.elb.amazonaws.com",
          "EvaluateTargetHealth": false
        }
      }
    }]
  }'
```

**Note:** `Z35SXDOTRQ7X7K` is the hosted zone ID for ALBs in us-east-1. This is an AWS constant, not your zone ID.

### Step 5: Update astro-sites Code

#### 5a. Create Site Directory

```bash
cd /Users/brent/scripts/CB-Workspace/astro-sites
# Clone starter or copy existing site structure
```

#### 5b. Update build-all.sh

Add to `astro-sites/deployment/build-all.sh`:
```bash
# Build DOMAIN.TLD
echo "Building DOMAIN.TLD..."
cd site-directory
npm ci
npm run build
cd ..
```

And add to the size output section:
```bash
if [ -d "site-directory/dist" ]; then
    echo "  DOMAIN.TLD: $(du -sh site-directory/dist | cut -f1)"
fi
```

#### 5c. Update nginx.conf

Add server block to `astro-sites/deployment/nginx.conf`:
```nginx
# DOMAIN.TLD server
server {
    listen 3003;
    server_name DOMAIN.TLD www.DOMAIN.TLD;
    root /usr/share/nginx/html/site-directory;
    index index.html;

    # Fix redirects behind ALB - don't include port in redirects
    absolute_redirect off;

    # Health check endpoint
    location /health {
        add_header Content-Type text/plain;
        return 200 'healthy';
    }

    # Handle Astro routing (SPA fallback)
    location / {
        try_files $uri $uri/ /index.html;
    }

    # Static assets with caching
    location ~* \.(js|css|png|jpg|jpeg|gif|ico|svg|woff|woff2|ttf|eot)$ {
        expires 1y;
        add_header Cache-Control "public, immutable";
    }

    # Security headers
    add_header X-Frame-Options "SAMEORIGIN" always;
    add_header X-Content-Type-Options "nosniff" always;
    add_header X-XSS-Protection "1; mode=block" always;
}
```

Also add local testing blocks (HTTP and HTTPS for `.test` domain).

#### 5d. Update Dockerfile (if needed)

Check `astro-sites/deployment/Dockerfile` - usually no changes needed as it copies all site directories.

### Step 6: Deploy

Deploy using the standard deployment process (GitHub Actions or manual).

---

## QUICK REFERENCE COMMANDS

### Check Current State

```bash
# List all hosted zones
aws route53 list-hosted-zones --output table

# List all ACM certificates
aws acm list-certificates --output table

# Check ALB listeners and certificates
aws elbv2 describe-listeners \
  --load-balancer-arn arn:aws:elasticloadbalancing:us-east-1:973753295447:loadbalancer/app/cb-app-alb/cc08a8f3fc6288e3

# List certificates attached to listener
aws elbv2 describe-listener-certificates \
  --listener-arn LISTENER_ARN
```

### Verify DNS Propagation

```bash
# Check if domain resolves to ALB
dig DOMAIN.TLD +short
# Should return ALB IP addresses

# Check if HTTPS works
curl -I https://DOMAIN.TLD
```

---

## EXISTING SITES

| Site | Directory | Domain(s) |
|------|-----------|-----------|
| contentbasis.io | contentbasis-io | contentbasis.io, www, new |
| contentbasis.ai | contentbasis-ai | contentbasis.ai, www |
| requestdesk.ai | requestdesk-ai | requestdesk.ai, www, docs |
| magento-masters.com | magento-masters-com | magento-masters.com, www |

---

## TROUBLESHOOTING

### Certificate Not Validating

1. Check DNS validation CNAME is correct in Route53
2. Wait up to 30 minutes
3. Verify with: `aws acm describe-certificate --certificate-arn ARN`

### Site Returns 444 (No Response)

nginx returns 444 for unknown hosts. Check:
1. `server_name` in nginx.conf matches the domain exactly
2. Container was rebuilt and deployed with new config

### Mixed Content / Redirect Issues

If redirects include port 3003:
- Ensure `absolute_redirect off;` is in the server block

### SSL Certificate Error

1. Verify certificate is attached to ALB listener
2. Verify certificate status is "ISSUED" not "PENDING_VALIDATION"

---

## When Claude Should Apply This Skill

Apply this skill automatically when:
- User wants to add a new site to astro-sites
- User mentions Route53, ACM, ALB, or ECS for astro sites
- User is deploying a new domain
- User has SSL/certificate questions for astro sites
- User asks about the deployment infrastructure

---

## Integration with Commands

- `/deploy-project` - Deploys changes to production
- `/start-work astro` - Creates new Astro site content
