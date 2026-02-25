# Landing Page Management

**USAGE:**
```
/landing                    Interactive: ask what user wants to do
/landing list               Show all landing pages with section orders + variants
/landing sections           Show all available section types and variants
/landing new                Guided creation of a new landing page
/landing add <slug>         Add a section to an existing page
/landing audit <slug>       Audit visual rhythm, variant usage, and completeness
/landing feedback <slug>    Record user feedback on a page's visual presentation
/landing --help             Show this help
```

## SKILL REFERENCE

**ALWAYS load BOTH files first:**
1. `.claude/skills/landing-pages/SKILL.md` - section types, data shapes, visual rhythm rules
2. `.claude/skills/landing-pages/registry.md` - usage counts, variant caps, user feedback

**The registry is the source of truth for what's been used and what the user thinks about it.**

## THEME PATH

All landing page files live in:
`/Users/brent/LocalSites/contentcucumber/app/public/wp-content/themes/cucumber-gp-child/`

- JSON files: `landing-data/{slug}.json`
- PHP template: `page-landing-json.php`
- CSS: `style.css`

## SUBCOMMAND: (no args) - Interactive

When user runs `/landing` with no arguments:

1. Read the skill file
2. Ask the user:
   - "What do you want to do?" (Options: Create a new landing page, Modify an existing page, Audit a page, View available sections)
3. Route to the appropriate subcommand flow

## SUBCOMMAND: list

1. Read all JSON files in `landing-data/`
2. Read the registry for usage counts
3. For each file, extract section order WITH variants (show variant if not default)
4. Display a table:

```
Landing Pages:
| Page                   | Sections (variant if non-default)                                |
|------------------------|------------------------------------------------------------------|
| agency-white-label     | hero > proof-bar > challenges > services > how-it-works > ...   |
| growth-marketing       | hero > proof-bar > challenges:alternating > shift > bundles > ...|
```

5. Show overused combos: "WARNING: challenges:default used on 5/4 pages (OVER CAP)"

## SUBCOMMAND: sections

1. Read the skill file
2. Display a summary table of all available section types with:
   - Type name
   - Background color
   - One-line description
   - Available in landing pages? (yes/no/phase 2)

## SUBCOMMAND: new

**This is the guided creation flow. Ask questions to build the page.**

### Step 1: Discovery
Ask the user these questions (use AskUserQuestion):

1. **"What is this landing page for?"**
   - Options: Service offering, Campaign/promotion, Partner/integration, Event, Other

2. **"Who is the target audience?"**
   - Options: Agency decision-makers, Marketing managers, Ecommerce brands, Technical teams, Other

3. **"What's the page slug?"** (free text)
   - This becomes the filename and URL

### Step 2: Registry Check (MANDATORY)
Before recommending anything, read the registry and identify:
- Which section:variant combos are at or over the cap of 4
- Any user feedback on existing pages
- Show the user: "These layouts are overused and I'll avoid them: [list]"

### Step 3: Section Selection + Variant Assignment
Based on discovery answers AND registry data, recommend a section order WITH specific variants.

**Archetype templates** (starting points, not rigid):

| Archetype | Middle sections | Best for |
|---|---|---|
| **Service** | challenges > services > how-it-works > bundles > outcomes > credibility | Selling a service |
| **Authority** | challenges > video-embed > credibility > outcomes | Thought leadership |
| **Partner** | challenges > services > how-it-works > ecosystem > bundles | Attracting partners |
| **Campaign** | challenges > shift > bundles > outcomes > credibility | Time-bound promotions |
| **Product** | challenges > services > video-embed > bundles > outcomes | Tool/platform focus |

**For each section, assign a variant:**
- Check the registry count for `section:default`
- If at or over cap (4), MUST choose an alternate variant
- If under cap, default is fine but prefer variety
- Show the user your choices with reasoning

Example output:
```
Recommended layout for "seo-services" (Service archetype):
  1. hero (default - 5 uses, but centered variant available. Use centered?)
  2. proof-bar (exempt)
  3. challenges:alternating (default is at 5/4 cap, using alternating instead)
  4. services (default - only 1 use, safe)
  5. how-it-works (default - only 2 uses, safe)
  6. bundles (default is at 5/4 cap - need variant. Only default implemented. Flag for CSS work.)
  7. outcomes (default is at 5/4 cap - need variant. Only default implemented. Flag for CSS work.)
  8. credibility (default at 4/4 cap, using stats-bar variant)
  9. faq (exempt)
  10. bottom-cta (exempt)
```

Ask: "Here's my recommended layout. Sections marked with warnings need new CSS variants or your approval to reuse. What do you think?"

### Step 3: Content Gathering
For each section in the approved order, ask the user for the content. Work through them one at a time:

- **hero:** "What's the page headline? What's the eyebrow text? Write 1-2 paragraphs describing the offering. Will this page have a HubSpot form or a hero image?"
- **proof-bar:** "What 3-4 proof points should appear? (e.g., '40+ Human Writers', 'HubSpot Partner')"
- **challenges:** "What 3-4 pain points does the audience face? Give me a title and description for each."
- **services:** "What 3 services/features should be highlighted? Title, description, and icon for each."
- **how-it-works:** "What are the 3-4 steps in the process?"
- **shift:** "What's the 'old way' vs 'new way' comparison?"
- **bundles:** "What service tiers or packages do you offer? Which one is featured?"
- **outcomes:** "What 4 results/benefits does the customer get?"
- **credibility:** "What stats and narrative build trust? (years experience, team size, etc.)"
- **video-embed:** "What's the YouTube video ID? Any side content?"
- **faq:** "What 5-8 questions does this audience commonly ask?"
- **ecosystem:** "Which brands should appear in the ecosystem section?"
- **bottom-cta:** "What's the final CTA headline and supporting text?"

**Content rules (from CLAUDE.md):**
- NEVER fabricate quotes, stats, or testimonials
- If user doesn't have content for a section, use `[NEED: description of what's needed]` placeholders
- Follow Brent's writing style: no em dashes, no emojis

### Step 4: Build
1. Assemble the JSON file from gathered content
2. Validate visual rhythm (no stacked same-background sections)
3. Write to `landing-data/{slug}.json`
4. Validate JSON syntax
5. Remind user they need to create a WordPress page with matching slug and "Landing Page - JSON" template

### Step 5: Form Setup
If the page needs a HubSpot form, ask:
- "What HubSpot form ID should this page use? Or should we reuse an existing one?"
- Show the user existing form configs from other JSON files as reference

## SUBCOMMAND: add <slug>

1. Read the existing JSON file for `<slug>`
2. Show current section order
3. Ask: "What section type do you want to add?" (show available types)
4. Ask: "Where should it go?" (show position options: after challenges, before faq, etc.)
5. Check visual rhythm with the new section inserted
6. If rhythm violation: warn and suggest alternative position
7. Gather content for the new section (same questions as `new` flow)
8. Insert into JSON and save

## SUBCOMMAND: audit <slug>

1. Read the JSON file for `<slug>`
2. Read the registry
3. Check:
   - **Visual rhythm:** No two adjacent sections with same background color
   - **Required bookends:** Starts with hero, ends with bottom-cta
   - **proof-bar position:** Should be right after hero
   - **Missing fields:** Required fields present in each section
   - **Icon references:** All icon names exist in `$icons` or `$service_icons`
   - **Form config:** If hero or bottom-cta expects a form, is `form` config present?
   - **Link targets:** Any internal links use relative URLs (no hardcoded domains)
   - **Variant staleness:** For each section, check if its section:variant combo is at or over cap in the registry. Flag overused layouts.
   - **Similarity check:** Compare this page's section order against all other pages. Flag if the middle sections (between proof-bar and faq) match another page's order exactly or nearly exactly.
4. Report findings with pass/warn/fail for each check

## SUBCOMMAND: feedback <slug>

Record user feedback on a page's visual presentation. This feedback persists in the registry and future sessions MUST read it before creating or modifying pages.

1. Read the registry
2. Ask the user:
   - "What's the feedback on this page?" (free text)
   - "Are there specific sections that need to change?" (optional, multi-select from the page's sections)
3. Append to the Feedback Log table in `registry.md`:
   ```
   | 2026-02-24 | agency-white-label | challenges:default feels stale, need alternating variant |
   ```
4. If user flags a specific section:variant as overused, check the registry count and confirm it's over cap
5. Suggest concrete next steps: "The challenges:default is at 5/4 cap. I can switch this page to challenges:alternating right now. Want me to?"

## REGISTRY UPDATE RULE

**After ANY change to a landing page JSON (new page, add section, change variant), update the registry:**
1. Re-count all section:variant combos across all JSON files
2. Update the Usage Tally table
3. Update the "Used on" column in the Available Variants tables
4. If a new variant was implemented (PHP + CSS), add it to the Implemented Variants list in SKILL.md

## VISUAL RHYTHM REFERENCE

| Background | Color | Section types |
|---|---|---|
| Dark | #1a1a2e | hero, proof-bar, how-it-works, credibility |
| White | #ffffff | challenges, bundles, video-embed, faq |
| Light gray | #f9fafb | services, shift, outcomes, ecosystem |
| Green gradient | | bottom-cta |

**Rule:** Never place two sections with the same background color adjacent to each other.
