# Command Registry

## Overview
The AugmentedClaude command system provides a comprehensive set of operations for software development lifecycle management. Commands are designed to be composable, with clear specialist assignments and integration patterns.

## Quick Reference Table

| Command | Syntax | Primary Specialist | Purpose |
|---------|--------|-------------------|----------|
| **analyze** | `@claude/commands/core/analyze.md --type --scope --depth` | @claude/agents/cognitive/analyzer.md | Multi-dimensional analysis and investigation |
| **build** | `@claude/commands/core/build.md --component --strategy` | @claude/agents/technical/*-dev.md | Code generation and implementation |
| **deploy** | `@claude/commands/core/deploy.md --environment --strategy` | @claude/agents/technical/devops.md | Deployment and release management |
| **plan** | `@claude/commands/core/plan.md --scope --timeline` | @claude/agents/cognitive/strategist.md | Strategic planning and roadmapping |
| **review** | `@claude/commands/core/review.md --type --depth` | @claude/agents/cognitive/architect.md | Code and architecture review |
| **test** | `@claude/commands/core/test.md --type --coverage` | @claude/agents/technical/qa-tester.md | Testing and quality assurance |
| **troubleshoot** | `@claude/commands/core/troubleshoot.md --issue --severity` | @claude/agents/cognitive/analyzer.md | Problem diagnosis and resolution |
| **coordinate** | `@claude/commands/orchestration/coordinate.md --workflow` | @claude/agents/orchestration/project-manager.md | Multi-specialist coordination |
| **research** | `@claude/commands/specialized/research.md --topic --depth` | @claude/agents/cognitive/researcher.md | Information gathering and analysis |
| **secure** | `@claude/commands/specialized/secure.md --scan --fix` | @claude/agents/technical/security.md | Security analysis and hardening |

## Core Commands

### Analyze Command
**Path**: `@claude/commands/core/analyze.md`  
**Purpose**: Comprehensive system analysis across multiple dimensions  
**Primary Specialist**: @claude/agents/cognitive/analyzer.md  
**Common Use Cases**:
- Performance bottleneck identification
- Security vulnerability assessment
- Code quality evaluation
- System behavior analysis

**Dependencies**:
- Often leads to → troubleshoot (for issue resolution)
- May trigger → secure (for security findings)
- Results feed → plan (for improvement planning)

### Build Command
**Path**: `@claude/commands/core/build.md`  
**Purpose**: Code generation and implementation  
**Primary Specialists**: 
- Frontend: @claude/agents/technical/frontend-dev.md
- Backend: @claude/agents/technical/backend-dev.md

**Common Use Cases**:
- API development
- UI component creation
- Database schema implementation
- Business logic coding

**Dependencies**:
- Follows → plan (implementation of designs)
- Requires → test (validation of implementation)
- May need → review (code quality check)

### Deploy Command
**Path**: `@claude/commands/core/deploy.md`  
**Purpose**: Deployment and release management  
**Primary Specialist**: @claude/agents/technical/devops.md  
**Common Use Cases**:
- Staging deployments
- Production releases
- Infrastructure updates
- Rollback operations

**Dependencies**:
- Requires → test (pre-deployment validation)
- Follows → build (deploying completed features)
- May trigger → troubleshoot (deployment issues)

### Plan Command
**Path**: `@claude/commands/core/plan.md`  
**Purpose**: Strategic planning and architecture design  
**Primary Specialist**: @claude/agents/cognitive/strategist.md  
**Common Use Cases**:
- Feature roadmapping
- Architecture planning
- Sprint planning
- Migration strategies

**Dependencies**:
- Uses → research (information gathering)
- Feeds → build (implementation guidelines)
- Informed by → analyze (current state assessment)

### Review Command
**Path**: `@claude/commands/core/review.md`  
**Purpose**: Code and architecture review  
**Primary Specialist**: @claude/agents/cognitive/architect.md  
**Common Use Cases**:
- Pull request reviews
- Architecture compliance
- Security review
- Performance optimization review

**Dependencies**:
- Follows → build (reviewing implementations)
- May trigger → test (additional testing needs)
- Can lead to → secure (security concerns)

### Test Command
**Path**: `@claude/commands/core/test.md`  
**Purpose**: Comprehensive testing and validation  
**Primary Specialist**: @claude/agents/technical/qa-tester.md  
**Common Use Cases**:
- Unit testing
- Integration testing
- E2E testing
- Performance testing

**Dependencies**:
- Follows → build (testing implementations)
- Precedes → deploy (pre-deployment validation)
- May trigger → troubleshoot (test failures)

### Troubleshoot Command
**Path**: `@claude/commands/core/troubleshoot.md`  
**Purpose**: Issue diagnosis and resolution  
**Primary Specialist**: @claude/agents/cognitive/analyzer.md  
**Common Use Cases**:
- Bug investigation
- Performance issue resolution
- System failure diagnosis
- Integration problem solving

**Dependencies**:
- Often follows → test (failed tests)
- May require → analyze (deeper investigation)
- Leads to → build (bug fixes)

## Orchestration Commands

### Coordinate Command
**Path**: `@claude/commands/orchestration/coordinate.md`  
**Purpose**: Multi-specialist workflow coordination  
**Primary Specialist**: @claude/agents/orchestration/project-manager.md  
**Common Use Cases**:
- Complex feature development
- Cross-team initiatives
- System-wide changes
- Release coordination

**Dependencies**:
- Orchestrates all other commands
- Manages specialist collaboration
- Tracks workflow progress

## Specialized Commands

### Research Command
**Path**: `@claude/commands/specialized/research.md`  
**Purpose**: Deep information gathering and analysis  
**Primary Specialist**: @claude/agents/cognitive/researcher.md  
**Common Use Cases**:
- Technology evaluation
- Best practice research
- Market analysis
- User behavior research

**Dependencies**:
- Feeds → plan (strategic input)
- Supports → analyze (background information)
- Informs → build (implementation choices)

### Secure Command
**Path**: `@claude/commands/specialized/secure.md`  
**Purpose**: Security hardening and compliance  
**Primary Specialist**: @claude/agents/technical/security.md  
**Common Use Cases**:
- Vulnerability scanning
- Security patching
- Compliance auditing
- Threat modeling

**Dependencies**:
- Triggered by → analyze (security findings)
- Part of → review (security review)
- Precedes → deploy (security validation)

## Command Relationships

### Command Chains
Common command execution sequences:

1. **Feature Development Flow**:
   ```
   research → plan → build → test → review → deploy
   ```

2. **Issue Resolution Flow**:
   ```
   troubleshoot → analyze → build → test → deploy
   ```

3. **Security Hardening Flow**:
   ```
   analyze → secure → test → review → deploy
   ```

4. **Performance Optimization Flow**:
   ```
   analyze → plan → build → test → deploy
   ```

### Parallel Execution Patterns
Commands that often run in parallel:

- **Development Phase**: 
  - Frontend build + Backend build
  - Unit test + Integration test
  
- **Analysis Phase**:
  - Performance analyze + Security analyze
  - Code review + Architecture review

### Command Prerequisites
Commands and their typical prerequisites:

- **deploy** requires: successful test + approved review
- **build** requires: completed plan + clear requirements
- **test** requires: completed build + test environment
- **review** requires: completed implementation + review criteria

## Integration with Memory System

Commands interact with memory for:

- **Context Loading**: All commands load @claude/memory/context/* for project awareness
- **Knowledge Application**: Commands reference @claude/memory/knowledge/* for best practices
- **Session Tracking**: Commands update @claude/memory/sessions/* for progress tracking
- **Pattern Matching**: Commands use stored patterns for decision making

## Command Selection Guidelines

### When to Use Each Command

**Use `analyze` when**:
- Performance is degrading
- Bugs are difficult to reproduce
- System behavior is unexpected
- Optimization opportunities are needed

**Use `build` when**:
- Implementing new features
- Fixing identified bugs
- Refactoring existing code
- Creating new components

**Use `deploy` when**:
- Features are tested and ready
- Hotfixes need immediate release
- Infrastructure updates required
- Rollback is necessary

**Use `plan` when**:
- Starting new initiatives
- Architecture decisions needed
- Sprint planning required
- Technical debt prioritization

**Use `review` when**:
- Code changes are complete
- Architecture compliance needed
- Security validation required
- Quality gates must be passed

**Use `test` when**:
- New code is implemented
- Regressions must be prevented
- Performance benchmarks needed
- Integration points change

**Use `troubleshoot` when**:
- Production issues occur
- Tests are failing
- Performance degrades
- Integration breaks

### Command Composition Examples

**Complex Feature Development**:
```
@claude/commands/orchestration/coordinate.md --workflow=feature-development \
  --parallel=[
    @claude/commands/specialized/research.md --market-analysis,
    @claude/commands/core/plan.md --technical-design
  ] \
  --sequential=[
    @claude/commands/core/build.md --full-stack,
    @claude/commands/core/test.md --comprehensive,
    @claude/commands/core/review.md --multi-specialist,
    @claude/commands/core/deploy.md --staged
  ]
```

**Emergency Hotfix**:
```
@claude/commands/core/troubleshoot.md --severity=critical \
  → @claude/commands/core/build.md --hotfix \
  → @claude/commands/core/test.md --regression \
  → @claude/commands/core/deploy.md --emergency
```

## Best Practices

1. **Always specify parameters** for clarity and precision
2. **Use coordinate for complex workflows** involving multiple specialists
3. **Chain related commands** for efficient execution
4. **Document command decisions** in memory for future reference
5. **Monitor command execution** through session tracking
6. **Validate prerequisites** before command execution
7. **Handle failures gracefully** with fallback strategies

## Command Evolution

The command system is designed to evolve. New commands should:
- Follow the established naming convention
- Include clear specialist assignment
- Define integration points
- Document memory interactions
- Provide usage examples
- Include success criteria

This registry serves as the authoritative reference for all AugmentedClaude commands and their interactions.