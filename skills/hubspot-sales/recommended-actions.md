# Recommended Actions: Signal → Action Mapping

**Purpose:** Given a set of signals, know exactly what to recommend.

---

## Quick Reference Matrix

| Engagement | Fit Score | Predictive Score | Action |
|------------|-----------|------------------|--------|
| High clicks (5+) | High | High | **Immediate personal follow-up** |
| High clicks (5+) | High | Low | Personal follow-up, investigate predictive gap |
| High clicks (5+) | Low | Any | Requalify fit, may be wrong persona |
| Low clicks (1-2) | High | High | Continue sequence, add LinkedIn touch |
| Low clicks (1-2) | High | Low | Continue sequence, monitor |
| Opens, no clicks | Any | Any | Test different CTA or value prop |
| No opens | High | High | Try different channel (LinkedIn, phone) |
| No opens | Low | Low | Deprioritize, minimal effort |
| Reply received | Any | Any | **Personal response within 24 hrs** |
| Meeting booked | Any | Any | Prepare, confirm, research |
| Unsubscribed | Any | Any | LinkedIn only or remove |

---

## Action Playbooks by Scenario

### Scenario: High Engagement, No Reply (Like Ashley)

**Signals:**
- 5+ email clicks
- Visited demo/CTA link multiple times
- No reply, no meeting booked

**Diagnosis:** Very interested but has barrier (time, objection, needs approval).

**Actions:**
1. Write behavioral insight to NOTES
2. Update personalization token with relevant hook
3. Recommend personal email within 48 hours
4. Offer low-commitment next step (15-min call, not full demo)
5. Add LinkedIn connection if not connected
6. If already connected, send LinkedIn message

**Personalization angle:** Reference their engagement without saying "I saw you clicked 8 times"
- "I noticed you were checking out the demo..."
- "Since you seemed interested in the AI search topic..."

---

### Scenario: Opened But No Clicks

**Signals:**
- 1-3 opens
- Zero clicks
- In sequence

**Diagnosis:** Subject got attention, content didn't compel action.

**Actions:**
1. Let sequence continue (different angles)
2. Note which subject lines get opens
3. If pattern continues, recommend manual email with stronger CTA
4. Test: More specific value prop, scarcity, or social proof

---

### Scenario: No Opens At All

**Signals:**
- 0 opens across multiple emails
- Still in sequence

**Diagnosis:** Wrong email, spam filter, wrong timing, or ignoring.

**Actions:**
1. Check email validity (bounces?)
2. Try different channel (LinkedIn)
3. If LinkedIn exists and active, prioritize that
4. If no LinkedIn presence, consider phone if high-fit
5. After sequence exhausted, move to long-term nurture

---

### Scenario: Replied "Not Now" / "Bad Timing"

**Signals:**
- Explicit reply indicating interest but not ready
- May include timeline ("check back in Q2")

**Diagnosis:** Real interest, wrong timing.

**Actions:**
1. Acknowledge and respect (reply immediately)
2. Set Lead Status = "Bad Timing"
3. Create task for follow-up at mentioned time
4. Add to low-touch nurture (monthly newsletter)
5. Document in NOTES: what they said, when to follow up
6. Do NOT keep emailing now

**Reply template:**
```
Totally understand - timing is everything. I'll circle back
in [timeframe they mentioned]. In the meantime, if anything
changes, I'm here.
```

---

### Scenario: Replied "Not Interested"

**Signals:**
- Explicit rejection
- No stated reason or stated reason is fundamental

**Diagnosis:** Not a fit right now (or ever).

**Actions:**
1. Thank them graciously
2. Set Lead Status = "Unqualified"
3. Remove from all sequences
4. Document reason in NOTES
5. Do NOT try to overcome objection in reply

**Reply template:**
```
Appreciate you letting me know - I'll take you off my list.
If things change down the road, feel free to reach out.
```

---

### Scenario: Ghosted After Demo/Meeting

**Signals:**
- Had meeting/demo
- No response to follow-ups
- Multiple follow-up attempts made

**Diagnosis:** Lost interest, internal blocker, or went with competitor.

**Actions:**
1. Try different stakeholder if known
2. Send "breakup" email (final attempt)
3. Try LinkedIn as different channel
4. If still no response, move to long-term nurture
5. Set task for 3-month re-engagement

**Breakup email angle:**
```
I've reached out a few times since our demo - I'm guessing
the timing isn't right. I'll stop filling your inbox, but
if [problem you solve] becomes a priority, I'm around.
```

---

### Scenario: High Predictive Score, Low Engagement

**Signals:**
- HubSpot says high likelihood to close
- But minimal engagement with your outreach

**Diagnosis:** HubSpot sees patterns you don't, OR your outreach isn't reaching them.

**Actions:**
1. Investigate: Is email correct? Going to spam?
2. Research: What does HubSpot see? (Company fit? Similar to converted customers?)
3. Try different channel with high effort (LinkedIn, phone)
4. Test different messaging angle
5. Worth extra effort given predictive signal

---

### Scenario: Low Predictive Score, High Engagement

**Signals:**
- Clicking, opening, maybe even replied
- HubSpot says low likelihood to close

**Diagnosis:** Interested but historically this profile doesn't convert.

**Actions:**
1. Qualify harder: Are they a decision maker? Budget?
2. Look for red flags HubSpot may see (company size, industry)
3. Proceed but don't over-invest
4. May be curiosity seeker or tire-kicker
5. Ask direct qualifying questions early

---

## Action Timing Guide

| Action | Timing |
|--------|--------|
| Reply to their email | Within 4 hours (same business day) |
| Follow up on high engagement | Within 48 hours |
| Post-demo follow-up | Same day or next morning |
| "Bad timing" follow-up | When they specified, or 3 months |
| Sequence running, no engagement | Let it complete |
| Ghosted after meeting | 3 attempts over 2 weeks, then pause |
| Re-engage cold contact | 3-6 months later |

---

## Output Format for Recommendations

When recommending actions, structure like this:

```
## Recommended Action

**Contact:** [Name]
**Current Status:** [Lifecycle Stage / Lead Status]
**Key Signal:** [What triggered this recommendation]

**Immediate Action:**
[Specific thing to do right now]

**Timeline:** [When to do it]

**Content Needed:**
- [ ] Update personalization token (see draft below)
- [ ] Personal email (see draft below)
- [ ] LinkedIn message (see draft below)

**If No Response:**
[What to do next if this doesn't work]
```
