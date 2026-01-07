# WordPress Theme Structure

## Standard Theme Hierarchy

```
theme-name/
├── style.css              # Required - theme metadata + global styles
├── functions.php          # Theme setup, enqueues, hooks
├── index.php              # Fallback template (required)
├── screenshot.png         # Theme thumbnail (1200x900)
│
├── assets/
│   ├── css/               # Stylesheets
│   ├── js/                # JavaScript
│   ├── images/            # Theme images
│   └── fonts/             # Custom fonts
│
├── template-parts/        # Reusable template fragments
│   ├── header/
│   ├── footer/
│   ├── content/
│   └── sidebar/
│
├── templates/             # Full page templates
│   ├── page-about.php
│   └── page-contact.php
│
├── inc/                   # PHP includes
│   ├── customizer.php
│   ├── template-tags.php
│   └── widgets.php
│
├── theme.json             # Block editor settings (WP 5.8+)
└── README.md              # Theme documentation
```

---

## Child Theme Structure

**Always use child themes for customizations.**

```
parent-theme/              # Never modify directly
child-theme/
├── style.css              # Required - must reference parent
├── functions.php          # Child-specific functions
├── theme.json             # Overrides parent theme.json
└── [any overridden files]
```

### style.css Header (Required)

```css
/*
Theme Name: My Child Theme
Template: parent-theme-folder-name
Version: 1.0.0
*/
```

### functions.php Pattern

```php
<?php
// Enqueue parent + child styles
function child_enqueue_styles() {
    // Parent first
    wp_enqueue_style('parent-style', get_template_directory_uri() . '/style.css');

    // Child after (will override)
    wp_enqueue_style('child-style', get_stylesheet_directory_uri() . '/style.css',
        array('parent-style'),
        wp_get_theme()->get('Version')
    );
}
add_action('wp_enqueue_scripts', 'child_enqueue_styles');
```

---

## Template Hierarchy

WordPress loads templates in a specific order. More specific wins:

### Pages
1. `page-{slug}.php` (page-about.php)
2. `page-{id}.php` (page-42.php)
3. `page.php`
4. `singular.php`
5. `index.php`

### Posts
1. `single-{post-type}-{slug}.php`
2. `single-{post-type}.php`
3. `single.php`
4. `singular.php`
5. `index.php`

### Archives
1. `category-{slug}.php`
2. `category-{id}.php`
3. `category.php`
4. `archive.php`
5. `index.php`

---

## Key Functions

### URLs
```php
get_template_directory_uri()      // Parent theme URL
get_stylesheet_directory_uri()    // Child theme URL (use this in child themes)
get_template_directory()          // Parent theme path (filesystem)
get_stylesheet_directory()        // Child theme path (filesystem)
```

### Conditionals
```php
is_page('about')                  // Specific page
is_single()                       // Single post
is_front_page()                   // Front page
is_home()                         // Blog index
is_archive()                      // Any archive
is_admin()                        // Admin dashboard
```

---

## Best Practices

1. **Never modify parent themes** - Use child themes
2. **Use template parts** - `get_template_part('template-parts/content', 'post')`
3. **Escape output** - `esc_html()`, `esc_attr()`, `esc_url()`
4. **Translate strings** - `__('Text', 'textdomain')`, `_e('Text', 'textdomain')`
5. **Prefix functions** - `mytheme_function_name()` to avoid conflicts
