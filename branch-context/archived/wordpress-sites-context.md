# Resume Instructions for Claude

## IMMEDIATE SETUP
1. **Change directory:** `cd /Users/brent/scripts/CB-Workspace`
2. **WordPress Sites Symlinks:** Check `ls -la wordpress-sites/`
3. **Plugin Location:** `wordpress-sites/requestdesk-connector/`

## SESSION METADATA
**Last Commit:** `35abe06 Update .gitignore to only track custom code`
**ContentCucumber Repo:** `/Users/brent/LocalSites/contentcucumber` (on main branch)
**Saved:** 2025-12-26

## WHAT WAS ACCOMPLISHED THIS SESSION

### 1. WordPress Sites Symlink Structure Created
- Created `/Users/brent/scripts/CB-Workspace/wordpress-sites/` directory
- Symlinked LocalWP sites for easier development:
  ```
  wordpress-sites/
  ├── contentcucumber/        → /Users/brent/LocalSites/contentcucumber/app/public/wp-content
  ├── requestdesk-connector/  → Direct access to plugin
  └── talk-commerce/          → /Users/brent/LocalSites/talk-commerce/app/public/wp-content
  ```

### 2. ContentCucumber Git Repo Synced and Cleaned
- Synced requestdesk-connector plugin from live to repo
- Updated .gitignore to only track custom code:
  - ✅ `plugins/cucumber-custom/`
  - ✅ `plugins/requestdesk-connector/`
  - ✅ `themes/cucumber-gp-child/`
- Removed 10,283 vendor files from tracking (1.7M lines)
- Repo: `git@github.com:brentwpeterson/contentcucumber.git`

### 3. Navigation Redesign Planned
Designed new navigation structure for contentcucumber.com:
```
┌─────────────────────────────────────────────────────────────────────────────┐
│  🥒 LOGO   |  HOME   Services ▼   Industries ▼   Our Work   Blog   Login ▼ │
│                      │                  │                                   │
│               ┌──────┴──────┐    ┌──────┴──────┐                           │
│               │ Writing     │    │ ???         │                           │
│               │ Flywheel    │    │ ???         │                           │
│               │ Hubspot     │    │ ???         │                           │
│               └─────────────┘    └─────────────┘                           │
└─────────────────────────────────────────────────────────────────────────────┘
```
- User is making nav changes in WP Admin on live, then pulling database to LocalWP

### 4. AEO Template Importer Enhancement - IN PROGRESS
**Goal:** Add Landing Page templates to RequestDesk Template Importer

**Template Architecture Designed:**
```
Landing Page Templates
├── Landing Page (Parent)          ← /services/, /industries/, /partners/
│   ├── Hero section
│   ├── Intro text
│   ├── Dynamic grid (pulls children)
│   └── CTA section
│
└── Landing Page Item (Child)      ← /services/writing/, /industries/saas/
    ├── Hero section
    ├── Service description
    ├── Benefits/Features
    ├── Process steps
    ├── Testimonial/Social proof
    └── CTA section
```

**Confirmed Requirements:**
- All templates must be GEO/AIO/AEO optimized
- Schema markup: Service, FAQ, BreadcrumbList, Organization, ItemList
- Answer Engine ready FAQ sections
- E-E-A-T signals throughout
- Reusable pattern for: Services, Industries, Partners, Portfolio

## PENDING TODO LIST
1. ⏳ Create Landing Page Parent template (aeo-template-landing-parent.php)
2. ⏳ Create Landing Page Child/Item template (aeo-template-landing-child.php)
3. ⏳ Update template importer UI with new template types
4. ⏳ Add CSV field mappings for landing page templates
5. ⏳ Create example CSV files for landing page imports
6. ⏳ Test import on local WordPress site

## KEY FILES TO WORK WITH
- **Template Importer:** `wordpress-sites/requestdesk-connector/admin/aeo-template-importer.php`
- **Homepage Template:** `wordpress-sites/requestdesk-connector/admin/aeo-template-enhanced.php` (reference)
- **About Template:** `wordpress-sites/requestdesk-connector/admin/aeo-template-about.php` (reference)
- **NEW Parent Template:** `wordpress-sites/requestdesk-connector/admin/aeo-template-landing-parent.php`
- **NEW Child Template:** `wordpress-sites/requestdesk-connector/admin/aeo-template-landing-child.php`

## NEXT ACTIONS (PRIORITY ORDER)
1. **FIRST:** Create `aeo-template-landing-child.php` (individual service pages)
2. **THEN:** Create `aeo-template-landing-parent.php` (services landing page)
3. **UPDATE:** Add new templates to importer dropdown in `aeo-template-importer.php`
4. **TEST:** Import a service page on local WordPress

## LANDING PAGE CHILD CSV FIELDS (DESIGNED)
| Field | Purpose |
|-------|---------|
| page_title | "Content Writing" |
| page_slug | "writing" |
| parent_slug | "services" |
| icon | Icon class or image URL |
| subtitle | Tagline |
| summary | For parent page grid |
| hero_headline | Full page headline |
| benefits_* | Benefits section |
| process_* | Process steps |
| faq_* | FAQ section |
| cta_* | CTA section |

## CONTEXT NOTES
- User was about to say "yes go!" to start building when session was saved
- Start with the Landing Page Child template first (service pages like Writing, Marketing)
- Follow existing template patterns in aeo-template-enhanced.php and aeo-template-about.php
- All templates must include full Schema.org markup for GEO/AEO optimization
