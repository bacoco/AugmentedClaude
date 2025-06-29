# Design Command

## Purpose
Comprehensive design and planning command for creating architectural blueprints, UI/UX designs, and system specifications before implementation.

## Specialist Integration
- **Primary**: @claude/agents/cognitive/architect.md
- **Supporting**: @claude/agents/domain/ux-designer.md, @claude/agents/technical/frontend-dev.md

## Command Syntax
```
@claude/commands/core/design.md [--type] [--level] [--format] [--specialist]
```

## Parameters
- `--type`: Design type (system-architecture, ui-design, database-schema, api-design, user-flow)
- `--level`: Design level (conceptual, logical, physical)
- `--format`: Output format (diagrams, wireframes, specifications, prototypes)
- `--specialist`: Override default specialist selection

## Usage Examples

### System Architecture Design
```
@claude/commands/core/design.md --type=system-architecture --level=logical --format=diagrams
```
**Activates**: @claude/agents/cognitive/architect.md for architectural patterns
**Tools**: @claude/integrations/magic.md for diagram generation
**Patterns**: @claude/patterns/architectural/microservices.md, @claude/patterns/architectural/event-driven.md

### UI/UX Design
```
@claude/commands/core/design.md --type=ui-design --format=wireframes --specialist=@claude/agents/domain/ux-designer.md
```
**Activates**: @claude/agents/domain/ux-designer.md for user experience design
**Tools**: @claude/integrations/sequential.md for user flow mapping
**Patterns**: @claude/patterns/development/frontend-patterns.md, @claude/patterns/ux/design-systems.md

### Database Schema Design
```
@claude/commands/core/design.md --type=database-schema --level=physical --format=specifications
```
**Activates**: @claude/agents/technical/backend-dev.md, @claude/agents/cognitive/architect.md
**Patterns**: @claude/patterns/architectural/data-patterns.md
**Memory**: @claude/memory/context/technical-stack.md#database

## Execution Workflow

### Phase 1: Requirements & Analysis
1. **Requirement Gathering**
   - Analyze project requirements and constraints
   - Identify stakeholders and user needs
   - Define functional and non-functional requirements

2. **Constraint Analysis**
   - Technical limitations and capabilities
   - Budget and timeline considerations
   - Compliance and security requirements

### Phase 2: Design Development
1. **Conceptual Design**
   - High-level architecture and components
   - User journey and interaction flows
   - Technology stack decisions

2. **Detailed Design**
   - Component specifications and interfaces
   - Data models and relationships
   - Integration patterns and protocols

### Phase 3: Validation & Refinement
1. **Design Review**
   - Peer review by relevant specialists
   - Pattern compliance verification
   - Scalability and performance assessment

2. **Prototype Development**
   - Create proof-of-concept implementations
   - Validate design assumptions
   - Gather feedback and iterate

## Integration Points
- **Planning**: Design feeds into @claude/commands/core/plan.md for execution strategy
- **Building**: Designs guide @claude/commands/core/build.md implementation
- **Documentation**: Design specs stored via @claude/commands/specialized/document.md
- **Validation**: Design validation through @claude/commands/core/validate.md

## Success Criteria
- [ ] Requirements fully captured and addressed
- [ ] Design patterns properly applied
- [ ] Scalability and performance considered
- [ ] Security and compliance requirements met
- [ ] Stakeholder approval obtained
- [ ] Implementation blueprint complete

## Memory & Context Usage
- **Design History**: @claude/memory/designs/design-decisions.md
- **Requirements**: @claude/memory/context/project-requirements.md
- **Patterns**: @claude/memory/knowledge/design-patterns.md
- **Session Notes**: @claude/memory/sessions/current-session.md#design-notes

## Error Handling & Fallbacks
- Incomplete requirements → @claude/agents/cognitive/analyst.md for gap analysis
- Design conflicts → @claude/agents/cognitive/architect.md for resolution
- Technical feasibility → @claude/agents/technical/* consultation
- User experience issues → @claude/agents/domain/ux-designer.md review

## Advanced Features
- **Collaborative Design**: Multi-specialist design sessions
- **Version Control**: Design evolution tracking
- **Impact Analysis**: Change impact assessment
- **Pattern Libraries**: Reusable design components