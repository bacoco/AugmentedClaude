# Claude Flow Commands Documentation

This directory contains detailed documentation for all Claude Flow commands integrated with the AugmentedClaude system.

## Command Categories

### 🎯 Core System Commands
- `start` - Initialize the orchestration system
- `status` - Check system health and active agents
- `monitor` - Real-time performance monitoring
- `config` - Manage system configuration

### 🤖 Agent Management
- `agent spawn` - Create specialized AI agents
- `agent list` - View active agents
- `spawn` - Quick agent creation (alias)

### 📋 Task Orchestration
- `task create` - Define new tasks
- `task list` - View task queue
- `workflow` - Execute workflow files

### 🧠 Memory Management
- `memory store` - Save data for persistence
- `memory get` - Retrieve stored data
- `memory list` - View all memory keys
- `memory export/import` - Backup and restore

### 🚀 SPARC Development
- `sparc` - Run default orchestrator mode
- `sparc run <mode>` - Execute specific SPARC mode
- `sparc tdd` - Test-driven development
- `sparc modes` - List all 17 available modes

### 🐝 Swarm Coordination
- `swarm` - Launch multi-agent swarms
- Strategy options: research, development, analysis, testing, optimization, maintenance
- Mode options: centralized, distributed, hierarchical, mesh, hybrid

### 🔌 MCP Integration
- `mcp start` - Launch MCP server
- `mcp status` - Check MCP health
- `mcp tools` - List available tools

### 🏢 Enterprise Features
- `project` - Project management
- `deploy` - Deployment automation
- `cloud` - Cloud infrastructure
- `security` - Security tools
- `analytics` - Performance insights

## Quick Reference

```bash
# Most common commands
./claude-flow start --ui          # Start with web interface
./claude-flow sparc "task"        # Run task with orchestrator
./claude-flow swarm "objective"   # Launch multi-agent swarm
./claude-flow memory store k v    # Store persistent data
./claude-flow status              # Check system status
```

## Integration with Specialists

Each command can activate specific specialists from the AugmentedClaude system:
- Cognitive specialists for planning and analysis
- Technical specialists for implementation
- Domain specialists for business logic
- Orchestration specialists for coordination

## Performance Tips

1. Use `--parallel` flag for concurrent execution
2. Enable `--monitor` for real-time progress tracking
3. Store architectural decisions in memory for consistency
4. Use swarm mode for complex multi-step tasks
5. Leverage SPARC modes for specialized workflows

## Troubleshooting

If a command fails:
1. Check system status with `./claude-flow status`
2. Verify prerequisites with `./setup.sh`
3. Review logs in `.claude-flow-data/logs/`
4. Ensure MCP servers are running if needed

For detailed command syntax and options, use:
```bash
./claude-flow <command> --help
```