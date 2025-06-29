# Migrate Command

## Purpose
Comprehensive migration and transformation command for moving systems, data, and applications between platforms, frameworks, and architectures.

## Specialist Integration
- **Primary**: @claude/agents/technical/backend-dev.md
- **Supporting**: @claude/agents/cognitive/architect.md, @claude/agents/technical/devops.md

## Command Syntax
```
@claude/commands/specialized/migrate.md [--source] [--target] [--strategy] [--scope]
```

## Parameters
- `--source`: Source platform (legacy-system, framework, database, cloud-provider, architecture)
- `--target`: Target platform (modern-framework, new-database, cloud-native, microservices)
- `--strategy`: Migration strategy (big-bang, phased, strangler-fig, parallel-run, hybrid)
- `--scope`: Migration scope (data, application, infrastructure, full-system)

## Usage Examples

### Legacy System Migration
```
@claude/commands/specialized/migrate.md --source=legacy-system --target=microservices --strategy=strangler-fig --scope=full-system
```
**Activates**: @claude/agents/cognitive/architect.md for migration architecture planning
**Tools**: @claude/integrations/sequential.md for complex migration orchestration
**Patterns**: @claude/patterns/architectural/migration-patterns.md, @claude/patterns/architectural/microservices.md

### Database Migration
```
@claude/commands/specialized/migrate.md --source=mysql --target=postgresql --strategy=parallel-run --scope=data
```
**Activates**: @claude/agents/technical/backend-dev.md for database migration
**Tools**: @claude/integrations/magic.md for data transformation and validation
**Patterns**: @claude/patterns/architectural/data-patterns.md, @claude/patterns/operational/migration-patterns.md

### Cloud Platform Migration
```
@claude/commands/specialized/migrate.md --source=on-premise --target=cloud-native --strategy=phased --specialist=@claude/agents/technical/devops.md
```
**Activates**: @claude/agents/technical/devops.md for infrastructure migration
**Tools**: @claude/integrations/sequential.md for infrastructure transformation
**Patterns**: @claude/patterns/architectural/cloud-patterns.md, @claude/patterns/operational/deployment-patterns.md

## Execution Workflow

### Phase 1: Migration Assessment
1. **Current State Analysis**
   - Analyze existing systems and dependencies
   - Identify migration challenges and risks
   - Assess technical debt and compatibility issues

2. **Target State Planning**
   - Define target architecture and requirements
   - Plan migration strategy and approach
   - Estimate effort, timeline, and resources

### Phase 2: Migration Preparation
1. **Environment Setup**
   - Prepare target environments and infrastructure
   - Set up migration tools and processes
   - Establish testing and validation frameworks

2. **Data Analysis**
   - Analyze data structures and relationships
   - Plan data transformation and mapping
   - Identify data quality and integrity issues

### Phase 3: Migration Execution
1. **Incremental Migration**
   - Execute migration in planned phases
   - Migrate data, applications, and services
   - Validate each migration step

2. **System Integration**
   - Integrate migrated components
   - Test cross-system functionality
   - Verify performance and reliability

### Phase 4: Validation & Cutover
1. **Comprehensive Testing**
   - Execute end-to-end testing scenarios
   - Validate business functionality
   - Perform load and stress testing

2. **Production Cutover**
   - Plan and execute production switch
   - Monitor system performance and stability
   - Implement rollback procedures if needed

## Integration Points
- **Planning**: Migration planning through @claude/commands/core/plan.md workflows
- **Testing**: Migration validation via @claude/commands/core/test.md comprehensive testing
- **Monitoring**: Migration progress tracking through @claude/commands/core/monitor.md
- **Documentation**: Migration documentation via @claude/commands/specialized/document.md

## Success Criteria
- [ ] All systems successfully migrated
- [ ] Data integrity and consistency maintained
- [ ] Performance requirements met or exceeded
- [ ] Minimal downtime achieved
- [ ] Rollback procedures tested and available
- [ ] Documentation and training completed

## Memory & Context Usage
- **Migration Plans**: @claude/memory/migration/migration-strategies.md
- **Dependency Maps**: @claude/memory/migration/system-dependencies.md
- **Progress Tracking**: @claude/memory/migration/migration-progress.md
- **Session Notes**: @claude/memory/sessions/current-session.md#migration-log

## Error Handling & Fallbacks
- Migration failures → @claude/agents/technical/backend-dev.md for troubleshooting
- Data corruption → @claude/agents/technical/backend-dev.md for data recovery strategies
- Performance issues → @claude/agents/cognitive/analyzer.md for optimization
- Architecture conflicts → @claude/agents/cognitive/architect.md for resolution

## Advanced Features
- **Zero-Downtime Migration**: Live migration techniques with minimal service interruption
- **Automated Rollback**: Intelligent rollback mechanisms for failed migrations
- **Progressive Migration**: Gradual user traffic shifting and validation
- **Multi-Cloud Migration**: Cross-cloud platform migration support