# CSS Development Guidelines

## Core Principle

**Minimize inline styles. Prioritize maintainable, cacheable CSS in stylesheets.**

Inline styles should be the exception, not the default.

---

## Where Styles Should Live

### style.css
Theme-wide base styles, typography, colors, layout foundations. This file should never be nearly empty on a custom build.

### Separate Enqueued Stylesheets
For larger themes, split into logical files:
- `components.css` - Reusable UI components
- `blocks.css` - Gutenberg block styles
- `woocommerce.css` - E-commerce styles

Enqueue via `wp_enqueue_style()` in `functions.php`.

### theme.json
Define design tokens (colors, spacing, font sizes) here. WordPress generates utility classes automatically.

### Block-specific Stylesheets
Use `block.json` to register styles scoped to individual blocks when building custom blocks.

---

## When Inline Styles Are Acceptable

- Truly dynamic values calculated by JavaScript at runtime
- User-selected colors stored in the database
- One-time overrides that will never repeat
- Email templates where external stylesheets aren't supported

---

## When Inline Styles Are NOT Acceptable

- Any style that appears on more than one element
- Colors, spacing, or typography that could change during a redesign
- Styles that need pseudo-classes (`:hover`, `:focus`)
- Styles that need media queries
- Anything a content editor might need to update later

---

## Handling Specificity Conflicts

Before using `!important`:

1. **Inspect** - Identify what rule is winning and why
2. **Configure** - Check if the conflict comes from a plugin/parent theme that can be configured
3. **Increase specificity** - Use a more targeted selector
4. **Use child theme** - Override parent theme rules in child stylesheet

Only use `!important` as a last resort for third-party code you cannot modify. Always document why.

```css
/* LAST RESORT: GenerateBlocks inline style override
   GB adds inline padding that can't be removed in block settings */
.hero-section .gb-container {
    padding: 2rem !important;
}
```

---

## Code Patterns

### Correct - Enqueued Stylesheet

```php
function theme_enqueue_styles() {
    wp_enqueue_style(
        'theme-main',
        get_stylesheet_directory_uri() . '/assets/css/main.css',
        array(),
        '1.0.0'
    );
}
add_action('wp_enqueue_scripts', 'theme_enqueue_styles');
```

### Correct - Class-based Styling

```php
<div class="card card--featured">
    <h3 class="card__title"><?php echo esc_html($title); ?></h3>
</div>
```

```css
/* In stylesheet */
.card {
    background: white;
    border-radius: 8px;
    padding: 20px;
}

.card--featured {
    background: #1a1a1a;
}

.card__title {
    font-size: 24px;
    margin: 0;
}
```

### WRONG - Inline Styles for Repeatable Patterns

```php
<!-- DON'T DO THIS -->
<div style="background: #1a1a1a; padding: 20px; border-radius: 8px;">
    <h3 style="color: white; font-size: 24px;"><?php echo $title; ?></h3>
</div>
```

---

## Refactoring Inline Styles

When encountering existing inline styles:

1. **Identify** - Does this style repeat anywhere else?
2. **Name semantically** - `.card--featured` not `.blue-background`
3. **Move to stylesheet** - Appropriate file based on scope
4. **Replace inline with class** - Update the HTML
5. **Test** - Check for specificity conflicts

---

## BEM Naming Convention

Use Block Element Modifier:

```css
/* Block - standalone component */
.card { }

/* Element - child of block (double underscore) */
.card__title { }
.card__image { }
.card__content { }

/* Modifier - variation (double dash) */
.card--featured { }
.card--compact { }
.card__title--large { }
```

---

## Specificity Reference

From lowest to highest:

1. Element selectors: `div`, `p`, `h1` (0,0,1)
2. Class selectors: `.card`, `.btn` (0,1,0)
3. ID selectors: `#header` (1,0,0)
4. Inline styles: `style="..."` (1,0,0,0)
5. `!important` - overrides everything

### Calculating Specificity

```css
div { }                    /* 0,0,1 */
.card { }                  /* 0,1,0 */
div.card { }               /* 0,1,1 */
#main .card { }            /* 1,1,0 */
#main .card.featured { }   /* 1,2,0 */
```

---

## Red Flags

Stop and refactor if you see:

- `style.css` nearly empty while templates full of inline styles
- Multiple `!important` declarations fighting each other
- Same inline style on multiple elements
- Hardcoded colors/spacing instead of theme.json tokens
- No clear naming convention
- Styles scattered across multiple files with no organization
