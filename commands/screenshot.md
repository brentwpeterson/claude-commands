# Screenshot Capture & Analysis Command

Capture screenshots of web pages using Playwright MCP and analyze them with Claude's vision capabilities.

**Usage:** `/screenshot <url> [options]`

**Examples:**
- `/screenshot http://localhost:3003` - Capture homepage
- `/screenshot http://localhost:3003 --fullpage` - Full page screenshot
- `/screenshot http://localhost:3003 --analyze "check spacing between sections"`
- `/screenshot https://requestdesk.ai/ --compare http://localhost:3003` - Compare prod vs dev

---

## Instructions for Claude

When this command is run, use the **Playwright MCP tools** to capture and analyze screenshots.

### Prerequisites

Playwright MCP must be installed:
```bash
claude mcp add playwright npx @playwright/mcp@latest
```

---

### Phase 1: Capture Screenshot

**Use Playwright MCP tools in this order:**

1. **Navigate to URL:**
   Use `browser_navigate` tool with the target URL

2. **Wait for page load:**
   Use `browser_wait` or check for key elements

3. **Take screenshot:**
   Use `browser_screenshot` tool
   - Default: viewport screenshot
   - With `--fullpage`: full page screenshot

**Available Playwright MCP Tools:**
- `browser_navigate` - Go to URL
- `browser_screenshot` - Capture current page
- `browser_click` - Click elements
- `browser_type` - Enter text
- `browser_wait` - Wait for elements
- `browser_evaluate` - Run JavaScript

---

### Phase 2: Display Screenshot

After capturing, the screenshot will be returned as base64.

**Present to user:**
```
## Screenshot Captured

**URL:** [url]
**Viewport:** [width]x[height]
**Type:** [viewport/fullpage]
**Captured:** [timestamp]

[Screenshot displayed inline]
```

---

### Phase 3: Analyze (if --analyze flag)

When `--analyze "prompt"` is provided:

1. Examine the screenshot using vision capabilities
2. Focus on the specific analysis requested
3. Provide detailed observations

**Common analysis prompts:**
- "check spacing between sections"
- "verify mobile responsiveness"
- "identify layout issues"
- "check text readability"
- "find broken images or elements"
- "verify color contrast"

**Analysis output format:**
```
## Screenshot Analysis

**Focus:** [user's analysis prompt]

### Observations
1. [Finding 1]
2. [Finding 2]
3. [Finding 3]

### Issues Found
| Issue | Location | Severity | Suggested Fix |
|-------|----------|----------|---------------|
| [issue] | [where] | [High/Med/Low] | [fix] |

### Recommendations
- [Actionable recommendation 1]
- [Actionable recommendation 2]
```

---

### Phase 4: Compare (if --compare flag)

When `--compare <url2>` is provided:

1. Take screenshot of first URL
2. Take screenshot of second URL
3. Compare both screenshots side-by-side
4. Identify differences

**Comparison output:**
```
## Screenshot Comparison

**URL 1:** [first url]
**URL 2:** [second url]

### Visual Differences
1. [Difference 1]
2. [Difference 2]

### Layout Comparison
| Element | URL 1 | URL 2 | Match? |
|---------|-------|-------|--------|
| Header | [state] | [state] | ✓/✗ |
| Hero | [state] | [state] | ✓/✗ |
| Footer | [state] | [state] | ✓/✗ |

### Conclusion
[Summary of whether they match or key differences]
```

---

### Phase 5: Interactive Mode

If user wants to interact with the page before screenshot:

1. Use `browser_click` to click elements
2. Use `browser_type` to fill forms
3. Use `browser_scroll` to scroll to sections
4. Then capture screenshot

**Example workflow:**
```
User: /screenshot http://localhost:3003 --scroll-to "#features"

1. Navigate to URL
2. Scroll to #features section
3. Capture screenshot of that viewport
4. Display result
```

---

## Device Emulation

**Mobile screenshot:**
```
/screenshot http://localhost:3003 --mobile
```
Uses mobile viewport (375x667 iPhone SE)

**Tablet screenshot:**
```
/screenshot http://localhost:3003 --tablet
```
Uses tablet viewport (768x1024 iPad)

**Custom viewport:**
```
/screenshot http://localhost:3003 --viewport 1920x1080
```

---

## Saving Screenshots

Screenshots can be saved to project directory:

```
/screenshot http://localhost:3003 --save homepage.png
```

Saves to: `./screenshots/homepage.png`

---

## Integration with Other Commands

**Use with /lighthouse:**
```
/screenshot http://localhost:3003 --analyze "identify performance bottlenecks visible in layout"
/lighthouse http://localhost:3003
```

**Use with /a11y-audit:**
```
/screenshot http://localhost:3003 --analyze "check color contrast and text sizes"
/a11y-audit http://localhost:3003
```

**Use with /seo-audit:**
```
/screenshot http://localhost:3003 --analyze "verify heading hierarchy and content structure"
/seo-audit http://localhost:3003
```

---

## Troubleshooting

**If Playwright MCP not responding:**
1. Check MCP is installed: `claude mcp list`
2. Restart Claude Code to reload MCP servers
3. Verify with: `claude mcp add playwright npx @playwright/mcp@latest`

**If page doesn't load:**
1. Check URL is accessible
2. Ensure dev server is running
3. Try with explicit wait: `/screenshot http://localhost:3003 --wait 3000`

**If screenshot is blank:**
1. Page may still be loading - use `--wait`
2. Check for JavaScript errors
3. Try fullpage mode: `--fullpage`

---

## Quick Reference

| Flag | Description |
|------|-------------|
| `--fullpage` | Capture entire page (scrolled) |
| `--mobile` | Mobile viewport (375x667) |
| `--tablet` | Tablet viewport (768x1024) |
| `--viewport WxH` | Custom viewport |
| `--analyze "..."` | Analyze with prompt |
| `--compare <url>` | Compare two URLs |
| `--save <file>` | Save to file |
| `--wait <ms>` | Wait before capture |
| `--scroll-to <sel>` | Scroll to element first |
