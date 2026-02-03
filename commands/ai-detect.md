# AI Detection - Content Authenticity Analysis

Analyze content for AI-generated patterns using a 10-category framework. Returns a score and actionable findings.

**USAGE:**
- `/ai-detect <file-path>` - Analyze a file for AI patterns
- `/ai-detect <file-path> --summary` - Quick summary score only (skip detailed analysis)

**ARGUMENTS:**
- `<file-path>` (required): Path to the content file to analyze (markdown, text, HTML)
- `--summary` (optional): Return only the overall score and top findings

**PURPOSE:**
Run content through a structured AI detection analysis before publishing. Identifies sentence patterns, vocabulary issues, logical gaps, and stylistic markers that signal AI-generated text. Use this after drafting and before final review.

---

## EXECUTION STEPS

### Step 1: Load Content

1. Read the file at the provided path
2. Strip any front matter (status, publish date, word count headers)
3. Strip any sections after `---` that are metadata (Sources, LinkedIn Post, Comment Engagement)
4. Focus analysis on the article body only

### Step 2: Run 10-Category Analysis

Analyze the content against each category below. For each category, answer the questions using the specified format. Be specific with direct quotes from the content.

**IMPORTANT:** Be honest and critical. The goal is to catch AI patterns before a reader or detection tool does. Don't soften findings.

---

#### Category 1: Sentence Structure Analysis

**Q1: How varied are the sentence structures throughout the document?**
Answer Format: "Regarding sentence structure variation, the document [assessment]. For example, the paragraph about [topic] uses [short/long/complex] sentences such as '[direct quote]', while the writing shifts to [different structure pattern] in [other section]. This [does/does not] reflect the natural variation typically found in human writing."

**Q2: Are there any patterns of repetitive sentence openings or structures?**
Answer Format: "The document [does/does not] display repetitive sentence openings. In [section], I noticed that [number] consecutive sentences begin with [pattern], particularly when discussing [topic]. This pattern [is/is not] consistent with human writing."

**Q3: How natural are the transitions between sentences and paragraphs?**
Answer Format: "Regarding transitions, the document [assessment]. For instance, the shift from discussing [topic A] to [topic B] uses the transition phrase '[direct quote]', which [feels natural/seems mechanical]. Paragraph transitions are particularly [smooth/abrupt] in [specific section]."

---

#### Category 2: Word Choice and Vocabulary

**Q1: Is there evidence of uncommon word choices or domain-specific terminology used appropriately?**
Answer Format: "The document's vocabulary [assessment]. In the section on [topic], the author demonstrates [appropriate/inappropriate] use of specialized terms like '[examples]'. These terms are [integrated naturally/inserted awkwardly] into sentences like '[direct quote]', suggesting [human expertise/algorithmic insertion]."

**Q2: Are there instances of redundant synonyms or unnecessary modifiers?**
Answer Format: "Regarding word redundancy, the document [assessment]. For example, the phrase '[direct quote with redundancy]' demonstrates [natural variation/algorithmic repetition]. This pattern appears [consistently/occasionally] throughout the document."

**Q3: Does the document use idioms, colloquialisms, or culturally specific references appropriately?**
Answer Format: "The document [does/does not] incorporate idiomatic expressions effectively. The phrase '[idiomatic expression]' is used in the context of [topic], which [makes perfect sense/seems out of place], suggesting [human understanding/AI limitation]."

---

#### Category 3: Coherence and Context

**Q1: How well does the document maintain thematic coherence across sections?**
Answer Format: "Regarding thematic coherence, the document [maintains/struggles with] consistent themes. The transition from [topic A] to [topic B] [flows logically/seems disjointed] because [specific reason]."

**Q2: Are there instances where information seems irrelevant or disconnected from the main topic?**
Answer Format: "The document [does/does not] contain irrelevant information. The paragraph about [topic] introduces '[concept]', which [relates clearly to/seems disconnected from] the main focus on [main topic]."

**Q3: Does the document demonstrate awareness of its own earlier content through self-references or callbacks?**
Answer Format: "The document [effectively/poorly] references its own earlier content. For example, [specific callback or lack thereof]. This kind of self-referential awareness [appears throughout/is notably absent]."

---

#### Category 4: Logical Reasoning and Argument Structure

**Q1: How sound is the logical progression of arguments or explanations?**
Answer Format: "Regarding logical progression, the document [assessment]. The reasoning moves from [starting point] to [conclusion] through [key points]. This [demonstrates careful thought/shows potential limitations] in how it [handles/fails to address] potential counterarguments."

**Q2: Are there instances of circular reasoning or logical fallacies?**
Answer Format: "The document [contains/avoids] logical fallacies. When discussing [topic], the statement '[direct quote]' represents [a sound argument/circular reasoning] because [specific analysis]."

**Q3: How effectively does the document address potential counterarguments or alternative perspectives?**
Answer Format: "The document [effectively/inadequately] addresses counterarguments. In the section on [topic], the author [acknowledges/ignores] the opposing viewpoint that '[potential counterargument]'."

---

#### Category 5: Depth and Originality of Insights

**Q1: Does the document offer novel insights or merely restate common knowledge?**
Answer Format: "Regarding originality, the document [assessment]. The statement '[direct quote]' represents [a fresh perspective/common knowledge] on [topic]. The analysis [goes beyond/merely restates] widely available information."

**Q2: Are analogies, examples, or case studies used effectively and originally?**
Answer Format: "The document [effectively/ineffectively] employs analogies. The analogy comparing [concept A] to [concept B] through '[direct quote]' [illuminates the topic creatively/seems generic]."

**Q3: Is there evidence of personal experience or unique perspective?**
Answer Format: "The document [does/does not] incorporate personal experience. The author shares [specific detail] when discussing [topic]. This [adds authentic dimension/seems fabricated]."

---

#### Category 6: Stylistic Consistency and Voice

**Q1: How consistent is the writing style throughout the document?**
Answer Format: "Regarding stylistic consistency, the document [maintains/fails to maintain] a consistent voice. The tone [stays steady/shifts noticeably] between [sections], which [reflects natural variation/suggests possible AI segments]."

**Q2: Are there shifts in formality level or technical language use that seem unnatural?**
Answer Format: "The document [demonstrates/lacks] natural shifts in formality. The language [appropriately/inappropriately] becomes more specialized when discussing [technical topic] with terms like '[examples]'."

**Q3: Does the document maintain a consistent point of view?**
Answer Format: "The document [maintains/shifts between] point(s) of view. The author uses [perspective] as evidenced by '[direct quote]'. This [continues consistently/changes unexpectedly]."

---

#### Category 7: Factual Accuracy and Citations

**Q1: How well are factual claims supported by evidence or citations?**
Answer Format: "Regarding factual support, the document [assessment]. The claim that '[factual statement]' is [supported by/lacks] appropriate citation."

**Q2: Are there any factual inaccuracies or outdated information?**
Answer Format: "The document [contains/avoids] factual inaccuracies. The statement '[direct quote]' regarding [topic] is [accurate/inaccurate] because [specific reason]."

**Q3: How specific and verifiable are the examples or data points presented?**
Answer Format: "The document's data points are [specific and verifiable/vague]. When discussing [topic], the author cites '[specific data point]'. This [can be traced to a specific source/lacks clear attribution]."

---

#### Category 8: Contextual Awareness and Timeliness

**Q1: Does the document demonstrate awareness of current events or recent developments?**
Answer Format: "The document [demonstrates/lacks] up-to-date knowledge. The reference to '[recent development]' [shows currency/seems outdated] because [specific reason]."

**Q2: Are cultural or temporal references appropriate and accurate?**
Answer Format: "The document [effectively/problematically] incorporates cultural and temporal references. The mention of '[reference]' in relation to [topic] [makes sense/seems inappropriate]."

**Q3: How well does the document address the specific audience it seems intended for?**
Answer Format: "The document [effectively/ineffectively] addresses its target audience. The explanation of [concept] using language like '[direct quote]' [seems appropriately calibrated/appears mismatched] for [presumed audience]."

---

#### Category 9: Emotional Intelligence and Nuance

**Q1: How effectively does the document handle emotionally charged or sensitive topics?**
Answer Format: "The document [handles/struggles with] sensitive topics. The discussion of [topic] through '[direct quote]' [demonstrates nuanced understanding/shows mechanical treatment]."

**Q2: Does the document show appropriate empathy or ethical awareness?**
Answer Format: "The document [demonstrates/lacks] ethical awareness. When addressing [issue], the statement '[direct quote]' [shows thoughtful consideration/presents a simplified view]."

**Q3: Are there subtle expressions of opinion or value judgments that seem authentic?**
Answer Format: "The document [contains/lacks] authentic expressions of opinion. The value judgment in '[direct quote]' [feels naturally integrated/seems artificially inserted]."

---

#### Category 10: Technical Analysis Indicators

**Q1: Is there unusual repetition of phrases or sentence structures?**
Answer Format: "Regarding repetition, the phrase '[specific phrase]' appears [number] times. The sentence structure '[pattern]' recurs noticeably. This level of repetition [falls within normal human variation/exceeds typical patterns]."

**Q2: How does the document score on perplexity and burstiness measures?**
Answer Format: "The document's linguistic variability [indicates human/suggests AI] authorship. Sections about [topic] [show high variation/appear predictable]. Regarding burstiness, the document [displays/lacks] the natural peaks and valleys of human writing."

**Q3: Are there patterns that suggest algorithmic generation?**
Answer Format: "The document [contains/lacks] patterns suggesting algorithmic generation. The systematic way [specific pattern] occurs [seems mechanical/appears natural]. The document's handling of [element] [demonstrates human irregularity/shows algorithmic consistency]."

---

### Step 3: Score and Summarize

After completing all 10 categories, provide:

**Overall Score: [0-100]**
- 90-100: Reads as fully human-written
- 70-89: Mostly human, minor AI patterns detected
- 50-69: Mixed signals, notable AI patterns
- 30-49: Likely AI-generated with some human editing
- 0-29: Strong AI generation indicators

**Top Findings (ranked by severity):**
List the 3-5 most significant AI detection flags with:
- Category name
- Specific finding with direct quote
- Suggested rewrite

**Passing Elements:**
List 2-3 categories where the content reads most authentically human.

### Step 4: Present Results

Format the output as:

```
## AI Detection Report

**File:** [filename]
**Score:** [X]/100 ([Human/Mixed/AI] signals)
**Verdict:** [One sentence summary]

### Flags (Fix These)
1. [Most critical finding with quote and rewrite suggestion]
2. [Second finding]
3. [Third finding]

### Passing (These Read Human)
1. [Strongest human signal]
2. [Second strongest]

### Full Category Scores
| Category | Score | Notes |
|----------|-------|-------|
| Sentence Structure | X/10 | [brief note] |
| Word Choice | X/10 | [brief note] |
| Coherence | X/10 | [brief note] |
| Logical Reasoning | X/10 | [brief note] |
| Depth/Originality | X/10 | [brief note] |
| Stylistic Voice | X/10 | [brief note] |
| Factual Accuracy | X/10 | [brief note] |
| Contextual Awareness | X/10 | [brief note] |
| Emotional Intelligence | X/10 | [brief note] |
| Technical Indicators | X/10 | [brief note] |
```

### Step 5: Offer Fixes

After presenting the report, ask:
"Want me to fix the flagged issues? I can rewrite the problem sections to read more naturally."
