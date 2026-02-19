# Planning Poker Skill

**Skill Description:** Simulate a planning poker session using 4 Claude agents with distinct estimation personas. Used during sprint planning to groom backlog items, break stories into tasks, and finalize point estimates through structured disagreement.

---

## When to Use

- During sprint planning (Step 7: Groom New Work)
- When grooming a batch of backlog items (5+ items)
- When breaking down stories into tasks
- Mid-sprint for emergent stories needing breakdown

---

## The Panel

| Agent | Persona | Bias | Surfaces |
|-------|---------|------|----------|
| **Brent** | The Owner | Real-world context | Ground truth, priorities, dependencies |
| **The Optimist** | Fast mover, happy path | Underestimates | Minimum viable scope |
| **The Skeptic** | Edge case hunter | Overestimates | Hidden work, integration risks |
| **The Busy Exec** | 20 min between flights | Forces simplification | Ruthless scoping |
| **The Multitasker** | Constantly interrupted | Accounts for friction | Real-world time vs ideal time |

---

## Point Scale

- 1 point = ~1 hour of work
- 2 points = ~2 hours of work
- Maximum 2 points per task
- If larger, must be broken into a story with child tasks

---

## Execution Flow

### Phase 1: Gather Candidates

Pull candidate items from backlog API:

```bash
curl -s "https://app.requestdesk.ai/api/backlog?sprint_name=CURRENT" \
  -H "Authorization: Bearer MNRcaklW3XF7UpKX4VrxPV7wo2L7xsWg" | \
  python3 -c "import json,sys; [print(f'{i[\"title\"]}') for i in json.load(sys.stdin) if i.get('status')=='backlog']"
```

Or accept a list of items from the user.

### Phase 2: Brent Estimates First (The 5th Voice)

**Before spawning agents, ask Brent for his estimates.** This prevents anchoring bias.

Present items in a simple table and ask Brent to estimate each:

```
Before I run the agents, give me your gut estimates:

| Item | Your Estimate (1-2 pts, or "story") |
|------|-------------------------------------|
| [item 1] | ? |
| [item 2] | ? |
```

Wait for Brent's estimates before proceeding.

### Phase 3: Spawn Agents

Launch all 4 agents in parallel using the Task tool with `subagent_type="general-purpose"` and `model="sonnet"`.

Each agent receives:
1. Their persona prompt (see Agent Prompts below)
2. The point scale
3. Project context summary
4. The list of items to estimate

**Critical:** All 4 must be spawned in a SINGLE message with 4 parallel Task tool calls.
**Critical:** Do NOT include Brent's estimates in the agent prompts. Agents estimate independently.

### Phase 4: Compile Results

After all agents return, build the comparison table **including Brent's column**:

```
## PLANNING POKER RESULTS

| Item | Brent | Optimist | Skeptic | Busy Exec | Multitasker | Consensus |
|------|-------|----------|---------|-----------|-------------|-----------|
| [item] | [est] | [est] | [est] | [est] | [est] | [result] |
```

**Consensus rules:**
- All 5 within 1 point = Accept majority. Tag as CONSENSUS.
- Spread of 2+ points = Tag as DIVERGENCE. Show highest and lowest reasoning.
- Any voice says "story" while others say "task" = Flag for discussion.

### Phase 5: Resolve Divergences

For DIVERGENCE items only, show the spread and reasoning:
- "You said [X], agents ranged [Y-Z]. Here's why they diverged: [reasoning]"
- Brent makes the final call.

For CONSENSUS items, confirm and move on quickly.

Brent has final say on every estimate.

### Phase 6: Record Decisions

Update backlog API with final estimates:

```bash
curl -s -X PATCH "https://app.requestdesk.ai/api/backlog/ITEM_ID" \
  -H "Authorization: Bearer MNRcaklW3XF7UpKX4VrxPV7wo2L7xsWg" \
  -H "Content-Type: application/json" \
  -d '{"points": FINAL_ESTIMATE}'
```

Write results to sprint plan if items are being committed.

---

## Agent Prompts

### Base Context (sent to all agents)

```
You are participating in a planning poker session for sprint grooming.

Point scale:
- 1 point = ~1 hour of work
- 2 points = ~2 hours of work
- Maximum 2 points per task. If larger, it must be broken into a story with child tasks.

Project context: [PULLED FROM SPRINT PLAN OR CLAUDE.MD]

For each item, return:
- Type: task or story
- Estimate: 1 or 2 points (if task), or breakdown into child tasks (if story)
- Reasoning: 1-2 sentences from your persona's perspective

Format as a markdown table: Item, Type, Estimate, Reasoning
```

### The Optimist

```
Your persona: The Optimist. You see the happy path. You assume things will go smoothly,
the code is clean, the docs are clear, and there are no surprises. You tend to estimate
on the low end. Your value to the team is defining the minimum viable scope. Ask yourself:
"What if everything goes perfectly? What's the fastest path?"
```

### The Skeptic

```
Your persona: The Skeptic. You hunt for edge cases, hidden dependencies, and integration
risks. You assume something will go wrong. You tend to estimate on the high end. Your
value to the team is surfacing hidden work. Ask yourself: "What are we missing? What
could go wrong? What's the thing nobody thought of?"
```

### The Busy Exec

```
Your persona: The Busy Exec. You have 20 minutes between flights. You force ruthless
simplification. If a task can't be explained in one sentence, it's too big. Your value
to the team is cutting scope. Ask yourself: "Can this be smaller? Do we really need all
of this? What's the absolute minimum to ship?"
```

### The Multitasker

```
Your persona: The Multitasker. You context-switch constantly. You get interrupted. You
know that a "1 hour task" actually takes 2 hours in real life because of Slack, email,
setup time, and getting back into flow. Your value to the team is accounting for
real-world friction. Ask yourself: "How long does this ACTUALLY take when I have a
normal day with interruptions?"
```

---

## Rules

1. **Brent always has final say.** Agents inform, Brent decides.
2. **Max 2 pts per task.** If any agent suggests 3+, it must be broken down.
3. **Write as you go.** Every decision is recorded immediately.
4. **Time-box per item.** Consensus = move on. Don't over-discuss simple items.
5. **Stories get broken down before estimation.** Estimate child tasks, not the story.

---

## Metrics to Track (Future)

Over time, compare agent estimates vs actual completion time:
- Which persona is most accurate?
- Is Brent consistently optimistic or pessimistic?
- Are Skeptic's concerns justified or paranoid?

---

## SOP Reference

Full SOP with implementation details: `Dashboard/SOPs/001-planning-poker-sop.md`

---

## Version History

| Date | Change | By |
|------|--------|-----|
| 2026-01-31 | SOP drafted | Brent + Claude-Austen |
| 2026-02-13 | Skill file created, first live session run | Claude-Turing |
| 2026-02-13 | Fixed: Brent estimates first as 5th voice (prevents anchoring bias) | Claude-Turing |
