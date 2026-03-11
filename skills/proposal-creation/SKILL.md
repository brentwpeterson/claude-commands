# Proposal Creation Skill

Generate sales proposals for Content Cucumber service types. Outputs Obsidian markdown or branded HTML to the proposals directory. Optionally imports discovery data from Fireflies meeting transcripts.

## Command Reference

```
/create-proposal [service-type] "Client Name"
/create-proposal blog "Acme Corp"
/create-proposal seo "BigRetail Inc" --referral "ShopTalk"
/create-proposal flywheel "SmallBrand" --skip-discovery
/create-proposal --from-meeting                          # Import from Fireflies transcript
/create-proposal blog "Acme Corp" --html                 # Output branded HTML
/create-proposal --from-meeting --html                   # Combine both
/create-proposal custom "Client Name"                    # Flexible custom proposal
/create-proposal --list
/create-proposal --help
```

---

## Service Registry

| Shortcode | Service | Category |
|-----------|---------|----------|
| `blog` | Blog Writing | Content Creation |
| `seo` | SEO Content | Content Creation |
| `website-copy` | Website Copy | Content Creation |
| `email` | Email Marketing | Content Creation |
| `social` | Social Media Content | Content Creation |
| `aeo` | AEO Optimization | Content Creation |
| `content-commerce` | Content in Commerce (bundle) | Commerce |
| `product-desc` | Product Descriptions | Commerce |
| `category-pages` | Category Pages | Commerce |
| `marketing-mgmt` | Marketing Management | Management |
| `flywheel` | Content Flywheel Plan | Strategy |
| `llm-discovery` | Commerce LLM Discovery | Commerce |
| `video` | Video Production | Production |
| `paid-media` | Paid Advertising Management | Advertising |
| `brand-strategy` | Brand Strategy / Identity | Brand & Design |
| `design` | Graphic Design | Brand & Design |
| `cro` | Conversion Rate Optimization | Conversion |
| `marketing-auto` | Marketing Automation | Automation |
| `sales-content` | Sales Enablement Content | Content Creation |
| `competitive-intel` | Competitive Intelligence | Analytics |
| `webinar` | Webinar Production | Production |
| `cms-implementation` | CMS Implementation | Web Development |
| `wp-turnkey` | WordPress Turnkey Site | Web Development |
| `wp-maintenance` | WordPress Maintenance | Web Development |
| `custom-integration` | Custom Integrations | Technology |
| `mcp-creation` | MCP Server Creation | Technology |
| `custom` | Custom / Pilot Proposal | Custom |

Service definitions (discovery questions, deliverables, investment structure, add-ons, process timelines) live in `service-types.md` in this directory. The `custom` type has no predefined structure. It generates a narrative proposal tailored to whatever the client needs (useful for pilot programs, hybrid engagements, or anything that doesn't fit a standard service type).

---

## Workflow

### Phase 0: Meeting Transcript Import (optional)

**Triggered by `--from-meeting` flag.** Replaces manual discovery by extracting proposal details from a Fireflies meeting transcript.

**Skip this phase entirely if `--from-meeting` is not set.**

**Steps:**

1. **List recent meetings.** Call `fireflies_list_transcripts` (limit 10). Present a numbered table:

   ```
   #  | Date       | Title                              | Participants
   ---|------------|------------------------------------|--------------
   1  | 2026-03-01 | Sales Call - EasiHair Pro           | Brent, Sarah
   2  | 2026-02-28 | Content Strategy - BigRetail        | Brent, Mike
   ...
   ```

2. **User picks a meeting.** Ask: "Which meeting should I pull from? (enter number)"

3. **Fetch transcript and summary.** Call `fireflies_get_transcript` and `fireflies_get_summary` in parallel for the selected meeting.

4. **Extract proposal data.** Parse the transcript and summary for:
   - **Client company name** and contact names/emails
   - **Service requirements** (what they need from us)
   - **Current situation** (platform, existing content, pain points)
   - **Timeline/urgency** mentioned
   - **Budget or pricing** discussed
   - **Concerns or objections** raised
   - **Action items and next steps**

5. **Present extracted data for confirmation.** Show the extracted details in a summary block and ask the user to confirm or correct anything.

6. **Determine service type.** If a service type was provided on the command line, use it. Otherwise:
   - Suggest a service type (or `custom`) based on what was discussed
   - Ask user to confirm or select a different one

7. **Feed into Phase 2.** The extracted data replaces discovery answers. Pass them directly into generation as pre-populated discovery context. Skip Phase 1 entirely.

**Custom/pilot proposals:** When `--from-meeting` is used with `custom` type (or when the transcript doesn't fit a standard service), generate a narrative proposal structure instead of the table-driven template. The narrative should follow the conversation flow: what the client needs, what we'll do, the pilot structure, deliverables, and investment, all derived from the actual meeting discussion.

---

### Phase 1: Discovery

Run discovery UNLESS `--skip-discovery` is passed.

**5 Universal Questions (ask all):**

1. Tell me about your business. What do you sell and who buys it?
2. What problem are you trying to solve with this service? What's not working today?
3. What content or marketing do you have in place right now?
4. What's your timeline? Is there a launch date, season, or event driving this?
5. Are there any constraints I should know about? (budget range, brand guidelines, platform requirements)

**Service-Specific Questions:**

After the universal questions, ask the 2-3 service-specific questions defined in `service-types.md` for the selected service type.

**Collect all answers before moving to Phase 2.**

**If `--skip-discovery` is set:**
- Skip all questions
- Generate the proposal with `[NEED: ...]` placeholders wherever discovery answers would have been used
- Report the placeholder count at the end

---

### Phase 2: Generation

1. Read the appropriate template from this directory:
   - **Default (markdown):** `proposal-template.md`
   - **If `--html` flag is set:** `proposal-template.html`
2. Read the selected service type definition from `service-types.md` (skip for `custom` type)
3. Fill the template:
   - Replace `{{SERVICE_NAME}}` with the service display name
   - Replace `{{CLIENT_NAME}}` with the client name argument
   - Replace `{{DATE}}` with today's date (Month DD, YYYY format)
   - Replace `{{REFERRAL}}` with the `--referral` value (or remove the line if not provided)
   - Fill the Overview section using discovery answers (or `[NEED: client overview]` if skipped)
   - Insert the Deliverables table from the service type definition
   - Insert the Investment table from the service type definition (all pricing uses `$X,XXX` placeholders)
   - Insert the Add-Ons table from the service type definition
   - Insert the "What We Need From You" list from the service type definition, customized with discovery answers
   - Insert the Equipment section ONLY for `video` type
   - Insert the Process timeline from the service type definition
   - Insert the Terms section matching the service type's billing model
   - Insert the shared About Content Cucumber section
   - Insert the shared Next Steps section
   - Insert the shared Validity line

**Pricing Rule:** NEVER fabricate prices. Every dollar amount uses `$X,XXX` format as a placeholder for Brent to fill in. The only exceptions are verified stats (60K+ projects, 55M+ words) in the About section.

**HTML-specific generation rules (when `--html` is set):**

- Use `proposal-template.html` instead of `proposal-template.md`
- Replace `{{REFERRAL_HTML}}` with `<div class="referral">Referred by: NAME</div>` or empty string if no referral
- Replace `{{OVERVIEW}}` with `<p>` wrapped paragraphs
- Replace `{{DELIVERABLES_TABLE}}`, `{{INVESTMENT_TABLE}}`, `{{ADDONS_TABLE}}`, `{{PROCESS_TABLE}}` with proper `<table>` HTML (use `<thead>`, `<tbody>`, `<tr>`, `<th>`, `<td>`)
- For `{{INVESTMENT_TABLE}}`, add class `investment-table` to the `<table>` element
- Replace `{{WHAT_WE_NEED_ITEMS}}` with `<li>` items (the `<ol>` wrapper is already in the template)
- Replace `{{TERMS_ITEMS}}` with `<li>` items (the `<ul>` wrapper is already in the template)
- Replace `{{EQUIPMENT_SECTION}}` with the full equipment section div (matching surrounding section styles) for video type, or empty string for all others

**Custom type generation rules (when service type is `custom`):**

- No predefined deliverables, investment, or add-ons tables from `service-types.md`
- Build the proposal structure from discovery answers or meeting transcript data
- Create deliverables, investment, and timeline tables based on what was actually discussed
- The Overview section should tell the client's story and how we'll help
- This is the most flexible mode. The proposal should feel tailored, not templated

---

### Phase 3: Output

1. Generate the filename:
   - **Markdown (default):** `YYYY-MM-client-slug-service-type.md`
   - **HTML (`--html`):** `YYYY-MM-client-slug-service-type.html`
   - `client-slug`: lowercase, hyphens for spaces (e.g., "Acme Corp" becomes "acme-corp")
   - Examples: `2026-02-acme-corp-blog.md`, `2026-03-easihair-pro-custom.html`

2. Save to: `brent-workspace/ob-notes/Brent Notes/Sales and Marketing/proposals/`
   - Create the `proposals/` directory if it doesn't exist

3. Report to user:
   ```
   ## Proposal Ready for Review

   **File:** proposals/YYYY-MM-client-slug-service-type.[md|html]
   **Format:** [Markdown|HTML]
   **Service:** [Service Display Name]
   **Client:** [Client Name]
   **Source:** [Discovery|Meeting transcript: "Meeting Title"|Skipped (placeholders)]
   **Placeholders to fill:** [N] items marked [NEED: ...] or $X,XXX

   Please review and fill in pricing before sending.
   ```

   For HTML output, add: `Open the HTML file in a browser to preview. Print to PDF for a polished document.`

---

## Brand Voice Rules

These apply to ALL proposal content. No exceptions.

### Content Cucumber writes like:
- A helpful expert friend, not a salesperson
- Confident but not arrogant
- Clear and direct, not fluffy
- Practical with real examples
- Warm and approachable

### Never use:
- Em dashes (use periods, commas, or parentheses instead)
- Emojis (unless explicitly requested)
- "Unlock your potential"
- "Take it to the next level"
- "Game-changer"
- "Synergy"
- "Delve"
- "Revolutionary"
- Excessive exclamation points
- Empty superlatives

### Proposal-specific tone:
- Professional but human
- Focus on what the client gets, not what Content Cucumber does
- Specific and concrete, not vague
- Short paragraphs, scannable tables
- Let the structure do the selling

---

## Company Details (verified, safe to use)

- **Company name:** Content Cucumber (proposals use "Content Cucumber" or "Content Basis" depending on context, ask if unclear)
- **Contact:** Brent Peterson, brent@contentbasis.io
- **Stats:** 60K+ projects completed, 55M+ words written
- **These stats are verified.** Do not fabricate additional stats.

---

## Flags

| Flag | Effect |
|------|--------|
| `--referral "Name"` | Adds "Referred by: Name" to header |
| `--skip-discovery` | Skip discovery questions, use `[NEED: ...]` placeholders |
| `--from-meeting` | Import discovery data from a Fireflies meeting transcript (Phase 0) |
| `--html` | Output branded HTML instead of markdown (uses `proposal-template.html`) |
| `--list` | Show all service types with descriptions |
| `--help` | Show command help and stop |

**Flag combinations:**
- `--from-meeting --html` - Import from transcript AND output HTML
- `--from-meeting` without a service type - Will auto-suggest based on transcript
- `--from-meeting --skip-discovery` - Invalid (from-meeting replaces discovery, skip-discovery skips it. Use one or the other)

---

## File Dependencies

| File | Purpose |
|------|---------|
| `service-types.md` | All 27 service definitions (in this directory) |
| `proposal-template.md` | Markdown proposal template with tokens (in this directory) |
| `proposal-template.html` | HTML proposal template with CC branding and tokens (in this directory) |

---

## Integration

- **`/brand-cucumber`** - Can be loaded first if full brand persona context is desired, but not required. This skill has its own voice rules above.
- **`/cucumber`** - The main Content Cucumber skill. Proposals are a specialized output, not general content.
