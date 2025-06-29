# Generate Command

## Purpose
Advanced code and content generation command for creating components, templates, configurations, and automated content based on specifications and patterns.

## Specialist Integration
- **Primary**: @specialists/technical/backend-dev.md
- **Supporting**: @specialists/technical/frontend-dev.md, @specialists/cognitive/architect.md

## Command Syntax
```
@commands/specialized/generate.md [--target] [--template] [--framework] [--customization]
```

## Parameters
- `--target`: Generation target (code, configuration, documentation, tests, data, scaffolding)
- `--template`: Template type (component, service, boilerplate, pattern, custom)
- `--framework`: Framework context (react, vue, node, python, kubernetes, terraform)
- `--customization`: Customization level (basic, advanced, intelligent, adaptive)

## Usage Examples

### Component Generation
```
@commands/specialized/generate.md --target=code --template=component --framework=react --customization=advanced
```
**Activates**: @specialists/technical/frontend-dev.md for React component generation
**Tools**: @shared/mcp-integration/magic.md for intelligent code generation
**Patterns**: @patterns/development/component-patterns.md, @patterns/development/frontend-patterns.md

### API Service Generation
```
@commands/specialized/generate.md --target=code --template=service --framework=node --specialist=@specialists/technical/backend-dev.md
```
**Activates**: @specialists/technical/backend-dev.md for API service scaffolding
**Tools**: @shared/mcp-integration/sequential.md for multi-file generation workflows
**Patterns**: @patterns/development/api-patterns.md, @patterns/architectural/microservices.md

### Infrastructure Configuration Generation
```
@commands/specialized/generate.md --target=configuration --template=boilerplate --framework=kubernetes --customization=intelligent
```
**Activates**: @specialists/technical/devops.md, @specialists/cognitive/architect.md
**Tools**: @shared/mcp-integration/magic.md for infrastructure-as-code generation
**Patterns**: @patterns/operational/infrastructure-patterns.md, @patterns/architectural/cloud-patterns.md

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
- **Building**: Generated code integrated with @commands/core/build.md workflows
- **Testing**: Generated tests executed via @commands/core/test.md
- **Validation**: Generated code validated through @commands/core/validate.md
- **Documentation**: Generated docs processed by @commands/specialized/document.md

## Success Criteria
- [ ] Generated code meets functional requirements
- [ ] Code quality and standards compliance achieved
- [ ] Framework conventions properly followed
- [ ] Integration tests pass successfully
- [ ] Documentation and examples generated
- [ ] Performance and security requirements met

## Memory & Context Usage
- **Generation Templates**: @memory/generation/template-library.md
- **Generation History**: @memory/generation/generation-log.md
- **Pattern Catalog**: @memory/generation/pattern-definitions.md
- **Session Notes**: @memory/sessions/current-session.md#generation-log

## Error Handling & Fallbacks
- Template issues → @specialists/cognitive/architect.md for pattern guidance
- Framework conflicts → Framework-specific specialist consultation
- Quality failures → @commands/core/validate.md for detailed analysis
- Integration problems → @specialists/technical/backend-dev.md for resolution

## Advanced Features
- **AI-Powered Generation**: Machine learning-enhanced code generation
- **Adaptive Templates**: Self-improving generation patterns
- **Multi-Framework Support**: Cross-platform code generation
- **Incremental Generation**: Partial updates and modifications