# Send Email - HubSpot Task Email Workflow

Send follow-up emails from HubSpot tasks via Gmail, with logging back to HubSpot.

## Usage

```
/send-email <hubspot-task-id>
```

**Arguments:**
- `<hubspot-task-id>` (required): The HubSpot task ID to process

## CRITICAL RULES

**NEVER send an email without explicit user approval.**

- Always show the full draft
- Always wait for "send it", "approved", or similar confirmation
- If user provides edits, show revised draft and wait again
- NO AUTO-SENDING EVER

---

## Workflow Steps

### Step 1: Get Task Context from HubSpot

```
1. Fetch task details using hubspot-batch-read-objects (tasks)
2. Get associated contact ID via hubspot-list-associations
3. Fetch contact details (name, email, company)
4. Display summary to user
```

**Display:**
```
Task: [task subject]
Contact: [firstname] [lastname]
Email: [email]
Company: [company name]
```

### Step 2: Check Gmail History (Optional)

```
1. Search Gmail for: "from:[email] OR to:[email]"
2. If found, show recent thread snippets
3. If not found, note "No prior email history"
```

### Step 3: Ask User for Email Content

**CRITICAL: Do not assume email content. Ask the user:**

```
What should this email say?
- What's the context/purpose?
- Any specific points to include?
- Tone preference? (casual, professional, brief)
```

### Step 4: Draft Email & Show for Review

**Display full draft in a clear format:**

```
═══════════════════════════════════════════
📧 DRAFT EMAIL - REVIEW BEFORE SENDING
═══════════════════════════════════════════

To: [email]
Subject: [subject]

---

[Full email body here]

---

═══════════════════════════════════════════
```

**Then ask:**
```
Review the draft above.
- Type "send" to send as-is
- Type edits/changes you want
- Type "cancel" to abort
```

### Step 5: Wait for Explicit Approval

**DO NOT PROCEED until user says one of:**
- "send"
- "send it"
- "looks good, send"
- "approved"
- Or similar explicit confirmation

**If user provides edits:**
1. Revise the draft
2. Show the revised draft again
3. Wait for approval again
4. Repeat until approved or cancelled

### Step 6: Send Email via Gmail

Only after explicit approval:

```
gmail_send_email:
  to: [contact email]
  subject: [approved subject]
  body: [approved body]
```

**Confirm to user:**
```
✅ Email sent (Message ID: [id])
```

### Step 7: Log as NOTE in HubSpot

```
hubspot-create-engagement:
  type: NOTE
  ownerId: 378618219
  associations: { contactIds: [contact_id], companyIds: [company_id] }
  metadata:
    body: |
      <strong>Email Sent via Gmail ([date])</strong>
      <br><br>
      <strong>Subject:</strong> [subject]
      <br><br>
      <strong>Body:</strong><br>
      [email body with <br> for line breaks]
```

**Confirm:**
```
✅ Logged to HubSpot (Engagement ID: [id])
```

### Step 8: Mark HubSpot Task as Completed

```
hubspot-batch-update-objects:
  objectType: tasks
  inputs: [{ id: [task_id], properties: { hs_task_status: "COMPLETED" }}]
```

**Confirm:**
```
✅ Task marked complete
```

### Step 9: Create Follow-up Task?

**Ask user:**
```
Create follow-up task?
- "yes" or "y" + number of days (default: 3)
- "no" or "n" to skip

Example: "yes 5" = follow-up in 5 days
```

**If yes:**
```
hubspot-create-engagement:
  type: TASK
  ownerId: 378618219
  associations: { contactIds: [contact_id], companyIds: [company_id] }
  timestamp: [now + X days in milliseconds]
  metadata:
    subject: "Follow up with [contact name]"
    body: "Follow up on email sent [date] about [topic]."
    status: "NOT_STARTED"
    forObjectType: "CONTACT"
```

---

## Quick Reference

**HubSpot Owner ID (Brent):** 378618219

**Gmail sends from:** brent@contentbasis.io

**Calendly link:** https://calendly.com/contentbasis/chat-with-brent

---

## Example Session

```
User: /send-email 100267875475

Claude:
Task: Follow up with Rachelle Rushton
Contact: Rachelle Rushton
Email: rachelle@easihairpro.com
Company: easihair pro

No prior email history found.

What should this email say? What's the context?

User: Demo request for RequestDesk branding tools

Claude:
═══════════════════════════════════════════
📧 DRAFT EMAIL - REVIEW BEFORE SENDING
═══════════════════════════════════════════

To: rachelle@easihairpro.com
Subject: Following up - RequestDesk Demo

---

Hi Rachelle,

[draft content here]

Best,
Brent

---

═══════════════════════════════════════════

Review the draft above.
- Type "send" to send as-is
- Type edits/changes you want
- Type "cancel" to abort

User: Change the subject to include "easihair pro"

Claude:
[Shows revised draft]

User: send

Claude:
✅ Email sent (Message ID: xxx)
✅ Logged to HubSpot (Engagement ID: xxx)
✅ Task marked complete

Create follow-up task? (yes/no, default 3 days)

User: yes 5

Claude:
✅ Follow-up task created for [date] (5 days out)

Done!
```

---

## Error Handling

- If task not found: "Task ID [id] not found in HubSpot"
- If no contact associated: "No contact associated with this task"
- If Gmail send fails: Show error, do not mark task complete
- If user cancels: "Email cancelled. Task remains open."
