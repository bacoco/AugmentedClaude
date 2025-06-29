# Design Command (Specialized)

## Purpose
Advanced creative and technical design command for specialized design workflows including UI/UX, visual identity, system architecture, and user experience optimization.

## Specialist Integration
- **Primary**: @claude/agents/domain/ux-designer.md
- **Supporting**: @claude/agents/cognitive/architect.md, @claude/agents/technical/frontend-dev.md

## Command Syntax
```
@claude/commands/specialized/design.md [--discipline] [--methodology] [--deliverable] [--iteration]
```

## Parameters
- `--discipline`: Design discipline (ux-design, visual-design, interaction-design, service-design, system-design)
- `--methodology`: Design methodology (design-thinking, lean-ux, atomic-design, design-systems, user-centered)
- `--deliverable`: Output deliverable (wireframes, prototypes, design-system, user-journey, style-guide)
- `--iteration`: Iteration approach (rapid-prototyping, iterative, agile, continuous)

## Usage Examples

### User Experience Design
```
@claude/commands/specialized/design.md --discipline=ux-design --methodology=design-thinking --deliverable=user-journey
```
**Activates**: @claude/agents/domain/ux-designer.md for comprehensive UX workflow
**Tools**: @claude/integrations/magic.md for user research and journey mapping
**Patterns**: @claude/patterns/ux/user-experience.md, @claude/patterns/ux/design-thinking.md

### Design System Creation
```
@claude/commands/specialized/design.md --discipline=visual-design --methodology=atomic-design --deliverable=design-system
```
**Activates**: @claude/agents/domain/ux-designer.md, @claude/agents/technical/frontend-dev.md
**Tools**: @claude/integrations/sequential.md for component library generation
**Patterns**: @claude/patterns/ux/design-systems.md, @claude/patterns/development/component-patterns.md

### Interaction Design Prototyping
```
@claude/commands/specialized/design.md --discipline=interaction-design --iteration=rapid-prototyping --deliverable=prototypes
```
**Activates**: @claude/agents/domain/ux-designer.md for interactive prototype development
**Tools**: @claude/integrations/magic.md for prototype generation and testing
**Patterns**: @claude/patterns/ux/interaction-design.md, @claude/patterns/ux/prototyping.md

## Execution Workflow

### Phase 1: Design Research
1. **User Research**
   - Conduct user interviews and surveys
   - Analyze user behavior and pain points
   - Create user personas and scenarios

2. **Market Analysis**
   - Research design trends and best practices
   - Analyze competitor designs and patterns
   - Identify opportunities and constraints

### Phase 2: Concept Development
1. **Ideation & Sketching**
   - Generate design concepts and ideas
   - Create low-fidelity sketches and wireframes
   - Explore different design directions

2. **Information Architecture**
   - Define content structure and hierarchy
   - Create site maps and user flows
   - Design navigation and interaction patterns

### Phase 3: Design Development
1. **Visual Design**
   - Develop visual language and style guides
   - Create high-fidelity mockups and designs
   - Design component libraries and systems

2. **Interaction Design**
   - Design micro-interactions and animations
   - Create interactive prototypes
   - Define responsive design behaviors

### Phase 4: Testing & Iteration
1. **Usability Testing**
   - Conduct user testing sessions
   - Gather feedback and insights
   - Identify usability issues and improvements

2. **Design Refinement**
   - Iterate based on testing feedback
   - Refine visual and interaction design
   - Optimize for accessibility and performance

## Integration Points
- **Development**: Design handoff to @claude/commands/core/build.md workflows
- **Research**: User research via @claude/commands/specialized/research.md insights
- **Analysis**: Design performance through @claude/commands/specialized/analyze.md metrics
- **Documentation**: Design documentation via @claude/commands/specialized/document.md

## Success Criteria
- [ ] User needs and requirements addressed
- [ ] Design consistency and coherence achieved
- [ ] Accessibility standards met
- [ ] Usability testing passed successfully
- [ ] Design system documentation complete
- [ ] Development handoff materials prepared

## Memory & Context Usage
- **Design History**: @claude/memory/design/design-evolution.md
- **User Research**: @claude/memory/design/user-research-findings.md
- **Design Patterns**: @claude/memory/design/reusable-patterns.md
- **Session Notes**: @claude/memory/sessions/current-session.md#design-log

## Error Handling & Fallbacks
- User feedback conflicts → @claude/agents/domain/ux-designer.md for resolution strategies
- Technical constraints → @claude/agents/technical/frontend-dev.md for feasibility assessment
- Accessibility issues → @claude/agents/domain/ux-designer.md for inclusive design review
- Performance concerns → @claude/agents/cognitive/analyzer.md for optimization guidance

## Advanced Features
- **AI-Assisted Design**: Machine learning-powered design suggestions
- **Collaborative Design**: Multi-stakeholder design workshops and sessions
- **Data-Driven Design**: Analytics-informed design decisions
- **Cross-Platform Design**: Consistent design across multiple platforms and devices