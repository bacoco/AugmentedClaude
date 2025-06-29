# Test Command

## Purpose
Comprehensive testing command covering unit, integration, end-to-end, performance, and security testing.

## Specialist Integration
- **Primary**: @claude/agents/technical/qa-tester.md
- **Supporting**: Domain-specific specialists for specialized testing

## Command Syntax
```
@claude/commands/core/test.md [--type] [--scope] [--coverage] [--environment]
```

## Parameters
- `--type`: Test type (unit, integration, e2e, performance, security, accessibility)
- `--scope`: Test scope (component, feature, system, regression)
- `--coverage`: Coverage requirements (basic, standard, comprehensive)
- `--environment`: Target environment (local, staging, production)

## Usage Examples

### Unit Testing
```
@claude/commands/core/test.md --type=unit --scope=component --coverage=comprehensive
```
**Activates**: @claude/agents/technical/qa-tester.md + component specialist
**Tools**: Framework-specific testing tools
**Patterns**: @claude/patterns/development/testing-patterns.md#unit-testing

### End-to-End Testing
```
@claude/commands/core/test.md --type=e2e --scope=feature --environment=staging
```
**Activates**: @claude/agents/technical/qa-tester.md
**Tools**: @claude/integrations/puppeteer.md for browser automation
**Patterns**: @claude/patterns/development/testing-patterns.md#e2e-testing

### Security Testing
```
@claude/commands/core/test.md --type=security --scope=system --specialist=@claude/agents/technical/security.md
```
**Activates**: @claude/agents/technical/security.md + @claude/agents/technical/qa-tester.md
**Tools**: @claude/integrations/sequential.md for complex security scenarios
**Patterns**: @claude/patterns/operational/security-testing.md

## Execution Workflow

### Phase 1: Test Planning
1. **Test Strategy Definition**
   - Analyze requirements and acceptance criteria
   - Select appropriate testing types and approaches
   - Define success criteria and coverage targets

2. **Test Environment Setup**
   - Prepare test data and environments
   - Configure testing tools and frameworks
   - Establish baseline metrics

### Phase 2: Test Development
1. **Test Case Creation**
   - Write test cases based on requirements
   - Implement automated test scripts
   - Create test data and mock services

2. **Test Infrastructure**
   - Set up CI/CD integration
   - Configure test reporting and analytics
   - Implement test monitoring and alerting

### Phase 3: Test Execution
1. **Automated Testing**
   - Execute test suites across different levels
   - Collect metrics and performance data
   - Generate detailed test reports

2. **Manual Testing**
   - Exploratory testing for edge cases
   - Usability and accessibility testing
   - User acceptance testing coordination

### Phase 4: Results Analysis
1. **Coverage Analysis**
   - Analyze test coverage metrics
   - Identify untested code paths
   - Recommend coverage improvements

2. **Defect Analysis**
   - Categorize and prioritize defects
   - Root cause analysis for failures
   - Integration with @claude/workflows/development/bug-resolution.md

## Test Types

### Unit Testing
- **Focus**: Individual components and functions
- **Specialists**: Component developers + @claude/agents/technical/qa-tester.md
- **Tools**: Jest, pytest, JUnit (framework-specific)
- **Patterns**: @claude/patterns/development/testing-patterns.md#unit-testing

### Integration Testing
- **Focus**: Component interactions and API contracts
- **Specialists**: @claude/agents/technical/qa-tester.md, @claude/agents/technical/backend-dev.md
- **Tools**: @claude/integrations/sequential.md for complex integration scenarios
- **Patterns**: @claude/patterns/development/testing-patterns.md#integration-testing

### End-to-End Testing
- **Focus**: Complete user workflows and scenarios
- **Specialists**: @claude/agents/technical/qa-tester.md, @claude/agents/domain/ux-designer.md
- **Tools**: @claude/integrations/puppeteer.md for browser automation
- **Patterns**: @claude/patterns/development/testing-patterns.md#e2e-testing

### Performance Testing
- **Focus**: System performance under load
- **Specialists**: @claude/agents/cognitive/analyzer.md, @claude/agents/technical/qa-tester.md
- **Tools**: Load testing tools, performance monitoring
- **Patterns**: @claude/patterns/development/performance-patterns.md#performance-testing

### Security Testing
- **Focus**: Security vulnerabilities and compliance
- **Specialists**: @claude/agents/technical/security.md
- **Tools**: Security testing tools, vulnerability scanners
- **Patterns**: @claude/patterns/operational/security-testing.md

### Accessibility Testing
- **Focus**: WCAG compliance and inclusive design
- **Specialists**: @claude/agents/technical/frontend-dev.md, @claude/agents/domain/ux-designer.md
- **Tools**: @claude/integrations/puppeteer.md for automated accessibility testing
- **Patterns**: @claude/patterns/development/accessibility-patterns.md

## Integration Points
- **Bug Resolution**: Failed tests trigger @claude/workflows/development/bug-resolution.md
- **Performance Issues**: Performance test failures escalate to @claude/commands/specialized/optimize.md
- **Security Issues**: Security test failures escalate to @claude/commands/specialized/secure.md
- **Documentation**: Test results documented via @claude/commands/specialized/document.md

## Success Criteria
- [ ] All test types executed successfully
- [ ] Coverage targets met (80%+ for unit tests)
- [ ] Performance benchmarks satisfied
- [ ] Security tests passed with no critical vulnerabilities
- [ ] Accessibility compliance verified
- [ ] Defects properly categorized and tracked

## Memory & Context Usage
- **Test History**: @claude/memory/knowledge/test-patterns.md
- **Quality Standards**: @claude/memory/context/quality-standards.md
- **Test Results**: @claude/memory/sessions/current-session.md#test-results
- **Known Issues**: @claude/memory/knowledge/anti-patterns.md#testing-antipatterns

## Error Handling & Escalation
- Test failures → @claude/workflows/development/bug-resolution.md
- Performance issues → @claude/agents/cognitive/analyzer.md + @claude/commands/specialized/optimize.md
- Security failures → @claude/agents/technical/security.md immediate review
- Infrastructure issues → @claude/agents/technical/devops.md support
