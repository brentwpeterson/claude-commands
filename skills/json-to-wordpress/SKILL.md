# JSON to WordPress - Convert JSON Landing Pages to Standard WordPress Pages

Convert Content Cucumber JSON landing page files into standalone WordPress pages via the RequestDesk API.

## Page Creation Workflow

There are two paths for creating WordPress pages:

### Path A: JSON-first (complex pages)

Best for pages with many sections, when you want to iterate on structure quickly.

1. **Create** the JSON file in `landing-data/` (fast, structured)
2. **Preview** by assigning "Landing Page - JSON" template to the page
3. **Proof** the page on the site, make revisions to the JSON
4. **Convert** by running `/json-to-wordpress <slug>` to bake JSON into HTML
5. Page template resets to default. Page is now standalone WordPress content.
6. JSON file can be kept as backup or deleted.

### Path B: Direct push (simple pages)

Best for straightforward pages that don't need iteration.

1. Use `/cucumber design` to generate HTML
2. Push via the RequestDesk API directly
3. No JSON file needed

Both paths use the same RequestDesk `/publish` API endpoint.

---

## Usage

```
/json-to-wordpress <slug>              Convert JSON to WordPress page and push
/json-to-wordpress <slug> --preview    Show HTML output without pushing
/json-to-wordpress <slug> --draft      Push as draft instead of publish
/json-to-wordpress <slug> --production Push to production (contentcucumber.com)
/json-to-wordpress list                List all JSON files in landing-data/
/json-to-wordpress --help              Show help
```

---

## Execution Steps

### Step 1: Find the JSON File

```bash
JSON_DIR="/Users/brent/LocalSites/contentcucumber/app/public/wp-content/themes/cucumber-gp-child/landing-data"
JSON_FILE="$JSON_DIR/{slug}.json"
```

If the file doesn't exist, show error and list available JSON files.

### Step 2: Find Existing WordPress Page

Search for a page with matching slug via the WP REST API:

```bash
# Default: local site
API_BASE="http://contentcucumber.local"
# With --production flag:
API_BASE="https://contentcucumber.com"

curl -sk "$API_BASE/wp-json/wp/v2/pages?slug={slug}" | python3 -c "import json,sys; pages=json.load(sys.stdin); print(pages[0]['id'] if pages else 'not found')"
```

- If found: get page ID for update
- If not found: will create new page

### Step 3: Convert JSON Sections to HTML

Read the JSON file and convert each section to styled HTML using the CC Design System.

**Wrap all output in a single WordPress HTML block:**
```html
<!-- wp:html -->
<div class="cc-page-content">
  [all sections here]
</div>
<!-- /wp:html -->
```

**All styles must be inline CSS.** Use the exact CC Design System values below.

#### CC Design System Reference

```
Colors:
  Primary Green:    #58c558 / #7ed957
  Green Hover:      #4ab34a / #6bc548
  Navy Dark:        #1a1a2e
  Navy Medium:      #0f3460
  Navy Blue:        #1e3a5f
  Primary Dark:     #2c3e50
  Red Accent:       #e94560
  Text Primary:     #333333
  Text Light:       #666666
  Surface:          #f8f9fa
  Border:           #e0e0e0

Typography:
  Font Stack:       -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif
  H1 Hero:          clamp(2rem, 5vw, 3.5rem), weight 700
  H2 Section:       32px, weight 700
  H3 Card:          22px, weight 600
  Body:             16px, line-height 1.6
  Eyebrow:          15px, uppercase, letter-spacing 0.15em, weight 700

Spacing:
  Section Padding:  80px 40px
  Card Padding:     30px
  Card Radius:      12px
  Button Padding:   16px 32px (standard), 18px 45px (large)
  Button Radius:    50px (pill)
  Container Max:    1200px
  Narrow Max:       800px
  Grid Gap:         30px
```

#### Section Type HTML Templates

**hero:**
```html
<section style="background:#1e3a5f;padding:80px 40px;text-align:center;color:#fff;">
  <div style="max-width:800px;margin:0 auto;">
    <p style="font-size:15px;font-weight:700;text-transform:uppercase;letter-spacing:0.15em;color:#7ed957;margin-bottom:16px;">{eyebrow}</p>
    <h1 style="font-size:clamp(2rem,5vw,3.5rem);font-weight:700;line-height:1.2;margin-bottom:24px;">{title}</h1>
    {paragraphs as <p> with font-size:18px;line-height:1.7;color:rgba(255,255,255,0.9);margin-bottom:20px;}
  </div>
</section>
```

**proof-bar:**
```html
<section style="padding:60px 40px;background:#f8f9fa;">
  <div style="max-width:1200px;margin:0 auto;display:grid;grid-template-columns:repeat(auto-fit,minmax(200px,1fr));gap:30px;text-align:center;">
    {for each stat:}
    <div>
      <div style="font-size:48px;font-weight:700;color:#58c558;">{number}</div>
      <div style="font-size:16px;font-weight:500;color:#666;">{label}</div>
    </div>
  </div>
</section>
```

**services / services-grid:**
```html
<section style="padding:80px 40px;background:#fff;">
  <div style="max-width:1200px;margin:0 auto;text-align:center;">
    <h2 style="font-size:32px;font-weight:700;color:#2c3e50;margin-bottom:16px;">{title}</h2>
    <p style="font-size:18px;color:#666;margin-bottom:48px;max-width:700px;margin-left:auto;margin-right:auto;">{subtitle}</p>
    <div style="display:grid;grid-template-columns:repeat(auto-fit,minmax(300px,1fr));gap:30px;text-align:left;">
      {for each item:}
      <div style="background:#f8f9fa;border-radius:12px;padding:30px;">
        <h3 style="font-size:22px;font-weight:600;color:#2c3e50;margin-bottom:12px;">{title}</h3>
        <p style="font-size:16px;color:#666;line-height:1.6;">{text}</p>
      </div>
    </div>
  </div>
</section>
```

**challenges:**
```html
<section style="padding:80px 40px;background:#fff;">
  <div style="max-width:1200px;margin:0 auto;text-align:center;">
    <h2 style="font-size:32px;font-weight:700;color:#2c3e50;margin-bottom:16px;">{title}</h2>
    <p style="font-size:18px;color:#666;margin-bottom:48px;">{subtitle}</p>
    <div style="display:grid;grid-template-columns:repeat(auto-fit,minmax(300px,1fr));gap:30px;text-align:left;">
      {for each item:}
      <div style="background:#f8f9fa;border-radius:12px;padding:30px;">
        <div style="font-size:48px;font-weight:700;color:#e94560;margin-bottom:12px;">{number}</div>
        <h3 style="font-size:22px;font-weight:600;color:#2c3e50;margin-bottom:12px;">{title}</h3>
        <p style="font-size:16px;color:#666;line-height:1.6;">{text}</p>
      </div>
    </div>
  </div>
</section>
```

**how-it-works:**
```html
<section style="padding:80px 40px;background:#0f3460;color:#fff;">
  <div style="max-width:1200px;margin:0 auto;text-align:center;">
    <h2 style="font-size:32px;font-weight:700;margin-bottom:16px;">{title}</h2>
    <p style="font-size:18px;color:#ccc;margin-bottom:48px;">{subtitle}</p>
    <div style="display:grid;grid-template-columns:repeat(auto-fit,minmax(250px,1fr));gap:30px;text-align:left;">
      {for each step:}
      <div style="padding:30px;">
        <div style="font-size:48px;font-weight:700;color:#e94560;margin-bottom:12px;">{number}</div>
        <h3 style="font-size:18px;font-weight:600;margin-bottom:12px;">{title}</h3>
        <p style="font-size:14px;color:#b0b0b0;line-height:1.6;">{text}</p>
      </div>
    </div>
  </div>
</section>
```

**shift:**
```html
<section style="padding:80px 40px;background:#fff;">
  <div style="max-width:800px;margin:0 auto;">
    <p style="font-size:15px;font-weight:700;text-transform:uppercase;letter-spacing:0.15em;color:#58c558;margin-bottom:16px;">{eyebrow}</p>
    <h2 style="font-size:32px;font-weight:700;color:#2c3e50;margin-bottom:24px;">{title}</h2>
    {paragraphs as <p> with font-size:18px;color:#666;line-height:1.8;margin-bottom:20px;}
  </div>
  <div style="max-width:1200px;margin:40px auto 0;display:grid;grid-template-columns:repeat(auto-fit,minmax(400px,1fr));gap:30px;">
    <div style="background:#f8f9fa;border-radius:12px;padding:30px;">
      <h3 style="font-size:18px;font-weight:700;color:#e94560;margin-bottom:16px;">{old_way.heading}</h3>
      <ul style="list-style:none;padding:0;margin:0;">
        {for each item:} <li style="font-size:16px;color:#666;padding:8px 0;border-bottom:1px solid #e0e0e0;">{item}</li>
      </ul>
    </div>
    <div style="background:#1a1a2e;border-radius:12px;padding:30px;color:#fff;">
      <h3 style="font-size:18px;font-weight:700;color:#7ed957;margin-bottom:16px;">{new_way.heading}</h3>
      <ul style="list-style:none;padding:0;margin:0;">
        {for each item:} <li style="font-size:16px;color:#ccc;padding:8px 0;border-bottom:1px solid rgba(255,255,255,0.1);">{item}</li>
      </ul>
    </div>
  </div>
</section>
```

**bundles:**
```html
<section style="padding:80px 40px;background:#f8f9fa;">
  <div style="max-width:1200px;margin:0 auto;text-align:center;">
    <h2 style="font-size:32px;font-weight:700;color:#2c3e50;margin-bottom:16px;">{title}</h2>
    <p style="font-size:18px;color:#666;margin-bottom:48px;">{subtitle}</p>
    <div style="display:grid;grid-template-columns:repeat(auto-fit,minmax(300px,1fr));gap:30px;text-align:left;">
      {for each item:}
      <div style="background:#fff;border-radius:12px;padding:30px;{if featured: border:2px solid #e94560;}">
        {if badge:}<span style="display:inline-block;background:#e94560;color:#fff;font-size:12px;font-weight:700;padding:4px 12px;border-radius:20px;margin-bottom:12px;">{badge}</span>
        <h3 style="font-size:22px;font-weight:600;color:#2c3e50;margin-bottom:8px;">{name}</h3>
        <p style="font-size:14px;color:#666;margin-bottom:16px;">{target}</p>
        <ul style="list-style:none;padding:0;margin:0;">
          {for each outcome:} <li style="font-size:14px;color:#333;padding:6px 0;border-bottom:1px solid #f0f0f0;">&#10003; {outcome}</li>
        </ul>
      </div>
    </div>
  </div>
</section>
```

**outcomes:**
```html
<section style="padding:80px 40px;background:#fff;">
  <div style="max-width:1200px;margin:0 auto;text-align:center;">
    <h2 style="font-size:32px;font-weight:700;color:#2c3e50;margin-bottom:16px;">{title}</h2>
    <p style="font-size:18px;color:#666;margin-bottom:48px;">{subtitle}</p>
    <div style="display:grid;grid-template-columns:repeat(auto-fit,minmax(300px,1fr));gap:30px;text-align:left;">
      {for each item:}
      <div style="background:#f8f9fa;border-radius:12px;padding:30px;">
        <h3 style="font-size:22px;font-weight:600;color:#2c3e50;margin-bottom:12px;">{title}</h3>
        <p style="font-size:16px;color:#666;line-height:1.6;">{text}</p>
      </div>
    </div>
  </div>
</section>
```

**credibility:**
```html
<section style="padding:80px 40px;background:#f8f9fa;">
  <div style="max-width:800px;margin:0 auto;">
    <p style="font-size:15px;font-weight:700;text-transform:uppercase;letter-spacing:0.15em;color:#58c558;margin-bottom:16px;">{eyebrow}</p>
    <h2 style="font-size:32px;font-weight:700;color:#2c3e50;margin-bottom:24px;">{title}</h2>
    {paragraphs as <p> with font-size:18px;color:#666;line-height:1.8;margin-bottom:20px;}
  </div>
  {if stats:}
  <div style="max-width:1200px;margin:40px auto 0;display:grid;grid-template-columns:repeat(auto-fit,minmax(200px,1fr));gap:30px;text-align:center;">
    {for each stat:}
    <div>
      <div style="font-size:48px;font-weight:700;color:#58c558;">{number}</div>
      <div style="font-size:16px;font-weight:500;color:#666;">{label}</div>
    </div>
  </div>
</section>
```

**faq:**
```html
<section style="padding:80px 40px;background:#fff;">
  <div style="max-width:800px;margin:0 auto;">
    <h2 style="font-size:32px;font-weight:700;color:#2c3e50;text-align:center;margin-bottom:48px;">{title}</h2>
    {for each item:}
    <details style="border:1px solid #e0e0e0;border-radius:8px;padding:20px;margin-bottom:15px;">
      <summary style="font-size:18px;font-weight:600;color:#2c3e50;cursor:pointer;">{question}</summary>
      <p style="font-size:16px;color:#666;line-height:1.6;margin-top:12px;">{answer}</p>
    </details>
  </div>
</section>
```

**bottom-cta:**
```html
<section style="padding:80px 40px;background:#2c3e50;text-align:center;color:#fff;">
  <div style="max-width:700px;margin:0 auto;">
    <h2 style="font-size:36px;font-weight:700;margin-bottom:16px;">{title}</h2>
    <p style="font-size:18px;color:#e0e0e0;margin-bottom:32px;">{text}</p>
  </div>
</section>
```

**case-study:**
```html
<section style="padding:80px 40px;background:#1a1a2e;color:#fff;">
  <div style="max-width:1200px;margin:0 auto;display:grid;grid-template-columns:repeat(auto-fit,minmax(400px,1fr));gap:60px;align-items:center;">
    <div>
      {if image:}<img src="{image}" alt="{image_alt}" style="width:100%;border-radius:12px;" />
    </div>
    <div>
      <p style="font-size:15px;font-weight:700;text-transform:uppercase;letter-spacing:0.15em;color:#7ed957;margin-bottom:16px;">{eyebrow}</p>
      <h2 style="font-size:32px;font-weight:700;margin-bottom:24px;">{title}</h2>
      {text array as <p> with font-size:16px;color:#ccc;line-height:1.7;margin-bottom:16px;}
      {if stats:}
      <div style="display:grid;grid-template-columns:repeat(3,1fr);gap:20px;margin-top:30px;">
        {for each stat:}
        <div>
          <div style="font-size:32px;font-weight:700;color:#7ed957;">{number}</div>
          <div style="font-size:14px;color:#999;">{label}</div>
        </div>
      </div>
    </div>
  </div>
</section>
```

**video-embed:**
```html
<section style="padding:80px 40px;background:#fff;">
  <div style="max-width:1200px;margin:0 auto;display:grid;grid-template-columns:repeat(auto-fit,minmax(400px,1fr));gap:60px;align-items:center;">
    <div>
      <div style="position:relative;padding-bottom:{aspect ratio %};height:0;overflow:hidden;border-radius:12px;">
        <iframe src="https://www.youtube.com/embed/{youtube_id}" style="position:absolute;top:0;left:0;width:100%;height:100%;border:0;" allowfullscreen></iframe>
      </div>
    </div>
    <div>
      <h2 style="font-size:32px;font-weight:700;color:#2c3e50;margin-bottom:16px;">{heading}</h2>
      {paragraphs}
      {if points: render as list}
    </div>
  </div>
</section>
```

**banner-image:**
```html
<section style="padding:0;">
  <img src="{src}" alt="{alt}" style="width:100%;display:block;" />
</section>
```

**who-its-for:**
```html
<section style="padding:80px 40px;background:#fff;">
  <div style="max-width:800px;margin:0 auto;text-align:center;">
    <h2 style="font-size:32px;font-weight:700;color:#2c3e50;margin-bottom:16px;">{title}</h2>
    <p style="font-size:18px;color:#666;margin-bottom:48px;">{subtitle}</p>
    <div style="display:grid;grid-template-columns:repeat(auto-fit,minmax(350px,1fr));gap:30px;text-align:left;">
      <div style="background:#f0fdf0;border-radius:12px;padding:30px;">
        <h3 style="font-size:18px;font-weight:700;color:#58c558;margin-bottom:16px;">Good Fit</h3>
        {for each fit:} <p style="font-size:16px;color:#333;padding:8px 0;">&#10003; {text}</p>
      </div>
      <div style="background:#fef2f2;border-radius:12px;padding:30px;">
        <h3 style="font-size:18px;font-weight:700;color:#e94560;margin-bottom:16px;">Not the Right Fit</h3>
        {for each not_fit:} <p style="font-size:16px;color:#333;padding:8px 0;">&#10007; {text}</p>
      </div>
    </div>
  </div>
</section>
```

**ecosystem:**
```html
<section style="padding:80px 40px;background:#1a1a2e;color:#fff;">
  <div style="max-width:1200px;margin:0 auto;text-align:center;">
    <h2 style="font-size:32px;font-weight:700;margin-bottom:16px;">{title}</h2>
    <p style="font-size:18px;color:#ccc;margin-bottom:48px;">{subtitle}</p>
    <div style="display:grid;grid-template-columns:repeat(auto-fit,minmax(300px,1fr));gap:30px;text-align:left;">
      {for each brand:}
      <div style="background:rgba(255,255,255,0.05);border-radius:12px;padding:30px;{if current: border:2px solid #7ed957;}">
        <h3 style="font-size:22px;font-weight:600;margin-bottom:4px;">{name}</h3>
        <p style="font-size:14px;color:#7ed957;margin-bottom:12px;">{role}</p>
        <p style="font-size:16px;color:#ccc;line-height:1.6;">{description}</p>
      </div>
    </div>
  </div>
</section>
```

**latest-posts:**
```html
<section style="padding:80px 40px;background:#f8f9fa;">
  <div style="max-width:1200px;margin:0 auto;text-align:center;">
    <h2 style="font-size:32px;font-weight:700;color:#2c3e50;margin-bottom:16px;">{title}</h2>
    <p style="font-size:18px;color:#666;margin-bottom:32px;">{subtitle}</p>
    <p style="font-size:16px;color:#666;">[Dynamic blog posts render here. Use a WordPress block or shortcode for live posts.]</p>
    <a href="{cta_link}" style="display:inline-block;margin-top:24px;padding:14px 32px;background:#58c558;color:#fff;font-size:16px;font-weight:600;border-radius:50px;text-decoration:none;">{cta_text}</a>
  </div>
</section>
```

**partner-carousel:**
```html
<section style="padding:60px 40px;background:#fff;">
  <div style="max-width:1200px;margin:0 auto;text-align:center;">
    <h2 style="font-size:32px;font-weight:700;color:#2c3e50;margin-bottom:16px;">{title}</h2>
    <p style="font-size:18px;color:#666;margin-bottom:32px;">{subtitle}</p>
    <p style="font-size:16px;color:#999;">[Partner logos render dynamically. Use a WordPress block or shortcode.]</p>
  </div>
</section>
```

**comparison-table:**
```html
<section style="padding:80px 40px;background:#fff;">
  <div style="max-width:800px;margin:0 auto;text-align:center;">
    <h2 style="font-size:32px;font-weight:700;color:#2c3e50;margin-bottom:16px;">{title}</h2>
    <p style="font-size:18px;color:#666;margin-bottom:32px;">{subtitle}</p>
    <p style="font-size:16px;color:#999;">[Comparison table renders dynamically from homepage renderer.]</p>
  </div>
</section>
```

### Step 4: Handle Forms

If the JSON has a `form` section, render it as a HubSpot embed at the top of the page (or where the form section appears):

```html
<section style="padding:60px 40px;background:#f8f9fa;">
  <div style="max-width:600px;margin:0 auto;text-align:center;">
    <h2 style="font-size:28px;font-weight:700;color:#2c3e50;margin-bottom:8px;">{form.header}</h2>
    {if form.subtitle:}<p style="font-size:16px;color:#666;margin-bottom:8px;">{form.subtitle}</p>
    {if form.trust_text:}<p style="font-size:14px;color:#999;margin-bottom:24px;">{form.trust_text}</p>
    <div id="hubspot-form-{slug}">
      <script charset="utf-8" type="text/javascript" src="//js.hsforms.net/forms/embed/v2.js"></script>
      <script>
        hbspt.forms.create({
          region: "{form.region}",
          portalId: "{form.portal_id}",
          formId: "{form.form_id}",
          target: "#hubspot-form-{slug}"
        });
      </script>
    </div>
  </div>
</section>
```

If `form.bottom_only` is true, place the form at the bottom before the CTA.

### Step 5: Push to WordPress

```bash
API_KEY="spF-vAD3uzTiEYyaxF9TD0zQ01zUny5DK4eVjIMPuB8"

# Local (default)
API_BASE="http://contentcucumber.local"
# Production (--production flag required)
API_BASE="https://contentcucumber.com"

curl -sk "$API_BASE/wp-json/requestdesk/v1/publish" \
  -X POST \
  -H "X-RequestDesk-API-Key: $API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "[title from JSON or formatted slug]",
    "content": "[generated HTML wrapped in wp:html block]",
    "post_id": "[page ID if updating]",
    "status": "publish",
    "template": ""
  }'
```

- `template: ""` clears the JSON template, reverting to default
- If `--draft` flag is set, use `"status": "draft"`
- **CRITICAL:** Never push to production without explicit `--production` flag. Default is always local.

### Step 6: Handle Spanish Version

If `{slug}-es.json` exists in the same directory:

1. Convert it to HTML using the same process
2. Search for the Spanish page:
   ```bash
   # Get the English page's linked translations via Polylang
   curl -sk "$API_BASE/wp-json/wp/v2/pages?slug={spanish-slug}"
   ```
3. If Spanish page found: update it with the Spanish HTML
4. If not found: report that a Spanish page needs to be created in wp-admin first
5. Clear the template on the Spanish page too

### Step 7: Output Summary

```
## Converted: {slug}

**English page:** {url} (ID: {id}) - {created/updated}
**Spanish page:** {url} (ID: {id}) - {created/updated}
  (or "No Spanish page found - create in wp-admin first")
**Sections converted:** {count}
**Form included:** {yes/no}
**Template:** Reset to default

The page is now standalone WordPress content.
JSON file kept as backup at: landing-data/{slug}.json
```

---

## `list` Subcommand

Show all JSON files with metadata:

```bash
JSON_DIR="/Users/brent/LocalSites/contentcucumber/app/public/wp-content/themes/cucumber-gp-child/landing-data"
```

Output format:
```
## JSON Landing Pages

| File | Sections | Spanish | WP Page |
|------|----------|---------|---------|
| about-us.json | 7 | yes | ID: 19958 |
| agency-white-label.json | 10 | yes | ID: ??? |
| growth-marketing.json | 8 | yes | not found |
| ... | ... | ... | ... |

Total: {N} English files, {M} with Spanish translations
```

For each file:
- Count sections in the JSON
- Check if `-es.json` exists
- Search WP API for a page with matching slug

---

## Critical Rules

- Do NOT use em dashes in any generated content
- All styles MUST be inline CSS (no external stylesheets, no `<style>` blocks)
- Use CC Design System values exactly (colors, fonts, spacing defined above)
- Wrap all HTML in `<!-- wp:html -->` blocks
- Default target is LOCAL (`contentcucumber.local`). Never push to production without `--production` flag
- Always show the user what will be pushed before pushing (unless `--preview` was used to review already)
- The API key is the same for local and production (RequestDesk plugin key)

---

## API Reference

| Endpoint | Method | Purpose |
|----------|--------|---------|
| `/wp-json/wp/v2/pages?slug={slug}` | GET | Find existing page by slug (no auth needed) |
| `/wp-json/requestdesk/v1/publish` | POST | Create or update page content |
| `/wp-json/requestdesk/v1/test-connection` | GET | Verify API key works |

**Auth header:** `X-RequestDesk-API-Key: spF-vAD3uzTiEYyaxF9TD0zQ01zUny5DK4eVjIMPuB8`

**Publish endpoint parameters:**

| Param | Type | Required | Description |
|-------|------|----------|-------------|
| `title` | string | yes | Page title |
| `content` | string | yes | HTML content |
| `status` | string | no | `draft` or `publish` (default: draft) |
| `post_id` | string | no | Page ID to update (omit to create new) |
| `template` | string | no | Page template filename (empty string = default) |
| `excerpt` | string | no | Page excerpt / meta description |

---

## File Locations

```
JSON files:     /Users/brent/LocalSites/contentcucumber/app/public/wp-content/themes/cucumber-gp-child/landing-data/
Theme:          /Users/brent/LocalSites/contentcucumber/app/public/wp-content/themes/cucumber-gp-child/
Plugin:         /Users/brent/LocalSites/contentcucumber/app/public/wp-content/plugins/requestdesk-connector/
Git repo:       /Users/brent/LocalSites/contentcucumber/ (git@github.com:brentwpeterson/contentcucumber.git)
```
