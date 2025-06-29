# Plan Command

## Purpose
Strategic planning and roadmap development for projects, features, sprints, and technical initiatives with comprehensive timeline and resource management.

## Specialist Integration
- **Primary**: @claude/agents/cognitive/strategist.md
- **Supporting**: @claude/agents/domain/product-manager.md, @claude/agents/orchestration/project-manager.md

## Command Syntax
```
@claude/commands/core/plan.md [--scope] [--horizon] [--format] [--priority] [--specialist]
```

## Parameters
- `--scope`: Planning scope (feature, sprint, release, quarter, annual)
- `--horizon`: Planning horizon (short=1-2 weeks, medium=1-3 months, long=3-12 months)
- `--format`: Output format (roadmap, gantt, kanban, timeline, milestones)
- `--priority`: Priority framework (value, risk, effort, strategic)
- `--specialist`: Override default specialist selection

## Usage Examples

### Feature Planning
```
@claude/commands/core/plan.md --scope=feature --horizon=short --format=kanban
```
**Activates**: @claude/agents/cognitive/strategist.md + @claude/agents/domain/product-manager.md
**Tools**: @claude/integrations/sequential.md for multi-phase planning
**Patterns**: @claude/patterns/operational/agile-patterns.md
**Memory**: Updates @claude/memory/context/project-overview.md#feature-roadmap

### Sprint Planning
```
@claude/commands/core/plan.md --scope=sprint --horizon=short --priority=value --specialist=@claude/agents/orchestration/scrum-master.md
```
**Activates**: @claude/agents/orchestration/scrum-master.md
**Tools**: @claude/integrations/context7.md for velocity analysis
**Patterns**: @claude/patterns/operational/agile-patterns.md#sprint-planning
**Memory**: Creates sprint plan in @claude/memory/sessions/current-session.md#sprint-plan

### Annual Strategic Planning
```
@claude/commands/core/plan.md --scope=annual --horizon=long --format=roadmap --priority=strategic
```
**Activates**: @claude/agents/cognitive/strategist.md
**Tools**: @claude/integrations/perplexity.md for market research
**Patterns**: @claude/patterns/operational/continuous-improvement.md
**Memory**: Stores strategic plan in @claude/memory/knowledge/strategic-initiatives.md

## Execution Workflow

### Phase 1: Context Gathering & Analysis
1. **Current State Assessment**
   - Review existing plans and progress from memory
   - Analyze completed features and technical debt
   - Assess team capacity and velocity metrics

2. **Stakeholder Alignment**
   - Reference: @claude/agents/domain/product-manager.md for requirement gathering
   - Identify key stakeholders and their priorities
   - Gather constraints and dependencies

### Phase 2: Strategic Planning
1. **Goal Definition**
   - Define SMART objectives for the planning horizon
   - Align with organizational strategy from @claude/memory/context/project-overview.md
   - Establish success metrics and KPIs

2. **Resource Planning**
   - Team capacity analysis and allocation
   - Budget and timeline constraints
   - Risk assessment and mitigation strategies

### Phase 3: Plan Development
1. **Roadmap Creation**
   - Use @claude/integrations/sequential.md for phased planning
   - Create deliverable breakdown structure
   - Define milestones and dependencies

2. **Prioritization**
   - Apply selected priority framework
   - Balance technical debt with new features
   - Consider risk vs. value trade-offs

### Phase 4: Validation & Communication
1. **Feasibility Review**
   - Technical validation with @claude/agents/cognitive/architect.md
   - Resource validation with @claude/agents/orchestration/project-manager.md
   - Risk assessment completion

2. **Plan Documentation**
   - Generate selected format output
   - Create communication materials
   - Update memory with finalized plan

## Integration Points
- **Architecture**: @claude/commands/core/analyze.md for technical feasibility
- **Resources**: @claude/agents/orchestration/project-manager.md for capacity planning
- **Execution**: @claude/commands/orchestration/coordinate.md for implementation
- **Tracking**: @claude/memory/sessions/current-session.md for progress monitoring

## Success Criteria
- [ ] Clear objectives with measurable outcomes defined
- [ ] Realistic timeline with buffer for uncertainties
- [ ] Resource allocation aligned with capacity
- [ ] Dependencies and risks identified and mitigated
- [ ] Stakeholder buy-in and alignment achieved
- [ ] Plan documented and accessible in memory

## Memory & Context Usage
- **Strategic Context**: @claude/memory/knowledge/strategic-initiatives.md
- **Project History**: @claude/memory/context/project-overview.md#planning-history
- **Team Capacity**: @claude/memory/context/team-metrics.md
- **Planning Templates**: @claude/config/templates/planning-templates.md

## Advanced Features

### Multi-Project Planning
```
@claude/commands/core/plan.md --scope=portfolio --horizon=medium --format=gantt
```
Coordinates planning across multiple projects with resource optimization.

### Technical Debt Planning
```
@claude/commands/core/plan.md --scope=technical-debt --priority=risk --horizon=medium
```
Specialized planning for addressing accumulated technical debt with risk-based prioritization.

### Adaptive Planning
Integrates with @claude/patterns/operational/continuous-improvement.md for iterative plan refinement based on:
- Velocity trends from completed sprints
- Market changes and competitive analysis
- Technical discoveries and constraints
- Stakeholder feedback loops

## Error Handling
- **Capacity Conflicts**: Automatic rebalancing suggestions
- **Dependency Issues**: Critical path analysis and alternatives
- **Timeline Risks**: Buffer calculation and contingency planning
- **Resource Constraints**: Priority-based scope adjustment