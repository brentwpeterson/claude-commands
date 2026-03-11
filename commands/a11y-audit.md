# Accessibility Audit Command

Run a WCAG 2.1 AA accessibility audit on any live URL using Pa11y with axe-core.

**Usage:** `/a11y-audit <url> [--all-pages] [--dark-mode]`

**Flags:**
- `--all-pages` - Audit common subpages (/, /about, /contact, /privacy, /terms)
- `--dark-mode` - Run dark mode audit (Pa11y with dark class injection + static Tailwind analysis)

**Examples:**
- `/a11y-audit https://requestdesk.ai/`
- `/a11y-audit https://yoursite.com/about`
- `/a11y-audit https://yoursite.com --all-pages`
- `/a11y-audit https://talk-commerce.com --dark-mode`
- `/a11y-audit https://requestdesk.ai --all-pages --dark-mode`

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

### Phase 1.5: Pa11y Dark Mode Audit (only with `--dark-mode`)

**Skip this phase entirely if `--dark-mode` flag is not present.**

**Step 1: Detect the dark mode mechanism.**

Find the matching astro-sites directory by grepping for the domain in astro config files:

```bash
grep -rl "DOMAIN_FROM_URL" /Users/brent/scripts/CB-Workspace/astro-sites/sites/*/astro.config.* 2>/dev/null
```

Then check how dark mode is toggled in that site:

```bash
# Check for data-theme pattern (requestdesk-ai uses this)
grep -r 'data-theme' /Users/brent/scripts/CB-Workspace/astro-sites/sites/SITE_DIR/src/ 2>/dev/null | head -5

# Check for .dark class pattern (most sites use this)
grep -r 'classList.*dark\|\.dark ' /Users/brent/scripts/CB-Workspace/astro-sites/sites/SITE_DIR/src/ 2>/dev/null | head -5
```

- If `data-theme="dark"` pattern found: use `document.documentElement.setAttribute('data-theme', 'dark')`
- If `.dark` class pattern found (or no pattern detected, as default): use `document.documentElement.classList.add('dark')`

**Step 2: Run Pa11y in dark mode via Node.js one-liner.**

```bash
node -e "
const pa11y = require('pa11y');
(async () => {
  const results = await pa11y('URL_HERE', {
    runner: 'axe',
    standard: 'WCAG2AA',
    ignoreUrl: true,
    actions: [
      'wait for element body to be visible',
    ],
    browser: {
      executablePath: undefined
    },
    wait: 500,
    beforeScript: async (page) => {
      await page.evaluate(() => {
        DARK_MODE_INJECTION_HERE
      });
      await new Promise(r => setTimeout(r, 300));
    }
  });
  console.log(JSON.stringify(results, null, 2));
})().catch(e => console.error('DARK_PA11Y_ERROR:', e.message));
"
```

Replace `DARK_MODE_INJECTION_HERE` with the detected mechanism:
- `.dark` class: `document.documentElement.classList.add('dark')`
- `data-theme`: `document.documentElement.setAttribute('data-theme', 'dark')`

**Note:** If `pa11y` is not available as a module, fall back to:

```bash
npx pa11y --runner axe --standard WCAG2AA "URL_HERE" \
  --action "wait for element body to be visible" \
  --action "set field body to dark" 2>&1
```

If the Node approach fails entirely, note it in the report:
```
Dark mode Pa11y audit: Could not inject dark mode classes programmatically.
Falling back to static analysis only (Phase 2.5).
```

**Step 3: Compare light vs dark results.**

After both Phase 1 (light) and Phase 1.5 (dark) complete, compare:
- Issues present in BOTH = light mode issues (already caught)
- Issues present ONLY in dark = dark-mode-specific issues (the valuable findings)
- Issues present ONLY in light = issues that dark mode accidentally fixes

Store the dark-mode-only issues separately for reporting.

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

### Dark Mode Audit (if --dark-mode was used)

#### Pa11y Light vs Dark Comparison
| Metric | Light Mode | Dark Mode |
|--------|-----------|-----------|
| Total Issues | X | Y |
| Errors | X | Y |
| Warnings | X | Y |
| Dark-Mode-Only Issues | - | Z |

#### Dark-Mode-Only Issues
[List issues that appear ONLY in dark mode Pa11y results]

#### Static Analysis: Tailwind Dark Coverage
| File | Missing dark: classes | Hardcoded colors | Priority |
|------|----------------------|------------------|----------|
| [file] | X | Y | HIGH/MED |

**Coverage Summary:** X files scanned, Y files with gaps, Z total missing dark: classes
```

---

### Phase 2.5: Static Analysis of Tailwind Dark Coverage (only with `--dark-mode`)

**Skip this phase entirely if `--dark-mode` flag is not present.**
**Also skip if no matching site directory was found in Phase 1.5.**

**Step 1: Find the site's source directory.**

Use the site directory detected in Phase 1.5. Scan all `.astro`, `.jsx`, `.tsx`, and `.css` files in `src/`:

```bash
find /Users/brent/scripts/CB-Workspace/astro-sites/sites/SITE_DIR/src -type f \( -name "*.astro" -o -name "*.jsx" -o -name "*.tsx" -o -name "*.css" \) 2>/dev/null
```

**Step 2: Check for missing dark: counterparts in template files (.astro, .jsx, .tsx).**

For each file, look for color utility classes that lack a `dark:` counterpart on the same element:

| Light Class Pattern | Expected Dark Counterpart | Priority |
|---------------------|---------------------------|----------|
| `bg-white`, `bg-gray-*`, `bg-slate-*` etc. | `dark:bg-*` on same element | HIGH |
| `text-gray-*`, `text-slate-*`, `text-black` etc. | `dark:text-*` on same element | HIGH |
| `border-gray-*`, `border-slate-*` etc. | `dark:border-*` on same element | MEDIUM |
| `divide-gray-*` etc. | `dark:divide-*` on same element | MEDIUM |

**Filter out false positives. Do NOT flag these:**
- Classes using CSS variables / semantic tokens: `bg-background`, `text-foreground`, `bg-primary`, `text-muted-foreground` (these adapt automatically via CSS custom properties)
- Opacity modifiers on universal colors: `bg-black/5`, `bg-white/10` (transparent overlays work in both modes)
- Utility classes that don't involve color: `bg-clip-text`, `bg-gradient-to-r`
- Elements that already have a `dark:` variant for that property on the same line/element
- Classes inside `dark:` prefixes themselves

**Step 3: Check CSS files for hardcoded colors and missing .dark selectors.**

```bash
# Find CSS custom properties defined in :root
grep -n ':root' SITE_DIR/src/**/*.css

# Check if those same properties exist inside a .dark selector or [data-theme="dark"]
grep -n '\.dark\|data-theme.*dark' SITE_DIR/src/**/*.css
```

Flag:
- Hex colors (`#xxx`, `#xxxxxx`) used outside of CSS custom property definitions and not inside a `.dark` or `[data-theme="dark"]` selector
- CSS custom properties defined in `:root` that have no override in `.dark` / `[data-theme="dark"]`

**Step 4: Generate coverage summary.**

Group findings by file:

```
### Dark Mode Coverage Analysis

| File | Missing dark: classes | Hardcoded colors | Priority |
|------|----------------------|------------------|----------|
| src/components/Hero.astro | 3 (bg, text, border) | 0 | HIGH |
| src/pages/index.astro | 1 (text) | 0 | MEDIUM |
| src/styles/global.css | 0 | 2 hex colors | HIGH |

**Summary:** X files scanned, Y files with gaps, Z total missing dark: classes
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

**If `--dark-mode` was used, also group dark-mode-specific patterns:**

```
### Dark Mode Pattern 1: Missing dark:text-* on body copy (12 elements)
**Issue:** Text color likely invisible or low contrast in dark mode
**Affected:** p, span elements with text-gray-700 but no dark: variant
**Source:** Phase 2.5 static analysis + Phase 1.5 Pa11y confirmation

### Dark Mode Pattern 2: Hardcoded background colors in CSS (3 files)
**Issue:** #ffffff backgrounds not overridden in .dark selector
**Affected:** global.css, hero.css
**Source:** Phase 2.5 static analysis
```

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

### Phase 7: Save Audit Document to Obsidian

**MANDATORY. Always save the full audit report as a markdown file.**

**Step 1: Determine the site name from the URL.**

Extract the domain (e.g., `talk-commerce.com` becomes `Talk Commerce`, `requestdesk.ai` becomes `RequestDesk`).

**Step 2: Determine the correct Obsidian folder.**

The audit folder follows this pattern:
```
brent-workspace/ob-notes/Brent Notes/Sales and Marketing/Company Websites/[SITE NAME]/Audits/
```

Map known sites:
- `talk-commerce.com` -> `Talk Commerce`
- `requestdesk.ai` -> `RequestDesk`
- `contentbasis.ai` -> `Content Basis`
- `contentcucumber.com` -> `Content Cucumber`
- `brent.run` -> `Brent Run`
- `eovoices.com` -> `EO Voices`

If the folder doesn't exist, create it.

**Step 3: Write the file.**

Filename: `YYYY-MM-DD-a11y-audit[--dark-mode].md`
- Include `--dark-mode` suffix only if `--dark-mode` flag was used
- Example: `2026-03-04-a11y-audit.md` or `2026-03-04-a11y-audit--dark-mode.md`

**Step 4: Include all audit data in the file.**

The file must contain:
- URL, standard, tool, date, flags used
- Summary table (errors/warnings by mode)
- Errors by category table
- All patterns identified (with root cause and recommended fix)
- Dark mode sections (if `--dark-mode` was used): Pa11y comparison, static analysis coverage, dark-mode-only issues
- False positives excluded (with reasoning)
- Quick wins list
- Re-test commands

**Step 5: Confirm the save location to the user.**

Always tell the user where the file was saved so they can find it in Obsidian.

---

## Dark Mode Checklist

**If `--dark-mode` flag was used:** Phases 1.5 and 2.5 automate most of these checks. Review the automated report first, then use this checklist for anything automation can't catch.

**If `--dark-mode` flag was NOT used:** Manually check these patterns:

| Element | Common Problem | Fix |
|---------|----------------|-----|
| Gray text | gray-400 too dark | Use gray-300 or gray-200 |
| Accent colors | Pink/purple/cyan fail on dark | Lighten to -200/-300 variants |
| Links in text | No underline, only color | Add text-decoration: underline |
| Focus rings | Invisible on dark backgrounds | Use visible ring color |
| Buttons | Light bg + white text fails | Flip to dark text |
| CSS custom properties | :root values not overridden in .dark | Add .dark selector with dark variants |
| Hardcoded hex colors | #ffffff / #000000 in CSS not theme-aware | Use CSS variables or add .dark overrides |
| Semantic tokens | bg-background/text-foreground not defined for dark | Ensure CSS vars change in .dark context |

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
