# Decision Examples - Real CB-Workspace Cases

Real examples of skill vs command decisions from this workspace.

---

## Example 1: Sprint Management

**Request:** "I need to track sprint velocity and manage sprints"

**Decision:** BOTH skill + command

**Why skill:**
- Domain knowledge needed (velocity, hours/point, sprint lifecycle)
- Multiple concepts (planning, execution, close, retrospective)
- Auto-detection makes sense ("how's the sprint going?" should trigger it)
- Complex enough for supporting files (api-reference, schema, workflows)

**Why command:**
- Users need explicit actions (`/sprint list`, `/sprint close S2`)
- Clear USAGE syntax (`/sprint S2 --hours 50`)
- Procedural steps for each action

**Result:**
- `skills/sprint-management/` - Knowledge base
- `commands/sprint.md` - Explicit actions, references skill

---

## Example 2: Brent's Daily Workflow

**Request:** "Help Brent start and end his day consistently"

**Decision:** Skill + multiple commands

**Why skill:**
- Domain knowledge (priorities, content schedule, delegation rules)
- Auto-detection needed (when Brent asks "what should I work on")
- Applies across multiple commands

**Why commands:**
- `/brent-start` - Explicit morning ritual
- `/brent-finish` - Explicit end-of-day closeout
- Users invoke these at specific times

**Result:**
- `skills/brent-workspace/` - Operating system knowledge
- `commands/brent-start.md` - Morning procedure
- `commands/brent-finish.md` - Evening procedure

---

## Example 3: Adding Backlog Items

**Request:** "Quick way to add items to the RequestDesk backlog"

**Decision:** Command only

**Why NOT a skill:**
- No complex domain knowledge needed
- Single action (add item to backlog)
- No auto-detection scenario (user explicitly wants to add something)

**Why command:**
- Clear trigger: `/add-backlog [description] --priority 1`
- Procedural (call API, confirm result)
- Single purpose

**Result:**
- `commands/add-backlog.md` - API call wrapper

---

## Example 4: Claude Session Management

**Request:** "Save and restore Claude sessions across context windows"

**Decision:** Commands only (multiple)

**Why NOT a skill:**
- Procedural workflows (save steps, start steps)
- No domain knowledge Claude needs to "understand"
- User explicitly invokes save/start

**Why commands:**
- `/claude-save` - Explicit save action
- `/claude-start` - Explicit resume action
- `/claude-complete` - Explicit completion action
- Each is a distinct workflow

**Result:**
- `commands/claude-save.md`
- `commands/claude-start.md`
- `commands/claude-complete.md`

---

## Example 5: Brand Voice

**Request:** "Load Brent's personal brand voice for content"

**Decision:** Command (but could benefit from skill)

**Current state:** Command only (`/brand-brent`)

**Why it works as command:**
- User explicitly invokes when writing
- Loads specific voice rules

**Why a skill might help:**
- Voice rules could auto-apply when writing any content
- "When Claude Should Apply" could trigger on content creation
- Background knowledge (terms to avoid, tone guidelines)

**Potential improvement:**
- Add `skills/brand-voice/` with Brent's voice rules
- `/brand-brent` command loads it explicitly
- Skill auto-applies when writing detected

---

## Example 6: WordPress Plugin Sync

**Request:** "Sync WordPress plugin changes to the plugin repo"

**Decision:** Command only

**Why NOT a skill:**
- Specific action (sync files between directories)
- Procedural steps
- No domain knowledge needed

**Why command:**
- `/sync-wp-plugin` - Run the sync
- Clear input/output
- User invokes when ready to sync

**Result:**
- `commands/sync-wp-plugin.md`

---

## Example 7: This Skill (Skill Creation)

**Request:** "Help Claude decide between skills and commands"

**Decision:** Skill only

**Why skill:**
- Domain knowledge (skill vs command concepts)
- Auto-detection makes sense (when creating new capabilities)
- No explicit `/create-skill` command needed
- Claude should automatically consider this when building

**Why NOT command:**
- No single action to invoke
- User doesn't type `/skill-vs-command`
- It's guidance, not procedure

**Result:**
- `skills/skill-creation/` - This skill

---

## Pattern Summary

| Scenario | Recommendation |
|----------|----------------|
| Single API call wrapper | Command |
| Complex domain with concepts | Skill |
| User workflow with explicit steps | Command |
| Background knowledge Claude needs | Skill |
| Complex domain + explicit actions | Skill + Command |
| Daily/weekly ritual | Command |
| Writing/content context | Skill (auto-apply) |
| One-off action | Command |

---

## Questions to Ask

When deciding:

1. **Will the user type something to trigger it?**
   - Yes → Include a command

2. **Does Claude need background knowledge?**
   - Yes → Include a skill

3. **Should it auto-apply based on context?**
   - Yes → Must be a skill

4. **Is it a single action or broad domain?**
   - Single action → Command
   - Broad domain → Skill

5. **Will multiple commands share this knowledge?**
   - Yes → Skill (commands reference it)
