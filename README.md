# AugmentedClaude 🚀

**Just describe what you want to build. No commands to memorize.**

AugmentedClaude is a natural language interface that transforms how you work with AI for development. Simply describe your task in plain English, and the orchestrator handles everything else.

## ✨ Key Features

### Natural Language Interface
- **No command memorization** - Just describe what you want
- **Automatic tool selection** - Chooses between SuperClaude and claude-flow
- **Smart orchestration** - Coordinates multiple AI agents when needed
- **Context-aware** - Understands your project and remembers decisions

### What You Can Say

```
"Build a React dashboard with authentication"
"Review my code for security issues"
"Debug this performance problem"
"Refactor my entire codebase"
"Create comprehensive test coverage"
"Deploy to production safely"
```

The orchestrator automatically translates your request into optimized commands.

## 📚 Documentation

- **[HOW_TO_USE.md](HOW_TO_USE.md)** - Complete guide with examples
- **[CLAUDE.md](CLAUDE.md)** - Main configuration file

## 🚀 Installation

Choose one of these installation methods:

### Option 1: Automated Install (Recommended)

Best for most users - handles all setup automatically:

```bash
# One-line install (creates a new project)
curl -sSL https://raw.githubusercontent.com/bacoco/AugmentedClaude/main/install.sh | bash

# Or if you prefer wget
wget -qO- https://raw.githubusercontent.com/bacoco/AugmentedClaude/main/install.sh | bash
```

The installer will:
- Check all prerequisites (git, Node.js, Claude CLI)
- Offer to install Claude CLI if needed
- Clone the repository to a directory of your choice
- Optionally install MCP dependencies
- Provide clear next steps

### Option 2: Manual Install

For users who want more control or are contributing to the project:

1. **Clone the repository**:
   ```bash
   # For using the main repository:
   git clone https://github.com/bacoco/AugmentedClaude.git
   
   # Or if you've forked the project:
   git clone https://github.com/[your-username]/AugmentedClaude.git
   
   cd AugmentedClaude
   ```

2. **Start Claude Code**:
   ```bash
   claude
   ```

## 🎯 Getting Started

Once installed, just talk naturally:
- "Build a user authentication system"
- "Find and fix performance issues"
- "Create API documentation"
- "Set up continuous integration"

## 🧠 How It Works

1. **You describe** what you want in natural language
2. **Orchestrator analyzes** your intent and context
3. **Automatically selects** the right tools and experts
4. **Generates and executes** optimized commands
5. **You get results** without learning complex syntax

## 🛠️ Under the Hood

- **Natural Language Orchestrator** - Translates requests to commands
- **SuperClaude Integration** - For focused development tasks
- **claude-flow MCP** - For multi-agent orchestration
- **Expert Personas** - Specialized AI agents for different tasks
- **Memory System** - Persists context across sessions

## 📦 Project Structure

```
AugmentedClaude/
└── .claude/              # SuperClaude-compatible structure
    ├── orchestrator/     # Natural language processing
    ├── specialists/      # AI specialists
    ├── commands/         # Command definitions
    ├── patterns/         # Best practices
    ├── workflows/        # Complex processes
    ├── memory/           # Context storage
    └── shared/           # Configuration
```

## 🎯 Example Use Cases

### Development
- "Create a REST API with authentication"
- "Build a real-time chat application"
- "Add payment processing to my app"

### Code Quality
- "Review my entire codebase"
- "Find security vulnerabilities"
- "Optimize database queries"

### Testing
- "Write tests for all my components"
- "Create end-to-end test suite"
- "Check my test coverage"

### DevOps
- "Set up CI/CD pipeline"
- "Configure Docker deployment"
- "Add monitoring and logging"

## 🤖 Powered By

- **SuperClaude** - Advanced command framework
- **claude-flow** - Multi-agent orchestration
- **MCP Servers** - Tool integrations
- **Natural Language Processing** - Intent understanding

## 📋 Project Status & Architecture

### ✅ This Project is READY TO USE

AugmentedClaude is a **markdown-based orchestration layer** for Claude Code. It's not a traditional application - it's a configuration system that Claude Code reads and interprets.

### How It Actually Works

1. **No Executable Code Needed**: All logic is in 118+ markdown files that Claude interprets
2. **Claude Code IS the Runtime**: When you run `claude`, it reads the orchestration files
3. **@ References Create the Magic**: The markdown files use @ references to link commands, patterns, and workflows
4. **MCP Servers Provide Tools**: The settings.json configures tools like claude-flow for multi-agent orchestration

### About "Missing" Files

Git status may show Python files (.py) as untracked - these are **NOT NEEDED** because:
- Claude Code itself is the execution engine
- All orchestration logic lives in markdown files
- The system uses Claude's ability to interpret structured markdown

### Quick Verification

✅ **Ready Checklist**:
- Claude CLI installed: Run `which claude` to verify
- 118 orchestration files in `.claude/` directory
- MCP server configurations in settings.json
- Natural language mappings in orchestrator files

### Start Using Now

```bash
# In the project directory
claude

# Then just type naturally:
# "Build a React dashboard with authentication"
# "Review my code for security issues"
# "Refactor my entire codebase"
```

The orchestrator automatically translates your natural language into optimized commands!

## 🤝 Contributing

Contributions welcome! The orchestrator can be extended with new patterns, workflows, and integrations.

## 🙏 Acknowledgments & Credits

This project integrates and builds upon the excellent work of:

- **[SuperClaude](https://github.com/NomenAK/SuperClaude)** - The powerful command framework that powers our natural language orchestration. All SuperClaude code has been integrated into the `.claude/` directory structure.
- **[claude-code-flow](https://github.com/ruvnet/claude-code-flow)** - Multi-agent orchestration capabilities available through MCP server integration.

Special thanks to the creators and contributors of these projects for their innovative approaches to AI-assisted development.

## 📄 License

MIT License - see LICENSE file for details.

---

**Stop memorizing commands. Start building faster.**

Just describe what you want, and let AugmentedClaude handle the complexity.