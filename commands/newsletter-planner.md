# Newsletter Planner

Plan and track newsletter content across platforms.

## Usage

```bash
/newsletter-planner --linkedin    # LinkedIn article planning
/newsletter-planner --claude      # Claude newsletter planning (future)
```

## LinkedIn Newsletter (`--linkedin`)

### Data Location
- **CSV:** `/Users/brent/scripts/CB-Workspace/brent-workspace/newsletters/linkedin-articles.csv`
- **Drafts:** `/Users/brent/scripts/CB-Workspace/brent-workspace/ob-notes/Brent Notes/LinkedIn Articles/`
- **Future Google Sheet:** TBD

### CSV Schema
```csv
id,title,platform,gartner_category,status,publish_date,linkedin_url,notes
```

| Column | Values |
|--------|--------|
| `platform` | Shopify, Magento, BigCommerce, Salesforce Commerce, Adobe Commerce, commercetools, VTEX, Shopware, WooCommerce, PrestaShop, OpenCart, Spryker, SAP Commerce, Oracle Commerce, Elastic Path, Other, N/A |
| `gartner_category` | DXP, E-commerce, Neither |
| `status` | published, scheduled, draft, idea |

### Gartner Magic Quadrant Coverage

**Digital Experience Platforms (DXP) - 2024:**
- Leaders: Adobe, Sitecore, Optimizely, Acquia
- Challengers: Salesforce, SAP
- Visionaries: Contentful, Contentstack, Bloomreach
- Niche: Episerver, Liferay, CoreMedia, Magnolia

**E-commerce Platforms - 2024:**
- Leaders: Salesforce Commerce, Adobe Commerce, commercetools, VTEX
- Challengers: SAP Commerce, BigCommerce
- Visionaries: Shopify Plus, Elastic Path, Spryker
- Niche: Oracle Commerce, Kibo

**Non-Gartner Platforms to Cover:**
- Shopify (standard)
- WooCommerce
- PrestaShop
- OpenCart
- Shopware
- Magento Open Source

### Workflow

1. **Review existing articles:**
   ```bash
   cat /Users/brent/scripts/CB-Workspace/brent-workspace/newsletters/linkedin-articles.csv
   ```

2. **Check coverage gaps:**
   - Which Gartner platforms haven't been covered?
   - Which non-Gartner platforms need articles?

3. **Brainstorm next article:**
   - Pick platform with gap
   - Generate 3-5 angle options
   - User selects angle
   - Create outline

4. **Add to CSV:**
   - Status: `idea` → `draft` → `scheduled` → `published`

### Article Angles (Templates)

- **Platform Deep Dive:** "[Platform] in 2026: What Content Teams Need to Know"
- **Comparison:** "[Platform A] vs [Platform B]: Content Strategy Differences"
- **Migration:** "Migrating Content to [Platform]: Lessons Learned"
- **Integration:** "Connecting [Platform] with Your Content Workflow"
- **Feature Focus:** "[Platform]'s [Feature]: Underrated for Content Teams"

## Claude Newsletter (`--claude`)

**Status:** Future implementation

### Planned Structure
- Weekly Claude tips and workflows
- New feature highlights
- Community discoveries
- Skill/command showcases

---

## Quick Commands

```bash
# Show all LinkedIn articles
/newsletter-planner --linkedin --list

# Show coverage gaps
/newsletter-planner --linkedin --gaps

# Brainstorm for specific platform
/newsletter-planner --linkedin --platform Shopify

# Add new article idea
/newsletter-planner --linkedin --add "Article Title" --platform Magento
```
