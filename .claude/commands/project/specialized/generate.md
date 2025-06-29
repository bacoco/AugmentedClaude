# Generate Command

## Purpose
Advanced code and content generation command for creating components, templates, configurations, and automated content based on specifications and patterns.

## Specialist Integration
- **Primary**: @claude/agents/technical/backend-dev.md
- **Supporting**: @claude/agents/technical/frontend-dev.md, @claude/agents/cognitive/architect.md

## Command Syntax
```
@claude/commands/specialized/generate.md [--target] [--template] [--framework] [--customization]
```

## Parameters
- `--target`: Generation target (code, configuration, documentation, tests, data, scaffolding)
- `--template`: Template type (component, service, boilerplate, pattern, custom)
- `--framework`: Framework context (react, vue, node, python, kubernetes, terraform)
- `--customization`: Customization level (basic, advanced, intelligent, adaptive)

## Usage Examples

### Component Generation
```
@claude/commands/specialized/generate.md --target=code --template=component --framework=react --customization=advanced
```
**Activates**: @claude/agents/technical/frontend-dev.md for React component generation
**Tools**: @claude/integrations/magic.md for intelligent code generation
**Patterns**: @claude/patterns/development/component-patterns.md, @claude/patterns/development/frontend-patterns.md

### API Service Generation
```
@claude/commands/specialized/generate.md --target=code --template=service --framework=node --specialist=@claude/agents/technical/backend-dev.md
```
**Activates**: @claude/agents/technical/backend-dev.md for API service scaffolding
**Tools**: @claude/integrations/sequential.md for multi-file generation workflows
**Patterns**: @claude/patterns/development/api-patterns.md, @claude/patterns/architectural/microservices.md

### Infrastructure Configuration Generation
```
@claude/commands/specialized/generate.md --target=configuration --template=boilerplate --framework=kubernetes --customization=intelligent
```
**Activates**: @claude/agents/technical/devops.md, @claude/agents/cognitive/architect.md
**Tools**: @claude/integrations/magic.md for infrastructure-as-code generation
**Patterns**: @claude/patterns/operational/infrastructure-patterns.md, @claude/patterns/architectural/cloud-patterns.md

## Execution Workflow

### Phase 1: Specification Analysis
1. **Requirement Processing**
   - Analyze generation requirements and constraints
   - Extract key parameters and configurations
   - Identify target patterns and frameworks

2. **Template Selection**
   - Choose appropriate generation templates
   - Customize templates based on requirements
   - Validate template compatibility and dependencies

### Phase 2: Generation Planning
1. **Architecture Design**
   - Plan generated component structure
   - Define interfaces and dependencies
   - Establish naming conventions and patterns

2. **Code Strategy**
   - Select appropriate design patterns
   - Plan error handling and validation
   - Design testing and documentation strategies

### Phase 3: Content Generation
1. **Core Generation**
   - Generate primary code and configuration files
   - Apply framework-specific patterns and conventions
   - Implement business logic and functionality

2. **Supporting Assets**
   - Generate tests, documentation, and examples
   - Create configuration and deployment files
   - Generate helper utilities and tools

### Phase 4: Validation & Integration
1. **Quality Assurance**
   - Validate generated code syntax and logic
   - Run automated tests and quality checks
   - Verify compliance with standards and patterns

2. **Integration Testing**
   - Test integration with existing systems
   - Validate API contracts and interfaces
   - Ensure performance and security requirements

## Integration Points
- **Building**: Generated code integrated with @claude/commands/core/build.md workflows
- **Testing**: Generated tests executed via @claude/commands/core/test.md
- **Validation**: Generated code validated through @claude/commands/core/validate.md
- **Documentation**: Generated docs processed by @claude/commands/specialized/document.md

## Success Criteria
- [ ] Generated code meets functional requirements
- [ ] Code quality and standards compliance achieved
- [ ] Framework conventions properly followed
- [ ] Integration tests pass successfully
- [ ] Documentation and examples generated
- [ ] Performance and security requirements met

## Memory & Context Usage
- **Generation Templates**: @claude/memory/generation/template-library.md
- **Generation History**: @claude/memory/generation/generation-log.md
- **Pattern Catalog**: @claude/memory/generation/pattern-definitions.md
- **Session Notes**: @claude/memory/sessions/current-session.md#generation-log

## Error Handling & Fallbacks
- Template issues → @claude/agents/cognitive/architect.md for pattern guidance
- Framework conflicts → Framework-specific specialist consultation
- Quality failures → @claude/commands/core/validate.md for detailed analysis
- Integration problems → @claude/agents/technical/backend-dev.md for resolution

## Advanced Features
- **AI-Powered Generation**: Machine learning-enhanced code generation
- **Adaptive Templates**: Self-improving generation patterns
- **Multi-Framework Support**: Cross-platform code generation
- **Incremental Generation**: Partial updates and modifications