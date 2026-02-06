# Content Cucumber - Full Brand Skill

Content creation and WordPress page design for Content Cucumber.

## Subcommands

| Subcommand | Purpose |
|------------|---------|
| `design` | Generate full WordPress pages (Astro-style HTML injection) |
| `writer` | Write content (blog, service, landing, social, email, meta) |
| `brand` | Load Content Cucumber brand persona only |

---

## Step 1: Always Fetch Brand Persona First

Every subcommand starts by loading the brand persona from RequestDesk.

```bash
curl -s -X POST "https://app.requestdesk.ai/api/agent/content" \
  -H "Authorization: Bearer spF-vAD3uzTiEYyaxF9TD0zQ01zUny5DK4eVjIMPuB8" \
  -H "Content-Type: application/json"
```

Parse and internalize:
- Brand personality and voice
- Words/phrases to AVOID
- Preferred language patterns
- Tone and style guidelines
- Target audience characteristics

Confirm:
```
## Content Cucumber Voice Loaded

**Writing Style:** [1 sentence summary]
**Audience:** [Target audience]
**Tone:** [Key tone descriptors]

Running: /cucumber [subcommand] "[topic]"
```

---

## Brand Voice Quick Reference

### Content Cucumber Writes Like:
- A helpful expert friend, not a salesperson
- Confident but not arrogant
- Clear and direct, not fluffy
- Practical with real examples
- Warm and approachable

### Never Use:
- Em dashes (use periods, commas, or parentheses instead)
- "Unlock your potential"
- "Take it to the next level"
- "Game-changer"
- "Synergy"
- Excessive exclamation points
- Empty superlatives
- Emojis (unless explicitly requested)

### Always Include:
- Specific, concrete examples
- Actionable advice
- Genuine helpfulness
- Natural transitions
- Clear value proposition

---

## Subcommand: `design`

### Overview

Astro-style workflow for WordPress. Write all content and design in one shot, output as
styled HTML that WordPress renders inside the GeneratePress theme wrapper.

**How it works:**
- GeneratePress handles the page chrome (header, footer, nav, sidebar)
- The content area receives ONE Custom HTML block with the full designed page
- All styling is inline (no external CSS dependencies beyond what the theme already loads)
- No block-by-block assembly. One block, full page.

### Design Quality: Frontend Design Principles

**REQUIRED:** Before generating any page, read and apply `.claude/commands/frontend-design.md`.
The `design` subcommand is NOT just content injection. It's design work. Every page should
feel intentionally designed, not template-stamped.

**Apply these principles to every page:**

- **Bold aesthetic direction** - Commit to a clear visual concept for each page. A services
  page feels different from a landing page feels different from an about page.
- **Typography with character** - Use the CC font stack but vary weights, sizes, and spacing
  to create hierarchy and visual interest. Not every H2 needs to look the same.
- **Color with intent** - Don't just alternate white/dark sections mechanically. Use the CC
  palette strategically. Dominant colors with sharp accents, not timid even distribution.
- **Spatial composition** - Asymmetry, generous negative space, unexpected layouts. Break the
  grid where it serves the content. Not every section needs to be centered.
- **Motion and micro-interactions** - Add CSS transitions, hover states, and scroll-triggered
  effects where they enhance the experience. Staggered reveals on card grids. Subtle button
  lifts. Details that reward attention.
- **Atmosphere and depth** - Gradient meshes, subtle textures, layered transparencies,
  shadows that create dimension. Not flat colored boxes.

**Anti-patterns to AVOID:**
- Generic AI-generated aesthetics (every section looks the same)
- Cookie-cutter alternating white/dark/white/dark layouts
- Identical card grids on every page
- No visual rhythm or surprise
- Predictable, safe compositions

**The section templates below are starting points, not final output.** Adapt, combine, break,
and reimagine them for each page. The CC color palette and typography are constraints to
work within, not a cage.

### Output Modes

There are two output modes. Choose based on whether the page will be edited after creation.

**Default: Single HTML Block (no flag)**
- Outputs one `<!-- wp:html -->` block with all content and inline styles
- Best for: service pages, landing pages, campaign pages, one-off pages
- These are "write once" pages. If they need updating, re-run `/cucumber design`
- Fast to create, visually consistent, no block editor knowledge needed

**`--blocks`: GenerateBlocks V2 Output**
- Outputs individual `generateblocks/element`, `generateblocks/text`, and `generateblocks/media` blocks
- Best for: homepage, about page, any page that non-technical people will edit
- Each section is a separate block that can be clicked and edited in the WordPress editor
- Uses GenerateBlocks V2 architecture (see `Claude-Skills/generateblocks-skills/`)
- Slower to generate but fully editable after creation

### Flags

- `--blocks` - Output as individual GenerateBlocks V2 blocks (editable in WP editor)
- `--push` - Push directly to WordPress via REST API (creates draft page)
- `--slug my-page` - Set the page slug (default: generated from title)
- `--template blank` - Use blank page template (no sidebar, full width)

### Workflow

1. **Gather page brief from user:**
   - Page title / headline
   - Target keyword(s)
   - Page purpose (service, info, landing, etc.)
   - Sections desired (or let Claude suggest based on type)
   - Any specific CTAs

2. **Build page structure** - Select from available section types:

   | Section | When to Use |
   |---------|-------------|
   | Hero | Always first. Headline + tagline + optional CTA |
   | Intro/Problem | Set context, describe the pain point |
   | Benefits/Features | 3-6 value props in card grid |
   | Process/Steps | How-it-works (3-5 steps) |
   | Stats | Social proof with numbers |
   | Testimonials | Client quotes |
   | FAQ | 3-7 questions (schema-ready) |
   | CTA | Final call-to-action section |

3. **Generate output based on mode:**

   **Default mode (single HTML block):**
   ```html
   <!-- wp:html -->
   <div class="cc-page-content">
     [full styled HTML here]
   </div>
   <!-- /wp:html -->
   ```

   **`--blocks` mode (GenerateBlocks V2):**
   Each section becomes separate GenerateBlocks blocks. Read
   `Claude-Skills/generateblocks-skills/skills/generateblocks-layouts/SKILL.md`
   for the V2 block format. Use the CC design system values for all styling.
   ```html
   <!-- wp:generateblocks/element {"uniqueId":"hero001","tagName":"section","styles":{...}} -->
   <section class="gb-element gb-element-hero001">
     <!-- inner blocks -->
   </section>
   <!-- /wp:generateblocks/element -->
   ```

5. **If `--push` flag is set**, push to WordPress via REST API:
   ```bash
   curl -s -X POST "https://contentcucumber.com/wp-json/wp/v2/pages" \
     -H "Authorization: Basic [base64_credentials]" \
     -H "Content-Type: application/json" \
     -d '{"title":"Page Title","content":"[HTML]","status":"draft","template":"blank"}'
   ```
   Report the draft URL back to the user for review.

6. **Present to user:**
   ```
   ## WP Page: [Topic]

   **Sections:** Hero, Benefits, Process, FAQ, CTA
   **Word count:** ~[N] words
   **Target keyword:** [keyword]

   [Show full HTML in code block]

   ---

   ### Next Steps
   - **Preview locally:** Paste into Custom HTML block on contentcucumber.local
   - **Push to draft:** Re-run with `--push` to create a draft page
   - **Adjust sections:** "Remove the stats section" / "Add testimonials"
   ```

---

## CC Design System

These are the exact values from the `cucumber-gp-child` WordPress theme.
All styling is inline so it works in a Custom HTML block without dependencies.

### Colors

```
Primary Green:    #58c558 / #7ed957 (CTAs, accents, hover states)
Green Hover:      #4ab34a / #6bc548
Navy Dark:        #1a1a2e (hero backgrounds, dark sections)
Navy Medium:      #0f3460 (stats, process sections)
Navy Blue:        #1e3a5f (default hero theme)
Primary Dark:     #2c3e50 (CTA sections, headings)
Red Accent:       #e94560 (featured items, accent buttons)
Text Primary:     #333333
Text Light:       #666666 / #6b7280
Surface:          #f8f9fa (light section backgrounds)
Border:           #e0e0e0
White:            #ffffff
```

### Typography

```
Font Stack:       -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif
Heading Weight:   700
Body Size:        16px, line-height 1.6-1.8
H1 Hero:          clamp(2.5rem, 6vw, 4.5rem)
H1 Section:       36-44px
H2:               32px section headings
H3:               22-24px card titles, font-weight 600
Eyebrow/Label:    15px, uppercase, letter-spacing 0.15em, weight 700
Small Text:       14px
```

### Spacing

```
Section Padding:  80px 40px (desktop), 40px 20px (mobile)
Card Padding:     25-30px
Card Radius:      12px
Button Padding:   16px 32px (standard), 18px 45px (large)
Button Radius:    50px (pill) or 8px (standard)
Container Max:    1200px
Narrow Max:       800px
Grid Gap:         30px
```

### Responsive Breakpoints

```
Desktop:          1025px+
Tablet:           768px - 1024px
Mobile:           < 768px
```

The `auto-fit` + `minmax()` grid patterns handle mobile automatically.
The `clamp()` on hero text handles fluid typography.
No media queries needed for basic layouts.

---

## Section Templates

Use these HTML patterns when generating `design` pages.

### Hero Section

```html
<section style="background:#1e3a5f;padding:80px 40px;text-align:center;color:#fff;">
  <div style="max-width:800px;margin:0 auto;">
    <p style="font-size:15px;font-weight:700;text-transform:uppercase;letter-spacing:0.15em;color:#7ed957;margin-bottom:16px;">[EYEBROW]</p>
    <h1 style="font-size:clamp(2rem,5vw,3.5rem);font-weight:700;line-height:1.2;margin-bottom:24px;">[HEADLINE]</h1>
    <p style="font-size:18px;line-height:1.7;color:rgba(255,255,255,0.9);margin-bottom:32px;">[SUBTITLE]</p>
    <a href="[CTA_URL]" style="display:inline-block;padding:16px 40px;background:#7ed957;color:#1a1a1a;font-size:16px;font-weight:600;border-radius:50px;text-decoration:none;">
      [CTA_TEXT]
    </a>
  </div>
</section>
```

**Hero color variants:**
- Default navy: `background:#1e3a5f`
- Dark: `background:#1a1a2e`
- Green: `background:#58c558` with `color:#1a1a1a` for text
- Orange: `background:#f39c12` with `color:#1a1a1a` for text

### Benefits/Features Grid

```html
<section style="padding:80px 40px;background:#fff;">
  <div style="max-width:1200px;margin:0 auto;text-align:center;">
    <h2 style="font-size:32px;font-weight:700;color:#2c3e50;margin-bottom:16px;">[SECTION TITLE]</h2>
    <p style="font-size:18px;color:#666;margin-bottom:48px;max-width:700px;margin-left:auto;margin-right:auto;">[SECTION SUBTITLE]</p>
    <div style="display:grid;grid-template-columns:repeat(auto-fit,minmax(300px,1fr));gap:30px;text-align:left;">
      <!-- Repeat card for each benefit -->
      <div style="background:#f8f9fa;border-radius:12px;padding:30px;">
        <div style="font-size:40px;margin-bottom:16px;">[ICON/EMOJI]</div>
        <h3 style="font-size:22px;font-weight:600;color:#2c3e50;margin-bottom:12px;">[BENEFIT TITLE]</h3>
        <p style="font-size:16px;color:#666;line-height:1.6;">[BENEFIT DESCRIPTION]</p>
      </div>
    </div>
  </div>
</section>
```

### Process/Steps Section (dark)

```html
<section style="padding:80px 40px;background:#0f3460;color:#fff;">
  <div style="max-width:1200px;margin:0 auto;text-align:center;">
    <h2 style="font-size:32px;font-weight:700;margin-bottom:48px;">[SECTION TITLE]</h2>
    <div style="display:grid;grid-template-columns:repeat(auto-fit,minmax(250px,1fr));gap:30px;text-align:left;">
      <!-- Repeat for each step -->
      <div style="padding:30px;">
        <div style="font-size:48px;font-weight:700;color:#e94560;margin-bottom:12px;">01</div>
        <h3 style="font-size:18px;font-weight:600;margin-bottom:12px;">[STEP TITLE]</h3>
        <p style="font-size:14px;color:#b0b0b0;line-height:1.6;">[STEP DESCRIPTION]</p>
      </div>
    </div>
  </div>
</section>
```

### Stats Section

```html
<section style="padding:80px 40px;background:#f8f9fa;">
  <div style="max-width:1200px;margin:0 auto;display:grid;grid-template-columns:repeat(auto-fit,minmax(200px,1fr));gap:30px;text-align:center;">
    <!-- Repeat for each stat -->
    <div>
      <div style="font-size:48px;font-weight:700;color:#58c558;">[NUMBER]</div>
      <div style="font-size:16px;font-weight:500;color:#666;">[LABEL]</div>
    </div>
  </div>
</section>
```

### FAQ Section (schema-ready)

```html
<section style="padding:80px 40px;background:#fff;">
  <div style="max-width:800px;margin:0 auto;">
    <h2 style="font-size:32px;font-weight:700;color:#2c3e50;text-align:center;margin-bottom:48px;">[FAQ TITLE]</h2>
    <!-- Repeat for each FAQ -->
    <details style="border:1px solid #e0e0e0;border-radius:8px;padding:20px;margin-bottom:15px;">
      <summary style="font-size:18px;font-weight:600;color:#2c3e50;cursor:pointer;">[QUESTION]</summary>
      <p style="font-size:16px;color:#666;line-height:1.6;margin-top:12px;">[ANSWER]</p>
    </details>
  </div>
</section>
```

### CTA Section

```html
<section style="padding:80px 40px;background:#2c3e50;text-align:center;color:#fff;">
  <div style="max-width:700px;margin:0 auto;">
    <h2 style="font-size:36px;font-weight:700;margin-bottom:16px;">[CTA HEADLINE]</h2>
    <p style="font-size:18px;color:#e0e0e0;margin-bottom:32px;">[CTA SUBTITLE]</p>
    <a href="[CTA_URL]" style="display:inline-block;padding:18px 45px;background:#7ed957;color:#1a1a1a;font-size:18px;font-weight:600;border-radius:50px;text-decoration:none;">
      [CTA_TEXT]
    </a>
  </div>
</section>
```

### Testimonial Section (dark)

```html
<section style="padding:80px 40px;background:#1a1a2e;color:#fff;">
  <div style="max-width:1200px;margin:0 auto;text-align:center;">
    <h2 style="font-size:36px;font-weight:600;margin-bottom:16px;">[SECTION TITLE]</h2>
    <p style="font-size:18px;color:#ccc;margin-bottom:48px;">[SECTION SUBTITLE]</p>
    <div style="display:grid;grid-template-columns:repeat(auto-fit,minmax(300px,1fr));gap:30px;text-align:left;">
      <!-- Repeat for each testimonial -->
      <div style="background:rgba(255,255,255,0.05);border-radius:12px;padding:30px;">
        <div style="color:#ffc107;font-size:20px;margin-bottom:12px;">&#9733;&#9733;&#9733;&#9733;&#9733;</div>
        <p style="font-size:16px;font-style:italic;line-height:1.6;margin-bottom:16px;">"[QUOTE]"</p>
        <p style="font-size:16px;font-weight:600;">[NAME]</p>
        <p style="font-size:14px;color:#999;">[TITLE/COMPANY]</p>
      </div>
    </div>
  </div>
</section>
```

### Intro/Problem Section

```html
<section style="padding:80px 40px;background:#fff;">
  <div style="max-width:800px;margin:0 auto;">
    <h2 style="font-size:32px;font-weight:700;color:#2c3e50;margin-bottom:24px;text-align:center;">[SECTION TITLE]</h2>
    <p style="font-size:18px;color:#666;line-height:1.8;margin-bottom:20px;">[PARAGRAPH 1]</p>
    <p style="font-size:18px;color:#666;line-height:1.8;margin-bottom:20px;">[PARAGRAPH 2]</p>
  </div>
</section>
```

### Two-Column Section (text + image)

```html
<section style="padding:80px 40px;background:#fff;">
  <div style="max-width:1200px;margin:0 auto;display:grid;grid-template-columns:repeat(auto-fit,minmax(400px,1fr));gap:60px;align-items:center;">
    <div>
      <p style="font-size:15px;font-weight:700;text-transform:uppercase;letter-spacing:0.15em;color:#58c558;margin-bottom:16px;">[EYEBROW]</p>
      <h2 style="font-size:32px;font-weight:700;color:#2c3e50;margin-bottom:16px;">[HEADING]</h2>
      <p style="font-size:16px;color:#666;line-height:1.7;margin-bottom:24px;">[DESCRIPTION]</p>
      <a href="[CTA_URL]" style="display:inline-block;padding:14px 32px;background:#58c558;color:#fff;font-size:16px;font-weight:600;border-radius:50px;text-decoration:none;">
        [CTA_TEXT]
      </a>
    </div>
    <div>
      <img src="[IMAGE_URL]" alt="[ALT TEXT]" style="width:100%;border-radius:12px;" />
    </div>
  </div>
</section>
```

---

## Subcommand: `writer`

### Content Types

| Type | Description | Output |
|------|-------------|--------|
| `blog` | Blog post (800-1500 words) | Full article with H2s, intro, conclusion |
| `service` | Service page content | Hero, benefits, process, FAQ |
| `landing-child` | Child landing page for /services/ | Full AEO-optimized page content |
| `landing-parent` | Parent landing page | Category overview content |
| `social` | Social media posts | LinkedIn, Twitter, Facebook versions |
| `email` | Email newsletter | Subject line + body |
| `meta` | Meta descriptions | Title tag + meta description |

### For `blog` posts:
1. Create compelling headline (use numbers, questions, or power words)
2. Write engaging intro (hook + promise)
3. Structure with H2 subheadings
4. Include actionable tips/insights
5. Add internal linking suggestions
6. Write strong CTA conclusion
7. Suggest meta description

### For `service` pages:
1. Hero headline + tagline
2. Problem/solution intro
3. 6 key benefits with icons
4. 4-step process
5. 5 FAQ questions with answers
6. Testimonial placeholder
7. CTA section

### For `landing-child` pages:
Generate content matching the AEO Landing Page Child template:
1. Service name and slug
2. Hero headline
3. Summary for parent grid (2-3 sentences)
4. 6 benefits
5. 4 process steps
6. 5 FAQs with schema-ready answers
7. Related services suggestions

Output as CSV-ready format:
```csv
service_name,hero_headline,summary,benefit_1_title,benefit_1_desc,...
```

### For `social` posts:
Create platform-specific versions:
- **LinkedIn:** Professional, 150-200 words, include hashtags
- **Twitter/X:** Under 280 chars, punchy, 2-3 hashtags
- **Facebook:** Conversational, 100-150 words, engagement question

### For `email` content:
1. 3 subject line options (A/B test ready)
2. Preview text
3. Email body with clear sections
4. CTA button text

### For `meta` descriptions:
1. Title tag (50-60 chars)
2. Meta description (150-160 chars)
3. Include primary keyword naturally

### Review Checklist

Before presenting any content:
- [ ] No forbidden phrases used (check brand persona response)
- [ ] No em dashes (use periods, commas, parentheses)
- [ ] No emojis (unless requested)
- [ ] Tone matches guidelines
- [ ] Active voice preferred
- [ ] Jargon-free where possible
- [ ] Authentic, not salesy

### Present Content

```
## [Content Type]: [Topic]

[Generated content here]

---

### Quick Edits
- **Make it shorter:** [suggestion]
- **Make it punchier:** [suggestion]
- **Add more detail:** [suggestion]

Would you like me to adjust anything?
```

---

## Subcommand: `brand`

Load the Content Cucumber brand persona and display it. No content generation.
Useful when switching contexts or before a series of manual writing tasks.

1. Call the brand endpoint (Step 1 above)
2. Display the full persona summary
3. Confirm voice is loaded for the session

---

## API Reference

| Purpose | Endpoint | Method | Auth |
|---------|----------|--------|------|
| Brand Persona | `https://app.requestdesk.ai/api/agent/content` | POST | `Bearer spF-vAD3uzTiEYyaxF9TD0zQ01zUny5DK4eVjIMPuB8` |
| WordPress Pages | `https://contentcucumber.com/wp-json/wp/v2/pages` | POST | Basic auth (ask user) |
| WordPress Posts | `https://contentcucumber.com/wp-json/wp/v2/posts` | POST | Basic auth (ask user) |

## TODOs

- [ ] Update Canva Brand Kit with CC design system (colors, fonts, spacing to match child theme)
- [ ] Get Content Cucumber brand to 100% in RequestDesk (persona, voice, all fields complete)
- [ ] WordPress REST API auth setup for `--push` workflow (currently placeholder credentials)
- [ ] Test `--push` workflow on contentcucumber.local
- [ ] Add section templates: pricing table, logo grid, comparison table
- [ ] Add `design` support for blog posts (not just pages)
- [ ] Define Content Cucumber tagline (TBD in brand-family skill)

---

## Integration with Other Skills

- **`/brand-cucumber`** - Lighter version, just loads persona (this skill replaces it)
- **Template Importer** - `landing-child` CSV output works with RequestDesk Template Importer
- **GenerateBlocks Skills** - For block-by-block layouts, use `Claude-Skills/generateblocks-skills/`
- **`/rd-blog`** - For RequestDesk blog posts (different brand voice)
