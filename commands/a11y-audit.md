# Accessibility Audit Command

Run a WCAG 2.1 AA accessibility audit on any live URL using Pa11y with axe-core.

**Usage:** `/a11y-audit <url>`

**Examples:**
- `/a11y-audit https://requestdesk.ai/`
- `/a11y-audit https://yoursite.com/about`
- `/a11y-audit https://yoursite.com --all-pages`

---

## Instructions for Claude

When this command is run, follow this workflow:

### Phase 1: Run Pa11y Audit

**Single page audit:**
```bash
pa11y --runner axe --standard WCAG2AA <URL> 2>&1
```

**If `--all-pages` flag is present, run on common pages:**
```bash
for page in "" "/about" "/contact" "/privacy" "/terms"; do
  echo "=== $page ==="
  pa11y --runner axe --standard WCAG2AA "<BASE_URL>$page" 2>&1 | grep -E "^Error:|^Warning:" | head -20
  echo ""
done
```

**If Pa11y is not installed:**
```bash
# Try with npx first (no install needed)
npx pa11y --runner axe --standard WCAG2AA <URL>

# If that fails, provide install instructions:
# npm install -g pa11y
```

---

### Phase 2: Parse and Categorize Results

**Group errors by type:**

| Category | WCAG Criteria | Priority |
|----------|---------------|----------|
| Color Contrast | 1.4.3 Contrast (Minimum) | HIGH |
| Missing Alt Text | 1.1.1 Non-text Content | HIGH |
| Empty Links/Buttons | 2.4.4 Link Purpose | HIGH |
| Missing Form Labels | 1.3.1 Info and Relationships | HIGH |
| Focus Not Visible | 2.4.7 Focus Visible | MEDIUM |
| Keyboard Inaccessible | 2.1.1 Keyboard | HIGH |
| Missing Language | 3.1.1 Language of Page | LOW |
| Frame Tested | N/A (third-party) | SKIP |

**Present results in this format:**
```
## Accessibility Audit Results

**URL:** [tested URL]
**Standard:** WCAG 2.1 Level AA
**Tool:** Pa11y with axe-core runner
**Date:** [current date]

### Summary
| Page | Errors | Warnings |
|------|--------|----------|
| /    | X      | X        |

### Errors by Category
| Category | Count | Priority |
|----------|-------|----------|
| Color Contrast | X | HIGH |
| [etc.] | | |

### Detailed Findings
[List each unique error pattern with affected elements]
```

---

### Phase 3: Identify Patterns vs. Individual Errors

**IMPORTANT:** Don't just list 29 errors. Group them by pattern.

Example:
```
### Pattern 1: gradient-text Class (5 elements)
**Issue:** Color contrast - text color is transparent
**Affected:** All h1/h2 elements with .gradient-text class
**Root Cause:** CSS background-clip: text technique

### Pattern 2: text-offset Color (8 elements)
**Issue:** Color contrast - gray too dark on dark background
**Affected:** p.text-offset elements
**Root Cause:** gray-400 on #0a0a0a background
```

This helps the user understand they have 2 problems to fix, not 13.

---

### Phase 4: Generate Fix Recommendations

**For Color Contrast issues:**
```
## Fix: Color Contrast

**Current:** [color] on [background] = [ratio]:1
**Required:** 4.5:1 for normal text, 3:1 for large text (18px+)

**Options:**
1. Lighten text color (e.g., gray-400 → gray-200)
2. Darken background
3. Increase font size to qualify as "large text"
4. Add font-weight: bold (helps perception)

**Recommended CSS change:**
[Specific CSS suggestion based on the element]
```

**For gradient-text / background-clip issues:**
```
## Fix: Gradient Text Accessibility

**The Problem:**
background-clip: text with transparent text color creates visually readable
gradients but automated tools see 0:1 contrast ratio.

**Options:**
1. **Accept & Document** - Visual contrast is good, document as known limitation
2. **Add fallback color** - Add a solid color fallback for accessibility tools
3. **Screen reader text** - Add aria-label or visually-hidden text
4. **Replace gradient** - Use solid color (safest for compliance)

**Recommended approach:** Option 2 or 3 - keeps design, improves actual accessibility
```

**For missing alt text:**
```
## Fix: Missing Alt Text

**Affected elements:**
- img[src="..."] - missing alt attribute

**Fix:**
<img src="..." alt="Descriptive text about the image">

**Guidelines:**
- Decorative images: alt=""
- Informative images: Describe the content/function
- Complex images: Consider aria-describedby for longer descriptions
```

**For form labels:**
```
## Fix: Missing Form Labels

**Affected elements:**
- input#email - no associated label

**Fix options:**
1. Explicit label: <label for="email">Email</label><input id="email">
2. Implicit label: <label>Email <input></label>
3. aria-label: <input aria-label="Email address">
```

---

### Phase 5: Create Backlog File (If requested or >10 errors)

If the audit finds significant issues, offer to create a backlog file:

```
Would you like me to create an accessibility backlog file at:
.claude/accessibility/wcag-2.1-aa-backlog.md

This will document:
- All issues found with priority
- Fix options for each pattern
- Commands to re-run the audit
- Related files to modify
```

**Backlog file structure:**
```markdown
# WCAG 2.1 AA Accessibility Backlog

**Target Standard**: WCAG 2.1 Level AA
**Audit Tool**: Pa11y with axe-core runner
**Last Audit**: [date]
**Status**: [In Progress / Backlogged]

---

## Summary
| Page | Errors | Priority |
|------|--------|----------|

---

## Issue Categories

### 1. [Issue Name]
**Type**: [WCAG criterion]
**Severity**: [High/Medium/Low]
**Affected Elements**: [list]
**Technical Cause**: [explanation]
**Fix Options**:
- [ ] Option 1
- [ ] Option 2

---

## Commands to Re-Run Audit
[pa11y commands]

## Related Files
[list of CSS/component files to modify]
```

---

### Phase 6: Quick Wins Report

Always end with actionable quick wins:

```
## Quick Wins (Fix These First)

1. **[Easiest fix]** - [one-line description]
   ```css
   [specific code change]
   ```

2. **[Second easiest]** - [one-line description]

3. **[Third]** - [one-line description]

## Re-Test Command
After fixes, run:
```bash
pa11y --runner axe --standard WCAG2AA <URL>
```
```

---

## Dark Mode Checklist

If the site uses dark mode, always check these specific patterns:

| Element | Common Problem | Fix |
|---------|----------------|-----|
| Gray text | gray-400 too dark | Use gray-300 or gray-200 |
| Accent colors | Pink/purple/cyan fail on dark | Lighten to -200/-300 variants |
| Links in text | No underline, only color | Add text-decoration: underline |
| Focus rings | Invisible on dark backgrounds | Use visible ring color |
| Buttons | Light bg + white text fails | Flip to dark text |

---

## Common False Positives

Document these if encountered:

| Issue | Why It's Flagged | Reality |
|-------|------------------|---------|
| gradient-text | Transparent text color | Visually readable gradient |
| Third-party iframes | Can't test inside iframe | Not your responsibility |
| Dynamic backgrounds | Can't calculate contrast | May need manual review |

---

## Additional Manual Checks

Automated tools catch ~30-50% of issues. Recommend these manual tests:

```
### Manual Testing Checklist
- [ ] Tab through entire page - can reach all interactive elements?
- [ ] Zoom to 200% - does layout break?
- [ ] Screen reader test (VoiceOver: Cmd+F5 on Mac)
- [ ] Check focus order makes logical sense
- [ ] Verify skip-to-content link exists
- [ ] Test with browser in high contrast mode
```

---

## Resources

- [WCAG 2.1 Quick Reference](https://www.w3.org/WAI/WCAG21/quickref/)
- [WebAIM Contrast Checker](https://webaim.org/resources/contrastchecker/)
- [Axe DevTools Browser Extension](https://www.deque.com/axe/devtools/)
- [The A11Y Project Checklist](https://www.a11yproject.com/checklist/)
- [Pa11y Documentation](https://pa11y.org/)
