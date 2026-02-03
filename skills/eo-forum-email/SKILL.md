# /eo-forum-email Command

**Command Description:** Send an email to Dreamweavers Forum members. Creates a Gmail draft for review.

## Usage

```
/eo-forum-email "Subject line here"
/eo-forum-email (Claude will ask for subject)
```

## What This Command Does

1. Load `/brand-brent` persona
2. Ask for email content/topic if not provided
3. Draft email in Brent's voice
4. Run terms checker
5. Save to **Gmail Drafts** (never sends directly)
6. Save copy to Obsidian `EO Material/emails-sent/`
7. User reviews in Gmail and sends manually

**Claude NEVER sends directly. Always creates draft for review.**

## Forum Members

| Name | Email |
|------|-------|
| Brent Peterson (self) | brent@contentbasis.io |
| Mark Sigel | msigel@sofiascookies.com |
| Randy Stenger | randy@extremesandbox.com |
| Paul Jonas | paulj@breezynotes.com |
| James Boys | james@boyswaterproducts.com |
| Kathy Mrozek | kathy@windmillstrategy.com |
| Tom Suerth | tom@waterfrontrestoration.com |

**All Recipients:**
```
brent@contentbasis.io, msigel@sofiascookies.com, randy@extremesandbox.com, paulj@breezynotes.com, james@boyswaterproducts.com, kathy@windmillstrategy.com, tom@waterfrontrestoration.com
```

## Email Style

- Casual, collegial tone ("Hey everyone")
- No em dashes (use periods or commas)
- No emojis
- Direct but warm
- Sign off with just "Brent"

## Related

- **Full EO context:** See `/eo-forum` skill for forum fundamentals, terminology, meeting prep
- **Obsidian folder:** `EO Material/emails-sent/`
