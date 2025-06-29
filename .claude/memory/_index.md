# Memory System Index

## Overview
The AugmentedClaude memory system provides persistent storage and retrieval of project knowledge, enabling continuous learning and context awareness across all operations. The system is designed to capture, organize, and leverage information throughout the software development lifecycle.

## Memory Architecture

### Three-Tier Memory Structure

```
memory/
├── context/          # Project-specific information
├── knowledge/        # Accumulated wisdom and patterns
└── sessions/         # Active session tracking
```

### Memory Categories

| Category | Purpose | Persistence | Update Frequency |
|----------|---------|-------------|------------------|
| **Context** | Project state and configuration | Long-term | As needed |
| **Knowledge** | Best practices and learnings | Permanent | Continuous |
| **Sessions** | Current activities and progress | Session-based | Real-time |

## Context Memory

### Overview
Context memory stores project-specific information that remains relevant throughout the project lifecycle. This includes technical architecture, business requirements, and environmental configurations.

### File Structure

#### project-overview.md
**Purpose**: Central repository of project information including goals, milestones, team structure, and success metrics  
**Schema**:
- Project metadata (name, description, status, dates)
- Goals and objectives with success criteria
- Team structure with roles and responsibilities
- Milestones with dependencies and deliverables
- Success metrics with baselines and targets

**Integration Points**: project-manager, product-manager, strategist, scrum-master

**Update Triggers**:
- Project initiation
- Major scope changes
- Architecture decisions
- Phase transitions

#### technical-stack.md
**Purpose**: Comprehensive technical stack documentation including technologies, versions, architecture decisions, and migration history  
**Schema**:
- Technology categories (frontend, backend, database, infrastructure, tools)
- Architecture decisions (ADRs) with rationale and alternatives
- Version control and dependency management
- Migration history and rollback plans
- Integration matrix showing system connections

**Integration Points**: architect, backend-dev, frontend-dev, devops, system-integrator

**Access Patterns**:
- Read by all commands during initialization
- Updated by architect during design phase
- Referenced during build and deployment
- Validated during review processes

### Context Memory Best Practices

1. **Keep It Current**: Update immediately when decisions change
2. **Version Control**: Track all modifications with clear rationale
3. **Cross-Reference**: Link to relevant documentation and code
4. **Validate Regularly**: Ensure accuracy during reviews
5. **Archive Old Versions**: Maintain history for reference

## Knowledge Memory

### Overview
Knowledge memory captures lessons learned, best practices, and patterns discovered during development. This information transcends individual projects and builds organizational wisdom.

### File Structure

#### best-practices.md
**Purpose**: Repository of validated best practices with implementation patterns and success metrics  
**Schema**:
- Best practice entries with categories and maturity levels
- Benefits with measurable improvements
- Implementation steps and complexity estimates
- Code examples showing before/after
- Evidence and metrics supporting the practice
- Adoption tracking and evolution history

**Integration Points**: architect, tech-writer, qa-tester, backend-dev, frontend-dev, devops, security

#### anti-patterns.md
**Purpose**: Comprehensive catalog of identified anti-patterns with detection criteria and resolution strategies  
**Schema**:
- Anti-pattern entries with severity and status tracking
- Symptoms and root causes analysis
- Automated detection rules and tools
- Impact assessment across multiple dimensions
- Resolution strategies with effort estimates
- Monitoring rules and prevention techniques
- Relationship mapping between anti-patterns

**Integration Points**: architect, qa-tester, security, analyzer, reviewer

#### lessons-learned.md
**Purpose**: Experiential knowledge repository capturing insights from project activities, incidents, and decisions  
**Schema**:
- Lesson entries with context and categorization
- Situation analysis with root causes
- Outcomes with positive/negative results
- Recommendations and prevention strategies
- Applicability scope and validation
- Impact tracking across implementations

**Integration Points**: project-manager, scrum-master, architect, qa-tester, all-specialists

### Knowledge Memory Management

**Knowledge Growth Cycle**:
1. **Capture**: Document immediately after learning
2. **Validate**: Peer review and testing
3. **Generalize**: Extract universal principles
4. **Share**: Propagate across teams
5. **Refine**: Update based on new experiences

**Knowledge Quality Metrics**:
- Applicability: How often is it referenced?
- Accuracy: Does it still hold true?
- Impact: What improvements resulted?
- Clarity: Is it easily understood?

## Sessions Memory

### Overview
Sessions memory tracks active work, maintaining state across command executions and specialist interactions. This enables continuity and progress tracking.

### File Structure

#### current-session.md
**Purpose**: Real-time state of the current working session including active tasks, decisions, and specialist coordination  
**Schema**:
- Session metadata with status and environment info
- Active specialists tracking with resource usage
- Task tracking with dependencies and artifacts
- Decision log with approval workflow
- Temporary data store with expiration
- Communication log between specialists
- Performance metrics and resource monitoring

**Integration Points**: all-specialists, orchestrator, project-manager

**Update Patterns**:
- Real-time updates during execution
- Checkpoint saves every 5 minutes
- Final summary on session close
- Archived after 24 hours of inactivity

### Session Memory Lifecycle

1. **Initialization**:
   - Create new session file
   - Load project context
   - Set initial state

2. **Active Updates**:
   - Track command execution
   - Log specialist activities
   - Record decisions and findings

3. **Checkpointing**:
   - Regular state saves
   - Progress snapshots
   - Recovery points

4. **Closure**:
   - Generate summary
   - Extract lessons learned
   - Archive to history

## Memory Access Patterns

### Read Patterns

**Initialization Read**:
```
1. Load project-overview.md
2. Load technical-stack.md
3. Check for active session
4. Load relevant knowledge files
```

**Command Execution Read**:
```
1. Check current session state
2. Load command-specific knowledge
3. Reference best practices
4. Check for relevant anti-patterns
```

**Specialist Activation Read**:
```
1. Load specialist context
2. Check previous decisions
3. Reference domain knowledge
4. Review session history
```

### Write Patterns

**Incremental Updates**:
- Append to session log
- Update task status
- Record command results
- Log decisions made

**Batch Updates**:
- End-of-phase summaries
- Knowledge consolidation
- Pattern extraction
- Lesson documentation

**Atomic Writes**:
- Critical state changes
- Configuration updates
- Error recovery points
- Checkpoint saves

## Memory Management Best Practices

### Storage Guidelines

1. **Structure Consistency**:
   - Follow defined schemas
   - Use consistent formatting
   - Maintain clear hierarchies
   - Version all changes

2. **Content Quality**:
   - Write for future readers
   - Include context and rationale
   - Provide concrete examples
   - Update outdated information

3. **Access Efficiency**:
   - Index key information
   - Use clear file names
   - Implement search tags
   - Cross-reference related content

### Maintenance Procedures

**Daily Maintenance**:
- Archive completed sessions
- Update current session
- Validate context accuracy

**Weekly Maintenance**:
- Consolidate lessons learned
- Update best practices
- Review and clean anti-patterns
- Generate knowledge reports

**Monthly Maintenance**:
- Full memory audit
- Pattern extraction
- Knowledge base optimization
- Archive old projects

### Memory Optimization

**Performance Considerations**:
- Keep files under 100KB
- Use lazy loading for large datasets
- Implement caching for frequent reads
- Compress archived sessions

**Search Optimization**:
- Maintain keyword index
- Tag important concepts
- Create cross-references
- Build relationship maps

## Integration with AugmentedClaude System

### Command Integration
Every command interacts with memory:
- **Pre-execution**: Load relevant context
- **During execution**: Update session state
- **Post-execution**: Save results and learnings

### Specialist Integration
Specialists leverage memory for:
- **Context awareness**: Understanding project state
- **Decision making**: Referencing best practices
- **Knowledge sharing**: Contributing learnings
- **Progress tracking**: Maintaining continuity

### Workflow Integration
Workflows orchestrate memory usage:
- **Initialization**: Load workflow-specific memory
- **Phase transitions**: Checkpoint state
- **Completion**: Archive deliverables
- **Post-mortem**: Extract lessons

## Memory System Evolution

### Continuous Improvement

**Feedback Loops**:
- Usage analytics
- Access patterns
- Content effectiveness
- User satisfaction

**Enhancement Areas**:
- AI-powered insights
- Predictive knowledge retrieval
- Automated pattern recognition
- Smart archival strategies

### Future Capabilities

**Planned Features**:
- Semantic search across all memory
- Auto-generated knowledge graphs
- Predictive context loading
- Cross-project learning synthesis

This memory system serves as the cognitive foundation of AugmentedClaude, enabling intelligent, context-aware operations that improve with every interaction.