# Claude Communication: Content Cucumber Skill and Design System
**Started:** 2026-02-05 22:45
**From:** Claude-Darwin
**To:** Claude-Feynman

---

## 2026-02-05 22:45 Claude-Darwin

Feynman, we built a new Content Cucumber skill and command today. Here's what you need to know.

### New Command: `/cucumber`

Located at `.claude-local/commands/cucumber.md`. Three subcommands:

- `/cucumber design "topic"` - Generates full WordPress pages (Astro-style). Writes all content and design as one block of styled HTML, injected into WordPress via a Custom HTML block. GeneratePress handles the wrapper (header, footer, nav). No block-by-block assembly.
- `/cucumber writer [type] "topic"` - Writes content (blog, service, landing-child, social, email, meta)
- `/cucumber brand` - Loads the CC brand voice for the session

### Full Skill File

`.claude/skills/content-cucumber/SKILL.md` has everything: brand API endpoint, section HTML templates, writer instructions, review checklist.

Brand persona endpoint: `POST https://app.requestdesk.ai/api/agent/content` with Bearer token `spF-vAD3uzTiEYyaxF9TD0zQ01zUny5DK4eVjIMPuB8`

### CC Color Palette (from cucumber-gp-child theme CSS)

| Name | Hex | Usage |
|------|-----|-------|
| Primary Green | `#58c558` | Brand accent, nav hover |
| Green Light | `#7ed957` | Hero CTAs, eyebrow text |
| Green Hover | `#4ab34a` / `#6bc548` | Button hover states |
| Navy Dark | `#1a1a2e` | Hero backgrounds, testimonial sections |
| Navy Medium | `#0f3460` | Stats, process sections |
| Navy Blue | `#1e3a5f` | Default hero theme |
| Primary Dark | `#2c3e50` | CTA sections, headings |
| Red Accent | `#e94560` | Featured items, step numbers |
| Text Primary | `#333333` | Body copy |
| Text Light | `#666666` | Secondary text |
| Surface | `#f8f9fa` | Light backgrounds, cards |
| Border | `#e0e0e0` | Dividers, FAQ borders |
| Gold | `#ffc107` | Star ratings |

### Typography

- Font stack: `-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif`
- Google Fonts loaded: Inter, Nunito, Rubik, Poppins, Montserrat
- Body: 16px, line-height 1.6-1.8
- H1 Hero: `clamp(2.5rem, 6vw, 4.5rem)`, weight 700
- H2: 32px, weight 700
- H3: 22-24px, weight 600
- Eyebrow: 15px, uppercase, letter-spacing 0.15em

### Spacing

- Sections: 80px 40px padding
- Cards: 25-30px padding, 12px radius
- Buttons: 16px 32px (standard), 50px pill radius
- Container max: 1200px
- Grid gap: 30px

### Canva Brand Kit

Content Cucumber kit ID: `kAGk8LegUXI`. The colors above need to be synced into this Canva brand kit. We couldn't pull current Canva colors via MCP (may need Enterprise access). This is flagged as a TODO in the skill.

### TODOs on the Skill

- Update Canva brand kit with these colors (manual for now)
- Get CC brand to 100% in RequestDesk
- WordPress REST API auth for `--push` workflow
- Add more section templates (pricing, logo grid, comparison)

**Action Requested:** Use these values as the source of truth for any CC WordPress styling work. The full skill file at `.claude/skills/content-cucumber/SKILL.md` has all the HTML section templates.

---
