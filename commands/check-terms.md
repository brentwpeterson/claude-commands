# Check Content Terms Command

Scan content files (CSV, text, markdown) against the RequestDesk content terms API to identify overused/avoid terms, recommended terms, and conditional terms.

**Usage:** `/check-terms <file-path>` or `/check-terms <text>`

**Examples:**
- `/check-terms /path/to/content.csv`
- `/check-terms file:101-blog-writing.csv`
- `/check-terms "Check this text for any content guideline issues"`

---

## API Configuration

**Public Endpoint (no auth required):**
- URL: `https://app.requestdesk.ai/api/public/content-terms`
- Method: GET
- Returns: List of terms with type, context, and occurrence_count
- Rate Limit: 60 requests/minute

**Authenticated Endpoint (if Plugin API Key available):**
- URL: `https://app.requestdesk.ai/api/typingmind/proxy/terms-checker`
- Method: POST
- Auth: Bearer token
- Features: Full text analysis with violation detection

---

## Instructions for Claude

### Phase 1: Input Detection

Determine the input type:

1. **File Path** (contains `/` or ends with `.csv`, `.txt`, `.md`):
   - Read the file content
   - For CSV: Extract text from relevant columns (skip headers, IDs, slugs)
   - For text/markdown: Use full content

2. **Direct Text** (quoted or plain text):
   - Use the provided text directly

3. **List Mode** (special keywords):
   - `avoidlist` - Show all terms to avoid
   - `uselist` - Show recommended terms
   - `conditionallist` - Show conditional terms
   - `alllist` - Show all terms

---

### Phase 2: Fetch Terms List

Fetch the current terms list from the public API:

```bash
curl -s "https://app.requestdesk.ai/api/public/content-terms" | jq
```

**Expected Response Structure:**
```json
{
  "terms": [
    {
      "term": "I just",
      "type": "avoid",
      "context": "Filler phrase that weakens professional content",
      "tags": ["filler", "casual"],
      "occurrence_count": 45
    },
    {
      "term": "streamline",
      "type": "use",
      "context": "Professional term for efficiency",
      "tags": ["business", "recommended"],
      "occurrence_count": 12
    },
    {
      "term": "leverage",
      "type": "conditional",
      "context": "OK in business context, overused otherwise",
      "condition": "Use only in formal business writing",
      "tags": ["business", "conditional"],
      "occurrence_count": 30
    }
  ]
}
```

---

### Phase 3: Content Analysis

For each term in the terms list, check if it appears in the content:

**Matching Rules:**
1. Case-insensitive matching
2. Word boundary aware (don't match partial words unless the term is a phrase)
3. Count occurrences for each found term
4. Track the context where each term appears (surrounding text)

**Term Types:**
- **Avoid** (`type: "avoid"`): Terms that should NOT be in content - flag as violations
- **Use** (`type: "use"`): Recommended terms - check if present, suggest if missing
- **Conditional** (`type: "conditional"`): Context-dependent - flag for review with condition

---

### Phase 4: Generate Report

Format the analysis results:

```
## Content Terms Analysis

**File:** [filename or "Direct text"]
**Content Length:** [word count] words
**Analysis Date:** [date]

---

### VIOLATIONS FOUND

[if avoid terms found]
| Term | Occurrences | Context | Recommendation |
|------|-------------|---------|----------------|
| "[term]" | [count] | "[excerpt where found]" | [context from API] |

[if no violations]
No avoid terms found in content.

---

### CONDITIONAL TERMS (Review Required)

[if conditional terms found]
| Term | Occurrences | Found In | Condition |
|------|-------------|----------|-----------|
| "[term]" | [count] | "[excerpt]" | [condition from API] |

[if none]
No conditional terms found.

---

### RECOMMENDED TERMS USED

[if use terms found]
| Term | Occurrences |
|------|-------------|
| "[term]" | [count] |

---

### RECOMMENDED TERMS MISSING

[if use terms NOT found - limit to top 5 most relevant]
Consider incorporating these terms:
- "[term]" - [context]
- "[term]" - [context]

---

### SUMMARY

| Metric | Count |
|--------|-------|
| Violations (Avoid Terms) | [count] |
| Conditional (Review) | [count] |
| Recommended Used | [count] |
| Suggestions | [count] |

**Overall Score:** [PASS/REVIEW/FAIL]
- PASS: 0 violations, 0 conditional
- REVIEW: 0 violations but has conditional terms
- FAIL: Has violations
```

---

### Phase 5: CSV-Specific Handling

When checking CSV files, apply these rules:

**Columns to CHECK (contain content):**
- `title`, `headline`, `name`
- `description`, `meta_description`
- `content`, `body`, `text`
- `tagline`, `excerpt`, `summary`
- `faq_*`, `question_*`, `answer_*`
- Any column with substantial text (>20 characters)

**Columns to SKIP (not content):**
- `id`, `slug`, `url`, `permalink`
- `date`, `created`, `modified`
- `status`, `type`, `category`
- `image`, `icon`, `thumbnail`
- Any column that's clearly a path/URL/ID

**CSV Processing:**
1. Parse CSV and identify content columns
2. Combine all content columns into analysis text
3. Report which columns were analyzed
4. Show violations by column if possible

---

### Phase 6: Quick Fixes (Optional)

If violations are found and user wants to fix:

```
## Suggested Replacements

| Original | Suggested Replacement |
|----------|----------------------|
| "I just wanted to..." | "We can..." |
| "very unique" | "unique" |
| "in order to" | "to" |

Would you like me to apply these fixes to the file? (yes/no)
```

Only offer automated fixes for clear-cut avoid terms with obvious replacements.

---

## Term Type Reference

### Common Avoid Terms (Examples)
- Filler phrases: "I just", "really", "very", "actually"
- Redundant phrases: "in order to", "due to the fact that"
- Weak language: "sort of", "kind of", "maybe"
- Cliches: "at the end of the day", "think outside the box"

### Common Use Terms (Examples)
- Professional: "streamline", "optimize", "enhance"
- Action-oriented: "achieve", "implement", "deliver"
- Clear language: "because", "so", "therefore"

### Common Conditional Terms (Examples)
- Business jargon (OK in B2B): "leverage", "synergy", "scalable"
- Technical terms (OK in tech content): "utilize", "facilitate"
- Formal terms (OK in legal/formal): "herein", "aforementioned"

---

## Arguments

- `<file-path>` - Path to CSV, TXT, or MD file to analyze
- `<text>` - Direct text content to check (in quotes)
- `avoidlist` - Show all terms to avoid
- `uselist` - Show recommended terms
- `conditionallist` - Show conditional terms
- `alllist` - Show all terms organized by type

---

## Notes

- Public API has 60 req/min rate limit
- Term list is company-specific (based on Content Cucumber usage data)
- Occurrence counts in term list reflect historical usage across all content
- For large files, consider chunking analysis
- Always show context around found terms to help with review
