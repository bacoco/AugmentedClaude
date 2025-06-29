# Setup Command

## Purpose
Comprehensive environment initialization and configuration command for establishing development environments, infrastructure, and project scaffolding.

## Specialist Integration
- **Primary**: @specialists/technical/devops.md
- **Supporting**: @specialists/cognitive/architect.md, @specialists/technical/backend-dev.md

## Command Syntax
```
@commands/core/setup.md [--environment] [--stack] [--scope] [--automation]
```

## Parameters
- `--environment`: Target environment (development, staging, production, testing)
- `--stack`: Technology stack (full-stack, frontend, backend, mobile, infrastructure)
- `--scope`: Setup scope (project, workspace, infrastructure, toolchain)
- `--automation`: Automation level (manual, semi-automated, fully-automated)

## Usage Examples

### Development Environment Setup
```
@commands/core/setup.md --environment=development --stack=full-stack --scope=workspace
```
**Activates**: @specialists/technical/devops.md for environment configuration
**Tools**: @shared/mcp-integration/magic.md for automated tool installation
**Patterns**: @patterns/operational/environment-setup.md, @patterns/development/workspace-patterns.md

### Production Infrastructure Setup
```
@commands/core/setup.md --environment=production --scope=infrastructure --automation=fully-automated
```
**Activates**: @specialists/technical/devops.md, @specialists/cognitive/architect.md
**Tools**: @shared/mcp-integration/sequential.md for infrastructure provisioning
**Patterns**: @patterns/architectural/cloud-patterns.md, @patterns/operational/deployment-patterns.md

### Project Scaffolding Setup
```
@commands/core/setup.md --stack=frontend --scope=project --specialist=@specialists/technical/frontend-dev.md
```
**Activates**: @specialists/technical/frontend-dev.md for project structure
**Tools**: @shared/mcp-integration/magic.md for code generation and templates
**Patterns**: @patterns/development/project-structure.md, @patterns/development/frontend-patterns.md

## Execution Workflow

### Phase 1: Environment Analysis
1. **Requirement Assessment**
   - Analyze project requirements and dependencies
   - Identify target platforms and constraints
   - Assess existing infrastructure and tools

2. **Configuration Planning**
   - Design environment architecture
   - Plan tool and service integration
   - Establish security and compliance requirements

### Phase 2: Infrastructure Provisioning
1. **Base Infrastructure**
   - Provision compute, storage, and network resources
   - Configure security groups and access controls
   - Set up monitoring and logging infrastructure

2. **Platform Services**
   - Deploy databases, message queues, and caches
   - Configure container orchestration platforms
   - Set up CI/CD pipelines and automation tools

### Phase 3: Development Environment
1. **Workspace Configuration**
   - Install development tools and dependencies
   - Configure IDEs and development environments
   - Set up version control and collaboration tools

2. **Project Initialization**
   - Create project structure and scaffolding
   - Configure build tools and package management
   - Set up testing frameworks and quality tools

### Phase 4: Validation & Documentation
1. **Environment Testing**
   - Verify all components and services
   - Test connectivity and integration points
   - Validate security and performance configurations

2. **Documentation & Handoff**
   - Generate setup documentation and runbooks
   - Create onboarding guides and tutorials
   - Establish maintenance and update procedures

## Integration Points
- **Planning**: Setup requirements from @commands/core/plan.md execution
- **Building**: Environment ready for @commands/core/build.md workflows
- **Testing**: Test infrastructure via @commands/core/test.md validation
- **Monitoring**: Environment monitoring through @commands/core/monitor.md

## Success Criteria
- [ ] All required tools and services installed
- [ ] Environment configurations validated
- [ ] Security and compliance requirements met
- [ ] Development workflow operational
- [ ] Documentation and guides complete
- [ ] Team onboarding processes established

## Memory & Context Usage
- **Setup History**: @memory/operations/setup-configurations.md
- **Environment Specs**: @memory/context/environment-specifications.md
- **Tool Inventory**: @memory/operations/installed-tools.md
- **Session Notes**: @memory/sessions/current-session.md#setup-log

## Error Handling & Fallbacks
- Installation failures → @specialists/technical/devops.md for troubleshooting
- Configuration conflicts → @specialists/cognitive/architect.md for resolution
- Security issues → @specialists/technical/security.md consultation
- Performance problems → @specialists/cognitive/analyzer.md optimization

## Advanced Features
- **Environment Templates**: Reusable configuration patterns
- **Automated Provisioning**: Infrastructure-as-Code deployment
- **Environment Cloning**: Exact environment replication
- **Progressive Setup**: Staged environment rollout