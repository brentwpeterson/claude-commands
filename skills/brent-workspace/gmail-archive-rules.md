# Gmail Auto-Archive Rules

**Purpose:** When processing Brent's Gmail inbox, automatically archive emails matching these rules without asking.

**Usage:** Check this file at the start of any Gmail inbox review. Archive matches silently, then report "Archived X emails by rule" at the end.

---

## Rules

### Vista Social Notifications
- **From:** `notifications@vistasocial.com`
- **Subject:** (any)
- **Action:** Archive
- **Reason:** Post published confirmations, not actionable

### HubSpot Contact Owner Notifications
- **From:** `noreply@notifications.hubspot.com`
- **Subject contains:** `You have been made the Contact owner`
- **Action:** Archive
- **Reason:** FYI only, contact already visible in CRM

### HubSpot Booking Notifications
- **From:** `noreply@notifications.hubspot.com`
- **Subject contains:** `You've been booked by`
- **Action:** Archive
- **Reason:** Calendar invite is the actionable item, not the email

### Slack DM Notifications
- **From:** `notification@slack.com`
- **Subject contains:** `sent you a message`
- **Action:** Archive
- **Reason:** Already visible in Slack

### Mail Delivery Delays
- **From:** `mailer-daemon@googlemail.com`
- **Subject contains:** `Delivery Status Notification`
- **Action:** Archive
- **Reason:** Transient issue, Gmail retries automatically

### Calendar Acceptances
- **From:** (any)
- **Subject contains:** `Accepted:`
- **Action:** Archive
- **Reason:** FYI only, calendar already updated

---

## Adding New Rules

When Brent says "always archive these [type] emails", add a new rule section:

```markdown
### [Descriptive Name]
- **From:** `email@domain.com`
- **Subject contains:** `pattern` (or "any")
- **Action:** Archive
- **Reason:** [Why this is safe to auto-archive]
```

---

## Do NOT Auto-Archive

These should always be shown to the user:
- Calendar invitations (need response)
- Emails from clients or prospects
- Emails with "urgent", "action required" in subject
- Anything from `@contentbasis.io` or `@contentcucumber.com` team
