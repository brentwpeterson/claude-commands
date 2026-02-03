# HubSpot Workflow - Brent's CRM Rules

**Skill Description:** Rules and workflows for managing HubSpot sequences, tasks, and contacts. These rules ensure consistency and traceability across all HubSpot automation.

---

## SEQUENCE RULES

### Rule 1: Sequence Code in Manual Tasks

**When creating a new sequence, ALL manual task subjects MUST include the sequence code.**

**Why:** Generic tasks like "Send follow-up email" don't tell you which sequence triggered them. When you have 5+ sequences running, you need to know the context.

**Format:**
```
[SEQUENCE-CODE]: [Task Description]
```

**Examples:**
- `SEQ-SHOPIFY-DEMO-001: Send follow-up email`
- `SEQ-SHOPIFY-DEMO-001: Contact opened email - send personalized message`
- `SEQ-HUBSPOT-SERVICES-001: Call to follow up on demo request`

**Task body should include:**
- Contact name and company
- Which email they interacted with (if applicable)
- Link to the sequence template doc (Obsidian)

**Example task body:**
```
Richard from Utu Sun opened Email 2 in SEQ-SHOPIFY-DEMO-001.

Sequence doc: obsidian://open?vault=Brent%20Notes&file=HubSpot%2Ftemplates%2Femail-sequences%2FSEQ-SHOPIFY-DEMO-001

Send a personalized follow-up referencing the "3-4 hour problem" email.
```

---

## LEARNING MOMENT: Why Sequence Codes Matter (Jan 20, 2026)

**The Problem:**

We had 5 overdue "Send follow-up email" tasks. The task bodies said things like:
```
Richard from Utu Sun opened their email! Send a personalized message
```

**What went wrong:**
1. No sequence code - we didn't know if it was SEQ-SHOPIFY-DEMO-001 or SEQ-TRE-001
2. No email number - we didn't know which email they opened
3. No context - we didn't know what message resonated with them

**The detective work required:**
1. Search for the contact in HubSpot
2. Check their activity data
3. Discover they're in a DIFFERENT sequence than expected
4. Realize the sequence (TRE) wasn't even documented
5. Document the entire 5-email sequence from scratch
6. STILL don't know which email they opened

**Time wasted:** 20+ minutes per contact instead of 2 minutes

**The Fix:**

BEFORE (bad):
```
Subject: Send follow-up email
Body: Richard from Utu Sun opened their email! Send a personalized message
```

AFTER (good):
```
Subject: SEQ-TRE-001: Richard from Utu Sun opened Email 3
Body: Contact opened "Running Commerce episodes start recording this month" email.

Sequence doc: obsidian://open?vault=Brent%20Notes&file=HubSpot%2Ftemplates%2Femail-sequences%2FSEQ-TRE-001

Follow up referencing the recording timeline / urgency angle.
```

**With proper coding:**
- Instantly know the sequence
- Instantly know which email resonated
- Link to the sequence doc for context
- Know exactly what angle to use in follow-up

**Rule:** Every manual task in a sequence MUST include the sequence code and email number.

---

## SEQUENCE NAMING CONVENTION

**Format:** `SEQ-[TARGET]-[TYPE]-[NUMBER]`

| Component | Description | Examples |
|-----------|-------------|----------|
| SEQ | Prefix (always) | SEQ |
| TARGET | Who it's for | SHOPIFY, MAGENTO, HUBSPOT, WOOCOMMERCE |
| TYPE | What it does | DEMO, NURTURE, REACTIVATE, ONBOARD |
| NUMBER | Version/variant | 001, 002, 003 |

**Examples:**
- `SEQ-SHOPIFY-DEMO-001` - Shopify demo booking sequence v1
- `SEQ-MAGENTO-DEMO-001` - Magento demo booking sequence v1
- `SEQ-HUBSPOT-SERVICES-001` - HubSpot services outreach
- `SEQ-SHOPIFY-NURTURE-001` - Long-term Shopify nurture

---

## SEQUENCE DOCUMENTATION

**All sequences MUST have a corresponding doc in:**
```
/Users/brent/scripts/CB-Workspace/brent-workspace/ob-notes/Brent Notes/HubSpot/templates/email-sequences/
```

**File naming:** Match the sequence code exactly (e.g., `SEQ-SHOPIFY-DEMO-001.md`)

**Doc should include:**
- Sequence code and name
- Target audience
- Goal
- Number of emails and cadence
- Full email text for each step
- Personalization tokens used
- Enrollment/unenrollment criteria
- HubSpot setup notes

---

## EXISTING SEQUENCES

| Code | Target | Type | Doc |
|------|--------|------|-----|
| SEQ-SHOPIFY-DEMO-001 | Shopify store owners | Demo booking | [Link](obsidian://open?vault=Brent%20Notes&file=HubSpot%2Ftemplates%2Femail-sequences%2FSEQ-SHOPIFY-DEMO-001) |
| SEQ-TRE-001 | Running brand founders | Podcast booking | [Link](obsidian://open?vault=Brent%20Notes&file=HubSpot%2Ftemplates%2Femail-sequences%2FSEQ-TRE-001) |
| SEQ-PARTNER-001 | Partners | TBD | [Link](obsidian://open?vault=Brent%20Notes&file=HubSpot%2Ftemplates%2Femail-sequences%2FSEQ-PARTNER-001) |

---

## TASK MANAGEMENT RULES

### Overdue "Send follow-up email" Tasks

When you see generic "Send follow-up email" tasks:

1. **Check the task body** for context (contact name, company, email opened)
2. **Look up the contact** to see which sequence they're in
3. **Reference the sequence doc** for the appropriate follow-up
4. **After sending**, mark task complete with note about what was sent

### Task Cleanup

- Delete tasks for contacts who have:
  - Unsubscribed
  - Bounced
  - Already replied
  - Already booked a meeting
  - Entered a deal

---

## HUBSPOT EMAIL TEMPLATES

**These are saved templates in HubSpot for manual sends.**

| Template Code | Purpose | When to Use |
|---------------|---------|-------------|
| Shopify RD follow up - 012026 | RequestDesk free offer + 3 months managed content | Shopify leads, offering free pilot |
| WordPress RD follow up - 012026 | WordPress plugin + AEO + managed content | WordPress leads |
| CC Generic follow up - 012026 | Content Cucumber Content Flywheel Plan | Platform-agnostic, human content services |

**Template Properties Used:**
- `personalization_paragraph` - Custom intro paragraph per contact

**Before sending with a template:**
1. Update the contact's `personalization_paragraph` in HubSpot
2. Use the template code above
3. Review the merged email before sending

---

## LEARNING MOMENT: Personalization Paragraph Rules (Jan 20, 2026)

**The personalization_paragraph is a CUSTOM HOOK, not a mini version of the offer.**

### What personalization_paragraph IS:
- A specific hook about THEIR brand/situation
- Something that shows you actually researched them
- A problem or opportunity they likely face
- A natural transition into the template's offer

### What personalization_paragraph is NOT:
- A repeat of the offer (template already has that)
- Generic marketing copy
- Links to demos (template already has that)
- Fake "great meeting you" if you didn't actually meet

### CRITICAL RULE: No Duplication

The template body already contains:
- The offer details (RequestDesk, managed content, etc.)
- Demo links
- Pricing/terms
- CTA

**DO NOT repeat these in the personalization_paragraph.**

### Examples

**BAD (duplicates the template):**
```
Hi Maddie. I came across Created Co. at The Running Event and was impressed by your drinkware line. Our AI connects to your Shopify catalog and creates blog posts that reference your products. Posts publish as drafts so you review everything first. I'd love to offer you 3 months of managed content (6 posts, on us) covering topics like gift guides, drinkware care, or the craftsmanship behind your designs. Live demo: https://requestdesk.ai/integrations/shopify/ No cost, no obligation.
```
**Why it's bad:** Repeats offer details, includes link, says same thing template will say.

**GOOD (custom hook only):**
```
Hi Maddie. Created Co. stands out in a market full of YETI and Stanley knockoffs. The craftsmanship story is there, but is it getting told? Your blog could be where customers learn why a Created tumbler is worth the investment.
```
**Why it's good:** Specific to their brand, identifies their problem (differentiation), natural lead-in to the offer.

### More Good Examples

**Shopify brand with blog gap:**
```
Hi [Name]. [Company]'s products look great, but your blog hasn't been updated since 2023. That's traffic you're leaving on the table.
```

**WordPress brand needing AEO:**
```
Hi [Name]. [Company] has solid content, but it's invisible to ChatGPT and Perplexity. The AI search gap is real, and your competitors are filling it.
```

**International brand needing English content:**
```
Hi [Name]. [Company]'s technology is impressive, but your site is primarily in [language]. You're invisible to the US market. We can fix that.
```

### Don't Fake Relationships

- If you actually met them: "Great meeting you at [Event]"
- If you didn't meet but saw their booth: "I came across [Company] at [Event]"
- If you have no connection: Just start with the hook about their brand

**Rule:** Never use bracket placeholders like "[insert specific topic]" - if you don't know, find out or write around it.

---

## FOLLOW-UP EMAIL TEMPLATES (Draft Examples)

### For Email Openers (Generic)

When someone opens an email but doesn't click or reply:

**Subject:** Re: [Original Subject]

**Body:**
```
Hi [First Name],

Noticed you opened my last email. Quick question: is [pain point from that email] something you're dealing with right now?

If timing's off, no worries. But if you want to see how we handle it, here's a 3-minute demo: [demo link]

Or grab 15 minutes and I'll walk you through it live: [meeting link]

- Brent
```

---

## INTEGRATION WITH CLAUDE

When Claude creates HubSpot tasks via MCP:

1. **Always include sequence code** in task subject if related to a sequence
2. **Link to Obsidian doc** in task body when referencing sequence content
3. **Use contact properties** (first name, company) in task descriptions

---

*Last Updated: 2026-01-20*
