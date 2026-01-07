# theme.json Reference

## Overview

`theme.json` defines design tokens and editor settings. WordPress automatically generates CSS custom properties and utility classes from it.

---

## Basic Structure

```json
{
  "$schema": "https://schemas.wp.org/trunk/theme.json",
  "version": 3,
  "settings": { },
  "styles": { },
  "customTemplates": [ ],
  "templateParts": [ ]
}
```

---

## Color Palette

```json
{
  "settings": {
    "color": {
      "palette": [
        {
          "slug": "primary",
          "color": "#1a1a1a",
          "name": "Primary"
        },
        {
          "slug": "secondary",
          "color": "#666666",
          "name": "Secondary"
        },
        {
          "slug": "accent",
          "color": "#0066cc",
          "name": "Accent"
        },
        {
          "slug": "background",
          "color": "#ffffff",
          "name": "Background"
        },
        {
          "slug": "surface",
          "color": "#f5f5f5",
          "name": "Surface"
        }
      ]
    }
  }
}
```

### Generated CSS

```css
:root {
  --wp--preset--color--primary: #1a1a1a;
  --wp--preset--color--secondary: #666666;
  --wp--preset--color--accent: #0066cc;
}
```

### Generated Classes

```css
.has-primary-color { color: #1a1a1a; }
.has-primary-background-color { background-color: #1a1a1a; }
```

---

## Spacing Scale

```json
{
  "settings": {
    "spacing": {
      "units": ["px", "rem", "%"],
      "spacingSizes": [
        { "slug": "10", "size": "0.5rem", "name": "Extra Small" },
        { "slug": "20", "size": "1rem", "name": "Small" },
        { "slug": "30", "size": "1.5rem", "name": "Medium" },
        { "slug": "40", "size": "2rem", "name": "Large" },
        { "slug": "50", "size": "3rem", "name": "Extra Large" },
        { "slug": "60", "size": "4rem", "name": "Huge" }
      ]
    }
  }
}
```

### Generated CSS

```css
:root {
  --wp--preset--spacing--10: 0.5rem;
  --wp--preset--spacing--20: 1rem;
  --wp--preset--spacing--30: 1.5rem;
}
```

---

## Typography

```json
{
  "settings": {
    "typography": {
      "fontFamilies": [
        {
          "slug": "primary",
          "name": "Primary",
          "fontFamily": "-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif"
        },
        {
          "slug": "heading",
          "name": "Heading",
          "fontFamily": "'Playfair Display', Georgia, serif"
        }
      ],
      "fontSizes": [
        { "slug": "small", "size": "0.875rem", "name": "Small" },
        { "slug": "medium", "size": "1rem", "name": "Medium" },
        { "slug": "large", "size": "1.25rem", "name": "Large" },
        { "slug": "x-large", "size": "1.5rem", "name": "Extra Large" },
        { "slug": "huge", "size": "2.5rem", "name": "Huge" }
      ]
    }
  }
}
```

---

## Global Styles

```json
{
  "styles": {
    "color": {
      "background": "var(--wp--preset--color--background)",
      "text": "var(--wp--preset--color--primary)"
    },
    "typography": {
      "fontFamily": "var(--wp--preset--font-family--primary)",
      "fontSize": "var(--wp--preset--font-size--medium)",
      "lineHeight": "1.6"
    },
    "spacing": {
      "blockGap": "var(--wp--preset--spacing--30)"
    },
    "elements": {
      "link": {
        "color": {
          "text": "var(--wp--preset--color--accent)"
        }
      },
      "h1": {
        "typography": {
          "fontFamily": "var(--wp--preset--font-family--heading)",
          "fontSize": "var(--wp--preset--font-size--huge)"
        }
      },
      "h2": {
        "typography": {
          "fontFamily": "var(--wp--preset--font-family--heading)",
          "fontSize": "var(--wp--preset--font-size--x-large)"
        }
      }
    }
  }
}
```

---

## Block-Specific Styles

```json
{
  "styles": {
    "blocks": {
      "core/button": {
        "color": {
          "background": "var(--wp--preset--color--accent)",
          "text": "#ffffff"
        },
        "border": {
          "radius": "4px"
        }
      },
      "core/quote": {
        "border": {
          "left": {
            "color": "var(--wp--preset--color--accent)",
            "width": "4px",
            "style": "solid"
          }
        },
        "spacing": {
          "padding": {
            "left": "var(--wp--preset--spacing--30)"
          }
        }
      }
    }
  }
}
```

---

## Disable Features

```json
{
  "settings": {
    "color": {
      "custom": false,
      "customGradient": false,
      "defaultPalette": false
    },
    "typography": {
      "customFontSize": false,
      "dropCap": false
    },
    "spacing": {
      "customSpacingSize": false
    }
  }
}
```

---

## Full Example

```json
{
  "$schema": "https://schemas.wp.org/trunk/theme.json",
  "version": 3,
  "settings": {
    "color": {
      "defaultPalette": false,
      "palette": [
        { "slug": "primary", "color": "#1a1a1a", "name": "Primary" },
        { "slug": "accent", "color": "#0066cc", "name": "Accent" },
        { "slug": "background", "color": "#ffffff", "name": "Background" }
      ]
    },
    "spacing": {
      "units": ["rem"],
      "spacingSizes": [
        { "slug": "small", "size": "1rem", "name": "Small" },
        { "slug": "medium", "size": "2rem", "name": "Medium" },
        { "slug": "large", "size": "4rem", "name": "Large" }
      ]
    },
    "typography": {
      "fontFamilies": [
        {
          "slug": "system",
          "name": "System",
          "fontFamily": "-apple-system, BlinkMacSystemFont, sans-serif"
        }
      ]
    },
    "layout": {
      "contentSize": "800px",
      "wideSize": "1200px"
    }
  },
  "styles": {
    "color": {
      "background": "var(--wp--preset--color--background)",
      "text": "var(--wp--preset--color--primary)"
    }
  }
}
```

---

## Using in CSS

Reference theme.json tokens in your stylesheets:

```css
.my-component {
    color: var(--wp--preset--color--primary);
    padding: var(--wp--preset--spacing--medium);
    font-size: var(--wp--preset--font-size--large);
}
```

This ensures consistency and makes redesigns easier - change theme.json, everything updates.
