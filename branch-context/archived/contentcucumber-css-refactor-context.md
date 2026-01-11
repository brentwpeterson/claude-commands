# Resume Instructions for Claude

## IMMEDIATE SETUP
1. **Plugin directory:** `cd /Users/brent/LocalSites/contentcucumber/app/public/wp-content/plugins/requestdesk-connector`
2. **Theme directory:** `/Users/brent/LocalSites/contentcucumber/app/public/wp-content/themes/cucumber-gp-child/`
3. **Verify branch:** `git branch --show-current` (should be: main)
4. **Local WP site:** `http://contentcucumber.local/wp-admin/`

## SESSION METADATA
**Last Commit:** `07b6aab Convert AEO templates to CSS classes - eliminate inline styles`
**Saved:** 2026-01-02
**Purpose:** CSS refactoring - eliminate inline styles from WordPress templates

## CRITICAL SKILL CREATED THIS SESSION
**WordPress Developer Skill** - `/wordpress-developer`
Location: `/Users/brent/scripts/CB-Workspace/.claude/skills/wordpress-developer/`

### Key Rules Established:
1. **NEVER use CSS !important overrides** - Fix source, not symptom
2. **NEVER create features that output inline styles** - All new code MUST use CSS classes
3. **CSS in stylesheets** - All styling lives in stylesheets, inline prohibited
4. **Define CSS classes FIRST** - Before building any feature that generates HTML

### Skill Structure:
```
skills/wordpress-developer/
├── SKILL.md                    # Entry point with critical rules
├── architecture/
│   ├── theme-structure.md      # Theme hierarchy, child themes
│   ├── generatepress.md        # GP hooks, classes, overrides
│   └── gutenberg-blocks.md     # Block patterns, programmatic creation
├── patterns/
│   ├── css-guidelines.md       # CSS best practices
│   └── enqueue-patterns.md     # Asset loading
├── templates/
│   ├── theme-json.md           # Design tokens
│   └── style-css.md            # Stylesheet structure
└── workflows/
    └── local-to-production.md  # Deployment workflow
```

## WHAT WAS COMPLETED THIS SESSION

### 1. Created Global CSS Class System
**File:** `cucumber-gp-child/style.css`

Added comprehensive classes:
- CSS Variables (colors, spacing)
- `.section`, `.section--gray`, `.section--tight`, `.section--spacious`
- `.section__heading`, `.section__subheading`
- `.hero`, `.hero--dark`, `.hero__title`, `.hero__tagline`, `.hero__subtitle`, `.hero__buttons`, `.hero__image`
- `.cta`, `.cta__heading`, `.cta__text`
- `.btn`, `.btn--white`, `.btn--primary`, `.btn--large`
- `.col--55`, `.col--45`
- `.img--rounded`, `.img--no-margin`
- WordPress block resets

### 2. Converted Open Base Template
**File:** `admin/aeo-template-open-base.php`

- Removed ALL inline styles (was: 25+ style= attributes)
- Now uses CSS classes exclusively
- Verified with grep: zero `style=` remaining

## TODO LIST STATE
- ✅ COMPLETED: Create wordpress-developer skill
- ✅ COMPLETED: Add CSS class system to style.css
- ✅ COMPLETED: Convert aeo-template-open-base.php to CSS classes
- ⏳ PENDING: aeo-template-landing-simple.php - convert to CSS classes
- ⏳ PENDING: aeo-template-landing-hub.php - convert to CSS classes
- ⏳ PENDING: aeo-template-landing-parent.php - convert to CSS classes
- ⏳ PENDING: aeo-template-landing-child.php - convert to CSS classes
- ⏳ PENDING: aeo-template-about.php - convert to CSS classes
- ⏳ PENDING: aeo-template-enhanced.php - convert to CSS classes
- ⏳ PENDING: Add /import-page API endpoint to requestdesk-connector

## NEXT ACTIONS (PRIORITY ORDER)
1. **FIRST:** User should test importing a page with Open Base template to verify CSS classes work
2. **THEN:** Convert remaining 6 AEO templates to CSS classes (same pattern as Open Base)
3. **LATER:** Add `/import-page` API endpoint for RequestDesk integration

## KEY FILES MODIFIED THIS SESSION
1. `/Users/brent/scripts/CB-Workspace/.claude/skills/wordpress-developer/SKILL.md` - Created
2. `/Users/brent/scripts/CB-Workspace/.claude/skills/wordpress-developer/architecture/*.md` - Created (3 files)
3. `/Users/brent/scripts/CB-Workspace/.claude/skills/wordpress-developer/patterns/*.md` - Created (2 files)
4. `/Users/brent/scripts/CB-Workspace/.claude/skills/wordpress-developer/templates/*.md` - Created (2 files)
5. `/Users/brent/scripts/CB-Workspace/.claude/skills/wordpress-developer/workflows/*.md` - Created (1 file)
6. `cucumber-gp-child/style.css` - Added CSS class system (~200 lines)
7. `admin/aeo-template-open-base.php` - Converted to CSS classes

## TEMPLATES REMAINING TO CONVERT
Run this to check inline styles in each:
```bash
for f in /Users/brent/LocalSites/contentcucumber/app/public/wp-content/plugins/requestdesk-connector/admin/aeo-template*.php; do
  count=$(grep -c 'style=' "$f" 2>/dev/null || echo 0)
  echo "$(basename $f): $count inline styles"
done
```

## CONTEXT NOTES
- **Flywheel WAF Issue:** Still blocking REST API on staging/live - work locally, push changes
- **Hot Loading:** Theme CSS changes require removing inline styles from page content to take effect
- **CSS Specificity:** Inline styles (from Gutenberg) always beat stylesheet rules - must remove inline styles from content
- **Live site:** https://www.contentcucumber.com (Flywheel hosting)
