# How to Verify the Orchestrator is Working

## What is the Orchestrator?
The orchestrator is a natural language processing system that translates your plain English requests into specific SuperClaude commands with appropriate flags and settings.

## Prerequisites
1. Make sure your `CLAUDE.md` file contains the orchestrator references:
   ```
   @.claude/orchestrator/ORCHESTRATOR.md
   @.claude/orchestrator/ORCHESTRATOR_ENHANCED.md
   ```

2. The `.claude/orchestrator/` directory should contain:
   - `ORCHESTRATOR.md` - Main command mappings
   - `ORCHESTRATOR_ENHANCED.md` - Enhanced mappings for claude-flow

## How to Test

### Test 1: Basic Natural Language Command
Try saying:
```
Build a React dashboard with user authentication
```

**If orchestrator is working:**
- Claude will understand this as a development task
- It will use appropriate tools and commands
- You'll see structured implementation

**If orchestrator is NOT working:**
- You'll get a generic response
- No specific command execution
- Just conversational text

### Test 2: Check Command Mapping
Try these natural language requests and see if they trigger specific behaviors:

| You Say | Orchestrator Should Execute |
|---------|----------------------------|
| "Security review of my code" | Security-focused code review with appropriate flags |
| "Debug this performance issue" | Performance debugging with profiling |
| "Create API documentation" | Documentation generation |
| "Deploy to production safely" | Production deployment with safety checks |

### Test 3: Verify Configuration Loading
When you start Claude in your project directory:
1. It should load `CLAUDE.md` from the root
2. Which loads orchestrator files via @ references
3. These provide the natural language mappings

## Troubleshooting

### Orchestrator Not Working?

1. **Check CLAUDE.md Content:**
   ```bash
   cat CLAUDE.md | grep orchestrator
   ```
   Should show:
   ```
   @.claude/orchestrator/ORCHESTRATOR.md
   @.claude/orchestrator/ORCHESTRATOR_ENHANCED.md
   ```

2. **Verify Files Exist:**
   ```bash
   ls -la .claude/orchestrator/
   ```
   Should show both orchestrator files

3. **Check for Model Override:**
   Make sure `.claude/settings.json` doesn't have a hardcoded model that doesn't support features

### Signs the Orchestrator IS Working:
- Natural language gets translated to specific actions
- Claude mentions using specific tools or commands
- Structured, implementation-focused responses
- References to SuperClaude commands or flags

### Signs the Orchestrator is NOT Working:
- Only conversational responses
- No specific tool usage
- Generic coding advice without implementation
- Doesn't understand command-like requests

## Common Issues

1. **Wrong CLAUDE.md Content**
   - The root CLAUDE.md must have orchestrator references
   - Not the simplified version

2. **Missing Files**
   - Ensure `.claude/orchestrator/` directory exists
   - Both orchestrator files must be present

3. **Model Limitations**
   - Some models don't support all features
   - Remove model overrides in settings.json

## Reinstalling
If the orchestrator isn't working, try a fresh install:
```bash
curl -H 'Cache-Control: no-cache' -sSL https://raw.githubusercontent.com/bacoco/AugmentedClaude/main/install.sh | bash
```

This will ensure you have the latest configuration with orchestrator properly set up.