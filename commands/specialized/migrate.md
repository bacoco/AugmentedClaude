# Migrate Command

## Purpose
Comprehensive migration and transformation command for moving systems, data, and applications between platforms, frameworks, and architectures.

## Specialist Integration
- **Primary**: @specialists/technical/backend-dev.md
- **Supporting**: @specialists/cognitive/architect.md, @specialists/technical/devops.md

## Command Syntax
```
@commands/specialized/migrate.md [--source] [--target] [--strategy] [--scope]
```

## Parameters
- `--source`: Source platform (legacy-system, framework, database, cloud-provider, architecture)
- `--target`: Target platform (modern-framework, new-database, cloud-native, microservices)
- `--strategy`: Migration strategy (big-bang, phased, strangler-fig, parallel-run, hybrid)
- `--scope`: Migration scope (data, application, infrastructure, full-system)

## Usage Examples

### Legacy System Migration
```
@commands/specialized/migrate.md --source=legacy-system --target=microservices --strategy=strangler-fig --scope=full-system
```
**Activates**: @specialists/cognitive/architect.md for migration architecture planning
**Tools**: @shared/mcp-integration/sequential.md for complex migration orchestration
**Patterns**: @patterns/architectural/migration-patterns.md, @patterns/architectural/microservices.md

### Database Migration
```
@commands/specialized/migrate.md --source=mysql --target=postgresql --strategy=parallel-run --scope=data
```
**Activates**: @specialists/technical/backend-dev.md for database migration
**Tools**: @shared/mcp-integration/magic.md for data transformation and validation
**Patterns**: @patterns/architectural/data-patterns.md, @patterns/operational/migration-patterns.md

### Cloud Platform Migration
```
@commands/specialized/migrate.md --source=on-premise --target=cloud-native --strategy=phased --specialist=@specialists/technical/devops.md
```
**Activates**: @specialists/technical/devops.md for infrastructure migration
**Tools**: @shared/mcp-integration/sequential.md for infrastructure transformation
**Patterns**: @patterns/architectural/cloud-patterns.md, @patterns/operational/deployment-patterns.md

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
- **Planning**: Migration planning through @commands/core/plan.md workflows
- **Testing**: Migration validation via @commands/core/test.md comprehensive testing
- **Monitoring**: Migration progress tracking through @commands/core/monitor.md
- **Documentation**: Migration documentation via @commands/specialized/document.md

## Success Criteria
- [ ] All systems successfully migrated
- [ ] Data integrity and consistency maintained
- [ ] Performance requirements met or exceeded
- [ ] Minimal downtime achieved
- [ ] Rollback procedures tested and available
- [ ] Documentation and training completed

## Memory & Context Usage
- **Migration Plans**: @memory/migration/migration-strategies.md
- **Dependency Maps**: @memory/migration/system-dependencies.md
- **Progress Tracking**: @memory/migration/migration-progress.md
- **Session Notes**: @memory/sessions/current-session.md#migration-log

## Error Handling & Fallbacks
- Migration failures → @specialists/technical/backend-dev.md for troubleshooting
- Data corruption → @specialists/technical/backend-dev.md for data recovery strategies
- Performance issues → @specialists/cognitive/analyzer.md for optimization
- Architecture conflicts → @specialists/cognitive/architect.md for resolution

## Advanced Features
- **Zero-Downtime Migration**: Live migration techniques with minimal service interruption
- **Automated Rollback**: Intelligent rollback mechanisms for failed migrations
- **Progressive Migration**: Gradual user traffic shifting and validation
- **Multi-Cloud Migration**: Cross-cloud platform migration support