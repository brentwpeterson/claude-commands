# Gmail Responses Skill

**Skill Description:** Decision tree for email responses. Maps incoming email types to HubSpot templates or inline responses. Used when clearing inbox or replying to emails.

---

## QUICK DECISION TREE

When Brent gets an email, match it to one of these categories. Use the HubSpot template if one exists, otherwise use the inline response.

```
INCOMING EMAIL
  |
  +-- Someone wants to SCHEDULE A CALL
  |     -> Send Calendly link (inline, see below)
  |
  +-- POST-MEETING follow-up needed
  |     +-- General recap -> HubSpot: BP-MTG-01
  |     +-- Send resources promised -> HubSpot: BP-MTG-02
  |     +-- Offered to intro someone -> HubSpot: BP-MTG-03
  |
  +-- CONFERENCE contact follow-up
  |     +-- Same day/next morning -> HubSpot: BP-CONF-01
  |     +-- Share relevant content -> HubSpot: BP-CONF-02
  |     +-- Invite to podcast -> HubSpot: BP-CONF-03
  |
  +-- WARM INTRO (someone connected you)
  |     +-- Simple first contact -> HubSpot: BP-INTRO-01
  |     +-- You researched them -> HubSpot: BP-INTRO-02
  |
  +-- NO RESPONSE (need to nudge)
  |     +-- 5-7 days, first bump -> HubSpot: BP-NUDGE-01
  |     +-- 10-14 days, add value -> HubSpot: BP-NUDGE-02
  |     +-- 21+ days, close the loop -> HubSpot: BP-NUDGE-03
  |
  +-- PODCAST related
  |     +-- Guest pitch for Talk Commerce -> Route to producer
  |     +-- Guest pitch for EO Voices -> Brent books directly
  |     +-- Invite someone to TC -> HubSpot: TC-INVITE-01
  |     +-- Invite merchant to TC -> HubSpot: TC-INVITE-02
  |     +-- Invite to Running Commerce -> HubSpot: TC-INVITE-03
  |     +-- Guest asking when episode airs -> HubSpot: TC-POD-04
  |     +-- Episode is live, notify guest -> HubSpot: TC-POD-01
  |     +-- Episode scheduled, notify guest -> HubSpot: TC-POD-02
  |     +-- Paid interview inquiry -> HubSpot: TC-SALES-01
  |     +-- Custom interview package -> HubSpot: TC-SALES-02
  |     +-- PR firm reply -> HubSpot: TC-PR-01
  |
  +-- SALES / SERVICES inquiry
  |     +-- Content Cucumber interest -> HubSpot: CC-SALES-01 (post-demo)
  |     +-- Sent CC proposal, follow up -> HubSpot: CC-SALES-02
  |     +-- Offer content audit -> HubSpot: CC-SALES-03
  |     +-- CommerceKing/consulting -> HubSpot: CK-SALES-01
  |     +-- Platform recommendation -> HubSpot: CK-SALES-02
  |     +-- RequestDesk demo follow-up -> HubSpot: RD-SALES-01
  |     +-- RD trial check-in -> HubSpot: RD-SALES-02
  |     +-- TC sponsorship -> HubSpot: TC-SALES-SPON-01 (update for 2026)
  |
  +-- PARTNER / AGENCY
  |     +-- Agency partner follow-up -> HubSpot: CC-PARTNER-01
  |     +-- RD partner -> HubSpot: RD-PARTNER-01 (rd-partner-1)
  |
  +-- SPEAKING / CONTRIBUTOR invitation
  |     +-- Interested -> inline (see below)
  |     +-- Passing -> inline (see below)
  |
  +-- EO related
  |     +-- Invite new member to podcast -> HubSpot: EO-INVITE-01
  |     +-- Introductions -> respond warmly (inline)
  |
  +-- COLD OUTREACH (vendors/tools)
  |     -> Brief decline or ignore (inline)
  |
  +-- GUEST BLOG inquiry
  |     +-- Inbound guest wanting to write -> HubSpot: TC-CONTENT-01
  |     +-- Paid guest blog response -> Review TC-SALES-01 or inline
  |
  +-- RESCHEDULING
  |     -> Send Calendly link (inline)
  |
  +-- RESEARCH / STUDENT request
        -> Send Calendly link (inline)
```

---

## CRITICAL LINKS

| Purpose | Link |
|---------|------|
| **Schedule a call with Brent** | https://calendly.com/contentbasis/chat-with-brent |
| **Content Cucumber demo** | https://requestdesk.ai/demos/shopify-blog-creation/ |
| **Talk Commerce Podcast site** | https://talk-commerce.com |

### Podcast Booking Links

| Podcast | Calendly Link | Producer Email |
|---------|---------------|----------------|
| **Talk Commerce** | https://calendly.com/contentbasis/45-minute-interview | producer@talk-commerce.com |
| **EO Visionary Voices** | https://calendly.com/contentbasis/eo-podcast | (Brent handles directly) |
| **Running Commerce** | (TBD) | (Brent handles directly) |

**Note:** EO Visionary Voices site (eovoices.com) is not ready yet. Don't include URL in emails.

---

## HUBSPOT TEMPLATE REFERENCE

Templates are encoded: `[BRAND]-[CATEGORY]-[NUMBER]`

**To use:** When suggesting a response, tell Brent the template code. He opens HubSpot, searches the code, and sends. Or Claude drafts from the template text in `HUBSPOT-TEMPLATE-LIBRARY.md`.

**Full template text:** `brent-workspace/ob-notes/Brent Notes/Sales and Marketing/Email Templates/HUBSPOT-TEMPLATE-LIBRARY.md`

**Template inventory by folder:** `brent-workspace/ob-notes/Brent Notes/Sales and Marketing/Email Templates/HUBSPOT/[folder]/README.md`

**Sequence dependencies:** `brent-workspace/ob-notes/Brent Notes/Sales and Marketing/Email Templates/HUBSPOT/SEQUENCES.md`

### Quick Code Lookup

| Code | What It's For |
|------|---------------|
| BP-MTG-01/02/03 | Post-meeting (general / resources / intro offer) |
| BP-CONF-01/02/03 | Conference follow-up (same day / with content / podcast invite) |
| BP-INTRO-01/02 | Warm intro (simple / with research) |
| BP-NUDGE-01/02/03 | No response (5 day / 14 day / 21 day close) |
| CC-SALES-01/02/03 | Content Cucumber (post-demo / post-proposal / audit offer) |
| CC-PARTNER-01 | Agency partner follow-up |
| CK-SALES-01/02 | CommerceKing (post-discovery / platform rec) |
| RD-SALES-01/02/03/04 | RequestDesk (demo / trial / Shopify / WordPress follow-up) |
| RD-PARTNER-01 | RD partner outreach |
| TC-POD-01/02/03/04 | Podcast ops (live / scheduled / launch / when live?) |
| TC-INVITE-01/02/03 | Podcast invite (guest / merchant / Running Commerce) |
| TC-SALES-01/02 | Paid interview / custom package |
| TC-SALES-SPON-01 | Sponsorship (update for 2026) |
| TC-PR-01 | PR firm reply |
| TC-CONTENT-01 | Guest post / collaborative article |
| EO-INVITE-01 | Invite EO member to podcast |

---

## INLINE RESPONSES (no HubSpot template needed)

### Scheduling Requests

**Default:**
```
Here's my calendar link, grab a time that works for you:
https://calendly.com/contentbasis/chat-with-brent
```

**If they offered specific times:**
```
Thanks for the time options. Here's my calendar link which will show my real-time availability:
https://calendly.com/contentbasis/chat-with-brent
```

### Podcast Guest Pitches (Talk Commerce)

**Route to producer. NEVER give them the Calendly booking link.**
```
Thanks for reaching out about Talk Commerce.

Please contact our producer to coordinate:
producer@talk-commerce.com
```

### Podcast Guest Pitches (EO Visionary Voices)

**Brent handles directly:**
```
Thanks for the intro! I'd love to have you on EO Visionary Voices.

Here's the booking link:
https://calendly.com/contentbasis/eo-podcast

Looking forward to it.
```

### Speaking/Contributor - Interested

```
This looks interesting. Can you share more details on:
- Expected time commitment
- Audience size/demographics
- Deadline for content/event

Happy to discuss further: https://calendly.com/contentbasis/chat-with-brent
```

### Speaking/Contributor - Passing

```
Thanks for thinking of me. My schedule is pretty full right now, so I'll have to pass on this one. Best of luck with the project.
```

### Cold Outreach (Vendors/Tools)

```
Thanks, but we're not looking for this right now.
```

### Rescheduling

```
No problem. Here's my calendar link, grab a new time that works:
https://calendly.com/contentbasis/chat-with-brent
```

### Research / Student Requests

```
Happy to chat. Here's my calendar:
https://calendly.com/contentbasis/chat-with-brent

Looking forward to connecting.
```

---

## DELEGATION RULES

| Email Type | Route To |
|------------|----------|
| Talk Commerce podcast guests | producer@talk-commerce.com |
| EO Visionary Voices podcast guests | Brent handles directly |
| Content Cucumber client issues | Isaac (isaac@contentcucumber.com) |
| RequestDesk technical issues | Handle directly or capture in backlog |
| Speaking requests | Brent decides |
| Partnership inquiries | Brent handles |

---

## TONE GUIDELINES

**DO:**
- Keep it short (3-5 sentences max)
- Be direct and friendly
- Use the Calendly link instead of back-and-forth scheduling
- Sign off simply: "Brent" or "Thanks, Brent"

**DON'T:**
- Use em dashes (use periods or commas instead)
- Over-explain or apologize excessively
- Promise specific timelines you can't control
- Use corporate speak ("circle back", "touch base", "synergize")

---

## SIGNATURE

```
Brent Peterson
Content Cucumber | RequestDesk
```

Or simply: `Brent`

---

*Last Updated: 2026-03-31*
