# Asset Enqueue Patterns

## Core Principle

**All CSS and JavaScript must be enqueued via WordPress functions.**

Never use hardcoded `<link>` or `<script>` tags in templates.

---

## Basic Enqueue Pattern

### CSS

```php
function theme_enqueue_styles() {
    wp_enqueue_style(
        'theme-main',                                          // Handle (unique ID)
        get_stylesheet_directory_uri() . '/assets/css/main.css', // URL
        array(),                                               // Dependencies
        '1.0.0',                                               // Version
        'all'                                                  // Media
    );
}
add_action('wp_enqueue_scripts', 'theme_enqueue_styles');
```

### JavaScript

```php
function theme_enqueue_scripts() {
    wp_enqueue_script(
        'theme-main',                                          // Handle
        get_stylesheet_directory_uri() . '/assets/js/main.js', // URL
        array('jquery'),                                       // Dependencies
        '1.0.0',                                               // Version
        true                                                   // In footer
    );
}
add_action('wp_enqueue_scripts', 'theme_enqueue_scripts');
```

---

## Child Theme Pattern

```php
function child_enqueue_styles() {
    // 1. Parent theme styles
    wp_enqueue_style(
        'parent-style',
        get_template_directory_uri() . '/style.css'
    );

    // 2. Child theme base styles (depends on parent)
    wp_enqueue_style(
        'child-style',
        get_stylesheet_directory_uri() . '/style.css',
        array('parent-style'),
        wp_get_theme()->get('Version')
    );

    // 3. Additional child theme styles
    wp_enqueue_style(
        'child-components',
        get_stylesheet_directory_uri() . '/components.css',
        array('child-style'),
        '1.0.0'
    );
}
add_action('wp_enqueue_scripts', 'child_enqueue_styles');
```

---

## Priority Control

```php
// Load early (default is 10)
add_action('wp_enqueue_scripts', 'my_early_styles', 5);

// Load late (to override other styles)
add_action('wp_enqueue_scripts', 'my_override_styles', 999);
```

---

## Conditional Enqueue

### By Page Type

```php
function conditional_styles() {
    // Only on front page
    if (is_front_page()) {
        wp_enqueue_style('homepage-style', get_stylesheet_directory_uri() . '/homepage.css');
    }

    // Only on single posts
    if (is_single()) {
        wp_enqueue_style('single-style', get_stylesheet_directory_uri() . '/single.css');
    }

    // Only on WooCommerce pages
    if (class_exists('WooCommerce') && is_woocommerce()) {
        wp_enqueue_style('shop-style', get_stylesheet_directory_uri() . '/shop.css');
    }
}
add_action('wp_enqueue_scripts', 'conditional_styles');
```

### By Page Template

```php
function template_styles() {
    if (is_page_template('templates/landing-page.php')) {
        wp_enqueue_style('landing-style', get_stylesheet_directory_uri() . '/landing.css');
    }
}
add_action('wp_enqueue_scripts', 'template_styles');
```

---

## Dequeue/Deregister

### Remove Unwanted Styles

```php
function remove_unwanted_styles() {
    wp_dequeue_style('plugin-bloated-style');
    wp_deregister_style('plugin-bloated-style');
}
add_action('wp_enqueue_scripts', 'remove_unwanted_styles', 100);
```

### Replace with Custom Version

```php
function replace_plugin_style() {
    wp_dequeue_style('plugin-style');
    wp_enqueue_style(
        'plugin-style-custom',
        get_stylesheet_directory_uri() . '/plugin-overrides.css',
        array(),
        '1.0.0'
    );
}
add_action('wp_enqueue_scripts', 'replace_plugin_style', 20);
```

---

## Inline Styles (When Necessary)

For truly dynamic values:

```php
function dynamic_inline_styles() {
    $primary_color = get_theme_mod('primary_color', '#0066cc');

    $custom_css = "
        :root {
            --primary-color: {$primary_color};
        }
    ";

    wp_add_inline_style('theme-main', $custom_css);
}
add_action('wp_enqueue_scripts', 'dynamic_inline_styles');
```

---

## Admin Styles

```php
function admin_enqueue_styles() {
    wp_enqueue_style(
        'admin-custom',
        get_stylesheet_directory_uri() . '/admin.css',
        array(),
        '1.0.0'
    );
}
add_action('admin_enqueue_scripts', 'admin_enqueue_styles');
```

---

## Block Editor Styles

```php
function editor_styles() {
    // Add editor stylesheet
    add_theme_support('editor-styles');
    add_editor_style('editor-style.css');
}
add_action('after_setup_theme', 'editor_styles');
```

---

## Common Mistakes

### WRONG - Hardcoded in Template

```php
<!-- DON'T DO THIS -->
<link rel="stylesheet" href="/wp-content/themes/mytheme/style.css">
<script src="/wp-content/themes/mytheme/main.js"></script>
```

### WRONG - Hardcoded URL

```php
// DON'T DO THIS
wp_enqueue_style('style', 'https://example.com/wp-content/themes/mytheme/style.css');
```

### CORRECT

```php
wp_enqueue_style('style', get_stylesheet_directory_uri() . '/style.css');
```
