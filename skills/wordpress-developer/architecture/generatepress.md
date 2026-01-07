# GeneratePress Architecture

## Overview

GeneratePress is a lightweight, performance-focused theme. Content Cucumber uses it as the parent theme.

---

## Key Characteristics

- **Lightweight:** ~10KB (no jQuery dependency)
- **Hooks-based:** Extensive action/filter hooks
- **Customizer-driven:** Most settings in WP Customizer
- **GenerateBlocks:** Companion block plugin

---

## GeneratePress Hooks

### Layout Hooks

```php
// Before/after header
generate_before_header
generate_after_header

// Before/after content
generate_before_main_content
generate_after_main_content

// Before/after footer
generate_before_footer
generate_after_footer

// Inside content area
generate_before_content
generate_after_content
generate_after_entry_content
```

### Usage Example

```php
add_action('generate_after_header', function() {
    echo '<div class="announcement-bar">Sale ends today!</div>';
});
```

---

## GeneratePress CSS Classes

### Layout Classes
```css
.site-header          /* Main header */
.main-navigation      /* Primary nav */
.site-content         /* Main content wrapper */
.content-area         /* Primary content */
.widget-area          /* Sidebar */
.site-footer          /* Footer */
```

### Content Classes
```css
.entry-header         /* Post/page header */
.entry-content        /* Post/page content */
.entry-meta           /* Post meta (date, author) */
.entry-summary        /* Excerpt */
```

---

## GenerateBlocks

Companion plugin for advanced layouts.

### Key Block Types
- **Container:** Flexbox/grid layouts
- **Grid:** CSS Grid layouts
- **Button:** Styled buttons
- **Headline:** Advanced headings
- **Image:** Enhanced images

### CSS Specificity

GenerateBlocks uses dynamic classes like `.gb-container-abc123`. Override with:

```css
/* Target by custom class (add in block settings) */
.my-custom-section {
    padding: 2rem;
}

/* Or increase specificity */
.gb-container.my-custom-section {
    padding: 2rem;
}
```

---

## Child Theme Overrides

### Overriding GeneratePress Styles

```css
/* In child theme style.css */

/* Override header */
.site-header {
    background: #1a1a1a;
}

/* Override with higher specificity if needed */
body .site-header {
    background: #1a1a1a;
}
```

### Removing GeneratePress Defaults

```php
// Remove default styles
add_action('wp_enqueue_scripts', function() {
    wp_dequeue_style('generate-style');
}, 20);

// Remove specific features
remove_action('generate_footer', 'generate_construct_footer');
```

---

## Content Cucumber Setup

### Theme Locations
```
Parent: /wp-content/themes/generatepress/
Child:  /wp-content/themes/cucumber-gp-child/
```

### Child Theme Files
```
cucumber-gp-child/
├── style.css          # Global styles
├── functions.php      # Custom functions + enqueues
├── hero-styles.css    # Hero section overrides
├── mega-menu.css      # Mega menu styles
└── screenshot.jpg     # Theme screenshot
```

### Enqueue Order
1. GeneratePress parent styles
2. cucumber-gp-child/style.css
3. cucumber-gp-child/hero-styles.css (depends on GenerateBlocks)
