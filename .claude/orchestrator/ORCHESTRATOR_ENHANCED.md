# AugmentedClaude Orchestrator - Enhanced for SuperClaude + claude-flow

## Purpose
Transform natural language requests into either:
1. SuperClaude commands (/build, /review, etc.)
2. claude-flow MCP commands (mcp claude-flow sparc, swarm, etc.)

## How It Works
When a user makes a request in natural language:
1. Analyze their intent
2. Determine if it's better suited for SuperClaude or claude-flow
3. Generate the optimal command with appropriate flags

## Decision Logic: SuperClaude vs claude-flow

### Use claude-flow for:
- Multi-agent coordination tasks
- Parallel execution needs
- Large-scale refactoring
- Complex workflows requiring multiple specialists
- Memory persistence across sessions

### Use SuperClaude for:
- Single-focused tasks
- Quick commands
- Specific tool usage
- When SuperClaude personas are explicitly needed

## Quick Reference: Natural Language → Commands

### Development Requests
| User Says | Generated Command |
|-----------|-------------------|
| "Build a React dashboard" | `mcp claude-flow sparc "React dashboard with routing and state management" --mode coder` |
| "Create authentication system" | `mcp claude-flow swarm "Build complete authentication system" --strategy development --parallel` |
| "Write unit tests" | `/test --unit --coverage --tdd` |
| "Add a new feature" | `/build --feature --test --evidence` |

### Analysis & Review Requests
| User Says | Generated Command |
|-----------|-------------------|
| "Review my entire codebase" | `mcp claude-flow swarm "Comprehensive code review" --strategy analysis --parallel` |
| "Security audit" | `mcp claude-flow sparc "Security audit and vulnerability assessment" --mode security` |
| "Quick code review" | `/review --quality --evidence` |
| "Find performance issues" | `mcp claude-flow sparc "Performance analysis and optimization" --mode analyzer` |

### Complex Orchestration
| User Says | Generated Command |
|-----------|-------------------|
| "Refactor entire project" | `mcp claude-flow swarm "Refactor codebase for better architecture" --strategy development --max-agents 8 --parallel` |
| "Migrate to TypeScript" | `mcp claude-flow swarm "Migrate JavaScript to TypeScript" --strategy maintenance --parallel` |
| "Full test coverage" | `mcp claude-flow swarm "Create comprehensive test coverage" --strategy testing --parallel` |

### Research & Learning
| User Says | Generated Command |
|-----------|-------------------|
| "Research best React practices" | `mcp claude-flow sparc "Research modern React best practices and patterns" --mode researcher` |
| "Compare frameworks" | `mcp claude-flow swarm "Compare React, Vue, and Angular" --strategy research --parallel` |
| "Learn about microservices" | `/research --deep --evidence --sources` |

### Deployment & Operations
| User Says | Generated Command |
|-----------|-------------------|
| "Deploy to production" | `mcp claude-flow sparc "Production deployment with safety checks" --mode devops` |
| "Set up CI/CD" | `mcp claude-flow swarm "Configure CI/CD pipeline" --strategy development` |
| "Monitor application" | `/monitor --health --alerts --ops` |

## Intent Analysis Rules

### 1. Multi-Agent Triggers
**Keywords:** "entire", "all", "comprehensive", "full", "complete", "everything"
**Action:** Use claude-flow swarm with appropriate strategy

### 2. Parallel Execution Triggers
**Keywords:** "fast", "quickly", "parallel", "simultaneously", "at once"
**Action:** Add --parallel flag to claude-flow commands

### 3. Research & Analysis Triggers
**Keywords:** "research", "analyze", "investigate", "explore", "understand"
**Action:** Use claude-flow sparc with researcher or analyzer mode

### 4. Development Mode Triggers
**Keywords:** "build", "create", "implement", "develop", "code"
**Action:** Use claude-flow sparc with coder mode or appropriate swarm strategy

### 5. Memory/Persistence Triggers
**Keywords:** "remember", "save", "store", "persist", "recall"
**Action:** Use claude-flow memory commands

## SPARC Mode Selection

Based on the task, select the appropriate SPARC mode:
- **orchestrator**: Complex multi-step tasks
- **coder**: Implementation tasks
- **researcher**: Information gathering
- **tdd**: Test-driven development
- **architect**: System design
- **reviewer**: Code review
- **debugger**: Bug fixing
- **tester**: Testing tasks
- **analyzer**: Performance/quality analysis
- **optimizer**: Optimization tasks
- **documenter**: Documentation
- **security**: Security analysis

## Swarm Strategy Selection

Choose strategy based on task type:
- **research**: Information gathering tasks
- **development**: Building features
- **analysis**: Code analysis and review
- **testing**: Test creation and execution
- **optimization**: Performance improvements
- **maintenance**: Refactoring and updates

## Response Format

When providing a command:

```
Based on your request: "{user's natural language request}"

I'll use {tool choice} for this task.

Recommended command:
`{generated command with flags}`

This will:
- {explain what will happen}
- {why this approach was chosen}
- {expected outcome}
```

## Emergency Situations

### Critical Production Issues
**Triggers:** "production down", "emergency", "critical", "urgent"
**Command:** `mcp claude-flow swarm "EMERGENCY: Fix production issue" --strategy maintenance --max-agents 10 --parallel --priority critical`

### Security Incidents
**Triggers:** "security breach", "vulnerability", "hacked"
**Command:** `mcp claude-flow sparc "CRITICAL: Security incident response" --mode security --emergency`

## Memory Integration

For tasks requiring persistence:
```
mcp claude-flow memory store "{key}" "{value}"
mcp claude-flow memory get "{key}"
mcp claude-flow memory list
```

Use memory for:
- Storing architectural decisions
- Saving analysis results
- Persisting configuration
- Tracking project context