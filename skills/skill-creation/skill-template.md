# Skill Template

Copy this template when creating a new skill in `.claude/skills/[skill-name]/SKILL.md`

---

```markdown
# [Skill Name] - [Brief Description]

**Skill Description:** [One sentence explaining what domain knowledge this skill provides to Claude]

## CRITICAL RESOURCES

| Resource | Location |
|----------|----------|
| **[Primary Resource]** | [Path or URL] |
| **[API Endpoint]** | [URL] |
| **[Key File]** | [Path] |
| **[Documentation]** | [Path] |

**Authentication (if applicable):**
```
Authorization: Bearer [token-reference]
```

---

## [DOMAIN SECTION 1]

[Core concepts Claude needs to understand]

### [Subsection]
[Details]

### [Subsection]
[Details]

---

## [DOMAIN SECTION 2]

[More knowledge Claude needs]

| Column 1 | Column 2 | Column 3 |
|----------|----------|----------|
| [Data] | [Data] | [Data] |

---

## [DOMAIN SECTION 3]

[Processes, workflows, or rules]

```
[Code blocks or structured info if helpful]
```

---

## When Claude Should Apply This Skill

Apply this skill automatically when the user:
- [Trigger 1 - e.g., "Asks about X topic"]
- [Trigger 2 - e.g., "Mentions Y keyword"]
- [Trigger 3 - e.g., "Wants to do Z action"]
- [Trigger 4 - e.g., "References specific terms like A, B, C"]

**Keywords that should trigger this skill:**
- [keyword1], [keyword2], [keyword3]

---

## Core Principles

1. **[Principle 1]** - [Brief explanation]
2. **[Principle 2]** - [Brief explanation]
3. **[Principle 3]** - [Brief explanation]

---

## Supporting Files

- `api-reference.md` - [What it contains]
- `schema.md` - [What it contains]
- `workflows.md` - [What it contains]
- `[other].md` - [What it contains]

---

## Integration with Commands

- `/[command1]` - [How this skill supports the command]
- `/[command2]` - [How this skill supports the command]
- `/[command3]` - [How this skill supports the command]

---

## Quick Reference

[Optional section for frequently-needed info at a glance]

| Item | Value |
|------|-------|
| [Key] | [Value] |
| [Key] | [Value] |
```

---

## Supporting File Templates

### api-reference.md
```markdown
# [Skill Name] - API Reference

## Authentication
[Auth details]

## Endpoints

### GET /resource
[Description]

**Parameters:**
| Param | Type | Required | Description |
|-------|------|----------|-------------|

**Response:**
```json
{
  "example": "response"
}
```

### POST /resource
[Continue pattern]
```

### schema.md
```markdown
# [Skill Name] - Schema Reference

## [Object Type]

| Field | Type | Description |
|-------|------|-------------|
| id | string | [Description] |
| name | string | [Description] |

### Field Details

#### [field_name]
[Detailed explanation if needed]
```

### workflows.md
```markdown
# [Skill Name] - Workflows

## [Workflow 1 Name]

**When to use:** [Context]

**Steps:**
1. [Step 1]
2. [Step 2]
3. [Step 3]

**Example:**
[Concrete example]

## [Workflow 2 Name]
[Continue pattern]
```

---

## Notes

- SKILL.md is the entry point - Claude reads this first
- "When Claude Should Apply This Skill" is CRITICAL for auto-detection
- Supporting files keep SKILL.md focused on overview
- Integration with Commands links skill to explicit user actions
- Keywords section helps Claude pattern-match in conversation
