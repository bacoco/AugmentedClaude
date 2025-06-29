# Coordinate Command

## Purpose
Multi-specialist orchestration command for managing complex projects requiring coordination across multiple domains, teams, and workflows with parallel execution capabilities.

## Specialist Integration
- **Primary**: @claude/agents/orchestration/project-manager.md
- **Supporting**: @claude/agents/orchestration/system-integrator.md, @claude/agents/cognitive/strategist.md

## Command Syntax
```
@claude/commands/orchestration/coordinate.md [--project] [--mode] [--teams] [--timeline]
```

## Parameters
- `--project`: Project type (feature, migration, integration, transformation)
- `--mode`: Coordination mode (sequential, parallel, hybrid, adaptive)
- `--teams`: Team composition (full-stack, specialized, cross-functional, distributed)
- `--timeline`: Timeline strategy (aggressive, standard, conservative, milestone-based)

## Usage Examples

### Feature Development Coordination
```
@claude/commands/orchestration/coordinate.md --project=feature --mode=parallel --teams=full-stack --timeline=aggressive
```
**Activates**: @claude/agents/orchestration/project-manager.md, @claude/agents/technical/* (as needed)
**Tools**: @claude/integrations/sequential.md for workflow orchestration, @claude/integrations/magic.md for automation
**Patterns**: @claude/patterns/team/parallel-development.md

### System Migration Project
```
@claude/commands/orchestration/coordinate.md --project=migration --mode=hybrid --teams=specialized --timeline=milestone-based
```
**Activates**: @claude/agents/orchestration/system-integrator.md, multiple domain specialists
**Tools**: @claude/integrations/context7.md for migration strategies, @claude/integrations/puppeteer.md for validation
**Patterns**: @claude/patterns/architectural/migration-patterns.md

### Cross-Team Integration
```
@claude/commands/orchestration/coordinate.md --project=integration --mode=adaptive --teams=cross-functional
```
**Activates**: @claude/agents/orchestration/scrum-master.md, @claude/agents/cognitive/architect.md
**Tools**: @claude/integrations/sequential.md for complex integration workflows
**Patterns**: @claude/patterns/team/cross-functional-collaboration.md

## Execution Workflow

### Phase 1: Project Initialization
1. **Scope Analysis**
   - Break down project into workstreams
   - Identify dependencies and constraints
   - Map required specialists and resources

2. **Team Formation**
   - Assemble specialist teams by domain
   - Define roles and responsibilities
   - Establish communication protocols

### Phase 2: Planning & Architecture
1. **Strategic Planning**
   - Activate @claude/agents/cognitive/strategist.md for high-level planning
   - Create project roadmap and milestones
   - Define success metrics and KPIs

2. **Technical Architecture**
   - Engage @claude/agents/cognitive/architect.md for design
   - Ensure architectural alignment across teams
   - Validate integration points

### Phase 3: Parallel Execution
1. **Workstream Management**
   - Launch parallel workstreams with appropriate specialists
   - Monitor progress across all teams
   - Manage inter-team dependencies

2. **Continuous Integration**
   - Regular integration checkpoints
   - Cross-team code reviews and testing
   - Conflict resolution and merge coordination

### Phase 4: Convergence & Delivery
1. **Integration Testing**
   - Coordinate @claude/commands/core/test.md across all components
   - Validate end-to-end functionality
   - Performance and security verification

2. **Deployment Coordination**
   - Orchestrate @claude/commands/core/deploy.md for all components
   - Manage rollout sequencing
   - Coordinate go-live activities

## Integration Points
- **Development**: Coordinate multiple @claude/commands/core/build.md instances
- **Testing**: Orchestrate @claude/commands/core/test.md across teams
- **Security**: Integrate @claude/commands/specialized/secure.md throughout
- **Documentation**: Consolidate via @claude/commands/specialized/document.md

## Success Criteria
- [ ] All workstreams completed on schedule
- [ ] Integration points validated and functional
- [ ] Cross-team dependencies resolved
- [ ] Quality standards met across all components
- [ ] Deployment successful with minimal issues
- [ ] Project delivered within timeline and scope

## Memory & Context Usage
- **Project State**: @claude/memory/operational/project-state.md
- **Team Assignments**: @claude/memory/context/team-structure.md
- **Integration Points**: @claude/memory/knowledge/integration-map.md
- **Progress Tracking**: @claude/memory/sessions/current-session.md#coordination-log

## Error Handling & Fallbacks
- Team conflicts → @claude/agents/orchestration/scrum-master.md mediation
- Technical blockers → @claude/agents/cognitive/architect.md consultation
- Resource constraints → @claude/agents/orchestration/project-manager.md reallocation
- Timeline risks → Adaptive replanning with milestone adjustment

## Advanced Features
- **AI Team Simulation**: Virtual specialist teams for rapid prototyping
- **Dependency Visualization**: Real-time project dependency graphs
- **Risk Prediction**: ML-based project risk assessment
- **Automated Coordination**: Self-organizing team workflows