# Canva Design - Workflows

## Print Booklet / Worksheet

**When to use:** User needs a printable document (8.5x11 or A4) like a workshop booklet, handout, workbook, or worksheet.

**Steps:**
1. Clarify content (what pages, what sections, fill-in areas vs reference content)
2. Ask for brand kit (suggest based on context)
3. Generate with `design_type: "document"` and detailed page-by-page prompt
4. Show candidates, let user pick (prefer the one with the most page thumbnails)
5. Save with `create-design-from-candidate`
6. Export as PDF: `format: { type: "pdf", size: "letter", export_quality: "pro" }`
7. Provide download URL and edit link

**Key details:**
- Use `document` type (NOT `doc`). Documents have fixed page layouts for print.
- `doc` is for web-first collaborative docs and will NOT print well.
- Always export at `pro` quality for print.
- For US print: `size: "letter"`. For international: `size: "a4"`.

**Example prompt structure:**
```
Create a printable 8.5x11 [DOCUMENT TYPE] for "[TITLE]" by [BRAND].
Use a clean, professional design with [COLOR SCHEME].

The [document] should have [N] pages total:

PAGE 1 - [PAGE TYPE]:
[Detailed content for page 1]

PAGE 2 - [PAGE TYPE]:
[Detailed content for page 2]

[Continue for all pages...]
```

---

## Social Media Graphic

**When to use:** User needs a graphic for Instagram, Facebook, Twitter/X, Pinterest, YouTube, or Stories.

**Steps:**
1. Ask which platform(s)
2. Ask for brand kit
3. Generate with platform-specific `design_type`
4. Show candidates
5. Save and export as PNG (default) or JPG

**Platform-specific types:**

| Platform | Type | Notes |
|----------|------|-------|
| Instagram feed | `instagram_post` | Square 1:1 |
| Instagram/FB Story | `your_story` | Vertical 9:16 |
| Facebook feed | `facebook_post` | Landscape |
| Facebook banner | `facebook_cover` | Wide |
| Twitter/X | `twitter_post` | Landscape |
| Pinterest | `pinterest_pin` | Vertical 2:3 |
| YouTube thumbnail | `youtube_thumbnail` | 16:9 |
| YouTube banner | `youtube_banner` | Wide |
| LinkedIn | `facebook_post` | No dedicated type, use facebook_post |

**Export settings:**
- Social posts: PNG at default size
- If user needs specific dimensions: set `width` and `height` in export
- For transparent backgrounds: `transparent_background: true`

---

## Presentation / Slide Deck

**When to use:** User needs a slide deck for presenting.

**Steps:**
1. Gather presentation details (topic, audience, key messages, slide count)
2. Ask for brand kit
3. Build the detailed prompt using the Presentation format (see prompt-patterns.md)
4. Generate with `design_type: "presentation"`
5. Show candidates
6. Save to account
7. Export as PPTX (if sharing) or PDF (if presenting)

**Critical:** The Canva generate-design tool requires a very specific format for presentations. See `prompt-patterns.md` for the exact structure including Presentation Brief, Narrative Arc, and Slide Plan sections.

**Export options:**
- PPTX: For sharing with people who need to edit
- PDF: For static presentation or handout
- PNG: For individual slide images (specify pages)

---

## Marketing Collateral

**When to use:** User needs flyers, posters, business cards, or other marketing materials.

**Steps:**
1. Clarify what they need (flyer, poster, business card, etc.)
2. Ask for brand kit
3. Generate with appropriate type
4. Show candidates, save, export

**Type selection:**
| Need | Type | Notes |
|------|------|-------|
| Event handout | `flyer` | Single page, both sides |
| Wall/display | `poster` | Large format |
| Contact info | `business_card` | Standard 3.5x2 |
| Event invite | `invitation` | Various sizes |
| Data viz | `infographic` | Long vertical format |
| Mailable | `postcard` | Standard postcard size |

---

## Export and Deliver

**When to use:** User has an existing design and needs it exported.

**Steps:**
1. Get design ID (from search, URL, or previous creation)
2. Check available formats: `mcp__Canva__get-export-formats`
3. Ask user what format they need
4. Export with appropriate settings
5. Provide download URL

**Format decision guide:**

| User says... | Format | Settings |
|-------------|--------|----------|
| "PDF" or "print" | pdf | `size: "letter"` or `"a4"`, `export_quality: "pro"` |
| "image" or "PNG" | png | Default or specify width/height |
| "JPG" or "web" | jpg | `quality: 85` |
| "PowerPoint" or "editable slides" | pptx | Default |
| "GIF" or "animated" | gif | Default |
| "video" or "MP4" | mp4 | `quality: "horizontal_1080p"` |
| "transparent" | png | `transparent_background: true` |
| Specific pages only | any | `pages: [1, 3, 5]` (1-based) |

---

## Search Existing Designs

**When to use:** User wants to find a design they already have in Canva.

**Steps:**
1. Get search query from user
2. Call `mcp__Canva__search-designs` with query and `sort_by: "relevance"`
3. Show results with titles and thumbnails
4. If user wants details: `mcp__Canva__get-design`
5. If user wants to edit: provide edit URL
6. If user wants to export: follow Export workflow

**Important:** `search-designs` only finds existing designs. For templates, use `search-brand-templates` instead.

---

## Browse Folders

**When to use:** User wants to see what's in a specific Canva folder.

**Steps:**
1. Call `mcp__Canva__search-folders` if user knows folder name
2. Call `mcp__Canva__list-folder-items` with folder ID
3. Show contents with titles and types

---

## Edit Existing Design

**When to use:** User wants to modify text or content in an existing design.

**Steps:**
1. Get design ID
2. Read current content: `mcp__Canva__get-design-content` with `content_types: ["richtexts"]`
3. If edits needed: use `start-editing-transaction` to begin edits
4. Make changes through editing tools
5. Export updated design if needed
