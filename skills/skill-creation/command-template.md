# Command Template

Copy this template when creating a new command in `.claude/commands/[name].md`

---

```markdown
[Brief one-line description of what this command does]

**SKILL:** [Optional - If backed by a skill, reference it]
This command is backed by the `[skill-name]` skill in `.claude/skills/[skill-name]/`
- See `SKILL.md` for overview and when to apply
- See `api-reference.md` for endpoint docs (if applicable)

**USAGE:**
- `/[command]` - [Default action]
- `/[command] [arg]` - [With argument]
- `/[command] [arg] --flag` - [With flag]

**ARGUMENTS:**
- `[arg]` (required/optional): [Description]
- `--flag` (optional): [Description]

**PURPOSE:**
[1-2 sentences explaining why this command exists and when to use it]

---

## EXECUTION STEPS

### Step 1: [Name]
[What to do first]

```bash
# Example command if applicable
```

### Step 2: [Name]
[What to do next]

### Step 3: [Name]
[Continue as needed]

---

## API CONFIGURATION (if applicable)

```
BASE_URL: https://example.com/api
AUTH: Authorization: Bearer [token-reference]
```

**Endpoints Used:**
| Method | Endpoint | Purpose |
|--------|----------|---------|
| GET | /resource | [Purpose] |
| POST | /resource | [Purpose] |

---

## EXAMPLES

### Example 1: [Scenario]
```
/[command] [example-args]
```
Result: [What happens]

### Example 2: [Scenario]
```
/[command] [example-args]
```
Result: [What happens]

---

## ERROR HANDLING

| Error | Cause | Resolution |
|-------|-------|------------|
| [Error message] | [Why it happens] | [How to fix] |

---

## RELATED COMMANDS

- `/[related-command]` - [Brief description]
- `/[another-command]` - [Brief description]
```

---

## Notes

- First line should be a brief description (shown in command list)
- SKILL reference is optional but recommended for complex domains
- USAGE section is critical for discoverability
- Keep examples practical and realistic
- Error handling helps users self-serve
