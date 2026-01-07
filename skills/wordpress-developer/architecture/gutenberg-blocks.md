# Gutenberg Blocks Architecture

## Block Types

### Core Blocks
Built-in WordPress blocks. Prefix: `core/`

```
core/paragraph
core/heading
core/image
core/button
core/group
core/columns
core/cover
core/list
core/quote
```

### Third-Party Blocks
From plugins like GenerateBlocks. Prefix varies.

```
generateblocks/container
generateblocks/grid
generateblocks/button
generateblocks/headline
generateblocks/image
```

### Custom Blocks
Your own blocks. Use your namespace.

```
cucumber/service-card
cucumber/testimonial
cucumber/pricing-table
```

---

## Block JSON Structure

When a block is inserted, WordPress stores it as HTML comments + content:

```html
<!-- wp:heading {"level":2,"className":"my-heading"} -->
<h2 class="wp-block-heading my-heading">Hello World</h2>
<!-- /wp:heading -->

<!-- wp:paragraph {"style":{"spacing":{"padding":{"top":"20px"}}}} -->
<p style="padding-top:20px">Content here.</p>
<!-- /wp:paragraph -->
```

### The Problem with Inline Styles

When you set padding/margin in block settings, WordPress adds inline styles:

```html
<!-- wp:group {"style":{"spacing":{"padding":{"top":"70px","bottom":"70px"}}}} -->
<div class="wp-block-group" style="padding-top:70px;padding-bottom:70px">
```

**This is hard to maintain** - you can't change it globally.

### The Solution: Use CSS Classes

Instead of setting spacing in block settings, add a custom class:

```html
<!-- wp:group {"className":"section section--padded"} -->
<div class="wp-block-group section section--padded">
```

Then control in stylesheet:

```css
.section--padded {
    padding: 3rem 0;
}

@media (min-width: 768px) {
    .section--padded {
        padding: 4rem 0;
    }
}
```

---

## GenerateBlocks Patterns

### Container Block

```html
<!-- wp:generateblocks/container {"uniqueId":"abc123","className":"hero-section"} -->
<div class="gb-container gb-container-abc123 hero-section">
    <!-- content -->
</div>
<!-- /wp:generateblocks/container -->
```

### Overriding GenerateBlocks

GB generates unique IDs for each block. Override with custom class:

```css
/* Target by custom class (reliable) */
.hero-section {
    padding: 4rem 2rem;
}

/* Or increase specificity */
.gb-container.hero-section {
    padding: 4rem 2rem;
}

/* Last resort - if GB adds inline styles */
.hero-section.gb-container {
    padding: 4rem 2rem !important; /* Document why */
}
```

---

## Block Patterns

Reusable block arrangements. Register in PHP:

```php
register_block_pattern(
    'cucumber/hero-split',
    array(
        'title'       => 'Hero Split',
        'description' => 'Hero with image on left, text on right',
        'categories'  => array('cucumber-heroes'),
        'content'     => '<!-- wp:columns {"className":"hero-split"} -->
            <div class="wp-block-columns hero-split">
                <!-- wp:column -->
                <div class="wp-block-column">
                    <!-- wp:image -->
                    <figure class="wp-block-image"><img src="" alt=""/></figure>
                    <!-- /wp:image -->
                </div>
                <!-- /wp:column -->
                <!-- wp:column -->
                <div class="wp-block-column">
                    <!-- wp:heading -->
                    <h2>Heading</h2>
                    <!-- /wp:heading -->
                    <!-- wp:paragraph -->
                    <p>Description text.</p>
                    <!-- /wp:paragraph -->
                </div>
                <!-- /wp:column -->
            </div>
            <!-- /wp:columns -->',
    )
);
```

### Pattern Category

```php
register_block_pattern_category(
    'cucumber-heroes',
    array('label' => 'Cucumber Heroes')
);
```

---

## Programmatic Block Creation

When generating pages programmatically (like AEO Template Importer):

### PHP Block Generation

```php
function generate_heading_block($text, $level = 2, $class = '') {
    $attrs = array('level' => $level);
    if ($class) {
        $attrs['className'] = $class;
    }

    $attrs_json = json_encode($attrs);
    $tag = "h{$level}";

    return "<!-- wp:heading {$attrs_json} -->
<{$tag} class=\"wp-block-heading {$class}\">" . esc_html($text) . "</{$tag}>
<!-- /wp:heading -->";
}

function generate_paragraph_block($text, $class = '') {
    $attrs = $class ? array('className' => $class) : new stdClass();
    $attrs_json = json_encode($attrs);

    return "<!-- wp:paragraph {$attrs_json} -->
<p class=\"{$class}\">" . wp_kses_post($text) . "</p>
<!-- /wp:paragraph -->";
}

function generate_group_block($content, $class = '') {
    $attrs = array(
        'className' => $class,
        'layout' => array('type' => 'constrained')
    );
    $attrs_json = json_encode($attrs);

    return "<!-- wp:group {$attrs_json} -->
<div class=\"wp-block-group {$class}\">{$content}</div>
<!-- /wp:group -->";
}
```

### Best Practice: Classes Over Inline

```php
// GOOD - use classes
function generate_section($content) {
    return generate_group_block($content, 'section section--padded');
}

// BAD - inline styles
function generate_section_bad($content) {
    $attrs = array(
        'style' => array(
            'spacing' => array(
                'padding' => array('top' => '70px', 'bottom' => '70px')
            )
        )
    );
    // This creates unmaintainable inline styles
}
```

---

## Block Editor Styles

Make the editor match frontend:

### editor-style.css

```css
/* Loaded in block editor */
.editor-styles-wrapper {
    font-family: var(--font-primary);
}

.editor-styles-wrapper h1,
.editor-styles-wrapper h2 {
    font-family: var(--font-heading);
}

.editor-styles-wrapper .section--padded {
    padding: 3rem 0;
}
```

### Enqueue Editor Styles

```php
function theme_editor_styles() {
    add_theme_support('editor-styles');
    add_editor_style('editor-style.css');
}
add_action('after_setup_theme', 'theme_editor_styles');
```

---

## Common Block Classes

### WordPress Core

```css
.wp-block-heading      /* Headings */
.wp-block-paragraph    /* Paragraphs */
.wp-block-image        /* Images */
.wp-block-button       /* Buttons */
.wp-block-group        /* Groups */
.wp-block-columns      /* Columns container */
.wp-block-column       /* Individual column */
.wp-block-cover        /* Cover blocks */
```

### Alignment

```css
.alignwide             /* Wide alignment */
.alignfull             /* Full width */
.aligncenter           /* Centered */
.alignleft             /* Float left */
.alignright            /* Float right */
```

### Spacing (from theme.json)

```css
.has-small-padding     /* Uses spacing preset */
.has-medium-padding
.has-large-padding
```
