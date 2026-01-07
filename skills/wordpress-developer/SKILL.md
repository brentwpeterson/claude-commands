# WordPress Developer Skill

## Purpose

Comprehensive WordPress development guidelines for themes, plugins, and sites. Load this skill when working on any WordPress project.

---

## Critical Rules

### 1. NEVER Use CSS Overrides with !important as a Quick Fix
**Fix the source, not the symptom. No !important hacks to override inline styles.**

When encountering inline styles in Gutenberg blocks:
- **WRONG:** Add `!important` CSS to override inline styles
- **RIGHT:** Re-edit the content, remove inline styles, use proper classes

The only exception is a catastrophic production emergency. Otherwise, always fix at the source.

### 2. NEVER Create Features That Output Inline Styles
**All new features MUST output CSS classes. Inline styles are PROHIBITED in new code.**

This is non-negotiable. Before building any feature that generates HTML:
1. Define the CSS classes needed in style.css FIRST
2. Then build the feature to output those classes

When generating Gutenberg blocks programmatically:
- **WRONG:** `style="padding:50px;background:#f8f9fa"`
- **RIGHT:** `class="section section--gray"`

This applies to:
- AEO Template Importer
- API endpoints that create pages/posts
- Any page/post generators
- Block pattern registration
- Any PHP that outputs HTML

**No exceptions. No "quick fixes." No "we'll clean it up later."**

**Why this matters:** Inline styles are lazy and create exponentially more work later. One inline style becomes 50 pages with inline styles, then you're manually editing every page to fix spacing. Do it right the first time.

### 3. CSS in Stylesheets, Not Inline
**All styling lives in stylesheets. Inline styles are prohibited.**

See `patterns/css-guidelines.md` for full details.

### 4. Use theme.json for Design Tokens
**Colors, spacing, fonts belong in theme.json, not hardcoded in templates.**

WordPress generates utility classes automatically from theme.json.

### 5. BEM Naming Convention
**Use Block Element Modifier for all custom classes.**

- `.block` — standalone component
- `.block__element` — child of the block
- `.block--modifier` — variation of the block

### 6. No Hardcoded URLs
**Use WordPress functions for all URLs.**

```php
// CORRECT
get_stylesheet_directory_uri() . '/assets/css/main.css'
get_template_directory_uri() . '/images/logo.png'
home_url('/about/')

// WRONG
'https://example.com/wp-content/themes/mytheme/assets/css/main.css'
'/wp-content/themes/mytheme/images/logo.png'
```

### 7. Enqueue, Don't Embed
**All CSS and JS must be enqueued via wp_enqueue_style/script.**

See `patterns/enqueue-patterns.md`.

---

## Skill Reference Documents

| Document | Purpose |
|----------|---------|
| `architecture/theme-structure.md` | Theme file organization, child themes |
| `architecture/generatepress.md` | GeneratePress-specific patterns |
| `architecture/gutenberg-blocks.md` | Block development and patterns |
| `patterns/css-guidelines.md` | CSS best practices, specificity, refactoring |
| `patterns/enqueue-patterns.md` | Proper asset loading |
| `templates/theme-json.md` | theme.json examples and tokens |
| `templates/style-css.md` | style.css structure template |
| `workflows/local-to-production.md` | Deployment workflow |

---

## Content Cucumber Specifics

### Theme Structure
- **Parent Theme:** GeneratePress
- **Child Theme:** cucumber-gp-child
- **Location:** `/wp-content/themes/cucumber-gp-child/`

### Stylesheet Architecture
```
style.css          → Global site styles (typography, colors, spacing)
hero-styles.css    → Hero section overrides
mega-menu.css      → Mega menu styles
```

### Plugin
- **RequestDesk Connector:** `/wp-content/plugins/requestdesk-connector/`
- **AEO Templates:** Template generators for landing pages

### Local Development
- **Local by Flywheel:** contentcucumber.local
- **WP Admin:** http://contentcucumber.local/wp-admin/
- **Theme path:** `/Users/brent/LocalSites/contentcucumber/app/public/wp-content/themes/cucumber-gp-child/`
- **Plugin path:** `/Users/brent/LocalSites/contentcucumber/app/public/wp-content/plugins/requestdesk-connector/`

### Deployment Workflow
Local → Staging → Live (due to Flywheel WAF blocking REST API)

See `workflows/local-to-production.md`.

---

## Quick Checklist

Before committing WordPress changes:

- [ ] No inline styles for repeatable patterns
- [ ] CSS in appropriate stylesheet (not scattered)
- [ ] theme.json used for design tokens
- [ ] Assets properly enqueued (not hardcoded)
- [ ] BEM naming for custom classes
- [ ] No hardcoded URLs
- [ ] Tested in local environment
- [ ] Child theme used (not modifying parent)

---

## Red Flags

Stop and refactor if you see:

- `style.css` is nearly empty while templates are full of inline styles
- Multiple `!important` declarations fighting each other
- Same inline style appearing on multiple elements
- Hardcoded colors/spacing instead of theme.json tokens
- Assets loaded via `<link>` or `<script>` tags in templates
- Direct parent theme modifications
