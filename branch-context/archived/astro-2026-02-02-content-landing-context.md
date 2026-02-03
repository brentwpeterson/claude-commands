# Resume Instructions for Claude

## IMMEDIATE SETUP
1. **Directory:** `cd /Users/brent/scripts/CB-Workspace/astro-sites/sites/dreamers-inc`
2. **Identity:** Claude-Copernicus
3. **Branch:** `git checkout master`
4. **Last Commit:** `90b9b5d Content Cucumber landing: full page build with all sections`
5. **Verify:** `git status`
6. **Dev Server:** `npm run dev` (port 4325)

## WORKSPACES TOUCHED
| Shortcode | What was done |
|-----------|---------------|
| astro | Built full Content Cucumber landing page at sites/dreamers-inc/ |

## WHAT YOU WERE WORKING ON
Building a full single-page landing site for Content Cucumber at `sites/dreamers-inc/` for `yourdream.contentcucumber.com`. Started from a three-column hero (previous session), then expanded to a complete multi-section page.

### Page Sections (top to bottom)
1. **Hero (three-column grid):** Green hero left (headline + subline + CTA) | White center (logo, "Your Story, Your Words," body copy, 2 numbered items, vine SVG) | Pale yellow right (rotating quotes, tendril SVG)
2. **How It Works:** 3-step process cards (Listen, Match, Create) with SVG icons
3. **Stats Bar:** Green bar with 60,000+ projects, 55M+ words, 4.9/5 rating
4. **Services Grid:** 6 cards (Blog Writing, Product Descriptions, Email Marketing, SEO Content, Social Media, Website Copy) with hover accent animations
5. **Case Study:** Silicone Depot (500 to 10,000+ visitors) with bar chart visualization
6. **Trusted By:** Adobe, HubSpot, eTail, Shopware, ShopTalk (text logos)
7. **Features Strip:** 5 icons (Powered by People, Fast Onboarding, Reliable Delivery, Content Intelligence, Flexible Plans)
8. **Contact Section:** Green background, two-field form ("Who are you?" + "What are you building?")
9. **Footer:** Text wordmark, tagline, links, copyright

### Design Details
- **Brand colors:** `#58c558` green, `#fffad4` pale yellow, `#effbe1` light green, `#575760` dark, `#74786f` gray
- **Fonts:** Nunito (headings, weight 900), Rubik (body, weight 400)
- **Logo:** PNG at `public/logo.png`, sized clamp(220px, 26vw, 340px)
- **Rotating quotes:** 6 famous quotes (Leo Burnett, Tom Fishburne, Simon Sinek, Ann Handley, Benjamin Franklin, Rudyard Kipling) randomized on each page load via client-side JS
- **Animations:** Hero elements have CSS entrance animations; below-fold sections use IntersectionObserver scroll-triggered reveals with staggered delays
- **Brand persona loaded:** Content Cucumber brand from RequestDesk API, audited all copy

### Body Copy (Option C - playful voice)
"Want to hear something radical? We use human beings to write your content. Revolutionary, we know..."

### Hero Subline
"Human beings writing content for human beings." with italic emphasis on both "human" words in pale yellow, separated from headline by thin white border-top line

## CURRENT STATE
- **Build:** Passes cleanly (`npm run build`)
- **Dev server:** Was running on port 4325 (background task, may need restart)
- **Semrush references:** Removed per brand review
- **Brand audit:** Passed (fixed one "actually" violation)
- **Footer:** Uses text wordmark instead of logo image (inversion filter didn't work cleanly on transparent PNG)

## NEXT ACTIONS
1. **FIRST:** User may want to refine copy, adjust design, or review sections
2. **THEN:** Add nginx config block for `yourdream.contentcucumber.com` to shared nginx.conf
3. **THEN:** Add Dockerfile build stage for dreamers-inc site
4. **VERIFY:** Test build in Docker container before deploying
5. **CONSIDER:** Rename directory from `dreamers-inc` to `content-cucumber-landing` if desired

## CONTEXT NOTES
- The site directory is named `dreamers-inc` from the original design reference (thedreamers.us). All content is Content Cucumber branded.
- The contact form action points to `https://contentcucumber.com/contact` as a GET redirect (placeholder - may need a real form handler)
- Canva MCP brand kit (ID: kAGk8LegUXI) exists but couldn't extract colors/fonts from API. Brand colors were pulled from the live contentcucumber.com CSS.
- The original Dreamers site structure was used as a layout reference (three-column hero, process steps, portfolio, trust bar, contact form, footer).
