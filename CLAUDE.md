# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build Commands
- `npm run build`: Build the project
- `npm run test`: Run the full test suite
- `npm run lint`: Run ESLint and format checks
- `npm run typecheck`: Run TypeScript type checking
- `./claude-flow --help`: Show all available commands

## Claude-Flow Complete Command Reference

### Core System Commands
- `./claude-flow start [--ui] [--port 3000] [--host localhost]`: Start orchestration system with optional web UI
- `./claude-flow status`: Show comprehensive system status
- `./claude-flow monitor`: Real-time system monitoring dashboard
- `./claude-flow config <subcommand>`: Configuration management (show, get, set, init, validate)

### Agent Management
- `./claude-flow agent spawn <type> [--name <name>]`: Create AI agents (researcher, coder, analyst, etc.)
- `./claude-flow agent list`: List all active agents
- `./claude-flow spawn <type>`: Quick agent spawning (alias for agent spawn)

### Task Orchestration
- `./claude-flow task create <type> [description]`: Create and manage tasks
- `./claude-flow task list`: View active task queue
- `./claude-flow workflow <file>`: Execute workflow automation files

### Memory Management
- `./claude-flow memory store <key> <data>`: Store persistent data across sessions
- `./claude-flow memory get <key>`: Retrieve stored information
- `./claude-flow memory list`: List all memory keys
- `./claude-flow memory export <file>`: Export memory to file
- `./claude-flow memory import <file>`: Import memory from file
- `./claude-flow memory stats`: Memory usage statistics
- `./claude-flow memory cleanup`: Clean unused memory entries

### SPARC Development Modes
- `./claude-flow sparc "<task>"`: Run orchestrator mode (default)
- `./claude-flow sparc run <mode> "<task>"`: Run specific SPARC mode
- `./claude-flow sparc tdd "<feature>"`: Test-driven development mode
- `./claude-flow sparc modes`: List all 17 available SPARC modes

Available SPARC modes: orchestrator, coder, researcher, tdd, architect, reviewer, debugger, tester, analyzer, optimizer, documenter, designer, innovator, swarm-coordinator, memory-manager, batch-executor, workflow-manager

### Swarm Coordination
- `./claude-flow swarm "<objective>" [options]`: Multi-agent swarm coordination
- `--strategy`: research, development, analysis, testing, optimization, maintenance
- `--mode`: centralized, distributed, hierarchical, mesh, hybrid
- `--max-agents <n>`: Maximum number of agents (default: 5)
- `--parallel`: Enable parallel execution
- `--monitor`: Real-time monitoring
- `--output <format>`: json, sqlite, csv, html

### MCP Server Integration
- `./claude-flow mcp start [--port 3000] [--host localhost]`: Start MCP server
- `./claude-flow mcp status`: Show MCP server status
- `./claude-flow mcp tools`: List available MCP tools

### Claude Integration
- `./claude-flow claude auth`: Authenticate with Claude API
- `./claude-flow claude models`: List available Claude models
- `./claude-flow claude chat`: Interactive chat mode

### Session Management
- `./claude-flow session`: Manage terminal sessions
- `./claude-flow repl`: Start interactive REPL mode

### Enterprise Features
- `./claude-flow project <subcommand>`: Project management (Enterprise)
- `./claude-flow deploy <subcommand>`: Deployment operations (Enterprise)
- `./claude-flow cloud <subcommand>`: Cloud infrastructure management (Enterprise)
- `./claude-flow security <subcommand>`: Security and compliance tools (Enterprise)
- `./claude-flow analytics <subcommand>`: Analytics and insights (Enterprise)

### Project Initialization
- `./claude-flow init`: Initialize Claude-Flow project
- `./claude-flow init --sparc`: Initialize with full SPARC development environment

## Architecture Overview

### Specialist System
The AugmentedClaude system implements a role-based AI orchestration framework where Claude can operate as different specialists:

- **Cognitive Specialists** (`claude/specialists/cognitive/`): High-level thinking roles
  - `architect.md`: System design and architecture decisions
  - `analyzer.md`: Problem investigation and root cause analysis
  - `researcher.md`: Information gathering and synthesis
  - `strategist.md`: Strategic planning and roadmap development

- **Technical Specialists** (`claude/specialists/technical/`): Implementation-focused roles
  - `frontend-dev.md`: React/TypeScript UI development
  - `backend-dev.md`: API and server-side development
  - `security.md`: Security analysis and threat mitigation
  - `qa-tester.md`: Quality assurance and testing
  - `devops.md`: Infrastructure and deployment

- **Domain Specialists** (`claude/specialists/domain/`): Business-focused roles
- **Orchestration Specialists** (`claude/specialists/orchestration/`): Coordination roles

### Reference System
The codebase uses a markdown-based reference system with `@` notation:
- `@specialists/[category]/[name].md` - Activate a specific specialist
- `@workflows/[type]/[process].md` - Execute a predefined workflow
- `@patterns/[category]/[pattern].md` - Apply design patterns
- `@commands/[type]/[command].md` - Execute specific commands
- `@memory/[type]/[file].md` - Access persistent memory/context

### MCP Server Integration
The system integrates with seven MCP servers (configured in `claude/settings.json`):
1. **perplexity**: AI-powered web search and real-time information
2. **context7**: Documentation and API reference access
3. **puppeteer**: Low-level browser automation and scripting
4. **firecrawl**: Web scraping and structured data extraction
5. **sequential**: Multi-step reasoning and complex logic
6. **magic**: UI component generation and prototyping
7. **browsermcp**: Visual regression and accessibility testing

### Key Directories
- `/claude/` - Core Claude configuration and specialist definitions
- `/orchestrator/` - Natural language orchestration system
- `/workflows/` - Predefined multi-step processes
- `/patterns/` - Reusable design patterns and best practices
- `/memory/` - Persistent context and knowledge storage
- `/commands/` - Executable command definitions
- `/shared/` - Shared utilities and MCP integration configs
- `/.claude/commands/` - Claude Flow command documentation

## Quick Start Workflows

### Research Workflow
```bash
# Start a research swarm with distributed coordination
./claude-flow swarm "Research modern web frameworks" --strategy research --mode distributed --parallel --monitor

# Or use SPARC researcher mode for focused research
./claude-flow sparc run researcher "Analyze React vs Vue vs Angular performance characteristics"

# Store findings in memory for later use
./claude-flow memory store "research_findings" "Key insights from framework analysis"
```

### Development Workflow
```bash
# Start orchestration system with web UI
./claude-flow start --ui --port 3000

# Run TDD workflow for new feature
./claude-flow sparc tdd "User authentication system with JWT tokens"

# Development swarm for complex projects
./claude-flow swarm "Build e-commerce API with payment integration" --strategy development --mode hierarchical --max-agents 8 --monitor

# Check system status
./claude-flow status
```

### Analysis Workflow
```bash
# Analyze codebase performance
./claude-flow sparc run analyzer "Identify performance bottlenecks in current codebase"

# Data analysis swarm
./claude-flow swarm "Analyze user behavior patterns from logs" --strategy analysis --mode mesh --parallel --output sqlite

# Store analysis results
./claude-flow memory store "performance_analysis" "Bottlenecks identified in database queries"
```

### Maintenance Workflow
```bash
# System maintenance with safety controls
./claude-flow swarm "Update dependencies and security patches" --strategy maintenance --mode centralized --monitor

# Security review
./claude-flow sparc run reviewer "Security audit of authentication system"

# Export maintenance logs
./claude-flow memory export maintenance_log.json
```

## Integration Patterns

### Memory-Driven Coordination
Use Memory to coordinate information across multiple SPARC modes and swarm operations:

```bash
# Store architecture decisions
./claude-flow memory store "system_architecture" "Microservices with API Gateway pattern"

# All subsequent operations can reference this decision
./claude-flow sparc run coder "Implement user service based on system_architecture in memory"
./claude-flow sparc run tester "Create integration tests for microservices architecture"
```

### Multi-Stage Development
Coordinate complex development through staged execution:

```bash
# Stage 1: Research and planning
./claude-flow sparc run researcher "Research authentication best practices"
./claude-flow sparc run architect "Design authentication system architecture"

# Stage 2: Implementation
./claude-flow sparc tdd "User registration and login functionality"
./claude-flow sparc run coder "Implement JWT token management"

# Stage 3: Testing and deployment
./claude-flow sparc run tester "Comprehensive security testing"
./claude-flow swarm "Deploy authentication system" --strategy maintenance --mode centralized
```

### Enterprise Integration
For enterprise environments with additional tooling:

```bash
# Project management integration
./claude-flow project create "authentication-system"
./claude-flow project switch "authentication-system"

# Security compliance
./claude-flow security scan
./claude-flow security audit

# Analytics and monitoring
./claude-flow analytics dashboard
./claude-flow deploy production --monitor
```

## MCP Server Workflows

### Research and Intelligence Gathering
Combine Perplexity and Firecrawl for comprehensive market research:
```bash
# Market research workflow
./claude-flow sparc run researcher "Analyze SaaS pricing trends"
# Activates: Perplexity for trends + Firecrawl for competitor data + Sequential for analysis
```

### Comprehensive Testing Strategy
Leverage Puppeteer and BrowserMCP for complete test coverage:
```bash
# Full testing suite
./claude-flow sparc run qa-tester "Test e-commerce checkout flow"
# Activates: Puppeteer for automation + BrowserMCP for visual testing + Sequential for reporting
```

### Data Collection Pipeline
Use Firecrawl with data science specialists:
```bash
# Automated data gathering
./claude-flow swarm "Collect training data for ML model" --strategy analysis
# Activates: Firecrawl for extraction + Sequential for processing + Memory for storage
```

## Advanced Batch Tool Patterns

### TodoWrite Coordination
Always use TodoWrite for complex task coordination:

```javascript
TodoWrite([
  {
    id: "architecture_design",
    content: "Design system architecture and component interfaces",
    status: "pending",
    priority: "high",
    dependencies: [],
    estimatedTime: "60min",
    assignedAgent: "architect"
  },
  {
    id: "frontend_development", 
    content: "Develop React components and user interface",
    status: "pending",
    priority: "medium",
    dependencies: ["architecture_design"],
    estimatedTime: "120min",
    assignedAgent: "frontend_team"
  }
]);
```

### Task and Memory Integration
Launch coordinated agents with shared memory:

```javascript
// Store architecture in memory
Task("System Architect", "Design architecture and store specs in Memory");

// Other agents use memory for coordination
Task("Frontend Team", "Develop UI using Memory architecture specs");
Task("Backend Team", "Implement APIs according to Memory specifications");
```

## Code Style Preferences
- Use ES modules (import/export) syntax
- Destructure imports when possible
- Use TypeScript for all new code
- Follow existing naming conventions
- Add JSDoc comments for public APIs
- Use async/await instead of Promise chains
- Prefer const/let over var

## Workflow Guidelines
- Always run typecheck after making code changes
- Run tests before committing changes
- Use meaningful commit messages
- Create feature branches for new functionality
- Ensure all tests pass before merging

## Working with the System

### Activating Specialists
When working on specific tasks, activate the appropriate specialist by referencing their markdown file. Each specialist has:
- Core identity and decision patterns
- Primary tools and MCP integrations
- Key workflows and collaboration partners
- Preferred commands and patterns

### Using the Reference System
- Use `@` references to access any markdown file in the system
- References can include anchors for specific sections: `@patterns/development/testing-patterns.md#test-pyramid`
- The system supports up to 7 references per context (configurable in settings.json)

### Memory and Context
- Current session state: `@memory/sessions/current-session.md`
- Technical decisions: `@memory/context/technical-stack.md`
- Lessons learned: `@memory/knowledge/lessons-learned.md`

## Natural Language Usage Examples
```bash
# Simple commands
"Security review of my payment API with performance analysis"
"Build React dashboard with authentication"
"URGENT: Production API is down, need diagnosis"

# Complex orchestration
"Design and implement a complete user management system with React frontend, Node.js backend, PostgreSQL database, including authentication, authorization, and admin panel"

# Research and analysis
"Research best practices for implementing real-time notifications in a microservices architecture and provide implementation recommendations"

# MCP Server-Specific Examples
"Search for latest React 19 features and breaking changes" # Uses Perplexity
"Extract competitor pricing data from their websites" # Uses Firecrawl
"Run visual regression tests across Chrome, Firefox, and Safari" # Uses BrowserMCP
"Analyze current security vulnerabilities in npm packages" # Uses Perplexity + Context7
"Monitor competitor feature changes weekly" # Uses Firecrawl + Sequential
```

## Important Notes
- **Use TodoWrite extensively** for all complex task coordination
- **Leverage Task tool** for parallel agent execution on independent work
- **Store all important information in Memory** for cross-agent coordination
- **Use batch file operations** whenever reading/writing multiple files
- **Check .claude/commands/** for detailed command documentation
- **All swarm operations include automatic batch tool coordination**
- **Monitor progress** with TodoRead during long-running operations
- **Enable parallel execution** with --parallel flags for maximum efficiency

This configuration ensures optimal use of Claude Code's batch tools for swarm orchestration and parallel task execution with full Claude-Flow capabilities.