# Canva Design - Prompt Patterns

Reusable prompt templates for `mcp__Canva__generate-design`. The quality of the generated design depends heavily on prompt detail. These patterns encode what Canva's AI expects for each design type.

---

## General Principles

1. **Be specific about page count** - State exactly how many pages/slides
2. **Describe content per page** - Don't summarize, list every page with its content
3. **Specify visual style** - Color palette, mood, layout preferences
4. **Include text verbatim** - Write the exact text you want on the design
5. **State the purpose** - Who is this for, how will it be used
6. **Mention print vs digital** - Affects layout, margins, and readability

---

## Document / Booklet Pattern

Use with `design_type: "document"`

```
Create a printable 8.5x11 [DOCUMENT TYPE] for "[TITLE]" by [ORGANIZATION].
Use a [STYLE DESCRIPTION] design with [COLOR 1] and [COLOR 2] color palette.
This is a [PURPOSE: hands-on workbook / reference guide / handout] for [AUDIENCE].

The [document type] should have [N] pages total:

PAGE 1 - COVER PAGE:
Title: "[Main Title]"
Subtitle: "[Subtitle]"
[Additional cover elements: author, organization, date, logo placement]
Use a [decorative/minimal/bold] layout.

PAGE 2 - [PAGE TYPE: Table of Contents / Introduction / Overview]:
Section header: "[Header Text]"
Title: "[Page Title]"
[Content description - bullet lists, numbered items, paragraphs]
[Note any special elements: tip boxes, callout boxes, dividers]

PAGE 3 - WORKSHEET:
Title: "[Worksheet Title]"
Subtitle: "[Instruction text]"
Create a grid of [N] fill-in boxes with blank lines for writing:
[Describe layout: 2x2 grid, 3 columns, etc.]
[List each box label and how many lines]
[Note any helper text or hints within boxes]

[Continue for all pages with the same level of detail...]

PAGE [N] - NOTES PAGE:
Title: "Notes"
Full page of blank lined writing space.

Footer on all pages: "[Footer text]"
```

**Tips for documents:**
- Describe worksheet boxes explicitly (label, hint text, number of lines)
- Specify grid layouts (2x2, 3 columns, etc.)
- Include tip/callout boxes with their exact text
- State whether pages should have headers/footers

---

## Presentation Pattern

Use with `design_type: "presentation"`

The generate-design tool has VERY specific requirements for presentations. Follow this exact format:

```
**Presentation Brief**

* **Title:** [Working title]
* **Topic / Scope:** [1-2 lines describing the subject]
* **Key Messages:**
  1. [Takeaway 1]
  2. [Takeaway 2]
  3. [Takeaway 3]
* **Constraints & Assumptions:** [Brand, audience, time limit, etc.]
* **Style Guide:** [Tone, color palette, typography, imagery style]

**Narrative Arc**

[One paragraph describing the story flow. Example: "Hook with a surprising stat, then present the problem, walk through the solution framework, show proof points, end with actionable next steps."]

**Slide Plan**

**Slide 1 - "[Exact Title]"**
* **Goal:** [One sentence purpose]
* **Bullets (3-6):**
  - [Bullet 1 with specific facts/examples]
  - [Bullet 2]
  - [Bullet 3]
* **Visuals:** [Specific recommendation: "Full-bleed photo of...", "Bar chart showing...", "2x2 matrix of..."]
* **Speaker Notes:** [2-4 sentences of narrative]
* **Transition:** [One sentence leading to next slide]

**Slide 2 - "[Exact Title]"**
[Same structure...]

[Continue for all slides...]
```

**Presentation quality checklist:**
- Titles must be unique, under 65 characters, action-oriented
- Each slide has 3-6 bullets, no paragraph walls
- Visuals are concrete (chart names + variables, not just "add a graphic")
- No placeholders like "[TBD]" - use realistic example figures if needed
- Transitions form an intelligible narrative

---

## Social Media Post Pattern

Use with platform-specific `design_type`

```
Create a [PLATFORM] post for [BRAND/ORGANIZATION].
Topic: [What the post is about]
Tone: [Professional / casual / bold / inspiring]

Main text on image: "[HEADLINE TEXT]"
Supporting text: "[SUBTEXT if any]"

Visual style:
- [Background: solid color / gradient / photo / pattern]
- [Key visual element: product photo, icon, illustration]
- [Brand elements: logo placement, brand colors]

Call to action: "[CTA TEXT if any]"
```

**Platform-specific notes:**
- **Instagram:** Bold, visual-first. Less text on image. Use hashtag-friendly captions separately.
- **Facebook:** Can include more text. Consider engagement-driving questions.
- **Twitter/X:** Keep text minimal on image. Sharp, quotable.
- **Pinterest:** Vertical format. Text overlay should be readable at small sizes.
- **YouTube thumbnail:** High contrast, face close-ups work well, max 3-5 words.
- **Stories:** Full-screen vertical. Interactive elements (polls, questions) can't be designed in Canva.

---

## Infographic Pattern

Use with `design_type: "infographic"`

```
Create an infographic about "[TOPIC]" for [BRAND].
Purpose: [Educate / compare / show process / visualize data]
Color palette: [Colors]
Style: [Modern / flat / illustrated / data-heavy]

Sections (top to bottom):

HEADER:
Title: "[Infographic Title]"
Subtitle: "[Context line]"

SECTION 1: [Section Name]
[Data point or concept to visualize]
[Specific numbers, stats, or comparisons]
Visual: [Chart type, icon set, illustration style]

SECTION 2: [Section Name]
[Content...]

[Continue sections...]

FOOTER:
Source: [Attribution]
Brand: [Logo/URL placement]
```

---

## Flyer / Poster Pattern

Use with `design_type: "flyer"` or `"poster"`

```
Create a [flyer/poster] for "[EVENT/PROMOTION]" by [BRAND].
Size: [Standard flyer / large poster]
Purpose: [Event promotion / product launch / announcement]

Layout:
- Headline: "[MAIN HEADLINE]"
- Subheadline: "[SUPPORTING TEXT]"
- Key details:
  - [Date/time if event]
  - [Location if event]
  - [Price/offer if promotion]
  - [Contact info / URL / QR code placeholder]

Visual style:
- [Background treatment]
- [Key imagery]
- [Color palette]
- [Overall mood: energetic / elegant / playful / professional]

Call to action: "[CTA]"
```

---

## Logo Pattern

Use with `design_type: "logo"`

```
Create a logo for "[BRAND NAME]".
Industry: [What the brand does]
Style: [Minimal / bold / playful / corporate / vintage]
Must include: [Text, icon, both]

Preferences:
- Colors: [Specific colors or "suggest based on industry"]
- Font style: [Sans-serif / serif / script / modern]
- Icon concept: [Description of symbol/icon idea, or "suggest"]
- Avoid: [Anything to stay away from]

Usage context: [Web, print, both. Light backgrounds, dark backgrounds, both.]
```

---

## Multi-Design Campaigns

When creating a set of related designs across platforms:

1. Start with the primary piece (usually the most content-rich one)
2. Save it to account
3. Generate derivative pieces referencing the primary design's style
4. In each derivative prompt, include: "Match the style of the [primary piece] already created. Use the same color palette, typography, and visual language."

**Example campaign set:**
- Blog header image (landscape)
- Instagram post (square)
- Instagram story (vertical)
- LinkedIn post (landscape)
- Email header (wide banner)

Generate each separately but reference the shared visual language.
