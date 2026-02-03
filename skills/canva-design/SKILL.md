# Canva Design - AI-Driven Design Creation and Management

**Skill Description:** Domain knowledge for creating, managing, and exporting designs through the Canva MCP integration, including brand matching, design type selection, prompt engineering, and export workflows.

## CRITICAL RESOURCES

| Resource | Location |
|----------|----------|
| **Canva MCP Tools** | `mcp__Canva__*` (loaded via ToolSearch) |
| **Brand Kits** | `mcp__Canva__list-brand-kits` |
| **Command** | `.claude-local/commands/canva.md` |
| **Workflows** | `.claude/skills/canva-design/workflows.md` |
| **Prompt Patterns** | `.claude/skills/canva-design/prompt-patterns.md` |

**Authentication:** Handled by Canva MCP. No API keys needed in code.

---

## BRAND KIT MAPPING

Always ask which brand before generating. Use this table to suggest the right one:

| Brand Kit | ID | Use When |
|-----------|----|----------|
| **Content Cucumber** | `kAGk8LegUXI` | Agency content, client workshops, CC branding |
| **Talk Commerce** | `kAGY1AGx07Y` | Podcast episodes, video thumbnails, show assets |
| **RequestDesk** | `kAGxHGjjgl0` | Product marketing, SaaS content, app screenshots |
| **Brent W. Peterson's Team** | `kAGlphqH5E0` | Personal branding, speaking, LinkedIn |
| **EO Minnesota** | `kAGZGBnpNks` | EO chapter events, forum content |
| **EO Visionary Voices** | `kAGu189FGOs` | EO podcast, interview assets |
| **Content Basis** | `kAG38a6Og4M` | Content Basis brand materials |
| **(default)** | `kAGHGlXlbAQ` | Generic, no specific brand |

**Auto-selection hints:**
- Workshop or presentation for CC clients = Content Cucumber
- Podcast thumbnail = Talk Commerce
- Product feature graphic = RequestDesk
- Conference talk = Brent W. Peterson's Team
- If unclear, ask the user

---

## DESIGN TYPE SELECTION

Choose the right `design_type` based on what the user needs:

### Print / Documents
| Type | When to Use | Print Size |
|------|-------------|------------|
| `document` | Printable booklets, handouts, worksheets, 8.5x11 | Fixed page layout |
| `doc` | Web-first collaborative docs, memos, articles | Dynamic/web layout |
| `report` | Visual reports with charts and graphics | Multi-page |
| `proposal` | Visual business proposals | Multi-page |
| `resume` | Professional resumes/CVs | Single page |
| `business_card` | Contact cards | 3.5x2 |
| `postcard` | Mailable cards | Standard postcard |

### Presentations
| Type | When to Use |
|------|-------------|
| `presentation` | Slide decks for presenting (requires detailed Slide Plan format) |

### Social Media
| Type | When to Use | Aspect |
|------|-------------|--------|
| `instagram_post` | Square social content | 1:1 |
| `facebook_post` | Facebook feed content | Landscape |
| `facebook_cover` | Facebook page banner | Wide banner |
| `twitter_post` | X/Twitter content | Landscape |
| `your_story` | Instagram/Facebook Stories | 9:16 vertical |
| `pinterest_pin` | Pinterest content | 2:3 vertical |
| `youtube_thumbnail` | Video thumbnails | 16:9 |
| `youtube_banner` | Channel header | Wide banner |

### Marketing
| Type | When to Use |
|------|-------------|
| `poster` | Large format, events, wall display |
| `flyer` | Single-page promos, handouts |
| `infographic` | Data visualization, long-form vertical |
| `invitation` | Event invitations |
| `logo` | Brand identity marks |

### Visual
| Type | When to Use |
|------|-------------|
| `desktop_wallpaper` | Computer backgrounds |
| `phone_wallpaper` | Mobile backgrounds |
| `photo_collage` | Multi-photo compositions |
| `card` | Greeting cards, holiday cards |

**Common confusion:**
- "Booklet" or "worksheet" = `document` (NOT `doc`)
- "Article" or "memo" = `doc` (NOT `document`)
- "Slides" or "deck" = `presentation`
- "One-pager" = `flyer` or `document` depending on print needs

---

## MCP TOOL WORKFLOW

The correct sequence for creating designs:

### Step 1: Load Tools
```
ToolSearch: "+Canva create design" or "select:mcp__Canva__generate-design"
```
Tools are deferred. Must load before calling.

### Step 2: Check Brand Kit (optional)
```
mcp__Canva__list-brand-kits
```
Show user options, let them pick, or auto-suggest from mapping table.

### Step 3: Generate Design
```
mcp__Canva__generate-design
  - design_type: selected type
  - brand_kit_id: selected brand
  - query: detailed prompt (see prompt-patterns.md)
```
Returns multiple candidates with preview URLs and thumbnails.

### Step 4: User Picks Candidate
Show candidates with thumbnail URLs. Let user preview and select. The candidate with the most thumbnails usually has the most complete pages.

### Step 5: Save to Account
```
mcp__Canva__create-design-from-candidate
  - job_id: from generate response
  - candidate_id: user's pick
```
Returns design_id, edit_url, view_url.

### Step 6: Edit (optional)
```
mcp__Canva__get-design-content  # Read current content
mcp__Canva__start-editing-transaction  # Begin edits
```

### Step 7: Export
```
mcp__Canva__get-export-formats  # Check what's available
mcp__Canva__export-design       # Export with format options
```
Always provide the download URL to the user.

**Key rule:** Generated designs are candidates until saved with `create-design-from-candidate`. The URLs in generate results are previews, not editable designs. The design_id only comes after saving.

---

## EXPORT FORMAT GUIDE

| Need | Format | Settings |
|------|--------|----------|
| **Print (booklet, flyer)** | PDF | `size: "letter"`, `export_quality: "pro"` |
| **Print (international)** | PDF | `size: "a4"`, `export_quality: "pro"` |
| **Social media post** | PNG | Default size, or specify dimensions |
| **Web use** | JPG | `quality: 85` for balance |
| **Editable slides** | PPTX | For sharing with non-Canva users |
| **Animation** | GIF | For animated designs |
| **Video** | MP4 | `quality: "horizontal_1080p"` |
| **High-res print** | PNG | Set width/height to max needed |
| **Transparent background** | PNG | `transparent_background: true` |

---

## When Claude Should Apply This Skill

Apply this skill automatically when the user:
- Asks to create any visual design (booklet, flyer, social post, presentation)
- Mentions "Canva" in any context
- Wants to export a design to PDF, PNG, or other format
- Asks for a "graphic", "visual", "poster", "handout", or "worksheet"
- Wants to create branded content for any of the listed brands
- References "brand kit" or "on-brand"
- Asks to search for or find existing Canva designs
- Wants to create print materials

**Keywords that should trigger this skill:**
- canva, design, graphic, visual, booklet, flyer, poster
- social post, instagram, thumbnail, banner
- brand kit, on-brand, branded
- export, PDF, print, handout, worksheet

---

## Core Principles

1. **Always ask about brand** - Never generate without confirming which brand kit to use
2. **Pick the right type** - `document` for print, `doc` for web, `presentation` for slides
3. **Detailed prompts win** - More detail in the query = better results from Canva AI
4. **Show candidates** - Let the user pick from generated options
5. **Provide download URLs** - Always surface the export link so users can grab their files

---

## Supporting Files

- `workflows.md` - Step-by-step workflows for common design tasks
- `prompt-patterns.md` - Reusable prompt templates for each design type

---

## Integration with Commands

- `/canva` - Main command for explicit design creation, search, and export
- `/create-social` - Social post creation may trigger Canva for graphics
- `/twc-start` - Article creation may need header images
