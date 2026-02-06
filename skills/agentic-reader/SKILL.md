# Agentic Reader - Content Audience Evaluation

Evaluate content through the lens of "The Agentic Commerce Guy" newsletter audience.
Read an article and report who it reaches, who it misses, and whether it fits the brand.

## The Newsletter: The Agentic Commerce Guy

**Identity:** Brent Peterson's newsletter about how AI agents and automation are
transforming commerce. Not generic e-commerce tips. The angle is always: how is this
becoming agentic?

**Voice:** Informed, opinionated, practical. Talks to peers, not down to beginners.
Assumes the reader is already in the game and wants to know what's next.

## The Seven Audience Segments

Every article is evaluated against all seven. The goal is to hit as many as possible
without diluting the depth.

| # | Segment | What they care about | Agentic angle |
|---|---------|---------------------|---------------|
| 1 | **Agencies** | Scaling client work, efficiency, tools, margins | How agents replace manual agency processes |
| 2 | **Merchants/Store Owners** | Revenue, conversion, what actually works | AI that runs parts of their store for them |
| 3 | **E-commerce Experts** | Strategy, trends, what's next | The shift from tools to autonomous agents |
| 4 | **Marketing Managers** | Tactics, how-to, proving ROI to their boss | Agent-driven campaigns, content, personalization |
| 5 | **Developers/Tech** | Integrations, platform capabilities, APIs | Building agents, MCP, agent SDKs, architecture |
| 6 | **Freelancers/Consultants** | Winning clients, positioning, best practices | Offering agentic services, staying relevant |
| 7 | **Platform Partners** | Ecosystem, co-selling, technical trends | Agent-powered apps, integrations, marketplace |

## Evaluation Framework

### Step 1: Read the Content

Accept input via:
- Pasted text in the prompt
- File path (read the file)
- Published URL (fetch and read)

### Step 2: Brand Fit Check

**Does this article belong in "The Agentic Commerce Guy"?**

Score: **Strong Fit** / **Moderate Fit** / **Weak Fit** / **Off Brand**

Criteria:
- Is there an AI, agent, or automation angle? (Required for Strong Fit)
- Is it about commerce/e-commerce? (Required for Strong or Moderate)
- Does it have a point of view, not just information? (Required for Strong)
- Would Brent's audience expect this from him? (Gut check)

If Weak Fit or Off Brand, explain what's missing and suggest how to add the agentic angle.

### Step 3: Segment Reach

For each of the 7 segments, evaluate:

| Segment | Reaches? | Why / Why Not |
|---------|----------|---------------|
| Agencies | Yes/No | [1 sentence] |
| Merchants | Yes/No | [1 sentence] |
| E-commerce Experts | Yes/No | [1 sentence] |
| Marketing Managers | Yes/No | [1 sentence] |
| Developers/Tech | Yes/No | [1 sentence] |
| Freelancers/Consultants | Yes/No | [1 sentence] |
| Platform Partners | Yes/No | [1 sentence] |

**Reach Score: X/7 segments**

### Step 4: Depth Check

**Is the depth calibrated for the audience?**

| Level | Description | Signal |
|-------|-------------|--------|
| Too Basic | Explains things the audience already knows | "What is SEO?" in a newsletter for experts |
| Right Level | Assumes competence, adds new insight | Talks about agent-driven SEO strategy shifts |
| Too Deep | Only developers would follow | Raw code, API specs with no business context |
| Mixed | Some sections land, others miss | Good strategy section, then unnecessary basics |

Verdict: **Too Basic** / **Right Level** / **Too Deep** / **Mixed**

If Mixed, call out which sections are off and for whom.

### Step 5: The Share Test

**Would someone forward this?**

- **Yes, strong take** - There's an opinion or insight people would talk about
- **Maybe, useful info** - Good information but no memorable angle
- **No, generic** - Could have come from any AI-generated blog

What's the one thing someone would quote or screenshot from this article?
If you can't find one, the article needs a stronger take.

### Step 6: Jargon and Accessibility Check

Flag any terms that would lose specific segments:

| Term | Who it loses | Suggestion |
|------|-------------|------------|
| [term] | [segment] | [plain language alternative or brief inline definition] |

The goal is not to dumb it down. It's to make sure jargon is either defined inline
or clearly contextual. Merchants shouldn't need to Google "MCP protocol" and developers
shouldn't be bored by "what is an API."

### Step 7: Verdict

Present the final evaluation:

```
## Agentic Reader Verdict

**Article:** [title or first line]
**Brand Fit:** [Strong/Moderate/Weak/Off Brand]
**Segment Reach:** X/7
**Depth:** [Too Basic/Right Level/Too Deep/Mixed]
**Share Test:** [Strong take/Useful info/Generic]

### Segments Reached
[List the segments that would engage]

### Segments Missed
[List the segments that wouldn't, and one sentence on what would bring them in]

### Recommendations
- [Specific, actionable suggestion 1]
- [Specific, actionable suggestion 2]
- [Specific, actionable suggestion 3]
```

## Usage Notes

- This skill does NOT rewrite the content. It evaluates and recommends.
- If the user wants rewrites, hand off to `/cucumber writer` with the recommendations.
- The skill should be honest. "This is generic" is more useful than "great article!"
- No fabricated praise. If it's weak, say so and say why.
- Remember: no em dashes, no emojis in the output.
