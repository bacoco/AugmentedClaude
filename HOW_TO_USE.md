# How to Use AugmentedClaude with Natural Language

## What is This?

AugmentedClaude is a natural language interface for development tasks. Instead of memorizing commands, just describe what you want to do in plain English.

## Prerequisites

- **Claude Access**: Either through claude.ai web interface or Claude Code CLI
- **Claude Code CLI** (required): For full functionality and MCP server features
- **No additional installations needed**: SuperClaude framework is already integrated into this project
- **claude-flow**: Available as MCP server through Claude Code's MCP integration

## Quick Start

### Method 1: Easy Install Script (Recommended)

```bash
# One-line install that handles everything
curl -sSL https://raw.githubusercontent.com/bacoco/AugmentedClaude/main/install.sh | bash
```

This will check prerequisites, clone the repository, and set everything up for you.

### Method 2: Manual Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/bacoco/AugmentedClaude.git
   cd AugmentedClaude
   ```

2. Start Claude Code:
   ```bash
   claude
   # Or use our helper script: ./start.sh
   ```

3. **Just talk naturally!** Examples:
   - "Build a React dashboard with authentication"
   - "Review my code for security issues"
   - "Debug this performance problem"
   - "Set up a complete testing suite"
   - "Refactor my entire codebase"

### Using Claude.ai (Web)

1. Open claude.ai
2. Copy the contents of `CLAUDE.md` into your first message
3. Start describing what you want in natural language

## How It Works

The orchestrator automatically:
1. **Understands your intent** from natural language
2. **Chooses the right tool**:
   - SuperClaude for focused tasks
   - claude-flow for multi-agent orchestration
3. **Selects expert personas** based on your task
4. **Optimizes command flags** for best results
5. **Executes the command** with all the right settings

## Natural Language Examples

### Building Features
Say: "Build a user authentication system"
- Orchestrator generates: `mcp claude-flow swarm "Build complete authentication system" --strategy development --parallel`

Say: "Create a simple contact form"
- Orchestrator generates: `/build --form --frontend --validation`

### Code Review & Analysis
Say: "Review my entire project for issues"
- Orchestrator generates: `mcp claude-flow swarm "Comprehensive code review" --strategy analysis --parallel`

Say: "Check this file for bugs"
- Orchestrator generates: `/review --file --quality --evidence`

### Debugging & Performance
Say: "My app is running slowly"
- Orchestrator generates: `mcp claude-flow sparc "Performance analysis and optimization" --mode analyzer`

Say: "Debug this error"
- Orchestrator generates: `/debug --verbose --evidence --think`

### Research & Learning
Say: "Research the best way to implement caching"
- Orchestrator generates: `mcp claude-flow sparc "Research caching strategies and implementation" --mode researcher`

### Testing
Say: "Create tests for everything"
- Orchestrator generates: `mcp claude-flow swarm "Create comprehensive test coverage" --strategy testing --parallel`

### Deployment
Say: "Deploy to production safely"
- Orchestrator generates: `mcp claude-flow sparc "Production deployment with safety checks" --mode devops`

## Advanced Features

### Multi-Agent Orchestration
When you need multiple specialists working together:
- "Refactor my entire codebase" - Uses 8+ agents in parallel
- "Migrate to TypeScript" - Coordinates migration specialists
- "Full security audit" - Deploys security experts across your code

### Memory Persistence
The system remembers important information:
- "Remember our API uses JWT tokens"
- "What did we decide about the database?"
- "Use the authentication approach we discussed"

### Emergency Mode
For critical situations:
- "URGENT: Production is down!"
- "Emergency: Security breach detected"
- "Critical performance issue in production"

## Tips for Best Results

1. **Be specific about what you want**
   - Good: "Build a React dashboard with user authentication and charts"
   - Less good: "Make a dashboard"

2. **Mention constraints or requirements**
   - "Build a REST API that follows OpenAPI spec"
   - "Create a mobile-responsive landing page"

3. **Specify quality needs**
   - "with comprehensive tests"
   - "following security best practices"
   - "optimized for performance"

4. **Use context when helpful**
   - "Debug this TypeScript error"
   - "Review my React components"
   - "Optimize my PostgreSQL queries"

## Common Tasks

### Development
- "Create a new feature"
- "Build a REST API"
- "Add authentication"
- "Implement real-time updates"

### Code Quality
- "Review my code"
- "Find security issues"
- "Check for bugs"
- "Improve performance"

### Testing
- "Write unit tests"
- "Create integration tests"
- "Test everything"
- "Check test coverage"

### DevOps
- "Set up CI/CD"
- "Deploy to staging"
- "Configure monitoring"
- "Automate deployment"

### Documentation
- "Document my API"
- "Create user guides"
- "Write code comments"
- "Generate README"

## No Command Memorization Needed!

You don't need to know:
- Command syntax (/build, /review, etc.)
- Flag combinations (--evidence, --parallel, etc.)
- MCP server details
- Which specialist to use

Just describe what you want to accomplish, and the orchestrator handles everything else.

## Helper Scripts

AugmentedClaude includes helpful scripts to make your experience even smoother:

### `./install.sh`
- One-command installation with prerequisite checking
- Interactive setup with custom project naming
- Automatic Claude CLI installation if needed

### `./start.sh`
- Quick start script that verifies your setup
- Shows helpful tips and examples
- Launches Claude with proper configuration

### `./update.sh`
- Updates AugmentedClaude to the latest version
- Preserves your local changes
- Updates dependencies if needed

## Troubleshooting

### "I don't know what command to use"
Just describe what you want to do! The orchestrator will figure out the right command.

### "The command seems wrong"
The orchestrator chooses commands based on your description. Try being more specific about what you want.

### "It's using the wrong tool"
The orchestrator automatically selects between SuperClaude and claude-flow based on your task complexity. For simple tasks, it uses SuperClaude. For complex multi-agent tasks, it uses claude-flow.

---

Remember: **Just talk naturally!** The orchestrator handles all the technical details.