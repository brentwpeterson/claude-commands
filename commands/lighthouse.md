# Lighthouse Performance Audit Command

Run a Google Lighthouse audit on any URL to measure Performance, Accessibility, Best Practices, and SEO.

**Usage:** `/lighthouse <url>`

**Examples:**
- `/lighthouse http://localhost:3003`
- `/lighthouse https://requestdesk.ai/`
- `/lighthouse https://requestdesk.ai/ --full`

---

## Instructions for Claude

When this command is run, follow this workflow:

### IMPORTANT: ARM64 Mac Compatibility

On Apple Silicon Macs, use the arm64 node explicitly to avoid Rosetta issues:
```bash
/opt/homebrew/bin/node /opt/homebrew/bin/lighthouse <URL> ...
```

### Phase 1: Run Lighthouse Audit

**Quick audit (scores only):**
```bash
/opt/homebrew/bin/node /opt/homebrew/bin/lighthouse <URL> --chrome-flags="--headless" --output json --quiet 2>/dev/null | jq '{
  performance: (.categories.performance.score * 100 | round),
  accessibility: (.categories.accessibility.score * 100 | round),
  bestPractices: (.categories["best-practices"].score * 100 | round),
  seo: (.categories.seo.score * 100 | round)
}'
```

**Full audit with metrics (if `--full` flag):**
```bash
lighthouse <URL> --chrome-flags="--headless" --output json --output-path /tmp/lighthouse-report.json --quiet 2>/dev/null

# Extract key metrics
cat /tmp/lighthouse-report.json | jq '{
  scores: {
    performance: (.categories.performance.score * 100 | round),
    accessibility: (.categories.accessibility.score * 100 | round),
    bestPractices: (.categories["best-practices"].score * 100 | round),
    seo: (.categories.seo.score * 100 | round)
  },
  metrics: {
    FCP: .audits["first-contentful-paint"].displayValue,
    LCP: .audits["largest-contentful-paint"].displayValue,
    TBT: .audits["total-blocking-time"].displayValue,
    CLS: .audits["cumulative-layout-shift"].displayValue,
    SI: .audits["speed-index"].displayValue
  }
}'
```

**If Lighthouse is not installed:**
```bash
npm install -g lighthouse
```

---

### Phase 2: Present Results

**Display scores in table format:**

```
## Lighthouse Audit Results

**URL:** [tested URL]
**Date:** [current date]
**Device:** Mobile (Lighthouse default)

### Scores
| Category | Score | Status |
|----------|-------|--------|
| Performance | XX | [color indicator] |
| Accessibility | XX | [color indicator] |
| Best Practices | XX | [color indicator] |
| SEO | XX | [color indicator] |

**Score Key:** 90-100 = Green, 50-89 = Orange, 0-49 = Red
```

---

### Phase 3: Core Web Vitals (Full audit only)

**Present Core Web Vitals:**

```
### Core Web Vitals
| Metric | Value | Target | Status |
|--------|-------|--------|--------|
| FCP (First Contentful Paint) | X.Xs | <1.8s | [status] |
| LCP (Largest Contentful Paint) | X.Xs | <2.5s | [status] |
| TBT (Total Blocking Time) | Xms | <200ms | [status] |
| CLS (Cumulative Layout Shift) | X.XX | <0.1 | [status] |
| Speed Index | X.Xs | <3.4s | [status] |
```

**Status indicators:**
- **Good**: FCP <1.8s, LCP <2.5s, TBT <200ms, CLS <0.1
- **Needs Improvement**: FCP 1.8-3s, LCP 2.5-4s, TBT 200-600ms, CLS 0.1-0.25
- **Poor**: Exceeds above thresholds

---

### Phase 4: Identify Issues

**If performance < 90, extract opportunities:**
```bash
cat /tmp/lighthouse-report.json | jq '.audits | to_entries | map(select(.value.score != null and .value.score < 1 and .value.details.type == "opportunity")) | .[].value | {title, displayValue, description}' 2>/dev/null
```

**Common performance issues to flag:**

| Issue | Impact | Quick Fix |
|-------|--------|-----------|
| Render-blocking resources | HIGH | Defer non-critical CSS/JS |
| Unoptimized images | HIGH | Use WebP, proper sizing |
| Large DOM size | MEDIUM | Simplify HTML structure |
| Unused CSS/JS | MEDIUM | Tree-shake, code-split |
| No text compression | HIGH | Enable gzip/brotli |
| Layout shifts | HIGH | Set explicit dimensions |

---

### Phase 5: Generate HTML Report (Optional)

**If user wants detailed report:**
```bash
lighthouse <URL> --chrome-flags="--headless" --output html --output-path ./lighthouse-report.html --quiet
echo "Report saved to: ./lighthouse-report.html"
open ./lighthouse-report.html  # macOS
```

---

### Phase 6: Recommendations

**Always end with prioritized recommendations:**

```
## Recommendations (Priority Order)

### High Priority (Biggest Impact)
1. [Issue] - [specific fix]
2. [Issue] - [specific fix]

### Medium Priority
3. [Issue] - [specific fix]

### Quick Wins
- [Easy fix that improves score]
- [Another easy fix]

## Re-Test Command
```bash
lighthouse <URL> --chrome-flags="--headless" --output json --quiet 2>/dev/null | jq '.categories | to_entries | map({(.key): (.value.score * 100 | round)}) | add'
```
```

---

## Desktop vs Mobile

Lighthouse defaults to mobile. For desktop audit:
```bash
lighthouse <URL> --chrome-flags="--headless" --preset desktop --output json --quiet
```

---

## Comparison Testing

**Before/After comparison:**
```bash
# Save baseline
lighthouse <URL> --chrome-flags="--headless" --output json --output-path /tmp/baseline.json --quiet

# After changes
lighthouse <URL> --chrome-flags="--headless" --output json --output-path /tmp/after.json --quiet

# Compare
echo "Before:"
cat /tmp/baseline.json | jq '.categories.performance.score * 100 | round'
echo "After:"
cat /tmp/after.json | jq '.categories.performance.score * 100 | round'
```

---

## Resources

- [web.dev/measure](https://web.dev/measure/) - Online Lighthouse
- [Core Web Vitals](https://web.dev/vitals/)
- [Lighthouse Scoring Calculator](https://googlechrome.github.io/lighthouse/scorecalc/)
- [PageSpeed Insights](https://pagespeed.web.dev/) - Production testing
