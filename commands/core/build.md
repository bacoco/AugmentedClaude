# Build Command

## Purpose
Comprehensive development and construction command for implementing features, components, and systems.

## Specialist Integration
- **Primary**: Domain-specific technical specialists
- **Supporting**: @specialists/cognitive/architect.md, @specialists/technical/qa-tester.md

## Command Syntax
```
@commands/core/build.md [--target] [--stack] [--pattern] [--specialist]
```

## Parameters
- `--target`: What to build (api, frontend, component, database, infrastructure)
- `--stack`: Technology stack (react, node, python, kubernetes)
- `--pattern`: Architecture pattern to follow
- `--specialist`: Override default specialist selection

## Usage Examples

### Frontend Development
```
@commands/core/build.md --target=frontend --stack=react --specialist=@specialists/technical/frontend-dev.md
```
**Activates**: Component development, state management, UI implementation
**Tools**: @shared/mcp-integration/magic.md for component generation
**Patterns**: @patterns/development/frontend-patterns.md

### Backend API Development
```
@commands/core/build.md --target=api --stack=node --pattern=microservices
```
**Activates**: @specialists/technical/backend-dev.md
**Tools**: @shared/mcp-integration/sequential.md for complex logic
**Patterns**: @patterns/architectural/microservices.md, @patterns/development/api-patterns.md

### Database Implementation
```
@commands/core/build.md --target=database --pattern=event-sourcing
```
**Activates**: @specialists/technical/backend-dev.md
**Patterns**: @patterns/architectural/data-patterns.md
**Memory**: @memory/context/technical-stack.md#database

## Execution Workflow

### Phase 1: Planning & Design
1. **Specialist Activation**
   - Auto-select based on target and stack
   - Load relevant patterns and context
   - Initialize memory tracking

2. **Architecture Review**
   - Reference: @specialists/cognitive/architect.md for design validation
   - Pattern compliance check
   - Performance and scalability considerations

### Phase 2: Implementation
1. **Code Generation**
   - Use appropriate MCP tools for scaffolding
   - Follow established patterns and conventions
   - Implement with best practices

2. **Quality Integration**
   - Unit test generation and execution
   - Code quality checks and linting
   - Security considerations integration

### Phase 3: Validation
1. **Testing**
   - Execute: @commands/core/test.md --unit --integration
   - Performance validation
   - Security validation

2. **Review**
   - Code review by relevant specialists
   - Architecture compliance verification
   - Documentation generation

## Integration Points
- **Testing**: Automatic @commands/core/test.md execution
- **Security**: @specialists/technical/security.md review for sensitive components
- **Documentation**: @commands/specialized/document.md for API/component docs
- **Deployment**: Integration with @commands/core/deploy.md workflow

## Success Criteria
- [ ] Implementation matches specifications
- [ ] Code quality meets standards (linting, complexity)
- [ ] Test coverage >= 80%
- [ ] Security review passed (if required)
- [ ] Performance requirements met
- [ ] Documentation generated

## Memory & Context Usage
- **Project Context**: @memory/context/project-overview.md
- **Technical Stack**: @memory/context/technical-stack.md
- **Build History**: @memory/sessions/current-session.md#build-log
- **Patterns**: @patterns/development/* (context-specific)

## Error Handling & Fallbacks
- Build failures → @commands/core/troubleshoot.md
- Pattern violations → @specialists/cognitive/architect.md review
- Security issues → @specialists/technical/security.md consultation
- Performance issues → @specialists/cognitive/analyzer.md optimization

## Advanced Features
- **Parallel Building**: Multiple components simultaneously
- **Incremental Builds**: Only changed components
- **Pattern Enforcement**: Automatic pattern compliance checking
- **Quality Gates**: Automatic quality validation and blocking
