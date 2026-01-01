# Claude Agents System

This directory contains specialized agents for different types of development work. Each agent provides structured workflows, methodologies, and tools for specific task categories.

## Available Agents

### 🐛 [Debugging Agent](./debugging-agent.md)
**Purpose**: Systematic debugging workflows for production issues, errors, and unexpected behavior

**When to Use:**
- Production errors or unexpected behavior
- API endpoints returning 500 errors
- Authentication/authorization issues
- Database connection problems
- Performance issues or timeouts
- Any system malfunction requiring root cause analysis

**Key Features:**
- Systematic debugging methodology
- Root cause analysis framework
- Fix implementation guidelines
- Testing and validation protocols
- Common debugging scenarios and solutions

### 🚀 [Feature Agent](./feature-agent.md)
**Purpose**: Systematic feature development workflows for new functionality, enhancements, and complex implementations

**When to Use:**
- Building new user-facing features
- Adding complex functionality to existing systems
- Implementing new API endpoints and services
- Creating new database collections or major schema changes
- Multi-component features requiring frontend and backend work

**Key Features:**
- Requirements analysis and technical design
- Implementation roadmap and planning
- Code quality standards and patterns
- Testing strategy and validation
- Documentation requirements

---

## Project Agents

Project agents define **WHERE** Claude can work and project-specific rules. They prevent cross-project contamination and ensure correct deployment mechanisms.

### 🛒 [cb-shopify Agent](./project-cb-shopify.md)
**Project**: Gadget Platform Shopify App
**Directory**: `cb-shopify/`

**Key Rules:**
- Uses Gadget direct sync (`ggt dev`), NOT git deployment
- Production deploy via Gadget web UI only
- Public endpoints in `api/routes/public/`
- Uses `x-requestdesk-api-key` authentication

### 📋 [cb-requestdesk Agent](./project-cb-requestdesk.md)
**Project**: Main RequestDesk Application (FastAPI + React)
**Directory**: `cb-requestdesk/`

**Key Rules:**
- Docker-only development (never install locally)
- MongoDB via Atlas/local install (NOT Docker)
- AWS deploys require `--platform linux/amd64`
- No hardcoded URLs, IDs, usernames, or secrets

### 📝 [cb-wordpress Agent](./project-cb-wordpress.md)
**Project**: WordPress Plugin (RequestDesk Connector)
**Directory**: `cb-wordpress/`

**Key Rules:**
- Directory name ALWAYS `requestdesk-connector/` (never version-named)
- LocalWP for development (not Docker)
- MANDATORY local testing before production
- Keep version history for rollback

### 🌐 [astro-sites Agent](./project-astro-sites.md)
**Project**: Multi-Site Marketing Container
**Directory**: `astro-sites/`

**Key Rules:**
- Contains multiple sites (requestdesk-ai, contentbasis-io, etc.)
- Docker multi-site with nginx routing
- AWS deploys require `--platform linux/amd64`
- Deploy via git tags

---

## Agent Types

| Type | Purpose | Examples |
|------|---------|----------|
| **Task Agents** | HOW to do work | Debugging, Feature |
| **Project Agents** | WHERE to work | cb-shopify, cb-requestdesk |

**Use both together:** Project agent defines boundaries, task agent defines methodology.

---

## Cross-Project Handoffs

When work spans multiple projects:

1. **Each project has its own Claude instance**
2. **Create handoff documents** in `.claude/cross-project-handoffs/`
3. **Never commit to other projects** - let their agent handle it

```
.claude/cross-project-handoffs/
├── shopify-to-requestdesk-2025-12-18.md
└── requestdesk-to-wordpress-2025-12-15.md
```

---

## How to Use the Agents

### Method 1: Reference During Development
1. **Read the relevant agent guide** before starting work
2. **Follow the methodology** outlined for your type of work
3. **Use the tools and patterns** provided in the agent
4. **Complete the success criteria** before considering work done

### Method 2: Task Agent Integration (Future)
```bash
# Future integration with Claude Code Task tool
/task debugging "API endpoint returning 500 errors"
/task feature "Add user notification preferences"
```

## Agent Selection Guide

| Task Type | Agent | Example Scenarios |
|-----------|-------|------------------|
| **Bug Fixes** | Debugging | 500 errors, broken functionality, authentication issues |
| **Production Issues** | Debugging | Performance problems, database errors, service failures |
| **New Features** | Feature | User dashboard, notification system, new workflows |
| **Enhancements** | Feature | UI improvements, new API endpoints, workflow additions |
| **System Analysis** | Debugging | Understanding why something broke, investigating errors |
| **Architecture Changes** | Feature | New collections, major refactoring, integration work |

## Workflow Integration

### With Existing Commands
- **`/project:create-branch`** - Use Feature Agent for planning new features
- **`/deploy-code`** - Use appropriate agent's testing guidelines
- **`/claude-violation-log`** - Reference agent methodologies to avoid violations

### With Development Process
1. **Planning Phase**: Use Feature Agent for requirements and design
2. **Implementation Phase**: Follow agent patterns and code standards
3. **Testing Phase**: Use agent testing strategies and validation
4. **Debugging Phase**: Switch to Debugging Agent for issues
5. **Documentation Phase**: Follow agent documentation requirements

## Best Practices

### Before Starting Work
1. **Identify the work type** - debugging vs feature development
2. **Read the relevant agent guide** completely
3. **Plan your approach** using agent methodology
4. **Set up proper branch and task tracking**

### During Development
1. **Follow agent patterns** for code structure and quality
2. **Document your process** as outlined in agent guides
3. **Test incrementally** using agent testing strategies
4. **Switch agents** if work type changes (feature → debugging)

### After Completion
1. **Verify success criteria** from relevant agent
2. **Complete documentation** requirements
3. **Test thoroughly** using agent validation protocols
4. **Deploy safely** following agent deployment guidelines

## Agent Benefits

### 🎯 **Consistency**
- Standardized approaches to common development tasks
- Consistent code quality and patterns across features
- Predictable workflows and methodologies

### 🚀 **Efficiency**
- Pre-planned workflows reduce decision fatigue
- Established patterns speed up implementation
- Clear success criteria prevent scope creep

### 🛡️ **Quality**
- Built-in testing and validation requirements
- Error prevention through systematic approaches
- Documentation and maintenance considerations

### 📚 **Learning**
- Codified best practices and lessons learned
- Training resource for development standards
- Reference for complex implementation patterns

## Future Enhancements

### Planned Agent Types
- **Security Agent** - Security review, vulnerability analysis, compliance
- **Performance Agent** - Optimization, profiling, scalability improvements  
- **Integration Agent** - Third-party integrations, API connections
- **Migration Agent** - Database migrations, system upgrades, data transformations

### Enhanced Integration
- Direct integration with Claude Code Task system
- Automated agent selection based on task description
- Progress tracking and milestone validation
- Integration with violation logging and quality gates

## Contributing to Agents

### Updating Existing Agents
1. **Identify improvement opportunities** from real development work
2. **Update agent methodology** based on lessons learned
3. **Add new patterns** discovered during implementation
4. **Enhance tools and examples** with real-world scenarios

### Creating New Agents
1. **Identify specialized workflows** not covered by existing agents
2. **Follow established agent structure** and documentation patterns
3. **Include methodology, tools, patterns, and success criteria**
4. **Test agent effectiveness** with real development scenarios

The agents system is designed to evolve based on actual development experience and lessons learned from building RequestDesk.ai features.