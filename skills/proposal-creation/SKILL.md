# Proposal Creation Skill

Generate sales proposals for Content Cucumber service types. Outputs Obsidian markdown to the proposals directory.

## Command Reference

```
/create-proposal [service-type] "Client Name"
/create-proposal blog "Acme Corp"
/create-proposal seo "BigRetail Inc" --referral "ShopTalk"
/create-proposal flywheel "SmallBrand" --skip-discovery
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

Service definitions (discovery questions, deliverables, investment structure, add-ons, process timelines) live in `service-types.md` in this directory.

---

## Workflow

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

1. Read `proposal-template.md` from this directory
2. Read the selected service type definition from `service-types.md`
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

---

### Phase 3: Output

1. Generate the filename: `YYYY-MM-client-slug-service-type.md`
   - `client-slug`: lowercase, hyphens for spaces (e.g., "Acme Corp" becomes "acme-corp")
   - Example: `2026-02-acme-corp-blog.md`

2. Save to: `brent-workspace/ob-notes/Brent Notes/Sales and Marketing/proposals/`
   - Create the `proposals/` directory if it doesn't exist

3. Report to user:
   ```
   ## Proposal Created

   **File:** proposals/YYYY-MM-client-slug-service-type.md
   **Service:** [Service Display Name]
   **Client:** [Client Name]
   **Placeholders to fill:** [N] items marked [NEED: ...] or $X,XXX

   Please review and fill in pricing before sending.
   ```

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
| `--list` | Show all 13 service types with descriptions |
| `--help` | Show command help and stop |

---

## File Dependencies

| File | Purpose |
|------|---------|
| `service-types.md` | All 13 service definitions (in this directory) |
| `proposal-template.md` | Universal proposal template with tokens (in this directory) |

---

## Integration

- **`/brand-cucumber`** - Can be loaded first if full brand persona context is desired, but not required. This skill has its own voice rules above.
- **`/cucumber`** - The main Content Cucumber skill. Proposals are a specialized output, not general content.
