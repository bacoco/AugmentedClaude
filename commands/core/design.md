# Design Command

## Purpose
Comprehensive design and planning command for creating architectural blueprints, UI/UX designs, and system specifications before implementation.

## Specialist Integration
- **Primary**: @specialists/cognitive/architect.md
- **Supporting**: @specialists/domain/ux-designer.md, @specialists/technical/frontend-dev.md

## Command Syntax
```
@commands/core/design.md [--type] [--level] [--format] [--specialist]
```

## Parameters
- `--type`: Design type (system-architecture, ui-design, database-schema, api-design, user-flow)
- `--level`: Design level (conceptual, logical, physical)
- `--format`: Output format (diagrams, wireframes, specifications, prototypes)
- `--specialist`: Override default specialist selection

## Usage Examples

### System Architecture Design
```
@commands/core/design.md --type=system-architecture --level=logical --format=diagrams
```
**Activates**: @specialists/cognitive/architect.md for architectural patterns
**Tools**: @shared/mcp-integration/magic.md for diagram generation
**Patterns**: @patterns/architectural/microservices.md, @patterns/architectural/event-driven.md

### UI/UX Design
```
@commands/core/design.md --type=ui-design --format=wireframes --specialist=@specialists/domain/ux-designer.md
```
**Activates**: @specialists/domain/ux-designer.md for user experience design
**Tools**: @shared/mcp-integration/sequential.md for user flow mapping
**Patterns**: @patterns/development/frontend-patterns.md, @patterns/ux/design-systems.md

### Database Schema Design
```
@commands/core/design.md --type=database-schema --level=physical --format=specifications
```
**Activates**: @specialists/technical/backend-dev.md, @specialists/cognitive/architect.md
**Patterns**: @patterns/architectural/data-patterns.md
**Memory**: @memory/context/technical-stack.md#database

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
- **Planning**: Design feeds into @commands/core/plan.md for execution strategy
- **Building**: Designs guide @commands/core/build.md implementation
- **Documentation**: Design specs stored via @commands/specialized/document.md
- **Validation**: Design validation through @commands/core/validate.md

## Success Criteria
- [ ] Requirements fully captured and addressed
- [ ] Design patterns properly applied
- [ ] Scalability and performance considered
- [ ] Security and compliance requirements met
- [ ] Stakeholder approval obtained
- [ ] Implementation blueprint complete

## Memory & Context Usage
- **Design History**: @memory/designs/design-decisions.md
- **Requirements**: @memory/context/project-requirements.md
- **Patterns**: @memory/knowledge/design-patterns.md
- **Session Notes**: @memory/sessions/current-session.md#design-notes

## Error Handling & Fallbacks
- Incomplete requirements → @specialists/cognitive/analyst.md for gap analysis
- Design conflicts → @specialists/cognitive/architect.md for resolution
- Technical feasibility → @specialists/technical/* consultation
- User experience issues → @specialists/domain/ux-designer.md review

## Advanced Features
- **Collaborative Design**: Multi-specialist design sessions
- **Version Control**: Design evolution tracking
- **Impact Analysis**: Change impact assessment
- **Pattern Libraries**: Reusable design components