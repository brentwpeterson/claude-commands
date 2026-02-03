# Skill Creation - When to Create Skills vs Commands

**Skill Description:** Guide for Claude to decide whether to create a skill, a command, or both when adding new capabilities to the CB-Workspace system.

## THE CORE DISTINCTION

| Aspect | Command (`/command`) | Skill (`skills/name/`) |
|--------|---------------------|------------------------|
| **Trigger** | User types `/command` | Claude auto-detects from context |
| **Purpose** | Execute specific action | Provide domain knowledge |
| **Structure** | Procedural steps | Conceptual framework |
| **Invocation** | Explicit | Implicit |
| **Scope** | Single action/workflow | Entire domain |

---

## DECISION FRAMEWORK

### Create a **SKILL** when:

1. **Domain knowledge is needed** - Claude needs background context to handle a topic well
   - Example: Sprint management (velocity concepts, lifecycle, metrics)
   - Example: Brent's writing style (voice rules, content schedule)

2. **Auto-detection makes sense** - User shouldn't have to explicitly invoke it
   - Example: When user mentions "sprint status", skill kicks in automatically
   - Example: When writing content, voice rules should auto-apply

3. **Multiple files are needed** - The knowledge is complex enough to split
   - SKILL.md (overview + auto-detection triggers)
   - api-reference.md (endpoints)
   - schema.md (data structures)
   - workflows.md (processes)

4. **Knowledge applies across multiple commands**
   - Sprint knowledge is used by `/sprint`, `/brent-start`, `/brent-finish`
   - Brent workspace knowledge is used by `/brent-start`, `/daily-content`, etc.

5. **"When Claude Should Apply This Skill" section makes sense**
   - If you can write clear auto-detection triggers, it's a skill

### Create a **COMMAND** when:

1. **User explicitly invokes it** - They type `/something` to trigger an action
   - Example: `/sprint create S3` - explicit action
   - Example: `/claude-save` - explicit workflow

2. **Procedural steps are the focus** - "Do this, then this, then this"
   - Example: `/claude-start` has exact steps to follow
   - Example: `/add-backlog` has specific API calls to make

3. **Single action with clear input/output**
   - Example: `/sprint list` - lists sprints
   - Example: `/check-terms` - checks content for bad terms

4. **USAGE patterns exist** - `/command arg1 --flag`
   - If there's a syntax to document, it's a command

### Create **BOTH** when:

The domain is complex enough to warrant a skill, but users also need explicit commands to trigger specific actions.

**Pattern:** Command references skill for knowledge, skill lists related commands.

```
# In command file (sprint.md):
**SKILL:** This command is backed by the `sprint-management` skill...

# In SKILL.md:
## Integration with Commands
- `/sprint` - Quick sprint status and operations
```

**Examples of skill + command pairs:**
- `sprint-management` skill + `/sprint` command
- `brent-workspace` skill + `/brent-start`, `/brent-finish` commands

---

## When Claude Should Apply This Skill

Apply this skill automatically when:
- User asks to "create a new command" or "add a slash command"
- User asks to "make a skill" or "add Claude knowledge for X"
- User says "I want Claude to know about X"
- User wants to add a new capability to the system
- Claude is about to create a command and should consider if a skill is needed

---

## USER INTERRUPT TRIGGERS

When the user says any of these phrases, Claude MUST STOP and reconsider the skill vs command decision:

| Trigger Phrase | Meaning |
|----------------|---------|
| **"skill check"** | Stop. Is this domain knowledge that should be a skill? |
| **"should this be a skill?"** | Pause and evaluate using the decision framework |
| **"you're defaulting to commands"** | I'm making a command when a skill might be better |
| **"make it a skill"** | Convert current work to a skill and continue building |

**When triggered by "skill check" or "should this be a skill?":**
1. STOP current work
2. Read this skill's decision framework
3. Evaluate: Does Claude need background knowledge? Should it auto-apply?
4. Present recommendation: "This should be a [skill/command/both] because..."
5. Wait for user confirmation before proceeding

**When triggered by "make it a skill":**
1. User has decided - no need to evaluate
2. Create `skills/[name]/SKILL.md` with current knowledge
3. Move domain content from command (if exists) into skill
4. Continue building on the skill - add supporting files as needed
5. Keep command if explicit actions are still needed (reference the skill)

**Example: "skill check" (evaluative)**
```
User: Create a way to manage API integrations
Claude: I'll create /manage-integrations command...
User: skill check
Claude: Let me reconsider. API integrations involve:
- Domain knowledge (auth patterns, rate limits, error handling)
- Would benefit from auto-detection when discussing integrations
- Multiple concepts that could use supporting files

Recommendation: This should be a SKILL with a command.
- `skills/api-integrations/` for the knowledge
- `/integrations` command for explicit actions

Should I proceed with this approach?
```

**Example: "make it a skill" (directive)**
```
User: Create a way to track client preferences
Claude: I'll create /client-prefs command with these options...
User: make it a skill
Claude: Converting to skill. Creating skills/client-preferences/SKILL.md...

[Creates SKILL.md with the domain knowledge]
[Adds "When Claude Should Apply" triggers]

Created skills/client-preferences/ with:
- SKILL.md (core knowledge + auto-detection)

What else should this skill know about? I can add:
- schema.md for data structure
- workflows.md for preference update processes
- Keep /client-prefs command for explicit lookups?
```

---

## SKILL STRUCTURE

Every skill lives in `skills/[skill-name]/` and MUST have:

```
skills/
  [skill-name]/
    SKILL.md              # Required - Main entry point
    api-reference.md      # If APIs are involved
    schema.md             # If data structures matter
    workflows.md          # If processes need documenting
    [other].md            # Domain-specific files
```

### SKILL.md Required Sections

```markdown
# [Skill Name] - [Brief Description]

**Skill Description:** [One sentence explaining what this skill provides]

## CRITICAL RESOURCES
[Table of key files, APIs, locations]

## [DOMAIN-SPECIFIC SECTIONS]
[The actual knowledge Claude needs]

## When Claude Should Apply This Skill
[List of triggers for auto-detection]

## Supporting Files
[List other files in skill directory]

## Integration with Commands
[List related commands]
```

See `skill-template.md` for full template.

---

## COMMAND STRUCTURE

Commands live in `commands/[command-name].md` as single files.

### Command Required Sections

```markdown
[Brief description - first line]

**SKILL:** [If backed by a skill, reference it here]

**USAGE:**
- `/command` - [what it does]
- `/command arg` - [with argument]
- `/command --flag` - [with flag]

**PURPOSE:**
[Why this command exists]

[DOMAIN-SPECIFIC SECTIONS]
[Steps, API calls, examples]
```

See `command-template.md` for full template.

---

## COMMON MISTAKES

### Mistake 1: Creating a command when a skill is needed

**Symptom:** Command file is huge because it contains too much background knowledge.

**Fix:** Extract domain knowledge into a skill, have command reference the skill.

### Mistake 2: Creating only a skill when a command is also needed

**Symptom:** User has to describe what they want instead of just typing `/command`.

**Fix:** Add a command that gives users explicit control.

### Mistake 3: Putting procedural steps in a skill

**Symptom:** SKILL.md reads like a recipe instead of a knowledge base.

**Fix:** Move procedures to a command or to `workflows.md` in the skill.

### Mistake 4: No "When Claude Should Apply" section

**Symptom:** Skill exists but Claude never uses it automatically.

**Fix:** Add clear auto-detection triggers.

---

## QUICK DECISION CHECKLIST

Ask these questions:

1. Does the user type something to trigger it? **Command**
2. Should Claude apply it automatically based on context? **Skill**
3. Is it procedural (steps to follow)? **Command**
4. Is it conceptual (knowledge to have)? **Skill**
5. Is it both complex knowledge AND explicit actions? **Both**

---

## Supporting Files

- `skill-template.md` - Copy-paste template for new skills
- `command-template.md` - Copy-paste template for new commands
- `decision-examples.md` - Real examples from CB-Workspace

---

## Integration with Commands

- No dedicated command (this skill auto-applies when creating capabilities)
