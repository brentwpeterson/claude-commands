# style.css Structure Template

## Child Theme Header (Required)

```css
/*
Theme Name: [Theme Name] Child
Description: Child theme for [Parent Theme] with custom styles
Template: [parent-theme-folder]
Version: 1.0.0
Author: [Author Name]
Author URI: [Author URL]
Text Domain: [theme-slug]-child
*/
```

---

## Recommended Section Structure

```css
/*
Theme Name: Cucumber GP Child
Description: Content Cucumber's child theme for GeneratePress
Template: generatepress
Version: 1.0.0
Author: Content Cucumber Team
Author URI: https://contentcucumber.com
Text Domain: cucumber-gp-child
*/

/* ==========================================================================
   TABLE OF CONTENTS
   ==========================================================================
   1. CSS Variables / Design Tokens
   2. Base / Reset
   3. Typography
   4. Layout
   5. Components
   6. Utilities
   7. Overrides (plugins, parent theme)
   ========================================================================== */

/* ==========================================================================
   1. CSS VARIABLES
   ========================================================================== */

:root {
    /* Colors - reference theme.json when possible */
    --color-primary: #1a1a1a;
    --color-secondary: #666666;
    --color-accent: #0066cc;
    --color-background: #ffffff;
    --color-surface: #f5f5f5;
    --color-border: #e0e0e0;

    /* Typography */
    --font-primary: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
    --font-heading: 'Playfair Display', Georgia, serif;

    /* Spacing */
    --space-xs: 0.5rem;
    --space-sm: 1rem;
    --space-md: 1.5rem;
    --space-lg: 2rem;
    --space-xl: 3rem;
    --space-xxl: 4rem;

    /* Borders */
    --radius-sm: 4px;
    --radius-md: 8px;
    --radius-lg: 16px;

    /* Shadows */
    --shadow-sm: 0 1px 2px rgba(0, 0, 0, 0.05);
    --shadow-md: 0 4px 6px rgba(0, 0, 0, 0.1);
    --shadow-lg: 0 10px 15px rgba(0, 0, 0, 0.1);

    /* Transitions */
    --transition-fast: 150ms ease;
    --transition-normal: 300ms ease;
}

/* ==========================================================================
   2. BASE / RESET
   ========================================================================== */

*,
*::before,
*::after {
    box-sizing: border-box;
}

body {
    color: var(--color-primary);
    background-color: var(--color-background);
    font-family: var(--font-primary);
    line-height: 1.6;
}

img {
    max-width: 100%;
    height: auto;
    display: block;
}

/* ==========================================================================
   3. TYPOGRAPHY
   ========================================================================== */

h1, h2, h3, h4, h5, h6 {
    font-family: var(--font-heading);
    font-weight: 700;
    line-height: 1.2;
    margin-top: 0;
}

h1 { font-size: 2.5rem; }
h2 { font-size: 2rem; }
h3 { font-size: 1.5rem; }
h4 { font-size: 1.25rem; }

p {
    margin-top: 0;
    margin-bottom: var(--space-md);
}

a {
    color: var(--color-accent);
    text-decoration: none;
    transition: color var(--transition-fast);
}

a:hover {
    color: var(--color-primary);
}

/* ==========================================================================
   4. LAYOUT
   ========================================================================== */

.container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 var(--space-md);
}

.section {
    padding: var(--space-xl) 0;
}

.section--alt {
    background-color: var(--color-surface);
}

/* ==========================================================================
   5. COMPONENTS
   ========================================================================== */

/* Buttons */
.btn {
    display: inline-block;
    padding: var(--space-sm) var(--space-lg);
    font-weight: 600;
    text-align: center;
    border-radius: var(--radius-sm);
    transition: all var(--transition-fast);
    cursor: pointer;
}

.btn--primary {
    background-color: var(--color-accent);
    color: white;
}

.btn--primary:hover {
    background-color: var(--color-primary);
    color: white;
}

/* Cards */
.card {
    background: white;
    border-radius: var(--radius-md);
    box-shadow: var(--shadow-sm);
    overflow: hidden;
}

.card__image {
    width: 100%;
    aspect-ratio: 16/9;
    object-fit: cover;
}

.card__content {
    padding: var(--space-md);
}

.card__title {
    margin-bottom: var(--space-xs);
}

/* ==========================================================================
   6. UTILITIES
   ========================================================================== */

.text-center { text-align: center; }
.text-left { text-align: left; }
.text-right { text-align: right; }

.mb-0 { margin-bottom: 0; }
.mb-sm { margin-bottom: var(--space-sm); }
.mb-md { margin-bottom: var(--space-md); }
.mb-lg { margin-bottom: var(--space-lg); }

.visually-hidden {
    position: absolute;
    width: 1px;
    height: 1px;
    padding: 0;
    margin: -1px;
    overflow: hidden;
    clip: rect(0, 0, 0, 0);
    border: 0;
}

/* ==========================================================================
   7. OVERRIDES
   ========================================================================== */

/* GeneratePress overrides */
.site-header {
    /* Custom header styles */
}

/* GenerateBlocks overrides */
.gb-container {
    /* Custom container styles */
}

/* Plugin overrides */
/* Document why !important is needed */
```

---

## Key Principles

1. **Use CSS Variables** - Define once, use everywhere
2. **Organize by section** - Easy to find and maintain
3. **Comment sections** - Table of contents at top
4. **BEM for components** - `.block__element--modifier`
5. **Document overrides** - Explain why `!important` is needed
6. **Mobile-first** - Base styles for mobile, media queries for larger

---

## Media Queries

```css
/* Mobile-first approach */

/* Base styles (mobile) */
.component {
    padding: var(--space-sm);
}

/* Tablet and up */
@media (min-width: 768px) {
    .component {
        padding: var(--space-md);
    }
}

/* Desktop and up */
@media (min-width: 1024px) {
    .component {
        padding: var(--space-lg);
    }
}
```
